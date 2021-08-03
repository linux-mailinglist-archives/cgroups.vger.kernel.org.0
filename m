Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16533DF05F
	for <lists+cgroups@lfdr.de>; Tue,  3 Aug 2021 16:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhHCOen (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Aug 2021 10:34:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:26072 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234683AbhHCOem (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Aug 2021 10:34:42 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 173EY6tY027819;
        Tue, 3 Aug 2021 07:34:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CT6/HOf97jS43kUCtPhkPIIFyT2ScXjvlO0MM1RISSQ=;
 b=UivFhhiUtIqrb6ubVPSuBqtmvsJRJ414quzdJfTHX96Rphds4/HEVoPnEXdruYCKmN8P
 9pIT4nV/BMMr66iXbiZEpUryswo/mfGAuRkMa/zIxWolRR+Q3a0kwJkih1rxW6QYY3TS
 +1uOfUh3vrqklaLAZaNknegn2BF8TtdIjho= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3a6px752pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 03 Aug 2021 07:34:25 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 07:34:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWOHw+IODcWNQznN7ZABYyqbV/mzNEKVsOYC2IamBWmORWgBgEP5qwrH2nyiESEWq5hsrM7PC+8gcS4FhSAlFduLKpUHFEUvDMnDrotPHA9rNo63I4xp7u0p6Q2Ld98xC0tuoynxPOL6+3azwgr5ABt63Z0JPaEoO212dPv8PapjvrRBzblhbmVhsr25EdJNG1H0s5KNiy10pBYylfHnqj3sQjBpyeqzG34yw1NgzkwDRD16JfMQxVlgG0BxnfD3sab1AibyoGL2v4RsSaRKnd176pjkpNzPB4GidBIkKLRHLvRJDavlhMzwB7ZmnHAn/3eTdSE6U3Qt/XjmWIL0Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT6/HOf97jS43kUCtPhkPIIFyT2ScXjvlO0MM1RISSQ=;
 b=KxjBdRw1jSojz8mvbG6MRpWmnM0TCByYtQxW3S/XwNuWf4UlQSj+0NnIrEg6cbKD5nMQp9p2I3oRpVn4NxcmzeHBOSMWTHUSISJIBJOLSD+B84mNaewZAlHK5JA04GjpUli9zkYMZLVaWuQUBGrhHsPhXtBPfMoevu5Eb0YqZkag8l+DjjTl2m3jnXB3hO9u5EIzjZZHtOJWCvR0OGesLKztsO1pX0Evn7/LtxeDCc2oLCumYfX8jQwD7YWbjZOZM2B+N0oT19Zny8CHRTa0c9wA+bXJ83WfpnBhzV2d2Pnu9D7u+o7EUm+GTu0p0VwsO9P3O6/n00rXitjOWzR90w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB3327.namprd15.prod.outlook.com (2603:10b6:208:fd::28)
 by MN2PR15MB2845.namprd15.prod.outlook.com (2603:10b6:208:ec::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Tue, 3 Aug
 2021 14:34:23 +0000
Received: from MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c]) by MN2PR15MB3327.namprd15.prod.outlook.com
 ([fe80::311e:701a:589c:249c%4]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 14:34:23 +0000
From:   Rik van Riel <riel@fb.com>
To:     "shakeelb@google.com" <shakeelb@google.com>
CC:     Kernel Team <Kernel-team@fb.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Thread-Topic: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Thread-Index: AQHXgi7+kFjHsY/NM0SDAPAR8veOlKtVXfCAgAGs2QCACtolAA==
Date:   Tue, 3 Aug 2021 14:34:23 +0000
Message-ID: <f3bc8b44d58a5e63178dee40f9c119cfc8bf669b.camel@fb.com>
References: <20210726150019.251820-1-hannes@cmpxchg.org>
         <2b0b08f9385b25fb7750dbe453516b0c8bb27604.camel@fb.com>
         <CALvZod5JmcSpym6oXMXEUXEq2u13SVLRaVGPg84ubeYZt-6w_g@mail.gmail.com>
In-Reply-To: <CALvZod5JmcSpym6oXMXEUXEq2u13SVLRaVGPg84ubeYZt-6w_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9872a8e6-03e7-4f23-acd2-08d9568bc9c1
x-ms-traffictypediagnostic: MN2PR15MB2845:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB28451ED9BA9F24F29ECB3B4EA3F09@MN2PR15MB2845.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DJq/iFjIzw06m8CGC9Zet4X3HPrbb5j0ngnvhpR303ZVTgGLK6AZ3d4a1CWDxO/EKiCeil0nEbspQCINWrD/6Cg4CsEWWJQwgeUwTgx9lMmho88CMfEAMqy7/uQG4YvS3eUrjM3L6VpW2Sj0ho+cNxa1GiTbfHA9Ftk70Neu21Z+ZrhE91ZpFkaX+DA9IDRPaUcljYzWc8BMTWHe9k7BEogYJAh3iuOJIntpINaswu0LQCUy8OqVyoYw9rm9REjDoayNlmhYNVozrYYMDLjPRB5iirJ+aOUrt1kahHtLL1PQ3uyQvuVKEX1VPrlbXjqz8q40U9qVZq1/2BesDkSt/xv2neyorg9VfPq3oYzbMN17eu0TlE40hKAapAHqXtq3W/Vku/MROylefWAHGa3MJTXj742OdO0R6EGiqcOsdfwEdYbUo8in1bMYWWGlRGRJ1IRzs7Z+IGnsvhVGRQ0XL53/fmHoTstqFYKPPyiGpx83l3f+tDPbfKPgJCn537O7VXEQUrSTxnpxuMnOtHVYQ6cmQOV/9OGQsvmKSmd7Jr4I8q/QBojSQPqSh1GTstsnvzMf+OA+xQHOFDmJb0inMdeoBHRxaqTYnGZNN9MUNa9RbH0BkZsih/PlY48k9vC+aEaLQFdOtHucS1RPOrHwRif6gLnzUHjSustOx726KNCIgFqR4BZq3XSOS5HJt8p587D9mXE3chgtvKw6kWZEyg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3327.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(66446008)(64756008)(66946007)(66556008)(36756003)(76116006)(66476007)(71200400001)(2906002)(478600001)(86362001)(83380400001)(5660300002)(4326008)(38100700002)(54906003)(6506007)(122000001)(53546011)(8676002)(8936002)(38070700005)(316002)(2616005)(6512007)(6486002)(186003)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjE1QjAvMjBrRGtjangvQWowbnlrZytERVFqV0Q0MW1NTmQvQWExWGpkYzQ1?=
 =?utf-8?B?SFlFQjVLRUl2ZmNwRmFVYTR4SmdubTFuUXlFbzZKeVU0aUFuMUtoKzJCZG1u?=
 =?utf-8?B?RU5HMkVycFVWMUhaajIxam95T0p2YVVVV2gwOGdUWWU4MURJb1k4dHlLT29s?=
 =?utf-8?B?RUJmcTloaUtpUDhReVVpRERSQkprK1RqZjdHa0dkSnRyUko0UG43M08yOUZr?=
 =?utf-8?B?eFo3NzJHZ3BkRm85S3AxM3pIWUMrLzUydGFmK3BHTE1abDI0ZWFuWlZuY3VJ?=
 =?utf-8?B?TVVwS1ZrVlhGTm15dnNZZDZSZTJONXJ2OVJ4MTBER2xQVThhRG9YeTdWMTFq?=
 =?utf-8?B?QnlIU1REZWJuall3Q1pLL043L3FNZGRZWThDMFhtU0JZZTEyaFdxWkJnN0dz?=
 =?utf-8?B?UFc5UVdIYkZiV0ZWT1NHVWRvMVRxOENpcEsxK1Zvcm9GYUt2azZvWk5SZ2lT?=
 =?utf-8?B?UVZlcFR6NGMzMG1hNVVKaVhVTEliZUVEb1VBNmt4MUNjS0FTd2lpOXNkNzZm?=
 =?utf-8?B?QkxWNm40MGsvczdOUW9LbHBYSUNINUEzQUNmL3pBNmJYcUs2QTZWTzhxdU1V?=
 =?utf-8?B?MHZYaUxtL1hKbkZ0SFZVOXIzQm9iN01CdkY2UFBjZU9DbmhtQlVZUVFsY2tN?=
 =?utf-8?B?WWFXWjdiVW5SZnYySlBhY3BuSDRiWG5abHZobXpNaGtuYm83U0ZOYVpaUlMr?=
 =?utf-8?B?V3JmOVZMWjA5NUpEZXFhYkM3OE11cEdCYXcvUkFRV2tjQWNUNm90cHphNDRy?=
 =?utf-8?B?UjZwQ3piUkVZMWVkbWxETENwS1hVcUNhS0hYQ2ljZmV6VkliSlV6OE5qbmFj?=
 =?utf-8?B?RUozWmlNRksyUVM0VGcyMWY1anllVWliaXFGUkY5emdCYm5jK0ExdklubnQw?=
 =?utf-8?B?eHp2enpjbHJDRVd0eXBucjNudU1MN3dHeWtUWFl2dlZkS0RxU09uanlWdDRv?=
 =?utf-8?B?cHBJZXcxZzhYYzM1NWVJQTJ1VGJFYTVoR1dQUlR3RG15LzB5N0FkdS9yUVFq?=
 =?utf-8?B?RHg1eFNvVTgxelAxd3Y0T2w5NlJZckRka1FJWTRaOWhXN3ZHZVBvcTN0WFBS?=
 =?utf-8?B?ZEloek41L0MwY2ZmdHFuSjZxZ0lyTHh1ZjRoUFRKNURXTStLSU9ka2s2czJQ?=
 =?utf-8?B?L1ZnT0xuekEyTmgrMmplcVlvQ0xLUEVVOG5IT0d6Sk5ORDVtdjQ5blJXOUJO?=
 =?utf-8?B?Zmk3eDRzaXZEd2UwQUdkZXJKS1RBTWl1ZWo1RjJod1ZrdlBra1Jna3NWbmFl?=
 =?utf-8?B?a1E0WDdWNjZHVkR2TVpqQTZEZHpiWmoyTktqSFN5c09RdUhoSWd3ZjNSeTZk?=
 =?utf-8?B?QmR6NStVUk53QmlzU1hTdEFKZjMraWpuNFJYK3lDeThWcmV1OStHR0g4ZTlT?=
 =?utf-8?B?YVBNcXV4RTU5WWJlMmJIYVR4eE8wSjdlMlUzSVVVekNwdnZyNnJacDZTMlF0?=
 =?utf-8?B?QmlVamJGcXhtNWxGSGhqa1FuMnp0NTdtOFVXbm9PZ1ltUzRzTG10Ym5yRmZK?=
 =?utf-8?B?NWE2VEVCT08rVkdja1lweG4renc3Sy9zVjNRRUZ4K3pNR1lwTHNLQ1FuZlFi?=
 =?utf-8?B?UWRFeDN4ZlJvR0tzamR3MUU5REppbThEZmo2MGZMTm15K2ZDeXJEQy80Z0Vz?=
 =?utf-8?B?TFljK2RES2xDNFU5MHVMUWNsbmZxcjV5Vk1wRXNtbytNcTZmU3hKcGY2QjY5?=
 =?utf-8?B?eDdZYUFOU25STnlmRTdncEg3aUpId21ZM3ROWG1EN3U3ZjBHYklXZHBvekE2?=
 =?utf-8?B?V21Edk5rb2hIZW5NUjJXMlg1b2NzUkExTFdzUDhSZGo2RkFrbjFUbUJncWxI?=
 =?utf-8?Q?gswjpeA4zQvLtIhreLNbyZA1A3Fu04w+Ljmzs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B112876F763DE947905D25E0FC1C39C5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3327.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9872a8e6-03e7-4f23-acd2-08d9568bc9c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 14:34:23.3732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oReivoL2WJIu/B++VhliApsQEL3xWxqso6X1ARBa+F+hHdaFygygCSEsAtDqdHCg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2845
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: FAsO7miqH_L-Z6lVcSM8s3Pa3-tAKMc2
X-Proofpoint-ORIG-GUID: FAsO7miqH_L-Z6lVcSM8s3Pa3-tAKMc2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_04:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030096
X-FB-Internal: deliver
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

T24gVHVlLCAyMDIxLTA3LTI3IGF0IDA5OjUxIC0wNzAwLCBTaGFrZWVsIEJ1dHQgd3JvdGU6DQo+
IE9uIE1vbiwgSnVsIDI2LCAyMDIxIGF0IDg6MTkgQU0gUmlrIHZhbiBSaWVsIDxyaWVsQGZiLmNv
bT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gTW9uLCAyMDIxLTA3LTI2IGF0IDExOjAwIC0wNDAwLCBK
b2hhbm5lcyBXZWluZXIgd3JvdGU6DQo+ID4gPiANCj4gPiA+IF9fbWVtX2Nncm91cF90aHJlc2hv
bGQoKSBpbmRlZWQgaG9sZHMgdGhlIHJjdSBsb2NrLiBJbiBhZGRpdGlvbiwNCj4gPiA+IHRoZQ0K
PiA+ID4gdGhyZXNob2xkaW5nIGNvZGUgaXMgaW52b2tlZCBkdXJpbmcgc3RhdCBjaGFuZ2VzLCBh
bmQgdGhvc2UNCj4gPiA+IGNvbnRleHRzDQo+ID4gPiBoYXZlIGlycXMgZGlzYWJsZWQgYXMgd2Vs
bC4gSWYgdGhlIGxvY2sgYnJlYWtpbmcgb2NjdXJzIGluc2lkZQ0KPiA+ID4gdGhlDQo+ID4gPiBm
bHVzaCBmdW5jdGlvbiwgaXQgd2lsbCByZXN1bHQgaW4gYSBzbGVlcCBmcm9tIGFuIGF0b21pYyBj
b250ZXh0Lg0KPiA+ID4gDQo+ID4gPiBVc2UgdGhlIGlyc2FmZSBmbHVzaGluZyB2YXJpYW50IGlu
IG1lbV9jZ3JvdXBfdXNhZ2UoKSB0byBmaXggdGhpcw0KPiA+IA0KPiA+IFdoaWxlIHRoaXMgZml4
IGlzIG5lY2Vzc2FyeSwgaW4gdGhlIGxvbmcgdGVybSBJIHRoaW5rIHdlIG1heQ0KPiA+IHdhbnQg
c29tZSBzb3J0IG9mIHJlZGVzaWduIGhlcmUsIHRvIG1ha2Ugc3VyZSB0aGUgaXJxIHNhZmUNCj4g
PiB2ZXJzaW9uIGRvZXMgbm90IHNwaW4gbG9uZyB0aW1lcyB0cnlpbmcgdG8gZ2V0IHRoZSBzdGF0
aXN0aWNzDQo+ID4gb2ZmIHNvbWUgb3RoZXIgQ1BVLg0KPiA+IA0KPiA+IEkgaGF2ZSBzZWVuIGEg
bnVtYmVyIG9mIHNvZnQgKElJUkMpIGxvY2t1cHMgZGVlcCBpbnNpZGUgdGhlDQo+ID4gYm93ZWxz
IG9mIGNncm91cF9yc3RhdF9mbHVzaF9pcnFzYWZlLCB3aXRoIHRoZSBmdW5jdGlvbiB0YWtpbmcN
Cj4gPiBtdWx0aXBsZSBzZWNvbmRzIHRvIGNvbXBsZXRlLg0KPiANCj4gQ2FuIHlvdSBwbGVhc2Ug
c2hhcmUgYSBiaXQgbW9yZSBkZXRhaWwgb24gdGhpcyBsb2NrdXA/IEkgYW0gd29uZGVyaW5nDQo+
IGlmIHRoaXMgd2FzIGR1ZSB0byB0aGUgZmx1c2ggbm90IGhhcHBlbmluZyBtb3JlIG9mdGVuIGFu
ZCB0aHVzIHRoZQ0KPiB1cGRhdGUgdHJlZSBpcyBsYXJnZSBvciBpZiB0aGVyZSBhcmUgdG9vIG1h
bnkgY29uY3VycmVudCBmbHVzaGVzDQo+IGhhcHBlbmluZy4NCg0KSSB3YXMgbm90IGxvZ2dlZCBp
bnRvIGFueSBzeXN0ZW0gd2hpbGUgaXQgaGFwcGVuZWQsIGJ1dA0Kb25seSBmb3VuZCBpdCBsYXRl
ciBpbiB0aGUgbG9ncy4NCg0KSSBzdXNwZWN0IHlvdXIgZXhwbGFuYXRpb24gaXMgdGhlIHJlYXNv
biB3aHkgaXQgaGFwcGVuZWQsDQp0aG91Z2guDQoNCg==
