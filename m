Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6D23DBB73
	for <lists+cgroups@lfdr.de>; Fri, 30 Jul 2021 16:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbhG3OzD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Jul 2021 10:55:03 -0400
Received: from mx20.baidu.com ([111.202.115.85]:35822 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238909AbhG3OzC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 30 Jul 2021 10:55:02 -0400
Received: from BC-Mail-Ex20.internal.baidu.com (unknown [172.31.51.14])
        by Forcepoint Email with ESMTPS id 07156AC1C1E2DC5980F1;
        Fri, 30 Jul 2021 22:54:50 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex20.internal.baidu.com (172.31.51.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Fri, 30 Jul 2021 22:54:49 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Fri, 30 Jul 2021 22:54:49 +0800
Received: from BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) by
 BJHW-MAIL-EX27.internal.baidu.com ([169.254.58.247]) with mapi id
 15.01.2308.014; Fri, 30 Jul 2021 22:54:49 +0800
From:   "Cai,Huoqing" <caihuoqing@baidu.com>
To:     Shakeel Butt <shakeelb@google.com>, Hu Haowen <src.res@email.cn>
CC:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Cgroups <cgroups@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cgroup: Fix typo in comments and documents
Thread-Topic: [PATCH] cgroup: Fix typo in comments and documents
Thread-Index: AQHXhQIDu+2rYoYCcECzux5whjnjEKtbAdqAgAATPICAAIZdwA==
Date:   Fri, 30 Jul 2021 14:54:49 +0000
Message-ID: <437db356f1b44a19837dc7f24f9adfcb@baidu.com>
References: <20210730051605.2626-1-caihuoqing@baidu.com>
 <0516372e-0120-ff52-bf9a-cf1cda9a633f@email.cn>
 <CALvZod6sUh0XQGVb4wEfzGNDcrLabgmjEdu+wh0g1c=cvvci4Q@mail.gmail.com>
In-Reply-To: <CALvZod6sUh0XQGVb4wEfzGNDcrLabgmjEdu+wh0g1c=cvvci4Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.190.132]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Rm9yZ2V0IGl0IC0gLQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU2hha2Vl
bCBCdXR0IDxzaGFrZWVsYkBnb29nbGUuY29tPiANClNlbnQ6IDIwMjHlubQ35pyIMzDml6UgMjI6
NTMNClRvOiBIdSBIYW93ZW4gPHNyYy5yZXNAZW1haWwuY24+DQpDYzogQ2FpLEh1b3FpbmcgPGNh
aWh1b3FpbmdAYmFpZHUuY29tPjsgVGVqdW4gSGVvIDx0akBrZXJuZWwub3JnPjsgWmVmYW4gTGkg
PGxpemVmYW4ueEBieXRlZGFuY2UuY29tPjsgSm9oYW5uZXMgV2VpbmVyIDxoYW5uZXNAY21weGNo
Zy5vcmc+OyBKb25hdGhhbiBDb3JiZXQgPGNvcmJldEBsd24ubmV0PjsgQ2dyb3VwcyA8Y2dyb3Vw
c0B2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBMS01MIDxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0KU3ViamVjdDogUmU6IFtQQVRDSF0gY2dyb3VwOiBG
aXggdHlwbyBpbiBjb21tZW50cyBhbmQgZG9jdW1lbnRzDQoNCk9uIEZyaSwgSnVsIDMwLCAyMDIx
IGF0IDY6NDQgQU0gSHUgSGFvd2VuIDxzcmMucmVzQGVtYWlsLmNuPiB3cm90ZToNCj4NCj4NCj4g
5ZyoIDIwMjEvNy8zMCDkuIvljYgxOjE2LCBDYWkgSHVvcWluZyDlhpnpgZM6DQo+ID4gRml4IHR5
cG86IGlmZiAgPT0+IGlmDQoNClRoaXMgaXMgbm90IGEgdHlwby4gJ2lmZicgbWVhbnMgJ2lmIGFu
ZCBvbmx5IGlmJy4gRm9yIGRldGFpbHMgc2VlIGh0dHBzOi8vZW4ud2lraXBlZGlhLm9yZy93aWtp
L0lmX2FuZF9vbmx5X2lmLg0K
