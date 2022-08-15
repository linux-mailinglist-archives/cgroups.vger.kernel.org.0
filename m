Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A54A5927E9
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 04:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiHOCwS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 14 Aug 2022 22:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiHOCwR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 14 Aug 2022 22:52:17 -0400
Received: from baidu.com (mx20.baidu.com [111.202.115.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D585413DE7
        for <cgroups@vger.kernel.org>; Sun, 14 Aug 2022 19:52:15 -0700 (PDT)
Received: from BC-Mail-Ex26.internal.baidu.com (unknown [172.31.51.20])
        by Forcepoint Email with ESMTPS id E47BE739FB0367CD4F4F;
        Mon, 15 Aug 2022 10:52:11 +0800 (CST)
Received: from bjkjy-mail-ex23.internal.baidu.com (172.31.50.17) by
 BC-Mail-Ex26.internal.baidu.com (172.31.51.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Mon, 15 Aug 2022 10:52:14 +0800
Received: from BJHW-Mail-Ex24.internal.baidu.com (10.127.64.26) by
 bjkjy-mail-ex23.internal.baidu.com (172.31.50.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.17; Mon, 15 Aug 2022 10:52:14 +0800
Received: from BJHW-Mail-Ex24.internal.baidu.com ([169.254.215.83]) by
 BJHW-Mail-Ex24.internal.baidu.com ([100.100.100.47]) with mapi id
 15.01.2308.020; Mon, 15 Aug 2022 10:52:14 +0800
From:   "Li,Liguang" <liliguang@baidu.com>
To:     Yosry Ahmed <yosryahmed@google.com>,
        Shakeel Butt <shakeelb@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
Thread-Topic: [PATCH] mm: correctly charge compressed memory to its memcg
Thread-Index: AQHYrVsMy0Eejy54pEyx9FbtyzV2Pq2p36EAgAFsPQCAAC7QgIADzqaA
Date:   Mon, 15 Aug 2022 02:52:14 +0000
Message-ID: <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com>
References: <20220811081913.102770-1-liliguang@baidu.com>
 <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
In-Reply-To: <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.200.66]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E9DF19C5E2CF144CA8782FE45BE74849@internal.baidu.com>
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

5ZyoIDIwMjIvOC8xMyDkuIrljYg4OjQ077yM4oCcWW9zcnkgQWhtZWTigJ08eW9zcnlhaG1lZEBn
b29nbGUuY29tPiDlhpnlhaU6DQoNCj4gT24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgMjo1NiBQTSBT
aGFrZWVsIEJ1dHQgPHNoYWtlZWxiQGdvb2dsZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gK0FuZHJl
dyAmIGxpbnV4LW1tDQo+ID4NCj4gPiBPbiBUaHUsIEF1ZyAxMSwgMjAyMiBhdCA1OjEyIFBNIFJv
bWFuIEd1c2hjaGluIDxyb21hbi5ndXNoY2hpbkBsaW51eC5kZXY+IHdyb3RlOg0KPiA+ID4NCj4g
PiA+IE9uIFRodSwgQXVnIDExLCAyMDIyIGF0IDA0OjE5OjEzUE0gKzA4MDAsIGxpbGlndWFuZyB3
cm90ZToNCj4gPiA+ID4gRnJvbTogTGkgTGlndWFuZyA8bGlsaWd1YW5nQGJhaWR1LmNvbT4NCj4g
PiA+ID4NCj4gPiA+ID4gS3N3YXBkIHdpbGwgcmVjbGFpbSBtZW1vcnkgd2hlbiBtZW1vcnkgcHJl
c3N1cmUgaXMgaGlnaCwgdGhlDQo+ID4gPiA+IGFubm9ueW1vdXMgbWVtb3J5IHdpbGwgYmUgY29t
cHJlc3NlZCBhbmQgc3RvcmVkIGluIHRoZSB6cG9vbA0KPiA+ID4gPiBpZiB6c3dhcCBpcyBlbmFi
bGVkLiBUaGUgbWVtY2dfa21lbV9ieXBhc3MoKSBpbg0KPiA+ID4gPiBnZXRfb2JqX2Nncm91cF9m
cm9tX3BhZ2UoKSB3aWxsIGJ5cGFzcyB0aGUga2VybmVsIHRocmVhZCBhbmQNCj4gPiA+ID4gY2F1
c2UgdGhlIGNvbXByZXNzZWQgbWVtb3J5IG5vdCBjaGFyZ2VkIHRvIGl0cyBtZW1vcnkgY2dyb3Vw
Lg0KPiA+ID4gPg0KPiA+ID4gPiBSZW1vdmUgdGhlIG1lbWNnX2ttZW1fYnlwYXNzKCkgYW5kIHBy
b3Blcmx5IGNoYXJnZSBjb21wcmVzc2VkDQo+ID4gPiA+IG1lbW9yeSB0byBpdHMgY29ycmVzcG9u
ZGluZyBtZW1vcnkgY2dyb3VwLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBM
aWd1YW5nIDxsaWxpZ3VhbmdAYmFpZHUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIG1tL21l
bWNvbnRyb2wuYyB8IDIgKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvbW0vbWVtY29u
dHJvbC5jIGIvbW0vbWVtY29udHJvbC5jDQo+ID4gPiA+IGluZGV4IGI2OTk3OWM5Y2VkNS4uNmE5
NWVhN2M1ZWU3IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9tbS9tZW1jb250cm9sLmMNCj4gPiA+ID4g
KysrIGIvbW0vbWVtY29udHJvbC5jDQo+ID4gPiA+IEBAIC0yOTcxLDcgKzI5NzEsNyBAQCBzdHJ1
Y3Qgb2JqX2Nncm91cCAqZ2V0X29ial9jZ3JvdXBfZnJvbV9wYWdlKHN0cnVjdCBwYWdlICpwYWdl
KQ0KPiA+ID4gPiAgew0KPiA+ID4gPiAgICAgICBzdHJ1Y3Qgb2JqX2Nncm91cCAqb2JqY2c7DQo+
ID4gPiA+DQo+ID4gPiA+IC0gICAgIGlmICghbWVtY2dfa21lbV9lbmFibGVkKCkgfHwgbWVtY2df
a21lbV9ieXBhc3MoKSkNCj4gPiA+ID4gKyAgICAgaWYgKCFtZW1jZ19rbWVtX2VuYWJsZWQoKSkN
Cj4NCj4NCj4gV29uJ3QgdGhlIG1lbWNnX2ttZW1fZW5hYmxlZCgpIGNoZWNrIGFsc28gY2F1c2Ug
YSBwcm9ibGVtIGluIHRoYXQgc2FtZQ0KPiBzY2VuYXJpbyAoZS5nLiBpZiBDT05GSUdfTUVNQ0df
S01FTT1uKT8gb3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZw0KPiBoZXJlPw0KPg0KDQpQbGVhc2Ug
bm90ZXMgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIGlzIGEgcG9pbnRlciB0byBvYmpfY2dyb3VwLCBu
b3QgbWVtY2cuDQpJZiBDT05GSUdfTUVNQ0dfS01FTT1uIG9yIG1lbWNnIGttZW0gY2hhcmdlIGlz
IGRpc2FibGVkLCB0aGUgTlVMTCBuZWVkIA0KdG8gYmUgcmV0dXJuZWQuDQoNCj4gPg0KPiA+ID4g
PiAgICAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiA+ID4gPg0KPiA+ID4gPiAgICAgICBpZiAo
UGFnZU1lbWNnS21lbShwYWdlKSkgew0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjMyLjAgKEFwcGxl
IEdpdC0xMzIpDQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gSGkgTGkhDQo+ID4gPg0KPiA+ID4gVGhl
IGZpeCBsb29rcyBnb29kIHRvIG1lISBBcyB3ZSBnZXQgb2JqY2cgcG9pbnRlciBmcm9tIGEgcGFn
ZSBhbmQgbm90IGZyb20NCj4gPiA+IHRoZSBjdXJyZW50IHRhc2ssIG1lbWNnX2ttZW1fYnlwYXNz
KCkgZG9lc24ndCBtYWtlcyBtdWNoIHNlbnNlLg0KPiA+ID4NCj4gPiA+IEFja2VkLWJ5OiBSb21h
biBHdXNoY2hpbiA8cm9tYW4uZ3VzaGNoaW5AbGludXguZGV2Pg0KPiA+ID4NCj4gPiA+IFByb2Jh
Ymx5LCB3ZSBuZWVkIHRvIGFkZA0KPiA+ID4gRml4ZXM6IGY0ODQwY2NmY2EyNSAoInpzd2FwOiBt
ZW1jZyBhY2NvdW50aW5nIikNCj4gPiA+DQo+ID4gPiBUaGFuayB5b3UhDQo+ID4NCj4gPiBZb3Ug
Y2FuIGFkZDoNCj4gPg0KPiA+IEFja2VkLWJ5OiBTaGFrZWVsIEJ1dHQgPHNoYWtlZWxiQGdvb2ds
ZS5jb20+DQo+ID4NCg0K
