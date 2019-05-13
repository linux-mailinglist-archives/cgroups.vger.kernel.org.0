Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DAD1BF39
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 23:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfEMVra (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 17:47:30 -0400
Received: from mail-eopbgr760075.outbound.protection.outlook.com ([40.107.76.75]:23318
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726421AbfEMVr3 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 May 2019 17:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n2jSXKQ5UA+EIgCBJRtFSX/GCm/g42bVM0iOtlr+Qek=;
 b=jEPcS+OPE9ojRNS+8KLbHvVe2eeV8nC5PmdnR70MJ3a/9MGX4E5mjkWGeJWRmY3dUeQA+ls9E5ID1E37NGEff0kWDXy0pLNQ18Uw8H/TZNhBGGh+36fB0zUQy4Hr8jD0BFwT6Ij+9XLhPFMysgAZdZpV4l0f3KY811HxnAmNUKs=
Received: from BYAPR12MB3384.namprd12.prod.outlook.com (20.178.55.225) by
 BYAPR12MB3093.namprd12.prod.outlook.com (20.178.54.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Mon, 13 May 2019 21:47:27 +0000
Received: from BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513]) by BYAPR12MB3384.namprd12.prod.outlook.com
 ([fe80::94db:e1b3:e492:1513%6]) with mapi id 15.20.1878.024; Mon, 13 May 2019
 21:47:27 +0000
From:   "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To:     "aris@redhat.com" <aris@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>, "guro@fb.com" <guro@fb.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 3/4] device_cgroup: Export __devcgroup_check_permission
Thread-Topic: [PATCH 3/4] device_cgroup: Export __devcgroup_check_permission
Thread-Index: AQHVAC55ig/tjOJIrUisrubOK/T1G6ZpqokA
Date:   Mon, 13 May 2019 21:47:26 +0000
Message-ID: <2ceffd10-c3d0-86bb-b010-ed1eae655f85@amd.com>
References: <20190501145904.27505-1-Harish.Kasiviswanathan@amd.com>
 <20190501145904.27505-4-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20190501145904.27505-4-Harish.Kasiviswanathan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
x-originating-ip: [165.204.55.251]
x-clientproxiedby: YTXPR0101CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::19) To BYAPR12MB3384.namprd12.prod.outlook.com
 (2603:10b6:a03:a9::33)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Harish.Kasiviswanathan@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87d204fd-77ea-4d47-0ef5-08d6d7ec96fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BYAPR12MB3093;
x-ms-traffictypediagnostic: BYAPR12MB3093:
x-microsoft-antispam-prvs: <BYAPR12MB309398FB0E009981B544331F8C0F0@BYAPR12MB3093.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0036736630
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(366004)(136003)(189003)(199004)(53754006)(66556008)(64756008)(66446008)(25786009)(66476007)(71200400001)(66946007)(2906002)(71190400001)(73956011)(64126003)(478600001)(2616005)(11346002)(446003)(6486002)(486006)(99286004)(6436002)(476003)(72206003)(52116002)(76176011)(65806001)(66066001)(65956001)(6512007)(58126008)(110136005)(54906003)(102836004)(386003)(6506007)(53546011)(26005)(186003)(14454004)(229853002)(68736007)(305945005)(316002)(65826007)(7736002)(86362001)(31696002)(36756003)(2201001)(5660300002)(31686004)(14444005)(8936002)(256004)(81166006)(81156014)(53936002)(3846002)(6116002)(6246003)(8676002)(2501003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3093;H:BYAPR12MB3384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fSKl7aP0X4Rkhdzgl3pE/A7Fx+vhHFR0YDl5+0CdT3BaGkpOecoH3yw1ZzUdOsgDVuIqTR4ju4yaUBVcX+FTYuRlhTWLU5ZCCUsG4/vXEi37QVyguZmSk094XjIFCEyHkZCCSFBy/dQu+0w58qGaHomQXSQchWh8IZU9EFkhNXovKaFTu/FehZesKvplvFcHFKWQJxvS1Dgwxq7tjJVw9myRYfEJyvPgP1DBRE7qEUNEGG3cQwEBmPnP3E7JK7myixUbLdue2vUBdzbwXoeIFTpKJabitJL1bJvz048RVXNdfg+PXasgRJzTuiY8vs0fJQswwWjCMJLSAvVnx6TY0BrGRu41e7NtfGRxsLBpmWSEXns09x1AQ3xaFzNPDcji6fa3LfTSDwduRSMOuUTMPnd8E0+GJPb7IDONpFXbE9Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <242F64A8B4C32E4BB3A78FA5C525BC18@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d204fd-77ea-4d47-0ef5-08d6d7ec96fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2019 21:47:26.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3093
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGVsbG8gRXZlcnlvbmUsDQoNCkNvdWxkIHlvdSBwbGVhc2UgcmV2aWV3IHRoaXMgcGF0Y2g/DQoN
CkJlc3QgUmVnYXJkcywNCg0KSGFyaXNoDQoNCg0KDQpPbiAyMDE5LTA1LTAxIDEwOjU5IGEubS4s
IEthc2l2aXN3YW5hdGhhbiwgSGFyaXNoIHdyb3RlOg0KPiBGb3IgQU1EIGNvbXB1dGUgKGFtZGtm
ZCkgZHJpdmVyLg0KPg0KPiBBbGwgQU1EIGNvbXB1dGUgZGV2aWNlcyBhcmUgZXhwb3J0ZWQgdmlh
IHNpbmdsZSBkZXZpY2Ugbm9kZSAvZGV2L2tmZC4gQXMNCj4gYSByZXN1bHQgZGV2aWNlcyBjYW5u
b3QgYmUgY29udHJvbGxlZCBpbmRpdmlkdWFsbHkgdXNpbmcgZGV2aWNlIGNncm91cC4NCj4NCj4g
QU1EIGNvbXB1dGUgZGV2aWNlcyB3aWxsIHJlbHkgb24gaXRzIGdyYXBoaWNzIGNvdW50ZXJwYXJ0
IHRoYXQgZXhwb3Nlcw0KPiAvZGV2L2RyaS9yZW5kZXJOIG5vZGUgZm9yIGVhY2ggZGV2aWNlLiBG
b3IgZWFjaCB0YXNrIChiYXNlZCBvbiBpdHMNCj4gY2dyb3VwKSwgS0ZEIGRyaXZlciB3aWxsIGNo
ZWNrIGlmIC9kZXYvZHJpL3JlbmRlck4gbm9kZSBpcyBhY2Nlc3NpYmxlDQo+IGJlZm9yZSBleHBv
c2luZyBpdC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSGFyaXNoIEthc2l2aXN3YW5hdGhhbiA8SGFy
aXNoLkthc2l2aXN3YW5hdGhhbkBhbWQuY29tPg0KPiBSZXZpZXdlZC1ieTogRmVsaXggS3VlaGxp
bmcgPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IC0tLQ0KPiAgc2VjdXJpdHkvZGV2aWNlX2Nn
cm91cC5jIHwgMSArDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4NCj4gZGlm
ZiAtLWdpdCBhL3NlY3VyaXR5L2RldmljZV9jZ3JvdXAuYyBiL3NlY3VyaXR5L2RldmljZV9jZ3Jv
dXAuYw0KPiBpbmRleCBjZDk3OTI5ZmFjNjYuLmUzYTlhZDVkYjVhMCAxMDA2NDQNCj4gLS0tIGEv
c2VjdXJpdHkvZGV2aWNlX2Nncm91cC5jDQo+ICsrKyBiL3NlY3VyaXR5L2RldmljZV9jZ3JvdXAu
Yw0KPiBAQCAtODI0LDMgKzgyNCw0IEBAIGludCBfX2RldmNncm91cF9jaGVja19wZXJtaXNzaW9u
KHNob3J0IHR5cGUsIHUzMiBtYWpvciwgdTMyIG1pbm9yLA0KPiAgDQo+ICAJcmV0dXJuIDA7DQo+
ICB9DQo+ICtFWFBPUlRfU1lNQk9MKF9fZGV2Y2dyb3VwX2NoZWNrX3Blcm1pc3Npb24pOw0K
