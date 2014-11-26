
    function filter( mode,keyword ) {
	if( keyword=='all'){
	 if( mode=='off'){
	   filter('off','Genomics') ; filter('off','Geoscience') ; filter('off','Teaching') ;
	  } else {
	   filter('on','Genomics') ; filter('on','Geoscience') ; filter('on','Teaching') ; filter('on','Teaching') ;	   
	  }
	} else {
   	 var items = document.getElementsByClassName( keyword ) ;
	 if( mode=='on'){
	  for( var i = 0 ; i < items.length ; i++ ) { items[i].style.display = 'none' ; }
	  var button_on = document.getElementById('filter_bottons_on').getElementsByClassName(keyword);
	  button_on[0].style.display = 'none' ;
	  var button_off = document.getElementById('filter_bottons_off').getElementsByClassName(keyword);
	  button_off[0].style.display = 'block' ;
	 } else {
	  for( var i = 0 ; i < items.length ; i++ ) { items[i].style.display = 'block' ; }
	  var button_on = document.getElementById('filter_bottons_on').getElementsByClassName(keyword);
	  button_on[0].style.display = 'block' ;
	  var button_off = document.getElementById('filter_bottons_off').getElementsByClassName(keyword);
	  button_off[0].style.display = 'none' ;
	 }//else
	}//else
	var are_all_filters_actived = document.getElementById('filter_bottons_off') ;
	var contador = 0 ;
	for( var i = 0 ; i < are_all_filters_actived.getElementsByTagName('li').length ; i++ )
	{
	 if( are_all_filters_actived.getElementsByTagName('li')[i].style.display == 'block' ){ contador++ ; }
	}
	if( contador > 0 )
	{
	 document.getElementById('showing_all_topics').style.display = 'none' ;
	 document.getElementById('hiding_all_topics').style.display = 'none' ; 
	 if( contador == are_all_filters_actived.getElementsByTagName('li').length-1 )
	 {
	  document.getElementById('showing_all_topics').style.display = 'none' ;
	  document.getElementById('hiding_all_topics').style.display = 'inline' ; 
	 }
    } else {
	 document.getElementById('showing_all_topics').style.display = 'inline' ;
	 document.getElementById('hiding_all_topics').style.display = 'none' ; 
	}
   }//function


   function showbibtex( bibtex ) {
    var box = bibtex.parentNode.childNodes ;
    if ( bibtex.id == 'show' ) {
	 box[1].style.display = 'none' ;
	 box[3].style.display = 'inline' ;
	 box[5].style.display = 'block' ;
	} else {
	 box[1].style.display = 'inline' ;
	 box[3].style.display = 'none' ;
	 box[5].style.display = 'none' ;
	}
   }