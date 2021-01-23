clear all;
FG =imread("C:/Users/ismail/Desktop/d/3.jpg");
BG =imread("C:/Users/ismail/Desktop/d/bg3.jpg");
#ON YUZ FOTOGRAFI VE ARKA PLAN FOTOGRAFINI ?MREAD ?LE OKUNDU[1-2]
FGhsv = rgb2hsv(FG);
#ON YUZ FOTOGRAFI HSV RENK UZAYINA DÖNÜ?TÜRÜLDÜ[5]
sat = size(FGhsv)(1);
sut = size(FGhsv)(2);
#SATIR VE SUTUN B?LG?LER? KAYDED?LD?[7-8]
H=uint8(255*FGhsv(:,:,1));
S=uint8(255*FGhsv(:,:,2));
V=uint8(255*FGhsv(:,:,3));
#HSV ON YUZ FOTOGRAFININ HUE,SATURATION VE VALUE KATMANLARI KAYDED?LD?[10-12]
hueMask = (H >= 65) & (H <= 140);
satMask = (S >= 40) & (S <= 360);
valMask = (V >= 40) & (V <= 360);
#HUE,SATURATION VE VALUE DEGERLERI ICIN MINIMUM VE MAKSIMUM
#ESIK DEGERLERI TANIMLANDI [14-16]
maske = uint8(hueMask&satMask&valMask );
maskAna = FG.*maske;
imwrite(maskAna,"C:/Users/ismail/Desktop/d/maskAna.jpg");
#BELIRLENEN ESIK DEGERLERINE GORE MASKE OLUSTURULDU VE ON YUZ FOTORAGRAFI
#ILE CARPILARAK MASKELENMIS ANA RESIM CIKTISI ELDE EDILDI[19-21]

maskAnaResimHSV = rgb2hsv(maskAna);
maskAna=uint8(255*maskAnaResimHSV(:,:,3));
#MASKELENMIS ANA RESMIMIZ TEKRARDAN HSV UZAYINA DONUSTURULDU 
#VE VALUE KATMANI ELE ALINDI [25-26]
imwrite(maskAna,"C:/Users/ismail/Desktop/d/maskAnaV.jpg");
#VALUE KATMANI ALINAN RESIM CIKTISI ALINDI
for i=1:sat
  for j=1:sut
    if maskAna(i,j)<=50
        mask2(i,j)=1;
        mask1(i,j)=0;
    else
      mask2(i,j)=0;
      mask1(i,j)=1;
    end
  end
end
imwrite(mask2,"C:/Users/ismail/Desktop/d/mask2.jpg");
imwrite(mask1,"C:/Users/ismail/Desktop/d/mask1.jpg");
#VALUE KATMANI ALINMIS RESIM FOR DONGUSUNE SOKULARAK VALUE DEGERI 50 YE ES?T 
#VEYA 50 N?N ALTINDA ?SE ?K? TANE B?RB?R?N?N TAM TERS? OLAN MASKELEME 
#GORUNTULERINI CIKTI OLARAK VERIR[31-43]
FGO(:,:,1)=mask2.*FG(:,:,1);
FGO(:,:,2)=mask2.*FG(:,:,2);
FGO(:,:,3)=mask2.*FG(:,:,3);
imwrite(FGO,"C:/Users/ismail/Desktop/d/FGO.jpg");
#ON YUZ FOTOGRAFI ILE ON YUZ MASKELEME MASKESINI CARPARAK ON YUZ ÇIKTI
#FOTOGRAFINI VERIR[47-50]
BGO(:,:,1)=mask1.*BG(:,:,1);
BGO(:,:,2)=mask1.*BG(:,:,2);
BGO(:,:,3)=mask1.*BG(:,:,3);
imwrite(BGO,"C:/Users/ismail/Desktop/d/BGO.jpg");
#ARKA YUZ FOTOGRAFI ILE ARKA YUZ MASKELEME MASKESINI CARPARAK ARKA YUZ ÇIKTI
#FOTOGRAFINI VERIR[53-56]
FGO = FGO +BGO;
imwrite(FGO,"C:/Users/ismail/Desktop/d/SON.jpg");
#ON YUZ VE ARKA YUZ FOTOGRAFI TOPLANARAK SON GORUNTU ELDE EDILIR
