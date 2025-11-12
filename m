Return-Path: <cgroups+bounces-11854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DF5C5101C
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 08:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24E71889E44
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 07:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAD2ECEA7;
	Wed, 12 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f2HB/A/h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0o/LkGf"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331B2D9ED1;
	Wed, 12 Nov 2025 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933775; cv=none; b=rZD0OdrdIhHcx8SnX0ukdeL7opDz/KyqhPevwZ4+zTBCOEppsGrnopNwQ0m9qzztkcZxu5wZp8MeVP2uQN6A85oJJibRr2u3ym8OgoE83OiPv9DAbonmJHskoxo2WN5tF9pNM0a57x/9LT/Suc3qMFLN+2z+l0WyaIKEjvuUyLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933775; c=relaxed/simple;
	bh=xbvMcM1IoFXOayGu/dX6p8mJi1v8/NnppEEb+PdNlEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzPhLPBwxxW47eFjd4oRBtG8OFS3KlseKuDOlp92OhtiwVN1XBVBGcNhaRK5fb7vEnAKhXTwnKD7lBlKAHZUpmQ+5yrwIHLrCOcg5S0mgBKC4XL5LsW1oP8Z1QnP63n/WHV4W/X77wyqXAEgcdGVpgNiMs3mHG3eG9wCJFsG41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f2HB/A/h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0o/LkGf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 08:49:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762933772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjmsQNbabVrHMjgajgEZibUL+efg9RjKcTRD2S+ysQ8=;
	b=f2HB/A/hb6zPD+MvHy/KC6OdmWpC1V68JL0jW4qNfv0jLBEggJ0szbe/6OorO2hbDxG684
	ArYQRJhVOGOBDvhNEI2ERthAEZnlBT2HjBfL/kf0+8KhcCPVsge0dLNgregR4MX6nJg5oo
	bpS9gAPhIWKi072xVwjJTvnB0IiQKxoKaQNhLFwvkVDMFFkJ7UIf+oDNa48WnLmlaNROEq
	5h/cgHgPc0QS7fhyI9Ff7mQduVeKdQ5HLfc6YYwGKQbSuZEok9BR/stoGLsi4VpqGFRO3c
	EeLwmycKHbL72hmLC4HFwiReBONSFKPSBT/oOafm0ECnUZHz10SG/AKDCb3VVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762933772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjmsQNbabVrHMjgajgEZibUL+efg9RjKcTRD2S+ysQ8=;
	b=l0o/LkGfxoyEmPkG6koDawTBPXTEvwbAYcuza/5SjiqDSmJto9UrhdHQKSLqA10+aCQusg
	Q2gtdV349a9ij4Dg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <qi.zheng@linux.dev>,
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
Message-ID: <20251112074930.mKu1J__U@linutronix.de>
References: <aQ3yLER4C4jY70BH@harry>
 <hfutmuh4g5jtmrgeemq2aqr2tvxz6mnqaxo5l5vddqnjasyagi@gcscu5khrjxm>
 <aRFKY5VGEujVOqBc@hyeyoo>
 <2a68bddf-e6e6-4960-b5bc-1a39d747ea9b@linux.dev>
 <aRF7eYlBKmG3hEFF@hyeyoo>
 <aqdvjyzfk6vpespzcszfkmx522iy7hvddefcjgusrysglpdykt@uqedtngotzmy>
 <8d6655f8-2756-45bb-85c1-223c3a5e656c@linux.dev>
 <aRKqm24Lrg-JnCoh@hyeyoo>
 <20251111084900.babaOj0w@linutronix.de>
 <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jzihvbb6w26d4codfigy2o7b2h26izb4ahihouw54cvuzau54d@jyaa6rgpzuai>

On 2025-11-11 08:44:14 [-0800], Shakeel Butt wrote:
> On Tue, Nov 11, 2025 at 09:49:00AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-11-11 12:16:43 [+0900], Harry Yoo wrote:
> > > > However, in the !CONFIG_HAVE_CMPXCHG_LOCAL case, mod_node_page_state()
> > > > still calls local_irq_save(). Is this feasible in the PREEMPT_RT kernel?
> > > 
> > > Hmm I was going to say it's necessary, but AFAICT we don't allocate
> > > or free memory in hardirq context on PREEMPT_RT (that's the policy)
> > > and so I'd say it's not necessary to disable IRQs.
> > > 
> > > Sounds like we still want to disable IRQs only on !PREEMPT_RT on
> > > such architectures?
> > > 
> > > Not sure how seriously do PREEMPT_RT folks care about architectures
> > > without HAVE_CMPXCHG_LOCAL. (riscv and loongarch have ARCH_SUPPORTS_RT
> > > but doesn't have HAVE_CMPXCHG_LOCAL).
> > 
> > We take things seriously and you shouldn't make assumption based on
> > implementation. Either the API can be used as such or not.
> > In case of mod_node_page_state(), the non-IRQ off version
> > (__mod_node_page_state()) has a preempt_disable_nested() to ensure
> > atomic update on PREEMPT_RT without disabling interrupts.
> > 
> 
> Harry is talking about mod_node_page_state() on
> !CONFIG_HAVE_CMPXCHG_LOCAL which is disabling irqs.
> 
> void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> 					long delta)
> {
> 	unsigned long flags;
> 
> 	local_irq_save(flags);
> 	__mod_node_page_state(pgdat, item, delta);
> 	local_irq_restore(flags);
> }
> 
> Is PREEMPT_RT fine with this?

Yes.
The local_irq_save() is not strictly needed but I am fine with it to
keep it simple. The inner part is just counting.

Sebastian

