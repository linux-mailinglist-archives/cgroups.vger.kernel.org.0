Return-Path: <cgroups+bounces-8722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8333B03566
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 06:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBE73BA5CC
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F8C211290;
	Mon, 14 Jul 2025 04:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wIbsefYh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CFC204F9B
	for <cgroups@vger.kernel.org>; Mon, 14 Jul 2025 04:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752468829; cv=none; b=UbVVOZW/MvQZCr68UVIyRk1EBwkj96oIcCN+LsWt5NYCp9yu2wPZHIf1VlDa4AGJA7wVfqSbQoKMfP/2BrH1Zz15X6CjBCGzk3achr+/111c8/rcW35DZxijeucdlzqZ9Otv8jAYMXCcc+GDQiSvwONB3L8M8vauGNpVcpgPYRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752468829; c=relaxed/simple;
	bh=7bXjRHiI47UNMRzrGl1d7MXm4Qp3OxzayVbsyPKgo/U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UpsX+OlGk81yMG3dzxfHxL2dtAtbYK/ggnHUwqp9f/gOQS17tpKpbvs4q4CUZhUQHBJIEr/HN3QNb0lmJsAXeBSAkqzMk3OkTVpmlCXvtWzEULM0Cz9Lj9A4cAo8Zng9/VFMwz4e5a0Yxg6QsGtQLd+ZCcuRto+xeY+bklxiMns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wIbsefYh; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ynaffit.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2d9ea524aa6so4256028fac.0
        for <cgroups@vger.kernel.org>; Sun, 13 Jul 2025 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752468826; x=1753073626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bXjRHiI47UNMRzrGl1d7MXm4Qp3OxzayVbsyPKgo/U=;
        b=wIbsefYhKvMLqoyxdjEphpe3+hvaDNQemgEhdzFbxvXG5DS6bqMW3+IYYtPZVBaP5m
         2K4nwP4+UbTKC9BafoK6mEGtCDmuoSbD0tXh7TyTn6RB7LqSzcBfJpsseflCIkvyJ8V6
         OQ8LQglYHBUMafmcHlmtaPvbTUEFz3ED7yGiorBgWRMfNGUp8pI4TF2GDW4LQtJ9y6kI
         K4Mt8Q15Oi1hu+MynqIvPJX+xg5CiqxiG25ZpiPwlZAXOWSyay2v4cw1DIAvEI+DYoum
         2B49MVIuIlT4j/5WHJw3nzq5cqNGC2ds+3RdXjZTbCDrFSNqTs3258UhdCiwfWQ7GsFL
         Bjxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752468826; x=1753073626;
        h=content-transfer-encoding:cc:to:from:subject:message-id:user-agent
         :references:mime-version:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bXjRHiI47UNMRzrGl1d7MXm4Qp3OxzayVbsyPKgo/U=;
        b=R27WnfZm3O6DNsyb+w5JWfmoNUAI/ymsU/+x5KRFl4084W2q/Wo61pT/L8fncCEQza
         tIQHp9S8yUYJpQdyqrxSAflK07rQ+r/RFHbj7HncfUWF2p6Q8r4/gmaOlibDlXDgB21g
         /3HSOsuzqzp2ZVW4/nQkWQaZxDJBNFzt/8AEmKilIR0KLnawdQ57V/fLN6eQ4SyNy7zq
         XZnwF3N4vwZE6rereAwpT7hcpxiWIkoYarpzroJ80OOVc9MAUjexgp2R14jFRZFwo1Ba
         ZAa0jqZWFqfD0VN/0HiTlXdoOLmW11lifFTcGIv1JUQ0aAa2FM3bF2+FKr7nT7JkN83S
         NzLw==
X-Forwarded-Encrypted: i=1; AJvYcCX4/L+8dzrsqkSRgG/j8YkvAIH9a339L1SUuadNagJCx72vNA8RaFDVPRLOA/mBBHOzIUdJfmZw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+l+p5wb8V9bzce+Cr2B7Dvf0XaCEgMERdBJ0MoaqX4QbMi3cj
	JGSQgIf030wJdB8FlG7Qg/dvFevJsponep2Zn2AOY1DNlJBEd+ORgqhflY4mqHrfmRxoFcLL4hE
	/ilrWwyMG0g==
X-Google-Smtp-Source: AGHT+IFycs6ExMKIq4iAOKf4cU4uPB/I0zZjZbEXW6RgDMEwKTVejcJf1yepScN61AgHIGEO2UnV5ttGNtrh
X-Received: from oabhi25.prod.google.com ([2002:a05:6870:c999:b0:295:ef58:6002])
 (user=ynaffit job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:2b20:b0:2c2:c92a:5789
 with SMTP id 586e51a60fabf-2ff26e4a12cmr8334191fac.5.1752468826465; Sun, 13
 Jul 2025 21:53:46 -0700 (PDT)
Date: Sun, 13 Jul 2025 21:53:45 -0700
In-Reply-To: <ry6p5w3p4l7pnsovyapu6n2by7f4zl63c7umwut2ngdxinx6fs@yu53tunbkxdi>
 ("Michal =?utf-8?Q?Koutn=C3=BD=22's?= message of "Mon, 30 Jun 2025 19:40:28 +0200")
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250603224304.3198729-3-ynaffit@google.com> <gn6xiuqczaoiepdczg364cj46riiskvqwgvyaawbb3bpaybaw4@5iiohkyscrek>
 <dbx8h601k4ms.fsf@ynaffit-andsys.c.googlers.com> <ry6p5w3p4l7pnsovyapu6n2by7f4zl63c7umwut2ngdxinx6fs@yu53tunbkxdi>
User-Agent: mu4e 1.12.9; emacs 30.1
Message-ID: <dbx8o6tn8jae.fsf@ynaffit-andsys.c.googlers.com>
Subject: Re: [RFC PATCH] cgroup: Track time in cgroup v2 freezer
From: Tiffany Yang <ynaffit@google.com>
To: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	kernel-team@android.com, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Chen Ridong <chenridong@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

TWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+IHdyaXRlczoNCg0KPiBXb3VsZCBpdCBi
ZSBzdWZmaWNpZW50IHRvIG1lYXN1cmUgdGhhdCBkZWFkbGluZSBhZ2FpbnN0DQo+IGNwdS5zdGF0
OnVzYWdlX3VzZWMgKENQVSB0aW1lIGNvbnN1bWVkIGJ5IHRoZSBjZ3JvdXApPyBPciBkbyBJDQo+
IG1pc3VuZGVyc3RhbmQgeW91ciBsYXR0ZXIgZGVhZGxpbmUgbWV0cmljPw0KDQpDUFUgdGltZSBp
cyBhIGdvb2Qgd2F5IHRvIHRoaW5rIGFib3V0IHRoZSBxdWFudGl0eSB3ZSBhcmUgdHJ5aW5nIHRv
DQptZWFzdXJlIGFnYWluc3QsIGJ1dCBpdCBkb2VzIG5vdCBhY2NvdW50IGZvciBzbGVlcCB0aW1l
IChlaXRoZXINCnZvbHVudGFyaWx5IG9yIHdhaXRpbmcgb24gYSBmdXRleCwgZXRjLikuIFVubGlr
ZSBmcmVlemUgdGltZSwgd2Ugd291bGQNCndhbnQgc2xlZXAgdGltZSB0byBjb3VudCBhZ2FpbnN0
IG91ciBkZWFkbGluZSBiZWNhdXNlIGEgdGltZW91dCB3b3VsZA0KbGlrZWx5IGluZGljYXRlIGEg
cHJvYmxlbSBpbiB0aGUgYXBwbGljYXRpb24ncyBsb2dpYy4NCg0KPiAoTm90ZSB0aGF0IFNJR1NU
T1AgbWF5IGJlIHNlbnQgdG8gc2VsZiBvciB3aXRoaW4gdGhlIGdyb3VwIGJ1dCkgbWluZA0KPiB0
aGF0IGV2ZW4gdGhlIGNhdGVnb3J5ICJub3QgcmVxdWVzdGVkIiBpcyBzcGxpdCBpbnRvIHR3byBv
dGhlcjogcmVzb3VyY2UNCj4gY29udGVudGlvbiBhbmQgZnJlZXppbmcgbWFuYWdlbWVudC4gQW5k
IHRoZSBsYXR0ZXIgc2hvdWxkIGJlIHVuZGVyDQo+IGNvbnRyb2wgb2YgdGhlIGFnZW50IHRoYXQg
c2V0cyB0aGUgZGVhZGxpbmVzLg0KDQoNClRoaXMgd291bGQgYmUgaWRlYWwsIGJ1dCBpbiBvdXIg
Y2FzZSwgdGhlIGFnZW50IHRoYXQgc2V0cy9lbmZvcmNlcyB0aGUNCmRlYWRsaW5lcyBpcyBhIHRh
c2sgaW4gdGhlIHNhbWUgYXBwbGljYXRpb24uIEl0IGhhcyBubyBjb250cm9sIG92ZXINCmZyZWV6
aW5nIGV2ZW50cyBhbmQgKGN1cnJlbnRseSkgbm8gd2F5IHRvIGtub3cgd2hlbiBvbmUgaGFzDQpv
Y2N1cnJlZC4gQ29uc2VxdWVudGx5LCBldmVuIGlmIHRoZSBmcmVlemluZyBtYW5hZ2VyIHdlcmUg
dG8gc2VuZCB0aGUNCnJlbGV2YW50IGluZm9ybWF0aW9uIHRvIG91ciBhZ2VudCwgbm9uZSBvZiB0
aG9zZSBtZXNzYWdlcyBjb3VsZCBiZQ0KcHJvY2Vzc2VkIHVudGlsIHRoZSBhcHBsaWNhdGlvbiB3
YXMgdW5mcm96ZW4uDQoNClRoZSByZXN1bHQgd291bGQgYmUgY29tcGV0aW5nIGRpcmVjdGx5IGFn
YWluc3QgdGhlIHRhc2sgdW5kZXIgZGVhZGxpbmUNCih0byBoYW5kbGUgY29tbXVuaWNhdGlvbiBh
cyBpdCBjYW1lIGluKSBvciBkZWxheWluZyBjb3JyZWN0aXZlIGFjdGlvbg0KZGVjaXNpb25zICh0
byB3YWl0IHVudGlsIHRoZSBkZWFkbGluZSB0byBkZWFsIHdpdGggYW55IG1lc3NhZ2VzKS4gSWYg
dGhlDQphcHBsaWNhdGlvbiB3ZXJlIGZyb3plbiBtdWx0aXBsZSB0aW1lcyBkdXJpbmcgdGhlIHRp
bWVyIGludGVydmFsLCB0aGF0DQpjb3N0IHdvdWxkIGJlIGluY3VycmVkIGVhY2ggdGltZS4gQXMg
YW4gYWx0ZXJuYXRpdmUsIHRoZSB3YXRjaGRvZyBjb3VsZA0KcmVxdWVzdCB0aGlzIGluZm9ybWF0
aW9uIGZyb20gdGhlIGZyZWV6aW5nIG1hbmFnZXIgdXBvbiB0aW1lciBlbGFwc2UsDQpidXQgdGhh
dCB3b3VsZCBhbHNvIGludHJvZHVjZSBzaWduaWZpY2FudCBsYXRlbmN5IHRvIGRlYWRsaW5lDQpl
bmZvcmNlbWVudC4NCg0KPiBUaG9zZSBhcmUgb3JkZXIocykgb2YgbWFnbml0dWRlIGRpZmZlcmVu
dC4gSSBjYW4ndCBpbWFnaW5lIHRoYXQgdXNpbmcNCj4gZnJlZXplciBmb3Igam9icyB3aGVyZSBh
bHNvIHdha2V1cCBsYXRlbmN5IG1hdHRlcnMuDQoNClRoaXMgaXMgdHJ1ZSEgVGhlc2UgZXhhbXBs
ZXMgd2VyZSBtYWlubHkgdG8gaWxsdXN0cmF0ZSB0aGUgYnJlYWR0aCBvZg0KdGhlIHByb2JsZW0g
c3BhY2UvaG93IHNsaXBwZXJ5IGl0IGNhbiBiZSB0byBnZW5lcmFsaXplLg0KDQo+IFdlbGwsIHRo
ZXJlIGFyZSBtdWx0aXBsZSBzaW1pbGFyIG1ldHJpY3M6IHZhcmlvdXMgKGNncm91cCkgUFNJLCAo
Z2xvYmFsKQ0KPiBzdGVhbCB0aW1lLCBjcHUuc3RhdDp0aHJvdHRsZWRfdXNhZ2UgYW5kIHBlcmhh
cHMgc29tZSBtb3JlLg0KDQpBaCEgVGhhbmtzIGZvciBub3RpbmcgdGhlc2UuIEl0J3MgaGVscGZ1
bCB0byBoYXZlIHRoZXNlIGNvbmNyZXRlDQpleGFtcGxlcyB0byBmaW5kIHdheXMgdG8gdGhpbmsg
YWJvdXQgdGhpcyBwcm9ibGVtLg0KDQpQaGlsb3NvcGhpY2FsbHksIEkgdGhpbmsgdGhlIHRpbWUg
d2UncmUgdHJ5aW5nIHRvIGFjY291bnQgZm9yIGlzIG1vc3QNCnNpbWlsYXIgdG8gc3RlYWwgdGlt
ZSBiZWNhdXNlIGl0IGFsbG93cyBhIFZNIHRvIGNvcnJlY3QgdGhlIGludGVybmFsDQphY2NvdW50
aW5nIGl0IHVzZXMgdG8gZW5mb3JjZSBwb2xpY3kuIEFmdGVyIGNvbnNpZGVyaW5nIGhvdyB0aGUg
ZGVsYXkNCndlJ3JlIHRyeWluZyB0byB0cmFjayBmaXRzIGFtb25nIHRoZXNlLCBJIHRoaW5rIG9u
ZSBxdWFsaXR5IHRoYXQgbWFrZXMNCml0IHNvbWV3aGF0IGRpZmZpY3VsdCB0byBmb3JtYWxpemUg
aXMgdGhhdCB3ZSBhcmUgdHJ5aW5nIHRvIGFjY291bnQgZm9yDQptdWx0aXBsZSBleHRlcm5hbCBz
b3VyY2VzIG9mIGRlbGF5LCBidXQgd2UgYWxzbyB3YW50IHRvIGV4Y2x1ZGUNCiJpbnRlcm5hbCIg
ZGVsYXkgKGNvbnRlbnRpb24sIHZvbHVudGFyeSBzbGVlcCkuIFRoZSBzcGVjaWZpY2l0eSBvZiB0
aGlzDQppcyBtYWtpbmcgYW4gaXRlcmF0aXZlIGFwcHJvYWNoIHNlZW0gbW9yZSBhcHBlYWxpbmcu
Li4NCg0KPiBUZWp1bidzIHN1Z2dlc3Rpb24gd2l0aCB0cmFja2luZyBjZ3JvdXAncyBmcm96ZW4g
dGltZSBvZiB3aG9sZSBjZ3JvdXANCj4gY291bGQgY29tcGxlbWVudCBvdGhlciAiZGVidWdnaW5n
IiBzdGF0cyBwcm92aWRlZCBieSBjZ3JvdXBzIGJ5IEkgdGVuZA0KPiB0byB0aGluayB0aGF0IGl0
J3Mgbm90IGdvb2QgKGFuZCBjZXJ0YWlubHkgbm90IGNvbXBsZXRlKSBzb2x1dGlvbiB0bw0KPiB5
b3VyIHByb2JsZW0uDQoNCkkgYWdyZWUgdGhhdCBpdCBkb2Vzbid0IG5lY2Vzc2FyaWx5IGZlZWwg
Y29tcGxldGUsIGJ1dCBhZnRlciBzcGVuZGluZw0KdGhpcyB0aW1lIG11bGxpbmcgb3ZlciB0aGUg
cHJvYmxlbSwgSSB0aGluayBpdCBzdGlsbCBmZWVscyB0b28gbmFycm93IHRvDQprbm93IHdoYXQg
YSBtb3JlIGdlbmVyYWwgc29sdXRpb24gc2hvdWxkIGxvb2sgbGlrZS4NCg0KU2luY2UgdGhlcmUg
aXNuJ3QgeWV0IGEgY2xlYXIgd2F5IHRvIGlkZW50aWZ5IGEgc2V0IG9mICJsb3N0IiB0aW1lIHRo
YXQNCmV2ZXJ5b25lIChvciBhdCBsZWFzdCBhIHdpZGVyIGdyb3VwIG9mIHVzZXJzKSBjYXJlcyBh
Ym91dCwgaXQgc2VlbXMgbGlrZQ0KaXRlcmF0aW5nIG92ZXIgY29tcG9uZW50cyBvZiBpbnRlcmVz
dCBpcyB0aGUgYmVzdCB3YXkgdG8gbWFrZSBwcm9ncmVzcw0KZm9yIG5vdy4gVGhhdCB3YXksIGF0
IGxlYXN0IGZvbGtzIGNhbiB0cmFjayBzb21lIGNvbWJpbmF0aW9uIG9mIHRoZQ0KdmFsdWVzIHRo
YXQgbWF0dGVyIHRvIHRoZW0uIChPbmUgYXNwZWN0IG9mIHRoaXMgSSBmaW5kIGludGVyZXN0aW5n
IGlzDQp0aW1lIHRoYXQgaXMgYWNjb3VudGVkIGZvciBpbiBtdWx0aXBsZSBtZXRyaWNzLiBNYXli
ZSBhIGJldHRlciB3YXkgdG8NCnRoaW5rIGFib3V0IHRoaXMgcHJvYmxlbSBjYW4gYmUgZm91bmQg
aW4gc29tZSByZWxhdGlvbiBiZXR3ZWVuIHRoZXNlDQpvdmVybGFwcy4pDQoNCkkgcmVhbGx5IGFw
cHJlY2lhdGUgdGhlIGVmZm9ydCB0aGF0IHlvdSd2ZSBwdXQgaW50byB0cnlpbmcgdG8gdW5kZXJz
dGFuZA0KdGhlIGxhcmdlciBwcm9ibGVtIGFuZCB0aGUgcXVlc3Rpb25zIHlvdSd2ZSBhc2tlZCB0
byBoZWxwIG1lIHRoaW5rIGFib3V0DQppdC4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciB0
aW1lIQ0KDQotLSANClRpZmZhbnkgWS4gWWFuZw0K

