Return-Path: <cgroups+bounces-8727-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996A0B03DEC
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 14:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67F647AD731
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B17248F4C;
	Mon, 14 Jul 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S2Hsds8P"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B182472AA;
	Mon, 14 Jul 2025 11:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494365; cv=none; b=ablMbBVv2/m6ksB2rZK07ch2wNV7by5dj5rHbMXNCkxOaPEejcHA7N73CHakAWtB/fYrUhfENEt9y6mk3uQHfYF4bEc8LCPB5ekbvYiXJro48r56PJWb4XMqRiA3CCRXoN6gXird5Cq4aZQWxALCIwy+FstW8F9ajgAp6vlb7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494365; c=relaxed/simple;
	bh=z6xxZ7ie7amVNGU5zyuAAZgT0FOgqT6yz9y9A53vPuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYHI98AX+MRE0ZaglCjZzoR0zximJ34ISya5ZXpj1uBBfMz6eOz1nD8X804wHevsd+WXi67q7+t9Gaq1vNQxmdRdgYdAivkvC3YQ124WhC1G/QzJcXM8y1HF8e+qdCHLj7zb/8Wm32vSGaOFZQWqroRibikSOEdcNXLBI+kvkDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S2Hsds8P; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PS8iHLWKV67y4WTZrVIpXmKU38BJWCS/8TFAYbVGALc=; b=S2Hsds8PGlRw078QCmkJiEYE1k
	s5Mv3Z/UpJSQZ70lFq2hbHL35D6TusMLiH208Zs+wmhIf0NyxDV71E7ef3sRJzsWVKJnXB7vOryAl
	qYPWhomekFSEhCb+dtoUljlqVhEndartGg61+srNyzGrWgALexq2iCzprOD9sVK2uj0neSuHGany6
	i90ZWktzfxVs/ZLr57rHQ2hIXiLXT+c3ackLAXwXVmrwOylNO4vej6BB37YQ7MaVl5EAF5blWdwE9
	FwEeIe5yUvtIDie07d82pDHSz2M5QGJKGwuSt9wURN3OZY1rke+06SDlUlesdlU71gmi3Ja2n9Cyr
	C6utEXqw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubHq0-000000076PT-00Yw;
	Mon, 14 Jul 2025 11:59:16 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 66F01300186; Mon, 14 Jul 2025 13:59:15 +0200 (CEST)
Date: Mon, 14 Jul 2025 13:59:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
Message-ID: <20250714115915.GU905792@noisy.programming.kicks-ass.net>
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
 <20250714084109.GK905792@noisy.programming.kicks-ass.net>
 <090bd627-95dc-49ef-a4f6-d78d8f6d6cec@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <090bd627-95dc-49ef-a4f6-d78d8f6d6cec@huaweicloud.com>

On Mon, Jul 14, 2025 at 07:30:39PM +0800, Chen Ridong wrote:

> >> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> >> index f74d04429a29..5401adbdffa6 100644
> >> --- a/kernel/cgroup/cpuset.c
> >> +++ b/kernel/cgroup/cpuset.c
> >> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
> >>  	if (cs != &top_cpuset)
> >>  		guarantee_active_cpus(task, cpus_attach);
> >>  	else
> >> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
> >> +		cpumask_andnot(cpus_attach, cpu_active_mask,
> >>  			       subpartitions_cpus);
> > 
> > This breaks things. Any task mask must be a subset of
> > task_cpu_possible_mask() at all times. It might not be able to run
> > outside of that mask.
> 
> Hi Peter,
> 
> Thanks for your feedback. I'm afraid I don't fully understand what you
> mean by "breaks things".  Could you please explain in more detail?
> 
> To clarify my current understanding: this patch simply changes the
> cpus_attach initialization from task_cpu_possible_mask(task) to
> cpu_active_mask. The intention is that when CPUs are offlined and
> tasks get migrated to root cpuset, we shouldn't try to migrate tasks
> to offline CPUs. And since cpu_active_mask is a subset of
> cpu_possible_mask, I thought this would be safe. Did I miss anything?

task_cpu_possible_mask() is the mask a task *MUST* stay inside of.

Specifically, this was introduced for ARMv9 where some CPUs drop the
capability to run ARM32 instructions. Trying to schedule an ARM32 task
on a CPU that does not support that instruction set is an immediate and
fatal fail.

Your change results in in something akin to:

  set_cpus_allowed_task(task, cpu_active_mask & ~subpartition_cpus);

Which does not honor the task_cpu_possible_mask() constraint.

