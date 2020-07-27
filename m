Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBB22E43F
	for <lists+cgroups@lfdr.de>; Mon, 27 Jul 2020 05:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgG0DOl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 26 Jul 2020 23:14:41 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgG0DOl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:41 -0400
Received: from DGGEML402-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 2F35626C562FB5507ACA;
        Mon, 27 Jul 2020 11:14:39 +0800 (CST)
Received: from DGGEML508-MBX.china.huawei.com ([169.254.3.30]) by
 DGGEML402-HUB.china.huawei.com ([fe80::fca6:7568:4ee3:c776%31]) with mapi id
 14.03.0487.000; Mon, 27 Jul 2020 11:14:29 +0800
From:   jingrui <jingrui@huawei.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>,
        "Fangxiuning (Jack, EulerOS)" <fangxiuning@huawei.com>
Subject: =?gb2312?B?UkU6ILTwuLQ6IFBST0JMRU06IGNncm91cCBjb3N0IHRvbyBtdWNoIG1lbW9y?=
 =?gb2312?Q?y_when_transfer_small_files_to_tmpfs?=
Thread-Topic: =?gb2312?B?tPC4tDogUFJPQkxFTTogY2dyb3VwIGNvc3QgdG9vIG11Y2ggbWVtb3J5IHdo?=
 =?gb2312?Q?en_transfer_small_files_to_tmpfs?=
Thread-Index: AdZfPbaDbBlN0uuzRT+WBs1zGYD4fAAETDVgAH9ylAAAE+ehUP//nlQA//tVE3A=
Date:   Mon, 27 Jul 2020 03:14:28 +0000
Message-ID: <2E04DD7753BE0E4ABABF0B664610AD6F2621907D@dggeml508-mbx.china.huawei.com>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200724075508.GF4061@dhcp22.suse.cz>
 <2E04DD7753BE0E4ABABF0B664610AD6F2620D4F6@dggeml528-mbx.china.huawei.com>
 <20200724113530.GH4061@dhcp22.suse.cz>
In-Reply-To: <20200724113530.GH4061@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.43]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Q2MgRmFuZ3hpdW5pbmcNCg0KT24gRnJpIDI0LTA3LTIwIDA5OjM1OjI2LCBqaW5ncnVpIHdyb3Rl
Og0KPiANCj4gT24gRnJpZGF5LCBKdWx5IDI0LCAyMDIwIDM6NTUgUE0sIE1pY2hhbCBIb2NrbyB3
cm90ZToNCj4gDQo+ID4gV2hhdCBpcyB0aGUgcmVhc29uIHRvIHJ1biB1bmRlciAhcm9vdCBjZ3Jv
dXAgaW4gdGhvc2Ugc2Vzc2lvbnMgaWYgeW91IGRvIG5vdCBjYXJlIGFib3V0IGFjY291bnRpbmcg
YW55d2F5PyANCj4gDQo+IFRoZSBzeXN0ZW1kIG5vdCBzdXBwb3J0IHJ1biB0aG9zZSBzZXNzaW9u
cyB1bmRlciByb290IGNncm91cCwgZGlzYWJsZSANCj4gcGFtLXN5c3RlbWQgd2lsbCBub3QgY3Jl
YXRlIHNlc3Npb24vY2dyb3VwLCBidXQgdGhpcyBpcyBub3Qgc2FmZSBhbmQgDQo+IG1ha2Ugc3lz
dGVtZC1sb2dpbmQgbm90IHdvcmsuDQoNCkNvdWxkIHlvdSBiZSBtb3JlIHNwZWNpZmljIHBsZWFz
ZT8NCg0KQXMgSSBrbm93LCB3aGVuIHVzZXIgY2FsbCBzZnRwIGNsaWVudCB0byBzZW5kIGZpbGVz
LCB0aGUgc2VydmVyIHdpbGwgY2FsbCBwYW0tc3lzdGVtZC5zbyBsaWIgdG8gY3JlYXRlIHNlc3Np
b24gYW5kIGNncm91cC4NCldlIGNhbiBza2lwIGNhbGwgcGFtLXN5c3RlbWQuc28gYnkgY29uZmln
IC9ldGMvcGFtLmQvcGFzc3dvcmQtYXV0aCBkcm9wIHRoZSBsaW5lICIgLXNlc3Npb24gICAgIG9w
dGlvbmFsICAgICAgcGFtX3N5c3RlbWQuc28iLg0KQnV0IHRoaXMgY29uZmlnIGlzIGdsb2JhbCwg
IGFuZCB3aWxsIGFmZmVjdCBvdGhlciBzZXJ2aWNlcywgc3VjaCBhcyBzc2ggbG9naW4uIFdlIGRv
bqGvdCBmaW5kIGEgd2F5IGp1c3QgZG9uoa90ICBjcmVhdGUgY2dyb3VwIGRpciBmb3Igc2Z0cC4N
Cg0KQFhpdW5pbmcgV291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9vayBhbmQgZ2l2ZSBzb21lIHN1
Z2dlc3Rpb24/DQoNCi0tDQpNaWNoYWwgSG9ja28NClNVU0UgTGFicw0K
