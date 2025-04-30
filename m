Return-Path: <cgroups+bounces-7961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49EAA4FE4
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 17:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B689C3296
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 15:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AFC1C5D62;
	Wed, 30 Apr 2025 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y7niSezD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0y9yWDl"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1A2190676;
	Wed, 30 Apr 2025 15:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025913; cv=none; b=YnlleY3lFV7VjDzbwgwIcIDTvKp2UlJu0VApjvNNMsqKxv9oFfXlGxYC7fuT/rkG8KJZD7AfOObLfxJq0tdksRAzM+b59ZMmKtQmXe87s73kdwGahn7EtK1iTYZz5wCzRH1U8nS1QsmSuwTI57k6IzKTi7HCNsPmwXE5b3ptaQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025913; c=relaxed/simple;
	bh=gwNreDt2XmAk6fEeKAjvZndQq/2M8drfbIRxele9Qsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGZIGJvaFsrzvYg1ukcWXfzfLKbVc3oWpvHPxGG3Id1myxG98SoiuvNpp54yi+DVWHdGovxi1HqwaNPOX4Fc9Zbd1ExDPtPZFVyKnfVbOuVaKHNlimDLy2F954+yC5a9Fz7aH8NsrGHQ0qoktTRyUIHvtu/rK92LPi0rRsUOq1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y7niSezD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0y9yWDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 30 Apr 2025 17:11:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746025910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2c3K2d5Af1MygOHpxIZVc/MSwzvBfxMXWYEj6fNYrpY=;
	b=y7niSezDbu5dRuluihwjKJIoTeAwB2SEcHuOaSf6t6kTHInm3WEez8yl3FB+fcx+INymyg
	X8V/iCDTVJLLp2G8T56aHRMbA+9a2crgjGwYMWCA/lX/1TK4LlBr+8gzK0svgJ43tQyeIY
	1xbmj3lJD+ZtxcSdx61UxCOAvRioYdS2BNxBe5wwgMTOylqMl+a5XrpwTXZLJwjxU5jbqm
	ITqpI14w2hIioGFqTbuw48gy6S3Ye0RT2kGTWo2nNCIZHs4IyiGFnL7CfzJqJ9rY4bGa5B
	w4sXbNKSJQGOcPlOiZv3Rdni5jzEWrs0lWdHyhgZBIlezvZchoZrlxGuDBcqgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746025910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2c3K2d5Af1MygOHpxIZVc/MSwzvBfxMXWYEj6fNYrpY=;
	b=b0y9yWDlT5hm7iouGh2JxKI9KK4Ca+wXCLV8YKrB/X2zXUQhNg/r/VTv9e8Xg/OAjoWlGu
	73a0+O7fBDpAwvDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org
Subject: Re: [PATCH 1/4] memcg: simplify consume_stock
Message-ID: <20250430151148.-SqLG7kP@linutronix.de>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
 <20250429230428.1935619-2-shakeel.butt@linux.dev>
 <dvyyqubghf67b3qsuoreegqk4qnuuqfkk7plpfhhrck5yeeuic@xbn4c6c7yc42>
 <ik3yjjt6evxexkaculyiibgrgxtvimwx7rzalpbecb75gpmmck@pcsmy6kxzynb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ik3yjjt6evxexkaculyiibgrgxtvimwx7rzalpbecb75gpmmck@pcsmy6kxzynb>

On 2025-04-29 21:37:26 [-0700], Shakeel Butt wrote:
> > > -	if (gfpflags_allow_spinning(gfp_mask))
> > > -		local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > -	else if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags))
> > > +	if (nr_pages > MEMCG_CHARGE_BATCH ||
> > > +	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
> > 
> > I don't think it's a good idea.
> > spin_trylock() will fail often enough in PREEMPT_RT.
> > Even during normal boot I see preemption between tasks and they
> > contend on the same cpu for the same local_lock==spin_lock.
> > Making them take slow path is a significant behavior change
> > that needs to be carefully considered.
> 
> I didn't really think too much about PREEMPT_RT kernels as I assume
> performance is not top priority but I think I get your point. Let me

Not sure if this is performance nor simply failing to allocate memory.

> explain and correct me if I am wrong. On PREEMPT_RT kernel, the local
> lock is a spin lock which is actually a mutex but with priority
> inheritance. A task having the local lock can still get context switched
> (but will remain on same CPU run queue) and the newer task can try to
> acquire the memcg stock local lock. If we just do trylock, it will
> always go to the slow path but if we do local_lock() then it will sleeps
> and possibly gives its priority to the task owning the lock and possibly
> make that task to get the CPU. Later the task slept on memcg stock lock
> will wake up and go through fast path.

So far correct. On PREEMPT_RT a task with spinlock_t or local_lock_t can
get preempted while owning the lock. The local_lock_t is a per-CPU lock.

Sebastian

