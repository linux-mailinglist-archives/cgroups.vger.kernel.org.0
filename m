Return-Path: <cgroups+bounces-11802-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D999C4C3BB
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 09:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 393E44E55CF
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 08:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439829617D;
	Tue, 11 Nov 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vMvGc8hC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iUqoMMo0"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4BB9476;
	Tue, 11 Nov 2025 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762848124; cv=none; b=LF0lspnND+ViBvZfaXIX9AOqmuT8OrcCjlraF16lPlIydY56G5Hif3uB6uULp4RXX95uErONqwq9Z0J7EUEj5yyuR+XcnChCQG3mif609j8SQet9/omCBpFcyhbhptSHinn36kJq7en7PFhthWrr6LtN/nwDTaGKs1YnT4OIebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762848124; c=relaxed/simple;
	bh=4tiOI0qI5k+vWSZUXOPHz8VzDwicg9ES+8RHVjqXnMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOHvgEhGbDhSCqf7oo5nbMJRf5rj9UbzSse7WHavFaTaqNIMqAdvZAV9JSyrg6a0zZTblXydndSYY80hwXidOXqfqqt8PpcqwziwNJ/VCtBujRWaSKM4jDrT3XpzMZSYnwOdVpCR6BRsvJ1LQHdylMQZvGo/1gctSpZLIaVew50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vMvGc8hC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iUqoMMo0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 09:01:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762848115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx+P3tmh8RRhlJbEuybtXJQuyEPuClVVZRpIZ0Mh1q8=;
	b=vMvGc8hCbnyKYogzWdAmHFKDT2esfKhiN/1WVwqSpRwIuyM0XqM+Hw24fN35m+ziuw1ZwN
	H4+vaj9gT0so58eZaRH8Fghkk14qaV5iKGl816Bvl95Y1+05Nmsa5A22vn6+QLq44OC/av
	mggOpIH2/avhHyT1+xzbnR58gA1b7XoWgsbtocODVQTNhB+0wYf9VyTPM8A41GgLZ5t4bq
	Y7Cd9e8JFK5AD4aMSrGP8yz6Xp7DpeDz7i8KQdHg5RNahP/caaiOW4aB7ElRolz1Ir2Sxe
	+puGZu1XqOOmIOzkpppJzZfHGNC2QM7Jac5cHnosNtxaDwcgYRsK2SVgt4aaIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762848115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dx+P3tmh8RRhlJbEuybtXJQuyEPuClVVZRpIZ0Mh1q8=;
	b=iUqoMMo0MCvnlPoaGp1XbX6sIHxU35Loi+T+vRoqwekh2f53jfWu9cCkH5+W+iunP1eY2N
	T/1+j18ur9A+p5Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <20251111080153.eo8vtb4P@linutronix.de>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
 <aRKn4kqHx9m9lWfu@hyeyoo>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRKn4kqHx9m9lWfu@hyeyoo>

> > I mean converting these places to use spin_lock() instead of
> > spin_lock_irq().
> 
> Just one thing I noticed while looking at __folio_migrate_mapping()...
> 
> - xas_lock_irq() -> xas_unlock() -> local_irq_enable()
> - swap_cluster_get_and_lock_irq() -> swap_cluster_unlock() -> local_irq_enable()
> 
> is wrong because spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.
> 
> Not 100% sure if it would be benign or lead to actual bugs that need
> to be fixed in -stable kernels.
> 
> Cc'ing RT folks again :)

The tail in __folio_migrate_mapping() after xas_unlock()/
swap_cluster_unlock(), is limited to __mod_lruvec_state() based stats
updates. There is a preempt_disable_nested() in __mod_zone_page_state()
to ensure that the update happens on the same CPU and is not preempted.
On PREEMPT_RT there should be no in-IRQ updates of these counters.
The IRQ enable at the end does nothing. There might be CPU migration
between the individual stats updates.
If it remains like this, it is fine. Please don't advertise ;)

Sebastian

