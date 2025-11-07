Return-Path: <cgroups+bounces-11663-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB408C3EB9C
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9BF84E7857
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393EB238149;
	Fri,  7 Nov 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0foV2wBI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4HhAeH/I"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81704AD2C;
	Fri,  7 Nov 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762499918; cv=none; b=flmMkGljzRddDy2n2zfAfxhBrpcIT1921s73e1sKUwVClaKpEwJaDIXW8NFUwtNdbx883bh+gYOJPQsLG/gytEORlxh5rSjA23BzYAXNvhBOpFpqy/OuMQmaTZN3aP7ZaX+bvGr7ZgmxeHzmbmD/u2HX3Iqoi4Ygyw4Pg0m5W/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762499918; c=relaxed/simple;
	bh=weU+v0sRv+5l3qc9AmslFpwy78JmXv/w7Q+ES0doiPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do12cI63XW8wssuK77eorEffumjIeGk28MsugjsdjZKPiDWN3nAGKTzJf6HbaroLEj7AJ3Z9M4sPTieZZmsafG1f1ciDMZ1Bun29CgU5Hsmi9Z9aTe6cgjDQXfiZnd3gRUkO3KaIpV/zApPic3e8b7n1IHDKVLXo8Udgus9HUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0foV2wBI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4HhAeH/I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Nov 2025 08:18:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762499914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heYXyy7Nh4RID45V94BklvzF7jWiD7JOdC5Cl12Mf4s=;
	b=0foV2wBII5D5grA3Ma4Lt5FTDQyn8Ne53juxY4gS7aVgvVSZXUbiBlhKs90ZgrmRJ7M7Qg
	Z6G+38Hngk5eVpswngQf3nX1dzxhEFwEZxeVH8uRERcPiYFwsrXOqU2ZmaaWQgF0UkvpeF
	3plGMA4JWo5AWbvwSWW1L2F207ZETIJbh1z8DMdmcj1IOXNMWegkXDvnhsU6/H5gI29d2/
	HswQZ64w1tAajFso/zFtJOy6cV7bVF2jbBPoGMUUHE7m57a/DfEp+IUR4TsA37m8H+ultr
	DBIEAx7lSeJGWpH/hDOd8ONJs54WzX3OY25xpxC5vo2Nw7qihWXBwpthO02YNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762499914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heYXyy7Nh4RID45V94BklvzF7jWiD7JOdC5Cl12Mf4s=;
	b=4HhAeH/IM7xqCjhvO9k/AiYYQLJbrdErspxJFo0S3UZwapJog43P00CbuK4lrm4CnbPUYd
	1j0RSvVxRq8llyAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
	mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
	ziy@nvidia.com, imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v1 04/26] mm: vmscan: refactor move_folios_to_lru()
Message-ID: <20251107071832.Ty2LfTyY@linutronix.de>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <97ea4728568459f501ddcab6c378c29064630bb9.1761658310.git.zhengqi.arch@bytedance.com>
 <aQ1_f_6KPRZknUGS@harry>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aQ1_f_6KPRZknUGS@harry>

On 2025-11-07 14:11:27 [+0900], Harry Yoo wrote:
> > @@ -4735,14 +4734,15 @@ static int evict_folios(unsigned long nr_to_scan, struct lruvec *lruvec,
> >  			set_mask_bits(&folio->flags.f, LRU_REFS_FLAGS, BIT(PG_active));
> >  	}
> >  
> > -	spin_lock_irq(&lruvec->lru_lock);
> > -
> > -	move_folios_to_lru(lruvec, &list);
> > +	move_folios_to_lru(&list);
> >  
> > +	local_irq_disable();
> >  	walk = current->reclaim_state->mm_walk;
> >  	if (walk && walk->batched) {
> >  		walk->lruvec = lruvec;
> > +		spin_lock(&lruvec->lru_lock);
> >  		reset_batch_size(walk);
> > +		spin_unlock(&lruvec->lru_lock);
> >  	}
> 
> Cc'ing RT folks as they may not want to disable IRQ on PREEMPT_RT.

Thank you, this is not going to work. The local_irq_disable() shouldn't
be used.

> IIRC there has been some effort in MM to reduce the scope of
> IRQ-disabled section in MM when PREEMPT_RT config was added to the
> mainline. spin_lock_irq() doesn't disable IRQ on PREEMPT_RT.
Exactly.

Sebastian

