Return-Path: <cgroups+bounces-8391-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A0BAC825B
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 20:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45B9500505
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 18:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0E1230D1E;
	Thu, 29 May 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VtgYLdCG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1461DB924
	for <cgroups@vger.kernel.org>; Thu, 29 May 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748545114; cv=none; b=hSwB9UKgABrAeS4/4TfX+dpb1UFe5b+VnAqccpABmfKQ4+JU0smI2yajRGUHef5zewRLN5ZNBg7o5tKJ6jRaH8by+W41TAX14pzqbbwfLfl+Veoeof/2sDu3aZnqRVGtspr7AqRBIK4SGcC6h1FJAzM+BACXZxN91fvLtAva9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748545114; c=relaxed/simple;
	bh=QeyNgQcP7SUNBaCrPXf1RaNXU4rKkV1IpXNIIrZFDm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNMD7SFBGn9mADNf3IX7IYCp1HQ744h2cciulHtXhwMlSY122eFoC5SuxH59cjKZ8CCOYBl/O2dlmNIDF+zkIurPKV3edJEixrasBts7iaqaLHXlG9CSuUNYG7AQxN1Gl/joJO9cKzPJ5maWxfoP3xuynrhxtcN0BFI6BhQxyH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VtgYLdCG; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f688f2e-7d26-423a-9029-d1b1ef1c938a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748545109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOHe7a4ltmWqU1e5ZS3U2ls9kKsTWCwuykifpUWa7fs=;
	b=VtgYLdCGWWtZxWhQVaE20Jrx/LldVehE0PJCfOKVrqNgrnWGgXGpsBM7eVN23clwEmliho
	GQUhZsaz5b8m1oaK2Mx/XoVNwY6T20jmR4ydzzDEUexemsKiZh6kou1HCCfRjK3P+6SvtD
	oDhdQDsdcTNnrCrcxDfzztsxaC14pb0=
Date: Thu, 29 May 2025 11:58:17 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] cgroup: move rstat base stat objects into their
 own struct
To: JP Kobryn <inwardvessel@gmail.com>, tj@kernel.org,
 shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
 hannes@cmpxchg.org, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-2-inwardvessel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20250404011050.121777-2-inwardvessel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/3/25 6:10 PM, JP Kobryn wrote:
> This non-functional change serves as preparation for moving to
> subsystem-based rstat trees. The base stats are not an actual subsystem,
> but in future commits they will have exclusive rstat trees just as other
> subsystems will.
> 
> Moving the base stat objects into a new struct allows the cgroup_rstat_cpu
> struct to become more compact since it now only contains the minimum amount
> of pointers needed for rstat participation. Subsystems will (in future
> commits) make use of the compact cgroup_rstat_cpu struct while avoiding the
> memory overhead of the base stat objects which they will not use.
> 
> An instance of the new struct cgroup_rstat_base_cpu was placed on the
> cgroup struct so it can retain ownership of these base stats common to all
> cgroups. A helper function was added for looking up the cpu-specific base
> stats of a given cgroup. Finally, initialization and variable names were
> adjusted where applicable.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>   include/linux/cgroup-defs.h | 38 ++++++++++-------
>   kernel/cgroup/cgroup.c      |  8 +++-
>   kernel/cgroup/rstat.c       | 84 ++++++++++++++++++++++---------------
>   3 files changed, 79 insertions(+), 51 deletions(-)
> 

Hi everyone.

BPF CI started failing after recent upstream merges (tip: 90b83efa6701).
I bisected the issue to this patch, see a log snippet below [1]:

     ##[error]#44/9 btf_tag/btf_type_tag_percpu_vmlinux_helper
     load_btfs:PASS:could not load vmlinux BTF 0 nsec
     test_btf_type_tag_vmlinux_percpu:PASS:btf_type_tag_percpu 0 nsec
     libbpf: prog 'test_percpu_helper': BPF program load failed: -EACCES
     libbpf: prog 'test_percpu_helper': -- BEGIN PROG LOAD LOG --
     0: R1=ctx() R10=fp0
     ; int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char 
*path) @ btf_type_tag_percpu.c:58
     0: (79) r1 = *(u64 *)(r1 +0)
     func 'cgroup_mkdir' arg0 has btf_id 437 type STRUCT 'cgroup'
     1: R1_w=trusted_ptr_cgroup()
     ; cpu = bpf_get_smp_processor_id(); @ btf_type_tag_percpu.c:63
     1: (7b) *(u64 *)(r10 -8) = r1         ; R1_w=trusted_ptr_cgroup() 
R10=fp0 fp-8_w=trusted_ptr_cgroup()
     2: (85) call bpf_get_smp_processor_id#8       ; 
R0_w=scalar(smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
     3: (79) r1 = *(u64 *)(r10 -8)         ; R1_w=trusted_ptr_cgroup() 
R10=fp0 fp-8_w=trusted_ptr_cgroup()
     ; cgrp->self.rstat_cpu, cpu); @ btf_type_tag_percpu.c:65
     4: (79) r1 = *(u64 *)(r1 +32)         ; R1_w=percpu_ptr_css_rstat_cpu()
     ; rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr( @ 
btf_type_tag_percpu.c:64
     5: (bc) w2 = w0                       ; 
R0_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 
0x1)) 
R2_w=scalar(id=1,smin=smin32=0,smax=umax=smax32=umax32=1,var_off=(0x0; 0x1))
     6: (85) call bpf_per_cpu_ptr#153      ; 
R0=ptr_or_null_css_rstat_cpu(id=2)
     ; if (rstat) { @ btf_type_tag_percpu.c:66
     7: (15) if r0 == 0x0 goto pc+1        ; R0=ptr_css_rstat_cpu()
     ; *(volatile int *)rstat; @ btf_type_tag_percpu.c:68
     8: (61) r1 = *(u32 *)(r0 +0)
     cannot access ptr member updated_children with moff 0 in struct 
css_rstat_cpu with off 0 size 4
     processed 9 insns (limit 1000000) max_states_per_insn 0 
total_states 1 peak_states 1 mark_read 1
     -- END PROG LOAD LOG --
     libbpf: prog 'test_percpu_helper': failed to load: -EACCES
     libbpf: failed to load object 'btf_type_tag_percpu'
     libbpf: failed to load BPF skeleton 'btf_type_tag_percpu': -EACCES
     test_btf_type_tag_vmlinux_percpu:FAIL:btf_type_tag_percpu_helper 
unexpected error: -13 (errno 13)

The test in question [2]:

SEC("tp_btf/cgroup_mkdir")
int BPF_PROG(test_percpu_helper, struct cgroup *cgrp, const char *path)
{
	struct cgroup_rstat_cpu *rstat;
	__u32 cpu;

	cpu = bpf_get_smp_processor_id();
	rstat = (struct cgroup_rstat_cpu *)bpf_per_cpu_ptr(cgrp->rstat_cpu, cpu);
	if (rstat) {
		/* READ_ONCE */
		*(volatile int *)rstat; // BPF verification fails here
	}

	return 0;
}

Any ideas about how to properly fix this?

Thanks.

[1] 
https://github.com/kernel-patches/bpf/actions/runs/15316839796/job/43125242673
[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/progs/btf_type_tag_percpu.c#n68

> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index 485b651869d9..6d177f770d28 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -344,10 +344,29 @@ struct cgroup_base_stat {
>    * frequency decreases the cost of each read.
>    *
>    * This struct hosts both the fields which implement the above -
> - * updated_children and updated_next - and the fields which track basic
> - * resource statistics on top of it - bsync, bstat and last_bstat.
> + * updated_children and updated_next.
>    */
>   struct cgroup_rstat_cpu {
> +	/*
> +	 * Child cgroups with stat updates on this cpu since the last read
> +	 * are linked on the parent's ->updated_children through
> +	 * ->updated_next.
> +	 *
> +	 * In addition to being more compact, singly-linked list pointing
> +	 * to the cgroup makes it unnecessary for each per-cpu struct to
> +	 * point back to the associated cgroup.
> +	 *
> +	 * Protected by per-cpu cgroup_rstat_cpu_lock.
> +	 */
> +	struct cgroup *updated_children;	/* terminated by self cgroup */
> +	struct cgroup *updated_next;		/* NULL iff not on the list */
> +};
> +
> +/*
> + * This struct hosts the fields which track basic resource statistics on
> + * top of it - bsync, bstat and last_bstat.
> + */
> +struct cgroup_rstat_base_cpu {
>   	/*
>   	 * ->bsync protects ->bstat.  These are the only fields which get
>   	 * updated in the hot path.
> @@ -374,20 +393,6 @@ struct cgroup_rstat_cpu {
>   	 * deltas to propagate to the per-cpu subtree_bstat.
>   	 */
>   	struct cgroup_base_stat last_subtree_bstat;
> -
> -	/*
> -	 * Child cgroups with stat updates on this cpu since the last read
> -	 * are linked on the parent's ->updated_children through
> -	 * ->updated_next.
> -	 *
> -	 * In addition to being more compact, singly-linked list pointing
> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
> -	 * point back to the associated cgroup.
> -	 *
> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
> -	 */
> -	struct cgroup *updated_children;	/* terminated by self cgroup */
> -	struct cgroup *updated_next;		/* NULL iff not on the list */
>   };
>   
>   struct cgroup_freezer_state {
> @@ -518,6 +523,7 @@ struct cgroup {
>   
>   	/* per-cpu recursive resource statistics */
>   	struct cgroup_rstat_cpu __percpu *rstat_cpu;
> +	struct cgroup_rstat_base_cpu __percpu *rstat_base_cpu;
>   	struct list_head rstat_css_list;
>   
>   	/*
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index ac2db99941ca..77349d07b117 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -161,10 +161,14 @@ static struct static_key_true *cgroup_subsys_on_dfl_key[] = {
>   };
>   #undef SUBSYS
>   
> -static DEFINE_PER_CPU(struct cgroup_rstat_cpu, cgrp_dfl_root_rstat_cpu);
> +static DEFINE_PER_CPU(struct cgroup_rstat_cpu, root_rstat_cpu);
> +static DEFINE_PER_CPU(struct cgroup_rstat_base_cpu, root_rstat_base_cpu);
>   
>   /* the default hierarchy */
> -struct cgroup_root cgrp_dfl_root = { .cgrp.rstat_cpu = &cgrp_dfl_root_rstat_cpu };
> +struct cgroup_root cgrp_dfl_root = {
> +	.cgrp.rstat_cpu = &root_rstat_cpu,
> +	.cgrp.rstat_base_cpu = &root_rstat_base_cpu,
> +};
>   EXPORT_SYMBOL_GPL(cgrp_dfl_root);
>   
>   /*
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 4bb587d5d34f..a20e3ab3f7d3 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -19,6 +19,12 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
>   	return per_cpu_ptr(cgrp->rstat_cpu, cpu);
>   }
>   
> +static struct cgroup_rstat_base_cpu *cgroup_rstat_base_cpu(
> +		struct cgroup *cgrp, int cpu)
> +{
> +	return per_cpu_ptr(cgrp->rstat_base_cpu, cpu);
> +}
> +
>   /*
>    * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
>    *
> @@ -351,12 +357,22 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>   			return -ENOMEM;
>   	}
>   
> +	if (!cgrp->rstat_base_cpu) {
> +		cgrp->rstat_base_cpu = alloc_percpu(struct cgroup_rstat_base_cpu);
> +		if (!cgrp->rstat_cpu) {
> +			free_percpu(cgrp->rstat_cpu);
> +			return -ENOMEM;
> +		}
> +	}
> +
>   	/* ->updated_children list is self terminated */
>   	for_each_possible_cpu(cpu) {
>   		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
> +		struct cgroup_rstat_base_cpu *rstatbc =
> +			cgroup_rstat_base_cpu(cgrp, cpu);
>   
>   		rstatc->updated_children = cgrp;
> -		u64_stats_init(&rstatc->bsync);
> +		u64_stats_init(&rstatbc->bsync);
>   	}
>   
>   	return 0;
> @@ -379,6 +395,8 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
>   
>   	free_percpu(cgrp->rstat_cpu);
>   	cgrp->rstat_cpu = NULL;
> +	free_percpu(cgrp->rstat_base_cpu);
> +	cgrp->rstat_base_cpu = NULL;
>   }
>   
>   void __init cgroup_rstat_boot(void)
> @@ -419,9 +437,9 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
>   
>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>   {
> -	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
> +	struct cgroup_rstat_base_cpu *rstatbc = cgroup_rstat_base_cpu(cgrp, cpu);
>   	struct cgroup *parent = cgroup_parent(cgrp);
> -	struct cgroup_rstat_cpu *prstatc;
> +	struct cgroup_rstat_base_cpu *prstatbc;
>   	struct cgroup_base_stat delta;
>   	unsigned seq;
>   
> @@ -431,15 +449,15 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>   
>   	/* fetch the current per-cpu values */
>   	do {
> -		seq = __u64_stats_fetch_begin(&rstatc->bsync);
> -		delta = rstatc->bstat;
> -	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
> +		seq = __u64_stats_fetch_begin(&rstatbc->bsync);
> +		delta = rstatbc->bstat;
> +	} while (__u64_stats_fetch_retry(&rstatbc->bsync, seq));
>   
>   	/* propagate per-cpu delta to cgroup and per-cpu global statistics */
> -	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
> +	cgroup_base_stat_sub(&delta, &rstatbc->last_bstat);
>   	cgroup_base_stat_add(&cgrp->bstat, &delta);
> -	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
> -	cgroup_base_stat_add(&rstatc->subtree_bstat, &delta);
> +	cgroup_base_stat_add(&rstatbc->last_bstat, &delta);
> +	cgroup_base_stat_add(&rstatbc->subtree_bstat, &delta);
>   
>   	/* propagate cgroup and per-cpu global delta to parent (unless that's root) */
>   	if (cgroup_parent(parent)) {
> @@ -448,73 +466,73 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
>   		cgroup_base_stat_add(&parent->bstat, &delta);
>   		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
>   
> -		delta = rstatc->subtree_bstat;
> -		prstatc = cgroup_rstat_cpu(parent, cpu);
> -		cgroup_base_stat_sub(&delta, &rstatc->last_subtree_bstat);
> -		cgroup_base_stat_add(&prstatc->subtree_bstat, &delta);
> -		cgroup_base_stat_add(&rstatc->last_subtree_bstat, &delta);
> +		delta = rstatbc->subtree_bstat;
> +		prstatbc = cgroup_rstat_base_cpu(parent, cpu);
> +		cgroup_base_stat_sub(&delta, &rstatbc->last_subtree_bstat);
> +		cgroup_base_stat_add(&prstatbc->subtree_bstat, &delta);
> +		cgroup_base_stat_add(&rstatbc->last_subtree_bstat, &delta);
>   	}
>   }
>   
> -static struct cgroup_rstat_cpu *
> +static struct cgroup_rstat_base_cpu *
>   cgroup_base_stat_cputime_account_begin(struct cgroup *cgrp, unsigned long *flags)
>   {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatbc;
>   
> -	rstatc = get_cpu_ptr(cgrp->rstat_cpu);
> -	*flags = u64_stats_update_begin_irqsave(&rstatc->bsync);
> -	return rstatc;
> +	rstatbc = get_cpu_ptr(cgrp->rstat_base_cpu);
> +	*flags = u64_stats_update_begin_irqsave(&rstatbc->bsync);
> +	return rstatbc;
>   }
>   
>   static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
> -						 struct cgroup_rstat_cpu *rstatc,
> +						 struct cgroup_rstat_base_cpu *rstatbc,
>   						 unsigned long flags)
>   {
> -	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
> +	u64_stats_update_end_irqrestore(&rstatbc->bsync, flags);
>   	cgroup_rstat_updated(cgrp, smp_processor_id());
> -	put_cpu_ptr(rstatc);
> +	put_cpu_ptr(rstatbc);
>   }
>   
>   void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec)
>   {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatbc;
>   	unsigned long flags;
>   
> -	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
> -	rstatc->bstat.cputime.sum_exec_runtime += delta_exec;
> -	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
> +	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
> +	rstatbc->bstat.cputime.sum_exec_runtime += delta_exec;
> +	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
>   }
>   
>   void __cgroup_account_cputime_field(struct cgroup *cgrp,
>   				    enum cpu_usage_stat index, u64 delta_exec)
>   {
> -	struct cgroup_rstat_cpu *rstatc;
> +	struct cgroup_rstat_base_cpu *rstatbc;
>   	unsigned long flags;
>   
> -	rstatc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
> +	rstatbc = cgroup_base_stat_cputime_account_begin(cgrp, &flags);
>   
>   	switch (index) {
>   	case CPUTIME_NICE:
> -		rstatc->bstat.ntime += delta_exec;
> +		rstatbc->bstat.ntime += delta_exec;
>   		fallthrough;
>   	case CPUTIME_USER:
> -		rstatc->bstat.cputime.utime += delta_exec;
> +		rstatbc->bstat.cputime.utime += delta_exec;
>   		break;
>   	case CPUTIME_SYSTEM:
>   	case CPUTIME_IRQ:
>   	case CPUTIME_SOFTIRQ:
> -		rstatc->bstat.cputime.stime += delta_exec;
> +		rstatbc->bstat.cputime.stime += delta_exec;
>   		break;
>   #ifdef CONFIG_SCHED_CORE
>   	case CPUTIME_FORCEIDLE:
> -		rstatc->bstat.forceidle_sum += delta_exec;
> +		rstatbc->bstat.forceidle_sum += delta_exec;
>   		break;
>   #endif
>   	default:
>   		break;
>   	}
>   
> -	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
> +	cgroup_base_stat_cputime_account_end(cgrp, rstatbc, flags);
>   }
>   
>   /*


