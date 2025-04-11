Return-Path: <cgroups+bounces-7470-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B356A86007
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 16:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756AC4C4A54
	for <lists+cgroups@lfdr.de>; Fri, 11 Apr 2025 14:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717DE1F2C44;
	Fri, 11 Apr 2025 14:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sodjuVZE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ooqIR+rj"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDB31F0E32;
	Fri, 11 Apr 2025 14:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380412; cv=none; b=RfMPWuLbWaAVh2suifVFJePUl2YczNbc8UA5sMBtBXzi365WmR9aR0Daz+qveti3Q9wg8Der9UpZapzh7g8KrnvZsce25ZtM7HenDc41g8wNiOxuh/2WMajqmr+8W7xuJQM0Tcre7+Gj+6bgvGNnFSaclVRWFGn/WzQHqGPjdY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380412; c=relaxed/simple;
	bh=rfA39iMFpXc5utIfQSXYmBvbpKLhOcIQKjDLCxPMQOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+kPuFexnJ9wJjlLfJCeOi9Ak6Ke6kF3abbCyiICWG4+Ad2QT51bJ7A/y92TEe0ZcFcxdc9khLWrekWUX9tSa3sBdvxOVbAX5uI0eUp5xb8H3iY9XPbk2TFR5tvEJuiurH5rKjZut65ehkdMRQbDPiWmposxhaTXSv9awob1iTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sodjuVZE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ooqIR+rj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 16:06:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744380408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwi9+d3HlbhPOOmyW82UQg4QFJt5ooYE0JVjvtsqWYQ=;
	b=sodjuVZEk2BE+/LbFRgqAGvubEREMlDUveQbbP8h7hVdFlBvhMzKIVQJY6yWHAeBAkwE4j
	U3PxFzSnjbBpjKX3sl1bGlY1Do49g59+2QCvTrjfhT66iluGBXpexYhUYKT4ukEhlzuhyW
	VOeqMjIDV7BhxMdxPWnq95PXfCmpwd9DuIqN+11p9+G+5ops+TGggptz743KYnnd7V6zT9
	DjK1ei33bH/PGjDz6BN+EtztisTj200UtCo+wPOQ0hfDs+KvHjN6ig5ZjnWGQTkRLx60Ii
	OKftxjysiB38HISHgiSPpm0yiMslbiHwgM0uQboEnfaeAotzLay5yzpKk/15CA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744380408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xwi9+d3HlbhPOOmyW82UQg4QFJt5ooYE0JVjvtsqWYQ=;
	b=ooqIR+rjgJuQUTihpZa/QZO2IdKmQ2lay4zuAXcc9UF5PH/KX8OiOxq9XTS1rM5wiLVSwX
	oba0cgkqnVjQj3Bg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, Waiman Long <llong@redhat.com>,
	linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: decouple memcg_hotplug_cpu_dead from stock_lock
Message-ID: <20250411140646.05s0O5SY@linutronix.de>
References: <20250410210623.1016767-1-shakeel.butt@linux.dev>
 <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e9e2d5d-ec64-4ad4-a184-0c53832ff565@suse.cz>

On 2025-04-11 10:55:31 [+0200], Vlastimil Babka wrote:
> > @@ -1964,10 +1964,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
> >  
> >  	stock = &per_cpu(memcg_stock, cpu);
> >  
> > -	/* drain_obj_stock requires stock_lock */
> > -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > -	drain_obj_stock(stock);
> > -	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> > +	local_irq_save(flag);
> 
> I think for RT this is not great? At least in theory, probably it's not
> actually used together with cpu hotplug? As it relies on memcg_stats_lock()
> I think no irq save/enable is necessary there. local_lock_irqsave wasn't
> actually a irq disable on RT. I don't know if there's a handy wrapper for this.

No seeing the whole context but memcg_hotplug_cpu_dead() should be
invoked the control CPU while "cpu" is already gone. So the local_lock
should be acquired and the target CPU needs no locks since it is
offline. local_irq_save() will break things.

Sebastian

