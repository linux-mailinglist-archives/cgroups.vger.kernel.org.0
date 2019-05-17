Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383D421B42
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 18:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbfEQQPH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 12:15:07 -0400
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:29696
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729452AbfEQQPH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 12:15:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJcn5NUE7+46jwgOT4gY89L6Fz8bWLiALCj8pcOI7DA=;
 b=UVzjFzXYejRtaRWK76DL6cRWtEbOtJyRrwHiesmMRsk12TDWqOjPLFBwUfXluzw7MkQxeCorM9DUbJsPDWYyk+eO1//rSGHGb62xUkXbWY6CUl+1H5DBcSPxnBadF4Hv0Dy+ADcDHkMI+KDOJyAimNAroqfYPp2fDcWBhn3WBfs=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB2823.namprd12.prod.outlook.com (20.177.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 16:15:04 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Fri, 17 May 2019
 16:15:04 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 2/4] drm/amd: Pass drm_device to kfd
Thread-Topic: [PATCH v2 2/4] drm/amd: Pass drm_device to kfd
Thread-Index: AQHVDMuvmVQJAvn+Xk6BeLzIu51wKA==
Date:   Fri, 17 May 2019 16:15:03 +0000
Message-ID: <20190517161435.14121-3-Harish.Kasiviswanathan@amd.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTOPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::27) To BYAPR12MB3384.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35686440-8230-4e83-d8df-08d6dae2d1c3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB2823;
x-ms-traffictypediagnostic: BYAPR12MB2823:
x-microsoft-antispam-prvs: <BYAPR12MB2823CDB42CED5BA04B8E684C8C0B0@BYAPR12MB2823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(25786009)(53936002)(4326008)(3846002)(6116002)(478600001)(7736002)(81156014)(305945005)(446003)(2906002)(14454004)(99286004)(6512007)(2501003)(73956011)(68736007)(66476007)(8676002)(66556008)(64756008)(71200400001)(71190400001)(66446008)(8936002)(26005)(186003)(66946007)(81166006)(6506007)(36756003)(72206003)(5660300002)(110136005)(50226002)(66066001)(86362001)(76176011)(102836004)(256004)(1076003)(14444005)(386003)(6436002)(11346002)(316002)(6486002)(476003)(486006)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2823;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xQ6PR0R5G22J8A6/GL3LYH5wQc8IUrJ/Du1JrsCsGr677REHm2i4ohPi7W02Y26hxF2AXJ8Wd3pBSwAXA1t3HfYG00wB5to3XnYrsudAbx+/NJ1nPUYuc/Y5EIpOPGZUH4uJlPTaBq/vxkUFnqSFw9ciVvIrL6lbTYbmbvaB9uQ3gddGXBHRkZJwQ6H9UXqhmqpn11FG4roiwFZpVyQ5Ih2iH65hZWU2ZMaM91XUE2S5H4e3nHi8RCEmZi5mInDuQTE6ElZrLimUo0QIl6oIU6G+yBrUDwIAkWL+9EqRmBdf220gDgRKw2Kx4sC7X95txvYaOYc3fWKug64aapX7XcV68hpxjMKrk+ASULEJZ8/SelXRHQPIPlzFhZ9IMp+m4Y6DNQUmC0baWOV3nnbiYDC+yhBKUQcck3dWFpKdSdo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35686440-8230-4e83-d8df-08d6dae2d1c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:15:04.0008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

a2ZkIG5lZWRzIGRybV9kZXZpY2UgdG8gY2FsbCBpbnRvIGRybV9jZ3JvdXAgZnVuY3Rpb25zDQoN
ClNpZ25lZC1vZmYtYnk6IEhhcmlzaCBLYXNpdmlzd2FuYXRoYW4gPEhhcmlzaC5LYXNpdmlzd2Fu
YXRoYW5AYW1kLmNvbT4NClJldmlld2VkLWJ5OiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9hbWRr
ZmQuYyB8IDIgKy0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgg
fCAxICsNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlLmMgICAgfCAyICsr
DQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3ByaXYuaCAgICAgIHwgMyArKysNCiA0
IGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQppbmRleCA5ODMyNmUzYjU2MTku
LmRmOTJlYjY1YTg5NyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jDQpAQCAtMTkzLDcgKzE5Myw3IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikNCiAJCQkJCWFkZXYtPmRvb3JiZWxsX2luZGV4
Lmxhc3Rfbm9uX2NwOw0KIAkJfQ0KIA0KLQkJa2dkMmtmZF9kZXZpY2VfaW5pdChhZGV2LT5rZmQu
ZGV2LCAmZ3B1X3Jlc291cmNlcyk7DQorCQlrZ2Qya2ZkX2RldmljZV9pbml0KGFkZXYtPmtmZC5k
ZXYsIGFkZXYtPmRkZXYsICZncHVfcmVzb3VyY2VzKTsNCiAJfQ0KIH0NCiANCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmggYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmgNCmluZGV4IGY1N2YyOTc2Mzc2OS4uYmFk
Mzc4NTk2ZjQ2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2FtZGtmZC5oDQorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
LmgNCkBAIC0yMzQsNiArMjM0LDcgQEAgdm9pZCBrZ2Qya2ZkX2V4aXQodm9pZCk7DQogc3RydWN0
IGtmZF9kZXYgKmtnZDJrZmRfcHJvYmUoc3RydWN0IGtnZF9kZXYgKmtnZCwgc3RydWN0IHBjaV9k
ZXYgKnBkZXYsDQogCQkJICAgICAgY29uc3Qgc3RydWN0IGtmZDJrZ2RfY2FsbHMgKmYyZyk7DQog
Ym9vbCBrZ2Qya2ZkX2RldmljZV9pbml0KHN0cnVjdCBrZmRfZGV2ICprZmQsDQorCQkJIHN0cnVj
dCBkcm1fZGV2aWNlICpkZGV2LA0KIAkJCSBjb25zdCBzdHJ1Y3Qga2dkMmtmZF9zaGFyZWRfcmVz
b3VyY2VzICpncHVfcmVzb3VyY2VzKTsNCiB2b2lkIGtnZDJrZmRfZGV2aWNlX2V4aXQoc3RydWN0
IGtmZF9kZXYgKmtmZCk7DQogdm9pZCBrZ2Qya2ZkX3N1c3BlbmQoc3RydWN0IGtmZF9kZXYgKmtm
ZCk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5j
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQppbmRleCA3YjRlYTI0
Yzg3ZjguLmFiYzI4Yjk2YzQ5MSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZS5jDQpAQCAtNTI3LDEwICs1MjcsMTIgQEAgc3RhdGljIHZvaWQga2ZkX2N3c3JfaW5pdChz
dHJ1Y3Qga2ZkX2RldiAqa2ZkKQ0KIH0NCiANCiBib29sIGtnZDJrZmRfZGV2aWNlX2luaXQoc3Ry
dWN0IGtmZF9kZXYgKmtmZCwNCisJCQkgc3RydWN0IGRybV9kZXZpY2UgKmRkZXYsDQogCQkJIGNv
bnN0IHN0cnVjdCBrZ2Qya2ZkX3NoYXJlZF9yZXNvdXJjZXMgKmdwdV9yZXNvdXJjZXMpDQogew0K
IAl1bnNpZ25lZCBpbnQgc2l6ZTsNCiANCisJa2ZkLT5kZGV2ID0gZGRldjsNCiAJa2ZkLT5tZWNf
ZndfdmVyc2lvbiA9IGFtZGdwdV9hbWRrZmRfZ2V0X2Z3X3ZlcnNpb24oa2ZkLT5rZ2QsDQogCQkJ
S0dEX0VOR0lORV9NRUMxKTsNCiAJa2ZkLT5zZG1hX2Z3X3ZlcnNpb24gPSBhbWRncHVfYW1ka2Zk
X2dldF9md192ZXJzaW9uKGtmZC0+a2dkLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJp
di5oDQppbmRleCA4ZjAyZDc4MTcxNjIuLmNiYmEwMDQ3MDUyZCAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9wcml2LmgNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcml2LmgNCkBAIC00Niw2ICs0Niw4IEBADQogLyogR1BVIElEIGhhc2gg
d2lkdGggaW4gYml0cyAqLw0KICNkZWZpbmUgS0ZEX0dQVV9JRF9IQVNIX1dJRFRIIDE2DQogDQor
c3RydWN0IGRybV9kZXZpY2U7DQorDQogLyogVXNlIHVwcGVyIGJpdHMgb2YgbW1hcCBvZmZzZXQg
dG8gc3RvcmUgS0ZEIGRyaXZlciBzcGVjaWZpYyBpbmZvcm1hdGlvbi4NCiAgKiBCSVRTWzYzOjYy
XSAtIEVuY29kZSBNTUFQIHR5cGUNCiAgKiBCSVRTWzYxOjQ2XSAtIEVuY29kZSBncHVfaWQuIFRv
IGlkZW50aWZ5IHRvIHdoaWNoIEdQVSB0aGUgb2Zmc2V0IGJlbG9uZ3MgdG8NCkBAIC0yMTEsNiAr
MjEzLDcgQEAgc3RydWN0IGtmZF9kZXYgew0KIA0KIAljb25zdCBzdHJ1Y3Qga2ZkX2RldmljZV9p
bmZvICpkZXZpY2VfaW5mbzsNCiAJc3RydWN0IHBjaV9kZXYgKnBkZXY7DQorCXN0cnVjdCBkcm1f
ZGV2aWNlICpkZGV2Ow0KIA0KIAl1bnNpZ25lZCBpbnQgaWQ7CQkvKiB0b3BvbG9neSBzdHViIGlu
ZGV4ICovDQogDQotLSANCjIuMTcuMQ0KDQo=
