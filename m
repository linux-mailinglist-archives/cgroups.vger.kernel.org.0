Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD6222C25F
	for <lists+cgroups@lfdr.de>; Fri, 24 Jul 2020 11:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGXJfh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Jul 2020 05:35:37 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXJfg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 Jul 2020 05:35:36 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 7215ABB684234815DC6A;
        Fri, 24 Jul 2020 17:35:34 +0800 (CST)
Received: from DGGEML528-MBX.china.huawei.com ([169.254.7.143]) by
 dggeml405-hub.china.huawei.com ([10.3.17.49]) with mapi id 14.03.0487.000;
 Fri, 24 Jul 2020 17:35:26 +0800
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
        "Weiwei (N)" <wick.wei@huawei.com>
Subject: =?gb2312?B?tPC4tDogUFJPQkxFTTogY2dyb3VwIGNvc3QgdG9vIG11Y2ggbWVtb3J5IHdo?=
 =?gb2312?Q?en_transfer_small_files_to_tmpfs?=
Thread-Topic: PROBLEM: cgroup cost too much memory when transfer small files
 to tmpfs
Thread-Index: AdZfPbaDbBlN0uuzRT+WBs1zGYD4fAAETDVgAH9ylAAAE+ehUA==
Date:   Fri, 24 Jul 2020 09:35:26 +0000
Message-ID: <2E04DD7753BE0E4ABABF0B664610AD6F2620D4F6@dggeml528-mbx.china.huawei.com>
References: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
 <20200724075508.GF4061@dhcp22.suse.cz>
In-Reply-To: <20200724075508.GF4061@dhcp22.suse.cz>
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

DQpPbiBGcmlkYXksIEp1bHkgMjQsIDIwMjAgMzo1NSBQTSwgTWljaGFsIEhvY2tvIHdyb3RlOg0K
DQo+IFdoYXQgaXMgdGhlIHJlYXNvbiB0byBydW4gdW5kZXIgIXJvb3QgY2dyb3VwIGluIHRob3Nl
IHNlc3Npb25zIGlmIHlvdSBkbyBub3QgY2FyZSBhYm91dCBhY2NvdW50aW5nIGFueXdheT8gDQoN
ClRoZSBzeXN0ZW1kIG5vdCBzdXBwb3J0IHJ1biB0aG9zZSBzZXNzaW9ucyB1bmRlciByb290IGNn
cm91cCwgZGlzYWJsZQ0KcGFtLXN5c3RlbWQgd2lsbCBub3QgY3JlYXRlIHNlc3Npb24vY2dyb3Vw
LCBidXQgdGhpcyBpcyBub3Qgc2FmZSBhbmQgbWFrZQ0Kc3lzdGVtZC1sb2dpbmQgbm90IHdvcmsu
DQoNCj4gdG1wZnMgaXMgYSBwZXJzaXN0ZW50IGNoYXJnZSB1bnRpbCB0aGUgZmlsZSBpcyByZW1v
dmVkLiBTbyBpZiB0aG9zZSBvdXRsaXZlIHRoZSBzZXNzaW9uIHRoZW4geW91IGVpdGhlciB3YW50
IHRoZW0gdG8gYmUgY2hhcmdlZCB0byBzb21lYm9keSBvciB5b3UgZG8gbm90IGNhcmUgYWJvdXQg
YWNjb3VudGluZyBhdCBhbGwsIG5vPyBPciBjb3VsZCB5b3UgZXhwbGFpbiB5b3VyIHVzZWNhc2Ug
c29tZSBtb3JlPw0KDQpJbiBzb21lIHVzZWNhc2UsIHdlIGRvbnQgaGF2ZSBkaXNrIGFuZCBrZWVw
IGZpbGVzIGluIG1lbW9yeSwgd2UgdHJlYXQgdG1wZnMNCmp1c3QgbGlrZSBkaXNrLCBzbyBkb250
IGNhcmUgdG1wZnMgYWNjb3V0aW5nIGF0IGFsbC4NCg0KLS0NCkppbmdydWkNCkJSLg0K
