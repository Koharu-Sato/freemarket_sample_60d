$(function(){
    var setMainId = "#slider_main";
    var setThumbId = '#slider_thumb';
    var slideTime = 250;
    // var delayTime = 99999999999;

    $(setMainId).each(function(){
        var sliderWidth = $(this).width();
        var sliderHeight = $(this).height();

        var listWidth = parseInt($(this).children('ul').children('li').css('width'));
        var listCount = $(this).children('ul').children('li').length;

        var ulWidth = (listWidth)*(listCount);

        $(setMainId + ' ul').css({
            width: (ulWidth),
            height: (sliderHeight)
        });

        $(setThumbId + ' ul li:first').addClass('active');
        $(setThumbId + ' ul li').css({opacity:'0.7'});

        $(setThumbId + ' ul li').hover(function(){
            clearInterval(setTimer);
            $(this).stop().animate({opacity:'1'},300);
            var connectCont = $(setThumbId + ' ul li').index(this);
            $(setMainId + ' ul').stop().animate({left:(-(sliderWidth)*(connectCont))},slideTime);
            $(setThumbId + ' ul li').removeClass('active');
            $(this).addClass('active');
        },function(){
            $(this).stop().animate({opacity:'0.7'},300);
            timer();
        });

        timer();

        function timer() {
            setTimer = function(){
                $(setMainId + ' ul').each(function(){
                    var moveLeft = parseInt($(this).css('left'));
                    var listLengh = $(setThumbId + ' ul li').length;

                    var listWidth = parseInt($(setMainId + ' ul li').css('width'));
                    var moveLengh = -((listWidth)*((listLengh)-1));
                    
                    if(moveLeft == moveLengh){
                        $(setMainId + ' ul').stop().animate({left:'0'},slideTime);
                        $(setThumbId + ' ul li.active').each(function(){
                            $(this).removeClass('active');
                            $(setThumbId + ' ul li:first').addClass('active');
                        });
                    }else{
                        $(setMainId + ' ul').stop().animate({left:'-=' + (sliderWidth)},slideTime);
                        $(setThumbId + ' ul li.active').each(function(){
                            $(this).removeClass('active');
                            $(this).next().addClass('active');
                        });
                    }
                });
            };
        };
    });
});