Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B4C190BAE
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgCXLAj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 07:00:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40556 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgCXLAi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 07:00:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so471134wro.7;
        Tue, 24 Mar 2020 04:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n793+N5lafHuxLCXbklTX9PGJ8abrUMy/bsZdO3BHXE=;
        b=L0ig301cruRhaztFjrNkXhQnVe8+eq9nPmks+6obXrOwdTaImMAkaYIcvOmrQqclLe
         gWHdtDBj9BPD23Ym8Mz051CenviwmcAV0AnF+K+dRLrU3wp66Vxcn5SyxGLvVBQD7YAB
         XnHVSr0U6HHrsrtW2tGhZo416YKNzF5AYa0onomM9TPW8nbIDMGML8wNHd2WwCtYwNyD
         cGTG2lhCDbPaU+5fx+ESf1zeMGNzcTVyOqZTRkxyOaKM9QzS5yf5QV367BJ6GFMBpx5f
         A5GrQ4PzC6+k3hrhpxpTPrKG4WaDMf4I+bSg5FBemUawB1vytLDuqiYhx9EwplXpFk6O
         ZDKg==
X-Gm-Message-State: ANhLgQ1ykI6r6Whe9bXi6vvdD5l6avKtk2hUOkH2EYAk6JepIgR411dd
        E6mffe1lUGtiGZYIqL/Bhh8=
X-Google-Smtp-Source: ADFU+vttJHbTykv3bsiyFteYS1kKC4oA4ArKrccVigs3ZQS+tWqcGmFS4TEdaOPdpYeOU3dYOVEB3Q==
X-Received: by 2002:a5d:6146:: with SMTP id y6mr36218034wrt.107.1585047636442;
        Tue, 24 Mar 2020 04:00:36 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id z21sm3790196wmf.28.2020.03.24.04.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 04:00:35 -0700 (PDT)
Date:   Tue, 24 Mar 2020 12:00:34 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Hui Zhu <teawater@gmail.com>
Cc:     hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, chris@chrisdown.name,
        tj@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324110034.GH19542@dhcp22.suse.cz>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585045916-27339-1-git-send-email-teawater@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 24-03-20 18:31:56, Hui Zhu wrote:
> /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> control if the application can use THP in system level.
> Sometime, we would not want an application use THP even if
> transparent_hugepage/enabled is set to "always" or "madvise" because
> thp may need more cpu and memory resources in some cases.

Could you specify that sometime by a real usecase in the memcg context
please?

> This commit add a new interface memory.transparent_hugepage_disabled
> in memcg.
> When it set to 1, the application inside the cgroup cannot use THP
> except dax.

Why should this interface differ from the global semantic. How does it
relate to the kcompactd. Your patch also doesn't seem to define this
knob to have hierarchical semantic. Why?

All that being said, this patch is lacking both proper justification and
the semantic is dubious to be honest. I have also say that I am not a
great fan. THP semantic is overly complex already and adding more on top
would require really strong usecase.

> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
> ---
>  include/linux/huge_mm.h    | 18 ++++++++++++++++--
>  include/linux/memcontrol.h |  2 ++
>  mm/memcontrol.c            | 42 ++++++++++++++++++++++++++++++++++++++++++
>  mm/shmem.c                 |  4 ++++
>  4 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 5aca3d1..fd81479 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -91,6 +91,16 @@ extern bool is_vma_temporary_stack(struct vm_area_struct *vma);
>  
>  extern unsigned long transparent_hugepage_flags;
>  
> +#ifdef CONFIG_MEMCG
> +extern bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma);
> +#else
> +static inline bool
> +memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * to be used on vmas which are known to support THP.
>   * Use transparent_hugepage_enabled otherwise
> @@ -106,8 +116,6 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	if (test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
>  		return false;
>  
> -	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> -		return true;
>  	/*
>  	 * For dax vmas, try to always use hugepage mappings. If the kernel does
>  	 * not support hugepages, fsdax mappings will fallback to PAGE_SIZE
> @@ -117,6 +125,12 @@ static inline bool __transparent_hugepage_enabled(struct vm_area_struct *vma)
>  	if (vma_is_dax(vma))
>  		return true;
>  
> +	if (memcg_transparent_hugepage_disabled(vma))
> +		return false;
> +
> +	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
> +		return true;
> +
>  	if (transparent_hugepage_flags &
>  				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
>  		return !!(vma->vm_flags & VM_HUGEPAGE);
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index a7a0a1a5..abc3142 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -320,6 +320,8 @@ struct mem_cgroup {
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	struct deferred_split deferred_split_queue;
> +
> +	bool transparent_hugepage_disabled;
>  #endif
>  
>  	struct mem_cgroup_per_node *nodeinfo[0];
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7a4bd8b..b6d91b6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5011,6 +5011,14 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	if (parent) {
>  		memcg->swappiness = mem_cgroup_swappiness(parent);
>  		memcg->oom_kill_disable = parent->oom_kill_disable;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		memcg->transparent_hugepage_disabled
> +			= parent->transparent_hugepage_disabled;
> +#endif
> +	} else {
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +		memcg->transparent_hugepage_disabled = false;
> +#endif
>  	}
>  	if (parent && parent->use_hierarchy) {
>  		memcg->use_hierarchy = true;
> @@ -6126,6 +6134,24 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
>  	return nbytes;
>  }
>  
> +static u64 transparent_hugepage_disabled_read(struct cgroup_subsys_state *css,
> +					      struct cftype *cft)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	return memcg->transparent_hugepage_disabled;
> +}
> +
> +static int transparent_hugepage_disabled_write(struct cgroup_subsys_state *css,
> +					       struct cftype *cft, u64 val)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +
> +	memcg->transparent_hugepage_disabled = !!val;
> +
> +	return 0;
> +}
> +
>  static struct cftype memory_files[] = {
>  	{
>  		.name = "current",
> @@ -6179,6 +6205,12 @@ static struct cftype memory_files[] = {
>  		.seq_show = memory_oom_group_show,
>  		.write = memory_oom_group_write,
>  	},
> +	{
> +		.name = "transparent_hugepage_disabled",
> +		.flags = CFTYPE_NOT_ON_ROOT,
> +		.read_u64 = transparent_hugepage_disabled_read,
> +		.write_u64 = transparent_hugepage_disabled_write,
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -6787,6 +6819,16 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	refill_stock(memcg, nr_pages);
>  }
>  
> +bool memcg_transparent_hugepage_disabled(struct vm_area_struct *vma)
> +{
> +	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(vma->vm_mm);
> +
> +	if (memcg && memcg->transparent_hugepage_disabled)
> +		return true;
> +
> +	return false;
> +}
> +
>  static int __init cgroup_memory(char *s)
>  {
>  	char *token;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index aad3ba7..253b63b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1810,6 +1810,10 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  		goto alloc_nohuge;
>  	if (shmem_huge == SHMEM_HUGE_DENY || sgp_huge == SGP_NOHUGE)
>  		goto alloc_nohuge;
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (memcg_transparent_hugepage_disabled(vma))
> +		goto alloc_nohuge;
> +#endif
>  	if (shmem_huge == SHMEM_HUGE_FORCE)
>  		goto alloc_huge;
>  	switch (sbinfo->huge) {
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
