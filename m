Return-Path: <cgroups+bounces-10606-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D4CBC5572
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2ECE4E9FD1
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D528A1F1;
	Wed,  8 Oct 2025 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a8Fh4yBU"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1006B283FCD;
	Wed,  8 Oct 2025 14:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759932150; cv=none; b=IFvcec7ki5AZGVZpfmhFsDQx/iqT96tDXDfXZGhckR5X9rvHnu8WLBUaAuCn2E4eWOlOAwjzCczMb2A7QmHGJqQkY6FPUWSbIMtHAx+e/06zekXRxwnHNzB+GLsKl7Hpn+zF/W5Q1ONU3As/N98qawxPVBEZs6CDUXkOtNNOBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759932150; c=relaxed/simple;
	bh=opMqdbRYxTnREhIqNTP3W4DXVGxMYhP+lE/4l3NC2co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKZ3x7lktZtBnIDptJMNBXpPobrk1It2ghz52BU88In+AX0GwXMAypKxnaHe9RbKOty1GDUMspS7TG50ieuhoCbQZXfOzkRNZZRLYIrUHn1dOevtPTMhlWlizOuY+AANF0iAkgtc0Ciz5mYjEysQh0+zvQtGk8gCRHTtdRWyF5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a8Fh4yBU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NuyOa3GaH25lZvs5J1BAadBluclsKsG+L+nNKt9cAIg=; b=a8Fh4yBU3cHoJJlnSR+usd/EJu
	JnHBk3Ai+HBLPm3GtaV5YJFq6LdxG6qSBmbDSwseKQf7Do/7v3XdLirPhZTOTZSjuyLACQ/En6Luv
	A0F6XQfgKtxcHkcWR8tiiYFWN/W+FQ07XqiHD5ch8cVQySkC1QWd6Rrplv+zi2FpuiVXiFtZljZXs
	vOZ38j4/L1S4q0SYq7ypWHPJqyYATtTLgut7CsCcGti/J4GQgvishBUaaIVQo4yIdiwnhIHEDK9oi
	2r3zF8PYtJyNhWdy2ehEJtlm1WNfCbVyxUy+LekcsCa4Kh86l4nQdfgKLil0NGk92QKZTtD2VUGfG
	cAVUkDMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6UkG-00000006NQe-40hM;
	Wed, 08 Oct 2025 14:02:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7FE8300462; Wed, 08 Oct 2025 16:02:21 +0200 (CEST)
Date: Wed, 8 Oct 2025 16:02:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
Message-ID: <20251008140221.GX4067720@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
 <xhsmhecrehcmz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmhecrehcmz.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On Tue, Oct 07, 2025 at 06:58:44PM +0200, Valentin Schneider wrote:
> On 06/10/25 12:44, Peter Zijlstra wrote:
> > @@ -7391,52 +7391,42 @@ void rt_mutex_setprio(struct task_struct
> >       if (prev_class != next_class && p->se.sched_delayed)
> >               dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
> >
> > -	queued = task_on_rq_queued(p);
> > -	running = task_current_donor(rq, p);
> 
> 
> I'm not sure how that plays with sched_ext, but for the "standard" change
> pattern such as this one & the others in core.c, that becomes a
> task_current() per sched_change_begin(). I'm guessing we want to make
> sched_change_begin() use task_current_donor() instead?

Argh yeah, rebase fail. Let me go fix.

