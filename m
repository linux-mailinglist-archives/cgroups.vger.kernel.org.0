Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A25742558C
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 18:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfEUQ2J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 12:28:09 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52406 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727932AbfEUQ2I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 May 2019 12:28:08 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4LGL7po022648;
        Tue, 21 May 2019 09:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4W8NHuI/u+XHU37aD05p8OdYnW8rnzf3lzt+u0w6T0w=;
 b=rX15COkyc0fGnOW5oVy4aQn6/HTALXMc6uTT2C1v6nYJQg5TEiTc0tuk5Z/HZkOCGKF5
 C/zOftIxuyed4Z0MRFZVmZVExC2B0IDlGQdrt1a/UUNYNJxBYU7owfHxHIh1FM7VIBhq
 T5jPuNv+xBunjbn4PQKzyA9PVqHdbe0+K8Y= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2smcnpsnv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 May 2019 09:27:06 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 May 2019 09:27:04 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 May 2019 09:27:04 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 21 May 2019 09:27:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4W8NHuI/u+XHU37aD05p8OdYnW8rnzf3lzt+u0w6T0w=;
 b=Y0drvktLjnroRyrVOB+YvT+efeErs9Z+isGykpzAteVnw5tmavVI9J6gYpF/GRQnFyMltR0NPVfZxfjsA/45g9KJamMYyLmXbWwk+j5illnkWxYWNAao8f7ibzcuoKWWxFcL49Kz9lqORhO6FrXryhoIu09PWZ7IJp1xFezNJXw=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.2.19) by
 MWHPR15MB1695.namprd15.prod.outlook.com (10.175.142.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Tue, 21 May 2019 16:27:02 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::85b5:614:bc49:8a15%11]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 16:27:02 +0000
From:   Song Liu <songliubraving@fb.com>
To:     =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
CC:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Topic: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACAQAwaAIAALJKA
Date:   Tue, 21 May 2019 16:27:02 +0000
Message-ID: <D9376488-F290-4917-9124-292AA649948C@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <20190521134730.GA12346@blackbody.suse.cz>
In-Reply-To: <20190521134730.GA12346@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.8)
x-originating-ip: [2620:10d:c090:200::1:bee7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62d56774-4771-49c0-e7e2-08d6de092819
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:MWHPR15MB1695;
x-ms-traffictypediagnostic: MWHPR15MB1695:
x-microsoft-antispam-prvs: <MWHPR15MB169518FF4144390263FA01F5B3070@MWHPR15MB1695.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(189003)(199004)(2906002)(305945005)(25786009)(99286004)(486006)(57306001)(476003)(76176011)(446003)(14444005)(316002)(11346002)(2616005)(46003)(68736007)(53936002)(256004)(6246003)(71200400001)(71190400001)(36756003)(83716004)(4326008)(6436002)(6506007)(186003)(82746002)(6116002)(6486002)(53546011)(6512007)(102836004)(5660300002)(229853002)(66476007)(8936002)(7736002)(14454004)(81156014)(81166006)(33656002)(76116006)(66446008)(66556008)(8676002)(86362001)(64756008)(6916009)(66946007)(73956011)(50226002)(54906003)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1695;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: skEQxFHDwmww0vF/DKz7m4I9DqkL2IbwuAToTvVSm53aALvqjp3H0dYZPfSbL8JDXCSrOcdfUaEmv471HwNAjEVBla7j/1pAJ1DM6ERcrkTj5nmCSwNFgd7cnqiVhR4Fbu/p0JvX6mPOg+8JhPMEctCqHMwRUGae1DKJuYrD+QsTAw3EQSLVXRmyBgIpqLJj93ZDFUooq0f8K4txjfHHZvu0iec2+943aG7nWrpnd72rbw7pc0oIYIbIZVS2gRZWW8j0e/tayCbkKM5i8bGBlTXWoNJBMYCDBLb559XQhK1cmjLaKP0y5jbQhQ1opLlnouOSexpNTHBrQJQg0MK1S4CsUYDL7Nvci04oBtbgqe97rDzoobQD+cjY3GHy1SnWS7kfxbI+NX4BIF+2Rx87YXtA7GqilaYPqoVdo7IdruQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <227172D9A4EF6C4B9300F4C897FCC117@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d56774-4771-49c0-e7e2-08d6de092819
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 16:27:02.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1695
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=925 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210101
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IE9uIE1heSAyMSwgMjAxOSwgYXQgNjo0NyBBTSwgTWljaGFsIEtvdXRu
w70gPG1rb3V0bnlAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gU29uZy4NCj4gDQo+IE9u
IFdlZCwgQXByIDEwLCAyMDE5IGF0IDA3OjQzOjM1UE0gKzAwMDAsIFNvbmcgTGl1IDxzb25nbGl1
YnJhdmluZ0BmYi5jb20+IHdyb3RlOg0KPj4gVGhlIGxvYWQgbGV2ZWwgYWJvdmUgaXMgbWVhc3Vy
ZWQgYXMgcmVxdWVzdHMtcGVyLXNlY29uZC4gDQo+PiANCj4+IFdoZW4gdGhlcmUgaXMgbm8gc2lk
ZSB3b3JrbG9hZCwgdGhlIHN5c3RlbSBoYXMgYWJvdXQgNDUlIGJ1c3kgQ1BVIHdpdGggDQo+PiBs
b2FkIGxldmVsIG9mIDEuMDsgYW5kIGFib3V0IDc1JSBidXN5IENQVSBhdCBsb2FkIGxldmVsIG9m
IDEuNS4gDQo+PiANCj4+IFRoZSBzYXR1cmF0aW9uIHN0YXJ0cyBiZWZvcmUgdGhlIHN5c3RlbSBo
aXR0aW5nIDEwMCUgdXRpbGl6YXRpb24uIFRoaXMgaXMNCj4+IHRydWUgZm9yIG1hbnkgZGlmZmVy
ZW50IHJlc291cmNlczogQUxVcyBpbiBTTVQgc3lzdGVtcywgY2FjaGUgbGluZXMsIA0KPj4gbWVt
b3J5IGJhbmR3aWR0aHMsIGV0Yy4gDQo+IEkgaGF2ZSByZWFkIHRocm91Z2ggdGhlIHRocmVhZCBj
b250aW51YXRpb24gYW5kIGl0IGFwcGVhcnMgdG8gbWUgdGhlcmUNCj4gaXMgc29tZSBtaXN1bmRl
cnN0YW5kaW5nIG9uIHRoZSBsYXRlbmN5IG1ldHJpYyAoc2NoZWR1bGVyIGxhdGVuY3kgPD0NCj4g
eW91ciBsYXRlbmN5IDw9IHJlcXVlc3Qgd2FsbCB0aW1lPykuDQoNCldlIGRlZmluZSAieW91ciBs
YXRlbmN5IiA9PSAicmVxdWVzdCB3YWxsIHRpbWUiID4gInNjaGVkdWxlciBsYXRlbmN5Ii4gDQoN
ClRoZSBhcHBsaWNhdGlvbiBpcyBhIHdlYiBzZXJ2ZXIuIEl0IHdvcmtzIGFzOg0KDQogICAgZm9y
IGEgZmV3IGl0ZXJhdGlvbnM6DQogICAgICAgIChhKSByZXF1ZXN0IGRhdGEgZnJvbSBjYWNoZS9k
Yg0KICAgICAgICAoYikgd2FpdCBmb3IgZGF0YQ0KICAgICAgICAoYykgZGF0YSBpcyByZWFkeSwg
d2FpdCB0byBiZSBzY2hlZHVsZWQNCiAgICAgICAgKGQpIHJlbmRlciB3ZWIgcGFnZSBiYXNlZCBv
biBkYXRhDQoNCldlIG5lZWQgdG8gZG8gYSBmZXcgaXRlcmF0aW9ucyBiZWNhdXNlIHdlIG5lZWQg
c29tZSBkYXRhIHRvIGRlY2lkZSB3aGF0DQpvdGhlciBkYXRhIHRvIGZldGNoLiANCg0KVGhlIG92
ZXJhbGwgbGF0ZW5jeSAob3Igd2FsbCBsYXRlbmN5KSBjb250YWluczogDQoNCiAgICgxKSBjcHUg
dGltZSwgd2hpY2ggaXMgKGEpIGFuZCAoZCkgaW4gdGhlIGxvb3AgYWJvdmU7DQogICAoMikgdGlt
ZSB3YWl0aW5nIGZvciBkYXRhLCB3aGljaCBpcyAoYik7DQogICAoMykgc2NoZWR1bGUgbGF0ZW5j
eSwgdGltZSBiZXR3ZWVuIGRhdGEgaXMgcmVhZHkgYW5kIHRoZSB0aHJlYWQgd2FrZXMNCiAgICAg
ICB1cCwgd2hpY2ggaXMgKGMpOw0KDQpJbiBvdXIgZXhwZXJpbWVudCwgd2UgY2FuIG1lYXN1cmUg
KDEpIGFuZCAiKDEpKygyKSsoMykiLiBGb3IgZGF0YSBpbiB0aGUNCmZvbGxvd2luZyB0YWJsZS4g
ImNwdSB0aW1lIiBpcyAoMSksICJ3YWxsIHRpbWUiIGlzICgxKSsoMikrKDMpLCBhbmQgDQoid2Fs
bCAtIGNwdSIgaXMgIigyKSsoMykiLiBXZSBhc3N1bWUgKDIpIGRvZXNuJ3QgY2hhbmdlLCBzbyBj
aGFuZ2VzIGluIA0KIndhbGwgLSBjcHUiIGlzIG1vc3RseSBkdWUgdG8gY2hhbmdlcyBpbiAoMyku
IA0KDQpzaWRlIGpvYiB8IGNwdS5oZWFkcm9vbSB8ICBjcHUtaWRsZSB8IHdhbGwgdGltZSB8IGNw
dSB0aW1lIHwgd2FsbCAtIGNwdQ0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogbm9uZSAgICB8ICAgICBuL2Eg
ICAgICB8ICAgIDQyLjQlICB8ICAgMS4wMCAgICB8ICAgMC4zMSAgIHwgICAwLjY5DQpmZm1wZWcg
ICB8ICAgICAgIDAgICAgICB8ICAgIDEwLjglICB8ICAgMS4xNyAgICB8ICAgMC4zOCAgIHwgICAw
Ljc5DQpmZm1wZWcgICB8ICAgICAyNSUgICAgICB8ICAgIDIyLjglICB8ICAgMS4wOCAgICB8ICAg
MC4zNSAgIHwgICAwLjczDQoNCg0KRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/DQoNClRoYW5rcywNClNv
bmcNCg0K
