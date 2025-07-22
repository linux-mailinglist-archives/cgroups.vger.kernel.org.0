Return-Path: <cgroups+bounces-8875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6391B0E64C
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 00:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CE07B476D
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6028640F;
	Tue, 22 Jul 2025 22:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2zTqM8WR"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9EBA937
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 22:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222586; cv=none; b=B7c/XpBlOwszeHBxxB579Oa/plzuJaMjQ0jk5802hOvOALETn/Ff9ISnnldCefaJ/qBeVC9tiul9/Pl4h8AeQxI11aMo+5CaDLpxFRRWjsNGaN15jDLPYHzhMb0zsJRlgyqvBfBZnmE3B+iUvX92/5V1oPE48vjg+A6cpVuxZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222586; c=relaxed/simple;
	bh=wMrajthTrfn+VJJ0omTKETlb5ZhBz0o5ltS36QpuDFk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IYRJ+Ne8xbvaKY31JZ5ILD1Pi+BRjFL1PDzX5VBC9JAzQYxgK9g5tde7e83v+eSSbOz/LFb/wYQEV3mTVogqavBjMNrzIR4G3U3AaOVSnIRZAXoSRpPX1wBf42Be7hjVqw+4BAvVfYcz0qz57432MeWTrKERTUSnIS0gKVZJcfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2zTqM8WR; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3132c1942a1so8270603a91.2
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753222584; x=1753827384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMrajthTrfn+VJJ0omTKETlb5ZhBz0o5ltS36QpuDFk=;
        b=2zTqM8WR3QgPqZmU7uYyYzzKxrM8XjgTzXijgvovUoqcb2SPaCCSzHlGTYr3WhRNOj
         Y5ipPQ9j4fW2KqHEXmZTGgu0y8cRWk6duOX0du/cJ5ExKE8qJVe2fBjaaDtAnQtoOaDX
         iVzzYW9ypOOjhTLO+6Qym5cbO1rIOxslvu/dJ+WVtPen7LejBu6eK7GrSTkyQsgPFwwY
         iUs8taPp+4YfXUSTSwgC8yv48Femp1yfPSQwoYv7ftbxzDC4hAM6laaApvvutry9jm3P
         FvjzErBVzl5WFx6Wa9+gR0hlPJi7IMrFBTzJJ1UvOMJGSP3wWkMP84aZBs6FhIKoca5n
         nZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222584; x=1753827384;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMrajthTrfn+VJJ0omTKETlb5ZhBz0o5ltS36QpuDFk=;
        b=wn7WYjDbbmVes2diIkZGDIZk0wcd19+nUPutiXzRiI5l/k3+LKakJdAgZfs7oRAlSf
         QxPZSGIFlxvKUjHCt43j2xNSh3VIfZ6qfqtwTNwlaqrPMY9npppyJcggoeQ7ECp+Zck9
         /oKP8EInw/taD/TqFbQc/PvwVysBCWbePnnoVrFyOuPMkAMcGu7YlyyZVkU4QFEyycWh
         TLfoYJJJn5d0FEJuwD0A5fKIyKRZcx9EsjO1FoosvU2JiUVOW4i0pK9Fe2t+WVj55jPa
         Mqj1KfzHaQ/qHGGljUgHs7jOAw+CL9LWaQuqtgRpYLcJqGeMk5odcnpRm1k1DdqQCurF
         hmDw==
X-Forwarded-Encrypted: i=1; AJvYcCWprNtUqNEMNhbODd+YcPf6x+JVoEXHh5fF03YibBIPBWIhdl+m106KFiB7dci0IkQIqWjvH0rY@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0XgOC9k5E25cIH1PWwtBSFYF+inhrOgtucY8iihsMU5i8uiq
	ovCmvdB+dQ8BeLr0rq7Aw9S1lkqfenzdChfDWBe82wxcJ/jCtIlpjOIUPIa2oePs0VfcdsaSlWG
	RRW/d35JM9g==
X-Google-Smtp-Source: AGHT+IEJJvfN1NwuQJ6NXfjDXeB1Dt54qr3NP+69gzSsnNNj3K1GVwu0drrKp25q4C0N9QwZZ7gUQxI7kUxQ
X-Received: from pjbsv15.prod.google.com ([2002:a17:90b:538f:b0:312:1dae:6bf0])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2b86:b0:311:e605:f60e
 with SMTP id 98e67ed59e1d1-31e507c19f9mr1308710a91.20.1753222584535; Tue, 22
 Jul 2025 15:16:24 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:16:22 -0700
In-Reply-To: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 ("Michal =?utf-8?Q?Koutn=C3=BD=22's?= message of "Thu, 17 Jul 2025 14:56:13 +0200")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714050008.2167786-2-ynaffit@google.com> <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8seinan2h.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+IHdyaXRlczoNCg0KPiBJJ2QgbGlrZSB0
byBpbmNvcnBvcmF0ZSB0aGUgcmVhc29uIGZyb20geW91ciBvdGhlciBtYWlsOg0KPiB8IFNpbmNl
IHRoZXJlIGlzbid0IHlldCBhIGNsZWFyIHdheSB0byBpZGVudGlmeSBhIHNldCBvZiAibG9zdCIg
dGltZQ0KPiB8IHRoYXQgZXZlcnlvbmUgKG9yIGF0IGxlYXN0IGEgd2lkZXIgZ3JvdXAgb2YgdXNl
cnMpIGNhcmVzIGFib3V0LCBpdA0KPiB8IHNlZW1zIGxpa2UgaXRlcmF0aW5nIG92ZXIgY29tcG9u
ZW50cyBvZiBpbnRlcmVzdCBpcyB0aGUgYmVzdCB3YXkNCj4gaW50byB0aGlzIGNvbW1pdCBtZXNz
YWdlIChiZWNhdXNlIHRoYXQncyBhIHN0cm9uZ2VyIHBvbml0IHRoYXQgeW91ciB1c2UNCj4gY2Fz
ZSBhbG9uZSkuDQoNCg0KPj4gQW55IGZlZWRiYWNrIHdvdWxkIGJlIG11Y2ggYXBwcmVjaWF0ZWQh
DQoNCj4gSSBjYW4gc2VlIGJlbmVmaXRzIG9mIHRoaXMgbmV3IHN0YXQgZmllbGQgY29uY2VwdHVh
bGx5LCBJIGhhdmUgc29tZQ0KPiByZW1hcmtzIHRvIGltcGxlbWVudGF0aW9uIGFuZCBzdWdnZXN0
aW9ucyB0byBjb252ZW50aW9ucyBiZWxvdy4NCg0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1p
bi1ndWlkZS9jZ3JvdXAtdjIucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L2Nncm91cC12Mi5yc3QNCj4+IEBAIC0xMDE4LDYgKzEwMTgsMTQgQEAgQWxsIGNncm91cCBjb3Jl
IGZpbGVzIGFyZSBwcmVmaXhlZCB3aXRoICJjZ3JvdXAuIg0KPj4gICAJaXQncyBwb3NzaWJsZSB0
byBkZWxldGUgYSBmcm96ZW4gKGFuZCBlbXB0eSkgY2dyb3VwLCBhcyB3ZWxsIGFzDQo+PiAgIAlj
cmVhdGUgbmV3IHN1Yi1jZ3JvdXBzLg0KDQo+PiArICBjZ3JvdXAuZnJlZXplLnN0YXQNCg0KPiBX
aXRoIHRoZSBnaXZlbiBpbXBsZW1lbnRhdGlvbiAoYW5kIHVzZSBzY2VuYXJpbyksIHRoaXMnZCBi
ZXR0ZXIgZXhwb3NlZA0KPiBpbg0KPiAgICBjZ3JvdXAuZnJlZXplLnN0YXQubG9jYWwNCg0KPiBJ
IGdyb2sgdGhlIGhpZXJhcmNoaWNhbCBzdW1taW5nIHdvdWxkIG1ha2UgbGl0dGxlIHNlbnNlIGFu
ZCBpdCdkIG1ha2UNCj4gaW1wbGVtZW50YWlvbiBtb3JlIGNvbXBsZXguIFdpdGggdGhhdCBJJ20g
dGhpbmtpbmcgYWJvdXQgZm9ybXVsYXRpb246DQoNCj4gCUN1bXVsYXRpdmUgdGltZSB0aGF0IGNn
cm91cCBoYXMgc3BlbnQgYmV0d2VlbiBmcmVlemluZyBhbmQNCj4gCXRoYXdpbmcsIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciBieSBzZWxmIG9yIGFuY2VzdG9yIGNncm91cHMuIE5CDQo+IAkobm90KSBy
ZWFjaGluZyAiZnJvemVuIiBzdGF0ZSBpcyBub3QgYWNjb3VudGVkIGhlcmUuDQoNCj4+ICsJQSBy
ZWFkLW9ubHkgZmxhdC1rZXllZCBmaWxlIHdoaWNoIGV4aXN0cyBpbiBub24tcm9vdCBjZ3JvdXBz
Lg0KPj4gKwlUaGUgZm9sbG93aW5nIGVudHJ5IGlzIGRlZmluZWQ6DQo+PiArDQo+PiArCSAgZnJl
ZXplX3RpbWVfdG90YWxfbnMNCj4+ICsJCUN1bXVsYXRpdmUgdGltZSB0aGF0IHRoaXMgY2dyb3Vw
IGhhcyBzcGVudCBpbiB0aGUgZnJlZXppbmcNCj4+ICsJCXN0YXRlLCByZWdhcmRsZXNzIG9mIHdo
ZXRoZXIgb3Igbm90IGl0IHJlYWNoZXMgImZyb3plbiIuDQo+PiArDQoNCj4gUmF0aGVyIHVzZSBt
aWNyb3NlY29uZHMsIGl0J3MgdGhlIGNncm91cCBBUEkgY29udmVudGlvbiBhbmQgSSdtIG5vdA0K
PiBzdXJlIG5hbm9zZWNvZHMgZXhwb3NlZCBoZXJlIGFyZSB0aGUgbmVlZGVkIHByZWNpc2lvbi4N
Cg0KDQpBY2suDQoNCj4gICAgICAgICAxICAgIF9fX19fDQo+IGZyb3plbiAwIF9fLyAgICAgXF9f
DQo+ICAgICAgICAgICAgYWIgICAgY2QNCg0KPiBZZWFoLCBJIGZpbmQgdGhlIG1lc3VyZW50IGJl
dHdlZW4gYSBhbmQgYyB0aGUgc2FuZXN0Lg0KDQoNCj4+ICtzdGF0aWMgaW50IGNncm91cF9mcmVl
emVfc3RhdF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqc2VxLCB2b2lkICp2KQ0KPj4gK3sNCj4+ICsJ
c3RydWN0IGNncm91cCAqY2dycCA9IHNlcV9jc3Moc2VxKS0+Y2dyb3VwOw0KPj4gKwl1NjQgZnJl
ZXplX3RpbWUgPSAwOw0KPj4gKw0KPj4gKwlzcGluX2xvY2tfaXJxKCZjc3Nfc2V0X2xvY2spOw0K
Pj4gKwlpZiAodGVzdF9iaXQoQ0dSUF9GUkVFWkUsICZjZ3JwLT5mbGFncykpDQo+PiArCQlmcmVl
emVfdGltZSA9IGt0aW1lX2dldF9ucygpIC0gY2dycC0+ZnJlZXplci5mcmVlemVfdGltZV9zdGFy
dF9uczsNCj4+ICsNCj4+ICsJZnJlZXplX3RpbWUgKz0gY2dycC0+ZnJlZXplci5mcmVlemVfdGlt
ZV90b3RhbF9uczsNCj4+ICsJc3Bpbl91bmxvY2tfaXJxKCZjc3Nfc2V0X2xvY2spOw0KDQo+IEkg
ZG9uJ3QgbGlrZSB0YWtpbmcgdGhpcyBzcGlubG9jayBvbmx5IGZvciB0aGUgbWF0dGVyIG9mIHJl
YWRpbmcgdGhpcw0KPiBhdHRyaWJ1dGUuIFRoZSBpbnRlbnRpb24gc2hvdWxkIGJlIHRvIGtlZXAg
dGhlICh1bilmcmVlemVpbmcgbW9zdGx5DQo+IHVuYWZmZWN0ZWQgYXQgdGhlIGV4cGVuc2Ugb2Yg
dGhlc2UgcmVhZGVycyAoc2VxY291bnQgb3IgdTY0IHN0YXRzPykuDQoNCg0KQWgsIHRoYW5rIHlv
dSBmb3IgdGhpcyBzdWdnZXN0aW9uISBJIG5vdGljZWQgdGhhdCBub25lIG9mIHRoZSBvdGhlcg0K
c2VxX2ZpbGUgcmVhZCBpbXBsZW1lbnRhdGlvbnMgdG9vayBhIGxvY2ssIHNvIEkgdGhvdWdodCB0
aGlzIG1pZ2h0IGJlIGENCnBvaW50IG9mIGNvbnRlbnRpb24uIEknbGwgdHJ5IGEgc2VxbG9jayBp
biB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZQ0KcGF0Y2guDQoNCj4gQWx0ZXJuYXRpdmUgYXBwcm9h
Y2g6IGVpdGhlciB0aGVyZSdzIG91dGVyIHdhdGNoZXIgd2hvIGNhbiBiZSBub3RpZmllZA0KPiBi
eSBjZ3JvdXAuZXZlbnRzOmZyb3plbiBvciBpdCdzIGFuIGlubmVyIHdhdGNoZXIgd2hvIGNvdWxk
bid0IGFjdGl2ZWx5DQo+IHJlYWQgdGhlIGZpZWxkIGFueXdheS4gU28gdGhlIGZpZWxkIGNvdWxk
IG9ubHkgc2hvdyBjb21wbGV0ZWQNCj4gZnJlZXplL3RoYXcgY3ljbGVzIGZyb20gdGhlIHBhc3Qg
KGkuZS4gbm90IHN1YnN0aXR1dGUgY2xvY2tfZ2V0dGltZSgyKQ0KPiB3aGVuIHRoZSBjZ3JvdXAg
aXMgZnJvemVuKSwgd2hpY2ggY291bGQgc2ltcGxpZnkgcXVlcnlpbmcgdGhlIGZsYWcgdG9vLg0K
DQoNClRoaXMgaXMgYSBnb29kIG9ic2VydmF0aW9uLiBUaGlzIGFwcHJvYWNoIGRvZXMgc2ltcGxp
ZnkgdGhpbmdzLCBidXQNCmV2ZW4gdGhvdWdoIGl0IHdvdWxkIHdvcmsgZm9yIG91ciB1c2UgY2Fz
ZSwgSSBmZWVsIGxpa2UgdGhpcyB2YWx1ZQ0Kd291bGQgYmUgbGVzcyB1c2VmdWwgZm9yIHRoZSBv
dXRlciB3YXRjaGVyIGNhc2UsIGVzcGVjaWFsbHkgaW4gdGhlIGNhc2UNCndoZXJlIHRoZSBjZ3Jv
dXAgbmV2ZXIgcmVhY2hlcyB0aGUgZnJvemVuIHN0YXRlLg0KDQo+PiBAQCAtNTc1OCw2ICs1Nzgw
LDcgQEAgc3RhdGljIHN0cnVjdCBjZ3JvdXAgKmNncm91cF9jcmVhdGUoc3RydWN0IGNncm91cCAg
DQo+PiAqcGFyZW50LCBjb25zdCBjaGFyICpuYW1lLA0KPj4gICAJICogaWYgdGhlIHBhcmVudCBo
YXMgdG8gYmUgZnJvemVuLCB0aGUgY2hpbGQgaGFzIHRvby4NCj4+ICAgCSAqLw0KPj4gICAJY2dy
cC0+ZnJlZXplci5lX2ZyZWV6ZSA9IHBhcmVudC0+ZnJlZXplci5lX2ZyZWV6ZTsNCj4+ICsJY2dy
cC0+ZnJlZXplci5mcmVlemVfdGltZV90b3RhbF9ucyA9IDA7DQoNCj4gc3RydWN0IGNncm91cCBp
cyBremFsbG9jJ2QsIHRoaXMgaXMgdW5uZWNlc3NhcnkNCg0KVGhhbmsgeW91IGZvciBhbGwgeW91
ciBmZWVkYmFjayEgSSdsbCBtYWtlIHN1cmUgdG8gaW5jb3Jwb3JhdGUgdGhlc2UNCnN1Z2dlc3Rp
b25zIGludG8gdGhlIG5leHQgdmVyc2lvbi4NCg0KLS0gDQpUaWZmYW55IFkuIFlhbmcNCg==

