/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.uild
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

/// Meen url
// const crashBaseUrl = "http://192.168.3.214/fitness-platform-yii2-2048/";
// const baseUrl = "http://192.168.3.214/fitness-platform-yii2-2048/api";

/// Harsh url
// const crashBaseUrl = "http://192.168.2.147/fitness-platform-yii2-2048/";
// const baseUrl = "http://192.168.2.147/fitness-platform-yii2-2048/api";
// const imageBaseUrl = "http://192.168.2.147";

/// Sach url
// const crashBaseUrl = "http://192.168.11.153/fitness-platform-yii2-2048/";
// const baseUrl = "http://192.168.11.153/fitness-platform-yii2-2048/api";

/// live url
// const crashBaseUrl = "https://mars.toxsl.in/fitness-platform-yii2-2048/";
// const baseUrl = "https://mars.toxsl.in/fitness-platform-yii2-2048/api";

/// prod url
const crashBaseUrl = "http://revalesuva.co.il/";
const baseUrl = "http://revalesuva.co.il/api";

/// authentication
const login = "/user/login";
const String checkEndPoint = "/user/check";
const String logout = "/user/logout";
const socialLogin = "/Account/socialLogin";
const forget = "/user/forgot-password";
const imageUpload = "/user/user-profile-image";
const profileSetup = "/user/profile-setup";
const getQuestionList = "/user/questionare-list";
const addUpdateAnswer = "/user/add-answer";
const editAnswer = "/user/edit-question";

/// weight
const addWeight = "/weight/add-weight";
const weightMeasurement = "/weight/measurement";
const addDataEntry = "/weight/add-data-entry";
const dataEntryDetails = "/weight/data-entry-details";
const weighingDetails = "/weight/weighing-details";

/// Health Consumerism
const categoryList = "/product-category/product-category";
const categoryDetailsList = "/product-category/product-details";
// const myShoppingList = "/product-category/my-shopping-list";
const myShoppingList = "/product-category/cart-item-list";
const myShoppingPlaceOrder = "/product-category/place-order";
const addProduct = "/product-category/add-cart";
// const addProduct = "/product-category/add-product";
const deleteProduct = "/product-category/delete-cart-item";
// const deleteProduct = "/product-category/delete-product";

const getRecipesByTime = "/product-category/recipe";
const getRecipesDetails = "/product-category/recipe-detail";

/// Vessels

const addIntuitiveWritingEndPoint = "/intuitive-writing/intuitive-writing";
const updateIntuitiveWritingEndPoint =
    "/intuitive-writing/edit-intuitive-writing";
const deleteIntuitiveWritingEndPoint =
    "/intuitive-writing/remove-intuitive-writing";
const getIntuitiveWritingListEndPoint =
    "/intuitive-writing/get-intuitive-writing";

const getNutritionCategoryListEndPoint =
    "/intuitive-writing/nutrition-categories";
const getNutritionSubCategoryListEndPoint =
    "/intuitive-writing/nutrition-details";
const addDailyNutritionEndPoint = "/intuitive-writing/add-daily-nutritions";
const mySuccessiveListEndPoint = "/intuitive-writing/my-success-list";
const addFastDetailsEndPoint = "/intuitive-writing/fasting";
const endFastEndPoint = "/intuitive-writing/complete-fast";
const fastHistoryEndPoint = "/intuitive-writing/my-fasting-history";
const addOvulationEndPoint = "/intuitive-writing/add-ovalution";
const ovulationDetailsEndPoint = "/intuitive-writing/ovalution-detail";
const addTrackEndPoint = "/intuitive-writing/fasting-track";
const getTrackTimeEndPoint = "/intuitive-writing/fasting-track-list";

/// Plans

const myPlanEventListEndPoint = "/plan/event-list";
const applyEventEndPoint = "/plan/event-apply";
const videoListEndPoint = "/plan/video-list";
const addReviewEndPoint = "/plan/review-video";

/// Podcasts

const podCastListEndPoint = "/podcasts/product-list";
const podCastDetailsListEndPoint = "/podcasts/list";

/// Contact

const dropdownListEndPoint = "/help/option-list";
const addHelpSupportEndPoint = "/help/help-support";
// const podCastDetailsListEndPoint = "/podcasts/list";

/// Shops/Events

const shopCategoryListEndPoint = "/product/category-list";
const productListByCategoryEndPoint = "/product/list";
const shopProductDetailsEndPoint = "/product/detail";
const addToCartShopProductEndPoint = "/product/add-cart";
const cartItemListEndPoint = "/product/cart-item-list";
const deleteCartItemEndPoint = "/product/delete-cart-item";
const addCustomerAddressEndPoint = "/product/add-customer-detail";
const updateCustomerAddressEndPoint = "/product/update-customer-detail";
const placeOrderEndPoint = "/product/place-order";
const orderListEndPoint = "/product/order-list";
const orderItemListEndPoint = "/product/order-item-list";
const orderItemDetailsEndPoint = "/product/order-detail";
const cancelOrderEndPoint = "/product/cancel-order";

/// Chat

const sendMessageEndPoint = "/chat/send-message";
const loadChatEndPoint = "/chat/load-chat";
const newMessageEndPoint = "/chat/load-new-message";

/// Article

const articlesListEndPoint = "/user/article-list";
const articlesDetailsEndPoint = "/user/article-detail";

/// Gallery

const galleryListEndPoint = "/user/gallery-list";
const galleryDetailsEndPoint = "/user/gallery-detail";

/// Torah Book Portion
const bookTorahPortionEndPoint = "/intuitive-writing/torah-portion-list";
const starListEndPoint = "/star/list";
const strengthVideoEndPoint = "/user/strength-traning";
const meditationVideoEndPoint = "/user/meditation-videos";

/// Notification
const notificationListEndPoint = "/user/notification-list";
const clearNotificationEndPoint = "/user/clear-notification";

const myAccount = "/Account/MyAccount";
const myBook = "/Book/MyBook";
const lend = "/Book/Lend";
const returnMyBook = "/Book/ReturnMyBook";
const returnBook = "/Book/ReturnBook";
const gift = "/Book/Gift";
const faq = "/Content/faq";
const plansListEndPt = "/Content/faq";
const buySubscriptionEndPt = "/Content/faq";

/// Static
const String getPagesEndPoint = "/user/get-page";

//Social login type const
const GOOGLE_SIGN_IN = 1;
const APPLE_SIGN_IN = 2;
const FB_SIGN_IN = 3;

const APP_ID = "";

//Log exceptions and crashes
const logCrashesExceptionsEndPoint = "logger/log/exception";
