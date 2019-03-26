const String appName = "Smart Building App";
const String kBaseUrl = "http://10.1.23.20";
const String kTicketBaseUrl = "http://ticket-api.spinalcom.com";
const String kUserBaseUrl = "http://user-api.spinalcom.com";

const String kUserPort = ":3333";
const String kUserUrl = kUserBaseUrl;

const String kLoginUrl = kUserUrl + "/login";
const String kSignUpUrl = kUserUrl + '/user';

const String kEndLogin = kUserPort + '/login';
const String kEndSignUp = kUserPort + '/user';

const String kTicketPort = ":3000";
const String kTicketUrl = kTicketBaseUrl;

const String kProcesses = kTicketUrl + '/processes';
const String kTicket = kTicketUrl + '/ticket';
const String kSentences = kTicketUrl + '/sentences';
const String kTicketUser = kTicketUrl + '/tickets';
const String kTicketNode = kTicketUrl + '/node';

const String kEndProcesses = kTicketPort + '/processes';
const String kEndTicket = kTicketPort + '/ticket';
const String kEndSentences = kTicketPort + '/sentences';
const String kEndTicketUser = kTicketPort + '/tickets';
const String kEndTicketNode = kTicketPort + '/node';
