
class ConvertTienSangChu {

  static String Sohangngan(String So)
  {
    String result = "";
    if (So == "1000")
      result = " một nghìn ";
    else
    {
      result = Sodonvi(So.substring(0, 1)) + " nghìn ";
      if (So.substring(1, 2) == "0")
      {

        if (So.substring(2, 3) == "0")
        {
          if (So.substring(3, 4) != "0")
          {
            result += Sodonvi(So.substring(1, 2)) + " trăm ";
            result += " lẻ " + Sodonvi(So.substring(So.length - 1));
          }
        }
        else
        {
          result += Sodonvi(So.substring(1, 2)) + " trăm ";
          result += Sohangchuc(So.substring(2, 4));
        }
      }
      else
        result += Sohangtram(So.substring(1, 4));
    }
    return result;


  }
  static String Sohangtram(String So)
  {
    String result = "";
    if (So == "100")
      result = " một trăm ";
    else {
      result += Sodonvi(So.substring(0, 1)) + " trăm ";
      if (So.substring(1, 2) == "0") {
        if (So.substring(2, 3) != "0")
          result += " lẻ " + Sodonvi(So.substring(2, 3));
      } else
        result += Sohangchuc(So.substring(1, 3));
    }
    return result;

  }
  static String Sohangchuc(String So)
  {
    String result = "";
    if (So == "10")
      result = " mười ";
    else
    {
      if (So.substring(0, 1) == "1")
        result += " mười " + Sodonvi(So.substring(1, 2));
      else
      {
        result += Sodonvi(So.substring(0, 1)) + " mươi ";
        if (So.substring(1, 2) != "0")
          result += Sodonvi(So.substring(1, 2));


      }
    }
    return result;
  }
  static String Sodonvi(String So)
  {
    String result = "";
    switch (So)
    {
      case "0":
        result += " không ";
        break;
      case "1":
        result += " một ";
        break;
      case "2":
        result += " hai ";
        break;
      case "3":
        result += " ba ";
        break;
      case "4":
        result += " bốn ";
        break;
      case "5":
        result += " năm ";
        break;
      case "6":
        result += " sáu ";
        break;
      case "7":
        result += " bảy ";
        break;
      case "8":
        result += " tám ";
        break;
      case "9":
        result += " chín ";
        break;

    }
    return result;
  }

 static String Convert_NumtoText(String Sonhap)
  {
    if (Sonhap.length > 12) return "Số quá lớn";
    String result = "";
    switch (Sonhap.length)
    {
      case 0:
        result = "";
        break;
      case 1:
        result = Sodonvi(Sonhap);
        break;
      case 2:
        {

          result = Sohangchuc(Sonhap);

        }
        break;
      case 3:
        {
          result = Sohangtram(Sonhap);
        }
        break;
      case 4:
        {
          result = Sohangngan(Sonhap);

        }
        break;
      case 5:
        {
          result = Sohangchuc(Sonhap.substring(0, 2)) + " nghìn " + Sohangtram(Sonhap.substring(2, 5));
        }
        break;
      case 6:
        {
          result = Sohangtram(Sonhap.substring(0, 3)) + " nghìn " + Sohangtram(Sonhap.substring(3, 6));

        }
        break;
      case 7:
        {
          result = Sodonvi(Sonhap.substring(0, 1)) + " triệu " + Sohangtram(Sonhap.substring(1, 4)) + " nghìn " + Sohangtram(Sonhap.substring(4, 7));
        }
        break;
      case 8:
        {
          result = Sohangchuc(Sonhap.substring(0, 2)) + " triệu " + Sohangtram(Sonhap.substring(2, 5)) +
              " nghìn " + Sohangtram(Sonhap.substring(5, 8));
        }
        break;
      case 9:
        {
          result = Sohangtram(Sonhap.substring(0, 3)) + " triệu " + Sohangtram(Sonhap.substring(3, 6)) +
              " nghìn " + Sohangtram(Sonhap.substring(6, 9));
        }
        break;
      case 10:
        {
          result = Sodonvi(Sonhap.substring(0, 1)) + " tỷ " + Sohangtram(Sonhap.substring(1, 4)) + " triệu ";
          result += Sohangtram(Sonhap.substring(4, 7)) + " nghìn ";
          result += Sohangtram(Sonhap.substring(7, 10));
        }
        break;
      case 11:
        {
          result = Sohangchuc(Sonhap.substring(0, 2)) + " tỷ " + Sohangtram(Sonhap.substring(2, 5)) + " triệu ";
          result += Sohangtram(Sonhap.substring(5, 8)) + " nghìn ";
          result += Sohangtram(Sonhap.substring(8, 11));
        }
        break;
      case 12:
        {
          result = Sohangtram(Sonhap.substring(0, 3)) + " tỷ " + Sohangtram(Sonhap.substring(3, 6)) + " triệu ";
          result += Sohangtram(Sonhap.substring(6, 9)) + " nghìn ";
          result += Sohangtram(Sonhap.substring(9, 12));
        }
        break;

    }
    int vt = result.lastIndexOf(" ");

    if ((vt == result.length - 12) && vt != -1)
      result = result.substring(0, vt);
    result = result.replaceAll("  ", " ").replaceAll("mươi một", "mươi mốt")
        .replaceAll("mươi năm", "mươi lăm").trim() + " đồng chẵn";
    return result.substring(0, 1).toUpperCase() + result.substring(1);
  }
}
