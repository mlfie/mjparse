#include <stdio.h>
#include <opencv2/core/core.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;

int main(int argc, char** argv)
{
  Mat img1 = imread(argv[1], CV_LOAD_IMAGE_GRAYSCALE);
  Mat img2 = imread(argv[2], CV_LOAD_IMAGE_GRAYSCALE);
  Mat out = img1.clone();
  Mat result, bin_img, bin_tmpl;
  Point pt;
  double val;
  int opt = THRESH_BINARY|THRESH_OTSU;

  //threshold(img1, bin_img, 0, 255, opt);
  //threshold(img2, bin_tmpl, 0, 255, opt);
  adaptiveThreshold(img1, bin_img, 255, ADAPTIVE_THRESH_MEAN_C,
      THRESH_BINARY, 7, 8);
  adaptiveThreshold(img2, bin_tmpl, 255, ADAPTIVE_THRESH_MEAN_C,
      THRESH_BINARY, 7, 8);
  imshow("bin", bin_img);
  waitKey(0);
  imshow("tmpl", bin_tmpl);
  waitKey(0);

  do {
    matchTemplate(bin_img, bin_tmpl, result, CV_TM_CCOEFF_NORMED);
    //matchTemplate(img1, img2, result, CV_TM_CCOEFF_NORMED);
    minMaxLoc(result, NULL, &val, NULL, &pt);
    Rect rect(pt.x,pt.y,img2.cols,img2.rows);
    rectangle(bin_img, rect, Scalar(0,0,255), CV_FILLED);
    rectangle(out, rect, Scalar(0,0,255), 3);
    printf("val = %f\n", val);
    imshow("temp", out);
    waitKey(0);
  } while (val > 0.6);


  //matchTemplate(img1, img2, result, CV_TM_CCOEFF_NORMED);
  //minMaxLoc(result, NULL, &val, NULL, &pt);
  //Rect rect2(pt.x,pt.y,img2.cols,img2.rows);
  //rectangle(img1, rect2, Scalar(0,0,255), 3);

  //printf("val=%f\n", val);
  imshow("temp", out);
  waitKey(0);

  return 0;
}
