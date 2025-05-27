Return-Path: <cgroups+bounces-8361-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F95AC59F1
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B081BA83C0
	for <lists+cgroups@lfdr.de>; Tue, 27 May 2025 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0418A93F;
	Tue, 27 May 2025 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lvLaWjqW"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E4242938
	for <cgroups@vger.kernel.org>; Tue, 27 May 2025 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748369763; cv=none; b=hTmwYrJz41lGFWLj+QHLawSW5oUlfV2xzShCPWIv1GuvF6b+5p26iA7lyf9W1AP7qwWb8WluCODuvb/NUHne8vlibljUHxSIxlsyemWzix3jJT2VOjSP7It027ZWk/xJK7PZf1qQ/7khFOne7vy2Xgr6nizuxlpje10hzn/aM1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748369763; c=relaxed/simple;
	bh=iUJ3YAqrX9ZTmc1NMHMhLqDQSB/nGX6czitUv/ydtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xnd7Bkan7wV0ULFXRRbYVJK9dy/zyVxtVVu3bk9rh+PRo61W2OHiF3YIWEtuwJLejIXcbXlpWX1kCJ1ViLms9qhSCPqfxLoKG2SYRtZh+n3gHRlbXUh58jeW11ruBwoPGO0TZmqNHuD56pwQ2NNdSk0CsagYZuPCncQw/If6XWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lvLaWjqW; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 May 2025 11:15:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748369758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hgp7UFRFy924BDD+FB4aDdOCHtczOgvXd6rr5SomvVo=;
	b=lvLaWjqWmcbwbDI9SnvAAklzWuKIlhtjpVMcOF4pHh+20rEa/pTZr5v1ISbaCr9S3OVMuv
	zqd7Trm+lnrdoBM7KmRAz5w1A34aqoZaaa775IoTECuB8TXDQKeBftRMtQXqd8HShqQyix
	RLRlzjHCwlC0vOZe6SgudD9NXXKtgbc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	peterz@infradead.org, akpm@linux-foundation.org, mingo@redhat.com, tj@kernel.org, 
	hannes@cmpxchg.org, corbet@lwn.net, mgorman@suse.de, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, tim.c.chen@intel.com, 
	aubrey.li@intel.com, libo.chen@oracle.com, kprateek.nayak@amd.com, 
	vineethr@linux.ibm.com, venkat88@linux.ibm.com, ayushjai@amd.com, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yu.chen.surf@foxmail.com
Subject: Re: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Message-ID: <fpa42ohp54ewxxymaclnmiafdlfs7lbddnqhtv7haksdd5jq6z@mb6jxk3pl2m2>
References: <cover.1748002400.git.yu.c.chen@intel.com>
 <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
 <cx4s4pnw5ymr4bxxmvrkhc457krq46eh6zamlr4ikp7tn3jsno@xzchjlnnawe5>
 <uuhyie7udxyvbdpccwi7dl5cy26ygkkuxjixpl247u5nqwpcqm@5whxlt5ddswo>
 <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8314889-f036-49ff-9cda-01367ddccf51@intel.com>
X-Migadu-Flow: FLOW_OUT

On Tue, May 27, 2025 at 05:20:54PM +0800, Chen, Yu C wrote:
> On 5/26/2025 9:35 PM, Michal Koutný wrote:
> > On Fri, May 23, 2025 at 04:42:50PM -0700, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > Hmm these are scheduler events, how are these relevant to memory cgroup
> > > or vmstat? Any reason to not expose these in cpu.stat?
> > 
> > Good point. If I take it further -- this functionality needs neither
> > memory controller (CONFIG_MEMCG) nor CPU controller
> > (CONFIG_CGROUP_SCHED), so it might be technically calculated and exposed
> > in _any_ cgroup (which would be same technical solution how cpu time is
> > counted in cpu.stat regardless of CPU controller, cpu_stat_show()).
> > 
> 
> Yes, we can add it to cpu.stat. However, this might make it more difficult
> for users to locate related events. Some statistics about NUMA page
> migrations/faults are recorded in memory.stat, while others about NUMA task
> migrations (triggered by NUMA faults periodicly) are stored in cpu.stat.
> 
> Do you recommend extending the struct cgroup_base_stat to include counters
> for task_migrate/task_swap? Additionally, should we enhance
> cgroup_base_stat_cputime_show() to parse task_migrate/task_swap in a manner
> similar to cputime?
> 
> Alternatively, as Shakeel previously mentioned, could we reuse
> "count_memcg_event_mm()" and related infrastructure while exposing these
> statistics/events in cpu.stat? I assume Shakeel was referring to the
> following
> approach:
> 
> 1. Skip task migration/swap in memory.stat:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cdaab8a957f3..b8eea3eca46f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1529,6 +1529,11 @@ static void memcg_stat_format(struct mem_cgroup
> *memcg, struct seq_buf *s)
>                 if (memcg_vm_event_stat[i] == PGPGIN ||
>                     memcg_vm_event_stat[i] == PGPGOUT)
>                         continue;
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +               if (memcg_vm_event_stat[i] == NUMA_TASK_MIGRATE ||
> +                   memcg_vm_event_stat[i] == NUMA_TASK_SWAP)
> +                       continue;
>  #endif
> 
> 2.Skip task migration/swap in /proc/vmstat
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index ed08bb384ae4..ea8a8ae1cdac 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1912,6 +1912,10 @@ static void *vmstat_next(struct seq_file *m, void
> *arg, loff_t *pos)
>         (*pos)++;
>         if (*pos >= NR_VMSTAT_ITEMS)
>                 return NULL;
> +#ifdef CONFIG_NUMA_BALANCING
> +       if (*pos == NUMA_TASK_MIGRATE || *pos == NUMA_TASK_SWAP)
> +               return NULL;
> +#endif
> 
> 3. Display task migration/swap events in cpu.stat:
>  seq_buf_printf(&s, "%s %lu\n",
> + vm_event_name(memcg_vm_event_stat[NUMA_TASK_MIGRATE]),
> +                      memcg_events(memcg,
> memcg_vm_event_stat[NUMA_TASK_MIGRATE]));
> 

You would need to use memcg_events() and you will need to flush the
memcg rstat trees as well

> 
> It looks like more code is needed. Michal, Shakeel, could you please advise
> which strategy is preferred, or should we keep the current version?

I am now more inclined to keep these new stats in memory.stat as the
current version is doing because:

1. Relevant stats are exposed through the same interface and we already
   have numa balancing stats in memory.stat.

2. There is no single good home for these new stats and exposing them in
   cpu.stat would require more code and even if we reuse memcg infra, we
   would still need to flush the memcg stats, so why not just expose in
   the memory.stat.

3. Though a bit far fetched, I think we may add more stats which sit at
   the boundary of sched and mm in future. Numa balancing is one
   concrete example of such stats. I am envisioning for reliable memory
   reclaim or overcommit, there might be some useful events as well.
   Anyways it is still unbaked atm.


Michal, let me know your thought on this.

