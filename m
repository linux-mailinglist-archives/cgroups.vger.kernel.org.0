Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98793CB19B
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 06:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhGPE2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 00:28:12 -0400
Received: from smtp4.jd.com ([59.151.64.78]:2065 "EHLO smtp4.jd.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhGPE2M (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 16 Jul 2021 00:28:12 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Jul 2021 00:28:11 EDT
Received: from JDCloudMail03.360buyAD.local (172.31.68.36) by
 JDCloudMail08.360buyAD.local (172.31.68.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Fri, 16 Jul 2021 12:10:02 +0800
Received: from JDCloudMail03.360buyAD.local ([fe80::cce5:2b09:1ea8:1970]) by
 JDCloudMail03.360buyAD.local ([fe80::cce5:2b09:1ea8:1970%2]) with mapi id
 15.01.2242.010; Fri, 16 Jul 2021 12:10:02 +0800
From:   =?gb2312?B?1dTQoce/?= <zhaoxiaoqiang11@jd.com>
To:     "tj@kernel.org" <tj@kernel.org>
CC:     "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: [PATCH] cgroup: remove cgroup_mount from comments
Thread-Topic: [PATCH] cgroup: remove cgroup_mount from comments
Thread-Index: Add587M4xc/XqU4zTIqHc96zfPQDcQ==
Date:   Fri, 16 Jul 2021 04:10:02 +0000
Message-ID: <ab3a1ee987d7447495be6b9ddbcbe24d@jd.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.31.12.238]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

R2l0IHJpZCBvZiB0aGUgaW5hcHByb3ByaWF0ZSBjb21tZW50DQoNClNpbmNlIGNncm91cCBpcyBm
dWxseSBzd2l0Y2hlZCB0byBmc19jb250ZXh0LCBmdW5jdGlvbiBjZ3JvdXBfbW91bnQNCmlzIHJl
bW92ZWQgYW5kIGl0J3MgY29uZnVzZWQgdG8gbWVudGlvbiBpbiBjb21tZW50cyBvZiBjZ3JvdXBf
a2lsbF9zYi4NCkp1c3Qgd2lwZSBpdCBvdXQuDQoNClNpZ25lZC1vZmYtYnk6IHpoYW94aWFvcWlh
bmcxMSA8emhhb3hpYW9xaWFuZzExQGpkLmNvbT4NCi0tLQ0KIGtlcm5lbC9jZ3JvdXAvY2dyb3Vw
LmMgfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
a2VybmVsL2Nncm91cC9jZ3JvdXAuYyBiL2tlcm5lbC9jZ3JvdXAvY2dyb3VwLmMNCmluZGV4IDNh
MDE2MWMyMWI2Yi4uZDA3MjVjMWE4ZGI1IDEwMDY0NA0KLS0tIGEva2VybmVsL2Nncm91cC9jZ3Jv
dXAuYw0KKysrIGIva2VybmVsL2Nncm91cC9jZ3JvdXAuYw0KQEAgLTIxNjksNyArMjE2OSw2IEBA
IHN0YXRpYyB2b2lkIGNncm91cF9raWxsX3NiKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQogICAg
ICAgIC8qDQogICAgICAgICAqIElmIEByb290IGRvZXNuJ3QgaGF2ZSBhbnkgY2hpbGRyZW4sIHN0
YXJ0IGtpbGxpbmcgaXQuDQogICAgICAgICAqIFRoaXMgcHJldmVudHMgbmV3IG1vdW50cyBieSBk
aXNhYmxpbmcgcGVyY3B1X3JlZl90cnlnZXRfbGl2ZSgpLg0KLSAgICAgICAgKiBjZ3JvdXBfbW91
bnQoKSBtYXkgd2FpdCBmb3IgQHJvb3QncyByZWxlYXNlLg0KICAgICAgICAgKg0KICAgICAgICAg
KiBBbmQgZG9uJ3Qga2lsbCB0aGUgZGVmYXVsdCByb290Lg0KICAgICAgICAgKi8NCi0tDQoyLjI3
LjANCg==
