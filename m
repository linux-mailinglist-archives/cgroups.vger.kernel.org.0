Return-Path: <cgroups+bounces-15557-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACm/Iftw8mljrQEAu9opvQ
	(envelope-from <cgroups+bounces-15557-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 22:58:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C678349A4AB
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 22:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71EB43010937
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B42F38F227;
	Wed, 29 Apr 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxIzY7fT"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5B3AA502
	for <cgroups@vger.kernel.org>; Wed, 29 Apr 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496308; cv=none; b=IP+ts7r/lrEaXaouPaDDdiwQRBQcHRwKPmlLNPepBSV6sgFZQOCD2VrItXpjWQLiHFdw6iZZJuoooqZeQ4zR4ZtUYTCi0gNGUSs0alGwvODYFp7P50qtKDL38/ViekAgdCuPUm4RM1J5z1ES6w9gBidOVUfJXBTv2oOD2kE2jSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496308; c=relaxed/simple;
	bh=H4PfGyMnPiSQn1my4AwccDfLneDKKhcFDfiOgWxT+qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLpt0cEfnggGAyJGIGV3IQYzrcRJaa61cBh89u3loeXGkiSX1ipxwuizIR0/OcVulOOWIyi3J/3Pn0R7kAcGNoIWLB84PynZa9xFRmLSl+PQ9AXJQZbxNqOQTm7mtbl3OoKr/dtim26dJh710Jy7wK5cCatVqg9HSxNz1VomJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxIzY7fT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777496305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1NyF1QURy3vdICAxiB0jl9JGp6DuWbQaRj+rdabH/M=;
	b=VxIzY7fTq52dDKodSeIaa5hIDSt2feYo11HHRk7tsz1O1Y1+HfrM4wFq8zzgKPPcSZbYMu
	ht/10rbobjNImpvgvGJoXya0zle5vjhdA/eEHrcYrd3vf5s4/XZNGRBbDB2hOAbsxv/yLN
	p7o2iMgYnNinqyMNBFEWeGSpBtMW2/I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-rBBwcJqwPxeaG3FBplukoA-1; Wed,
 29 Apr 2026 16:58:18 -0400
X-MC-Unique: rBBwcJqwPxeaG3FBplukoA-1
X-Mimecast-MFC-AGG-ID: rBBwcJqwPxeaG3FBplukoA_1777496295
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D94C118002C0;
	Wed, 29 Apr 2026 20:58:13 +0000 (UTC)
Received: from [10.22.65.94] (unknown [10.22.65.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B3F75300019F;
	Wed, 29 Apr 2026 20:58:10 +0000 (UTC)
Message-ID: <68ba05da-7052-406a-9ddd-b324a349ca80@redhat.com>
Date: Wed, 29 Apr 2026 16:58:09 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memcontrol: Avoid stuck FLUSHING_CACHED_CHARGE on
 isolated CPU
To: Hui Zhu <hui.zhu@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Hui Zhu <zhuhui@kylinos.cn>
References: <20260429022723.133833-1-hui.zhu@linux.dev>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20260429022723.133833-1-hui.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: C678349A4AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-15557-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/28/26 10:27 PM, Hui Zhu wrote:
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
> Fixes: 2d05068610a3 ("memcg: Prepare to protect against concurrent isolated cpuset change")

I don't think this is the right commit to blame as it didn't really 
change the logic other than adding RCU locking. I think commit 
6a792697a53a ("memcg: do not drain charge pcp caches on remote isolated 
cpus") is the right one as this is the commit that adds the 
cpu_is_isolated() check first.

Other than that, the patch looks good to me as the list of isolated CPUs 
is runtime changeable.

Cheers,
Longman

> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> ---
>   mm/memcontrol.c | 28 ++++++++++++++++++++++------
>   1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c3d98ab41f1f..cee77b0a95f5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2219,7 +2219,8 @@ static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
>   	return flush;
>   }
>   
> -static void schedule_drain_work(int cpu, struct work_struct *work)
> +static void
> +schedule_drain_work(int cpu, struct work_struct *work, unsigned long *flags)
>   {
>   	/*
>   	 * Protect housekeeping cpumask read and work enqueue together
> @@ -2227,9 +2228,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
>   	 * partition update only need to wait for an RCU GP and flush the
>   	 * pending work on newly isolated CPUs.
>   	 */
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
>   }
>   
>   /*
> @@ -2262,7 +2276,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>   			if (cpu == curcpu)
>   				drain_local_memcg_stock(&memcg_st->work);
>   			else
> -				schedule_drain_work(cpu, &memcg_st->work);
> +				schedule_drain_work(cpu, &memcg_st->work,
> +						    &memcg_st->flags);
>   		}
>   
>   		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
> @@ -2272,7 +2287,8 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
>   			if (cpu == curcpu)
>   				drain_local_obj_stock(&obj_st->work);
>   			else
> -				schedule_drain_work(cpu, &obj_st->work);
> +				schedule_drain_work(cpu, &obj_st->work,
> +						    &obj_st->flags);
>   		}
>   	}
>   	migrate_enable();


