package kernel.dao;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.util.Assert;


public abstract class SQLUtils {
    
    /**
     * 去除hql的select 子句，未考虑union的情况,用于pagedQuery.
     *
     * @see #pagedQuery(String,int,int,Object[])
     */
    public static String removeSelect(String hql) {
        Assert.hasText(hql);
        int beginPos = hql.toLowerCase().indexOf("from");
        Assert.isTrue(beginPos != -1, " hql : " + hql + " must has a keyword 'from'");
        return hql.substring(beginPos);
    }

    /**
     * 去除hql的orderby 子句，用于pagedQuery.
     *
     * @see #pagedQuery(String,int,int,Object[])
     */
    public static String removeOrders(String hql) {
        Assert.hasText(hql);
        Pattern p = Pattern.compile("order\\s*by[\\w|\\W|\\s|\\S]*", Pattern.CASE_INSENSITIVE);
        Matcher m = p.matcher(hql);
        StringBuffer sb = new StringBuffer();
        while (m.find()) {
            m.appendReplacement(sb, "");
        }
        m.appendTail(sb);
        return sb.toString();
    }
}
