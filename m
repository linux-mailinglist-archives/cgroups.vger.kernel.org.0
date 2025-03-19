Return-Path: <cgroups+bounces-7160-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED04A6965F
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A59819C387B
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 17:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14583202971;
	Wed, 19 Mar 2025 17:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp7id31/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E831DE3BF;
	Wed, 19 Mar 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405165; cv=none; b=VFEvUtiACMENiYBppZbEDe1dAH0ODRqHJgBNkrOi4i+9Aj8Ncl/LaniAVjN9/nbh+alQpl/fvTDB/ZD96vz38dcPuGQv6DsLc9gTCTrjebTjfxZnAJbiFeXQMBXGPqtvda/nk1C8WxTOFfSkAEa02QYKQvwSHgfG+zHpxvhvMXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405165; c=relaxed/simple;
	bh=GBa/d5ZJnXwXWG7QhIaeYLye6YW7mc6EK6JtbZelJvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrR6jU58aJxJ9KCMJU4OegeWtun5gw23ZFKqOQCQq2it6dwgdb8K0PQkE1DdsmkkaRgz8fJoTiS+juM5Zg1TgEv3PGZGAPRnSvwlKzWb2L+StB7y+icQ3scm/+Oym6x43/uNI/9u0rnoEHv91WwQD2Kvnnk7N7xMV9Ki9pJhNSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp7id31/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765C2C4CEE9;
	Wed, 19 Mar 2025 17:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405165;
	bh=GBa/d5ZJnXwXWG7QhIaeYLye6YW7mc6EK6JtbZelJvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lp7id31/DO3cqmmJWSYyKj3SbbCKrsQYjRLojLlcyZTXYrnJG8976Nn09wkdlJq5+
	 vntIt9AWHByAEawJYfwSpqbw1uuJaqynLnglzNZLHlHACQMEDIeex8ONioxwRtaYj5
	 s2edM2YNVUfhYZukoxULhJXayB6nxxxwSo/DxSm2bQc22PLhd+3oDIY3BoXA78tWAN
	 BZ5FXkn/xvqnXUA1TEVGZO2tMT1l2QDfkzgo+htilP/eHf05dkTEG4fHr/zjM6V5Sa
	 jFIcc7QV0SazaJyK9/aU0tfxdA0rHrHfHbGdKCdI18PQiqWjE71Hf9wHJKVCPTwFF/
	 XLY7Vy8MwF4Vw==
Date: Wed, 19 Mar 2025 07:26:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Greg Thelen <gthelen@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9r-LBMjQ-s0Zb6E@slm.duckdns.org>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
> 
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
> 
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
> 
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  => started at: _raw_spin_lock_irq
>   #  => ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=> CPU#
>   #                   / _-----=> irqs-off/BH-disabled
>   #                  | / _----=> need-resched
>   #                  || / _---=> hardirq/softirq
>   #                  ||| / _--=> preempt-depth
>   #                  |||| / _-=> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    => memcg1_stat_format
>    => memory_stat_format
>    => memory_stat_show
>    => seq_read_iter
>    => vfs_read
>    => ksys_read
>    => do_syscall_64
>    => entry_SYSCALL_64_after_hwframe
> 
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> 
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses => 12.7M accesses
> -    with memory hogs: 9.46M accesses => 11.1M accesses
> The throughput of memory.stat access improves.
> 
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec => 16 usec
> -    with memory hogs: 64 usec =>  8 usec
> The memory.stat latency improves.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

