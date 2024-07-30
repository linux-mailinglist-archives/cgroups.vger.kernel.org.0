Return-Path: <cgroups+bounces-4010-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A66942167
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 22:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85FABB25E54
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 20:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A354418A6B4;
	Tue, 30 Jul 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQOaYe/v"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9912CDB6;
	Tue, 30 Jul 2024 20:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370520; cv=none; b=QLwyXUBmEDSZXozxjBhC1btLdfOtjofYS7hBjO9u2vsgYyhoBqfYW/cZPJE4zSEEgx/XkjIw5osdT0C1kWhue4sEJ7OtQvVflVNFrW4xakPSjhm18EPOsStHTivr5Aj/hMs8hCpTltkZHxq3+NWEBcfb/TY6frKd71d73eFDGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370520; c=relaxed/simple;
	bh=ay6hgAnQAQnA6PKOJXLf2wJGdfKc4x05GCOcouY6KOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOp3Fb+GYEEFy/t1I3PCIiHgZ0bjxtNLOiHsV9VXgDW1uscqTdIqkJ7hFBYot1SHYO3M9Gq15KeADMuXavevBvR/5Zoi2DNDkjiAWuCxYkAGdNxI9QLbUeAGldx0Kv4Igm+Vwdbm+BX4iLxYycpt/jt27HJgF9GHZJbGHqPZ33U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQOaYe/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3108C4AF0B;
	Tue, 30 Jul 2024 20:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722370520;
	bh=ay6hgAnQAQnA6PKOJXLf2wJGdfKc4x05GCOcouY6KOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQOaYe/voS7e7yPBBf26uuqMHv4nTNggvLSEufYWjnigpEbzGc7bbqHfMaCwbs7tR
	 c/bL9Tm68bYx+kYM2YpcoWn2tjjLxkc540s+EWmz1FDh8pnMStVOKnb+kfpytFly3S
	 vLkrnkDMn0VxwamptGIDXZdI8FF5X68dgkFhBEEZb+/jKmJ0PaGUaPH/XE9uj3eArW
	 AinIQP/guYZ6Y9Lnfq8K1O9kbffbQW2lQ4Ob0zFoo/AXGrpEB7vxxBbDdbFVJqMZKI
	 GT2I6sqQrrrlvwIRv7EYpwdhnzsflu2ytP4QO9CmFO23dyN5xin51/nE2ZjRNUD83i
	 phxECXErqFHMA==
Message-ID: <3fd88047-db3f-4165-9b58-fdeb5413c1a6@kernel.org>
Date: Tue, 30 Jul 2024 22:15:16 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
 <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
 <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 30/07/2024 20.54, Yosry Ahmed wrote:
> [..]
>>>> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
>>>> +                                      bool already_contended)
>>>>           __acquires(&cgroup_rstat_lock)
>>>>    {
>>>> -       bool contended;
>>>> +       bool locked = false;
>>>>
>>>> -       contended = !spin_trylock_irq(&cgroup_rstat_lock);
>>>> -       if (contended) {
>>>> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
>>>> +       if (already_contended) /* Skip trylock if already contended */
>>>> +               locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
>>> Should this be the other way around?
>>>
>> I think it is correct, but I used it wrong in once place, in
>> cgroup_rstat_flush_hold(), as cgroup_rstat_trylock_flusher() returning
>> false doesn't mean it was already_contended, but that ongoing flusher
>> "skipped" (and waited for) a flush.  I need to correct this.
>
> Something isn't adding up here as well. The comment says skip trylock
> if already contended, then if already_contended is true we do a
> trylock. Am I confusing myself here? 🙂

Your are correct. Thanks you for spelling it out for me!
I will send a V9 tomorrow, then deploy it to my prod experiment hosts,
and retest as I think my mistake here affects the prod results, as some
of the tracepoints gets skipped due to this.

Again thanks for catching this!!!
--Jesper

