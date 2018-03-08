<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
   		<table	id="messagetab" width="860" border="0" style="">
     			<tr style="background:#edf8fd;">
     				<td width="43">序号</td>
				    <td width="106">消息接收人</td>
				    <td width="150">消息类型</td>
				    <td width="150">通知种类</td>
				    <td width="150">时间类型</td>
				    <td width="127">开始时间</td>
				    <td width="127">结束时间</td>
				 </tr>
     			<tbody>
     				<s:if test="#request.SmsreceiveruleColumnslist == null || #request.SmsreceiveruleColumnslist.size() == 0">
     				<tr>
     				<td>1</td>
     				<td><input name="smsperson" id="smsperson" value="" style="width:100px;height:24px;"/></td>
					<td>    
						<select id="mnkcode" name="mnkcode" style="width:100px;height:24px;">
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getMessagenoticekind()">
                            <option value="<s:property value='#bean.mnkMnkcode'/>">
                            <s:property value="#bean.mnkMnkname"/>
                            </option>
                          </s:iterator>
                   	 </select>	 
                    </td>
				    <td>
				    <select id="snkcode" name="snkcode" style="width:100px;height:24px;">
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticekind()">
                            <option value="<s:property value='#bean.snkSnkcode'/>">
                            <s:property value="#bean.snkSnkname"/>
                            </option>
                          </s:iterator>
                       
                    </select>
				    </td>
				    <td><select id="snott" name="snott" style="width:100px;height:24px;">
        
                          <option value="" selected="selected" >---请选择---</option>
                          <s:iterator var="bean" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticetimetype()">
                            <option value="<s:property value='#bean.snttSnttcode'/>">
                            <s:property value="#bean.snttSnttname"/>
                            </option>
                          </s:iterator>
                         </select>
					</td>
				    <td>  <input name="startdate" type="text" value="" src="${pageContext.request.contextPath}/images/time.png" style="width:127px;height:22px;" 
               	 			class="Wdate"	id="startdate" onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"/>
          			</td>
				    <td> <input name="enddate" type="text" value="" src="${pageContext.request.contextPath}/images/time.png" style=" width:127px;height:22px;" 
             			  	class="Wdate" id="enddate"  onfocus="WdatePicker({startDate:'%y-%M-01 00:00:00',dateFmt:'yyyy-MM-dd HH:mm:ss',alwaysUseStartDate:true})"	/>
                	</td>
				    </tr>
     				</s:if>
     				
     				
     				
     				<s:else>
     				<s:iterator var="bean" value="#request.SmsreceiveruleColumnslist" status="index">
     				<s:set var="#index.index" value="varIndex"></s:set>
     				<tr >
     				<td><s:property value="#index.index+1"/></td>
     				<td><input name="" id="" value="<s:property value="#bean.srOpename"/>" style="width:100px;height:24px;"/></td>
					<td> 
		               <select id="mnkcode" name="mnkcode" style="width:100px;height:24px;">
                        <s:else>
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getMessagenoticekind()">
                            <s:if test="(#bean1.mnkMnkcode).equals(#bean.mnkcode)">
                              <option  value="<s:property value='#bean1.mnkMnkcode'/>" selected="selected">
                              <s:property value="#bean1.mnkMnkname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.mnkMnkcode'/>">
                              <s:property value="#bean1.mnkMnkname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                        </s:else>
                    </select>	 
	                </td>
	                
				    <td>
				    	<select id="snkcode" name="snkcode" style="width:100px;height:24px;">
                        
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.CorewaybillstatusKindDemand@getSmsnoticekind()">
                            <s:if test="(#bean1.snkSnkcode).equals(#bean.snkcode)">
                              <option  value="<s:property value='#bean1.snkSnkcode'/>" selected="selected">
                              <s:property value="#bean1.snkSnkname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.snkSnkcode'/>">
                              <s:property value="#bean1.snkSnkname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                       
                    </select>	 
				    </td>
				    
				    
				    <td>
				    <select id="snott" name="snott" style="width:100px;height:24px;">
                          <option value="" >---请选择---</option>
                          <s:iterator var="bean1" value="@com.daiyun.dax.SmsnoticetimeKindDemand@getSmsnoticetimetype()">
                            <s:if test="(#bean1.snttSnttname).equals(#bean.snott)">
                              <option  value="<s:property value='#bean1.snttSnttcode'/>" selected="selected">
                              <s:property value="#bean1.snttSnttname"/>
                              </option>
                            </s:if>
                            <s:else>
                              <option  value="<s:property value='#bean1.snttSnttcode'/>">
                              <s:property value="#bean1.snttSnttname"/>
                              </option>
                            </s:else>
                          </s:iterator>
                    
                    </select>	
				   
					</td>
				    <td><s:property value="#bean.snttSnttstarttime"/></td>
				    <td><s:property value="#bean.snttSnttendtime"/></td>
     				</tr>
     				</s:iterator>
     			</s:else>
     			</tbody>
     		
     		</table> 
