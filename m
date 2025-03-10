Return-Path: <cgroups+bounces-6934-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E9EA59A2D
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 16:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AF803A9489
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2B922CBF5;
	Mon, 10 Mar 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="x7eIRHPa"
X-Original-To: cgroups@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC411CBA;
	Mon, 10 Mar 2025 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621194; cv=none; b=auQOZcjbjOJiUGCZNo5n06C0hSQQj/b3vONVzdskT6+tYIV4r9l9Hu6txDHK4Fq3Ep0hMAt/g31gBznXFJ6ytsbGgwJ2uvti2VhFpX0EFfNslWbfJZzblNxmSPfd1tDnxx+m1hIeSS39Ynln3zE8Yeid5NaHUvK2wr9nYsPUCc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621194; c=relaxed/simple;
	bh=sf48gHTI2g1XhG0YpUhtLmKmMVnv4Y3V1rfNKy+WvL0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmVW6hacJUiTDxVUzL6mtQ3DVxYULIvkCkP084vpA94B40L9bfIL2+CH3lH8KSKftrK1TF+cJFkHIcBUUB+m0PWbpb+HhRzwYH8DD45q3pUWb+7ZJAhAr0qs4WIwXh0qZ8TsaXB2qFWasEMOaamuO8doBLjOGUyiK5Jm8WH2sOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=x7eIRHPa; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1741620886;
	bh=QD4BNC6L/gJ1g337KEtnyuP7OQgQm7c2Xf3mWHcS5dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=x7eIRHPa7tjrn76zu/SduIeF/2tjupIAvQj6DL1s3awlfZprptXX3231LOzEp/2X+
	 YofT77yuHUvAGepY4PizyBnUGqsHRb5m1IrhkXNoYqBXsYBqgGTw0QVgtCDeT2ASjV
	 qnas55sr67opfLu3DlVdspzpxANXfqwDwM9/IYA0=
Received: from chenyu5-mobl2 ([125.69.38.41])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8A7A6EA5; Mon, 10 Mar 2025 23:34:39 +0800
X-QQ-mid: xmsmtpt1741620879tgob8bak6
Message-ID: <tencent_DD83D4AEAD7235546C9CC0C62CD189A6B607@qq.com>
X-QQ-XMAILINFO: McFs54YitxxBSSrbZshezlPop2X5lsIPeKke4k5HxK2vwsXIsgILU//lzZ+g9e
	 wVKHYtthKTjn3eY7vovBwQMc7uApmxOe5vwhpLIIQ1j/ceEMh6/v5tu8WUlslfIf9u+BJwjSXhlV
	 Z8Oyfvv5lJqCN5f3tIn0nodIN4rIE2HP/pvmEiK53GRNQUTF0/CRllDf+I7GiWhQQvrP17YPku+p
	 629q8onGAQCepi+B6ubNIPIQyOf0HOwIaqjLygJ1Vi5LbxTR+818+YnQrIVHiuYahSmkYyC5tY+3
	 UvRPOZLBtvU2ZQqhmoQ2pHXeRyXmAClQVfNGAQHcSXLl/pqNj/DI62IzqM7GzX0H0GRZaeTKUSOh
	 qwEXsrVmemxy/0QtFZ8BN9Ll/wViFGxRNUW/VVBS2IjltPhq71zPiep18QoN7OuMMKLDY0baDTkz
	 qc41HuZUTGrzLlfgMe14l+0XMwOOybXSl+/N+c8nQXPsZmZvlcMkMAtRH/bZU2yZo2vR8efCJZHZ
	 VSgitjyDhHGJrG/QSEhRFo6OKKJ7uoJ9sYv7h33rncHqPtA9/Eu5gDWyYs+efO3MrNzeW1LSAAPo
	 pxAUvSl34n+D5OhkOzSxcq9USf2b8JPK4ZcfAycpYJ6MWgwh/fj1ahLNkDpIxW9jPn9fAMr1jTMk
	 eV7bHhCtbk9ezqvKzTShpkUyZJOilCWYVEuOOZBvGEeBUV1JTNZCbKtpVTlIQzdvB6vqoBrXUO/F
	 R1ex0vLnnE4tDmzuz52UIn8Pd80TVd35NzEIRDy/1+wGsrYaaa2CaAE3P1ZExWIqKSzxq9IutaRV
	 75UBLPCMaIHF532CcOe9xVE8I3W/jqiSqUKUFefK2/fy/Y9LgfzyLN5BJQztgdvtHbk0HPEadtjX
	 DEqB5yncAFF80IC+qWaFRNNizxGJljBGGnGruMiJ7RJMtdfKtQLRol06MbZe9aHW/CAhsOWI0xdX
	 sSUa9YcC2zZ8vSCVKK9J7+Q05qPf4NzVwVw6/CLbRMB99OIXUIyIbZHTo/V7h7h5oSCIcI/m4=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
Date: Mon, 10 Mar 2025 23:36:10 +0800
From: Chen Yu <yu.chen.surf@foxmail.com>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>,
	Michael Wang <yun.wang@linux.alibaba.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] sched/numa: Introduce per cgroup numa balance
 control
X-OQ-MSGID: <Z88G6tILI6h5InqM@chenyu5-mobl2>
References: <cover.1740483690.git.yu.c.chen@intel.com>
 <b3f1f6c478127a38b9091a8341374ba160d25c5a.1740483690.git.yu.c.chen@intel.com>
 <0d1cc457c6a97178fc68880957757f3c27088f53.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d1cc457c6a97178fc68880957757f3c27088f53.camel@linux.intel.com>

On 2025-03-07 at 14:54:10 -0800, Tim Chen wrote:
> On Tue, 2025-02-25 at 22:00 +0800, Chen Yu wrote:
> > [Problem Statement]
> > Currently, NUMA balancing is configured system-wide. However,
> > 
> > 
> > A simple example to show how to use per-cgroup Numa balancing:
> > 
> > Step1
> > //switch to global per cgroup Numa balancing,
> > //All cgroup's Numa balance is disabled by default.
> > echo 4 > /proc/sys/kernel/numa_balancing
> > 
> 
> Can you add documentation of this additional feature
> for numa_balancing in
> admin-guide/sysctl/kernel.rst
>

OK, will refine in next version.
 
> Should you make NUMA_BALANCING_NORMAL and NUMA_BALANCING_CGROUP
> mutually exclusive in? In other words
> echo 5 > /proc/sys/kernel/numa_balancing should result in numa_balancing to be 1?
> 
> Otherwise tg_numa_balance_enabled() can return 0 with NUMA_BALANCING_CGROUP
> bit turned on even though you have NUMA_BALANCING_NORMAL bit on.
>

I see, will fix tg_numa_balance_enabled() in next version, thanks!

Best,
Chenyu
 
> Tim
> > 
> > Suggested-by: Tim Chen <tim.c.chen@intel.com>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  include/linux/sched/sysctl.h |  1 +
> >  kernel/sched/core.c          | 32 ++++++++++++++++++++++++++++++++
> >  kernel/sched/fair.c          | 18 ++++++++++++++++++
> >  kernel/sched/sched.h         |  3 +++
> >  mm/mprotect.c                |  5 +++--
> >  5 files changed, 57 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> > index 5a64582b086b..1e4d5a9ddb26 100644
> > --- a/include/linux/sched/sysctl.h
> > +++ b/include/linux/sched/sysctl.h
> > @@ -22,6 +22,7 @@ enum sched_tunable_scaling {
> >  #define NUMA_BALANCING_DISABLED		0x0
> >  #define NUMA_BALANCING_NORMAL		0x1
> >  #define NUMA_BALANCING_MEMORY_TIERING	0x2
> > +#define NUMA_BALANCING_CGROUP		0x4
> >  
> >  #ifdef CONFIG_NUMA_BALANCING
> >  extern int sysctl_numa_balancing_mode;
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 44efc725054a..f4f048b3da68 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -10023,6 +10023,31 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_NUMA_BALANCING
> > +static DEFINE_MUTEX(numa_balance_mutex);
> > +static int numa_balance_write_u64(struct cgroup_subsys_state *css,
> > +				  struct cftype *cftype, u64 enable)
> > +{
> > +	struct task_group *tg;
> > +	int ret;
> > +
> > +	guard(mutex)(&numa_balance_mutex);
> > +	tg = css_tg(css);
> > +	if (tg->nlb_enabled == enable)
> > +		return 0;
> > +
> > +	tg->nlb_enabled = enable;
> > +
> > +	return ret;
> > +}
> > +
> > +static u64 numa_balance_read_u64(struct cgroup_subsys_state *css,
> > +				 struct cftype *cft)
> > +{
> > +	return css_tg(css)->nlb_enabled;
> > +}
> > +#endif /* CONFIG_NUMA_BALANCING */
> > +
> >  static struct cftype cpu_files[] = {
> >  #ifdef CONFIG_GROUP_SCHED_WEIGHT
> >  	{
> > @@ -10071,6 +10096,13 @@ static struct cftype cpu_files[] = {
> >  		.seq_show = cpu_uclamp_max_show,
> >  		.write = cpu_uclamp_max_write,
> >  	},
> > +#endif
> > +#ifdef CONFIG_NUMA_BALANCING
> > +	{
> > +		.name = "numa_load_balance",
> > +		.read_u64 = numa_balance_read_u64,
> > +		.write_u64 = numa_balance_write_u64,
> > +	},
> >  #endif
> >  	{ }	/* terminate */
> >  };
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 1c0ef435a7aa..526cb33b007c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -3146,6 +3146,18 @@ void task_numa_free(struct task_struct *p, bool final)
> >  	}
> >  }
> >  
> > +/* return true if the task group has enabled the numa balance */
> > +static bool tg_numa_balance_enabled(struct task_struct *p)
> > +{
> > +	struct task_group *tg = task_group(p);
> > +
> > +	if (tg && (sysctl_numa_balancing_mode & NUMA_BALANCING_CGROUP) &&
> > +	    !tg->nlb_enabled)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  /*
> >   * Got a PROT_NONE fault for a page on @node.
> >   */
> > @@ -3174,6 +3186,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
> >  	     !cpupid_valid(last_cpupid)))
> >  		return;
> >  
> > +	if (!tg_numa_balance_enabled(p))
> > +		return;
> > +
> >  	/* Allocate buffer to track faults on a per-node basis */
> >  	if (unlikely(!p->numa_faults)) {
> >  		int size = sizeof(*p->numa_faults) *
> > @@ -3596,6 +3611,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
> >  	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
> >  		return;
> >  
> > +	if (!tg_numa_balance_enabled(curr))
> > +		return;
> > +
> >  	/*
> >  	 * Using runtime rather than walltime has the dual advantage that
> >  	 * we (mostly) drive the selection from busy threads and that the
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 38e0e323dda2..9f478fb2c03a 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -491,6 +491,9 @@ struct task_group {
> >  	/* Effective clamp values used for a task group */
> >  	struct uclamp_se	uclamp[UCLAMP_CNT];
> >  #endif
> > +#ifdef CONFIG_NUMA_BALANCING
> > +	u64			nlb_enabled;
> > +#endif
> >  
> >  };
> >  
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 516b1d847e2c..ddaaf20ef94c 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -155,10 +155,11 @@ static long change_pte_range(struct mmu_gather *tlb,
> >  				toptier = node_is_toptier(nid);
> >  
> >  				/*
> > -				 * Skip scanning top tier node if normal numa
> > +				 * Skip scanning top tier node if normal/cgroup numa
> >  				 * balancing is disabled
> >  				 */
> > -				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> > +				if (!(sysctl_numa_balancing_mode &
> > +				    (NUMA_BALANCING_CGROUP | NUMA_BALANCING_NORMAL)) &&
> >  				    toptier)
> >  					continue;
> >  				if (folio_use_access_time(folio))
> 


