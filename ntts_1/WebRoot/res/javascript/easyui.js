
/*************************** easyui-datagrid的toolbar方法 ***********************/
var datagridEditingIndexArray = new Array();

function getEditingIndex(datagridID) {
	return datagridEditingIndexArray[datagridID];
	//return $('#'+datagridID).data('editingIndex_'+datagridID);
}
function setEditingIndex(datagridID, editingIndex) {
	datagridEditingIndexArray[datagridID] = editingIndex;
	//$('#'+datagridID).data('editingIndex_'+datagridID, editingIndex)
}

function endEditing(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	if (editingIndex == undefined){return true}
	
	var datagridObj = $("#"+datagridID);
	if (datagridObj.datagrid('validateRow', editingIndex)){
		datagridObj.datagrid('endEdit', editingIndex);

		setEditingIndex(datagridID, undefined);
		return true;
	} else {
		return false;
	}
}

function onClickRow(datagridID, index){
	var editingIndex = getEditingIndex(datagridID);
	
	var datagridObj = $("#"+datagridID);
	if (editingIndex != index){
		if (endEditing(datagridID)){
			datagridObj.datagrid('selectRow', index).datagrid('beginEdit', index);

			setEditingIndex(datagridID, index);
		} else {
			datagridObj.datagrid('selectRow', editingIndex);
		}
	}
}

function append(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	if (endEditing(datagridID)){
		var datagridObj = $("#"+datagridID);
		datagridObj.datagrid('appendRow',{});

		editingIndex = datagridObj.datagrid('getRows').length-1;
		setEditingIndex(datagridID, editingIndex);
		datagridObj.datagrid('selectRow', editingIndex).datagrid('beginEdit', editingIndex);
	}
}

function removeit(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	if (editingIndex == undefined){return}

	var datagridObj = $("#"+datagridID);
	datagridObj.datagrid('cancelEdit', editingIndex).datagrid('deleteRow', editingIndex);

	accept(datagridID);
	setEditingIndex(datagridID, undefined);
}

function accept(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	if (endEditing(datagridID)){
		var datagridObj = $("#"+datagridID);
		datagridObj.datagrid('acceptChanges');
	}
}

function reject(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	var datagridObj = $("#"+datagridID);
	datagridObj.datagrid('rejectChanges');

	setEditingIndex(datagridID, undefined);
}

function getChanges(datagridID){
	var editingIndex = getEditingIndex(datagridID);
	
	var datagridObj = $("#"+datagridID);
	var rows = datagridObj.datagrid('getChanges');
	alert(rows.length+' 行被修改!');
}



