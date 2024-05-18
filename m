Return-Path: <cgroups+bounces-2956-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CA18C8F2F
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 03:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96259281728
	for <lists+cgroups@lfdr.de>; Sat, 18 May 2024 01:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FC81A2C3E;
	Sat, 18 May 2024 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X/lJrsny";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wUEZICMm"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5C4C8B;
	Sat, 18 May 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715995544; cv=none; b=Y5zHDW6uHr88YWtilIxgK9/l+VqwOSZ+C0yVsbdn2fTasxK7wUpVMZ56ZzRIe9vdCjQqDgvQnYXbb/loqxxt/A1fwLFoZ7OoVKFE7Ryb/NZawqkYsRfXqEOIaMJYSbaxdr9Crro7jdJhkw0ktdsC9NXWa45+yEj2+ttatnWahfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715995544; c=relaxed/simple;
	bh=bShbf5InU3Hku1+D50QV7iqSrD5aDAK0nYFxFHxjIT0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ryqWC1hyllSSidz+4wP4XQ8auh0Plc4Q8AO6ajmu5nYs2MzfhmlSpCQnUog8csy1TIl9V3XrKudNCw9QjG0KOiIehb6tl/ppWRxi6B3VaGQUxAD22S8QcW81+IQ5RbMCRUJ2+IHlztqm7xPe+IQoazrmY1oXZ3SrFVUy9QAPb4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X/lJrsny; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wUEZICMm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715995540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjMrzFAps1/5DI6E1pJhCseVkyrxWMsgaCpQLqNIzZo=;
	b=X/lJrsnyGUlY+3ZKYTovXIRlEOXIlO0BbAxuTC2XCUZpJnzqXKrsS2GCGP0IhlXOAhKAiu
	oiwZfApTT/xFHuuzPnxJQgKY5Kh2Z1QxB3jS6HO6iRyjdkV/3NYEmzQ4wyD+Icj9kGDe8u
	gtvnYBEXAGeM7n3fA2UC5QVilkHxFKnkcSnZY6zOx2avdWaXdkcxx5L5Q09QGWUY8q/iWC
	k3LhnrcE5UnTtOVQCN1s2OSIWc4b9J8OiOz4mHdw5QNHBDeZ9pXO6TSPH0Ai/mTx50wbMI
	VqmcEIFzIhGSpJTiBs+D/Ctt02iYnf0P0yHVlrFvxxD3cOLcGRVw907SrPE85A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715995540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FjMrzFAps1/5DI6E1pJhCseVkyrxWMsgaCpQLqNIzZo=;
	b=wUEZICMmJ76CMNcDJx/e17MYOhK/Gvz4w8qhTeWQSUQ7Qc9RZjjor5fKQ1sxKJ55p9VQRy
	ojcQhCMjl0shB6CA==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 pauld@redhat.com, juri.lelli@redhat.com, prarit@redhat.com,
 vschneid@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Yoann Congal <yoann.congal@smile.fr>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, Costa
 Shulyupin <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [PATCH v1 4/7] sched/isolation: Adjust affinity of managed irqs
 according to change of housekeeping cpumask
In-Reply-To: <87wmnrj4uz.ffs@tglx>
References: <20240516190437.3545310-1-costa.shul@redhat.com>
 <20240516190437.3545310-5-costa.shul@redhat.com> <87wmnrj4uz.ffs@tglx>
Date: Sat, 18 May 2024 03:25:40 +0200
Message-ID: <87seyfj4h7.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Costa!

On Sat, May 18 2024 at 03:17, Thomas Gleixner wrote:
> Impressive...

Now let's take a step back because none of this makes any sense at all
conceptually.

Reconfiguring the housekeeping CPUs on a life system is expensive and a
slow path operation no matter what.

So why inflicting all of this nonsense to the kernel instead of
cleverly (ab)using CPU hotplug for it in user space:

          for_each_cpu(cpu, new_house_keeping_mask) {
          	if (cpu_ishk(cpu))
                	continue;
                cpu_offline(cpu);
                set_cpu_in_hkmask(cpu);
                cpu_online(cpu);
          }

          for_each_cpu(cpu, new_isolated_mask) {
          	if (!cpu_ishk(cpu))
                	continue;
                cpu_offline(cpu);
                clear_cpu_in_hkmask(cpu);
                cpu_online(cpu);
          }

Or something like that. You get the idea, right?

IOW, the only kernel change which is required to achieve your goal is to
ensure that changing the housekeeping/isolated property of a CPU at
runtime is only possible when the CPU is "offline".

Then all of the magic things you try to solve just work out of the box
because the existing and well exercised hotplug code takes care of it
already, no?

I might be missing something obvious as always, so feel free to educate
me on it. 

Thanks,

        tglx

