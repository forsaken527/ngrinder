<!DOCTYPE html>
<html>
<head>
	<title>nGrinder User List</title>
	<#include "../common/common.ftl">
	<#include "../common/datatables.ftl">
</head>

<body>
	<#include "../common/navigator.ftl">

	<div class="container">
		<div class="row">
			<#assign listPage = true>
			<#include "leftButton.ftl"/>

			<div class="span10">
				<div class="page-header pageHeader">
					<h3>User List</h3>
				</div>
				<div class="well form-inline searchBar">
					<input type="text" class="input-medium search-query span4"
						placeholder="Keywords" id="searchText" value="${keywords!}">
					<button type="submit" class="btn" id="search_user">Search</button>
					<span class="pull-right">
						<a class="btn" href="${req.getContextPath()}/user/detail" id="createBtn"  data-toggle="modal">
							<i class="icon-user"></i>
							Create User
						</a>
					
						<a href="javascript:deleteCheckedUsers()" class="btn btn-danger">
						<i class="icon-remove"></i>
						Delete selected Users
					</a> 
				</span>
					
				</div>
				<table class="table table-striped table-bordered ellipsis" id="userTable">
					<colgroup>
                        <col width="30">
                        <col width="150">
                        <col width="150">
                        <col>
                        <col width="130">
                        <col width="40">
                        <col width="40">
                    </colgroup>
					<thead>
						<tr>
							<th><input type="checkbox" class="checkbox" value=""></th>
							<th>User Name</th>
							<th>Create Date</th>
							<th class="noClick">Description</th>
							<th>Role</th>
							<th class="noClick">Edit</th>
							<th class="noClick">Del</th>
						</tr>
					</thead>
					<tbody>
						<#list userList as user>
						<tr>
							<td><input type="checkbox" id="user_info_check" <#if user.userId == "admin">disabled</#if> value="${user.userId}" /></td>
							<td class="left"><a
										href="${req.getContextPath()}/user/detail?userId=${user.userId}">${user.userName!}</a></td>
							<td>
								<#if user.createdDate?has_content>
									${user.createdDate?string("yyyy/MM/dd HH:mm:ss")}
								</#if>
								</td>
							<td class="left ellipsis">${user.description!}</td>
							<td class="left">${user.role}</td>
							<td><a
								href="${req.getContextPath()}/user/detail?userId=${user.userId}"><i
									class="icon-edit"></i></a></td>
							<td><a
								href="${req.getContextPath()}/user/delete?userIds=${user.userId}"><i
									class="icon-remove"></i></a></td>
						</tr>
						</#list>
					</tbody>
				</table>
			</div>
		</div>
		<#include "../common/copyright.ftl">
	</div>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#search_user").on('click', function() {
				document.location.href = "${req.getContextPath()}/user/list?keywords=" + $("#searchText").val() ;
			});
			
			enableChkboxSelectAll();
			
		    <#if userList?has_content>
			oTable = $("#userTable").dataTable({
				"bAutoWidth": false,
				"bFilter": false,
				"bLengthChange": false,
				"bInfo": false,
				"iDisplayLength": 15,
				"aaSorting": [[1, "asc"]],
				"bProcessing": true,
				"aoColumns": [{ "asSorting": []}, null, null, { "asSorting": []}, null, { "asSorting": []}, { "asSorting": []}],
				"sPaginationType": "bootstrap"
			});
			
			removeClick();
			</#if>
		});
	
		function deleteCheckedUsers() {
			var list = $("input[id='user_info_check']:checked");
			if(list.length == 0) {
				alert("Please select at least 1 user.");
				return;
			}
			var checkedUser = [];
			var $elem;
			list.each(function() {
				$elem = $(this);
				checkedUser.push($elem.val());
			});
			
			var ids = checkedUser.join(",");
			
			if (!confirm("Do you want to delete user: "+ ids +" ?")) {
				return;
			}
			
			document.location.href="${req.getContextPath()}/user/delete?userIds=" + ids;		
		}
	</script>
</body>
</html>