Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29AF8109B3
	for <lists+cgroups@lfdr.de>; Wed,  1 May 2019 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfEAO7Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 May 2019 10:59:24 -0400
Received: from mail-eopbgr820045.outbound.protection.outlook.com ([40.107.82.45]:34496
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfEAO7X (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 1 May 2019 10:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu7yXynnbn64/JHBjYRJffGIJ85vxavJ8+hMR4oGLdg=;
 b=xUp2IZTDqHMw1IJXotJzA9ExrsbCQ/bHLcN8QiAmrgDOc7pSIAJsvRW835fpwKLiAVsVnQtcuc8+iEDanYQ/MYeF3XDGcFipyDszuRT2qeFqJhkQ7rCHIVa96EHKIt6bCHmpEBTbAf0O7WezyXh6Xqv2eGf6Reur1RQx9qGP1Yc=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3525.namprd12.prod.outlook.com (20.179.94.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Wed, 1 May 2019 14:59:21 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::7496:be8b:650:d66a%4]) with mapi id 15.20.1835.018; Wed, 1 May 2019
 14:59:21 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH 0/4] AMDKFD (AMD GPU compute) support for device cgroup.
Thread-Topic: [PATCH 0/4] AMDKFD (AMD GPU compute) support for device cgroup.
Thread-Index: AQHVAC51igvNBcs4pE2jTJvFXPXmtw==
Date:   Wed, 1 May 2019 14:59:21 +0000
Message-ID: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
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
x-ms-office365-filtering-correlation-id: 5e68c156-80fc-4a91-7d5d-08d6ce4597a4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3525;
x-ms-traffictypediagnostic: BYAPR12MB3525:
x-microsoft-antispam-prvs: <BYAPR12MB3525F66449E7171C342B918C8C3B0@BYAPR12MB3525.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 00246AB517
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(316002)(25786009)(68736007)(4326008)(86362001)(7736002)(2906002)(110136005)(52116002)(2501003)(36756003)(6512007)(3846002)(6116002)(99286004)(53936002)(186003)(8676002)(14444005)(256004)(66946007)(102836004)(50226002)(14454004)(66066001)(73956011)(478600001)(66556008)(72206003)(71190400001)(81156014)(81166006)(2616005)(66476007)(64756008)(71200400001)(476003)(305945005)(26005)(386003)(486006)(6486002)(8936002)(6436002)(6506007)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3525;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uLjQESMACGI4stCF/w7wWTgSXLeDU+K7FWyQf1aLs5Ut1ejaKKFwI6L3MCyDT0eOxGJuhNyCej7wg+h57LARNmk2mR15UKNC1L3Iz63a4rKRwir873uhC257/+d6VzOvCJAz4C9WTXDehHf15WqbtvtL7aixcwzr3qZZXZV7sLG++le7kCMSpHLRa+0yyrUNlsDrL7ZiUtK0CqowZRmsK49eM7C1FaxXygDvjgJfa3VdJtw3xmsPMFTxAXHd9A9RXsqmd5DfvIuC2V0apTqGQW3rkeescf0kF2yD7eP4YT4F1Qi2W6nrWqF45CB0bfHlSgpLmUlfvDk1NxgPtPN2fYKylvQAsPpuFAaX4wAZyVyvbMjn5Ug0gTCn5W0ChAg6+02s4jDk7obnWsguMPJdMleMBDVq1ZQW4Ts34ueevYQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e68c156-80fc-4a91-7d5d-08d6ce4597a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2019 14:59:21.5311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
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
bmVyIGRldmljZSBmaWxlcy4NCg0KSGFyaXNoIEthc2l2aXN3YW5hdGhhbiAoNCk6DQogIGRybS9h
bWRrZmQ6IFN0b3JlIGtmZF9kZXYgaW4gaW9saW5rIGFuZCBjYWNoZSBwcm9wZXJ0aWVzDQogIGRy
bS9hbWQ6IFBhc3MgZHJtX2RldmljZSB0byBrZmQNCiAgZGV2aWNlX2Nncm91cDogRXhwb3J0IF9f
ZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24NCiAgZHJtL2FtZGtmZDogQ2hlY2sgYWdhaW5zdCBk
ZXZpY2UgY2dyb3VwDQoNCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfYW1ka2Zk
LmMgICB8ICAyICstDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2FtZGtmZC5o
ICAgfCAgMSArDQogZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZS5jICAgICAg
fCAgMiArKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tmZF9mbGF0X21lbW9yeS5jIHwg
IDkgKysrKysrLS0NCiBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfcHJpdi5oICAgICAg
ICB8IDIwICsrKysrKysrKysrKysrKysrKw0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1ka2ZkL2tm
ZF90b3BvbG9neS5jICAgIHwgMjIgKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGtmZC9rZmRfdG9wb2xvZ3kuaCAgICB8ICAzICsrKw0KIHNlY3VyaXR5L2Rldmlj
ZV9jZ3JvdXAuYyAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KIDggZmlsZXMgY2hhbmdlZCwg
NTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg0K
