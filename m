Return-Path: <cgroups+bounces-10617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D50BC9627
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D64F47B2
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847662E9730;
	Thu,  9 Oct 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SxAjVnxb"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3668E2E9EA9;
	Thu,  9 Oct 2025 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018063; cv=none; b=eQc58azlYJ7fvyUFhKJqWY5BgLZPtZkzotY5fpCrw/Y6ihvhaBREJ89JlM2XhqoYsUuN8hlQI0j59ZnB3xtUfiOmm03muOPp1EYOHp3aPGJZfjaFF8uc/RFvHpDsQIH8Tb1TKc02pE9QHhEL2c3vH9AyiTwh49VYOnmvHDH4kAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018063; c=relaxed/simple;
	bh=QtXc8ESkwpZEhqGealqs1YU7jMM9lHkaFm2L48lnLcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D0PzM6IRZCpkODzkY2KAhW3iMtKc5mpFwfDT4PX9nIiBYecdXWz+75u/6MeGaZ5C/b6rzGuicOQLNkL0b54dmfsjlESeM/TEsoGrkqd6e3Bbe9E/iYtQ2ovPaIt6KsgR5Myu94uvqfREXjsSG/rFDkf5Qqa5s2/Qj4LZ2VXlvsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SxAjVnxb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iEcPPHQnhpaxY6WSqV84aGI8Fn5PdIquY/j42KoeHTg=; b=SxAjVnxb948i+fQGF6yVCzpKLX
	YTBpVI2+jn7Pb/4z8xa4PjwZTL1pU8pcd5ad186U7/mIOFwJs7ZrUo8RquXHFFYUJpdrrzs8OxaGg
	0ZDXDeP5oIyFV/nkNVFDlvP75HGtsp/TeGxzFcwD9SQ1VFqUPtrQMZ/PiWYUkzRxYao/IP30yiFtU
	R+Uhnk+1fAaLz5T/vtQDN/KgQpogK7YeIRMDF3okPXXBI6b0jonfRKR8X4vOpHHAUOJjyWiomxgtW
	W8PJEUiXx6rDCBtUZlXBGwGG3J94JmA/rVae050LvLGykx4sk9CR6U1ndqV/lgAW7rvNvm8VRaavN
	m4/XePoA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6r5s-00000008XE6-17lR;
	Thu, 09 Oct 2025 13:54:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 641C5300342; Thu, 09 Oct 2025 15:54:08 +0200 (CEST)
Date: Thu, 9 Oct 2025 15:54:08 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 03/12] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <20251009135408.GD4067720@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.861755244@infradead.org>
 <02452879-8998-47e0-9679-d2ff00503901@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02452879-8998-47e0-9679-d2ff00503901@arm.com>

On Thu, Oct 09, 2025 at 03:30:02PM +0200, Dietmar Eggemann wrote:
> On 06.10.25 12:44, Peter Zijlstra wrote:
> > Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
> > the change pattern. This completes and makes the pattern more
> > symmetric.
> > 
> > This changes the order of callbacks slightly:
> > 
> > 				|
> > 				|  switching_from()
> >   dequeue_task();		|  dequeue_task()
> >   put_prev_task();		|  put_prev_task()
> > 				|  switched_from()
> > 				|
> >   ... change task ...		|  ... change task ...
> > 				|
> >   switching_to();		|  switching_to()
> >   enqueue_task();		|  enqueue_task()
> >   set_next_task();		|  set_next_task()
> >   prev_class->switched_from()	|
> >   switched_to()			|  switched_to()
> > 				|
> > 
> > Notably, it moves the switched_from() callback right after the
> > dequeue/put. Existing implementations don't appear to be affected by
> > this change in location -- specifically the task isn't enqueued on the
> > class in question in either location.
> > 
> > Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
> > when changing scheduling classes.
> 
> This one causes a DL bw related warning when I run a simple 1 DL task
> rt-app workload:

> Not sure yet how this is related to switched_from_dl() being now called earlier?

Ooh, I might see a problem. task_non_contending() uses dl_task(), which
uses p->prio. The move above means it is now called using the 'old'
prio, whereas it used to run with the 'new' prio.

I suppose it does this to distinguish 'real' DL tasks from PI boosted DL
tasks.

Let me see if I can figure out something for this.

