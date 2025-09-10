Return-Path: <cgroups+bounces-9961-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A424FB52031
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 20:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63C01C85D8C
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA226F2B2;
	Wed, 10 Sep 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WSatKagG"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78E22422A;
	Wed, 10 Sep 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757528405; cv=none; b=DBbCmu1R4IV6dKdMt7jmSJBmyae+ROnLqiGVbmKYgUy/LUUN17E3R7wSZhq3Ep7NzpY0xt5MLTx4iATTnmDng/Rrdb3Fnpsxc4IptbnaWlUvbWOSj2kZUOKTQzY9MQvvV+m4b1OEHY0W0/vPrYXxFyjyOq3MGOJnIlZ8E1sDdNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757528405; c=relaxed/simple;
	bh=ewGV+K42Qi2TBeJG/kRJCd6MynsZ6+8Ifv4ODPkQs5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qh9eMpQTsX/jTkdyyxNllSmUFui+NnOHrNcbauB0vCk5AjC8GapoKmzwAWx2kF6QZnNdO9lcu+nuzS6nP0xqWYcJDJ8l/a1PYLUwY/SD7hm0/LuIW6/b6/xHyRQVtpGq8fbJQxyCxqvtiHLo4ajyKZ7NSMVVUoIsFNrPv6cgipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WSatKagG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TjWNQMxBOIgUJz+VV92/f6Sqt99APWpac1vz/U7RENk=; b=WSatKagGqiYXaRwXFonVtpHvUp
	xei20UdTVUB7PPX3UvE3SqQhA6qdCRikIroG5DFD6bfwfYlvbReKxPQxrhPul6NAUZfBWin/vLyIW
	JnHQma1ZIAZW3egF37tgCT3kI9+Ox4D7fQlMtxMlXomI3PZFpChKE8UPhroirCf8jyXvoakH60qqW
	kEIPOAeub74cB06TGTnoqByVozue2OGOUkmpeAIJVyiA1JgfskWfE7kBpHcVBfoEIB5kRYcHnea6t
	VwjrTRiKcUd9bF9tqSWENo14wzG2qGoNOQrp+TUrV8NCwQx5JDbzEmj9VKeQDElu+PPg0SfecdsSM
	k1GLBf2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwPQ9-0000000DNqA-3tUQ;
	Wed, 10 Sep 2025 18:19:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8A0F2300342; Wed, 10 Sep 2025 20:19:52 +0200 (CEST)
Date: Wed, 10 Sep 2025 20:19:52 +0200
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
Message-ID: <20250910181952.GU3289052@noisy.programming.kicks-ass.net>
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

> I've done a quick test with this patch set applied and I was able to
> trigger this:
> 
> [   49.746281] ============================================
> [   49.746457] WARNING: possible recursive locking detected
> [   49.746559] 6.17.0-rc4-virtme #85 Not tainted
> [   49.746666] --------------------------------------------
> [   49.746763] stress-ng-race-/5818 is trying to acquire lock:
> [   49.746856] ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: dispatch_dequeue+0x125/0x1f0
> [   49.747052]
> [   49.747052] but task is already holding lock:
> [   49.747234] ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x170
> [   49.747416]
> [   49.747416] other info that might help us debug this:
> [   49.747557]  Possible unsafe locking scenario:
> [   49.747557]
> [   49.747689]        CPU0
> [   49.747740]        ----
> [   49.747793]   lock(&dsq->lock);
> [   49.747867]   lock(&dsq->lock);
> [   49.747950]
> [   49.747950]  *** DEADLOCK ***
> [   49.747950]
> [   49.748086]  May be due to missing lock nesting notation
> [   49.748086]
> [   49.748197] 3 locks held by stress-ng-race-/5818:
> [   49.748335]  #0: ffff890e0f0fce70 (&p->pi_lock){-.-.}-{2:2}, at: task_rq_lock+0x38/0x170
> [   49.748474]  #1: ffff890e3b6bcc98 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x20/0xa0
> [   49.748652]  #2: ffff890e0adacc18 (&dsq->lock){-.-.}-{2:2}, at: task_rq_lock+0x6c/0x170
> 
> Reproducer:
> 
>  $ cd tools/sched_ext
>  $ make scx_simple
>  $ sudo ./build/bin/scx_simple
>  ... and in another shell
>  $ stress-ng --race-sched 0

Heh, the selftests thing was bound to not cover everything. I'll have a
poke at it. Thanks!

