function MessageTimer(){
  let myTime = new Date();
  let myHours = myTime.getHours();
  let myMinutes = myTime.getMinutes();
  let mySeconds = myTime.getSeconds();

  let strTime = myHours+":"+myMinutes+":"+mySeconds;

  let myMessage = document.getElementById("Message");

  let ListMessage = new Array(
    { time:"9:0:0" ,message:"出勤時間です"},
    { time:"12:0:0" ,message:"お昼休みです。45分間休憩しましょう。休憩中の賃金は発生しません"},
    { time:"19:25:0" ,
    message:"勤務時間終了です。残業を希望する方は上司に連絡してください。残業に入る前に15分間の休憩を取ってください。休憩中の賃金は発生しません。"}
  );

  for(var i=0; i < ListMessage.length; i++){
    if( strTime == ListMessage[i]["time"] ){
      myMessage.innerHTML = ListMessage[i]["message"];
      setTimeout(function(){myMessage.innerHTML="";}, 45 * 60 * 1000);
    };
  };
  return 0;
}
setInterval(MessageTimer, 1000);