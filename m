Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95B3592E72
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 13:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiHOLsZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 07:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiHOLsZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 07:48:25 -0400
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BE05BF5C
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 04:48:24 -0700 (PDT)
Received: from BC-Mail-Ex24.internal.baidu.com (unknown [172.31.51.18])
        by Forcepoint Email with ESMTPS id 4A3CC18692833C22CEAA;
        Mon, 15 Aug 2022 19:48:20 +0800 (CST)
Received: from BJHW-Mail-Ex24.internal.baidu.com (10.127.64.26) by
 BC-Mail-Ex24.internal.baidu.com (172.31.51.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 15 Aug 2022 19:48:22 +0800
Received: from BJHW-Mail-Ex24.internal.baidu.com ([169.254.215.83]) by
 BJHW-Mail-Ex24.internal.baidu.com ([100.100.100.47]) with mapi id
 15.01.2308.020; Mon, 15 Aug 2022 19:48:22 +0800
From:   "Li,Liguang" <liliguang@baidu.com>
To:     Yosry Ahmed <yosryahmed@google.com>
CC:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Thread-Topic: [PATCH] mm: correctly charge compressed memory to its memcg
Thread-Index: AQHYrVsMy0Eejy54pEyx9FbtyzV2Pq2p36EAgAFsPQCAAC7QgIADzqaA///SlgCAAMM2AA==
Date:   Mon, 15 Aug 2022 11:48:22 +0000
Message-ID: <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com>
References: <20220811081913.102770-1-liliguang@baidu.com>
 <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
 <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
In-Reply-To: <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <97DC608ED8F29946B8E7B8410223FC4A@internal.baidu.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

DQo+IOWcqCAyMDIyLzgvMTUg5LiL5Y2INDoxMO+8jOKAnFlvc3J5IEFobWVk4oCdPHlvc3J5YWht
ZWRAZ29vZ2xlLmNvbT4g5YaZ5YWlOg0KPg0KPiBPbiBTdW4sIEF1ZyAxNCwgMjAyMiBhdCA3OjUy
IFBNIExpLExpZ3VhbmcgPGxpbGlndWFuZ0BiYWlkdS5jb20+IHdyb3RlOg0KPiA+DQo+ID4g5Zyo
IDIwMjIvOC8xMyDkuIrljYg4OjQ077yM4oCcWW9zcnkgQWhtZWTigJ08eW9zcnlhaG1lZEBnb29n
bGUuY29tPiDlhpnlhaU6DQo+ID4NCj4gPiA+IE9uIEZyaSwgQXVnIDEyLCAyMDIyIGF0IDI6NTYg
UE0gU2hha2VlbCBCdXR0IDxzaGFrZWVsYkBnb29nbGUuY29tPiB3cm90ZToNCj4gPiA+ID4NCj4g
PiA+ID4gK0FuZHJldyAmIGxpbnV4LW1tDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFRodSwgQXVnIDEx
LCAyMDIyIGF0IDU6MTIgUE0gUm9tYW4gR3VzaGNoaW4gPHJvbWFuLmd1c2hjaGluQGxpbnV4LmRl
dj4gd3JvdGU6DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBUaHUsIEF1ZyAxMSwgMjAyMiBhdCAw
NDoxOToxM1BNICswODAwLCBsaWxpZ3Vhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiBGcm9tOiBMaSBM
aWd1YW5nIDxsaWxpZ3VhbmdAYmFpZHUuY29tPg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IEtz
d2FwZCB3aWxsIHJlY2xhaW0gbWVtb3J5IHdoZW4gbWVtb3J5IHByZXNzdXJlIGlzIGhpZ2gsIHRo
ZQ0KPiA+ID4gPiA+ID4gYW5ub255bW91cyBtZW1vcnkgd2lsbCBiZSBjb21wcmVzc2VkIGFuZCBz
dG9yZWQgaW4gdGhlIHpwb29sDQo+ID4gPiA+ID4gPiBpZiB6c3dhcCBpcyBlbmFibGVkLiBUaGUg
bWVtY2dfa21lbV9ieXBhc3MoKSBpbg0KPiA+ID4gPiA+ID4gZ2V0X29ial9jZ3JvdXBfZnJvbV9w
YWdlKCkgd2lsbCBieXBhc3MgdGhlIGtlcm5lbCB0aHJlYWQgYW5kDQo+ID4gPiA+ID4gPiBjYXVz
ZSB0aGUgY29tcHJlc3NlZCBtZW1vcnkgbm90IGNoYXJnZWQgdG8gaXRzIG1lbW9yeSBjZ3JvdXAu
DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gUmVtb3ZlIHRoZSBtZW1jZ19rbWVtX2J5cGFzcygp
IGFuZCBwcm9wZXJseSBjaGFyZ2UgY29tcHJlc3NlZA0KPiA+ID4gPiA+ID4gbWVtb3J5IHRvIGl0
cyBjb3JyZXNwb25kaW5nIG1lbW9yeSBjZ3JvdXAuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTGkgTGlndWFuZyA8bGlsaWd1YW5nQGJhaWR1LmNvbT4NCj4gPiA+ID4g
PiA+IC0tLQ0KPiA+ID4gPiA+ID4gIG1tL21lbWNvbnRyb2wuYyB8IDIgKy0NCj4gPiA+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vbWVtY29udHJvbC5jIGIvbW0vbWVtY29u
dHJvbC5jDQo+ID4gPiA+ID4gPiBpbmRleCBiNjk5NzljOWNlZDUuLjZhOTVlYTdjNWVlNyAxMDA2
NDQNCj4gPiA+ID4gPiA+IC0tLSBhL21tL21lbWNvbnRyb2wuYw0KPiA+ID4gPiA+ID4gKysrIGIv
bW0vbWVtY29udHJvbC5jDQo+ID4gPiA+ID4gPiBAQCAtMjk3MSw3ICsyOTcxLDcgQEAgc3RydWN0
IG9ial9jZ3JvdXAgKmdldF9vYmpfY2dyb3VwX2Zyb21fcGFnZShzdHJ1Y3QgcGFnZSAqcGFnZSkN
Cj4gPiA+ID4gPiA+ICB7DQo+ID4gPiA+ID4gPiAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2Jq
Y2c7DQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gLSAgICAgaWYgKCFtZW1jZ19rbWVtX2VuYWJs
ZWQoKSB8fCBtZW1jZ19rbWVtX2J5cGFzcygpKQ0KPiA+ID4gPiA+ID4gKyAgICAgaWYgKCFtZW1j
Z19rbWVtX2VuYWJsZWQoKSkNCj4gPiA+DQo+ID4gPg0KPiA+ID4gV29uJ3QgdGhlIG1lbWNnX2tt
ZW1fZW5hYmxlZCgpIGNoZWNrIGFsc28gY2F1c2UgYSBwcm9ibGVtIGluIHRoYXQgc2FtZQ0KPiA+
ID4gc2NlbmFyaW8gKGUuZy4gaWYgQ09ORklHX01FTUNHX0tNRU09bik/IG9yIGFtIEkgbWlzc2lu
ZyBzb21ldGhpbmcNCj4gPiA+IGhlcmU/DQo+ID4gPg0KPiA+DQo+ID4gUGxlYXNlIG5vdGVzIHRo
YXQgdGhlIHJldHVybiB2YWx1ZSBpcyBhIHBvaW50ZXIgdG8gb2JqX2Nncm91cCwgbm90IG1lbWNn
Lg0KPiA+IElmIENPTkZJR19NRU1DR19LTUVNPW4gb3IgbWVtY2cga21lbSBjaGFyZ2UgaXMgZGlz
YWJsZWQsIHRoZSBOVUxMIG5lZWQNCj4gPiB0byBiZSByZXR1cm5lZC4NCj4gPg0KPg0KPiBSaWdo
dC4gSSBhbSBub3QgaW1wbHlpbmcgdGhhdCB0aGUgY2hlY2sgc2hvdWxkIGJlIHJlbW92ZWQsIG9y
IHRoYXQNCj4gdGhpcyBpcyBzb21ldGhpbmcgdGhpcyBwYXRjaCBzaG91bGQgYWRkcmVzcyBmb3Ig
dGhhdCBtYXR0ZXIuDQo+DQo+IEkganVzdCByZWFsaXplZCB3aGlsZSBsb29raW5nIGF0IHRoaXMg
cGF0Y2ggdGhhdCBiZWNhdXNlIHdlIGFyZSB1c2luZw0KPiBvYmpjZyBpbiB6c3dhcCBjaGFyZ2lu
ZywgaXQgaXMgZGVwZW5kZW50IG9uIG1lbWNnIGttZW0gY2hhcmdpbmcuIEkgYW0NCj4gbm90IHN1
cmUgSSB1bmRlcnN0YW5kIGlmIHN1Y2ggZGVwZW5kZW5jeSBpcyBuZWVkZWQ/IElJVUMgc3dhcHBl
ZCBvdXQNCj4gcGFnZXMgaG9sZCByZWZlcmVuY2VzIHRvIHRoZSBtZW1jZyB0aGV5IGFyZSBjaGFy
Z2VkIHRvIGFueXdheSwgc28gd2h5DQo+IGRvIHdlIG5lZWQgdG8gdXNlIG9iamNncyBpbiBjaGFy
Z2luZyB6c3dhcD8gSSBmZWVsIGxpa2UgSSBhbSBtaXNzaW5nDQo+IHNvbWV0aGluZy4NCj4gDQoN
ClRoZSBjb21wcmVzc2VkIHNpemUgb2Ygc3dhcHBlZCBvdXQgcGFnZXMgaXMgbmVhcmx5IGEgcXVh
cnRlciBvZiBpdHMgUkFNLA0KYW5kIGEgcGFnZSBpbiB0aGUgenN3YXAgY2FuIHN0b3JlIG11bHRp
cGxlIGNvbXByZXNzZWQgc3dhcHBlZCBvdXQNCnBhZ2VzLiBTbyBvYmpjZyBpcyB1c2VkIGhlcmUu
IA0KDQpQbGVhc2UgY2hlY2sgdGhpcyBwb3N0IGZvciBtb3JlIGluZm9ybWF0aW9uLg0KaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIyMDUxMDE1Mjg0Ny4yMzA5NTctMS1oYW5uZXNAY21w
eGNoZy5vcmcvVC8jbWJkMDI1NGZmZDM3N2JmODQzYWM1MDg1MGJmMGE2ZDQxNTA1YTkyNWENCg0K
PiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiAgICAgICBpZiAoUGFnZU1lbWNnS21lbShwYWdlKSkgew0KPiA+ID4g
PiA+ID4gLS0NCj4gPiA+ID4gPiA+IDIuMzIuMCAoQXBwbGUgR2l0LTEzMikNCj4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBIaSBMaSENCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBm
aXggbG9va3MgZ29vZCB0byBtZSEgQXMgd2UgZ2V0IG9iamNnIHBvaW50ZXIgZnJvbSBhIHBhZ2Ug
YW5kIG5vdCBmcm9tDQo+ID4gPiA+ID4gdGhlIGN1cnJlbnQgdGFzaywgbWVtY2dfa21lbV9ieXBh
c3MoKSBkb2Vzbid0IG1ha2VzIG11Y2ggc2Vuc2UuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBY2tl
ZC1ieTogUm9tYW4gR3VzaGNoaW4gPHJvbWFuLmd1c2hjaGluQGxpbnV4LmRldj4NCj4gPiA+ID4g
Pg0KPiA+ID4gPiA+IFByb2JhYmx5LCB3ZSBuZWVkIHRvIGFkZA0KPiA+ID4gPiA+IEZpeGVzOiBm
NDg0MGNjZmNhMjUgKCJ6c3dhcDogbWVtY2cgYWNjb3VudGluZyIpDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPiBUaGFuayB5b3UhDQo+ID4gPiA+DQo+ID4gPiA+IFlvdSBjYW4gYWRkOg0KPiA+ID4gPg0K
PiA+ID4gPiBBY2tlZC1ieTogU2hha2VlbCBCdXR0IDxzaGFrZWVsYkBnb29nbGUuY29tPg0KPiA+
ID4gPg0KPiA+DQoNCg==
