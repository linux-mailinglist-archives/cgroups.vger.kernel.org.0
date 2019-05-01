Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E713109B5
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfEAO71 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:59:27 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:31060
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfEAO70 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:59:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0xB8lfMpn4f7kJGZYyvrbXUgHaMcQDln6nHtvTKDJY=;
 b=yi4dQnOZWY8zqwtRot3RKMivPvbHP1dsHL2AdaJNALiURF6yg3PFez5NTS7v9HNMePvTVZD/qKIColwR1NMN8/na0TnmjXH7bi25IesQsBxCEcc7rWyAH9egsTvaE7wEnN/mzs0kt3GlW85Rr/xCcg+AGSDpcTz3Se/BcJYO2oc=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 1 May 2019 14:59:24 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a%4]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 14:59:24 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 1/4] drm/amdkfd: Store kfd_dev in iolink and cache properties
Thread-Topic: [PATCH 1/4] drm/amdkfd: Store kfd_dev in iolink and cache
 properties
Thread-Index: AQHVAC52aj0uhquLKkuo9CjPmEDDZw==
Date:   Wed, 1 May 2019 14:59:24 +0000
Message-ID: <20190501145904.27505-2-Harish.Kasiviswanathan@amd.com>
References: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YQBPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::37) To BYAPR12MB3384.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 926cbf45-e6e4-4fb8-dd55-08d6ce45993d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3398;
x-ms-traffictypediagnostic: BYAPR12MB3398:
x-microsoft-antispam-prvs: <BYAPR12MB3398F563EC79F515A2B67F718C3B0@BYAPR12MB3398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(102836004)(66556008)(66446008)(66476007)(73956011)(7736002)(64756008)(386003)(71200400001)(71190400001)(76176011)(186003)(8936002)(6506007)(305945005)(36756003)(66946007)(11346002)(446003)(14444005)(256004)(6512007)(68736007)(486006)(476003)(2616005)(86362001)(6486002)(72206003)(14454004)(6436002)(52116002)(110136005)(5660300002)(53936002)(99286004)(2501003)(50226002)(66066001)(478600001)(3846002)(2906002)(6116002)(4326008)(1076003)(81166006)(8676002)(81156014)(26005)(316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3398;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PiIdj9LRE/gLXulpY3WF1XMBKMjH9vuUv5QAhIGYWs5QkGOtMb0viiP2Rqk/ucszYhxx9ZX6d4m+Kx9I7qygQVd2q77X87DZ9rYA/Fk+U1dVsTpxBTkZtHMBrsfpzyrUtx8wIW7ZuIpp2UbbgKfOK6fwLAFHNoAWaXktRIvorAo+m1kYSnllXSC3RYk7TAEYpEJembjDDpwtZe8GR5+ykIJlhQ9BL78qubI9zF90EaoA8+2b9D+AdkIPRlvtjO10SOH/22PTtVyJdRdEE/0RFPItSOFtN6Yx+9/HAO3zH+6U13yWYshMpqGvkTtrR3cHtpLXML1HeS4bf7qf6cwoh/H+BNT7UEcryTCvNl/dAdzQaEP6UDyp19Bd16Io39cldWUBtlMsYjDKtAQdewIAnoA5r5afX4v0nn3X4fi1VSo=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926cbf45-e6e4-4fb8-dd55-08d6ce45993d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 14:59:24.1239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

VGhpcyBpcyByZXF1aXJlZCB0byBjaGVjayBhZ2FpbnN0IGNncm91cCBwZXJtaXNzaW9ucy4NCg0K
U2lnbmVkLW9mZi1ieTogSGFyaXNoIEthc2l2aXN3YW5hdGhhbiA8SGFyaXNoLkthc2l2aXN3YW5h
dGhhbkBhbWQuY29tPg0KUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGlu
Z0BhbWQuY29tPg0KLS0tDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5
LmMgfCAxMCArKysrKysrKysrDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9s
b2d5LmggfCAgMyArKysNCiAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKykNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3BvbG9neS5jIGIvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmMNCmluZGV4IDJjMDZkNmMxNmVh
Yi4uNjRkNjY3YWUwZDM2IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90b3Bv
bG9neS5jDQpAQCAtMTEwNCw2ICsxMTA0LDkgQEAgc3RhdGljIHN0cnVjdCBrZmRfdG9wb2xvZ3lf
ZGV2aWNlICprZmRfYXNzaWduX2dwdShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQ0KIHsNCiAJc3RydWN0
IGtmZF90b3BvbG9neV9kZXZpY2UgKmRldjsNCiAJc3RydWN0IGtmZF90b3BvbG9neV9kZXZpY2Ug
Km91dF9kZXYgPSBOVUxMOw0KKwlzdHJ1Y3Qga2ZkX21lbV9wcm9wZXJ0aWVzICptZW07DQorCXN0
cnVjdCBrZmRfY2FjaGVfcHJvcGVydGllcyAqY2FjaGU7DQorCXN0cnVjdCBrZmRfaW9saW5rX3By
b3BlcnRpZXMgKmlvbGluazsNCiANCiAJZG93bl93cml0ZSgmdG9wb2xvZ3lfbG9jayk7DQogCWxp
c3RfZm9yX2VhY2hfZW50cnkoZGV2LCAmdG9wb2xvZ3lfZGV2aWNlX2xpc3QsIGxpc3QpIHsNCkBA
IC0xMTE3LDYgKzExMjAsMTMgQEAgc3RhdGljIHN0cnVjdCBrZmRfdG9wb2xvZ3lfZGV2aWNlICpr
ZmRfYXNzaWduX2dwdShzdHJ1Y3Qga2ZkX2RldiAqZ3B1KQ0KIAkJaWYgKCFkZXYtPmdwdSAmJiAo
ZGV2LT5ub2RlX3Byb3BzLnNpbWRfY291bnQgPiAwKSkgew0KIAkJCWRldi0+Z3B1ID0gZ3B1Ow0K
IAkJCW91dF9kZXYgPSBkZXY7DQorDQorCQkJbGlzdF9mb3JfZWFjaF9lbnRyeShtZW0sICZkZXYt
Pm1lbV9wcm9wcywgbGlzdCkNCisJCQkJbWVtLT5ncHUgPSBkZXYtPmdwdTsNCisJCQlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGNhY2hlLCAmZGV2LT5jYWNoZV9wcm9wcywgbGlzdCkNCisJCQkJY2FjaGUt
PmdwdSA9IGRldi0+Z3B1Ow0KKwkJCWxpc3RfZm9yX2VhY2hfZW50cnkoaW9saW5rLCAmZGV2LT5p
b19saW5rX3Byb3BzLCBsaXN0KQ0KKwkJCQlpb2xpbmstPmdwdSA9IGRldi0+Z3B1Ow0KIAkJCWJy
ZWFrOw0KIAkJfQ0KIAl9DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQv
a2ZkX3RvcG9sb2d5LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3ku
aA0KaW5kZXggOTQ5ZTg4NWRmYjUzLi41ZmQzZGY4MGJiMGUgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaA0KKysrIGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRrZmQva2ZkX3RvcG9sb2d5LmgNCkBAIC0xMDEsNiArMTAxLDcgQEAgc3RydWN0IGtm
ZF9tZW1fcHJvcGVydGllcyB7DQogCXVpbnQzMl90CQlmbGFnczsNCiAJdWludDMyX3QJCXdpZHRo
Ow0KIAl1aW50MzJfdAkJbWVtX2Nsa19tYXg7DQorCXN0cnVjdCBrZmRfZGV2CQkqZ3B1Ow0KIAlz
dHJ1Y3Qga29iamVjdAkJKmtvYmo7DQogCXN0cnVjdCBhdHRyaWJ1dGUJYXR0cjsNCiB9Ow0KQEAg
LTEyMiw2ICsxMjMsNyBAQCBzdHJ1Y3Qga2ZkX2NhY2hlX3Byb3BlcnRpZXMgew0KIAl1aW50MzJf
dAkJY2FjaGVfbGF0ZW5jeTsNCiAJdWludDMyX3QJCWNhY2hlX3R5cGU7DQogCXVpbnQ4X3QJCQlz
aWJsaW5nX21hcFtDUkFUX1NJQkxJTkdNQVBfU0laRV07DQorCXN0cnVjdCBrZmRfZGV2CQkqZ3B1
Ow0KIAlzdHJ1Y3Qga29iamVjdAkJKmtvYmo7DQogCXN0cnVjdCBhdHRyaWJ1dGUJYXR0cjsNCiB9
Ow0KQEAgLTE0MCw2ICsxNDIsNyBAQCBzdHJ1Y3Qga2ZkX2lvbGlua19wcm9wZXJ0aWVzIHsNCiAJ
dWludDMyX3QJCW1heF9iYW5kd2lkdGg7DQogCXVpbnQzMl90CQlyZWNfdHJhbnNmZXJfc2l6ZTsN
CiAJdWludDMyX3QJCWZsYWdzOw0KKwlzdHJ1Y3Qga2ZkX2RldgkJKmdwdTsNCiAJc3RydWN0IGtv
YmplY3QJCSprb2JqOw0KIAlzdHJ1Y3QgYXR0cmlidXRlCWF0dHI7DQogfTsNCi0tIA0KMi4xNy4x
DQoNCg==
