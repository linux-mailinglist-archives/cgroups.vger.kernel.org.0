Return-Path: <cgroups+bounces-6900-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA3BA57244
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 20:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E71A3A9323
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 19:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97F255E2F;
	Fri,  7 Mar 2025 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IWdkuHeR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868524DFEF
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376530; cv=none; b=BxyXCBbu/FI7IGFVWs/l+UOqiJ42p1R2kWppiujbHkFLWF85sk/ZkOewSIJN1/2kBmNZaYERoFYtrLJVsXmesWWMrzs/lOTDS3WfpQvWvy/PnkCkzRr0bxdxKc8ZQiVjHePqB+iOWj7/wOP9a+y0FksTfzW816hm+pTgeyqLIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376530; c=relaxed/simple;
	bh=OZkliL2bYezi7a2we+4OxPKOzQpAk3iSHqbABO6VJ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeEQSg+qhqVSUc0yJFHz/wTmtCDZecQytNxNwE4l/wWsEUopGiDdDSOsaZh392JpWEj7oKBcsUR0shHquff83icTB0fmxHROXbacO3hmaEYr0SgYNlPHjp9Xe2TlL9xFYyxYpGbsjDdNwQKVf8/lw9aXhgqlnG1jqTEJiRaYDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IWdkuHeR; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Mar 2025 19:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741376525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUfk1/2NcSfPN/tpPfLTglczAj9VxtvTU3Ogyf9VQss=;
	b=IWdkuHeRMDC+9wNq0Lo0/O/5kMk6BYVu38wbtXm8ScUXAhZyee1hoE9gApdp7k2fHqLaEa
	lSJIMUsgS+5avUY2z2QStbB7g6TAtfdGW26DdBIJvqBW7FbfDuySpBvMwgW+pR60vCGAUR
	kaRdKLxXImqEfy4bcU+uXr24hZsNnsU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [RFC PATCH] memcg: net: improve charging of incoming network
 traffic
Message-ID: <Z8tMB4i_hBLaSZS1@google.com>
References: <20250307055936.3988572-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307055936.3988572-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 06, 2025 at 09:59:36PM -0800, Shakeel Butt wrote:
> Memory cgroup accounting is expensive and to reduce the cost, the kernel
> maintains per-cpu charge cache for a single memcg. So, if a charge
> request comes for a different memcg, the kernel will flush the old
> memcg's charge cache and then charge the newer memcg a fixed amount (64
> pages), subtracts the charge request amount and stores the remaining in
> the per-cpu charge cache for the newer memcg.
> 
> This mechanism is based on the assumption that the kernel, for locality,
> keep a process on a CPU for long period of time and most of the charge
> requests from that process will be served by that CPU's local charge
> cache.
> 
> However this assumption breaks down for incoming network traffic in a
> multi-tenant machine. We are in the process of running multiple
> workloads on a single machine and if such workloads are network heavy,
> we are seeing very high network memory accounting cost. We have observed
> multiple CPUs spending almost 100% of their time in net_rx_action and
> almost all of that time is spent in memcg accounting of the network
> traffic.
> 
> More precisely, net_rx_action is serving packets from multiple workloads
> and is observing/serving mix of packets of these workloads. The memcg
> switch of per-cpu cache is very expensive and we are observing a lot of
> memcg switches on the machine. Almost all the time is being spent on
> charging new memcg and flushing older memcg cache. So, definitely we
> need per-cpu cache that support multiple memcgs for this scenario.

We've internally faced a different situation on machines with a large
number of CPUs where the mod_memcg_state(MEMCG_SOCK) call in
mem_cgroup_[un]charge_skmem() causes latency due to high contention on
the atomic update in memcg_rstat_updated().

In this case, networking performs a lot of charge/uncharge operations,
but because we count the absolute magnitude updates in
memcg_rstat_updated(), we reach the threshold quickly. In practice, a
lot of these updates cancel each other out so the net change in the
stats may not be that large.

However, not using the absolute value of the updates could cause stat
updates of irrelevant stats with opposite polarity to cancel out,
potentially delaying stat updates.

I wonder if we can leverage the batching introduced here to fix this
problem as well. For example, if the charging in
mem_cgroup_[un]charge_skmem() is satisfied from this catch, can we avoid
mod_memcg_state() and only update the stats once at the end of batching?

IIUC the current implementation only covers the RX path, so it will
reduce the number of calls to mod_memcg_state(), but it won't prevent
charge/uncharge operations from raising the update counter
unnecessarily. I wonder if the scope of the batching could be increased
so that both TX and RX use the same cache, and charge/uncharge
operations cancel out completely in terms of stat updates.

WDYT?

