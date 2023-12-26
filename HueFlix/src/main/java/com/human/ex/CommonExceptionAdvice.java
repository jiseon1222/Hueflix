package com.human.ex;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

// 전역적인 예외 처리와 모델 객체인 바인딩을 담당
@ControllerAdvice
public class CommonExceptionAdvice {

  private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);

//  @ExceptionHandler(Exception.class)
//  public String common(Exception e) {
//
//    logger.info(e.toString());
//
//    return "error_common";
//  }
  //모든 에러 처리
  @ExceptionHandler(Exception.class)
  private ModelAndView errorModelAndView(Exception ex) {

    ModelAndView modelAndView = new ModelAndView();
    modelAndView.setViewName("/board/error_common2");
    modelAndView.addObject("exception", ex);

    return modelAndView;
  }
  //수학적 에러 처리
  @ExceptionHandler(ArithmeticException.class)
  private ModelAndView errorMath(Exception ex) {

    ModelAndView modelAndView = new ModelAndView();
    modelAndView.setViewName("/board/error_common");
    modelAndView.addObject("exception", ex);

    return modelAndView;
  }
}


