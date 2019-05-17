Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7BE21B3F
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2019 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfEQQOz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 May 2019 12:14:55 -0400
Received: from mail-eopbgr740083.outbound.protection.outlook.com ([40.107.74.83]:48832
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729437AbfEQQOz (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 17 May 2019 12:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Thj+cvFIs4NnaOZQ9n0cwQAeLDftZs2Ttgm5BrBP89Q=;
 b=iWEqlqVa6afoeydadjgGEAXATMPjST3AR06qxeFv0zoH8mQ+7vsuOYWyxXASQAjg5ZhLjg6yH1p+IA2WWEMFLljbov120v7a97Q17gOY9PvzBhW6MWgtALP/EZJS5Ygc2TKovN8b4JA8IJVKpmn5ul3oDFmgcK1vcOGFJFnDzYY=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB2823.namprd12.prod.outlook.com (20.177.229.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Fri, 17 May 2019 16:14:52 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Fri, 17 May 2019
 16:14:52 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device cgroup.
Thread-Topic: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device
 cgroup.
Thread-Index: AQHVDMuol86WSWX8+kyraEU0ra1TfA==
Date:   Fri, 17 May 2019 16:14:52 +0000
Message-ID: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: 2d4e8f52-efb1-4b89-3e0a-08d6dae2cab8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB2823;
x-ms-traffictypediagnostic: BYAPR12MB2823:
x-microsoft-antispam-prvs: <BYAPR12MB282305E14E62AE6A117E59988C0B0@BYAPR12MB2823.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0040126723
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(136003)(376002)(366004)(189003)(199004)(25786009)(53936002)(4326008)(3846002)(6116002)(478600001)(7736002)(81156014)(305945005)(2906002)(14454004)(99286004)(6512007)(2501003)(73956011)(68736007)(66476007)(8676002)(66556008)(64756008)(71200400001)(71190400001)(66446008)(8936002)(26005)(186003)(66946007)(81166006)(6506007)(36756003)(72206003)(5660300002)(110136005)(50226002)(66066001)(86362001)(102836004)(256004)(1076003)(14444005)(386003)(6436002)(316002)(6486002)(476003)(486006)(52116002)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2823;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: WwIIuGOM3fCcVOSbHxgBYmrotowBK8phVyd7FhSV6UF8mKWzda4/UfhDiHKiWeR7Cw0uo8YfQ/thg2wQQcK6zT231wE1+uGt5RfDDymbgXslIC+v3TtgPeCKasPy4mR7ZaEyLvoKUsWaZyfwzHtlGTTp/nURFPrYwIyGl7VE2JWEmHdmmX+hVMP74BlO2VB5l6NJvNPxO3GoPfRfxV9cYk1J9oJnRFoVbKihmmL+HVXdzDUl+7WWGArEcB7R++b/F5fiAWKj/7JGSraQw66+fzTRuUTLP7i/cdXKNBU9kqoudS2MXZZLbkN21TxjmYQ9bRb4WQIGbvu5bk1pFgadar/bD45CCESIAi5FD/+kuCADdNWNwd9PBpOpDHa3wK6OCN24nNqO48SP28vx+XbGrjabB75REOmG+RC2AKHU2a8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d4e8f52-efb1-4b89-3e0a-08d6dae2cab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2019 16:14:52.2567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2823
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

YW1ka2ZkIChwYXJ0IG9mIGFtZGdwdSkgZHJpdmVyIHN1cHBvcnRzIHRoZSBBTUQgR1BVIGNvbXB1
dGUgc3RhY2suDQphbWRrZmQgZXhwb3NlcyBvbmx5IGEgc2luZ2xlIGRldmljZSAvZGV2L2tmZCBl
dmVuIGlmIG11bHRpcGxlIEFNRCBHUFUNCihjb21wdXRlKSBkZXZpY2VzIGV4aXN0IGluIGEgc3lz
dGVtLiBIb3dldmVyLCBhbWRncHUgZHJ2aWVyIGV4cG9zZXMgYQ0Kc2VwYXJhdGUgcmVuZGVyIGRl
dmljZSBmaWxlIC9kZXYvZHJpL3JlbmRlckROIGZvciBlYWNoIGRldmljZS4gVG8gcGFydGljaXBh
dGUNCmluIGRldmljZSBjZ3JvdXAgYW1ka2ZkIGRyaXZlciB3aWxsIHJlbHkgb24gdGhlc2UgcmVk
bmVyIGRldmljZSBmaWxlcy4NCg0KdjI6IEV4cG9ydGluZyBkZXZjZ3JvdXBfY2hlY2tfcGVybWlz
c2lvbigpIGluc3RlYWQgb2YNCl9fZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24oKSBhcyBwZXIg
cmV2aWV3IGNvbW1lbnRzLg0KDQpIYXJpc2ggS2FzaXZpc3dhbmF0aGFuICg0KToNCiAgZHJtL2Ft
ZGtmZDogU3RvcmUga2ZkX2RldiBpbiBpb2xpbmsgYW5kIGNhY2hlIHByb3BlcnRpZXMNCiAgZHJt
L2FtZDogUGFzcyBkcm1fZGV2aWNlIHRvIGtmZA0KICBkZXZpY2VfY2dyb3VwOiBFeHBvcnQgZGV2
Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24NCiAgZHJtL2FtZGtmZDogQ2hlY2sgYWdhaW5zdCBkZXZp
Y2UgY2dyb3VwDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2ZkLmMg
ICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5oICAg
fCAgMSArDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgICAgfCAg
MiArKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9mbGF0X21lbW9yeS5jIHwgIDkg
KysrKysrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAgICB8
IDIwICsrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF90
b3BvbG9neS5jICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaCAgICB8ICAzICsrKw0KIGluY2x1ZGUvbGludXgvZGV2
aWNlX2Nncm91cC5oICAgICAgICAgICAgICAgIHwgMTkgKysrKy0tLS0tLS0tLS0tLS0NCiBzZWN1
cml0eS9kZXZpY2VfY2dyb3VwLmMgICAgICAgICAgICAgICAgICAgICB8IDE1ICsrKysrKysrKysr
LS0NCiA5IGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0K
DQotLSANCjIuMTcuMQ0KDQo=
