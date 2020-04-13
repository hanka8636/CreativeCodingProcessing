public class XMLparser {
  void parseMany(Can[] cans) {
    XML[] cansXML = xml.getChildren("can");
    cans = new Can[cansXML.length];


    for (int i = 0; i < cansXML.length; i++) {
      int id = cansXML[i].getInt("id");
      //cansXML[i].getChildren();
      cans[i] = new Can();
      cans[i].name = cansXML[i].getChild("name").getContent();
      cans[i].brand = cansXML[i].getChild("brand").getContent();
      cans[i].canWidth = Float.parseFloat(cansXML[i].getChild("width").getContent());
      if (cansXML[i].getChild("width").getString("unit") == "cm") 
        cans[i].canWidth*=10;
      cans[i].canHeight = Float.parseFloat(cansXML[i].getChild("height").getContent());
      if (cansXML[i].getChild("height").getString("unit") == "cm") 
        cans[i].canHeight*=10;
      cans[i].weight = Integer.parseInt(cansXML[i].getChild("weight").getContent());
      cans[i].weightProduct = Integer.parseInt(cansXML[i].getChild("weight_product").getContent());
      cans[i].energy = Integer.parseInt(cansXML[i].getChild("energy").getContent());
      cans[i].barCode = Long.parseLong(cansXML[i].getChild("bar_code").getContent());
      cans[i].days = Integer.parseInt(cansXML[i].getChild("expiration_date").getChild("day").getContent());
      cans[i].months = Integer.parseInt(cansXML[i].getChild("expiration_date").getChild("month").getContent());
      cans[i].years = Integer.parseInt(cansXML[i].getChild("expiration_date").getChild("year").getContent());

      //cans[i].canHeight = cansXML[i].getInt("height");
      //String name = cansXML[i].getContent();
    }
  }
  
    void parseOne(Can can, int index) {
    XML[] cansXML = xml.getChildren("can");
  XML canXML = null;
    for (int i = 0; i < cansXML.length; i++) {
      int id = cansXML[i].getInt("id");
      if(id==index)
       canXML =  cansXML[i].getChild("can");
      //cansXML[i].getChildren();
      can = new Can();
      can.name = canXML.getChild("name").getContent();
      can.brand = canXML.getChild("brand").getContent();
      can.canWidth = Float.parseFloat(canXML.getChild("width").getContent());
      if (canXML.getChild("width").getString("unit") == "cm") 
        can.canWidth*=10;
      can.canHeight = Float.parseFloat(canXML.getChild("height").getContent());
      if (canXML.getChild("height").getString("unit") == "cm") 
        can.canHeight*=10;
      can.weight = Integer.parseInt(canXML.getChild("weight").getContent());
      can.weightProduct = Integer.parseInt(canXML.getChild("weight_product").getContent());
      can.energy = Integer.parseInt(canXML.getChild("energy").getContent());
      can.barCode = Long.parseLong(canXML.getChild("bar_code").getContent());
      can.days = Integer.parseInt(canXML.getChild("expiration_date").getChild("day").getContent());
      can.months = Integer.parseInt(canXML.getChild("expiration_date").getChild("month").getContent());
      can.years = Integer.parseInt(canXML.getChild("expiration_date").getChild("year").getContent());

      //cans[i].canHeight = cansXML[i].getInt("height");
      //String name = cansXML[i].getContent();
    }
  }
  
   Can parseFirst(Can can) {
    XML canXML = xml.getChild("can"); //<>//
      //cansXML[i].getChildren();
      can = new Can(); //<>//
      can.name = canXML.getChild("name").getContent();
      can.brand = canXML.getChild("brand").getContent();
      can.canWidth = Float.parseFloat(canXML.getChild("width").getContent());
      if (canXML.getChild("width").getString("unit") == "cm") 
        can.canWidth*=10;
      can.canHeight = Float.parseFloat(canXML.getChild("height").getContent());
      if (canXML.getChild("height").getString("unit") == "cm") 
        can.canHeight*=10;
      can.weight = Integer.parseInt(canXML.getChild("weight").getContent());
      can.weightProduct = Integer.parseInt(canXML.getChild("weight_product").getContent());
      can.energy = Integer.parseInt(canXML.getChild("energy").getContent());
      can.kcal = Integer.parseInt(canXML.getChild("kcal").getContent());
      can.barCode = Long.parseLong(canXML.getChild("bar_code").getContent());
      can.days = Integer.parseInt(canXML.getChild("expiration_date").getChild("day").getContent());
      can.months = Integer.parseInt(canXML.getChild("expiration_date").getChild("month").getContent());
      can.years = Integer.parseInt(canXML.getChild("expiration_date").getChild("year").getContent());

      //cans[i].canHeight = cansXML[i].getInt("height");
      //String name = cansXML[i].getContent();
      return can;
  }
}
