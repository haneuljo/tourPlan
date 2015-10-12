/**
 * 
 */
/*	json key값 있는지 판단*/
function keyFind(obj, key){
	var chk=false;
	for (var j in obj) {
		if (!obj.hasOwnProperty(key)){
			chk=true;
			break;
		}
	}
	return chk;
				
}