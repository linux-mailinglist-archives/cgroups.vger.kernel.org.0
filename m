Return-Path: <cgroups+bounces-8335-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F2CAC2C1C
	for <lists+cgroups@lfdr.de>; Sat, 24 May 2025 01:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 756E93BBAD2
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 23:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85742213E7B;
	Fri, 23 May 2025 23:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UrpNWhEQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B421F09B2
	for <cgroups@vger.kernel.org>; Fri, 23 May 2025 23:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748042538; cv=none; b=jjeGHKhaKj+nevW2n7TKPUlOqWCq6QV/DTLghek84YsZ5bQI0rl1wWyKQvJeg5ZTNWg0QqJVsoVsjDXsP8ZgzD7zR5l3ApA8raIfcEWMvo7lxzRHa76a8Y1zt2qHb/AUyrS0Cp6qEjWooO2bPS92UqfYR8HZnJJ+0WXsBdGSc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748042538; c=relaxed/simple;
	bh=PT0n5oLcAYvJ/GJTS2v1zAuSNvoef4s8WKK2UhO+rdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MP5C+eOSMEvHQVk3CgUzFt8WY/TL+PYzXtsi+R96burtvfP6s2oRQ9uxPR+kNaiP5/dASiuvUdMURiA9H6FN/Hn0BjcdgmLkr6UtSJnuRWJqijnpUFd06yYz9ACI2hYJNI8TpN3PmLT3qN76OUdl21zTBWjPkKGfoiW8Z9QukQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UrpNWhEQ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 23 May 2025 16:22:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748042533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pbohqPvTVeXsKSNiF9Zk+FfL3e0e15hYtvlbPcQaa5Q=;
	b=UrpNWhEQvglIN9mujLRlr0ou2+L+0XlJGEX5uJZXmAr4YdBorlOkOz1isGM1jbHrt0VXT2
	kKqPdtjKmEdgSB8PvWWkELaceu55sJNPUrTbSWo9gYuXJJKicPZJI7Yf/JZv1TMFTZ3ZXZ
	KTehI9aam39MJi6D8EYE/G7mBgJNOms=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Chen Yu <yu.c.chen@intel.com>
Cc: peterz@infradead.org, akpm@linux-foundation.org, mkoutny@suse.com, 
	mingo@redhat.com, tj@kernel.org, hannes@cmpxchg.org, corbet@lwn.net, 
	mgorman@suse.de, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, tim.c.chen@intel.com, aubrey.li@intel.com, libo.chen@oracle.com, 
	kprateek.nayak@amd.com, vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com, Ayush Jain <Ayush.jain3@amd.com>
Subject: Re: [PATCH v5 1/2] sched/numa: fix task swap by skipping kernel
 threads
Message-ID: <zecfzttkv2ryqbusxjyo7avvkb22dnbaggt3bth2miaujk3wjo@vwwshve724jx>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <eaacc9c9bd37bac92d43a671867d85b2fdad3b06.1748002400.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaacc9c9bd37bac92d43a671867d85b2fdad3b06.1748002400.git.yu.c.chen@intel.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 23, 2025 at 08:51:01PM +0800, Chen Yu wrote:
> From: Libo Chen <libo.chen@oracle.com>
> 
> Task swapping is triggered when there are no idle CPUs in
> task A's preferred node. In this case, the NUMA load balancer
> chooses a task B on A's preferred node and swaps B with A. This
> helps improve NUMA locality without introducing load imbalance
> between nodes. In the current implementation, B's NUMA node
> preference is not mandatory. That is to say, a kernel thread
> might be incorrectly chosen as B. However, kernel thread and
> user space thread that does not have mm are not supposed to be
> covered by NUMA balancing because NUMA balancing only considers
> user pages via VMAs.
> 
> According to Peter's suggestion for fixing this issue, we use
> PF_KTHREAD to skip the kernel thread. curr->mm is also checked
> because it is possible that user_mode_thread() might create a
> user thread without an mm. As per Prateek's analysis, after
> adding the PF_KTHREAD check, there is no need to further check
> the PF_IDLE flag:
> "
> - play_idle_precise() already ensures PF_KTHREAD is set before adding
>   PF_IDLE
> 
> - cpu_startup_entry() is only called from the startup thread which
>   should be marked with PF_KTHREAD (based on my understanding looking at
>   commit cff9b2332ab7 ("kernel/sched: Modify initial boot task idle
>   setup"))
> "
> 
> In summary, the check in task_numa_compare() now aligns with
> task_tick_numa().
> 
> Suggested-by: Michal Koutny <mkoutny@suse.com>
> Tested-by: Ayush Jain <Ayush.jain3@amd.com>
> Signed-off-by: Libo Chen <libo.chen@oracle.com>
> Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

