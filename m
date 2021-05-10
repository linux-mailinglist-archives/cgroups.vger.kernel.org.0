Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7E537935C
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 18:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhEJQIE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 12:08:04 -0400
Received: from mga07.intel.com ([134.134.136.100]:49667 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhEJQIC (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 12:08:02 -0400
IronPort-SDR: omNUBcyAZl5bUyEqhLe+iI/WabHbcDzBYYwCjxMsNRBqabsBGbZl3NnNm75Km9drkpxDZbFVfS
 4P1l6H4D0OGQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="263160450"
X-IronPort-AV: E=Sophos;i="5.82,286,1613462400"; 
   d="scan'208";a="263160450"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2021 09:06:34 -0700
IronPort-SDR: dnlIFFFwxspurSvFBH0h9NWjDR9VI7+YoZb18mumICFeecgC0nk5wCHIvaa5KpzY0BuF5agTst
 OWaaR3SVveDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,287,1613462400"; 
   d="scan'208";a="429961127"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 10 May 2021 09:06:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 09:06:33 -0700
Received: from irsmsx604.ger.corp.intel.com (163.33.146.137) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 10 May 2021 09:06:32 -0700
Received: from irsmsx604.ger.corp.intel.com ([163.33.146.137]) by
 IRSMSX604.ger.corp.intel.com ([163.33.146.137]) with mapi id 15.01.2106.013;
 Mon, 10 May 2021 17:06:31 +0100
From:   "Tamminen, Eero T" <eero.t.tamminen@intel.com>
To:     "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Welty, Brian" <brian.welty@intel.com>
CC:     "airlied@linux.ie" <airlied@linux.ie>,
        "tj@kernel.org" <tj@kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "tvrtko.ursulin@linux.intel.com" <tvrtko.ursulin@linux.intel.com>,
        "Kenny.Ho@amd.com" <Kenny.Ho@amd.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>
Subject: Re: [RFC PATCH 8/9] drm/gem: Associate GEM objects with drm cgroup
Thread-Topic: [RFC PATCH 8/9] drm/gem: Associate GEM objects with drm cgroup
Thread-Index: AQHW9Cx15TjPXGT9hUOJR9LC/Jv9PqpPu6eAgAJMa4CAASZwgIAjLNaAgBN73oCAAJfTgIBS/HgAgAAIQYA=
Date:   Mon, 10 May 2021 16:06:31 +0000
Message-ID: <09a39aa58c064a8f8e696a091a1b5edd22ef58b9.camel@intel.com>
References: <20210126214626.16260-1-brian.welty@intel.com>
         <20210126214626.16260-9-brian.welty@intel.com>
         <YCJp//kMC7YjVMXv@phenom.ffwll.local>
         <dffeb6a7-90f1-e17c-9695-44678e7a39cb@intel.com>
         <YCVOl8/87bqRSQei@phenom.ffwll.local>
         <89a71735-aae5-2617-c017-310207c5873b@intel.com>
         <CAKMK7uG2PFMWXa9o4LzsF1r0Mc-M8KqD-PKZkCj+m7XeO5wCyg@mail.gmail.com>
         <67867078-4f4b-0a6a-e55d-453b973d8b7c@intel.com>
         <CAKMK7uG7EWv93EbRcMRCm+opi=7fQPMOv2z1R6GBhJXb6--28w@mail.gmail.com>
In-Reply-To: <CAKMK7uG7EWv93EbRcMRCm+opi=7fQPMOv2z1R6GBhJXb6--28w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5931D961B8B5484C894BA9ABDE9A0665@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

SGksDQoNCk1vbiwgMjAyMS0wNS0xMCBhdCAxNzozNiArMDIwMCwgRGFuaWVsIFZldHRlciB3cm90
ZToNCj4gDQouLi4NCj4gPiBJZiBEUk0gYWxsb3dzIHVzZXItc3BhY2UgdG8gZXhoYXVzdCBhbGwg
b2Ygc3lzdGVtIG1lbW9yeSwgdGhpcyBzZWVtcw0KPiA+IHRvIGJlIGEgZ2FwIGluIGVuZm9yY2Vt
ZW50IG9mIE1FTUNHIGxpbWl0cyBmb3Igc3lzdGVtIG1lbW9yeS4NCj4gPiBJIHRyaWVkIHRvIGxv
b2sgaW50byBpdCB3aGVuIHRoaXMgd2FzIGRpc2N1c3NlZCBpbiB0aGUgcGFzdC4uLi4NCj4gPiBN
eSBndWVzcyBpcyB0aGF0IHNobWVtX3JlYWRfbWFwcGluZ19wYWdlX2dmcCgpIC0+DQo+ID4gc2ht
ZW1fZ2V0cGFnZV9nZnAoKSBpcyBub3QgY2hvb3NpbmcgdGhlIGNvcnJlY3QgTU0gdG8gY2hhcmdl
IGFnYWluc3QNCj4gPiBpbiB0aGUgdXNlIGNhc2Ugb2YgZHJpdmVycyB1c2luZyBzaG1lbWZzIGZv
ciBiYWNraW5nIGdlbSBidWZmZXJzLg0KPiANCj4gWWVhaCB3ZSBrbm93IGFib3V0IHRoaXMgb25l
IHNpbmNlIGZvcmV2ZXIuIFRoZSBidWcgcmVwb3J0IGlzIHJvdWdobHkNCj4gYXMgb2xkIGFzIHRo
ZSBnZW0vdHRtIG1lbW9yeSBtYW5hZ2VycyA6LS8gU28gYW5vdGhlciBwcm9ibGVtIG1pZ2h0IGJl
DQo+IHRoYXQgaWYgd2Ugbm93IHN1ZGRlbmx5IGluY2x1ZGUgZ3B1IG1lbW9yeSBpbiB0aGUgbWVt
Y2cgYWNjb3VudGluZywgd2UNCj4gc3RhcnQgYnJlYWtpbmcgYSBidW5jaCBvZiB3b3JrbG9hZHMg
dGhhdCB3b3JrZWQganVzdCBmaW5lIGJlZm9yZWhhbmQuDQoNCkl0J3Mgbm90IHRoZSBmaXJzdCB0
aW1lIHRpZ2h0ZW5pbmcgc2VjdXJpdHkgcmVxdWlyZXMgYWRhcHRpbmcgc2V0dGluZ3MNCmZvciBy
dW5uaW5nIHdvcmtsb2Fkcy4uLg0KDQpXb3JrbG9hZCBHUFUgbWVtb3J5IHVzYWdlIG5lZWRzIHRv
IGJlIHNpZ25pZmljYW50IHBvcnRpb24gb2YNCmFwcGxpY2F0aW9uJ3MgcmVhbCBtZW1vcnkgdXNh
Z2UsIHRvIGNhdXNlIHdvcmtsb2FkIHRvIGhpdCBsaW1pdHMgdGhhdA0KaGF2ZSBiZWVuIHNldCBm
b3IgaXQgZWFybGllci4gIFRoZXJlZm9yZSBJIHRoaW5rIGl0IHRvIGRlZmluaXRlbHkgYmUNCnNv
bWV0aGluZyB0aGF0IHVzZXIgc2V0dGluZyBzdWNoIGxpbWl0cyBhY3R1YWxseSBjYXJlcyBhYm91
dC4NCg0KPT4gSSB0aGluayB0aGUgaW1wb3J0YW50IHRoaW5nIGlzIHRoYXQgcmVhc29uIGZvciB0
aGUgZmFpbHVyZXMgaXMgY2xlYXINCmZyb20gdGhlIE9PTSBtZXNzYWdlLiAgVGhpcyB3b3JrcyBt
dWNoIGJldHRlciBpZiBHUFUgcmVsYXRlZCBtZW1vcnkNCnVzYWdlIGlzIHNwZWNpZmljYWxseSBz
dGF0ZWQgaW4gdGhhdCBtZXNzYWdlLCBvbmNlIHRoYXQgbWVtb3J5IHN0YXJ0cyB0bw0KYmUgYWNj
b3VudGVkIGZvciBzeXN0ZW0gbWVtb3J5Lg0KDQoNCgktIEVlcm8NCg0K
