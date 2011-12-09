function testUtilDomToDateUrl() {

    var expect_dataurl="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAMCAgICAgMCAgIDAwMDBAYEBAQEBAgGBgUGCQgKCgkICQkKDA8MCgsOCwkJDRENDg8QEBEQCgwSExIQEw8QEBD/2wBDAQMDAwQDBAgEBAgQCwkLEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBD/wAARCAAQABADAREAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD6h+NXxK8R/DfSdJudE8IaHqP9r20Pkvd6cr/8sEd5Hf8Aj+d66s6zSnlWFU6r5qrbT100dtj4LOsfjsr/AIKvTM34XfEXXPiN4W8R6jrXgjQNPm0awuXeaz01E+f7LM6SJJ/A+9K1yPM4ZrhHOi2qsWra92lsPJcdjs0/jq1MX4m698U9b01fDGk23w3n0JNNto7KfVbuEXttP9lTfJ89ynlvG+/HyfwV8dxBlub47FNUMNzUpbO9joxCxDXLWSdMzfBviT4l6N4cv/CGrx/DOHRp9FvLe6fS7+E6hcziydYzhbl/MkeTZ/B0etOHcszbBYpLEYblpR3d7iw6xCXLRSVM/9k=";

    var img_orig = document.createElement('img');
    img_orig.src = "assets/hoge.jpg";

    var target_dataurl=imgDomToDataUrl(img_orig);
    console.log("target_dataurl=" + target_dataurl);

    var img_test = document.createElement('img');
    img_test.src =  target_dataurl;
    document.getElementsByTagName("body").item(0).appendChild(img_test);
    
    assertEquals(expect_dataurl, target_dataurl);
    assertEquals(16, img_test.naturalWidth);
    assertEquals(16, img_test.naturalHeight);

    var target_dataurl2 = dataUrlResize(target_dataurl,"image/jpeg",90,300);
    var img_test2 = document.createElement('img');
    img_test2.src =  target_dataurl2;
    document.getElementsByTagName("body").item(0).appendChild(img_test2);

    assertEquals(90, img_test2.naturalWidth);
    assertEquals(300, img_test2.naturalHeight);

};

