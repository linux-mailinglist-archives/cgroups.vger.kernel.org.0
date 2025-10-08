Return-Path: <cgroups+bounces-10595-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A484BC3847
	for <lists+cgroups@lfdr.de>; Wed, 08 Oct 2025 08:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 87B82351F8F
	for <lists+cgroups@lfdr.de>; Wed,  8 Oct 2025 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211992EB87E;
	Wed,  8 Oct 2025 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XBWLez4/"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFC82BE02A;
	Wed,  8 Oct 2025 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759906287; cv=none; b=GFQfT2iaIPNbdxjOQLRyxNuChzA/7KBMGLPpze71dlb5MhAXbX2Hp8CllFzlGSsd6ANs5BUmlMrrdYxPB7HKj1AFJZFziQ5frtUb0ewX2HN7K0MaX6pm/tj8kWDrIKXzaC9BWZOf0+ZnTauFb0N4wnma5cWEQha86QRocslO+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759906287; c=relaxed/simple;
	bh=gHRgGh5QI+obHIWHL0SmoWibRidhXELVybYnsbLTG+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jM7GtnZY2MfEalS4rzLPDHWIr+D5NjXaJtW73bsOrUTCPI6wKBG0/Q7hTdaLE79wEpKVAcrAQsq3667c6QrDN/6M53A7s/3YKeasMYl/9t72T4g1uMwCMcrTMT42FmppxjAgYZK86Qe4+Tf3plnYGMe1cGedvEgk0qkADBdBq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XBWLez4/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4wFNVRKSQ904MaxMgBEMzFphqKMmGj3VtnigXlW9IfY=; b=XBWLez4/oUuPKoWmGzvS8GtVzB
	5Cb9i0YwY1ECW+F/i0WEzY0EfNPLO8OxEeS4xvEM53InMxK9UGWCJ1K1F7/YJ1u76bPmjJA4xy906
	YG91cSTfvCj2/qW1ApelDf50/TtY8tfqJbRw6v9LUN/Mox08DI7PYIn1KxOIC6r/cYYxcQ2tPL4yT
	mvcYK5EPcG1Khme3uBkMwd8GbaxVxqkMiutOjRqcM7IPfrKw4fvVghrwRYY9DIO8rbRcAjOZUBtUw
	dHnKAdbwKXguRC8HAj6M4zvSVtXnUrPUts+a7gjVVHJrlxFWPCaMsq9s5Mr26Q4USoSFIyb/hIYfY
	zBv9fkVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6O0u-00000000Xcd-49DX;
	Wed, 08 Oct 2025 06:51:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 46801300230; Wed, 08 Oct 2025 08:51:03 +0200 (CEST)
Date: Wed, 8 Oct 2025 08:51:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 01/12] sched: Employ sched_change guards
Message-ID: <20251008065103.GQ4067720@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.613879143@infradead.org>
 <aOTNXPTyk4zth-1C@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOTNXPTyk4zth-1C@gpd4>

On Tue, Oct 07, 2025 at 10:20:44AM +0200, Andrea Righi wrote:
> Hi Peter,
> 
> On Mon, Oct 06, 2025 at 12:44:03PM +0200, Peter Zijlstra wrote:
> > As proposed a long while ago -- and half done by scx -- wrap the
> > scheduler's 'change' pattern in a guard helper.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Tejun Heo <tj@kernel.org>
> > ---
> ...
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -3885,23 +3885,22 @@ extern void check_class_changed(struct r
> >  extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
> >  extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
> >  
> > -#ifdef CONFIG_SCHED_CLASS_EXT
> > -/*
> > - * Used by SCX in the enable/disable paths to move tasks between sched_classes
> > - * and establish invariants.
> > - */
> > -struct sched_enq_and_set_ctx {
> 
> Not necessarily for this patch, we can add it later, but I kinda liked the
> comment that briefly explained how the context is used. Maybe having
> something along these lines could be helpful?

I have changed it thus:


--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3885,6 +3885,22 @@ extern void check_class_changed(struct r
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
 
+/*
+ * The 'sched_change' pattern is the safe, easy and slow way of changing a
+ * task's scheduling properties. It dequeues a task, such that the scheduler
+ * is fully unaware of it; at which point its properties can be modified;
+ * after which it is enqueued again.
+ *
+ * Typically this must be called while holding task_rq_lock, since most/all
+ * properties are serialized under those locks. There is currently one
+ * exception to this rule in sched/ext which only holds rq->lock.
+ */
+
+/*
+ * This structure is a temporary, used to preserve/convey the queueing state
+ * of the task between sched_change_begin() and sched_change_end(). Ensuring
+ * the task's queueing state is idempotent across the operation.
+ */
 struct sched_change_ctx {
 	struct task_struct	*p;
 	int			flags;

