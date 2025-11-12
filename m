Return-Path: <cgroups+bounces-11858-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CA3C51365
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 983394F0A56
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00FF2FD665;
	Wed, 12 Nov 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqdeNE9W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5XX9Dx12"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C032F83A3;
	Wed, 12 Nov 2025 08:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937490; cv=none; b=sN6g6mJQKMvJEPqwbIf8E+KhQz4v4k6IVXafd+5+PUUcD606hR5vEBGv6v9c3HwQFnRG430xQyUkyWO8PSPuCbWrWKchYpFZs88NUg3BfyuId20T2V+efpm3BqLLm4AADX6rmHlGF9KFKpf27NpRJvt666EVa1E/k1LIVj6I4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937490; c=relaxed/simple;
	bh=kywgyA5FQhs8oTkjYjD9AFdb6TMZcC4VTRRosKwcu6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwu2iKmBunlY+hBc0Q1pBeU3SZuRtd/ObBXKFFwj5nwUyJOMHPaiPvwQ3o6m6oyq5c2n6eFdVSDDgdDdY0gTEeDYTzGYHXAnN+nM06WwtMBqDmch4mUn/BvhmiFBcF5GBUes+4iaNL6DxTMQ0EEYXD1QVo6YryR8mwYMOduSnjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqdeNE9W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5XX9Dx12; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Nov 2025 09:51:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762937487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQp5we3WQzNUr+PZJkPqi9yKHhRHyihXOTm5iJHE5M=;
	b=RqdeNE9WVxzF6JfkZqhPy54fYG98A573xXX6VDuMmXALlr/i4ZNejefpnEeRPr9tqm7nme
	QVUMdVDat9o1RnGZBI1tTqahIWNaVw/WUMl56/TOfjwJ8IQa+1L6Ifk27C1R49mxh7MZWq
	tx1T/8B8YjuzkERYyID647GQUPIuaOGWaW6pccjuJ6nvvsMb7yLhHZY8A241tNEsb+nXg6
	TYqWq0dMYCYqJvtwe7QIVSO4KH63s6flRkeUWgdVMVNqMxw9CQzaBa3n3LsvVQWGp7ZClU
	p21B3TmecXzrop7qWgiFziSjt7TdO9lxW7TMxTjZgdt420siwdVWfZQppDeC4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762937487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBQp5we3WQzNUr+PZJkPqi9yKHhRHyihXOTm5iJHE5M=;
	b=5XX9Dx124mDAOrpgt9BjA2WxZS5h7LCCkV3H4UL9UAaOnFsLq/wVDI/fQatJiO0WI2WIFG
	x9b7WEkh7W+YYMDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Chen Ridong <chenridong@huawei.com>, Pingfan Liu <piliu@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
Message-ID: <20251112085124.O5dlZ8Og@linutronix.de>
References: <20251112035759.1162541-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112035759.1162541-1-longman@redhat.com>

On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
> The callback_lock is a spinlock_t which is acquired either to read
> a stable set of cpu or node masks or to modify those masks when
> cpuset_mutex is also acquired. Sometime it may need to go up the
> cgroup hierarchy while holding the lock to find the right set of masks
> to use. Assuming that the depth of the cgroup hierarch is finite and
> typically small, the lock hold time should be limited.

We can't assume that, can we?

> Some externally callable cpuset APIs like cpuset_cpus_allowed() and

cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
GFP_KERNEL shortly before invoking the function in question.

> cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
This I did not find. But I would ask to rework it somehow that we don't
need to use raw_spinlock_t as a hammer that solves it all.

> stable cpuset data. These APIs currently have the restriction that they
> can't be called when a raw spinlock is being held. This is needed to
> work correctly in a PREEMPT_RT kernel. This requires additional code
> changes to work around this limitation. See [1] for a discussion of that.
> 
> Make these external cpuset APIs more useful by changing callback_lock
> to a raw_spinlock_t to remove this limitation so that they can be called
> from within other raw spinlock critical sections if needed.
> 
> [1] https://lore.kernel.org/lkml/20251110014706.8118-1-piliu@redhat.com/
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Sebastian

