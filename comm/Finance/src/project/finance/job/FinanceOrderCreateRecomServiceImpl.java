package project.finance.job;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.collections.CollectionUtils;

import kernel.util.Arith;
import kernel.util.DateUtils;
import kernel.util.StringUtils;
import kernel.web.Page;
import project.Constants;
import project.finance.FinanceOrder;
import project.finance.FinanceOrderService;
import project.log.MoneyLog;
import project.log.MoneyLogService;
import project.party.PartyService;
import project.party.model.Party;
import project.party.model.UserRecom;
import project.party.recom.UserRecomService;
import project.syspara.SysparaService;
import project.wallet.Wallet;
import project.wallet.WalletService;

public class FinanceOrderCreateRecomServiceImpl implements FinanceOrderCreateRecomService {

	protected FinanceOrderService financeOrderService;
	protected SysparaService sysparaService;
	protected UserRecomService userRecomService;
	protected PartyService partyService;
	protected WalletService walletService;
	protected MoneyLogService moneyLogService;
	/**
	 * 计算推荐人收益
	 */
	protected Map<String, Double> cacheRecomProfit = new ConcurrentHashMap<String, Double>();

	/**
	 * 计算前一日购买产品的订单
	 */
	public void computeRecom() {
		String finance_buy_bonus_parameters = sysparaService.find("finance_buy_bonus_parameters").getValue();
		if (StringUtils.isEmptyString(finance_buy_bonus_parameters)) {
			return;
		}
		cacheRecomProfit.clear();
		int pageSize = 1000;
		int pageNo = 1;
		String date = DateUtils.getDateStr(DateUtils.addDate(new Date(), -1));
		while (true) {
			Page page = financeOrderService.pagedQueryByDate(pageNo, pageSize, date);
			List<FinanceOrder> list = (List<FinanceOrder>) page.getElements();
			if (list.isEmpty()) {
				break;
			}
			for (FinanceOrder order : list) {
				handleCacheRecom(order, finance_buy_bonus_parameters);
			}
			pageNo++;
		}
		saveRecomProfit();
	}

	/**
	 * 购买推荐奖励
	 * 
	 * @param entity
	 */
	public void handleCacheRecom(FinanceOrder entity, String finance_buy_bonus_parameters) {
		List<UserRecom> list_parents = this.userRecomService.getParents(entity.getPartyId());

		if (CollectionUtils.isNotEmpty(list_parents)) {
			String[] finance_buy_bonus_array = finance_buy_bonus_parameters.split(",");
			int loop = 0;
			int loopMax = finance_buy_bonus_array.length;
			for (int i = 0; i < list_parents.size(); i++) {
				if (loop >= loopMax) {
					break;
				}
				Party party_parent = this.partyService.cachePartyBy(list_parents.get(i).getReco_id(), true);
				if (!Constants.SECURITY_ROLE_MEMBER.equals(party_parent.getRolename())) {
					continue;
				}
				loop++;
				double pip_amount = Double.valueOf(finance_buy_bonus_array[loop - 1]);
				double get_money = Arith.mul(entity.getAmount(), pip_amount);

				if (cacheRecomProfit.containsKey(party_parent.getId().toString())) {
					cacheRecomProfit.put(party_parent.getId().toString(),
							Arith.add(cacheRecomProfit.get(party_parent.getId().toString()), get_money));
				} else {
					cacheRecomProfit.put(party_parent.getId().toString(), get_money);
				}
			}

		}
	}

	public void saveRecomProfit() {
		System.out.println("===========================================================");
		if (cacheRecomProfit.isEmpty()) {
			return;
		}
		for (Entry<String, Double> entry : cacheRecomProfit.entrySet()) {
			Wallet wallet_parent = walletService.saveWalletByPartyId(entry.getKey());
			double amount_before_parent = wallet_parent.getMoney();
			walletService.update(wallet_parent.getPartyId().toString(), entry.getValue());
			/**
			 * 保存资金日志
			 */
			MoneyLog moneyLog = new MoneyLog();
			moneyLog.setCategory(Constants.MONEYLOG_CATEGORY_FINANCE);
			moneyLog.setAmount_before(amount_before_parent);
			moneyLog.setAmount(entry.getValue());
			moneyLog.setAmount_after(Arith.add(amount_before_parent, entry.getValue()));
			moneyLog.setLog("下级购买理财佣金奖励");
			moneyLog.setPartyId(entry.getKey());
			moneyLog.setWallettype(Constants.WALLET);
			moneyLog.setContent_type(Constants.MONEYLOG_CONTENT_FINANCE_RECOM_PROFIT);
			moneyLogService.save(moneyLog);
		}
	}

	public void setFinanceOrderService(FinanceOrderService financeOrderService) {
		this.financeOrderService = financeOrderService;
	}

	public void setSysparaService(SysparaService sysparaService) {
		this.sysparaService = sysparaService;
	}

	public void setUserRecomService(UserRecomService userRecomService) {
		this.userRecomService = userRecomService;
	}

	public void setPartyService(PartyService partyService) {
		this.partyService = partyService;
	}

	public void setWalletService(WalletService walletService) {
		this.walletService = walletService;
	}

	public void setMoneyLogService(MoneyLogService moneyLogService) {
		this.moneyLogService = moneyLogService;
	}

	public void setCacheRecomProfit(Map<String, Double> cacheRecomProfit) {
		this.cacheRecomProfit = cacheRecomProfit;
	}

}
