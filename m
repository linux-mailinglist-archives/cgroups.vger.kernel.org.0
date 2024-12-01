Return-Path: <cgroups+bounces-5724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F829DF5D6
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 14:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCF2162FFE
	for <lists+cgroups@lfdr.de>; Sun,  1 Dec 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164D21D0E39;
	Sun,  1 Dec 2024 13:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1QkXfdg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Q/0IDO9"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2E81D0E2F;
	Sun,  1 Dec 2024 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733060598; cv=none; b=nkR0cN7fZAh3U6I6s8hSW4qadC3eYSnkyMkNepVkW41YB0qdK0r7rC4fIIJ9qncObHraEgSovzRTZZj9u0SOF55tT+BPRGW5PcHCjGWBz87zrWlnG90DSh4CF30yXqX+XOuvNCXEFdVHFkEJURYu6kEKMN/OZlrZZnuqcxW/zqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733060598; c=relaxed/simple;
	bh=YA/f8iH0VvTDq7yOjft/LV2wzPsuTs01YC6/ki45Lo0=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROZGN3MD9xrtNHJpEzasj3jZb73XIvg9xePhXwZd7kAU1Kiy0qkk4Apr0aTMR6JZbl4jIgiPLDmdGF0+K/R5dtFai2Yu3zJbfrG+RjMmrTRcr/XzBeuwVVGik2Awzzd1gfCEXFgr9LjacARnqbLjS7T40nkhx3Dx141cUlw3knw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1QkXfdg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Q/0IDO9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733060595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7QirRpzcjlf7VNRb3R9DPJ2hSPUvw3knkJqc65OqXE=;
	b=h1QkXfdg5fmzot0NVS8G8K9ZQZAvMGHuFujfJdu51hWnp9pKVF4e7XF5ybq85kPTiX9pt4
	h5thbsEv/OPoiLWHswCbZF29jiFa/sn4XbDtfx2yeZGEBKJlSRR9Y1UMjs2T1rao+epXiz
	duLU00fJ37eJIMjviCja8UJ8z1aNHR3xT6zIxQPlCzb2loRk5bIxpKJFw8jK2EZ0IBe8Hf
	rRLTqcZ7WjL7LFFYyCOrwBRATxbAeP3YiMFWYZ0ruURWDvxXkmkOfNtnPpJiTiMkGM2sm5
	tR4J28gN6xCGMl+hqwc/6Iyi5rpp8AFowA/d3yfPFrDFzQkRAPqtBERj6Mek/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733060595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7QirRpzcjlf7VNRb3R9DPJ2hSPUvw3knkJqc65OqXE=;
	b=3Q/0IDO9WyEhQrBsKr3fkhTWmTjtgoJSKyNBKab3eI5Wu6HGQUk/Q36bH/Vw5vjeQN6O3c
	/oRx1a8xK8zi0SCQ==
To: Costa Shulyupin <costa.shul@redhat.com>, longman@redhat.com,
 ming.lei@redhat.com, pauld@redhat.com, juri.lelli@redhat.com,
 vschneid@redhat.com, Tejun Heo <tj@kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Costa Shulyupin
 <costa.shul@redhat.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v4 2/4] genirq/cpuhotplug: Dynamically isolate CPUs
 from managed interrupts
In-Reply-To: <20241201124244.997754-3-costa.shul@redhat.com>
References: <20241201124244.997754-1-costa.shul@redhat.com>
 <20241201124244.997754-3-costa.shul@redhat.com>
Date: Sun, 01 Dec 2024 14:43:14 +0100
Message-ID: <87zflfv7rh.ffs@tglx>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Dec 01 2024 at 14:42, Costa Shulyupin wrote:
> After change of housekeeping_cpumask(HK_TYPE_MANAGED_IRQ) during runtime
> managed interrupts continue to run on isolated CPUs.
>
> Dynamic CPUs isolation is complex task. One of approaches is:
> 1. Set affected CPUs offline and disable relevant interrupts
> 2. Change housekeeping_cpumask
> 3. Set affected CPUs online and enable relevant interrupts
>
> irq_restore_affinity_of_irq() restores managed interrupts
> during complex CPU hotplug process of bringing back a CPU online.
>
> Leave the interrupts disabled those affinity doesn't intersect
> with new housekeeping_cpumask thereby ensuring isolation
> of the CPU from managed intrrupts.

And thereby breaking drivers, which will restore the per cpu queue and
expect interrupts to work.

The semantics of HK_TYPE_MANAGED_IRQ are clearly not what you try to
make them. See the description of the "managed_irq" command line
parameter:

        Isolate from being targeted by managed interrupts
        which have an interrupt mask containing isolated
        CPUs. The affinity of managed interrupts is
        handled by the kernel and cannot be changed via
        the /proc/irq/* interfaces.

        This isolation is best effort and only effective
        if the automatically assigned interrupt mask of a
        device queue contains isolated and housekeeping
        CPUs. If housekeeping CPUs are online then such
        interrupts are directed to the housekeeping CPU
        so that IO submitted on the housekeeping CPU
        cannot disturb the isolated CPU.

        If a queue's affinity mask contains only isolated
        CPUs then this parameter has no effect on the
        interrupt routing decision, though interrupts are
        only delivered when tasks running on those
        isolated CPUs submit IO. IO submitted on
        housekeeping CPUs has no influence on those
        queues.

It's pretty clear, no?

Thanks,

        tglx

