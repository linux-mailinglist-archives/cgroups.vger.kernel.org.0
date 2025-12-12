Return-Path: <cgroups+bounces-12342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF84FCB7AA4
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 03:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4D5301BE9E
	for <lists+cgroups@lfdr.de>; Fri, 12 Dec 2025 02:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CF26F2BC;
	Fri, 12 Dec 2025 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z7woSZo9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R3SPY+/u"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA93126BF1;
	Fri, 12 Dec 2025 02:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765506405; cv=none; b=qNdiYNlxfLlKSxDt/NcXpDwW/5iJ1vw0r1eF6ooYsbJAYKeKotPAQ4bDx+6pXCQef1b2ftTn5UIeEzjwP2gLeUZ+8jrBWE9jjuR800/zPmWNv98g9vT1YV/adwIVJ0ttbjSPSTN0zmB51Uu1a6GckPAmY1STgjoSw/n1f6/HNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765506405; c=relaxed/simple;
	bh=ugNSR+pTuCtNZr0xECgz70LwVVcgMsezNPyr5oUY2ZQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CpM+WrjttdPxtSpChXQaBhDkv737CQ6tqJg3/Pg0TcnFDICPCha9AZ7O+9GGZBFyBTPatKVLYMGf+vwjKHhgqshXs8dBWPoIxO/oKEUUYkTQXpJZlYryIH/fCpzWLhDsYVxo0YrR0VgSICSnYVg6u2BdtJBAONjZIN4C3Kl7rz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z7woSZo9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R3SPY+/u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765506401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MqnmiQEbneDIt6dVEUpH70HG0wKZ3F18+mTaCW27Co=;
	b=Z7woSZo9PQjzUmk8BnX1GDfLbLLN38c8Nc3RCDWi5Xcnd/YTbegoLT/ORr1FthGCp5KrNs
	EOXYBY4CWVk3DxRD8lPl4yA7WAUgwFyFg6tkHesp7kmHdiMXMR4h7UgtE8E8SF7zjOTnBc
	XCztrZp4HvzQgNpuhbwHeds3CU2fztnZqc1UDDDBKX/uRfeT9ibLzlCvED07MKVspwGOYz
	FxG+k3a/OSnwoDuWw+BscCm1aufWe1xMbO7hG9qNxgTW5mAOeSYu9MzCnNdsol8tpOUcdI
	CqTJV26R8dFJ16x68Pd+vfbTWqAlXm+1lipa/6THDui4Jm5uVFJ4PS3peRxPmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765506401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2MqnmiQEbneDIt6dVEUpH70HG0wKZ3F18+mTaCW27Co=;
	b=R3SPY+/uKT4TFI6mGOQkfto+SiGVm2WRPVzPI/3JsaLHKmm4g6H6hDGXqkyk8ZZziP92Us
	9si8RagWBl4gcfDA==
To: Chris Mason <clm@meta.com>, Frederic Weisbecker <frederic@kernel.org>
Cc: Chris Mason <clm@meta.com>, LKML <linux-kernel@vger.kernel.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Waiman Long <llong@redhat.com>,
 cgroups@vger.kernel.org
Subject: Re: [PATCH 2/3 v3] genirq: Fix interrupt threads affinity vs.
 cpuset isolated partitions
In-Reply-To: <20251212014848.3509622-1-clm@meta.com>
References: <20251212014848.3509622-1-clm@meta.com>
Date: Fri, 12 Dec 2025 11:26:39 +0900
Message-ID: <87ikece8ps.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 11 2025 at 17:48, Chris Mason wrote:
> On Fri, 21 Nov 2025 15:34:59 +0100 Frederic Weisbecker <frederic@kernel.org> wrote:
> I ran some recent commits through AI patch review and it flagged this one.
> The comments below looks right to me, but I might be missing something:
>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index c1ce30c9c3ab6..61da1c68ff82a 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -1408,16 +1408,23 @@ setup_irq_thread(struct irqaction *new, unsigned int irq, bool secondary)
>>  	 * references an already freed task_struct.
>>  	 */
>>  	new->thread = get_task_struct(t);
>
> [ ... ]
>
>> -	set_bit(IRQTF_AFFINITY, &new->thread_flags);
>> +	kthread_bind_mask(t, cpu_possible_mask);
>> +
>> +	/*
>> +	 * Ensure the thread adjusts the affinity once it reaches the
>> +	 * thread function.
>> +	 */
>> +	new->thread_flags = BIT(IRQTF_AFFINITY);
>                           ^^^
>
> Can this clobber IRQTF_FORCED_THREAD?
>
> In __setup_irq(), irq_setup_forced_threading() is called before
> setup_irq_thread(). When forced threading is enabled,
> irq_setup_forced_threading() sets IRQTF_FORCED_THREAD via set_bit():
>
>     set_bit(IRQTF_FORCED_THREAD, &new->thread_flags);
>
> Then setup_irq_thread() overwrites thread_flags with a direct assignment:
>
>     new->thread_flags = BIT(IRQTF_AFFINITY);
>
> This clears IRQTF_FORCED_THREAD. Later in irq_thread():

Yep. That's broken. Nice catch.

