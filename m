Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E01227E9E
	for <lists+cgroups@lfdr.de>; Tue, 21 Jul 2020 13:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgGULUD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jul 2020 07:20:03 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2985 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727043AbgGULUD (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 Jul 2020 07:20:03 -0400
Received: from DGGEML404-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 9162C21CE0AE9FFC4EDC;
        Tue, 21 Jul 2020 19:20:01 +0800 (CST)
Received: from DGGEML424-HUB.china.huawei.com (10.1.199.41) by
 DGGEML404-HUB.china.huawei.com (10.3.17.39) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 21 Jul 2020 19:20:01 +0800
Received: from DGGEML528-MBX.china.huawei.com ([169.254.7.143]) by
 dggeml424-hub.china.huawei.com ([10.1.199.41]) with mapi id 14.03.0487.000;
 Tue, 21 Jul 2020 19:19:52 +0800
From:   jingrui <jingrui@huawei.com>
To:     "tj@kernel.org" <tj@kernel.org>, Lizefan <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "vdavydov.dev@gmail.com" <vdavydov.dev@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        caihaomin <caihaomin@huawei.com>,
        "Weiwei (N)" <wick.wei@huawei.com>
Subject: PROBLEM: cgroup cost too much memory when transfer small files to
 tmpfs
Thread-Topic: PROBLEM: cgroup cost too much memory when transfer small files
 to tmpfs
Thread-Index: AdZfPbaDbBlN0uuzRT+WBs1zGYD4fAAETDVg
Date:   Tue, 21 Jul 2020 11:19:52 +0000
Message-ID: <2E04DD7753BE0E4ABABF0B664610AD6F2620CAF7@dggeml528-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.43]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Q2M6IEpvaGFubmVzIFdlaW5lciA8aGFubmVzQGNtcHhjaGcub3JnPiA7IE1pY2hhbCBIb2NrbyA8
bWhvY2tvQGtlcm5lbC5vcmc+OyBWbGFkaW1pciBEYXZ5ZG92IDx2ZGF2eWRvdi5kZXZAZ21haWwu
Y29tPg0KDQpUaGFua3MuDQoNCi0tLQ0KUFJPQkxFTTogY2dyb3VwIGNvc3QgdG9vIG11Y2ggbWVt
b3J5IHdoZW4gdHJhbnNmZXIgc21hbGwgZmlsZXMgdG8gdG1wZnMuDQoNCmtleXdvcmRzOiBjZ3Jv
dXAgUEVSQ1BVL21lbW9yeSBjb3N0IHRvbyBtdWNoLg0KDQpkZXNjcmlwdGlvbjoNCg0KV2Ugc2Vu
ZCBzbWFsbCBmaWxlcyBmcm9tIG5vZGUtQSB0byBub2RlLUIgdG1wZnMgL3RtcCBkaXJlY3Rvcnkg
dXNpbmcgc2Z0cC4gT24NCm5vZGUtQiB0aGUgc3lzdGVtZCBjb25maWd1cmVkIHdpdGggcGFtIG9u
IGxpa2UgYmVsb3cuDQoNCmNhdCAvZXRjL3BhbS5kL3Bhc3N3b3JkLWF1dGggfCBncmVwIHN5c3Rl
bWQNCi1zZXNzaW9uwqDCoMKgwqAgb3B0aW9uYWzCoMKgwqDCoMKgIHBhbV9zeXN0ZW1kLnNvDQoN
ClNvIHdoZW4gdHJhbnNmZXIgYSBmaWxlLCBhIHN5c3RlbWQgc2Vzc2lvbiBpcyBjcmVhdGVkLCB0
aGF0IG1lYW5zIGEgY2dyb3VwIGlzDQpjcmVhdGVkLCB0aGVuIGZpbGUgc2F2ZWQgYXQgL3RtcCB3
aWxsIGFzc29jaWF0ZWQgd2l0aCBhIGNncm91cCBvYmplY3QuIEFmdGVyDQpmaWxlIHRyYW5zZmVy
cmVkLCBzZXNzaW9uIGFuZCBjZ3JvdXAtZGlyIHdpbGwgYmUgcmVtb3ZlZCwgYnV0IHRoZSBmaWxl
IGluIC90bXANCnN0aWxsIGFzc29jaWF0ZWQgd2l0aCB0aGUgY2dyb3VwIG9iamVjdC4gVGhlIFBF
UkNQVSBtZW1vcnkgaW4gY2dyb3VwL2NzcyBvYmplY3QNCmNvc3QgYSBsb3QoYWJvdXQgMC41TUIv
cGVyLWNncm91cC1vYmplY3QpIG9uIDIwMC9jcHVzIG1hY2hpbmUuDQoNCldoZW4gbG90IG9mIHNt
YWxsIGZpbGVzIHRyYW5zZmVycmVkIHRvIHRtcGZzLCB0aGUgY2dyb3VwL2NzcyBvYmplY3QgbWVt
b3J5DQpjb3N0IGJlY29tZSBodWdlIGluIHRoaXMgc2NlbmVzIHRvIGJlIHVzZWQuDQoNCnN5c3Rl
bWQgcmVsYXRlZCBpc3N1ZTogaHR0cHM6Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9pc3N1
ZXMvMTY0OTkNCg0Ka2VybmVsIHZlcnNpb246IDQuMTkrDQoNClByb2JsZW06DQoNCjEuIERvIHdl
IGhhdmUgYW55IGlkZWEgdG8gZGVzY3JlYXNlIGNncm91cCBtZW1vcnkgY29zdCBpbiB0aGlzIGNh
c2U/DQoyLiBXaGVuIHVzZXIgcmVtb3ZlIGNncm91cCBkaXJlY3RvcnksIGRvZXMgaXQgcG9zc2li
bGUgYXNzb2NpYXRlZCBmaWxlIG1lbW9yeSB0byByb290IGNncm91cD8NCjMuIENhbiB3ZSBwcm92
aWRlIGFuIG9wdGlvbiB0aGF0IGRvIG5vdCBhc3NvY2lhdGUgbWVtb3J5IHdpdGggY2dyb3VwIGlu
IHRtcGZzPw0K
