Return-Path: <cgroups+bounces-9962-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DD2B5204F
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CB43B9629
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3947F2C21FC;
	Wed, 10 Sep 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WEL88/Gu"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F826E16C;
	Wed, 10 Sep 2025 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757529371; cv=none; b=nrwFjWyOyoLsvZ4uU1Q49rWY6kzJSbf0DEjGem53mnmhPlvR3rnan2gOml/jOl49avuW0QBqR5wZmLT5BYy2m5x+8DZyulRNkgLkQC+lXRfdwGS6Gh0K8DGC/8L8XHFVEFrX3SbfT3fzHz1f7f6FRMp9sAJs4I+zXe0+/dq4doc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757529371; c=relaxed/simple;
	bh=fqijw/XDzf/AskVqjyaCA8x/56UgaRg2/zkkUSynxSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPQi5VZR25aA/nDP4M4Vz+doIfonLWUghDuUii/3X02S1HW80kytdqxV24WJdYxaoJgJgDu4vK/u+bxkeNqJUW5f+kSm3Waivyz9o7T8iqA/TTUxM71nocjToKcp3Ob3vMXiBecLibw5tKm73tT6XQAvwDYhDGaSHfGqVk7rKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WEL88/Gu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KwMJ9KjTMn2M16gnJGzTuFHRWs8aIEG3Ojk/moKrLfM=; b=WEL88/Gu6K/TsNls4UQiIKh8vH
	sIO5c3DTpvq9Rb5ufhol1BUKr5lPD6HwctBjrMdalyZvUBQSR9ePc3XFytP29aJOa7jq1dPD1taWl
	PbED/s6YqCME8YE8ANf8yPE8DBctnCGtdtbWl7Z4n4vOwbBLNaGldsew4VH2lNVclJtnFjc3qC8b4
	m2BLChiBVqCSk45WRADy43jvVqxYA21/qyjS+TIM96lyaShK2E31dXhTcAwONMr5jbA54BLkaH04h
	P/nsarywv3Ym7K9EGJdXUzLEGGRQcoknJpcatk7zrYuStMPFiuN7820+dtDJ8DGZHzpL0r/FsLoES
	t+J+/1Kg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwPfh-00000005wMl-09AQ;
	Wed, 10 Sep 2025 18:35:57 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B7F8C300342; Wed, 10 Sep 2025 20:35:55 +0200 (CEST)
Date: Wed, 10 Sep 2025 20:35:55 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
Message-ID: <20250910183555.GV3289052@noisy.programming.kicks-ass.net>
References: <20250910154409.446470175@infradead.org>
 <aMG2HAWhgAYBdh6Q@gpd4>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMG2HAWhgAYBdh6Q@gpd4>

On Wed, Sep 10, 2025 at 07:32:12PM +0200, Andrea Righi wrote:

> [   15.160400] Call Trace:
> [   15.160706]  dequeue_task_scx+0x14a/0x270
> [   15.160857]  move_queued_task+0x7d/0x2d0
> [   15.160952]  affine_move_task+0x6ca/0x700
> [   15.161210]  __set_cpus_allowed_ptr+0x64/0xa0
> [   15.161348]  __sched_setaffinity+0x72/0x100
> [   15.161459]  sched_setaffinity+0x261/0x2f0
> [   15.161569]  __x64_sys_sched_setaffinity+0x50/0x80
> [   15.161705]  do_syscall_64+0xbb/0x370
> [   15.161816]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Are we missing a DEQUEUE_LOCKED in the sched_setaffinity() path?

Yeah, the affine_move_task->move_queued_task path is messed up. It
relied on raw_spin_lock_irqsave(&p->pi_lock); rq_lock(rq); being
equivalent to task_rq_lock(), which is no longer true.

I fixed a few such sites earlier today but missed this one.

I'll go untangle it, but probably something for tomorrow, I'm bound to
make a mess of it now :-)

