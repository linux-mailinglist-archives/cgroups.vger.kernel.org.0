Return-Path: <cgroups+bounces-7081-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BAA6169E
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 17:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE781165452
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 16:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DBD20459C;
	Fri, 14 Mar 2025 16:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bgEqsRfc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FI3StjOY"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF049204C1F;
	Fri, 14 Mar 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970559; cv=none; b=p3jH9r2vGEWXJiHt1D+1z3Vi/vhIS6aLi7iLLYt3sj4jUcLsXEuYjb4gc1nzfvaz9N7B+HEC5PRAJ8Gha86kggxr8ioj9owDFcljqejcmboENZ9H6lTRAqq/1njeiNmJt5njQBW3pMEVkCjOCTJrfpvx/h900NrQrulS24FMQu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970559; c=relaxed/simple;
	bh=WKvPBqAheABYVXZCOMX/grkc+3SAOOYUHz4YuZsE/P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQGdC05sHghFCHdtS+MHy3DZlh7POOrXwZtyOovxrTlRw+7Ie95RU9eOhXdydiUtyL+6sM0nwrsPjh7CLnn/MVXwDbnOXP6kH1AAAXsKdC5hr9j0Qn1r3/YrzDghAwfmDby9Ue94nXYst7Lfi99SzWKR8iF9dqhTBMgWUAnqjzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bgEqsRfc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FI3StjOY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 17:42:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741970555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYlPwasXBzLfgEyJddys083H0WNthfCNPSsv0doG2Do=;
	b=bgEqsRfcBMtkfP0wbQPmmiEkCbQ15g6h3mpeVQZARg9564I5uBy+tB0VayJFeisXX8zXJ2
	5oKgNf1KdiJ6SkINlyCr/B6rMgQ4G725dxP/3XSCMELmDqQzoawdKi+cZYX69Qht0u2MqA
	9Y3IffYa6JVtsoeLFNPeS8wawEQf9ud0gRiWNRrIyaAQGNqflPsK1n3jGTaqgsfm4FiJKB
	BA3chkPe4/tVm7PrRz64hrbBZUJv7oVY43n++0ClkZvU+1RHrYvcXmK5OGlF5iCSF0CwSJ
	vKk3FnlTi4Xf+Y6a69wx5vu+ltNu+Yf46ml6reBFmGuXNg1+ZaoKxdPtMUPBmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741970555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tYlPwasXBzLfgEyJddys083H0WNthfCNPSsv0doG2Do=;
	b=FI3StjOYvtarRJPlbmUMnre0628h2cAhLZLpGcHRlRhbhgv2nEoyZgHFkTULCzvMbfKW7a
	/zo6VemKynZh9GAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Message-ID: <20250314164234.KHdt_CWt@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-11-shakeel.butt@linux.dev>
 <9e1e3877-55ae-4546-a5c1-08ea730ea638@suse.cz>
 <20250314115802.DESa-C1z@linutronix.de>
 <2c62mvfo4726x3ci3sze7u55encoycbbzbaatzslkbhur2dkvd@wlli7wrcjlik>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c62mvfo4726x3ci3sze7u55encoycbbzbaatzslkbhur2dkvd@wlli7wrcjlik>

On 2025-03-14 08:55:51 [-0700], Shakeel Butt wrote:
> On Fri, Mar 14, 2025 at 12:58:02PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2025-03-14 11:54:34 [+0100], Vlastimil Babka wrote:
> > > On 3/14/25 07:15, Shakeel Butt wrote:
> > > > Let's switch all memcg_stock locks acquire and release places to not
> > > > disable and enable irqs. There are two still functions (i.e.
> > > > mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
> > > > update the stats on non-RT kernels. For now add a simple wrapper for
> > > > that functionality.
> > > 
> > > BTW, which part of __mod_objcg_mlstate() really needs disabled irqs and not
> > > just preemption? I see it does rcu_read_lock() anyway, which disables
> > > preemption. Then in __mod_memcg_lruvec_state() we do some __this_cpu_add()
> > > updates. I think these also are fine with just disabled preemption as they
> > > are atomic vs irqs (but don't need LOCK prefix to be atomic vs other cpus
> > > updates).
> > 
> > __this_cpu_add() is not safe if also used in interrupt context. Some
> > architectures (not x86) implemented as read, add, write.
> > this_cpu_add()() does the same but disables interrupts during the
> > operation.
> > So __this_cpu_add() should not be used if interrupts are not disabled
> > and a modification can happen from interrupt context.
> 
> So, if I use this_cpu_add() instead of __this_cpu_add() in
> __mod_memcg_state(), __mod_memcg_lruvec_state(), __count_memcg_events()
> then I can call these functions without disabling interrupts. Also
> this_cpu_add() does not disable interrupts for x86 and arm64, correct?
> For x86 and arm64, can I assume that the cost of this_cpu_add() is the
> same as __this_cpu_add()?

on arm64, __this_cpu_add will "load, add, store". preemptible.
this_cpu_add() will "disable preemption, atomic-load, add, atomic-store or
start over with atomic-load. if succeeded enable preemption and move an"

so no, this is not the same. On x86 it is possible to increment a memory
value directly with one opcode so you get preempted either before or
after that operation.

Sebastian

