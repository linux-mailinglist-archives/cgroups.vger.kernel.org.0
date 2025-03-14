Return-Path: <cgroups+bounces-7072-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CBAA61041
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 12:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B454171F41
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 11:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3CD01FDE15;
	Fri, 14 Mar 2025 11:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r43ox+5y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+GRAJ06p"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A3B1FDE00;
	Fri, 14 Mar 2025 11:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952650; cv=none; b=eVdeaK8wyC+j3Db2Z2zkOiv/u34clTKqCM5jXq2fzAvJnj+mha/ckQPIYpV9rhtUlFQ6c38tCJWMi8avxG3aeu9UQuaTJ2EbnsegYHZD6Wxbg/3GGXPjPshYFNmlKKjoOz124XAUwRqVvZPXoXEFVrJgBY2E4/9aZH8+pHD7NWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952650; c=relaxed/simple;
	bh=WMXbgEmWPTPcZc2ne24plB+Q65lf9UBI1rkU47oyPZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9GreKlkSKod5Q5Vd4EMchv/+JRSv2hQ/ZtztbrDpxdUxVXXAXb/Obrflw4NBF/xPV4nxHWG9iA14p2uTjKUUvgC20HHG3Q1J4JzGxZ0Nv6u/Lv6E5X14hvM1qAU4n/al78JbkvgEU1Mhv7k3OvibQ0InM4XBt+z4BlEA4Te09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r43ox+5y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+GRAJ06p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 12:44:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741952647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3SFScDyttEY9US8ubeRIrvuSvpvEfTK2KFVStD/P3k=;
	b=r43ox+5yxWxW0pcpayTd7dSW8e3o5/EoCe1cI+2FFKxf2EqW5JQUdaS2pVVxSRuzK4ZhcV
	K+cL2ltSWsgKHeJ9P6KVEGFnN+Uwrjs/ykxbL3ahjhoKddsJlZSeELQByMK2zIlGEE0M7a
	0LPDcqVp94/opumCJL+RySyWgpvK2zoNXRyEm3+jizdyp/XvmWLhzPKASoN1QDKQ8SUmPL
	Qv9kTeqvYyGVX0qkSgzYy1J4PgpAjqafZPyysWYVvLB5xv8YjKedU+tp3lDNI/GO5oqczL
	C+CrMJhdtyckSczRJhmbSzTB0V0+q0VAqdMljJyKID7A25Xi3caf9zyAq7U32g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741952647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m3SFScDyttEY9US8ubeRIrvuSvpvEfTK2KFVStD/P3k=;
	b=+GRAJ06pNMGb19/QXxJwxJTeaTS8JcSgCno6lJCaFovNgikauelmaFZoVxGaZ1VhO7dawM
	iM3nbJTtA8vrQ/AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH 07/10] memcg: use __mod_memcg_state in drain_obj_stock
Message-ID: <20250314114405.4x6EuYYW@linutronix.de>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
 <20250314061511.1308152-8-shakeel.butt@linux.dev>
 <c88739b4-1fe3-47dc-8ed6-22adf0aadcb4@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c88739b4-1fe3-47dc-8ed6-22adf0aadcb4@suse.cz>

On 2025-03-14 11:27:40 [+0100], Vlastimil Babka wrote:
> On 3/14/25 07:15, Shakeel Butt wrote:
> > For non-PREEMPT_RT kernels, drain_obj_stock() is always called with irq
> > disabled, so we can use __mod_memcg_state() instead of
> > mod_memcg_state(). For PREEMPT_RT, we need to add memcg_stats_[un]lock
> > in __mod_memcg_state().
> > 
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> 
> Maybe it'll make sense later but as of this patch itself it begs a question
> why put memcg_stats_lock()/unlock() in __mod_memcg_state itself and not just
> around the call in drain_obj_stock()?

The memcg_stats_lock() were introduce to protect the per-CPU counters
(vmstats_percpu) on PREEMPT_RT which are protected on !PREEMPT_RT by
disabling interrupts. Other modifier have this already except for
__mod_memcg_state() because mod_memcg_state() was the only user and
already disables interrupt for the operation.

Sebastian

