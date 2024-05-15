# Hello Sayarwon

Simple News Reader
but build for all types of article contect.


## API Documentation

https://documenter.getpostman.com/view/6000182/2sA3BuWp3R


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