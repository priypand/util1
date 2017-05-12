/*file:loginPage.html validate the credentials of the user*/

function myFunction() 
{	
	var pswd =document.getElementById("pswd").value;	
	var emailid =document.getElementById("emailid").value;
	if(pswd =='' || emailid=="")
	{	
		document.getElementById("case").style.display= 'inline';
		var post = document.getElementById("failedlogin");
		post.style.display = 'inline'; // to show error message
	}
	else
	{	
		var otp=document.getElementById("otp").innerHTML;
		if(pswd==otp)
		{ 
			document.contents.submit();
		}
		else	
		{	
			document.getElementById("case").style.display= 'inline';
			var post = document.getElementById("failedlogin");
			post.style.display = 'inline'; // to show error message
			return false;
		}		
   	}
}

/*common to all... timer at the footer*/
function startTime() 
{
    var today = new Date();
    var monthNames = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	var h = today.getHours();
	var m = today.getMinutes();
	var s = today.getSeconds();
	m = checkTime(m);
	s = checkTime(s);
	document.getElementById('date').innerHTML =today.getDate()+"/"+monthNames[today.getMonth()]+"/"+today.getFullYear()+" "+h + ":" + m + ":" + s+"      ";
	var t = setTimeout(startTime, 500);
}

function checkTime(i) 
{
    if (i < 10) {i = "0" + i};  // add zero in front of numbers < 10
    return i;
}


/*file: PreparePPT.jsp... function to move to next Page...CreatePresentation*/
function movenext1()
{
	
	var emailid = document.getElementById("loggedin").innerHTML;
	var selectedsector = document.getElementById("sector").value;
    var selectedpal = document.getElementById("palname").value;
  
    if(selectedsector=="Sector" || selectedpal=="PAL NOTES ID")
    	{
    		alert("Select at least Sector and Pal Name");
    	}
    else
	window.location.href = "CreatePresentation.jsp";
}

/*file:UploadExtract.jsp and PreparePPT.jsp... help button pop-up*/
function popup()
{
  cuteLittleWindow = window.open("popup.html", "littleWindow", "location=no,width=550,height=400");
}
function popup1()
{
  cuteLittleWindow = window.open("help2.html", "littleWindow", "location=no,width=550,height=400");
}

function sendRep()
{
	var emailid = document.getElementById("loggedin").innerHTML;
	var recemailid = document.getElementById("recemailid").value;
	window.location.href = "SendReport.jsp?"+"&recemailid="+recemailid+"&emailid="+emailid;
}


function changeselect(id)
{
	var selectedsectorindex = document.getElementById(id).selectedIndex;
    var selectedsector = document.getElementsByTagName("option")[selectedsectorindex].text;
    if(selectedsector.includes("&"))
    	{
    		selectedsector= selectedsector.replace("&","and");	
    	}
    window.location.href = "showpalname.jsp?"+"&selectedsector="+selectedsector;
}

function changepal(palid,class1) 
{
	var selectedpal = document.getElementById(palid).value;
	var selectedsectorindex = document.getElementById("sector").selectedIndex;
    var selectedsector = document.getElementsByTagName("option")[selectedsectorindex].text;	
    var emailid = document.getElementById("loggedin").innerHTML;
    if(selectedsector.includes("&"))
	{
		selectedsector= selectedsector.replace("&","and");
	}
    window.location.href = "showindustry.jsp?"+"&selectedpal="+selectedpal;
}

function changeindus(indusid)
{
	var selectedsector = document.getElementById("sector").value; 
	if(selectedsector.includes("&"))
	{
		selectedsector= selectedsector.replace("&","and");
	}
    var selectedpal = document.getElementById("palname").value;
	var selectedindus1 = document.getElementById(indusid).value;
	if(selectedindus1.includes("&"))
	{
		selectedindus1= selectedindus1.replace("&","and");
	}
    var emailid = document.getElementById("loggedin").innerHTML; 
	window.location.href = "showproject.jsp?"+"&selectedindus1="+selectedindus1;
}


var rating ="";
function show(id)
{
	
	 rating = document.getElementById(id).value;
	alert("Thanks for giving us "+rating+" stars... Your opinion is valuable...");
	//alert(document.getElementById(id).value);
}

function feedback()
{
	
	if(rating=="")
	{
		alert("Your feedback is required... Please first rate us...");
		return false;
	}
	else {
		document.pptform.submit;
		return true;
	}
}