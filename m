Return-Path: <cgroups+bounces-5370-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13CA9B8FC5
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 11:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D691F21D11
	for <lists+cgroups@lfdr.de>; Fri,  1 Nov 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8741714D3;
	Fri,  1 Nov 2024 10:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H7IWqsM7"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4F52A1B2;
	Fri,  1 Nov 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730458479; cv=none; b=iNbP0tBErdSsQqWdH9Yo6uzIgfXH8X2w3eZxo5himZX5N3TfwxfPOzEX6RaKwyOAOFOVDzZxHN7u3p/5ki3P7AyruEHJrZ+EE7Bv2wiwGRH84grypniatQtNN3IN4/B7DrtXNcApr7qP+iEUEYTrm8bzfyuFwhTZ8paqrYNgf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730458479; c=relaxed/simple;
	bh=cQcpOQMRfeJFrOwjc5JQJ1Pu8ZUGtxW8AYo9hH2Dr/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/NfsC4EjpbRuenjA/S6tQpFIzmLuM57ZFTWBvklGd7A4l3dlmg7g1OHSulic2HFdE0EQkrjpP0DWuJpDEO4fmflPh5gz21lLQns8ZKgrnlRekh5ZuChzNmdP4LewQixEXFvTmC6iiKH8BoIGmucInurpTepUPWHPIlzWvZtLEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H7IWqsM7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cMU2PXMPWhHixiOJ4wxaJ5Wp1ljqAoRHxyXW2Ip72NA=; b=H7IWqsM7Msi4h7l+86uU0JCNPN
	CAHPiALfedD/24CnJ+CZGFqg/RdTC/3BkVAW/lbIIbwL/j9sKNhG1pK/Bo/1Ctwx+OEn0XhVAIurb
	W7ltywfkWOjCvU9gsz2y1iiZlH0CqiutH7WiUMaRxLXWfhN4hjQjISehTD0FU88gLMGAokECZ9L6J
	LEUrb3R3zDZWOjNvOm0SM5SGTb2SR/gRr1K6L4+EiLuzT0B13dgyULRJ/uEmGbmY3b35/bhlC5T4A
	/Y0jQkI9MUedmbjLOmx7Ra92LDsahwP2S/Vf3p4qbRg93YaPripru3Vyfu5ScO73N+jKTWB7kHCf2
	IcGWjXmg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t6pIQ-0000000AfKW-4AIf;
	Fri, 01 Nov 2024 10:54:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5B74F300599; Fri,  1 Nov 2024 11:54:26 +0100 (CET)
Date: Fri, 1 Nov 2024 11:54:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, hannes@cmpxchg.org,
	surenb@google.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] sched: Fix irq accounting for
 CONFIG_IRQ_TIME_ACCOUNTING
Message-ID: <20241101105426.GX14555@noisy.programming.kicks-ass.net>
References: <20241101031750.1471-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101031750.1471-1-laoar.shao@gmail.com>

On Fri, Nov 01, 2024 at 11:17:46AM +0800, Yafang Shao wrote:
> After enabling CONFIG_IRQ_TIME_ACCOUNTING to track IRQ pressure in our
> container environment, we encountered several user-visible behavioral
> changes:
> 
> - Interrupted IRQ/softirq time is not accounted for in the cpuacct cgroup
> 
>   This breaks userspace applications that rely on CPU usage data from
>   cgroups to monitor CPU pressure. This patchset resolves the issue by
>   ensuring that IRQ/softirq time is accounted for in the cgroup of the
>   interrupted tasks.
> 
> - getrusage(2) does not include time interrupted by IRQ/softirq
> 
>   Some services use getrusage(2) to check if workloads are experiencing CPU
>   pressure. Since IRQ/softirq time is no longer charged to task runtime,
>   getrusage(2) can no longer reflect the CPU pressure caused by heavy
>   interrupts.
> 
> This patchset addresses the first issue, which is relatively
> straightforward. 

So I don't think it is. I think they're both the same issue. You cannot
know for whom the work done by the (soft) interrupt is.

For instance, if you were to create 2 cgroups, and have one cgroup do a
while(1) loop, while you'd have that other cgroup do your netperf
workload, I suspect you'll see significant (soft)irq load on the
while(1) cgroup, even though it's guaranteed to not be from it.

Same with rusage -- rusage is fully task centric, and the work done by
(soft) irqs are not necessarily	related to the task they interrupt.


So while you're trying to make the world conform to your legacy
monitoring view, perhaps you should fix your view of things.

