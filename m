Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EF43654C3
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 11:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhDTJHx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 20 Apr 2021 05:07:53 -0400
Received: from stumail.xidian.edu.cn ([202.117.112.40]:34330 "HELO
        stu.xidian.edu.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S230395AbhDTJHx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 20 Apr 2021 05:07:53 -0400
Received: from localhost ([127.0.0.1]) 
        by stu.xidian.edu.cn with sendmail id c82f9d87de1d7459016d3718967cbcf6;
        Tue, 20 Apr 2021 17:11:52 +0800
Date:   Tue, 20 Apr 2021 17:11:51 +0800
From:   "=?GBK?B?0e7E0NfT?=" <nzyang@stu.xidian.edu.cn>
Subject: Report Bug to Linux Control Group
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org
Cc:     "cgroups" <cgroups@vger.kernel.org>
Message-Id: <210420171151fc1e2cfe68a34fa7e4e8ee3c8a07f7f4@stu.xidian.edu.cn>
MIME-Version: 1.0
X-Mailer: eYou WebMail 8.1.0.3.fix1_s3
X-Priority: 1
Importance: High
X-Msmail-Priority: High
X-Eyou-Client: 45.87.95.68
Content-Type: text/plain;
 charset="GBK"
Content-Transfer-Encoding: base64
X-Eyou-Sender: <nzyang@stu.xidian.edu.cn>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGksIG91ciB0ZWFtIGhhcyBmb3VuZCBhIHByb2JsZW0gaW4gZnMgc3lzdGVtIG9uIExp
bnV4IGtlcm5lbCB2NS4xMCwgbGVhZGluZyB0byBEb1MgYXR0YWNrcy4KCiAKClRoZSBz
dHJ1Y3QgZmlsZSBjYW4gYmUgZXhoYXVzdGVkIGJ5IG5vcm1hbCB1c2VycyBieSBjYWxs
aW5nIG11bHRpcGxlIHN5c2NhbGxzIHN1Y2ggYXMgdGltZXJmZF9jcmVhdGUvcGlwZS9v
cGVuIGV0Yy4gQWx0aG91Z2ggdGhlIHJsaW1pdCBsaW1pdHMgdGhlIG1heCBmZHMgY291
bGQgb3BlbmVkIGJ5IGEgc2luZ2xlIHByb2Nlc3MuIEEgbm9ybWFsIHVzZXIgY2FuIGZv
cmsgbXVsdGlwbGUgcHJvY2Vzc2VzLCByZXBlYXRlZGx5IG1ha2UgdGhlIHRpbWVyZmRf
Y3JlYXRlL3BpcGUvb3BlbiBzeXNjYWxscyBhbmQgZXhoYXVzdCBhbGwgc3RydWN0IGZp
bGVzLiBBcyBhIHJlc3VsdCwgYWxsIHN0cnVjdC1maWxlLWFsbG9jYXRpb24gcmVsYXRl
ZCBvcGVyYXRpb25zIG9mIGFsbCBvdGhlciB1c2VzIHdpbGwgZmFpbC4KCiAKCkluIGZh
Y3QsIHdlIHRyeSB0aGlzIGF0dGFjayBpbnNpZGUgYSBkZXByaXZpbGVnZWQgZG9ja2Vy
IGNvbnRhaW5lciB3aXRob3V0IGFueSBjYXBhYmlsaXRpZXMuIFRoZSBwcm9jZXNzZXMg
aW4gdGhlIGRvY2tlciBjYW4gZXhoYXVzdCBhbGwgc3RydWN0LWZpbGUgb24gdGhlIGhv
c3Qga2VybmVsLiBXZSB1c2UgYSBtYWNoaW5lIHdpdGggMTZHIG1lbW9yeS4gV2Ugc3Rh
cnQgMjAwMCBwcm9jZXNzZXMsIGVhY2ggcHJvY2Vzc2VzIHdpdGggYSAxMDI0IGxpbWl0
LiBJbiB0b3RhbCwgYXJvdW5kIDE2MTM0MDAgbnVtYmVyIG9mIHN0cnVjdC1maWxlIGFy
ZSBjb25zdW1lZCBhbmQgdGhlcmUgYXJlIG5vIGF2YWlsYWJsZSBzdHJ1Y3QtZmlsZSBp
biB0aGUga2VybmVsLiBUaGUgdG90YWwgY29uc3VtZWQgbWVtb3J5IGlzIGxlc3MgdGhh
biAyRyAsIHdoaWNoIGlzIHNtYWxsLCBzbyBtZW1vcnkgY29udHJvbCBncm91cCBjYW4g
bm90IGhlbHAuCgogCgpUaGV5IGFyZSBjYXVzZWQgYnkgdGhlIGNvZGUgc25pcHBldHMg
bGlzdGVkIGJlbG93OgoKLyotLS0tLS0tLS0tLS0tLS0tZnMvZmlsZV90YWJsZS5jLS0t
LS0tLS0tLS0tLS0tLSovCgogICAuLi4uLi4KCjEzNCBzdHJ1Y3QgZmlsZSAqYWxsb2Nf
ZW1wdHlfZmlsZShpbnQgZmxhZ3MsIGNvbnN0IHN0cnVjdCBjcmVkICpjcmVkKQoKMTM1
IHsKCiAgICAgICAgLi4uLi4uCgoxNDIgICAgIGlmIChnZXRfbnJfZmlsZXMoKSA+PSBm
aWxlc19zdGF0Lm1heF9maWxlcyAmJiAhY2FwYWJsZShDQVBfU1lTX0FETUlOKSkgewoK
ICAgICAgICAgICAgICAgLi4uLi4uICAKCjE0NyAgICAgICAgICAgIGlmIChwZXJjcHVf
Y291bnRlcl9zdW1fcG9zaXRpdmUoJm5yX2ZpbGVzKSA+PSBmaWxlc19zdGF0Lm1heF9m
aWxlcykKCjE0OCAgICAgICAgICAgICAgICAgICBnb3RvIG92ZXI7CgoxNDkgICAgIH0K
CiAgICAgICAuLi4uLi4KCjE1NyBvdmVyOgoKICAgICAgIC4uLi4uLgoKMTYzICAgICBy
ZXR1cm4gRVJSX1BUUigtRU5GSUxFKTsKCjE2NCB9CgovKi0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKi8KClRoZSBjb2RlIGF0IGxpbmUg
MTQ3IGNvdWxkIGJlIHRyaWdnZXJlZCBieSBzeXNjYWxscyB0aW1lcmZkX2NyZWF0ZS9w
aXBlL29wZW4gZXRjLiBCZXNpZGVzLCB0aGVyZSBhcmUgbm8gIExpbnV4IGNvbnRyb2wg
Z3JvdXBzIG9yIExpbnV4IG5hbWVzcGFjZXMgY2FuIGxpbWl0IG9yIGlzb2xhdGUgdGhl
IHN0cnVjdCBmaWxlIHJlc291cmNlcy4gSXMgdGhlcmUgbmVjZXNzYXJ5IHRvIGNyZWF0
ZSBhIG5ldyBjb250cm9sIGdyb3VwIG9yIG5hbWVzcGFjZSB0byBkZWZlbmQgYWdhaW5z
dCB0aGlzIGF0dGFjaz8KCiAKCkxvb2tpbmcgZm9yd2FyZCB0byB5b3VyIHJlcGx5IQoK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTmFuemkgWWFuZw==
