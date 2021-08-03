Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286523DE712
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 09:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhHCHOO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 03:14:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30706 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234065AbhHCHON (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 03:14:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17375MUJ006829;
        Tue, 3 Aug 2021 00:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=79998fF840Dkp1r85lrkR0Hrx1OGK4+YPPULC29XaVU=;
 b=BHdHla4gn44VGrNW9wfr1B9ZLxUfrUOcdGGdJ4AFVO6nkIPSam4d1OpzD3+iZUobmvT7
 7wNJJNzicBb72YtHDK76GI7K7a7audDzjrM5Qa6AaA2DW5e6mOaJd0T/ShFfQCNrGy4S
 KFblB9ukZlenK6bWB78YthydEpBn1+/78Ho= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3a6nmmbjt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Aug 2021 00:13:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 00:13:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B/CJMp5pIr8mkFrNekugpXcBVL79J4kLlfLCoHJOD+0bLgsoIVIaHhEmEP7P2vrBCJTBdqYr0jovSffsN1DnBQF6Mph126KrcLe25K2KcAF0Lx30GG1AYN/4yLnf/PPdFlnS5ADcq/vVO0ffJow1BNScpI0AHzFNlFqtkGh3qR10RI2umA9CRR18Ffo1PncWuZcee6GMRUSW3+UZEYW5WsdYINdKi59jVooZR5xdDyEWeIUjZBAOLImmS6l6uMSN9t2jEz9e2dFSvNln2i0lgxo8UK4G+L5Vp3PdO4d5zk4Dg+AlX0MGgyaciPsyF5r3jvYTi9WsVK0359pQG+UMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79998fF840Dkp1r85lrkR0Hrx1OGK4+YPPULC29XaVU=;
 b=k9DVZ8Made3zJc7uxsd4eMUYZJs6D3+AFxdX+l0lKM1HY3zZZc6fu30KShaUnKHp4oZ8w8SzybzZ9kuXlZ/OJ6ZxcUtQL0vozW1vOqrTsq63JgIsVAd2TuwhealgO6s6mKNFyF/FzbcNqMCDQA0+Ke8JITmtIFDkxSoYziQDqXv3oEtgA4kOOS8xjFlK02WQVRBiEbuyUcDezvdBq51LFBrrzN3mXYLJffeKHIUFFqxBRTkChD8oxu/MdHS/+Kch++vRd14f69z/I7q2yDS4gZLu05A1PCGXwhrxr13PbD1fZMb4/keAhqgrE/lszEttCopA3QehxYcRDhWPF4A6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by SJ0PR15MB4646.namprd15.prod.outlook.com (2603:10b6:a03:37b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 07:13:35 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::9520:2bcd:e6fd:1dc7%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 07:13:35 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Miaohe Lin <linmiaohe@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "alexs@kernel.org" <alexs@kernel.org>,
        "richard.weiyang@gmail.com" <richard.weiyang@gmail.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Thread-Topic: [PATCH 2/5] mm, memcg: narrow the scope of percpu_charge_mutex
Thread-Index: AQHXhHlhZOi6jIG+t0KCX9QHt+1jRata1uiAgAA+YwCAAUmkAIAEypsAgAAvQ4CAAAvKgIAAAJyJ
Date:   Tue, 3 Aug 2021 07:13:35 +0000
Message-ID: <898130C3-FDF2-41C2-81DD-D33721C977C6@fb.com>
References: <20210729125755.16871-1-linmiaohe@huawei.com>
 <20210729125755.16871-3-linmiaohe@huawei.com> <YQNsxVPsRSBZcfGG@carbon.lan>
 <YQOhGs3k9rHx3mmT@dhcp22.suse.cz>
 <4a3c23c4-054c-2896-29c5-8cf9a4deee98@huawei.com>
 <YQi6lOT6j2DtOGlT@carbon.dhcp.thefacebook.com>
 <95629d91-6ae8-b445-e7fc-b51c888cad59@huawei.com>,<YQjsHTW+46bG9XsV@dhcp22.suse.cz>
In-Reply-To: <YQjsHTW+46bG9XsV@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c91caa8-9f83-499b-1ed5-08d9564e35c1
x-ms-traffictypediagnostic: SJ0PR15MB4646:
x-microsoft-antispam-prvs: <SJ0PR15MB46463C88BCF5219BEDA23098BEF09@SJ0PR15MB4646.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKEaVOrIfad2vPmYvGIu3OuqZQ1Ujp/LRQDWoAEaHK+0DA8p+IPW0JNqpITx2bMPp2kei/4RK+DNbxfcDmYVYtOmgh+cLwB6SWKWMNaAhmJynyK3pPt91S+yyYvjpTSt0BjIbNg2ftKrKNBp/fHpg9KTdpDeu8gf449a28BsHkyVF6EjUspkrS+F4uQJBQL7ag+YdKYLMekLIOurGRez9G5UVPdSE0Q5iNbx7fBTrDOiMA/ZC/UtKoREP8xmwyWFtwqUhfXOw2/XFecvpEz3U4OydAkWNnBmvCtNFyz3UYDg1fAialRO1zlmLSN9cXW666I/1TuUXmk3ifp+Tt0Dqjrj0LUevyQebWGHDzMek6B7qIoKcazFtpNexkagi/A0lbCuwXGlHapChoAuAMBemKnV8G4HsyITf8mvplhi4WDehcCm44SiDevvQKddbLvNjRJiFAyjbN9eUIlI9MTanTko8xGbtvxW6wj3CoD3vWvuu/Qy771TDt9lbHaSRy8ofZ8QHbp/Gzgwf4nBhokPCEM13MdvVg5UQgpdqdCXPxzM0eT68WIF9aG81Br/IcgwLlnRvuKnNYDjxG23B+hL2nHRwpklYkAd8/xxi4xsGezwsfFg9S6+VvBn4iACkd1gCnboeQdB0d27qI8xN6Axkj1PZa60vlMcLkOV9xFuXhtxgn8wMMjiWLUC233W61THRKb697BAc5QQNzDD8uEcDMeNaEok/3W19z9iuED4gbk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(36756003)(53546011)(6506007)(2906002)(38100700002)(6486002)(86362001)(122000001)(71200400001)(8676002)(316002)(478600001)(6512007)(38070700005)(5660300002)(54906003)(66476007)(2616005)(6916009)(76116006)(186003)(8936002)(83380400001)(7416002)(4326008)(66556008)(64756008)(66446008)(33656002)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmxWSUNBd2w1dEVCaGtaMlRueEFHa0thOUo3cnRtbmNzTU9rN1RoTUZINW5V?=
 =?utf-8?B?Z3FuMHA1ZEFRVTk3REt3clM0bU0reGo5VWd5VHo1cDhLZFA3U3NDRlEvZWM2?=
 =?utf-8?B?dHRkcUVCN3NoWjhLNm0zWkI5T2xYVGUvLzJ6S3RGSHNwUTBZRFhFVGVEaFNL?=
 =?utf-8?B?WTVGdDJWb20rMUFJdE1lUlZreURLakJQZjVQUmw2eVIwSWNZZVI0K1cybjhU?=
 =?utf-8?B?bGRRMDhlMjdSVEhJN2RRZ2U4U2hJaGQrN1RNNmlXNzlKREYvbmFsVlNOemN4?=
 =?utf-8?B?VlNvOVpMTmpjODAyZllOQTgvak1nQ2ZJMkt6clA2YVA1R1ZhRVNzT0NGTXl6?=
 =?utf-8?B?a3NXQ3BIbjFuMWZnSTBNMGFGbUdBeGpkQXJLWWpaRktVSmw4L2N2MFhoa1NZ?=
 =?utf-8?B?cmExZmNUejJFci81cjJxZTVmbFgwaW1qRjR5Q3dOd2s1M3ZJejVNZWFJMm5O?=
 =?utf-8?B?eUZlbHlmcFhmeHdtckhVZCtMQ1NUWlRZMXBnSUtleG9sTGlPMjVqNVdpTS9X?=
 =?utf-8?B?cmN0eVdxcWQ0NmpKdDhQaU9oUzVTeVFFazdwWVpzZFRRcHgremZJa2svbzll?=
 =?utf-8?B?RG1nSmhLRTZLZ2N6MXJvRHVxN3p4NFI2dHVQS29qNytRYmVKbERCdktiamx2?=
 =?utf-8?B?L2JPWTNHRnpuZWVUMFkvV1htRnhmaStXUjN3aFVKQ1ZtL2pyQXlWRktUS3pE?=
 =?utf-8?B?Z2c3UUoyd1kxaHRRWGZDZVF4Z3FKMzlyNVRXMVM1dkcrOUQ3Z01ReHlxbDlo?=
 =?utf-8?B?YmhQUUxsR3Q3bENFdisvSFNhQTZOSlY4aWJOUUVBdENlVDRCRU9XRE85U3li?=
 =?utf-8?B?S0hCTlZpeUhiV1g0NENZOWJlNm9LdzkvRFpCM3hHSEVUbCsvNnNTMExLaHpy?=
 =?utf-8?B?RVRKdk1iU1hxMk5ETWpJRFhlbUxva0lTQnduNGcrb0FFWWNhU3c2MWlVZXQ3?=
 =?utf-8?B?TTk0VHRvSE9UWExwWE0xUmNGSVdleHh4bFhPM1VlK3FmYk9BZDVHaVh3bjhm?=
 =?utf-8?B?aGpiUDNOaDNja244WnA4aVdQVDVHS0hjcnJ6QUFvQXc1d2ZUV3BJMGsxaHBX?=
 =?utf-8?B?V2w5TDhjY3p0TllpMDByVHJDSjl6ZVJTN2RDc2hYRWlSSytkOFBGZ1pvT2hn?=
 =?utf-8?B?c0RXZ01DUlhJZlBMeWF1TnovNTNuSVFrWkpSRGNtSmRObXpMSSs4T2xHMVdD?=
 =?utf-8?B?WUdiUVFKUTN4KzlScXduRTNwSW94dWZHUkorMW9YWGxDYTAwcG1aN21iTmZv?=
 =?utf-8?B?UHRSUkpETG5LKzlYWHdvd2FNcE9aR2VEaVh4QWFqQmkydisyYnphNTBwVTBF?=
 =?utf-8?B?Zk02V2R4SjBSSWJYdVVOSlNQL1d3bjhvQWNXeE5VTVdnQ01SUitTUG1RblVy?=
 =?utf-8?B?T3FZakNKNjZLbzUralllNzFNejBtWk0wejVsTU14Z1JMV2NOOEU3c2hESHhL?=
 =?utf-8?B?WmlGelpaOHBmZVcvY3gxaWNiYUczaFdVWFJoQ2t4UVo2MWozVHpSYXRabjFu?=
 =?utf-8?B?aHBHZkdlRzlZc0paWnRlY2JOczNYeWx0NUpEMStDenl5L2tNUHB0K0Q2OEdD?=
 =?utf-8?B?SVNlUGVLdGR2L1NpL1VIRENrNktNUHFkUTY2MlVXenJTUmI0emNGd1RIcHFX?=
 =?utf-8?B?N0RzMnNlMlZLRG53Y2locnluTTMyaU1tTkV2WlkvdmJEZ01nWXI3WHp3YWxH?=
 =?utf-8?B?TXI2SGtlT1JNbGswbnlGa2dZNk40RDhGYjNCdWw3V2drSUZoeEZnR2dBNmZ2?=
 =?utf-8?B?eFlOaEkxcnhIWkZyRi9aWTV2SUhpVVdsUXU3UytJeEFLVG00WTlnWk9EUFJ4?=
 =?utf-8?B?Y3BFdndpejFCbnVlbXhnTUNOdW9oazZJdlNnLy9kR1ZWKzVxRTJ4Zytka25p?=
 =?utf-8?Q?K/8ym9Ont0RC5?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c91caa8-9f83-499b-1ed5-08d9564e35c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 07:13:35.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vclONUnK+b84OSzA1XPtMn1P6fq+UZ93P4XPgly0sxghxjFFufzPsfcZy1rLu1QT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4646
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6eQZDRQcsRWjvL6gkoAKWyO8xzSgZJW1
X-Proofpoint-ORIG-GUID: 6eQZDRQcsRWjvL6gkoAKWyO8xzSgZJW1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-02,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=969 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SeKAmWQgZ28gd2l0aCBhdG9taWNfZGVjKCkuDQoNClNlbnQgZnJvbSBteSBpUGhvbmUNCg0KPiBP
biBBdWcgMywgMjAyMSwgYXQgMDA6MTEsIE1pY2hhbCBIb2NrbyA8bWhvY2tvQHN1c2UuY29tPiB3
cm90ZToNCj4gDQo+IO+7v09uIFR1ZSAwMy0wOC0yMSAxNDoyOToxMywgTWlhb2hlIExpbiB3cm90
ZToNCj4gWy4uLl0NCj4+IGRpZmYgLS1naXQgYS9tbS9tZW1jb250cm9sLmMgYi9tbS9tZW1jb250
cm9sLmMNCj4+IGluZGV4IDYxNmQxYTcyZWNlMy4uNjIxMGIxMTI0OTI5IDEwMDY0NA0KPj4gLS0t
IGEvbW0vbWVtY29udHJvbC5jDQo+PiArKysgYi9tbS9tZW1jb250cm9sLmMNCj4+IEBAIC0yMjA4
LDExICsyMjA4LDExIEBAIHN0YXRpYyB2b2lkIHJlZmlsbF9zdG9jayhzdHJ1Y3QgbWVtX2Nncm91
cCAqbWVtY2csIHVuc2lnbmVkIGludCBucl9wYWdlcykNCj4+ICAqLw0KPj4gc3RhdGljIHZvaWQg
ZHJhaW5fYWxsX3N0b2NrKHN0cnVjdCBtZW1fY2dyb3VwICpyb290X21lbWNnKQ0KPj4gew0KPj4g
LSAgICAgICBzdGF0aWMgREVGSU5FX01VVEVYKHBlcmNwdV9jaGFyZ2VfbXV0ZXgpOw0KPj4gICAg
ICAgIGludCBjcHUsIGN1cmNwdTsNCj4+ICsgICAgICAgc3RhdGljIGF0b21pY190IGRyYWluZXIg
PSBBVE9NSUNfSU5JVCgwKTsNCj4+IA0KPj4gICAgICAgIC8qIElmIHNvbWVvbmUncyBhbHJlYWR5
IGRyYWluaW5nLCBhdm9pZCBhZGRpbmcgcnVubmluZyBtb3JlIHdvcmtlcnMuICovDQo+PiAtICAg
ICAgIGlmICghbXV0ZXhfdHJ5bG9jaygmcGVyY3B1X2NoYXJnZV9tdXRleCkpDQo+PiArICAgICAg
IGlmIChhdG9taWNfY21weGNoZygmZHJhaW5lciwgMCwgMSkgIT0gMCkNCj4+ICAgICAgICAgICAg
ICAgIHJldHVybjsNCj4+ICAgICAgICAvKg0KPj4gICAgICAgICAqIE5vdGlmeSBvdGhlciBjcHVz
IHRoYXQgc3lzdGVtLXdpZGUgImRyYWluIiBpcyBydW5uaW5nDQo+PiBAQCAtMjI0NCw3ICsyMjQ0
LDcgQEAgc3RhdGljIHZvaWQgZHJhaW5fYWxsX3N0b2NrKHN0cnVjdCBtZW1fY2dyb3VwICpyb290
X21lbWNnKQ0KPj4gICAgICAgICAgICAgICAgfQ0KPj4gICAgICAgIH0NCj4+ICAgICAgICBwdXRf
Y3B1KCk7DQo+PiAtICAgICAgIG11dGV4X3VubG9jaygmcGVyY3B1X2NoYXJnZV9tdXRleCk7DQo+
PiArICAgICAgIGF0b21pY19zZXQoJmRyYWluZXIsIDApOw0KPiANCj4gYXRvbWljX3NldCBkb2Vz
bid0IGltcGx5IG1lbW9yeSBiYXJyaWVyIElJUkMuIElzIHRoaXMgc2FmZT8NCj4gDQo+IC0tIA0K
PiBNaWNoYWwgSG9ja28NCj4gU1VTRSBMYWJzDQo=
