Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F6317CFC4
	for <lists+cgroups@lfdr.de>; Sat,  7 Mar 2020 20:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGTK2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Mar 2020 14:10:28 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.194]:33603 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726109AbgCGTK2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Mar 2020 14:10:28 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Mar 2020 14:10:27 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 672B5258B3
        for <cgroups@vger.kernel.org>; Sat,  7 Mar 2020 12:50:09 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AeWXjmx5FvBMdAeWXjgqMd; Sat, 07 Mar 2020 12:50:09 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=cdJUhpJ9Pa9hMkV8tSPPlMlDjcstmUN42XNs+4149mc=; b=kjemHEERjpOhgqUNV1PoQwASxW
        Ut9RkCP+dsp0csqjXkFTGj+WEc67K8UODsNEh7gAB/ZngzEMAtCERLK4fEOSFmi+Al0wMVgPVhMc/
        gdxGD30enQ1k6bneOksm+Tyj2XbbDOfoax1DBuwUcwyBPbqHIP+bZdIMKOLZbIVbBGjttQYGbAArD
        BemFtJ1wItdydpo4nvdywrkRYpjgyFfY9Ae6kTCSdJxNq6DBiIIfZBufKaYhqj/qrDSfb9DfDfaa2
        nMMMD5j9qDPhuPb4tkRhieLdMQ4t6DPNIvonJxpggwD45etls6+uShqD9fXIcOO482+fs6Jte5NP7
        wnBMlV5g==;
Received: from [201.162.241.123] (port=15271 helo=[192.168.43.132])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jAeWT-001v2v-AT; Sat, 07 Mar 2020 12:50:08 -0600
Subject: Re: [PATCH] mm: Use fallthrough;
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <d769ebee-b282-0b96-ce40-a1b57611415f@embeddedor.com>
Date:   Sat, 7 Mar 2020 12:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.123
X-Source-L: No
X-Exim-ID: 1jAeWT-001v2v-AT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.132]) [201.162.241.123]:15271
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



On 3/7/20 01:58, Joe Perches wrote:
> Convert the various /* fallthrough */ comments to the
> pseudo-keyword fallthrough;
> 
> Done via script:
> https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com/
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Reviewed-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

> ---
> 
> Might as well start with fallthrough conversions somewhere...
> 
>  mm/gup.c            | 2 +-
>  mm/hugetlb_cgroup.c | 6 +++---
>  mm/ksm.c            | 3 +--
>  mm/list_lru.c       | 2 +-
>  mm/memcontrol.c     | 2 +-
>  mm/mempolicy.c      | 3 ---
>  mm/mmap.c           | 5 ++---
>  mm/shmem.c          | 2 +-
>  mm/zsmalloc.c       | 2 +-
>  9 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f58929..4bfd753 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1072,7 +1072,7 @@ static long __get_user_pages(struct task_struct *tsk, struct mm_struct *mm,
>  				goto retry;
>  			case -EBUSY:
>  				ret = 0;
> -				/* FALLTHRU */
> +				fallthrough;
>  			case -EFAULT:
>  			case -ENOMEM:
>  			case -EHWPOISON:
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 790f63..7994eb8 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -468,14 +468,14 @@ static int hugetlb_cgroup_read_u64_max(struct seq_file *seq, void *v)
>  	switch (MEMFILE_ATTR(cft->private)) {
>  	case RES_RSVD_USAGE:
>  		counter = &h_cg->rsvd_hugepage[idx];
> -		/* Fall through. */
> +		fallthrough;
>  	case RES_USAGE:
>  		val = (u64)page_counter_read(counter);
>  		seq_printf(seq, "%llu\n", val * PAGE_SIZE);
>  		break;
>  	case RES_RSVD_LIMIT:
>  		counter = &h_cg->rsvd_hugepage[idx];
> -		/* Fall through. */
> +		fallthrough;
>  	case RES_LIMIT:
>  		val = (u64)counter->max;
>  		if (val == limit)
> @@ -515,7 +515,7 @@ static ssize_t hugetlb_cgroup_write(struct kernfs_open_file *of,
>  	switch (MEMFILE_ATTR(of_cft(of)->private)) {
>  	case RES_RSVD_LIMIT:
>  		rsvd = true;
> -		/* Fall through. */
> +		fallthrough;
>  	case RES_LIMIT:
>  		mutex_lock(&hugetlb_limit_mutex);
>  		ret = page_counter_set_max(
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 363ec8..a558da9 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2813,8 +2813,7 @@ static int ksm_memory_callback(struct notifier_block *self,
>  		 */
>  		ksm_check_stable_tree(mn->start_pfn,
>  				      mn->start_pfn + mn->nr_pages);
> -		/* fallthrough */
> -
> +		fallthrough;
>  	case MEM_CANCEL_OFFLINE:
>  		mutex_lock(&ksm_thread_mutex);
>  		ksm_run &= ~KSM_RUN_OFFLINE;
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 9e4a28..87b540f 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -223,7 +223,7 @@ __list_lru_walk_one(struct list_lru_node *nlru, int memcg_idx,
>  		switch (ret) {
>  		case LRU_REMOVED_RETRY:
>  			assert_spin_locked(&nlru->lock);
> -			/* fall through */
> +			fallthrough;
>  		case LRU_REMOVED:
>  			isolated++;
>  			nlru->nr_items--;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 1e1260..dfe191 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5756,7 +5756,7 @@ static int mem_cgroup_move_charge_pte_range(pmd_t *pmd,
>  		switch (get_mctgt_type(vma, addr, ptent, &target)) {
>  		case MC_TARGET_DEVICE:
>  			device = true;
> -			/* fall through */
> +			fallthrough;
>  		case MC_TARGET_PAGE:
>  			page = target.page;
>  			/*
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6d30379..45eb0a5 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  
>  	switch (p->mode) {
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		*nodes = p->v.nodes;
>  		break;
> @@ -2092,7 +2091,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  		break;
>  
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		*mask =  mempolicy->v.nodes;
>  		break;
> @@ -2359,7 +2357,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  
>  	switch (a->mode) {
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		return !!nodes_equal(a->v.nodes, b->v.nodes);
>  	case MPOL_PREFERRED:
> diff --git a/mm/mmap.c b/mm/mmap.c
> index f8ea04..60dc38 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1457,7 +1457,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			 * with MAP_SHARED to preserve backward compatibility.
>  			 */
>  			flags &= LEGACY_MAP_MASK;
> -			/* fall through */
> +			fallthrough;
>  		case MAP_SHARED_VALIDATE:
>  			if (flags & ~flags_mask)
>  				return -EOPNOTSUPP;
> @@ -1480,8 +1480,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>  			vm_flags |= VM_SHARED | VM_MAYSHARE;
>  			if (!(file->f_mode & FMODE_WRITE))
>  				vm_flags &= ~(VM_MAYWRITE | VM_SHARED);
> -
> -			/* fall through */
> +			fallthrough;
>  		case MAP_PRIVATE:
>  			if (!(file->f_mode & FMODE_READ))
>  				return -EACCES;
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d01d5b..1e9b377 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3992,7 +3992,7 @@ bool shmem_huge_enabled(struct vm_area_struct *vma)
>  			if (i_size >= HPAGE_PMD_SIZE &&
>  					i_size >> PAGE_SHIFT >= off)
>  				return true;
> -			/* fall through */
> +			fallthrough;
>  		case SHMEM_HUGE_ADVISE:
>  			/* TODO: implement fadvise() hints */
>  			return (vma->vm_flags & VM_HUGEPAGE);
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 2aa2d5..2f836a2b 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -424,7 +424,7 @@ static void *zs_zpool_map(void *pool, unsigned long handle,
>  	case ZPOOL_MM_WO:
>  		zs_mm = ZS_MM_WO;
>  		break;
> -	case ZPOOL_MM_RW: /* fall through */
> +	case ZPOOL_MM_RW:
>  	default:
>  		zs_mm = ZS_MM_RW;
>  		break;
> 
> 
