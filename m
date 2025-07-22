Return-Path: <cgroups+bounces-8876-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4907FB0E669
	for <lists+cgroups@lfdr.de>; Wed, 23 Jul 2025 00:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A7191C822EB
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D51288522;
	Tue, 22 Jul 2025 22:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KoZjtG5X"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42461AB6F1
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 22:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223249; cv=none; b=hXFRJTJohv4Gu/g4RKCx6qyk0ELtRbklJ8qDohjYmqqXIAwcTVQe74/fhVj04i1k4XcXRcJvGsbTsb3cB+acoP9ZOTKGMgIsLDJZ7SxYp/c0qqAfuBcigkmA1H9wgmg9xRo08Vf+fOBcVcIvDI3lK/4xFOhK8kThhPkWKmW/7Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223249; c=relaxed/simple;
	bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kz5Q5EvlY5cnxhSVicljG5XDYe139pokxwPDkBkGMEMuO0d4edg2s7nXrTKNxhiVJESKbh9w1bZXscKLVIR4/Yvb77PBFOg9+DmsuIDIv47sh4WQ5vuHv0hTtN+q/Sl9LopFLACabQoA5XJvCk5UiZULhMv8ehAaVHZk0RjnzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KoZjtG5X; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-311e7337f26so6189962a91.3
        for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753223247; x=1753828047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
        b=KoZjtG5XiImMQQOtLEMdnLQ18qvw+btRKfeO+vCQVdORjgucQHPpnxNEOxWqVbzmSK
         imHqs2XomCY2jddhJonEiAvIjz8DK9G51v1RfmdSf9m10qPYrauUCTKSqGGZ+zjv8TRX
         xQ229OagEnUk2/u+zCFdAkwwvL8u6kDFSsGPWMDBo+Fm+iDgkCvNJBdRKSwGdcs72hz+
         MnADrBHYVj2YepqdkHYFmH/pDain7w7ijMKRjCi1i1NYSCwD8I3r907L45L7r7yuGi0E
         85+EFGXzSJ8AcRjK5qQC91dDifR8jpizEGJzCPAODC39bgbLijC4bFwPDDODdOcMdxiq
         aTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223247; x=1753828047;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mb4kKTr2b2SV59aU/jYfBTXhmbecwaKvdvs8GM35uqg=;
        b=Uf4IEsYB5twupvEoViPToAqSWQA5H2/rvQ/d9/6EcVSoSWxvwO+VpLrhIM1R7qBF7U
         4D/KA/1DDUIGzsXZbJbz6Se6xjIlWlhJ+yc9gCMQugecPZGu6827ANvO0s8d98QYaxJt
         EvK7jX8ZxfDsnx9yXrHDg39oGw7C9o0TLABJMqVOfLCFId+XrnbnU5/3wZQJ9nVzogEI
         3I9UBn7jqxCVPnHbJeXJ/jezHpbOxF3PQ1r/l6i9mLN1qzi4f0xPtq22UXYJIZmAdXQ7
         S1Qc2Y2atTgIpvu6JjaBEvvAmJlHxjjTCHrAejChr+pkGjH9T8jjQjVkCqhvCteGpMGe
         0JQA==
X-Forwarded-Encrypted: i=1; AJvYcCW8QaibHsRnn4BbLE4dGfmBE/CSHZDYVWOhZpQ1hCNKTSU4W0Xs6BTXr3g2xeMkmF4MapGj5mol@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5spQJ+IbH9jf8JYh8AessIR0vISSMDoweTZ+j45CYHR0+9+bL
	x6HwJbqOHwIv8Zo+tfBc5N+z2G6b1rhlwptzlHYOuFQzTxkC/FfJ/eLauppT2KDb3JhHcIyvTBE
	KkeeRrcCiwQ==
X-Google-Smtp-Source: AGHT+IHdtzMNdz7v/eZVyhMXcY5p63zKcUoUhYPBqTUBbkO9Ow+dJHxndxUnQJPdWqaO1hNSSqMcGmPDkvj2
X-Received: from pjboh11.prod.google.com ([2002:a17:90b:3a4b:b0:312:e914:4548])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3e83:b0:312:e1ec:de44
 with SMTP id 98e67ed59e1d1-31e507dc9e6mr1264437a91.27.1753223247203; Tue, 22
 Jul 2025 15:27:27 -0700 (PDT)
Date: Tue, 22 Jul 2025 15:27:25 -0700
In-Reply-To: <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com> (Chen
 Ridong's message of "Thu, 17 Jul 2025 21:52:38 +0800")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714050008.2167786-2-ynaffit@google.com> <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <6c9278b7-4eb4-4b47-b61a-a5bcc7e558b0@huaweicloud.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8jz3zamk2.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH v2] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, linux-kernel@vger.kernel.org, 
	John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgUmluZG9uZywNCg0KQ2hlbiBSaWRvbmcgPGNoZW5yaWRvbmdAaHVhd2VpY2xvdWQuY29tPiB3
cml0ZXM6DQoNCj4gT24gMjAyNS83LzE3IDIwOjU2LCBNaWNoYWwgS291dG7DvSB3cm90ZToNCj4+
IEhlbGxvIFRpZmZhbnkuDQoNCj4+IE9uIFN1biwgSnVsIDEzLCAyMDI1IGF0IDEwOjAwOjA5UE0g
LTA3MDAsIFRpZmZhbnkgWWFuZyAgDQo+PiA8eW5hZmZpdEBnb29nbGUuY29tPiB3cm90ZToNCg0K
Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2dyb3VwLXYyLnJzdA0KPj4+ICsr
KyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2dyb3VwLXYyLnJzdA0KPj4+IEBAIC0xMDE4
LDYgKzEwMTgsMTQgQEAgQWxsIGNncm91cCBjb3JlIGZpbGVzIGFyZSBwcmVmaXhlZCB3aXRoICJj
Z3JvdXAuIg0KPj4+ICAgCWl0J3MgcG9zc2libGUgdG8gZGVsZXRlIGEgZnJvemVuIChhbmQgZW1w
dHkpIGNncm91cCwgYXMgd2VsbCBhcw0KPj4+ICAgCWNyZWF0ZSBuZXcgc3ViLWNncm91cHMuDQoN
Cj4+PiArICBjZ3JvdXAuZnJlZXplLnN0YXQNCg0KPj4gV2l0aCB0aGUgZ2l2ZW4gaW1wbGVtZW50
YXRpb24gKGFuZCB1c2Ugc2NlbmFyaW8pLCB0aGlzJ2QgYmV0dGVyIGV4cG9zZWQNCj4+IGluDQo+
PiAgICBjZ3JvdXAuZnJlZXplLnN0YXQubG9jYWwNCg0KDQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxl
IHRvIGFkZCB0aGlzIGZpZWxkIHRvIGVpdGhlciBjZ3JvdXAuZXZlbnQgb3IgIA0KPiBjZ3JvdXAu
c3RhdD8NCj4gU2luY2UgdGhlIGZyb3plbiBzdGF0dXMgaXMgYWxyZWFkeSB0cmFja2VkIGluIGNn
cm91cC5ldmVudCwgdGhpcyAgDQo+IHBsYWNlbWVudCB3b3VsZCBtYWludGFpbiBiZXR0ZXINCj4g
Y29oZXNpb24gd2l0aCBleGlzdGluZyBtZXRyaWNzLg0KDQo+IFRoaXMgaXMganVzdCBhIHN1Z2dl
c3Rpb24uDQoNCj4gQmVzdCByZWdhcmRzLA0KPiBSaWRvbmcNCg0KVGhhbmtzIGZvciB0YWtpbmcg
YSBsb29rIQ0KDQpJIGRvbid0IHRoaW5rIHRoaXMgd291bGQgKnF1aXRlKiBmaXQgaW4gY2dyb3Vw
LmV2ZW50IGJlY2F1c2Ugd2UncmUNCm1lYXN1cmluZyB3aGVuIHRoZSBjZ3JvdXAgYmVnaW5zIGZy
ZWV6aW5nIGluc3RlYWQgb2Ygd2hlbiBpdCByZWFjaGVzIHRoZQ0KZnJvemVuIHN0YXRlLiBJIGFs
c28gd29ycnkgdGhhdCBoYXZpbmcgdGhlIHZhbHVlIHNvIGNsb3NlIHRvDQpjZ3JvdXAuZnJvemVu
IHdvdWxkIGNhdXNlIGFkZGl0aW9uYWwgY29uZnVzaW9uIGFib3V0IGl0cw0KbWVhbmluZy4gY2dy
b3VwLnN0YXQgc2VlbXMgcmVhc29uYWJsZSwgYnV0IHRoZSB2YWx1ZXMgaW5zaWRlIGFwcGVhciB0
bw0KYmUgYWNjb3VudGVkIGZvciBoaWVyYXJjaGljYWxseSwgd2hpY2ggd291bGRuJ3Qgc3VpdCBv
dXIgdXNlIGNhc2UuDQoNCi0tIA0KVGlmZmFueSBZLiBZYW5nDQo=

