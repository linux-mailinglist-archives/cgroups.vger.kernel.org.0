Return-Path: <cgroups+bounces-17405-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZxQMOGXdQ2qOkgoAu9opvQ
	(envelope-from <cgroups+bounces-17405-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 17:14:45 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C76E5D06
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 17:14:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=DdA85Oso;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17405-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17405-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70C99301277A
	for <lists+cgroups@lfdr.de>; Tue, 30 Jun 2026 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BA52F5A12;
	Tue, 30 Jun 2026 15:08:07 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680C82E7162
	for <cgroups@vger.kernel.org>; Tue, 30 Jun 2026 15:08:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832087; cv=none; b=RTOjlan3hqsDhEgMNYskIKXhvDbFOfClHWyq5jdO1H+wwax3ebx3liqpKCTmM4RRwq1zajdz7WjkW8z0W+6/w60rxe6cmjEwFyLPvvxE+T0CRsn8VgZe0lLt8YLgMoyufCxZ+YkTmtvXVTwJ8HdO/chkel7jpZO/YKpXuBActWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832087; c=relaxed/simple;
	bh=DTKadkgUJEsm8vau+Kht82J5nMgaemZk4nMq4zha+HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pc5ZQ8U5obZgguAkkSEMnZOYnZgjnaivM+OwfTivNnTlEcuz+T3ZDFqXMi9hb3kZ2KbaspEUI/H6BFt/5SYTtereoQ4lWyDK/YC9Zf3XU0bKtELP5/ETHjvUHyKDQnXTcVPrFexIeVczaEWzYriJ+1tduIOcGgYp2OGeR0PZOX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DdA85Oso; arc=none smtp.client-ip=95.215.58.180
Date: Tue, 30 Jun 2026 08:07:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782832082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gHtO69diIM0k7S0Wj5v0VMDMfaI21iwZjDPJcsxigLA=;
	b=DdA85OsoBrLMdEteQcGdKeX0AzDe/7nYRg6vYyk+ql7QNoPRZhPyh6W4lrwEt3aIUsY85A
	JE813+iwrtqbl676jixEw8tFQvESMIQJk7/QjLpMcGpXjiQKc/SGLfsaN5zJ4egZANbrfF
	VdBlPwM6d0VpkL2r/zLQAQQmH4qak78=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RESEND PATCH v2] mm/memcontrol: Avoid stuck
 FLUSHING_CACHED_CHARGE on isolated CPU
Message-ID: <akPbL3HZrvWy8O3Q@linux.dev>
References: <20260630070004.470181-1-hui.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630070004.470181-1-hui.zhu@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hui.zhu@linux.dev,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:bigeasy@linutronix.de,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:zhuhui@kylinos.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-17405-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,kylinos.cn:email,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB4C76E5D06

On Tue, Jun 30, 2026 at 03:00:04PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> drain_all_stock() sets FLUSHING_CACHED_CHARGE before calling
> schedule_drain_work() to queue per-CPU drain work.  When the target
> CPU is isolated (cpu_is_isolated() == true), the work is silently
> not queued, but FLUSHING_CACHED_CHARGE stays set.  Every subsequent
> drain_all_stock() then sees the bit and skips this stock entirely,
> so the entry is effectively pinned until something else on that CPU
> runs drain_local_*_stock() and clears the bit -- which on a long-
> isolated CPU may never happen.
> 
> The original idea was to actually perform the drain from the calling
> CPU on behalf of the isolated one, by adding a lock around the
> per-CPU stock so that a remote drainer could safely touch it.  In
> practice this turned out to be intrusive: the stock data structures
> and their fast paths (consume_stock(), refill_stock(), the obj_stock
> helpers) are deliberately designed around current-CPU-only access,
> and retrofitting cross-CPU serialisation onto them adds non-trivial
> locking and PREEMPT_RT concerns for very little gain.
> 
> Looking at the actual amount of charge that can accumulate in a
> single per-CPU stock, it is bounded and small, so leaving an
> isolated CPU's stock undrained for a while is not a real problem.
> The only real bug is that the stuck FLUSHING_CACHED_CHARGE bit
> prevents future drain_all_stock() callers from re-attempting once
> the CPU is no longer isolated.
> 
> Fix this minimally by clearing FLUSHING_CACHED_CHARGE when the work
> could not be queued because the target CPU is isolated.  The cached
> charge itself is left in place; it will be released the next time
> the CPU runs drain_local_*_stock() (e.g. after leaving isolation,
> or if the isolated CPU itself calls drain_all_stock() -- in that
> case cpu == curcpu causes drain_local_memcg_stock() to be invoked
> directly), and the next drain_all_stock() call is free to retry
> instead of skipping the stock forever.
> 
> Fixes: 6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated cpus")
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
> Changelog:
> v2:
> According to the comments of Waiman Long, updated fixes.
> 
>  mm/memcontrol.c | 28 ++++++++++++++++++++++------
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6dc4888a90f3..2e66b4a2c25d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2256,7 +2256,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>  	return flush;
>  }
>  
> -static void schedule_drain_work(int cpu, struct work_struct *work)
> +static void
> +schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
>  {
>  	/*
>  	 * Protect housekeeping cpumask read and work enqueue together
> @@ -2264,9 +2265,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>  	 * partition update only need to wait for an RCU GP and flush the
>  	 * pending work on newly isolated CPUs.
>  	 */
> -	guard(rcu)();
> -	if (!cpu_is_isolated(cpu))
> -		queue_work_on(cpu, memcg_wq, work);
> +	scoped_guard(rcu) {
> +		if (!cpu_is_isolated(cpu)) {
> +			queue_work_on(cpu, memcg_wq, work);
> +			return;
> +		}
> +	}
> +
> +	/*
> +	 * The target CPU is isolated: the drain work was not queued.
> +	 * Clear FLUSHING_CACHED_CHARGE so that future drain_all_stock()
> +	 * callers can re-attempt instead of skipping this stock forever.
> +	 * The cached charge is left in place; it will be released the
> +	 * next time the CPU itself runs drain_local_*_stock() (e.g.
> +	 * after leaving isolation), or by a follow-up mechanism.
> +	 */
> +	clear_bit(FLUSHING_CACHED_CHARGE, flags);

Let's do something like the following.

	guard(rcu)();
	if (cpu_is_isolated(cpu)) {
		clear_bit(FLUSHING_CACHED_CHARGE, flags);
		return;
	}
	queue_work_on(cpu, memcg_wq, work);

>  }
>  
>  /*
> @@ -2299,7 +2313,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_memcg_stock(&memcg_st->work);
>  			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> +				schedule_drain_work(cpu, &memcg_st->work,
> +						    &memcg_st->flags);
>  		}
>  
>  		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
> @@ -2309,7 +2324,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>  			if (cpu == curcpu)
>  				drain_local_obj_stock(&obj_st->work);
>  			else
> -				schedule_drain_work(cpu, &obj_st->work);
> +				schedule_drain_work(cpu, &obj_st->work,
> +						    &obj_st->flags);
>  		}
>  	}
>  	migrate_enable();
> -- 
> 2.43.0
> 

