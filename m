Return-Path: <cgroups+bounces-6902-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF34A57572
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 23:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452B11899921
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECD42580C3;
	Fri,  7 Mar 2025 22:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/Fcjbvr"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC41724167A;
	Fri,  7 Mar 2025 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741388054; cv=none; b=f3riS3xQ5urWsmOiJHpdyRQiVCNB6z6K2oOcRUDIg5G/+C/QQg6C4dcuOvSdllX3Xym3aGFD0d9DYNpGXsMwywA3RCXeC6Xq7j8SxtYz6hBTeCRrcRHJJ2i9fSspPZLRJKxczcp0XbGXpTNi4NWWkKQZHLMhfmtLQZHv2mXvSU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741388054; c=relaxed/simple;
	bh=h95jfDEVekegdqKYt0vI61hdhO60jEa8FkEqwJSP3t0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M4RCftU6C3UqRlARjho7e7k1hBnPw8WbYPJgALSCZy+RJUakD6L1eS4JarsJ4C7IWTHr3+M+2Ec2jPe2qHD15q5tkRzRCa4VI5qwPp4LOT5Dsrkx5d5JoW3b3CyApZ8hHQVDa7ntTtl2/fHkznkU3/5TQ/p3fR1Cq5bHxuaH5nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/Fcjbvr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741388053; x=1772924053;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=h95jfDEVekegdqKYt0vI61hdhO60jEa8FkEqwJSP3t0=;
  b=O/FcjbvriXj/sVEzUaTWU7hVw/dMl1j0wGVepd8SLtGoQwMpR3VhOMpD
   e/N64yAvyJDpHNPyQNwSa6qRr4FPj1p8VubEYMJeF2+R9ib2Ms4Aafdsj
   CxXK/arTxURlIqVc8FXAUXzazBxXdpu2JziSzs+2CH6VADQtFVh68vCGr
   n8t5gpW8T4tINvSXCh+yF3abMmMnF0dlb4hf4zc6qqEHdN0M85c3yj7G5
   fTb/J3x/49oCwoxOKN2tGoaE1nfvoN/VZsNvPHbx6CCbE090BSSuzU58C
   cWhtEssv9VGKytPHDCsZECgXakfMaYfww6dZP3L10XGxRBzWSIpHXlBWq
   Q==;
X-CSE-ConnectionGUID: fEFMGlcJQaqnNlRrrS9k9A==
X-CSE-MsgGUID: LCpkEvjtRrmvYjxGBM3Eng==
X-IronPort-AV: E=McAfee;i="6700,10204,11366"; a="42156863"
X-IronPort-AV: E=Sophos;i="6.14,230,1736841600"; 
   d="scan'208";a="42156863"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:54:12 -0800
X-CSE-ConnectionGUID: tkw14bPlTzOo9dHdIvualg==
X-CSE-MsgGUID: 4IRqfbo2SZ6xNS3eCfDgeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119382998"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.110.166]) ([10.125.110.166])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 14:54:12 -0800
Message-ID: <0d1cc457c6a97178fc68880957757f3c27088f53.camel@linux.intel.com>
Subject: Re: [RFC PATCH 2/3] sched/numa: Introduce per cgroup numa balance
 control
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, Mel Gorman <mgorman@suse.de>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Huang, Ying" <ying.huang@linux.alibaba.com>, Tim Chen
 <tim.c.chen@intel.com>, Aubrey Li <aubrey.li@intel.com>, Michael Wang
 <yun.wang@linux.alibaba.com>, Kaiyang Zhao <kaiyang2@cs.cmu.edu>, David
 Rientjes <rientjes@google.com>, Raghavendra K T <raghavendra.kt@amd.com>,
 cgroups@vger.kernel.org,  linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Mar 2025 14:54:10 -0800
In-Reply-To: <b3f1f6c478127a38b9091a8341374ba160d25c5a.1740483690.git.yu.c.chen@intel.com>
References: <cover.1740483690.git.yu.c.chen@intel.com>
	 <b3f1f6c478127a38b9091a8341374ba160d25c5a.1740483690.git.yu.c.chen@intel.com>
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-02-25 at 22:00 +0800, Chen Yu wrote:
> [Problem Statement]
> Currently, NUMA balancing is configured system-wide. However,
>=20
>=20
> A simple example to show how to use per-cgroup Numa balancing:
>=20
> Step1
> //switch to global per cgroup Numa balancing,
> //All cgroup's Numa balance is disabled by default.
> echo 4 > /proc/sys/kernel/numa_balancing
>=20

Can you add documentation of this additional feature
for numa_balancing in
admin-guide/sysctl/kernel.rst

Should you make NUMA_BALANCING_NORMAL and NUMA_BALANCING_CGROUP
mutually exclusive in? In other words
echo 5 > /proc/sys/kernel/numa_balancing should result in numa_balancing to=
 be 1?

Otherwise tg_numa_balance_enabled() can return 0 with NUMA_BALANCING_CGROUP
bit turned on even though you have NUMA_BALANCING_NORMAL bit on.

Tim
>=20
> Suggested-by: Tim Chen <tim.c.chen@intel.com>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  include/linux/sched/sysctl.h |  1 +
>  kernel/sched/core.c          | 32 ++++++++++++++++++++++++++++++++
>  kernel/sched/fair.c          | 18 ++++++++++++++++++
>  kernel/sched/sched.h         |  3 +++
>  mm/mprotect.c                |  5 +++--
>  5 files changed, 57 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 5a64582b086b..1e4d5a9ddb26 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -22,6 +22,7 @@ enum sched_tunable_scaling {
>  #define NUMA_BALANCING_DISABLED		0x0
>  #define NUMA_BALANCING_NORMAL		0x1
>  #define NUMA_BALANCING_MEMORY_TIERING	0x2
> +#define NUMA_BALANCING_CGROUP		0x4
> =20
>  #ifdef CONFIG_NUMA_BALANCING
>  extern int sysctl_numa_balancing_mode;
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 44efc725054a..f4f048b3da68 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -10023,6 +10023,31 @@ static ssize_t cpu_max_write(struct kernfs_open_=
file *of,
>  }
>  #endif
> =20
> +#ifdef CONFIG_NUMA_BALANCING
> +static DEFINE_MUTEX(numa_balance_mutex);
> +static int numa_balance_write_u64(struct cgroup_subsys_state *css,
> +				  struct cftype *cftype, u64 enable)
> +{
> +	struct task_group *tg;
> +	int ret;
> +
> +	guard(mutex)(&numa_balance_mutex);
> +	tg =3D css_tg(css);
> +	if (tg->nlb_enabled =3D=3D enable)
> +		return 0;
> +
> +	tg->nlb_enabled =3D enable;
> +
> +	return ret;
> +}
> +
> +static u64 numa_balance_read_u64(struct cgroup_subsys_state *css,
> +				 struct cftype *cft)
> +{
> +	return css_tg(css)->nlb_enabled;
> +}
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>  static struct cftype cpu_files[] =3D {
>  #ifdef CONFIG_GROUP_SCHED_WEIGHT
>  	{
> @@ -10071,6 +10096,13 @@ static struct cftype cpu_files[] =3D {
>  		.seq_show =3D cpu_uclamp_max_show,
>  		.write =3D cpu_uclamp_max_write,
>  	},
> +#endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	{
> +		.name =3D "numa_load_balance",
> +		.read_u64 =3D numa_balance_read_u64,
> +		.write_u64 =3D numa_balance_write_u64,
> +	},
>  #endif
>  	{ }	/* terminate */
>  };
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1c0ef435a7aa..526cb33b007c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3146,6 +3146,18 @@ void task_numa_free(struct task_struct *p, bool fi=
nal)
>  	}
>  }
> =20
> +/* return true if the task group has enabled the numa balance */
> +static bool tg_numa_balance_enabled(struct task_struct *p)
> +{
> +	struct task_group *tg =3D task_group(p);
> +
> +	if (tg && (sysctl_numa_balancing_mode & NUMA_BALANCING_CGROUP) &&
> +	    !tg->nlb_enabled)
> +		return false;
> +
> +	return true;
> +}
> +
>  /*
>   * Got a PROT_NONE fault for a page on @node.
>   */
> @@ -3174,6 +3186,9 @@ void task_numa_fault(int last_cpupid, int mem_node,=
 int pages, int flags)
>  	     !cpupid_valid(last_cpupid)))
>  		return;
> =20
> +	if (!tg_numa_balance_enabled(p))
> +		return;
> +
>  	/* Allocate buffer to track faults on a per-node basis */
>  	if (unlikely(!p->numa_faults)) {
>  		int size =3D sizeof(*p->numa_faults) *
> @@ -3596,6 +3611,9 @@ static void task_tick_numa(struct rq *rq, struct ta=
sk_struct *curr)
>  	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->nex=
t !=3D work)
>  		return;
> =20
> +	if (!tg_numa_balance_enabled(curr))
> +		return;
> +
>  	/*
>  	 * Using runtime rather than walltime has the dual advantage that
>  	 * we (mostly) drive the selection from busy threads and that the
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 38e0e323dda2..9f478fb2c03a 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -491,6 +491,9 @@ struct task_group {
>  	/* Effective clamp values used for a task group */
>  	struct uclamp_se	uclamp[UCLAMP_CNT];
>  #endif
> +#ifdef CONFIG_NUMA_BALANCING
> +	u64			nlb_enabled;
> +#endif
> =20
>  };
> =20
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 516b1d847e2c..ddaaf20ef94c 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -155,10 +155,11 @@ static long change_pte_range(struct mmu_gather *tlb=
,
>  				toptier =3D node_is_toptier(nid);
> =20
>  				/*
> -				 * Skip scanning top tier node if normal numa
> +				 * Skip scanning top tier node if normal/cgroup numa
>  				 * balancing is disabled
>  				 */
> -				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
> +				if (!(sysctl_numa_balancing_mode &
> +				    (NUMA_BALANCING_CGROUP | NUMA_BALANCING_NORMAL)) &&
>  				    toptier)
>  					continue;
>  				if (folio_use_access_time(folio))


