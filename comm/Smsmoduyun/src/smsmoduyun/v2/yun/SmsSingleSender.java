package smsmoduyun.v2.yun;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.util.List;

//import org.json.JSONObject;


public class SmsSingleSender {
//	String accesskey;
//	String secretkey;
	// 同时支持http和https两种协议，具体根据自己实际情况使用。
	String url = "https://live.mordula.com/sms/v2/sendsinglesms";
	// String url =
	// "http://2p8773516g.qicp.vip:16416/live.kewail.com/sms/v2/sendsinglesms";

	SmsSenderUtil util = new SmsSenderUtil();
//
//	public SmsSingleSender(String accesskey, String secretkey) throws Exception {
//		this.accesskey = accesskey;
//		this.secretkey = secretkey;
//	}

	/**
	 * 指定签名和模板单发短信接口
	 * 
	 * @param type        短信类型，0 为普通短信，1 营销短信
//	 * @param nationCode  国家码，如 86 为中国
	 * @param phoneNumber 不带国家码的手机号
	 * @param signId      短信签名的Id
	 * @param templateId  短信模板Id
	 * @param params      ,短信的变量参数值 ，将短信模板中的变量{0},{1}替换为参数中的值，如果短信模板中没有变量，这这个值填null
	 * @param ext         服务端原样返回的参数，可填空
	 * @return {@link}SmsSingleSenderResult
	 * @throws Exception
	 */
	public SmsSingleSenderResult send(int type, String nationcode, String phoneNumber, String signId, String templateId,
			List<String> params, String ext, String accesskey, String secretkey) throws Exception {

		if (null == ext) {
			ext = "";
		}

		// 按照协议组织 post 请求包体
		long random = util.getRandom();
		long curTime = System.currentTimeMillis() / 1000;

//		JSONObject data = new JSONObject();
//
//		JSONObject tel = new JSONObject();
//		tel.put("nationcode", nationcode);
//		tel.put("mobile", phoneNumber);
//
//		data.put("signId", signId);
//		data.put("templateId", templateId);
//		data.put("type", type);
//		if (params != null && params.size() > 0) {
//			data.put("params", util.smsParamsToJSONArray(params));
//		}
//
//		data.put("sig", util.strToHash(
//				String.format("secretkey=%s&random=%d&time=%d&mobile=%s", secretkey, random, curTime, phoneNumber)));
//		data.put("tel", tel);
//		data.put("time", curTime);
//		data.put("ext", ext);
//
//		// 与上面的 random 必须一致
//		String wholeUrl = String.format("%s?accesskey=%s&random=%d", url, accesskey, random);
//		HttpURLConnection conn = util.getPostHttpConn(wholeUrl);
//
//		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream(), "utf-8");
////		System.out.println(data.toString());
//		wr.write(data.toString());
//		wr.flush();
//
////		System.out.println(data.toString());
//
//		// 显示 POST 请求返回的内容
//		StringBuilder sb = new StringBuilder();
//		int httpRspCode = conn.getResponseCode();
//		SmsSingleSenderResult result;
//		if (httpRspCode == HttpURLConnection.HTTP_OK) {
//			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
//			String line = null;
//			while ((line = br.readLine()) != null) {
//				sb.append(line);
//			}
//			br.close();
////			System.out.println(sb.toString());
//			JSONObject json = new JSONObject(sb.toString());
//			result = util.jsonToSmsSingleSenderResult(json);
//		} else {
//			result = new SmsSingleSenderResult();
//			result.result = httpRspCode;
//			result.errMsg = "http error " + httpRspCode + " " + conn.getResponseMessage();
//		}

		return null;
	}

}
