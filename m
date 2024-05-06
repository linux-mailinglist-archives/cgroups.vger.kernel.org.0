Return-Path: <cgroups+bounces-2796-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB1F8BD28A
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF82C286A88
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF51156249;
	Mon,  6 May 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKdUA9Ak"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FC15575A
	for <cgroups@vger.kernel.org>; Mon,  6 May 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012540; cv=none; b=ooLBV/OOiRtOPZFDAVPsAMvQ5OspR60Oy0LqgG3P8ZccbcV3NGgGFoQttQZZStYWu+fAhFSYNggTJoZvK+Hr1757XNoyK3YlqoBEWlNeN+J5GU0NUEZHxdW4NXlh9x7RDI21adIeLZpxOrlV3zn1rEPSrVV0u3WV8vQlkhydqog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012540; c=relaxed/simple;
	bh=TFtwIvXQHRGTxyB6eoO0ffqHFpXtlLoYIuN3TZ2SrqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTmgwKzZCCLvyqJLVv9I9UZWhVbh1Dd8EmIX1QwkwSuIWPU7PMHPAdwKC09dbDZs9Mlv7yaiaHr2Q2zUw95UGRuhIT2guOtwRCeAxi0sl2PEca2rhkUJlcti9j5cG7tmRx88QimJAQCfTG917E3VMcUxrqpXYitQahIlQkohdqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKdUA9Ak; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 6 May 2024 09:22:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715012535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nALvQTtsxVLvBAYqOXvSZA/jQdEqOKOBP2on/4nFouA=;
	b=wKdUA9AkInjNcG4oD11+YsIiuMvwDRcyDOrBFB+tws4xaHPMT5GEyIVnCqhYQomX6+Q8RG
	0/bG7aJTnaiSyqsmhXq3FukgKGKjlh8cQNCiKmyZ7I7KjlvA9VLkx/xav4O7dGs7ILjZCO
	XSVu6YOTxp/pmTh8sosgvF5N948eKF8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Waiman Long <longman@redhat.com>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, yosryahmed@google.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, kernel-team@cloudflare.com, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Daniel Dao <dqminh@cloudflare.com>, Ivan Babrou <ivan@cloudflare.com>, jr@cloudflare.com
Subject: Re: [PATCH v1] cgroup/rstat: add cgroup_rstat_cpu_lock helpers and
 tracepoints
Message-ID: <mnakwztmiskni3k6ia5mynqfllb3dw5kicuv4wp4e4ituaezwt@2pzkuuqg6r3e>
References: <171457225108.4159924.12821205549807669839.stgit@firesoul>
 <30d64e25-561a-41c6-ab95-f0820248e9b6@redhat.com>
 <4a680b80-b296-4466-895a-13239b982c85@kernel.org>
 <203fdb35-f4cf-4754-9709-3c024eecade9@redhat.com>
 <b74c4e6b-82cc-4b26-b817-0b36fbfcc2bd@kernel.org>
 <b161e21f-9d66-4aac-8cc1-83ed75f14025@redhat.com>
 <42a6d218-206b-4f87-a8fa-ef42d107fb23@kernel.org>
 <4gdfgo3njmej7a42x6x6x4b6tm267xmrfwedis4mq7f4mypfc7@4egtwzrfqkhp>
 <55854a94-681e-4142-9160-98b22fa64d61@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55854a94-681e-4142-9160-98b22fa64d61@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, May 06, 2024 at 02:03:47PM +0200, Jesper Dangaard Brouer wrote:
> 
> 
> On 03/05/2024 21.18, Shakeel Butt wrote:
[...]
> > 
> > Hmm 128 usec is actually unexpectedly high.
> 
> > How does the cgroup hierarchy on your system looks like?
> I didn't design this, so hopefully my co-workers can help me out here? (To
> @Daniel or @Jon)
> 
> My low level view is that, there are 17 top-level directories in
> /sys/fs/cgroup/.
> There are 649 cgroups (counting occurrence of memory.stat).
> There are two directories that contain the major part.
>  - /sys/fs/cgroup/system.slice = 379
>  - /sys/fs/cgroup/production.slice = 233
>  - (production.slice have directory two levels)
>  - remaining 37
> 
> We are open to changing this if you have any advice?
> (@Daniel and @Jon are actually working on restructuring this)
> 
> > How many cgroups have actual workloads running?
> Do you have a command line trick to determine this?
> 

The rstat infra maintains a per-cpu cgroup update tree to only flush
stats of cgroups which have seen updates. So, even if you have large
number of cgroups but the workload is active in small number of cgroups,
the update tree should be much smaller. That is the reason I asked these
questions. I don't have any advise yet. At the I am trying to understand
the usage and then hopefully work on optimizing those.

> 
> > Can the network softirqs run on any cpus or smaller
> > set of cpus? I am assuming these softirqs are processing packets from
> > any or all cgroups and thus have larger cgroup update tree.
> 
> Softirq and specifically NET_RX is running half of the cores (e.g. 64).
> (I'm looking at restructuring this allocation)
> 
> > I wonder if
> > you comment out MEMCG_SOCK stat update and still see the same holding
> > time.
> > 
> 
> It doesn't look like MEMCG_SOCK is used.
> 
> I deduct you are asking:
>  - What is the update count for different types of mod_memcg_state() calls?
> 
> // Dumped via BTF info
> enum memcg_stat_item {
>         MEMCG_SWAP = 43,
>         MEMCG_SOCK = 44,
>         MEMCG_PERCPU_B = 45,
>         MEMCG_VMALLOC = 46,
>         MEMCG_KMEM = 47,
>         MEMCG_ZSWAP_B = 48,
>         MEMCG_ZSWAPPED = 49,
>         MEMCG_NR_STAT = 50,
> };
> 
> sudo bpftrace -e 'kfunc:vmlinux:__mod_memcg_state{@[args->idx]=count()}
> END{printf("\nEND time elapsed: %d sec\n", elapsed / 1000000000);}'
> Attaching 2 probes...
> ^C
> END time elapsed: 99 sec
> 
> @[45]: 17996
> @[46]: 18603
> @[43]: 61858
> @[47]: 21398919
> 
> It seems clear that MEMCG_KMEM = 47 is the main "user".
>  - 21398919/99 = 216150 calls per sec
> 
> Could someone explain to me what this MEMCG_KMEM is used for?
> 

MEMCG_KMEM is the kernel memory charged to a cgroup. It also contains
the untyped kernel memory which is not included in kernel_stack,
pagetables, percpu, vmalloc, slab e.t.c.

The reason I asked about MEMCG_SOCK was that it might be causing larger
update trees (more cgroups) on CPUs processing the NET_RX.

Anyways did the mutex change helped your production workload regarding
latencies?

