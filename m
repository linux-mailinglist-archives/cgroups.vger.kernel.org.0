Return-Path: <cgroups+bounces-11806-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA289C4C74B
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 09:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8719518853F4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC0B757EA;
	Tue, 11 Nov 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cCjfxdSd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HIm7hPIl"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C32335950;
	Tue, 11 Nov 2025 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850946; cv=none; b=Jz0JZ8YQsxgQ4Ar44Ip2uy+IKA4Szor6706TBRDfHITdS0V5aAWynS0gB3DIZ7QkiMhFhjrwPHIX8fBY3ruQCv/NFxABpwPcYRgQkrFfShByg/0g1n6Y/xXIQhSe8/rqWRMcStG7doXg2vdw9jt88VEWOHr25xLEHvziepo1HVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850946; c=relaxed/simple;
	bh=5kYM5+1Jza/SwfDmK/uU9CnWofuzjoM5cr1YVI6ReTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlf63O9hXlsAZn4kRbgttjSKi+/lm7pVp3l9HgvjWWe9wirurK89EYpVqPkrcVkaXKYrxrrBp1unHN5/ReuymMxXlD+KBOEuqJM+j3NIC+yLnhzdPqowqyClmyJ29EMOC42KJ69D95e4TK4+siQylTmGzbuzSaZckU5cREbz1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cCjfxdSd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HIm7hPIl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 09:49:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762850942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lug3ME6CtD6QvK/qR5uG3WWqf/M2ZdQU/OQnEwpHbAk=;
	b=cCjfxdSdzShFAEa6SvGIzVs3lbcTA4pHEJ25qlpTUWLXnZtXrgeu1F9Lp05bUpaFskLvhr
	lIi3lbU8+TKDKtBzNN4i+MfzDlppoHqpK1TeDkHtTXQqeP7TQBatHoVCUyibXb1/0bYevy
	g1CBZoS2lGowkWa6daKovKfR5/XAEGsZpBb3GZaXTWb378xRVGe3AXhzwBh9atkqs+jUnI
	CRNtILc65XaP0p7cWpTJXbgRCHGrro9ob4Lf627HvhLEVwuZhUhzj2Udx6psxpTJE1txF3
	8eAdbFZyz1anOH4fXTM6iqEDaNJwaL7rrByrXovTa5H12vGtwCxQj/G91CpRwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762850942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lug3ME6CtD6QvK/qR5uG3WWqf/M2ZdQU/OQnEwpHbAk=;
	b=HIm7hPIlEuOw5BRjNF1vnYS3Kg1k6TeP51kIcZF3a318jajF+lq7IYXJkODd9SC+gCIdt7
	Zcpr2GVKPiesiqAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <20251111084900.babaOj0w@linutronix.de>
References: <aQ1_f_6KPRZknUGS@harry>
 <366385a3-ed0e-440b-a08b-9cf14165ee8f@linux.dev>
 <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <aRKqm24Lrg-JnCoh@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRKqm24Lrg-JnCoh@hyeyoo>

On 2025-11-11 12:16:43 [+0900], Harry Yoo wrote:
> > However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
> > still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> 
> Hmm I was going to say it's necessary, but AFAICT we don't allocate
> or free memory in hardirq context on PREEMPT_RT (that's the policy)
> and so I'd say it's not necessary to disable IRQs.
> 
> Sounds like we still want to disable IRQs only on !PREEMPT_RT on
> such architectures?
> 
> Not sure how seriously do PREEMPT_RT folks care about architectures
> without HAVE_CMPXCHG_LOCAL. (riscv and loongarch have ARCH_SUPPORTS_RT
> but doesn't have HAVE_CMPXCHG_LOCAL).

We take things seriously and you shouldn't make assumption based on
implementation. Either the API can be used as such or not.
In case of mod_node_page_state(), the non-IRQ off version
(__mod_node_page_state()) has a preempt_disable_nested() to ensure
atomic update on PREEMPT_RT without disabling interrupts.

Sebastian

