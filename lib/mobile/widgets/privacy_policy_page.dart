import 'package:flutter/material.dart';

class PrivacyPolicy extends StatefulWidget {
  PrivacyPolicy();
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: _height / 2.0,
                width: _width,
                decoration: BoxDecoration(
                    color: Colors.blue[900],
                    borderRadius: BorderRadius.only(
                      bottomLeft:
                          Radius.elliptical(_height / 3.5, _width / 2.5),
                    )),
              ),
              Container(
                height: _height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          "Privacy Policy",
                          textScaleFactor: 2.0,
                          style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: _width / 0.2,
                            child: Text(
                              "Privacy Policy Introduction \n\n"
                              "Our privacy policy will help you understand what information we collect at Quickly, how Quickly uses it, and what choices you have. "
                              "*Quickly* built the Quickly app as a free app. This SERVICE is provided by Quickly at no cost and is intended for use as is. "
                              "If you choose to use our Service, then you agree to the collection and use of information in  relation with this policy. The Personal Information that we collect are used for providing and improving the Service. We will not use or share your information with anyone except as described in this Privacy Policy. "
                              "The terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which is accessible in our website, unless otherwise  defined in this Privacy Policy.\n\n\n "
                              "### Information Collection and Use\n\n"
                              "For a better experience while using our Service, we may require you to provide us with certain personally identifiable information, including but not limited to users name, email address, gender, location, pictures. The information that we request will be retained by us and used as described in this privacy policy. "
                              "The app does use third party services that may collect information used to identify you.\n\n\n "
                              "### Cookies \n\n"
                              "Cookies are files with small amount of data that is commonly used an anonymous unique identifier. These are sent to your browser from the website that you visit and are stored on your devices’s internal memory. "
                              "This Services does not uses these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collection information and to improve their services. You have the option  to either accept or refuse these cookies, and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service. \n\n\n"
                              "### Location Information \n\n"
                              "Some of the services may use location information transmitted from users' mobile phones. We only use this information within the scope necessary for the designated service. \n\n\n "
                              "### Device Information \n\n"
                              "We collect information from your device in some cases. The information will be utilized for the provision of better service and to prevent fraudulent acts. Additionally, such information will not include that which will identify the individual user. \n\n\n"
                              "### Service Providers \n\n"
                              " We may employ third-party companies and individuals due to the following reasons:"
                              "* To facilitate our Service;"
                              "* To provide the Service on our behalf;"
                              "* To perform Service-related services; or"
                              "* To assist us in analyzing how our Service is used."
                              "We want to inform users of this Service that these third parties have access to your Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.\n\n\n"
                              "Security\n\n"
                              "We value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over  the internet, or method of electronic storage is 100% secure and reliable, and we cannot guarantee its absolute security. \n\n\n"
                              "Children’s Privacy\n\n"
                              "This Services do not address anyone under the age of 13. We do not knowingly collect personal identifiable information from children under 13. In the case we discover that a child under 13 has provided us with personal information, we immediately delete this from our servers. If you  are  a  parent  or  guardian and you are aware that your child has provided us with personal information, please contact us so that we will be able to do necessary actions. \n\n\n"
                              "Changes to This Privacy Policy\n\n"
                              "We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page. These changes are effective immediately, after they are posted on this page. \n\n\n"
                              "Contact Us\n\n"
                              "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us. "
                              "Contact Information: "
                              "Email: vigortechapp@gmail.com "
                              "                            ",
                              //  textScaleFactor: 1.0,
                              maxLines: 200,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10.0,
                child: Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white60,
                          size: 30.0,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            //   alignment: Alignment.bottomCenter,
            height: 100.0,
            width: 100.0,

            child: Image.asset(
              "assets/images/vigor.png",
              fit: BoxFit.contain,
            ),
          )
        ],
      ),
    );
  }
}
