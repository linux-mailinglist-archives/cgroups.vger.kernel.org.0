Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA66109B6
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfEAO72 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:59:28 -0400
Received: from mail-eopbgr740042.outbound.protection.outlook.com ([40.107.74.42]:31060
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726842AbfEAO72 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLF8gMwxDUpNKlwJO1TBJ+EgR0Mj6xltYAxbhQafsh0=;
 b=gf8xoJA8kKuUc9nsJQpOFYXoDMoG6i8VdLK5tAPCWnAoUQZodUPcLqDsibNbv84rbCATRNzFmpBgMVVtsO5lBy75DV5PO45VGbpS/Kt2anz+XKjSDDN4V7ggk5fkwRKcJq7J/FXdWMJhlGVBe8LqfYdjWShBuG/UJal2f4yKies=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Wed, 1 May 2019 14:59:26 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a%4]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 14:59:26 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 2/4] drm/amd: Pass drm_device to kfd
Thread-Topic: [PATCH 2/4] drm/amd: Pass drm_device to kfd
Thread-Index: AQHVAC54C4Lw1Kb8rUGHx6y6gvFv+A==
Date:   Wed, 1 May 2019 14:59:25 +0000
Message-ID: <20190501145904.27505-3-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: 60f84dab-55df-40a8-1959-08d6ce459a5b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3398;
x-ms-traffictypediagnostic: BYAPR12MB3398:
x-microsoft-antispam-prvs: <BYAPR12MB33986F5F8DE9B67D4B2A81348C3B0@BYAPR12MB3398.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(102836004)(66556008)(66446008)(66476007)(73956011)(7736002)(64756008)(386003)(71200400001)(71190400001)(76176011)(186003)(8936002)(6506007)(305945005)(36756003)(66946007)(11346002)(446003)(14444005)(256004)(6512007)(68736007)(486006)(476003)(2616005)(86362001)(6486002)(72206003)(14454004)(6436002)(52116002)(110136005)(5660300002)(53936002)(99286004)(2501003)(50226002)(66066001)(478600001)(3846002)(2906002)(6116002)(4326008)(1076003)(81166006)(8676002)(81156014)(26005)(316002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3398;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: abYwgun5vw/JqNero69KmD4m+1mErC+o0M3WfZZNKtB2k08AZUKyiTBg41eD4FYvn3746cf7yBVmzqmVfCjSTqvYIZ23rc2iT1s1MzJCFWn/V+jmbNcmWRcsMvdQlK2PbEI4obrMWUocMrLerHPazrYkKfHCHQzP6d5JiQPKld630J+Z7ytNviNQM0XSzOBvx7VUH+K5Jl3EPZpMwO6FgroYHEEk0O/lOr4Fy+4zU1pL4TvOpjVbtjQa5rfoIXIP9Vis9cw0pEY+wzHpKT9tz7o0oQ15edBIcBehNxQHr0Ay1B+FtSQEaDsrfaOSOQNmV0Qhp9bXf4q6vFo+TV3ou5H/dL0du01+jOsz0fWrh3RLsOQKTscvyKfox28U+PXx1YLdSiL8UzIoEjZReLLB/edzuNGF/mzcpGeixMMYNjs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f84dab-55df-40a8-1959-08d6ce459a5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 14:59:26.0022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3398
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
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5jDQppbmRleCA4OTQ5YjFhYzJmMTgu
Ljk0MzMzMTJmNzg5YyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9hbWRrZmQuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Ft
ZGtmZC5jDQpAQCAtMTkwLDcgKzE5MCw3IEBAIHZvaWQgYW1kZ3B1X2FtZGtmZF9kZXZpY2VfaW5p
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
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jDQppbmRleCBhNTNkZGE5
MDcxYjEuLjdmNWQ2MjcxOWU0MCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
a2ZkL2tmZF9kZXZpY2UuYw0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2Rl
dmljZS5jDQpAQCAtNTI2LDEwICs1MjYsMTIgQEAgc3RhdGljIHZvaWQga2ZkX2N3c3JfaW5pdChz
dHJ1Y3Qga2ZkX2RldiAqa2ZkKQ0KIH0NCiANCiBib29sIGtnZDJrZmRfZGV2aWNlX2luaXQoc3Ry
dWN0IGtmZF9kZXYgKmtmZCwNCisJCQkgc3RydWN0IGRybV9kZXZpY2UgKmRkZXYsDQogCQkJIGNv
bnN0IHN0cnVjdCBrZ2Qya2ZkX3NoYXJlZF9yZXNvdXJjZXMgKmdwdV9yZXNvdXJjZXMpDQogew0K
IAl1bnNpZ25lZCBpbnQgc2l6ZTsNCiANCisJa2ZkLT5kZGV2ID0gZGRldjsNCiAJa2ZkLT5tZWNf
ZndfdmVyc2lvbiA9IGFtZGdwdV9hbWRrZmRfZ2V0X2Z3X3ZlcnNpb24oa2ZkLT5rZ2QsDQogCQkJ
S0dEX0VOR0lORV9NRUMxKTsNCiAJa2ZkLT5zZG1hX2Z3X3ZlcnNpb24gPSBhbWRncHVfYW1ka2Zk
X2dldF9md192ZXJzaW9uKGtmZC0+a2dkLA0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1ka2ZkL2tmZF9wcml2LmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJp
di5oDQppbmRleCBjODkyNWI3YjZjNDYuLjdjYWY0ZmEzZDM2NiAxMDA2NDQNCi0tLSBhL2RyaXZl
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
