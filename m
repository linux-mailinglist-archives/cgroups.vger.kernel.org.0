Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF6B1B03B7
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2020 10:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgDTIDG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 04:03:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33837 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDTIDF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 04:03:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id j1so5475729wrt.1;
        Mon, 20 Apr 2020 01:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R7PqN5/7b2AnqMI0774YCuHpXyuK4T9fpEJbWvpY8X4=;
        b=oFx0lzpZPooJpM+u6AbSsG3792hScLIIZ7cyJJinNoGSw8UnTWB3PBD6TVXzNjci3G
         D3YNxQk9Cnc0KOMciifVMB3bIkhhExh4+VP9/r1KZ3jCL1tFtdq1L2soqQQnKOdaYdOe
         pUQXpOLAIaF0v/IJsN9QEfg7y+ZgWXIMKprP2UgZzlm+4GCALY01Br+KI+9Ym9YA2ErB
         D9pZALjzRCqTlk7YkeIkAOMZGzWQPjHaeIF0uxYulijRhTazrswm2jFbyqBNnHB5m2TM
         tI9W5ws0EpyeDWbcqDujqnIBVMdwIBTx107CfAXpmu8u+AScojYdTxvB0B6IeFr9OSNy
         JkEQ==
X-Gm-Message-State: AGi0Pub4NSWpFvZoB5SNdu9SvyeRTkO7NfC488eooXYDipnmEhPb1nga
        pyoZr2QN/6d6yM2xbtWrB98=
X-Google-Smtp-Source: APiQypJv793GIJmkD4kxf+tXm6OVefWuHDONmtVBRPVmiLGEjmVTuVfXPCdhnI8BcYiGbZHched6Qw==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr14018678wru.293.1587369781652;
        Mon, 20 Apr 2020 01:03:01 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id l4sm105388wrv.60.2020.04.20.01.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:03:00 -0700 (PDT)
Date:   Mon, 20 Apr 2020 10:02:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: folding CONFIG_MEMCG_SWAP as default
Message-ID: <20200420080259.GH27314@dhcp22.suse.cz>
References: <1587216789-42342-1-git-send-email-alex.shi@linux.alibaba.com>
 <1587216789-42342-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587216789-42342-2-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 18-04-20 21:33:08, Alex Shi wrote:
> This patch fold MEMCG_SWAP feature into kernel as default function. With
> the next swapaccount removing patch, the swapout pages for each of memcg
> always be recorded into swap_cgroup.id. the cost as Johannes mentioned
> 
> "the overhead of tracking is tiny - 512k per G of swap (0.04%).'
> 
> With this record info, swapin don't have to add all readahead page
> into lru list before do memcg charge.

Why is this really an advantage. Please keep in mind that the changelog
really needs to have a self contained information. If this is a part of
larger changes be _expplicit_ about that.

This is especially important when you are changing a long standing default
behavior. The memory overhead of the swap tracking might be small from
todays perspective but we are not changing behavior just nilly willy. If
there is a really important follow up that would be impossible or too
clumsy without this change then make it clear because that would be
a strong argument to judge this patch.

Btw. I do know that you have referenced the respective discussion with
Johannes in the previous version of the patch but I really want to
stress out the importance of having the information in the changelog.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> ---
>  arch/arm/configs/omap2plus_defconfig        |  1 -
>  arch/arm64/configs/defconfig                |  1 -
>  arch/mips/configs/db1xxx_defconfig          |  1 -
>  arch/mips/configs/generic_defconfig         |  1 -
>  arch/mips/configs/loongson3_defconfig       |  1 -
>  arch/parisc/configs/generic-64bit_defconfig |  1 -
>  arch/powerpc/configs/powernv_defconfig      |  1 -
>  arch/powerpc/configs/pseries_defconfig      |  1 -
>  arch/s390/configs/debug_defconfig           |  1 -
>  arch/s390/configs/defconfig                 |  1 -
>  arch/sh/configs/sdk7786_defconfig           |  1 -
>  arch/sh/configs/urquell_defconfig           |  1 -
>  include/linux/memcontrol.h                  |  2 --
>  include/linux/swap.h                        | 27 --------------------------
>  include/linux/swap_cgroup.h                 | 30 -----------------------------
>  init/Kconfig                                | 20 -------------------
>  mm/Makefile                                 |  4 ++--
>  mm/memcontrol.c                             | 18 -----------------
>  18 files changed, 2 insertions(+), 111 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 3cc3ca5fa027..929cfc4c062a 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -10,7 +10,6 @@ CONFIG_IKCONFIG_PROC=y
>  CONFIG_LOG_BUF_SHIFT=16
>  CONFIG_CGROUPS=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_CFS_BANDWIDTH=y
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 24e534d85045..3854c6140a04 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -13,7 +13,6 @@ CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_PIDS=y
>  CONFIG_CGROUP_HUGETLB=y
> diff --git a/arch/mips/configs/db1xxx_defconfig b/arch/mips/configs/db1xxx_defconfig
> index e6f3e8e3da39..4604e826d03f 100644
> --- a/arch/mips/configs/db1xxx_defconfig
> +++ b/arch/mips/configs/db1xxx_defconfig
> @@ -9,7 +9,6 @@ CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_LOG_BUF_SHIFT=16
>  CONFIG_CGROUPS=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_CFS_BANDWIDTH=y
> diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
> index 714169e411cf..48e4e251779b 100644
> --- a/arch/mips/configs/generic_defconfig
> +++ b/arch/mips/configs/generic_defconfig
> @@ -3,7 +3,6 @@ CONFIG_NO_HZ_IDLE=y
>  CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CFS_BANDWIDTH=y
>  CONFIG_RT_GROUP_SCHED=y
> diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
> index 51675f5000d6..f91f49595100 100644
> --- a/arch/mips/configs/loongson3_defconfig
> +++ b/arch/mips/configs/loongson3_defconfig
> @@ -13,7 +13,6 @@ CONFIG_TASK_DELAY_ACCT=y
>  CONFIG_TASK_XACCT=y
>  CONFIG_TASK_IO_ACCOUNTING=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CPUSETS=y
>  CONFIG_SCHED_AUTOGROUP=y
> diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
> index 59561e04e659..fab4401dd9f6 100644
> --- a/arch/parisc/configs/generic-64bit_defconfig
> +++ b/arch/parisc/configs/generic-64bit_defconfig
> @@ -10,7 +10,6 @@ CONFIG_TASK_XACCT=y
>  CONFIG_TASK_IO_ACCOUNTING=y
>  CONFIG_CGROUPS=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_CGROUP_PIDS=y
>  CONFIG_CPUSETS=y
>  CONFIG_RELAY=y
> diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
> index df8bdbaa5d8f..c60c3a4125f7 100644
> --- a/arch/powerpc/configs/powernv_defconfig
> +++ b/arch/powerpc/configs/powernv_defconfig
> @@ -17,7 +17,6 @@ CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_CGROUPS=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_CGROUP_FREEZER=y
>  CONFIG_CPUSETS=y
> diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
> index 0bea4d3ffb85..426244f491ec 100644
> --- a/arch/powerpc/configs/pseries_defconfig
> +++ b/arch/powerpc/configs/pseries_defconfig
> @@ -16,7 +16,6 @@ CONFIG_LOG_CPU_MAX_BUF_SHIFT=13
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_CGROUPS=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_CGROUP_FREEZER=y
>  CONFIG_CPUSETS=y
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 46038bc58c9e..864b32403673 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -14,7 +14,6 @@ CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CFS_BANDWIDTH=y
>  CONFIG_RT_GROUP_SCHED=y
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 7cd0648c1f4e..991e60d7c307 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -13,7 +13,6 @@ CONFIG_IKCONFIG=y
>  CONFIG_IKCONFIG_PROC=y
>  CONFIG_NUMA_BALANCING=y
>  CONFIG_MEMCG=y
> -CONFIG_MEMCG_SWAP=y
>  CONFIG_BLK_CGROUP=y
>  CONFIG_CFS_BANDWIDTH=y
>  CONFIG_RT_GROUP_SCHED=y
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
> index 7fa116b436c3..4a1d19068a8d 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -17,7 +17,6 @@ CONFIG_CPUSETS=y
>  # CONFIG_PROC_PID_CPUSET is not set
>  CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_MEMCG=y
> -CONFIG_CGROUP_MEMCG_SWAP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_RT_GROUP_SCHED=y
>  CONFIG_BLK_CGROUP=y
> diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
> index cb2f56468fe0..be478f3148f2 100644
> --- a/arch/sh/configs/urquell_defconfig
> +++ b/arch/sh/configs/urquell_defconfig
> @@ -14,7 +14,6 @@ CONFIG_CPUSETS=y
>  # CONFIG_PROC_PID_CPUSET is not set
>  CONFIG_CGROUP_CPUACCT=y
>  CONFIG_CGROUP_MEMCG=y
> -CONFIG_CGROUP_MEMCG_SWAP=y
>  CONFIG_CGROUP_SCHED=y
>  CONFIG_RT_GROUP_SCHED=y
>  CONFIG_BLK_DEV_INITRD=y
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 1b4150ff64be..45842ed8ba53 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -569,9 +569,7 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  					    struct mem_cgroup *oom_domain);
>  void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
>  
> -#ifdef CONFIG_MEMCG_SWAP
>  extern int do_swap_account;
> -#endif
>  
>  struct mem_cgroup *lock_page_memcg(struct page *page);
>  void __unlock_page_memcg(struct mem_cgroup *memcg);
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index eae48a3896e8..5627fb8ca827 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -652,38 +652,11 @@ static inline void mem_cgroup_throttle_swaprate(struct mem_cgroup *memcg,
>  }
>  #endif
>  
> -#ifdef CONFIG_MEMCG_SWAP
>  extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
>  extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
>  extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
>  extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
>  extern bool mem_cgroup_swap_full(struct page *page);
> -#else
> -static inline void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
> -{
> -}
> -
> -static inline int mem_cgroup_try_charge_swap(struct page *page,
> -					     swp_entry_t entry)
> -{
> -	return 0;
> -}
> -
> -static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
> -					    unsigned int nr_pages)
> -{
> -}
> -
> -static inline long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
> -{
> -	return get_nr_swap_pages();
> -}
> -
> -static inline bool mem_cgroup_swap_full(struct page *page)
> -{
> -	return vm_swap_full();
> -}
> -#endif
>  
>  #endif /* __KERNEL__*/
>  #endif /* _LINUX_SWAP_H */
> diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
> index a12dd1c3966c..5ac87b3b0e08 100644
> --- a/include/linux/swap_cgroup.h
> +++ b/include/linux/swap_cgroup.h
> @@ -4,8 +4,6 @@
>  
>  #include <linux/swap.h>
>  
> -#ifdef CONFIG_MEMCG_SWAP
> -
>  extern unsigned short swap_cgroup_cmpxchg(swp_entry_t ent,
>  					unsigned short old, unsigned short new);
>  extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
> @@ -14,32 +12,4 @@ extern unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
>  extern int swap_cgroup_swapon(int type, unsigned long max_pages);
>  extern void swap_cgroup_swapoff(int type);
>  
> -#else
> -
> -static inline
> -unsigned short swap_cgroup_record(swp_entry_t ent, unsigned short id,
> -				  unsigned int nr_ents)
> -{
> -	return 0;
> -}
> -
> -static inline
> -unsigned short lookup_swap_cgroup_id(swp_entry_t ent)
> -{
> -	return 0;
> -}
> -
> -static inline int
> -swap_cgroup_swapon(int type, unsigned long max_pages)
> -{
> -	return 0;
> -}
> -
> -static inline void swap_cgroup_swapoff(int type)
> -{
> -	return;
> -}
> -
> -#endif /* CONFIG_MEMCG_SWAP */
> -
>  #endif /* __LINUX_SWAP_CGROUP_H */
> diff --git a/init/Kconfig b/init/Kconfig
> index 9e22ee8fbd75..3b09c71e9b57 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -834,26 +834,6 @@ config MEMCG
>  	help
>  	  Provides control over the memory footprint of tasks in a cgroup.
>  
> -config MEMCG_SWAP
> -	bool "Swap controller"
> -	depends on MEMCG && SWAP
> -	help
> -	  Provides control over the swap space consumed by tasks in a cgroup.
> -
> -config MEMCG_SWAP_ENABLED
> -	bool "Swap controller enabled by default"
> -	depends on MEMCG_SWAP
> -	default y
> -	help
> -	  Memory Resource Controller Swap Extension comes with its price in
> -	  a bigger memory consumption. General purpose distribution kernels
> -	  which want to enable the feature but keep it disabled by default
> -	  and let the user enable it by swapaccount=1 boot command line
> -	  parameter should have this option unselected.
> -	  For those who want to have the feature enabled by default should
> -	  select this option (if, for some reason, they need to disable it
> -	  then swapaccount=0 does the trick).
> -
>  config MEMCG_KMEM
>  	bool
>  	depends on MEMCG && !SLOB
> diff --git a/mm/Makefile b/mm/Makefile
> index fccd3756b25f..812c08323355 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -58,7 +58,8 @@ ifdef CONFIG_MMU
>  	obj-$(CONFIG_ADVISE_SYSCALLS)	+= madvise.o
>  endif
>  
> -obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o
> +obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o swap_slots.o \
> +			   swap_cgroup.o
>  obj-$(CONFIG_FRONTSWAP)	+= frontswap.o
>  obj-$(CONFIG_ZSWAP)	+= zswap.o
>  obj-$(CONFIG_HAS_DMA)	+= dmapool.o
> @@ -80,7 +81,6 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> -obj-$(CONFIG_MEMCG_SWAP) += swap_cgroup.o
>  obj-$(CONFIG_CGROUP_HUGETLB) += hugetlb_cgroup.o
>  obj-$(CONFIG_GUP_BENCHMARK) += gup_benchmark.o
>  obj-$(CONFIG_MEMORY_FAILURE) += memory-failure.o
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5beea03dd58a..446141b6597a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -82,11 +82,7 @@
>  static bool cgroup_memory_nokmem;
>  
>  /* Whether the swap controller is active */
> -#ifdef CONFIG_MEMCG_SWAP
>  int do_swap_account __read_mostly;
> -#else
> -#define do_swap_account		0
> -#endif
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
> @@ -3020,7 +3016,6 @@ void mem_cgroup_split_huge_fixup(struct page *head)
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -#ifdef CONFIG_MEMCG_SWAP
>  /**
>   * mem_cgroup_move_swap_account - move swap charge and swap_cgroup's record.
>   * @entry: swap entry to be moved
> @@ -3050,13 +3045,6 @@ static int mem_cgroup_move_swap_account(swp_entry_t entry,
>  	}
>  	return -EINVAL;
>  }
> -#else
> -static inline int mem_cgroup_move_swap_account(swp_entry_t entry,
> -				struct mem_cgroup *from, struct mem_cgroup *to)
> -{
> -	return -EINVAL;
> -}
> -#endif
>  
>  static DEFINE_MUTEX(memcg_max_mutex);
>  
> @@ -6936,7 +6924,6 @@ static int __init mem_cgroup_init(void)
>  }
>  subsys_initcall(mem_cgroup_init);
>  
> -#ifdef CONFIG_MEMCG_SWAP
>  static struct mem_cgroup *mem_cgroup_id_get_online(struct mem_cgroup *memcg)
>  {
>  	while (!refcount_inc_not_zero(&memcg->id.ref)) {
> @@ -7137,11 +7124,7 @@ bool mem_cgroup_swap_full(struct page *page)
>  }
>  
>  /* for remember boot option*/
> -#ifdef CONFIG_MEMCG_SWAP_ENABLED
>  static int really_do_swap_account __initdata = 1;
> -#else
> -static int really_do_swap_account __initdata;
> -#endif
>  
>  static int __init enable_swap_account(char *s)
>  {
> @@ -7257,4 +7240,3 @@ static int __init mem_cgroup_swap_init(void)
>  }
>  subsys_initcall(mem_cgroup_swap_init);
>  
> -#endif /* CONFIG_MEMCG_SWAP */
> -- 
> 1.8.3.1

-- 
Michal Hocko
SUSE Labs
