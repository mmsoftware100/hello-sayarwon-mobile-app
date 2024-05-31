# Hello Sayarwon

Simple News Reader
but build for all types of article contect.


## API Documentation

https://documenter.getpostman.com/view/6000182/2sA3BuWp3R


## 2024-05-31 Hello Sayarwon Deployment

- [ ] About Section မှာ စာအပြည့်အစုံ ရေးပေးထားရမယ်။ Hello Sayarwon ပဲ ဖြစ်ဖြစ်။
- [ ] Screenshots
- [ ] Description and other text
- [ ] Terms and conditions, privacy policy
- [ ] Submit

- [ ] Next Moves ( Multiple Language, Fully Offline Capabilities , for listing and detail )


## 2024-05-17 New Home Page UI 

- [ ] New Home Page
- [ ] FCM Detail Page
- [ ] About Page


2 Hr.

- [0830] UP and Running
 
article card မှာ ဒေတာ ပြည့်ပြည့်စုံစုံလေး ပြရမယ်။

category, author, updated at
ဒီထဲက ဘာရမလဲ
ရတာကို အဆင်ပြေအောင် ပြရမယ်။

နောက် Category Card ကို Refactor လုပ်ရမယ်။


- [x] Category On Tap ကို လုပ်မယ်။
- [x] Search result
- [x] Article card on tap
- [ ] all articles loading


article loading ကို home page မှာ ပြပေးဖို့။



```bash
rm Podfile.lock
rm -rf Pods/
```

on search လုပ်ရင် search page ကို သွားမယ်။



Local State ကို ပိုင်ပိုင်နိုင်နိုင် ထိမ်းထားဖို့ လိုမယ်
## 2024-05-16 Favourite and UI

- [x] Favourite Listing ကနေ detail ကို သွားတဲ့အခါ api call ခေါ်မိနေတယ်။ favourite ဆိုရင် မခေါ်ဘူးလို့ လုပ်လို့ရမလား?

ရတယ်။ api call မခေါ်ပဲ ဒီအတိုင်း set detail and navigate လုပ်လိုက်ရုံပဲ။


ဒါဆို Home Page လုပ်ရင် ရမယ်။

Button Navigation မှာပဲ

Home, Category, Favourite နဲ့ Account/About ဆိုပြီး ထားမယ်။


### Firebase add မယ်။

ဘယ်လောက်ကြာမလဲ?
တစ်နာရီလောက်တော့ ကြာမယ် 
ထင်တယ်။

ဒီတစ်ခါတော့ note ပါ သေချာထုတ်လိုက်ကြရအောင်။


ခန break off @ 1240 

hey, I'm back.

- [1250] FCM package တွေ ထည့်ပြီးပြီ။



firebase_core: ^2.25.2
firebase_messaging: ^14.7.13
flutter_local_notifications: ^16.3.2


Firebase Panel မှာ json file  သွားယူမယ်။

com.mmsoftware100.hellosayarwon.hellosayarwon


project level gradle


id("com.google.gms.google-services") version "4.4.1" apply false


- [1400] kotlin version တွေ၊ android ဘက်က gradle files တွေမှာ dependency တွေ ပြင်တာတွေနဲ့ ရွာတွေလည်။
ဘယ်ဟာက အမှန်မှန်း မသိ။


https://socket-server-uiks.onrender.com/fcm?title=$title&description=$description&topic=$topic

https://socket-server-uiks.onrender.com/fcm?title=ဆရာဝန်&description=မင်္ဂလာပါ&topic=hello_sayarwon



https://socket-server-uiks.onrender.com/fcm?title=ဖေဖေဖြစ်နိုင်မယ့် အခွင့်အရေး&description=ဒီလိုနည်းနဲ့ မြင့်တင်လိုက်ပါ&topic=hello_sayarwon


https://socket-server-uiks.onrender.com/fcm?title=ဖေဖေဖြစ်နိုင်မယ့် အခွင့်အရေး&description=ဒီလိုနည်းနဲ့ မြင့်တင်လိုက်ပါ&topic=hello_sayarwon





Notification Icon updated.

Final Check with FCM in release mode.

- [ ] Search Page / Icon ထည့်ပေးရမယ်။

ဒါမှ မဟုတ် search bar ကို ထိပ်ဆုံးမှာ တင်ပေးထားရမလား။

action မှာ 
- [1415] FCM အိုကေပြီ။

minSdk version တွေ ဘာတွေ ဂရုစိုက်ရတယ်။
project နဲ့ app build gradle နှစ်ခုမှာ ပြင်မယ်။

main.dart နဲ့
home_page.dart မှာ ပြင်မယ်။

ဒါဆို ရပြီ။
လွယ်ပါတယ်။

၏

အရင်ဆုံး ရနိုင်တဲ့ (၂) ခုကတော့

Category နဲ့ Favourite List ပဲ

ရိုးရိုး listing လည်း ရမယ်။

ဒါကို home page မှာ ခနထားရင် ထားလိုက်မယ်။

new home page ကို တစ်ခုထား
about က ပြီးမှ စဉ်းစား။


pull to refresh  က အော်တို ဖြစ်နေတာ တစ်ခု စဉ်းစားရမယ်။

home ကပဲ initial တစ်ခါ ခေါ်ပြီး
ကျန်တာက user ခေါ်မှ သွားလိုက်။



share လုပ်ချင်တယ် ဆိုရင်

app link ကို လုပ်ရမလား?
hello sayarwon website link ကိုပဲ ပေးမလား?


auto refresh ကို ပိတ်လိုက်တာက 
category listing မှာ အကျိုးသတ်ရောက်မှု ရှိနိုင်လား
သီးခြားစီဆိုရင်တော့ မလိုဘူး ဖြစ်မယ်။


သီးခြားစီ။
ဒီတော့ မလို။

home page , category နဲ့ favourite ပဲ လိုတာ။

About မှာ ဘာတွေရေး။

Chat GPT ကို 
CoPilot ကို မေးပြီး ရေးခိုင်းရမယ်။


** Category Detail -> listing ကို ဝင်ပြီး ပြန်ထွက်ရင် home listing မှာ အကုန်ပျောက်နေပြီ။ **

loading ပြေပးဖို့ လိုမယ်။
main listing မှာ။


basic version မှာ ဘာတွေပါမလဲ?

Premium ဆန်တဲ့ UI/UX တော့ ပေးထားရမယ်။
Yeah, i mean shimmer with detailed place.



### Release Note

- [ ] App Icon
- [ ] Splash Screen
- [ ] Shimmer effect loading on article listing
- [ ] New HOme Page
- [ ] Sale post / sharing 

Category Card ပုံစံမှာ
ပုံကို ဘောင်အပြင်ရောက်အောင်လုပ်မယ်။

ကျန်တဲ့ bug တွေရှိလား ကြည့်မယ်။

အဖြူရောင်ပေါ်မှာ 
သိသိသာသာ division ခွဲထားနိုင်ရင်လည်း ကောင်းမယ်။
အမြဲလိုလို အစိမ်းကတ်က အဆင်မပြေနိုင်။


article card တွေကိုလည်း ပြန်စစ်ကြည့်ရမယ်။


release mode နဲ့ တစ်ခါ စမ်းပြီးရင် 
promotional poster ထုတ်မယ်။



notificatoin icon 

https://romannurik.github.io/AndroidAssetStudio/icons-notification.html#source.type=image&source.space.trim=1&source.space.pad=0&name=ic_stat_hello_sayarwon_removebg_preview





Hello Sayarwon ရဲ့
အခြား နိုင်ငံက ဗားရှင်းတွေလည်း လုပ်ရမယ်။

https://wp.hellokhunmor.com/wp-json/api/health-tools/bmi-calculator/info? 


https://wp.hellokhunmor.com/wp-json/api/articles
https://hellodoctor.com.ph/
https://hellosehat.com/
https://hellodoktor.com/
https://hellokrupet.com/
https://helloyishi.com.tw/
https://hellobacsi.com/

https://helloswasthya.com/




## 2024-05-15 Category UI and 

Basic Listing for 

- [ ] Home Page
- [ ] Category Listing
- [ ] Article Listing
- [ ] Article list by category
- [ ] Search

all online features

Search လုပ်တာက api သက်သက်ဆိုတော့ကာ

remote မှာပဲ တိုးလိုက်ကြတာပေါ့။
အလွယ်တကူ။

Search Page  ဆက်လုပ်မယ်။





*** Article List by category ကို သီးသန့် page မှာ ထားကြမလား ဒါကတော့ ရိုးရှင်းတဲ့ ချဉ်းကပ်မှုပဲ ***

Duplicate ဖြစ်တာ မှန်ပေမယ့်.

Listing တစ်ခုက မျိုးစုံကို တာဝန်ယူရတာက 

အခုဆိုရင် pull to refresh ရဲ့ auto refresh က အနှောက်အယှက်ပေးနေပြီ။

add to fav ထည့်ချင်ပြီ။

Local Db က သိမ်းထားပေးမှ ရမယ်။

Data Flow က ဒီလိုလာမယ်။
Article Detail Page -> 
article  တစ်ပုဒ်ကို fav လုပ်ချင်တယ် ပြောတယ်။

Provider -> usecase က တဆင့် ပို့ပေးမယ်။ 
Local Data Source အထိ ရောက်အောင်။

Add to Fav နဲ့
Remove from Fav နှစ်ခု ရှိမယ်။

တစ်ခု လိုမှာက

article တစ်ခုဟာ fav or not ဆိုတာကို စစ်ပေးတဲ့ method တစ်ခု 

ဘယ်ချိန်မှာ တောင်းမလဲ?

detail ကတည်းက တောင်းမလား?

တောင်းလိုက်မယ်။
fav ရှိ / မရှိ

id ပေးပြီးပဲ တောင်းတာ ကောင်းမယ်။

insert လုပ်ရင်လည်း id နဲ့ လုပ်။

ဒါလည်း အရေးကြီးတယ်။
ကိုယ်စုထားတာလေး ရှိမှ ပြန်ဝင်လာကြည့်ဖို့ စိတ်များမယ်။

လုပ်ရမှာတော့ များတယ်။

database ဆောက်ရမယ်။
table ဆောက်မယ်။

insert နဲ့
update / 
delete ရေးရမယ်။

CRUD ကတော မဖြစ်မနေ ရေးရမှာပဲ။

directory ကနေ ကူးလို့ရမလား ကြည့်ရမယ်။

ဒီနေ့ ညနေ sale post တစ်ခုလည်း ရေးရမယ်။


နောက်မှ sync logic ထည့်မယ်။

detail ကြည့်တိုင်းမှာ _insert_ လုပ်တာမျိုး။
insert / update ပေါ့။
ဒီ id နဲ့ ရှိရင် update လုပ်မယ်။
မရှိရင် insert လုပ်။



## 2024-05-14 Test Pages က စမ်းကြမယ်။

- [x] Refresh article
- [x] Load more articles
- [x] Article detail

- [x] Category Listing
- [x] Category Detatil
- [x] Article Listing by Category

- [ ] Add to favourite
- [ ] Remove from favourite
- [ ] Favourite List

- [ ] Select local list

စစ်ရမှာက 

store အဆင်ပြေသွားသလား

getArticles လုပ်တဲ့အချိန်မှာ။


*** App အတွင်းပိုင်းမှာ ကိုယ်ပိုင် Data Structure တွေနဲ့ပဲ အလုပ်လုပ်မယ် ***

Entity,
Model
JSON Map

ဒီ (၃) မျိုး။


test page ကနေ စမ်းကြည့်တာ ဒေတာတွေ အကုန်အဆင်ပြ။

detail page မှာက
favourite လုပ်တာ 
data တွေ ပျောက်ကုန်တယ်။

api က ပြန်ခေါ်လိုက်ရင်လည်း main tain လုပ်ထားတာမရှိ။
အသစ်ဖြစ်နေတယ်။
ဒါကို တစ်ဆင့်ချင်း ပြန်စစ်ရမယ်။
Provider ကို debug မှာ ကြည့်မရတာ ခက်။


article က ပြန်လာတာ က empty ဖြစ်နေတယ်။
select လုပ်တာ / update လုပ်တဲ့ data က ဘာဖြစ်နေလို့လဲ?



Serialization မှန်အောင် လုပ်ရမလိမ့်မယ်။

Refresh က စကြတာပေါ့။

### UI

article detail page မှာ loading ပြရန်။ 

Set Detail မှာ api call ပါ ခေါ်ရမယ်။

description ကို html render နဲ့ ချပြရမလို ဖြစ်နေပြီ။


## ဘယ်က စကြမလဲ?

Entity

Provider

Presentation


Documentation ရှိရင်တော့ ပိုမြန်မယ်။

Data Structure နဲ့
CRUD Methods တွေ။

ဒါတောင် အရင်က ဟာတွေ ကူးတာများတယ်။
စဉ်းစားရတာ ကို အတက်နိုင်ဆုံး လျှော့ထားတယ်။

Usecase နဲ့ Provider အပိုင်း ဆက်သွားလိုက်မယ်။




## 2024-05-09 Offline on Domain and Presentation 


- [0910] 


- [x] repository
- [x] usecases
- providers
- pages
- components
- testing without calling repository

## 2024-05-10

- select api call

## API List

- [ ] Select Articles
- [ ] Select Article Detail
- [ ] Select Categories
- [ ] Select Category Detail
- [ ] Select Articles by Category
- [ ] Select Articles by Search



### Serialization 

```bash
dart run build_runner build --delete-conflicting-outputs
```
- [ ] 