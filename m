Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38FB21B44
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfEQQPJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 12:15:09 -0400
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:29696
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729369AbfEQQPJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 12:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03sZXWj8M9i32ILVVECiKszUYO3cXuVRIzYtddi6zW0=;
 b=DtCKccUGpp+Tq5Fhnujq1wcIRrwErdnvvJAoW+cfxyT7UlmGV/HqC/mSsK+vjbbxN0aW37z3fr81sI/wRkCJaAh6viBT884Z8J+O2n4J6YgRSqAV/nn81fjcXoLTA4oK6QSD1XUTeJVwO2jqWmuIW9Q+vb/ISbYL/5wjc/ZmDdY=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB2823.namprd12.prod.outlook.com (20.177.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 16:15:06 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Fri, 17 May 2019
 16:15:06 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Topic: [PATCH v2 3/4] device_cgroup: Export devcgroup_check_permission
Thread-Index: AQHVDMuwlGxX/j2JnUSoSESRdhEwJQ==
Date:   Fri, 17 May 2019 16:15:06 +0000
Message-ID: <20190517161435.14121-4-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: 62baa453-6c69-4c29-6e0c-08d6dae2d312
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB2823;
x-ms-traffictypediagnostic: BYAPR12MB2823:
x-microsoft-antispam-prvs: <BYAPR12MB282377ED25948768E5B7D3D28C0B0@BYAPR12MB2823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(25786009)(53936002)(4326008)(3846002)(6116002)(478600001)(7736002)(81156014)(305945005)(446003)(2906002)(14454004)(99286004)(6512007)(2501003)(73956011)(68736007)(66476007)(8676002)(66556008)(64756008)(71200400001)(71190400001)(66446008)(8936002)(26005)(186003)(66946007)(81166006)(6506007)(36756003)(72206003)(5660300002)(110136005)(50226002)(66066001)(86362001)(76176011)(102836004)(256004)(1076003)(14444005)(386003)(6436002)(11346002)(316002)(6486002)(476003)(486006)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2823;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +rW6CscHxjPXye3nmUk60Qs6+iypExFdEZkS2m15ApFICJBPVAmeRxJbDjn5040Jeut7kANEyYykUhBm2oO0Ma6p6VYFZ4g1D9tzmEvqlrLlmYdP2VDwM4P7DRZ2eJ+qKh8uF+PCmS4HWQ90tlrMCVmNNxw3OM1LaJoGvLL26DfXer1ILXl2W9L6+SkLPn5AqRh0igIGZgMCt6MCA0jXq8a7YTOcnXi6j9A9E92btVDq7vgLP/6bcvZ04yqwAkYBRkTnepBzWsCEOtop9V3diw0LTjXTMtvd3+4rUBALW3qwoHksh9YzLXyTVF43TIo/PKSMnbei0xc0+UFxYgTRC+k0TbcwUzS/++t3f90EaPM1o7PtluYMzboXdKebXyoL2yuw1FNGiTjSVu0+uH05ud3ScWCt4t+Wq9sM1LvzC0I=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62baa453-6c69-4c29-6e0c-08d6dae2d312
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:15:06.1446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Rm9yIEFNRCBjb21wdXRlIChhbWRrZmQpIGRyaXZlci4NCg0KQWxsIEFNRCBjb21wdXRlIGRldmlj
ZXMgYXJlIGV4cG9ydGVkIHZpYSBzaW5nbGUgZGV2aWNlIG5vZGUgL2Rldi9rZmQuIEFzDQphIHJl
c3VsdCBkZXZpY2VzIGNhbm5vdCBiZSBjb250cm9sbGVkIGluZGl2aWR1YWxseSB1c2luZyBkZXZp
Y2UgY2dyb3VwLg0KDQpBTUQgY29tcHV0ZSBkZXZpY2VzIHdpbGwgcmVseSBvbiBpdHMgZ3JhcGhp
Y3MgY291bnRlcnBhcnQgdGhhdCBleHBvc2VzDQovZGV2L2RyaS9yZW5kZXJOIG5vZGUgZm9yIGVh
Y2ggZGV2aWNlLiBGb3IgZWFjaCB0YXNrIChiYXNlZCBvbiBpdHMNCmNncm91cCksIEtGRCBkcml2
ZXIgd2lsbCBjaGVjayBpZiAvZGV2L2RyaS9yZW5kZXJOIG5vZGUgaXMgYWNjZXNzaWJsZQ0KYmVm
b3JlIGV4cG9zaW5nIGl0Lg0KDQpDaGFuZ2UtSWQ6IEkxYjk3MDViMmMzMDYyMmEyNzY1NWY0Zjg3
ODk4MGZhMTM4ZGJmMzczDQpTaWduZWQtb2ZmLWJ5OiBIYXJpc2ggS2FzaXZpc3dhbmF0aGFuIDxI
YXJpc2guS2FzaXZpc3dhbmF0aGFuQGFtZC5jb20+DQotLS0NCiBpbmNsdWRlL2xpbnV4L2Rldmlj
ZV9jZ3JvdXAuaCB8IDE5ICsrKystLS0tLS0tLS0tLS0tLS0NCiBzZWN1cml0eS9kZXZpY2VfY2dy
b3VwLmMgICAgICB8IDE1ICsrKysrKysrKysrKystLQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5z
ZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RldmljZV9jZ3JvdXAuaCBiL2luY2x1ZGUvbGludXgvZGV2aWNlX2Nncm91cC5oDQppbmRleCA4
NTU3ZWZlMDk2ZGMuLmJkMTk4OTdiZDU4MiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvZGV2
aWNlX2Nncm91cC5oDQorKysgYi9pbmNsdWRlL2xpbnV4L2RldmljZV9jZ3JvdXAuaA0KQEAgLTEy
LDI2ICsxMiwxNSBAQA0KICNkZWZpbmUgREVWQ0dfREVWX0FMTCAgIDQgIC8qIHRoaXMgcmVwcmVz
ZW50cyBhbGwgZGV2aWNlcyAqLw0KIA0KICNpZmRlZiBDT05GSUdfQ0dST1VQX0RFVklDRQ0KLWV4
dGVybiBpbnQgX19kZXZjZ3JvdXBfY2hlY2tfcGVybWlzc2lvbihzaG9ydCB0eXBlLCB1MzIgbWFq
b3IsIHUzMiBtaW5vciwNCi0JCQkJCXNob3J0IGFjY2Vzcyk7DQorZXh0ZXJuIGludCBkZXZjZ3Jv
dXBfY2hlY2tfcGVybWlzc2lvbihzaG9ydCB0eXBlLCB1MzIgbWFqb3IsIHUzMiBtaW5vciwNCisJ
CQkJICAgICAgc2hvcnQgYWNjZXNzKTsNCiAjZWxzZQ0KLXN0YXRpYyBpbmxpbmUgaW50IF9fZGV2
Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oc2hvcnQgdHlwZSwgdTMyIG1ham9yLCB1MzIgbWlub3Is
DQotCQkJCQkgICAgICAgc2hvcnQgYWNjZXNzKQ0KK3N0YXRpYyBpbmxpbmUgaW50IGRldmNncm91
cF9jaGVja19wZXJtaXNzaW9uKHNob3J0IHR5cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9yLA0KKwkJ
CQkJICAgICBzaG9ydCBhY2Nlc3MpDQogeyByZXR1cm4gMDsgfQ0KICNlbmRpZg0KIA0KICNpZiBk
ZWZpbmVkKENPTkZJR19DR1JPVVBfREVWSUNFKSB8fCBkZWZpbmVkKENPTkZJR19DR1JPVVBfQlBG
KQ0KLXN0YXRpYyBpbmxpbmUgaW50IGRldmNncm91cF9jaGVja19wZXJtaXNzaW9uKHNob3J0IHR5
cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9yLA0KLQkJCQkJICAgICBzaG9ydCBhY2Nlc3MpDQotew0K
LQlpbnQgcmMgPSBCUEZfQ0dST1VQX1JVTl9QUk9HX0RFVklDRV9DR1JPVVAodHlwZSwgbWFqb3Is
IG1pbm9yLCBhY2Nlc3MpOw0KLQ0KLQlpZiAocmMpDQotCQlyZXR1cm4gLUVQRVJNOw0KLQ0KLQly
ZXR1cm4gX19kZXZjZ3JvdXBfY2hlY2tfcGVybWlzc2lvbih0eXBlLCBtYWpvciwgbWlub3IsIGFj
Y2Vzcyk7DQotfQ0KLQ0KIHN0YXRpYyBpbmxpbmUgaW50IGRldmNncm91cF9pbm9kZV9wZXJtaXNz
aW9uKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGludCBtYXNrKQ0KIHsNCiAJc2hvcnQgdHlwZSwgYWNj
ZXNzID0gMDsNCmRpZmYgLS1naXQgYS9zZWN1cml0eS9kZXZpY2VfY2dyb3VwLmMgYi9zZWN1cml0
eS9kZXZpY2VfY2dyb3VwLmMNCmluZGV4IGNkOTc5MjlmYWM2Ni4uM2M1N2UwNWJmNzNiIDEwMDY0
NA0KLS0tIGEvc2VjdXJpdHkvZGV2aWNlX2Nncm91cC5jDQorKysgYi9zZWN1cml0eS9kZXZpY2Vf
Y2dyb3VwLmMNCkBAIC04MDEsOCArODAxLDggQEAgc3RydWN0IGNncm91cF9zdWJzeXMgZGV2aWNl
c19jZ3JwX3N1YnN5cyA9IHsNCiAgKg0KICAqIHJldHVybnMgMCBvbiBzdWNjZXNzLCAtRVBFUk0g
Y2FzZSB0aGUgb3BlcmF0aW9uIGlzIG5vdCBwZXJtaXR0ZWQNCiAgKi8NCi1pbnQgX19kZXZjZ3Jv
dXBfY2hlY2tfcGVybWlzc2lvbihzaG9ydCB0eXBlLCB1MzIgbWFqb3IsIHUzMiBtaW5vciwNCi0J
CQkJIHNob3J0IGFjY2VzcykNCitzdGF0aWMgaW50IF9fZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Np
b24oc2hvcnQgdHlwZSwgdTMyIG1ham9yLCB1MzIgbWlub3IsDQorCQkJCQlzaG9ydCBhY2Nlc3Mp
DQogew0KIAlzdHJ1Y3QgZGV2X2Nncm91cCAqZGV2X2Nncm91cDsNCiAJYm9vbCByYzsNCkBAIC04
MjQsMyArODI0LDE0IEBAIGludCBfX2RldmNncm91cF9jaGVja19wZXJtaXNzaW9uKHNob3J0IHR5
cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9yLA0KIA0KIAlyZXR1cm4gMDsNCiB9DQorDQoraW50IGRl
dmNncm91cF9jaGVja19wZXJtaXNzaW9uKHNob3J0IHR5cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9y
LCBzaG9ydCBhY2Nlc3MpDQorew0KKwlpbnQgcmMgPSBCUEZfQ0dST1VQX1JVTl9QUk9HX0RFVklD
RV9DR1JPVVAodHlwZSwgbWFqb3IsIG1pbm9yLCBhY2Nlc3MpOw0KKw0KKwlpZiAocmMpDQorCQly
ZXR1cm4gLUVQRVJNOw0KKw0KKwlyZXR1cm4gX19kZXZjZ3JvdXBfY2hlY2tfcGVybWlzc2lvbih0
eXBlLCBtYWpvciwgbWlub3IsIGFjY2Vzcyk7DQorfQ0KK0VYUE9SVF9TWU1CT0woZGV2Y2dyb3Vw
X2NoZWNrX3Blcm1pc3Npb24pOw0KLS0gDQoyLjE3LjENCg0K
