var pages = new Array(0);
var pageWidth = 360
var pageHeight = 480

var domain = "newpage.in.ua";
var user = "demoUser";

var catId;

function push(name, source){
    pages.push(source);

    if(pages.length > 1)
        backBtn.text = "<-"
    loader.source = source
    header.text = name
}
function pop(){
    loader.source = pages.pop()
}
function getLast(){
    return pages.valueOf(pages.length - 1);
}

function loadK2Item(value){
    jsonModel.source = "http://" + domain + "/index.php?option=com_hoicoiapi&task=k2_single_item&id=" + value;
}

function loadK2Items(value){
    jsonModel.source = "http://" + domain + "/index.php?option=com_hoicoiapi&task=k2_items&id=" + value;
}

function catDetails(id, name, description, image, language, parent){
    itemId.text = "id: " + id;
    itemName.text = "Name: " + name;
    itemDescription = "Description: " + description;
    itemImage.source = image;
    itemLanguage = "Language: " + language;
    itemParent = "Parent: " +  parent;
    infoBlock.state = "OPENED";
}
