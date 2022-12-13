Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B02264B46E
	for <lists+cgroups@lfdr.de>; Tue, 13 Dec 2022 12:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiLMLuL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Dec 2022 06:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbiLMLuK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Dec 2022 06:50:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0FCFCD4
        for <cgroups@vger.kernel.org>; Tue, 13 Dec 2022 03:50:08 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-12-Bl4TgW_RMbKU5U7vIV3uIw-1; Tue, 13 Dec 2022 11:50:06 +0000
X-MC-Unique: Bl4TgW_RMbKU5U7vIV3uIw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 13 Dec
 2022 11:50:04 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Tue, 13 Dec 2022 11:50:04 +0000
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
Thread-Index: AQHY7hGH734dfSyX20WOi86L/FtKtq4rTpIAgD+71dKAALHkcIAAL92AgAACt3A=
Date:   Tue, 13 Dec 2022 11:50:04 +0000
Message-ID: <542d413b9d044474a34b6e7a40d70541@AcuMS.aculab.com>
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
In-Reply-To: <9d2ead31-efab-cf49-08d4-1e613382d89f@kernel.org>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiAxMyBEZWNlbWJlciAyMDIyIDExOjE1DQo+IA0KPiBP
biAxMy4gMTIuIDIyLCA5OjMwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogVGVqdW4g
SGVvIDxodGVqdW5AZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgJ1RlanVuIEhlbycNCj4gPj4gU2Vu
dDogMTIgRGVjZW1iZXIgMjAyMiAyMTo0Nw0KPiA+PiBUbzogSmlyaSBTbGFieSA8amlyaXNsYWJ5
QGtlcm5lbC5vcmc+DQo+ID4+IENjOiBEYXZpZCBMYWlnaHQgPERhdmlkLkxhaWdodEBBQ1VMQUIu
Q09NPjsgQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRlYWQub3JnPjsgbGludXgtDQo+ID4+
IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IE1hcnRpbiBMaXNrYSA8bWxpc2thQHN1c2UuY3o+OyBK
b3NlZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+OyBKZW5zDQo+IEF4Ym9lDQo+ID4+IDxh
eGJvZUBrZXJuZWwuZGs+OyBjZ3JvdXBzQHZnZXIua2VybmVsLm9yZzsgbGludXgtYmxvY2tAdmdl
ci5rZXJuZWwub3JnDQo+ID4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGJsb2NrL2Jsay1pb2Nvc3Qg
KGdjYzEzKTogY2FzdCBlbnVtIG1lbWJlcnMgdG8gaW50IGluIHByaW50cw0KPiA+Pg0KPiA+PiBP
biBNb24sIERlYyAxMiwgMjAyMiBhdCAwMToxNDozMVBNICswMTAwLCBKaXJpIFNsYWJ5IHdyb3Rl
Og0KPiA+Pj4+IElmIHNvLCBteSBzdWdnZXN0aW9uIGlzIGp1c3Qgc3RpY2tpbmcgd2l0aCB0aGUg
b2xkIGJlaGF2aW9yIHVudGlsIHdlIHN3aXRjaA0KPiA+Pj4+IHRvIC0tc3RkPWcyeCBhbmQgdGhl
biBtYWtlIG9uZSB0aW1lIGFkanVzdG1lbnQgYXQgdGhhdCBwb2ludC4NCj4gPj4+DQo+ID4+PiBT
byBpcyB0aGUgZW51bSBzcGxpdCBPSyB1bmRlciB0aGVzZSBjaXJjdW1zdGFuY2VzPw0KPiA+Pg0K
PiA+PiBPaCBtYW4sIGl0J3Mga2luZGEgY3JhenkgdGhhdCB0aGUgY29tcGlsZXIgaXMgY2hhbmdp
bmcgaW4gYSB3YXkgdGhhdCB0aGUNCj4gPj4gc2FtZSBwaWVjZSBvZiBjb2RlIGNhbid0IGJlIGNv
bXBpbGVkIHRoZSBzYW1lIHdheSBhY3Jvc3MgdHdvIGFkam9pbmluZw0KPiA+PiB2ZXJzaW9ucyBv
ZiB0aGUgc2FtZSBjb21waWxlci4gQnV0LCB5ZWFoLCBpZiB0aGF0J3Mgd2hhdCBnY2MgaXMgZ29u
bmEgZG8gYW5kDQo+ID4+IHNwbGl0dGluZyBlbnVtcyBpcyB0aGUgb25seSB3YXkgdG8gYmUgb2th
eSBhY3Jvc3MgdGhlIGNvbXBpbGVyIHZlcnNpb25zLA0KPiA+PiB0aGVyZSBpc24ndCBhbnkgb3Ro
ZXIgY2hvaWNlIHdlIGNhbiBtYWtlLg0KPiA+DQo+ID4gSXQgaXMgYWxzbyBhIHNpbGVudCBjb2Rl
LWJyZWFrZXIuDQo+ID4gQ29tcGlsZSB0aGlzIGZvciAzMmJpdCB4ODY6DQo+ID4NCj4gPiBlbnVt
IHsgYSA9IDEsIGIgPSB+MHVsbH07DQo+IA0KPiBCdXQgaGF2aW5nIHVsbCBpbiBhbiBlbnVtIGlz
IHVuZGVmaW5lZCBhbnl3YXkuIEM5OSBhbGxvd3Mgb25seSBpbnQNCj4gY29uc3RhbnRzLiBnbnVD
IHN1cHBvcnRzIHVsb25nIGV4cHJlc3Npb25zIChJSVJDKS4NCg0KZ2NjIHN1cHBvcnRzICdsb25n
IGxvbmcnIGFzIHdlbGwgLSA2NGJpdCBvbiAzMmJpdCBzeXN0ZW1zLg0KDQpJbiBwcmFjdGljYWwg
dGVybXMgaXQgcmVhbGx5IGRvZXNuJ3QgbWF0dGVyIHdoYXQgQzk5IChvciBhbnkgb3RoZXINCnZl
cnNpb24pIHNheXMsIHRoZSBpbXBvcnRhbnQgdGhpbmcgaXMgdGhhdCB0aGUgY29tcGlsZXIgYWNj
ZXB0ZWQgaXQuDQoNCj4gPiBleHRlcm4gaW50IGZvbyhpbnQsIC4uLik7DQo+ID4gaW50IGYodm9p
ZCkNCj4gPiB7DQo+ID4gICAgICByZXR1cm4gZm9vKDAsIGEsIDIpOw0KPiA+IH0NCj4gPg0KPiA+
IGdjYzEzIHB1c2hlcyBhbiBleHRyYSB6ZXJvIG9udG8gdGhlIHN0YWNrIGJldHdlZW4gdGhlIDEg
YW5kIDIuDQo+IA0KPiBTbyB0aGlzIGlzIHNvcnQgb2YgImV4cGVjdGVkIi4NCg0KRm9yIHNvbWUg
ZGVmaW5pdGlvbnMgb2YgImV4cGVjdGVkIiA6LSkNCg0KTm90ZSB0aGF0IGl0IChwcm9iYWJseSkg
bWFrZXMgbm8gYWN0dWFsIGRpZmZlcmVuY2UgdG8gc29tZSBhcmNoaXRlY3R1cmVzDQoobGlrZSA2
NGJpdCB4ODYpIHdoZXJlIGFsbCB2YXJhcmdzIHBhcmFtZXRlcnMgYXJlIHBhc3NlZCBhcyA2NGJp
dC4NCkV4dGVuZGluZyBhIHZhbHVlIHRvIDY0Yml0cyBqdXN0IG1ha2VzIHRoZSBoaWdoIGJpdHMg
d2VsbCBkZWZpbmVkLg0KKFRoZSBoaWdoIGJpdHMgb2Ygc3RhY2tlZCAzMmJpdCBhcmdzIGFyZSB1
bmRlZmluZWQuKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBC
cmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdp
c3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

