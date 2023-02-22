Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C364569F0D2
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 10:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjBVJBR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 04:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjBVJBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 04:01:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14402E811
        for <cgroups@vger.kernel.org>; Wed, 22 Feb 2023 01:01:15 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-143-23q2w5B5PN6fPRJeaTFZqg-1; Wed, 22 Feb 2023 09:01:11 +0000
X-MC-Unique: 23q2w5B5PN6fPRJeaTFZqg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Wed, 22 Feb
 2023 09:01:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Wed, 22 Feb 2023 09:01:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>
CC:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yue Zhao <findns94@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: change memcg->oom_group access with atomic operations
Thread-Topic: [PATCH] mm: change memcg->oom_group access with atomic
 operations
Thread-Index: AQHZRfujbWkXm/SALUSQLx6HdIkuPa7ap5/g
Date:   Wed, 22 Feb 2023 09:01:05 +0000
Message-ID: <e7f5f9686a5d4872a2e530550228718f@AcuMS.aculab.com>
References: <20230220230624.lkobqeagycx7bi7p@google.com>
 <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com>
 <Y/TMYa8DrocppXRu@casper.infradead.org>
In-Reply-To: <Y/TMYa8DrocppXRu@casper.infradead.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RnJvbTogTWF0dGhldyBXaWxjb3gNCj4gU2VudDogMjEgRmVicnVhcnkgMjAyMyAxMzo1MQ0KLi4u
DQo+ID4gRm9yIHRoaXMgcGFydGljdWxhciBjYXNlLCBkb2N1bWVudGluZyBzdWNoIGFuIGFjY2Vz
cy4gVGhvdWdoIEkgZG9uJ3QNCj4gPiB0aGluayB0aGVyZSBhcmUgYW55IGFyY2hpdGVjdHVyZXMg
d2hpY2ggbWF5IHRlYXIgYSBvbmUgYnl0ZSByZWFkL3dyaXRlDQo+ID4gYW5kIG1lcmdpbmcvcmVm
ZXRjaGluZyBpcyBub3QgYW4gaXNzdWUgZm9yIHRoaXMuDQo+IA0KPiBXb3VsZG4ndCBhIGNvbXBp
bGVyIGJlIHdpdGhpbiBpdHMgcmlnaHRzIHRvIGltcGxlbWVudCBhIG9uZSBieXRlIHN0b3JlIGFz
Og0KPiANCj4gCWxvYWQtd29yZA0KPiAJbW9kaWZ5LWJ5dGUtaW4td29yZA0KPiAJc3RvcmUtd29y
ZA0KPiANCj4gYW5kIGlmIHRoaXMgaXMgYSBsb2NrbGVzcyBzdG9yZSB0byBhIHdvcmQgd2hpY2gg
aGFzIGFuIGFkamFjZW50IGJ5dGUgYWxzbw0KPiBiZWluZyBtb2RpZmllZCBieSBhbm90aGVyIENQ
VSwgb25lIG9mIHRob3NlIENQVXMgY2FuIGxvc2UgaXRzIHN0b3JlPw0KPiBBbmQgV1JJVEVfT05D
RSB3b3VsZCBwcmV2ZW50IHRoZSBjb21waWxlciBmcm9tIGltcGxlbWVudGluZyB0aGUgc3RvcmUN
Cj4gaW4gdGhhdCB3YXkuDQoNClNvbWUgYWxwaGEgY3B1IGNvdWxkbid0IGRvIGJ5dGUgbWVtb3J5
IGFjY2Vzc2VzIC0gc28gYWx3YXlzDQpkaWQgMzJiaXQgcmVhZC1tb2RpZnktd3JpdGUuIEJ1dCBM
aW51eCBkb2Vzbid0IHN1cHBvcnQgdGhvc2UNCm9uZXMgYW55IG1vcmUuDQoNCk9uIGFybSAxNmJp
dCBzdHJ1Y3R1cmUgbWVtYmVycyBjYW4gYmUgYWNjZXNzZWQgd2l0aCAzMmJpdA0KaW5zdHJ1Y3Rp
b25zIGJlY2F1c2UgdGhlIDE2Yml0IG9uZXMgaGF2ZSBhIHNtYWxsZXIgb2Zmc2V0Lg0KDQpPbiB4
ODYgdGhlIGJpdCBvcGVyYXRpb25zIG1pZ2h0IGFjY2VzcyB0aGUgKHBvc3NpYmx5IG1pc2FsaWdu
ZWQpDQozMmJpdCB3b3JkIGNvbnRhaW5pbmcgdGhlIHJlcXVpcmVkIGJpdCAtIGJ1dCB0aGV5IGFy
ZSBsb2NrZWQuDQoNCklTVFIgYSBwcm9ibGVtIHdoZXJlIGdjYyB3YXMgdXNpbmcgd2lkZXIgaW5z
dHJ1Y3Rpb25zIGFuZA0KZG9pbmcgYSBSTVcgb24gYW4gYWRqYWNlbnQgdm9sYXRpbGUgZmllbGQu
DQoNCkkgcmVhbGx5IGNhbid0IHJlbWVtYmVyIHRoZSBqdXN0aWZpY2F0aW9uIGZvciBub3QgbWFy
a2luZw0KZmllbGRzIHRoYXQgaGF2ZSB1bmxvY2tlZCBhY2Nlc3NlcyAndm9sYXRpbGUnIGluc3Rl
YWQgb2YNCnJlcXVpcmluZyBhbGwgdGhlIGFjY2Vzc2VzIGJlIGRvbmUgYXMgZXhwbGljaXQgdm9s
YXRpbGUgb25lcy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

