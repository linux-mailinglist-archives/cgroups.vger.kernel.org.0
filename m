Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1CF731ED
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2019 16:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfGXOl6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 24 Jul 2019 10:41:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:6082 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbfGXOl5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 24 Jul 2019 10:41:57 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6OEcvPe015934;
        Wed, 24 Jul 2019 07:41:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=+DvBjlhSBR+cAuMcoX0J52F26OOs+GmIjiHE/JQ5hqo=;
 b=gKl2ogZ0Hwvm0zJ5C8en2e02f/vv+zAZhJkNg1Ab6HXHGySMEAAIxStG4n2IsvHwGA86
 YbHa2jBiOLzS4t+DmVP/Otbr6IHIerqfKskQ0s0vppoC/qPQRcHS7wgMBpDmTzkWq51q
 JMxlj4G8yuEyS6YWJv1E3nUC2BkS4MXeKxg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2txk7918hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 24 Jul 2019 07:41:44 -0700
Received: from ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 24 Jul 2019 07:41:44 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 24 Jul 2019 07:41:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9M/GPSsmaqY4TJRzAt50zAic+LqTCUzIOELxMwIP1NS04kV2YJapv3/Pk9AntE9YOmYXZf5KU+eqqhPULbPvQGhB7261E8OLYEl8LhAWDyLpl39KZI6TXa3aj2tg2LqTGVvHJKZL6l0Am0SEUNuvTJ/TgMdqwmJcNF6UhdQ996sbDy+YF+GJTv0e1A/VgQDpC5dWoO/h6ol3pUuH9mqzDrW6zjjBeRZV6ExQZyHOCG3nm2ySvtnAjoBmRM9pDhGq0qw2OQGbUwwRbS6pJNO5COUf4zmLCztRVejLqv7Mhe8gEbWMWL9t9ew6FvkQNqasoe5cmJG6c17RPgDwHK/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DvBjlhSBR+cAuMcoX0J52F26OOs+GmIjiHE/JQ5hqo=;
 b=ISlkCIeqOxP+EUJkNzIMMlg9RgY+wkJQ3MVh/OKvYac7UXnxfujj55+rJrfjA7jp1L1mu3l7B72sbygmMxk+R0P83anhisQR+zaIkTLS2OQ+R4Jzg425fUwNKXQ8M82hKsYTFEtyzotgWyYpLNijoWfOCER1NTZvAhTpsNS5Rn06PRltxXllyJA1w7MdwWA3WLmjGhw3mVEY7LqjDu9dLMbPogU2qip1YG1pPNvpysBtS2bvB2BxFzOL/o6MLEPiAIoT23bSTdjMLAcWVx2FJT1IHcf7sHtDA70mWFwRmKqYRAqDfg7qiyquHjBrlNFc7roNDWSK+pmsL/m4Eig7rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DvBjlhSBR+cAuMcoX0J52F26OOs+GmIjiHE/JQ5hqo=;
 b=jKA16YyTy0xAv1XqF3peGaWd96/cc3MY3uIh+LpdyoUd2RB5J76qhUEhp/HFbn24FdCIFoi+EDVJcmHJE+Y233wlKbSsdqqGytWII7NqVSl+sDJ5z7KMRkyTU0KQwCY0jgIFgXboxv3OPlrZ9s80z2RxlqAUA748cJxLNx6oK3I=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB2890.namprd15.prod.outlook.com (20.178.230.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Wed, 24 Jul 2019 14:41:42 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::fc39:8b78:f4df:a053%3]) with mapi id 15.20.2115.005; Wed, 24 Jul 2019
 14:41:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Philipp Hahn <hahn@univention.de>
CC:     Ben Hutchings <ben@decadent.org.uk>,
        "931111@bugs.debian.org" <931111@bugs.debian.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        =?utf-8?B?5q6154aK5pil?= <duanxiongchun@bytedance.com>
Subject: Re: Bug#931111: linux-image-4.9.0-9: Memory "leak" caused by CGroup
 as used by pam_systemd
Thread-Topic: Bug#931111: linux-image-4.9.0-9: Memory "leak" caused by CGroup
 as used by pam_systemd
Thread-Index: AQHVQV6N/oFcmrrGFEytID2rfOtWTKbYwksAgACZXwCAAH1kgA==
Date:   Wed, 24 Jul 2019 14:41:42 +0000
Message-ID: <20190724144137.GB11425@castle.DHCP.thefacebook.com>
References: <156154446841.16461.12659721223363969171.reportbug@fixa.knut.univention.de>
 <ad0222ca-5fb0-4177-dc82-ca63f079e942@univention.de>
 <aa31aa4f4f6c05df3f52f4bd99ceb6f0341ff482.camel@decadent.org.uk>
 <ad6a6d63-b61d-45c2-36f4-e7761bb58a3d@univention.de>
In-Reply-To: <ad6a6d63-b61d-45c2-36f4-e7761bb58a3d@univention.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR10CA0007.namprd10.prod.outlook.com (2603:10b6:301::17)
 To DM6PR15MB2635.namprd15.prod.outlook.com (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:500::5937]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d41c1201-f34d-411f-8815-08d710450ae6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB2890;
x-ms-traffictypediagnostic: DM6PR15MB2890:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DM6PR15MB28901F7D4BCB52AED4B456EFBEC60@DM6PR15MB2890.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0108A997B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(366004)(39860400002)(199004)(189003)(966005)(6246003)(6116002)(53936002)(6512007)(5660300002)(14454004)(9686003)(25786009)(99286004)(68736007)(316002)(54906003)(1076003)(7736002)(76176011)(52116002)(305945005)(6506007)(71190400001)(6436002)(71200400001)(102836004)(4326008)(6916009)(478600001)(8936002)(256004)(14444005)(86362001)(386003)(2906002)(66946007)(33656002)(229853002)(476003)(446003)(11346002)(6306002)(81156014)(81166006)(66446008)(486006)(64756008)(66556008)(66476007)(6486002)(46003)(8676002)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2890;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: umlW8FpTdrGX8JYIdGPRHOLYUbGMafkGHqUDWHt5CB6fVZKHCJu4uzTxrfu4I2UUgoSq8iRUj2oPHStDdyceYnY6H5URXTza1ozjillJgS4vWzbKzIJUr8Q3c7oHI66OGT1qTzzOf80wGB+/lfudpuY2Ax1T/DTlvwEsbvra/dox94Zpa7Nwx553jRaIOhUimVaKuCOQxyQvZAaz/Ak8GL62Kv8Hs/j6Acz9RhgnXr7YWFJHM1Zv0ND3wMC1W5qvpSWQL2dh7o/MbWXLALDUP1OLVeIpHD0ukbLTQ6KoadXPHtzuvOqC4WpF3v8NtNjuazqMM+/rwnV55xj/U9cbgHhO/IEGQGyoYWjdJEm/UNK2/9rS7T8GzQXaf0hviPjvICwjx1aVVy2j5g90Dp/fRF3x6AvRCyIgi0z9OmOxy48=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2951F9ABB1F0764CAD2C37410167C09C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d41c1201-f34d-411f-8815-08d710450ae6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 14:41:42.0700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2890
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-24_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907240164
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gV2VkLCBKdWwgMjQsIDIwMTkgYXQgMDk6MTI6NTBBTSArMDIwMCwgUGhpbGlwcCBIYWhuIHdy
b3RlOg0KPiBIZWxsbyBCZW4sDQo+IA0KPiBBbSAyNC4wNy4xOSB1bSAwMDowMyBzY2hyaWViIEJl
biBIdXRjaGluZ3M6DQo+ID4gT24gVHVlLCAyMDE5LTA3LTIzIGF0IDE1OjU2ICswMjAwLCBQaGls
aXBwIEhhaG4gd3JvdGU6DQo+ID4gWy4uLl0NCj4gPj4gLSB3aGVuIHRoZSBqb2IgLyBzZXNzaW9u
IHRlcm1pbmF0ZXMsIHRoZSBkaXJlY3RvcnkgaXMgZGVsZXRlZCBieQ0KPiA+PiBwYW1fc3lzdGVt
ZC4NCj4gPj4NCj4gPj4gLSBidXQgdGhlIExpbnV4IGtlcm5lbCBzdGlsbCB1c2VzIHRoZSBDR3Jv
dXAgdG8gdHJhY2sga2VybmVsIGludGVybmFsDQo+ID4+IG1lbW9yeSAoU0xBQiBvYmplY3RzLCBw
ZW5kaW5nIGNhY2hlIHBhZ2VzLCAuLi4/KQ0KPiA+Pg0KPiA+PiAtIGluc2lkZSB0aGUga2VybmVs
IHRoZSBDR3JvdXAgaXMgbWFya2VkIGFzICJkeWluZyIsIGJ1dCBpdCBpcyBvbmx5DQo+ID4+IGdh
cmJhZ2UgY29sbGVjdGVkIHZlcnkgbGF0ZXIgb24NCj4gPiBbLi4uXQ0KPiA+PiBJIGRvIG5vdCBr
bm93IHdobyBpcyBhdCBmYXVsdCBoZXJlLCBpZiBpdCBpcw0KPiA+PiAtIHRoZSBMaW51eCBrZXJu
ZWwgZm9yIG5vdCBmcmVlaW5nIHRob3NlIHJlc291cmNlcyBlYXJsaWVyDQo+ID4+IC0gc3lzdGVt
ZCBmb3IgdXNpbmcgQ0dzIGluIGEgYnJva2VuIHdheQ0KPiA+PiAtIHNvbWVvbmUgb3RoZXJzIGZh
dWx0Lg0KPiA+IFsuLi5dDQo+ID4gDQo+ID4gSSB3b3VsZCBzYXkgdGhpcyBpcyBhIGtlcm5lbCBi
dWcuICBJIHRoaW5rIGl0J3MgdGhlIHNhbWUgcHJvYmxlbSB0aGF0DQo+ID4gdGhpcyBwYXRjaCBz
ZXJpZXMgaXMgdHJ5aW5nIHRvIHNvbHZlOg0KPiA+IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBv
aW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbHduLm5ldF9tbF9saW51eC0yRGtlcm5lbF8yMDE5
MDYxMTIzMTgxMy4zMTQ4ODQzLTJEMS0yRGd1cm8tNDBmYi5jb21fJmQ9RHdJRGFRJmM9NVZEMFJU
dE5sVGgzeWNkNDFiM01VdyZyPWpKWWd0RE03UVQtVy1Gel9kMjlIWVEmbT14TkxGQUIzZ0JHQjFO
Q0ttUVpOLTZKTkVqX0FYZkozLXdZSzdJRFdKQXg0JnM9WWZXV25vVy16SmRUTjBoZDF0enpaUWxV
SVV0anYtaUJOOUNvNXJOUDVKMCZlPSANCj4gPiANCj4gPiBEb2VzIHRoZSBkZXNjcmlwdGlvbiB0
aGVyZSBzZWVtIHRvIG1hdGNoIHdoYXQgeW91J3JlIHNlZWluZz8NCj4gDQo+IFllcywgUm9tYW4g
R3VzaGNoaW4gcmVwbGllZCB0byBtZSBieSBwcml2YXRlIG1haWwsIHdoaWNoIEkgd2lsbCBxdW90
ZQ0KPiBoZXJlIHRvIGdldCBoaXMgcmVzcG9uc2UgYXJjaGl2ZWQgaW4gRGViaWFuJ3MgQlRTIGFz
IHdlbGw6DQo+IA0KPiA+IEhpIFBoaWxpcHAhDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZvciB0aGUg
cmVwb3J0IQ0KPiA+IA0KPiA+IEkndmUgc3BlbnQgbG90IG9mIHRpbWUgd29ya2luZyBvbiB0aGlz
IHByb2JsZW0sIGFuZCB0aGUgZmluYWwgcGF0Y2hzZXQNCj4gPiBoYXMgYmVlbiBtZXJnZWQgaW50
byA1LjMuIEl0IGltcGxlbWVudHMgcmVwYXJlbnRpbmcgb2YgdGhlIHNsYWIgbWVtb3J5DQo+ID4g
b24gY2dyb3VwIGRlbGV0aW9uLiA1LjMgc2hvdWxkIGJlIG11Y2ggYmV0dGVyIGluIHJlY2xhaW1p
bmcgZHlpbmcgY2dyb3Vwcy4NCj4gPiANCj4gPiBVbmZvcnR1bmF0ZWx5LCB0aGUgcGF0Y2hzZXQg
aXMgcXVpdGUgaW52YXNpdmUgYW5kIGlzIGJhc2VkIG9uIHNvbWUNCj4gPiB2bXN0YXRzIGNoYW5n
ZXMgZnJvbSA1LjIsIHNvIGl0J3Mgbm90IHRyaXZpYWwgdG8gYmFja3BvcnQgaXQgdG8NCj4gPiBv
bGRlciBrZXJuZWxzLg0KPiA+IA0KPiA+IEFsc28sIHRoZXJlIGlzIG5vIGdvb2Qgd29ya2Fyb3Vu
ZCwgb25seSBtYW51YWxseSBkcm9wcGluZyBrZXJuZWwNCj4gPiBjYWNoZXMgb3IgZGlzYWJsZSB0
aGUga2VybmVsIG1lbW9yeSBhY2NvdW50aW5nIGFzIGEgd2hvbGUuDQo+ID4gDQo+ID4gVGhhbmtz
IQ0KPiANCj4gDQo+IOauteeGiuaYpSA8ZHVhbnhpb25nY2h1bkBieXRlZGFuY2UuY29tPiBhbHNv
IHJlcGxpZWQgYW5kIHBvaW50ZWQgb3V0IGhpcw0KPiBwYXRjaC1zZXQgPGh0dHBzOi8vcGF0Y2h3
b3JrLmtlcm5lbC5vcmcvY292ZXIvMTA3NzIyNzcvPiwgd2hpY2ggc29sdmVkDQo+IHRoZSBwcm9i
bGVtIGZvciB0aGVtLiBJIG1vcmUgbG9va3MgbGlrZSBhICJoYWNrIiwgd2FzIG5ldmVyIGFwcGxp
ZWQNCj4gdXBzdHJlYW0gYXMgUm9tYW5zIHdvcmsgc29sdmVkIHRoZSB1bmRlcmx5aW5nIHByb2Js
ZW0uDQo+IA0KPiANCj4gU28gc2hvdWxkIHNvbWVvbmXihKIgYml0ZSB0aGUgYnVsbGV0IGFuZCB0
cnkgdG8gYmFja3BvcnQgUm9tYW5zIGNoYW5nZSB0bw0KPiA0LjE5IChhbmQgNC45KT8gKHRob3Nl
IGFyZSB0aGUga2VybmVsIHZlcnNpb25zIHVzZWQgYnkgRGViaWFuKS4NCj4gSSdtIG5vdCBhIGtl
cm5lbCBleHBlcnQgbXlzZWxmLCBlc3BlY2lhbGx5IG5vIG1tL2NnIGV4cGVydCwgYnV0IGhhdmUN
Cj4gZG9uZSBzb21lIHdvcmsgbXlzZWxmIGluIHRoZSBwYXN0LCBidXQgSSB3b3VsZCBoYXBwaWx5
IHBhc3Mgb24gdGhlDQo+IGNoYWxpY2UgdG8gc29tZW9uZSBtb3JlIGV4cGVyaWVuY2VkLg0KDQpI
aSBQaGlsaXBwIQ0KDQpJdCdzIGRvYWJsZSBmcm9tIHRoZSB0ZWNobmljYWwgcG9pbnQgb2Ygdmll
dywgYnV0IEkgcmVhbGx5IGRvdWJ0IGl0J3Mgc3VpdGFibGUNCmZvciB0aGUgb2ZmaWNpYWwgc3Rh
YmxlLiBUaGUgYmFja3BvcnQgd2lsbCBjb25zaXN0IG9mIGF0IGxlYXN0IDIwKyBjb3JlDQptbS9t
ZW1jb250cm9sIHBhdGNoZXMsIHNvIGl0IHJlYWxseSBmZWVscyBleGNlc3NpdmUuDQoNCklmIHlv
dSBzdGlsbCB3YW50IHRvIHRyeSwgeW91IG5lZWQgdG8gYmFja3BvcnQgMjA1YjIwY2M1YTk5IGZp
cnN0IChhbmQgdGhlIHJlc3QNCm9mIHRoZSBwYXRjaHNldCksIGJ1dCBpdCBtYXkgYWxzbyBkZXBl
bmQgb24gc29tZSBvdGhlciB2bXN0YXQgY2hhbmdlcy4NCg0KVGhhbmtzIQ0K
