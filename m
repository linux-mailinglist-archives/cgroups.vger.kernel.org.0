Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCE8034A44
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 16:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfFDOXn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Jun 2019 10:23:43 -0400
Received: from foss.arm.com ([217.140.101.70]:45136 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbfFDOXn (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 4 Jun 2019 10:23:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E423341;
        Tue,  4 Jun 2019 07:23:43 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDBD23F690;
        Tue,  4 Jun 2019 07:23:40 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:23:38 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Qian Cai <cai@lca.pw>, rppt@linux.ibm.com
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, linux-mm@kvack.org, vdavydov.dev@gmail.com,
        hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] arm64/mm: fix a bogus GFP flag in pgd_alloc()
Message-ID: <20190604142338.GC24467@lakrids.cambridge.arm.com>
References: <1559656836-24940-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559656836-24940-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jun 04, 2019 at 10:00:36AM -0400, Qian Cai wrote:
> The commit "arm64: switch to generic version of pte allocation"
> introduced endless failures during boot like,
> 
> kobject_add_internal failed for pgd_cache(285:chronyd.service) (error:
> -2 parent: cgroup)
> 
> It turns out __GFP_ACCOUNT is passed to kernel page table allocations
> and then later memcg finds out those don't belong to any cgroup.

Mike, I understood from [1] that this wasn't expected to be a problem,
as the accounting should bypass kernel threads.

Was that assumption wrong, or is something different happening here?

> 
> backtrace:
>   kobject_add_internal
>   kobject_init_and_add
>   sysfs_slab_add+0x1a8
>   __kmem_cache_create
>   create_cache
>   memcg_create_kmem_cache
>   memcg_kmem_cache_create_func
>   process_one_work
>   worker_thread
>   kthread
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/arm64/mm/pgd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/pgd.c b/arch/arm64/mm/pgd.c
> index 769516cb6677..53c48f5c8765 100644
> --- a/arch/arm64/mm/pgd.c
> +++ b/arch/arm64/mm/pgd.c
> @@ -38,7 +38,7 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
>  	if (PGD_SIZE == PAGE_SIZE)
>  		return (pgd_t *)__get_free_page(gfp);
>  	else
> -		return kmem_cache_alloc(pgd_cache, gfp);
> +		return kmem_cache_alloc(pgd_cache, GFP_PGTABLE_KERNEL);

This is used to allocate PGDs for both user and kernel pagetables (e.g.
for the efi runtime services), so while this may fix the regression, I'm
not sure it's the right fix.

Do we need a separate pgd_alloc_kernel()?

Thanks,
Mark.

[1] https://lkml.kernel.org/r/20190505061956.GE15755@rapoport-lnx
