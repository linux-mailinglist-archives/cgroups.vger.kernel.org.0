Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6E64B58F
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 13:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235293AbiLMM6S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 07:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiLMM6Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 07:58:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD15E0F9
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 04:58:14 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-89-xORWxX3AP_CUetMfbOsIHA-1; Tue, 13 Dec 2022 12:58:11 +0000
X-MC-Unique: xORWxX3AP_CUetMfbOsIHA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 12:58:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 13 Dec 2022 12:58:10 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jiri Slaby' <jirislaby@kernel.org>, 'Tejun Heo' <tj@kernel.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Liska <mliska@suse.cz>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Thread-Topic: [PATCH] block/blk-iocost (gcc13): cast enum members to int in
 prints
Thread-Index: AQHY7hGH734dfSyX20WOi86L/FtKtq4rTpIAgD+71dKAALHkcIAAL92AgAACt3CAAAtKgIAADYvw
Date:   Tue, 13 Dec 2022 12:58:10 +0000
Message-ID: <d26f03e828c94df5b4653ac6980def59@AcuMS.aculab.com>
References: <20221031114520.10518-1-jirislaby@kernel.org>
 <Y1++fLJXkeZgtXR2@infradead.org> <Y2AMcSPAJpj6obSA@slm.duckdns.org>
 <d833ad15-f458-d43d-cab7-de62ff54a939@kernel.org>
 <Y2FNa4bGhJoevRKT@slm.duckdns.org>
 <2b975ee3117e45aaa7882203cf9a4db8@AcuMS.aculab.com>
 <Y2Kaghnu/sPvl0+g@slm.duckdns.org> <Y2KePvYRRMOrqzOe@slm.duckdns.org>
 <320c939e-a3f0-1b1e-77e4-f3ecca00465d@kernel.org>
 <Y5ehU524daymEKgf@slm.duckdns.org>
 <f5220f08bd7f45248d718f1919503261@AcuMS.aculab.com>
 <9d2ead31-efab-cf49-08d4-1e613382d89f@kernel.org>
 <542d413b9d044474a34b6e7a40d70541@AcuMS.aculab.com>
 <c7539121-c8fc-b4b7-b722-ead833420b2b@kernel.org>
In-Reply-To: <c7539121-c8fc-b4b7-b722-ead833420b2b@kernel.org>
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

RnJvbTogSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDEzIERlY2Vt
YmVyIDIwMjIgMTI6MDUNCj4gDQo+IE9uIDEzLiAxMi4gMjIsIDEyOjUwLCBEYXZpZCBMYWlnaHQg
d3JvdGU6DQo+ID4gRnJvbTogSmlyaSBTbGFieQ0KPiA+PiBTZW50OiAxMyBEZWNlbWJlciAyMDIy
IDExOjE1DQo+ID4+DQouLi4NCj4gPj4+PiBPaCBtYW4sIGl0J3Mga2luZGEgY3JhenkgdGhhdCB0
aGUgY29tcGlsZXIgaXMgY2hhbmdpbmcgaW4gYSB3YXkgdGhhdCB0aGUNCj4gPj4+PiBzYW1lIHBp
ZWNlIG9mIGNvZGUgY2FuJ3QgYmUgY29tcGlsZWQgdGhlIHNhbWUgd2F5IGFjcm9zcyB0d28gYWRq
b2luaW5nDQo+ID4+Pj4gdmVyc2lvbnMgb2YgdGhlIHNhbWUgY29tcGlsZXIuIEJ1dCwgeWVhaCwg
aWYgdGhhdCdzIHdoYXQgZ2NjIGlzIGdvbm5hIGRvIGFuZA0KPiA+Pj4+IHNwbGl0dGluZyBlbnVt
cyBpcyB0aGUgb25seSB3YXkgdG8gYmUgb2theSBhY3Jvc3MgdGhlIGNvbXBpbGVyIHZlcnNpb25z
LA0KPiA+Pj4+IHRoZXJlIGlzbid0IGFueSBvdGhlciBjaG9pY2Ugd2UgY2FuIG1ha2UuDQo+ID4+
Pg0KPiA+Pj4gSXQgaXMgYWxzbyBhIHNpbGVudCBjb2RlLWJyZWFrZXIuDQo+ID4+PiBDb21waWxl
IHRoaXMgZm9yIDMyYml0IHg4NjoNCj4gPj4+DQo+ID4+PiBlbnVtIHsgYSA9IDEsIGIgPSB+MHVs
bH07DQo+ID4+DQo+ID4+IEJ1dCBoYXZpbmcgdWxsIGluIGFuIGVudW0gaXMgdW5kZWZpbmVkIGFu
eXdheS4gQzk5IGFsbG93cyBvbmx5IGludA0KPiA+PiBjb25zdGFudHMuIGdudUMgc3VwcG9ydHMg
dWxvbmcgZXhwcmVzc2lvbnMgKElJUkMpLg0KPiA+DQo+ID4gZ2NjIHN1cHBvcnRzICdsb25nIGxv
bmcnIGFzIHdlbGwgLSA2NGJpdCBvbiAzMmJpdCBzeXN0ZW1zLg0KPiANCj4gQ2FuIHlvdSBlbGFi
b3JhdGUgd2hhdCdzIHNvdXJjZSBvZiB0aGlzPyAuLi4NCg0KRXhwZXJpbWVudGF0aW9uLCBmb3Ig
ZXhhbXBsZToNCg0KaHR0cHM6Ly9nb2Rib2x0Lm9yZy96L240cm5jN2NLRw0KDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

