Return-Path: <cgroups+bounces-5009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84598D05E
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E85DB1F22370
	for <lists+cgroups@lfdr.de>; Wed,  2 Oct 2024 09:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF81C1E1313;
	Wed,  2 Oct 2024 09:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfstEY9P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E1m6jm20"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6A119882C;
	Wed,  2 Oct 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727862265; cv=none; b=CwrLDiwgGuwA4nf4tM/D/ZeUxBIV4FLwMMEteVUqm4Y9kUrieUAZFVWoVBgNqJmC/D8GRQKYSY7a8yNs0dPUczknvRAqdrU/ttWlei3I0k8LQ/XSp/AnLMNmDD6vAxKSl1QjGO/DIl111HEB26p16yQgM3VsuTkGJ+j7rFuzrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727862265; c=relaxed/simple;
	bh=ckNRaqkBk8GiNP4s8N8LMRXmLRo/q8Kb7OZ0CWGxGxc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bb5mgKP3KUYXpUaVFUzarc7txKXbaEUacIpgTBD4iymjW53auZ3uuyHr3ivZ7VmVRKg2BnjkaWxf0vaxo2poEf5LREeMnLlxJNNDIpJZ5fHZdJ0HOGqvCDMvQ3+R7uDPWCrUSx2PsmOxujfV4NvniatcGGh1saXwvgRVoKaHG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfstEY9P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E1m6jm20; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727862262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbNeEOBRlBQ4W4QTFBiGzbZCYE8gT06BwQpa9ZprJWg=;
	b=WfstEY9PzoFots3K8sjQFzkfjgmJ36EbTbOY3KCsRX+I7jfyn9lhennyOmf6CaW/WnN/Mp
	ypz0utH0oCVCkl9xAoZzh+i1EZKgqkmrbtjFGWGCWCRK4ifaPzxdy9+Wro3hPywAyS1EdN
	kalyXkjMAiE3CTYq6CNxpYsAD+/dyZP9KZ/zSjlDOEiaOLZKlbHpyKHe4pgafIIvGOsJJA
	hVRvlXFWudfM6XMYkAIJKLdedfA7S9QR1EypbppSzpJGrNafiOrpsDAL5OX5BfAa3ex6Tt
	ijt+DkUulNHeEzOWa9Q17JYhb1dUKrrcrQn6wy8PPfaOCOvmiYUgM77Viv+rng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727862262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbNeEOBRlBQ4W4QTFBiGzbZCYE8gT06BwQpa9ZprJWg=;
	b=E1m6jm20jqxHfOCJ/Xt2T2iLoTRcMbXtWawTfdP8xBkMd/MowmPhKLCziAKxbsFzBr/BDr
	lgV66gndQLwT+vDw==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 ming.lei@redhat.com, pauld@redhat.com, juri.lelli@redhat.com,
 vschneid@redhat.com, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Costa Shulyupin <costa.shul@redhat.com>, Bjorn
 Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/3] sched/isolation: Add infrastructure for
 dynamic CPU isolation
In-Reply-To: <20240916122044.3056787-2-costa.shul@redhat.com>
References: <20240916122044.3056787-1-costa.shul@redhat.com>
 <20240916122044.3056787-2-costa.shul@redhat.com>
Date: Wed, 02 Oct 2024 11:44:22 +0200
Message-ID: <87jzeqyh3d.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 16 2024 at 15:20, Costa Shulyupin wrote:
> +/*
> + * housekeeping_update - change housekeeping.cpumasks[type] and propagate the
> + * change.
> + */
> +static int housekeeping_update(enum hk_type type, const struct cpumask *update)
> +{
> +	struct {
> +		struct cpumask changed;
> +		struct cpumask enable;
> +		struct cpumask disable;
> +	} *masks;
> +
> +	masks = kmalloc(sizeof(*masks), GFP_KERNEL);
> +	if (!masks)
> +		return -ENOMEM;
> +
> +	lockdep_assert_cpus_held();
> +	cpumask_xor(&masks->changed, housekeeping_cpumask(type), update);
> +	cpumask_and(&masks->enable, &masks->changed, update);
> +	cpumask_andnot(&masks->disable, &masks->changed, update);
> +	cpumask_copy(housekeeping.cpumasks[type], update);
> +	WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));

So this sets the bit for the type

> +	if (!static_branch_unlikely(&housekeeping_overridden))
> +		static_key_enable_cpuslocked(&housekeeping_overridden.key);

What's the point of doing this on every iteration?

> +	kfree(masks);
> +
> +	return 0;
> +}
> +
>  static int __init housekeeping_setup(char *str, unsigned long flags)
>  {
>  	cpumask_var_t non_housekeeping_mask, housekeeping_staging;
> @@ -327,8 +357,11 @@ int housekeeping_exlude_isolcpus(const struct cpumask *isolcpus, unsigned long f
>  		/*
>  		 * Reset housekeeping to bootup default
>  		 */
> +
> +		for_each_clear_bit(type, &boot_hk_flags, HK_TYPE_MAX)
> +			housekeeping_update(type, cpu_possible_mask);

Even for those which are clear

>  		for_each_set_bit(type, &boot_hk_flags, HK_TYPE_MAX)
> -			cpumask_copy(housekeeping.cpumasks[type], boot_hk_cpumask);
> +			housekeeping_update(type, boot_hk_cpumask);
>  
>  		WRITE_ONCE(housekeeping.flags, boot_hk_flags);

Just to overwrite them with boot_hk_flags afterwards. That does not make
any sense at all.

Thanks,

        tglx

