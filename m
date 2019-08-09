Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9486F01
	for <lists+cgroups@lfdr.de>; Fri,  9 Aug 2019 02:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfHIA54 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Aug 2019 20:57:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21506 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732796AbfHIA5z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Aug 2019 20:57:55 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x790rvlI002575;
        Thu, 8 Aug 2019 17:57:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/BPU77XJe1qy2ASoI5lFobOZEYDoCwlx/KYqwMSP0aY=;
 b=qdmRVyTW7vOPlR31vJUZ374HcyFcs7eaixAb/F6dZuUV9I48T2nH8zRTT19KdeW9/bzJ
 kX6MPH/wfRmXQZqAbQMGV8O5uCabXA4nA1zp6Lb7q7GBiVSi6V3yQbF2SdXlLEePMU4R
 vVuVnLtFpPzk9KRyWgjktVNsWBPUNGURRlo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2u8sunh0h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 08 Aug 2019 17:57:45 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 17:57:42 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 8 Aug 2019 17:57:42 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Aug 2019 17:57:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY9b41Nm6MDFxh4N+owjLyzyWIC73qhJG0iG1couOk/XQ56sS1a0a/ZHJWFFRQK15OW6sAycq4ghd1d1cWv++smKOQc3L9bl/nOdLVoCGSL78qBLIRcqQOZcWBNJQrkmB4kUmyXy55hkBSOTdEPzLnroKl7QkWstXyN7SnZIEznVxVxcbdiub0yF0aoFILf447emsJ4aBQ2KW4M3oiyKHFcfBeblCp7CFA6ZpNCun9cfgQ12Vz3Cl8FyEJ6Lp6sJ2/+9JhNqtqWRLAL8Dd+DG7T1Pa+TRYGjROsPqRmlisiH4c68DWc//lXB+FbzOuEJUJSGvmbGJuoBBY7lZXIq7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPU77XJe1qy2ASoI5lFobOZEYDoCwlx/KYqwMSP0aY=;
 b=KW13HyQXb1aeWUQsZmuTBAZHaE3nUdTknRKO5jX76Ln6EML2Iw4PH3Cu4+Udi+/7odTD23NzF2VfW850PDXURPhO4O3aYvrG4P1dsfYnGe4bYLQcXT7nKFFmn7gt8lYEi12yZEMP+CFm6KAVkI8nBO1Hbm3Vb6rCZfpH+6q++la5VqHqvfRAcBbARLe530UuyFpGborpGH4xWU/pHKb/bJnDhzJPvtDUUESC0R7C0C/2cdAQlP8kRuEysKNqVYJgVdp3+P/Cf6CNzScZfzc/AyAcJSYZxMi7N2E4a91UjgFzVrD37+Dxcf83nbdohjg2CMCwBgSslfa+qvDebUoT1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=fb.com;dmarc=pass action=none header.from=fb.com;dkim=pass
 header.d=fb.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BPU77XJe1qy2ASoI5lFobOZEYDoCwlx/KYqwMSP0aY=;
 b=b8qmWhKlB2740VAbokWnsRlAQh05Y8xlXNDrJdjX9dj4d2WYpY0H+z87VoAluX/RArfXTA0OwMyuEyRSDQV0T9ByM+YPRVjatTSeDwmZ34gxajhfz6G4ydyYmceNdA5UXEtbLRCE4IFfHqjxQu/Zda7Dm4xkON6bX47XJWITGPQ=
Received: from BYAPR15MB3479.namprd15.prod.outlook.com (20.179.60.19) by
 BYAPR15MB2936.namprd15.prod.outlook.com (20.178.237.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.13; Fri, 9 Aug 2019 00:57:24 +0000
Received: from BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2940:2c5b:d114:4301]) by BYAPR15MB3479.namprd15.prod.outlook.com
 ([fe80::2940:2c5b:d114:4301%4]) with mapi id 15.20.2136.022; Fri, 9 Aug 2019
 00:57:24 +0000
From:   Rik van Riel <riel@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>, "jack@suse.cz" <jack@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Roman Gushchin" <guro@fb.com>
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Thread-Topic: [PATCH 2/4] bdi: Add bdi->id
Thread-Index: AQHVSgQYPr6K+ZkjtECAKgDfReEUqqbuwZoAgAFHIICAAAgJgIAB9f0A
Date:   Fri, 9 Aug 2019 00:57:24 +0000
Message-ID: <775309de70c1371e852fa5e6f84ca1ca2727faa0.camel@fb.com>
References: <20190803140155.181190-1-tj@kernel.org>
         <20190803140155.181190-3-tj@kernel.org>
         <20190806160102.11366694af6b56d9c4ca6ea3@linux-foundation.org>
         <20190807183151.GM136335@devbig004.ftw2.facebook.com>
         <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
In-Reply-To: <20190807120037.72018c136db40e88d89c05d1@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:301:3a::28) To BYAPR15MB3479.namprd15.prod.outlook.com
 (2603:10b6:a03:112::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::b402]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5baa222c-6893-4002-c993-08d71c648aae
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2936;
x-ms-traffictypediagnostic: BYAPR15MB2936:
x-microsoft-antispam-prvs: <BYAPR15MB2936C0D712CBA3F4A5D091C0A3D60@BYAPR15MB2936.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(366004)(396003)(199004)(189003)(71200400001)(316002)(66476007)(71190400001)(118296001)(66556008)(66946007)(256004)(7736002)(64756008)(66446008)(305945005)(110136005)(81156014)(5660300002)(54906003)(8676002)(86362001)(46003)(8936002)(76176011)(2906002)(11346002)(36756003)(25786009)(81166006)(2616005)(6506007)(102836004)(229853002)(6246003)(53936002)(6486002)(386003)(486006)(7416002)(6436002)(6512007)(476003)(52116002)(186003)(446003)(6116002)(4326008)(478600001)(99286004)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2936;H:BYAPR15MB3479.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: H6HVlOaDConwRhU7gaQ+MmcY2Isw5e+A+CC+mk6Sm2UrME1WKrbV05D6YA7Oh2O2DNTfmqtUWWQ2Yjey2FPm0uvoOOOVRLTQv0/FqLxe2hb6tZF+AsRD//BGDV445Ykqrd98goUjV9K/OX1fKvfVfTVpasYv4YDmlLP6YZF9Zb1HSxA49SOX253gD6Pms/DxugXiUArRl71xtDTcdRydlFEf181AzOPtEgH54TBwjp2YyiOaU0Ya/uygs5FBMXwBjrGHKtLIXihJcYBWzv7B2dJ1s7NwIx10zi3WYu6K3a50H11Ypz7K268HTQSwcbFIHtjZy/BErOmsdFjPcItHtoLYT/91uoFiO6h3M7tsucOSC/N1NQkhTbNue97KAQHrOQ2VDNLq9TgAjciAoeLqBHFZOAu+52Qby5aeVNy5Cj0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <407D6DBF6F662F4A87AD469AF3BAF9A2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baa222c-6893-4002-c993-08d71c648aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 00:57:24.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: riel@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2936
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=431 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908090007
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDEyOjAwIC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBXZWQsIDcgQXVnIDIwMTkgMTE6MzE6NTEgLTA3MDAgVGVqdW4gSGVvIDx0akBrZXJuZWwu
b3JnPiB3cm90ZToNCj4gDQo+ID4gSGVsbG8sDQo+ID4gDQo+ID4gT24gVHVlLCBBdWcgMDYsIDIw
MTkgYXQgMDQ6MDE6MDJQTSAtMDcwMCwgQW5kcmV3IE1vcnRvbiB3cm90ZToNCj4gPiA+IE9uIFNh
dCwgIDMgQXVnIDIwMTkgMDc6MDE6NTMgLTA3MDAgVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPg0K
PiA+ID4gd3JvdGU6DQo+ID4gPiA+IFRoZXJlIGN1cnJlbnRseSBpcyBubyB3YXkgdG8gdW5pdmVy
c2FsbHkgaWRlbnRpZnkgYW5kIGxvb2t1cCBhDQo+ID4gPiA+IGJkaQ0KPiA+ID4gPiB3aXRob3V0
IGhvbGRpbmcgYSByZWZlcmVuY2UgYW5kIHBvaW50ZXIgdG8gaXQuICBUaGlzIHBhdGNoIGFkZHMN
Cj4gPiA+ID4gYW4NCj4gPiA+ID4gbm9uLXJlY3ljbGluZyBiZGktPmlkIGFuZCBpbXBsZW1lbnRz
IGJkaV9nZXRfYnlfaWQoKSB3aGljaA0KPiA+ID4gPiBsb29rcyB1cA0KPiA+ID4gPiBiZGlzIGJ5
IHRoZWlyIGlkcy4gIFRoaXMgd2lsbCBiZSB1c2VkIGJ5IG1lbWNnIGZvcmVpZ24gaW5vZGUNCj4g
PiA+ID4gZmx1c2hpbmcuDQo+ID4gPiANCj4gPiA+IFdoeSBpcyB0aGUgaWQgbm9uLXJlY3ljbGlu
Zz8gIFByZXN1bWFibHkgdG8gYWRkcmVzcyBzb21lDQo+ID4gPiBsaWZldGltZS9sb29rdXAgaXNz
dWVzLCBidXQgd2hhdCBhcmUgdGhleT8NCj4gPiANCj4gPiBUaGUgSUQgYnkgaXRzZWxmIGlzIHVz
ZWQgdG8gcG9pbnQgdG8gdGhlIGJkaSBmcm9tIGNncm91cCBhbmQgaWRyDQo+ID4gcmVjeWNsZXMg
cmVhbGx5IGFnZ3Jlc3NpdmVseS4gIENvbWJpbmVkIHdpdGgsIGZvciBleGFtcGxlLCBsb29wDQo+
ID4gZGV2aWNlDQo+ID4gYmFzZWQgY29udGFpbmVycywgc3RhbGUgcG9pbnRpbmcgY2FuIGJlY29t
ZSBwcmV0dHkgY29tbW9uLiAgV2UncmUNCj4gPiBoYXZpbmcgc2ltaWxhciBpc3N1ZXMgd2l0aCBj
Z3JvdXAgSURzLg0KPiANCj4gT0ssIGJ1dCB3aHkgaXMgcmVjeWNsaW5nIGEgcHJvYmxlbT8gIEZv
ciBleGFtcGxlLCBmaWxlIGRlc2NyaXB0b3JzDQo+IHJlY3ljbGUgYXMgYWdncmVzc2l2ZWx5IGFz
IGlzIHBvc3NpYmxlLCBhbmQgdGhhdCBkb2Vzbid0IGNhdXNlIGFueQ0KPiB0cm91YmxlLiAgUHJl
c3VtYWJseSByZWN5Y2xpbmcgaXMgYSBwcm9ibGVtIHdpdGggY2dyb3VwcyBiZWNhdXNlIG9mDQo+
IHNvbWUgc29ydCBvZiBzdGFsZSByZWZlcmVuY2UgcHJvYmxlbT8NCg0KUElEcywgb24gdGhlIG90
aGVyIGhhbmQsIHdlIHJlY3ljbGUgYXMgc2xvd2x5IGFzDQpwb3NzaWJsZS4uLg0KDQo=
