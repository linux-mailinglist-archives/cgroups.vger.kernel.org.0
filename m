Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3456E28
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZP5h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:57:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:21542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfFZP5g (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 11:57:36 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5QFtXkS018654;
        Wed, 26 Jun 2019 08:56:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=e4QsHOsj/ansg9eJGXoLS07ec1mXlD32/gZfHaz02rE=;
 b=Qhn1rGvG3PQKThcV7S3szGMRxklG0EGyDGloa9rtkqGFllT6YfqSg4Lwc9wXyNoip4bT
 Hh/3EqMBkMhpO4TpU/TrYxJTdTMmOMYr1s3bA5JP5RdGgfVgHSkj/OxE3D/1NAuK585l
 Mu2DUEc9hdWXyg+Loo3aRtJIbDxP+MDAmQ0= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tc8axgtpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Jun 2019 08:56:49 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 26 Jun 2019 08:56:48 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 26 Jun 2019 08:56:47 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 26 Jun 2019 08:56:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e4QsHOsj/ansg9eJGXoLS07ec1mXlD32/gZfHaz02rE=;
 b=pBOfZ6Ik4NbQulFMYfkeon9uC6aeQdMn8rxgdnVAs+6jb92kvNYyPluZ/j9Xy0OqCV2rR4khpjvwt6myidLdAR5o6N1ysmDuXSg2ruGI1mTsNB5QIApp6k85/kwsHc8DRyNBdVszDty3xnLjiMD9cKFWwpqiQoLmfJMp6+adEW4=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1200.namprd15.prod.outlook.com (10.175.3.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Wed, 26 Jun 2019 15:56:46 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.018; Wed, 26 Jun 2019
 15:56:46 +0000
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
Thread-Index: AQHU7lSD68FtcB4UGUOYupgC9AfmOKY1TPCAgACBxACAQAwaAIAALJKAgDgNsoCAAH3FAA==
Date:   Wed, 26 Jun 2019 15:56:46 +0000
Message-ID: <11B128A7-6E3C-4DB7-817D-36711F3DD0C4@fb.com>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
 <20190521134730.GA12346@blackbody.suse.cz>
 <D9376488-F290-4917-9124-292AA649948C@fb.com>
 <20190626082634.GA22035@blackbody.suse.cz>
In-Reply-To: <20190626082634.GA22035@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:180::1:6898]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6d5be1b-c89b-46e3-28a0-08d6fa4ee443
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1200;
x-ms-traffictypediagnostic: MWHPR15MB1200:
x-microsoft-antispam-prvs: <MWHPR15MB12009CE039DAD55DB4CF715CB3E20@MWHPR15MB1200.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 00808B16F3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(396003)(366004)(346002)(189003)(199004)(8936002)(6436002)(68736007)(50226002)(6512007)(53936002)(478600001)(99286004)(6916009)(14454004)(256004)(33656002)(6246003)(5660300002)(2906002)(6486002)(229853002)(86362001)(46003)(76176011)(476003)(57306001)(7736002)(66556008)(2616005)(66476007)(305945005)(76116006)(25786009)(71200400001)(11346002)(73956011)(6116002)(446003)(66946007)(186003)(8676002)(81166006)(4326008)(316002)(81156014)(102836004)(6506007)(14444005)(54906003)(53546011)(71190400001)(36756003)(486006)(64756008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1200;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4mGTOfnd2tLAd3dC/InGeyeeUst1JI3mgILc92f9PzaUCh5BakgDdrLBfYvN+DYrGnqJlqxeE4dhvd6edb5oyqkhbeWfeueXTVCvYKY+/RZHtN8azFdTzuPthM5YagF8WtxFG+Ib0tjWysJGf6lOKsUAdZaFnpw1Fs1pi8zTqSJxlHc9yJijrsaMFLJi8A3i0feOLxNM8a/znxBE0sCuWuiPhYWWDIcO9EYjY/VDIIFkgtHvl5fWwy1JN1SYyUixTwRmk3yOMp0MSUNVjSVHXcXQIlKTn/otPdSaSJ5TBp5hVPn52bU0PPQA/GaRqaqvu6GCVtMlRvOX1WglOj26LAz4+CByPcweKWiEVLa+iMmgti4EP4ULJGHnVpdJTtmxox7MovoWNeAOFcoNJFAvx/jeGyliQ3qSlXZ+RwPOCKs=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3983C0F8C296C546851342B9A822F7CD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d5be1b-c89b-46e3-28a0-08d6fa4ee443
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2019 15:56:46.1712
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1200
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260186
X-FB-Internal: deliver
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IE9uIEp1biAyNiwgMjAxOSwgYXQgMToyNiBBTSwgTWljaGFsIEtvdXRu
w70gPG1rb3V0bnlAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gU29uZyBhbmQgSSBhcG9s
b2d5IGZvciBsYXRlIHJlcGx5Lg0KPiANCj4gSSB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uIGZv
ciB0aGUgaGVhZHJvb20gYXR0cmlidXRlIGlzIHRvIGFjaGlldmUNCj4gc2lkZSBsb2FkIHRocm90
dGxpbmcgYmVmb3JlIHRoZSBDUFUgaXMgZnVsbHkgc2F0dXJhdGVkIHNpbmNlIHlvdXINCj4gbWVh
c3VyZW1lbnRzIHNob3cgdGhhdCBzb21ldGhpbmcgZWxzZSBnZXRzIHNhdHVyYXRlZCBlYXJsaWVy
IHRoYW4gQ1BVDQo+IGFuZCBjYXVzZXMgZ3JvdyBvZiB0aGUgb2JzZXJ2ZWQgbGF0ZW5jeS4NCj4g
DQo+IFRoZSBzZWNvbmQgYXNwZWN0IG9mIHRoZSBoZWFkcm9vbSBrbm9iLCBpLmUuIGR5bmFtaWMg
cGFydGl0aW9uaW5nIG9mIHRoZQ0KPiBDUFUgcmVzb3VyY2UgaXMgSU1PIHNvbWV0aGluZyB3aGlj
aCB3ZSBhbHJlYWR5IGhhdmUgdGhhbmtzIHRvDQo+IGNwdS53ZWlnaHQuDQoNCkkgdGhpbmsgdGhl
IGNwdS5oZWFkcm9vbSBrbm9iIGlzIHRoZSBkeW5hbWljIHZlcnNpb24gb2YgdGhlIGNwdS5tYXgg
a25vYi4gDQpJdCBzZXJ2ZXMgZGlmZmVyZW50IHJvbGUgYXMgY3B1LndlaWdodC4gDQoNCmNwdS53
ZWlnaHQgaXMgbGlrZTogd2hlbiBib3RoIHRhc2tzIGNhbiBydW4sIHdoaWNoIG9uZSBnZXRzIG1v
cmUgY3ljbGVzLiANCmNwdS5oZWFkcm9vbSBpcyBsaWtlOiBldmVuIHRoZXJlIGlzIGlkbGUgY3B1
IGN5Y2xlLCB0aGUgc2lkZSB3b3JrbG9hZCANCnNob3VsZCBub3QgdXNlIGl0IGFsbC4gDQoNCj4g
DQo+IEFzIHlvdSB3cm90ZSwgcGxhaW4gY3B1LndlaWdodCBvZiB3b3JrbG9hZHMgZGlkbid0IHdv
cmsgZm9yIHlvdSwgc28gSQ0KPiB0aGluayBpdCdkIGJlIHdvcnRoIGZpZ3VyaW5nIG91dCB3aGF0
IGlzIHRoZSByZXNvdXJjZSB3aG9zZSBzYXR1cmF0aW9uDQo+IGFmZmVjdHMgdGhlIG92ZXJhbGwg
b2JzZXJ2ZWQgbGF0ZW5jeSBhbmQgc2VlIGlmIGEgcHJvdGVjdGlvbi93ZWlnaHRzIG9uDQo+IHRo
YXQgcmVzb3VyY2UgY2FuIGJlIHNldCAob3IgaW1wbGVtZW50ZWQpLg0KDQpPdXIgZ29hbCBoZXJl
IGlzIG5vdCB0byBzb2x2ZSBhIHBhcnRpY3VsYXIgY2FzZS4gSW5zdGVhZCwgd2Ugd291bGQgbGlr
ZSANCmEgdW5pdmVyc2FsIHNvbHV0aW9uIGZvciBkaWZmZXJlbnQgY29tYmluYXRpb24gb2YgbWFp
biB3b3JrbG9hZCBhbmQgc2lkZQ0Kd29ya2xvYWQuIGNwdS5oZWFkcm9vbSBtYWtlcyBpdCBlYXN5
IHRvIGFkanVzdCB0aHJvdHRsaW5nIGJhc2VkIG5vIHRoZSANCnJlcXVpcmVtZW50IG9mIHRoZSBt
YWluIHdvcmtsb2FkLiANCg0KQWxzbywgdGhlcmUgYXJlIHJlc291cmNlcyB0aGF0IGNvdWxkIG9u
bHkgYmUgcHJvdGVjdGVkIGJ5IGludGVudGlvbmFsbHkNCmxlYXZlIHNvbWUgaWRsZSBjeWNsZXMu
IEZvciBleGFtcGxlLCBTTVQgc2libGluZ3Mgc2hhcmUgQUxVcywgc29tZXRpbWVzIA0Kd2UgaGF2
ZSB0byB0aHJvdHRsZSBvbmUgU01UIHNpYmxpbmcgdG8gbWFrZSB0aGUgb3RoZXIgc2libGluZyBy
dW4gZmFzdGVyLiANCg0KPiANCj4gT24gVHVlLCBNYXkgMjEsIDIwMTkgYXQgMDQ6Mjc6MDJQTSAr
MDAwMCwgU29uZyBMaXUgPHNvbmdsaXVicmF2aW5nQGZiLmNvbT4gd3JvdGU6DQo+PiBUaGUgb3Zl
cmFsbCBsYXRlbmN5IChvciB3YWxsIGxhdGVuY3kpIGNvbnRhaW5zOiANCj4+IA0KPj4gICAoMSkg
Y3B1IHRpbWUsIHdoaWNoIGlzIChhKSBhbmQgKGQpIGluIHRoZSBsb29wIGFib3ZlOw0KPiBIb3cg
ZG8geW91IG1lYXN1cmUgdGhpcyBDUFUgdGltZT8gRG9lcyBpdCBpbmNsdWRlIHRpbWUgc3BlbnQg
aW4gdGhlDQo+IGtlcm5lbD8gKE9yIGNhbiB0aGVyZSBiZSBhbnl0aGluZyBlbHNlIHVuYWNjb3Vu
dGVkIGZvciBpbiB0aGUgZm9sbG93aW5nDQo+IGNhbGN1bGF0aW9ucz8pDQoNCldlIG1lYXN1cmVz
IGhvdyBtdWNoIHRpbWUgYSB0aHJlYWQgaXMgcnVubmluZy4gSXQgaW5jbHVkZXMga2VybmVsIHRp
bWUuIA0KSSB0aGluayB3ZSBkaWRuJ3QgbWVhc3VyZSB0aW1lcyBzcGVudCBvbiBwcm9jZXNzaW5n
IElSUXMsIGJ1dCB0aGF0IGlzIA0Kc21hbGwgY29tcGFyZWQgd2l0aCBvdmVyYWxsIGxhdGVuY3ku
IA0KDQo+IA0KPj4gICAoMikgdGltZSB3YWl0aW5nIGZvciBkYXRhLCB3aGljaCBpcyAoYik7DQo+
IElzIHlvdXIgYXNzdW1wdGlvbiBvZiB0aGlzIGJlaW5nIGNvbnN0YW50IHN1cHBvcnRlZCBieSB0
aGUgbWVhc3VyZW1lbnRzPw0KDQpXZSBkb24ndCBtZWFzdXJlIHRoYXQgc3BlY2lmaWNhbGx5LiBU
aGUgZGF0YSBpcyBmZXRjaGVkIG92ZXIgdGhlIG5ldHdvcmsNCmZyb20gb3RoZXIgc2VydmVycy4g
VGhlIGxhdGVuY3kgdG8gZmV0Y2ggZGF0YSBpcyBub3QgY29uc3RhbnQsIGJ1dCB0aGUgDQphdmVy
YWdlIG9mIHRob3VzYW5kcyBvZiByZXF1ZXN0cyBzaG91bGQgYmUgdGhlIHNhbWUgZm9yIGRpZmZl
cmVudCBjYXNlcy4gDQoNCj4gDQo+IFRoZSBsYXN0IG5vdGUgaXMgcmVnYXJkaW5nIHNlbWFudGlj
cyBvZiB0aGUgaGVhZHJvb20ga25vYiwgSSdtIG5vdCBzdXJlDQo+IGl0IGZpdHMgd2VsbCBpbnRv
IHRoZSB3ZWlnaHReYWxsb2NhdGlvbl5saW1pdF5wcm90ZWN0aW9uIG1vZGVsLiBJdCBzZWVtcw0K
PiB0byBtZSB0aGF0IGl0J3MgY3JhZnRlZCB0byBzYXRpc2Z5IHRoZSBkaXZpc2lvbiB0byBvbmUg
bWFpbiB3b3JrbG9hZCBhbmQNCj4gc2lkZSB3b3JrbG9hZCwgaG93ZXZlciwgdGhlIGNvbmNlcHQg
ZG9lc24ndCBnZW5lcmFsaXplIHdlbGwgdG8gYXJiaXRyYXJ5DQo+IG51bWJlciBvZiBzaWJsaW5n
cyAoZS5nLiB0d28gY2dyb3VwcyB3aXRoIHNhbWUgaGVhZHJvb20sIHRoaXJkIHdpdGgNCj4gbGVz
cywgd2hvIGlzIHdpbm5pbmc/KS4NCg0KVGhlIHNlbWFudGljcyBpcyBub3QgdmVyeSBzdHJhaWdo
dGZvcndhcmQuIFdlIGRpc2N1c3NlZCBhYm91dCBpdCBmb3IgYSANCmxvbmcgdGltZS4gQW5kIGl0
IGlzIHJlYWxseSBjcmFmdGVkIHRvIHByb3RlY3Rpb24gbW9kZWwuIA0KDQpJbiB5b3VyIGV4YW1w
bGUsIHNheSBib3RoIEEgYW5kIEIgaGF2ZSAzMCUgaGVhZHJvb20sIGFuZCBDIGhhcyAyMCUuIEEg
YW5kDQpCIGFyZSAid2lubmluZyIsIGFzIHRoZXkgd2lsbCBub3QgYmUgdGhyb3R0bGVkLiBDIHdp
bGwgYmUgdGhyb3R0bGVkIHdoZW4NCnRoZSBnbG9iYWwgaWRsZW5lc3MgaXMgbG93ZXIgdGhhbiAx
MCUgKDMwJSAtIDIwJSkuIA0KDQpOb3RlIHRoYXQsIHRoaXMgaXMgbm90IGEgdHlwaWNhbCB1c2Ug
Y2FzZSBmb3IgY3B1LmhlYWRyb29tLiBJZiBtdWx0aXBsZSANCmxhdGVuY3kgc2Vuc2l0aXZlIGFw
cGxpY2F0aW9ucyBhcmUgc2hhcmluZyB0aGUgc2FtZSBzZXJ2ZXIsIHRoZXkgd291bGQgDQpuZWVk
IHNvbWUgcGFydGl0aW9uIHNjaGVtZS4gDQoNClRoYW5rcywNClNvbmcNCg0KDQo=
