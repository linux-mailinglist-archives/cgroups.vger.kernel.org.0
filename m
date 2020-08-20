Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF2D24C11F
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHTO7G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 10:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHTO67 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 10:58:59 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2A4C061385
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 07:58:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so1383352qth.5
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ET2XNn7lo6854zHDsZgOcJetJM+mPFVXCCN5RTBo4Y4=;
        b=e3fL0rOPM9Az7uh5AHamHJ50dIupBoi/OfZc/qL/TLDmvBdn4eeyFTpZXeE4C0sF6L
         a417LcbqRavsf/rTuhY+Mc00F7D7pOd6frm1H1x3mXpjAp9yaPwDI1H5wLO+vDr7lLqa
         RCcPulhFgDj7yKuI+1YHyY5My5b/SeTxEZw7x/ov/qPgGEG+8KNIl1io3YEM9SynRaK1
         6l2M6W95Ki8cgKrGfCSoWJaZfyxovqQKqT3/EzzaP0j4TxdsWgJMbJJmLCueu3jDTCMe
         tIGAzlr2ANoNAn5si8f3rjdhN964mWxgzoZqqXlb4Jmd1rxt8FCSHPl4CVG4HqGYnEf7
         LOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ET2XNn7lo6854zHDsZgOcJetJM+mPFVXCCN5RTBo4Y4=;
        b=JvGS4u8+U6rmTy/UuyKzjuP3x4pwbA2D32IlNgHqtoZRPjp5Flk93YQyjohQZqs3/Z
         J5pTtB88XQMrlCxYdr4+u/VYvrMcQWMuKT84//bMWow6JObj3dFX4TZUHW1x6+ar8x+4
         glt/K8wLQfykLcesZnZfswDLtSI+LcFk8Fi/rnwnIny9QOWnOg3oRIUjIVvqtSbZvXBg
         JjNO54hWzWCC/wNd3bgwOHEbdfgxjGtZ5BtIlHDjsmHhoq6qIKixe9oOAxLYjfYa3rPv
         XK3IsHttszoPXiu9kYfvmrz8FrtYQgLb1BF43/huz/hlsk/BSTP7T9A9D37w9Se4+err
         H6aw==
X-Gm-Message-State: AOAM530ShPO7p7JLIXIxhI3eF3lEOnJqmLI3Ghs6OUXWYRdBxiU3dHkN
        sklz8SrewZgaoPoM35N5qgif9A==
X-Google-Smtp-Source: ABdhPJxWGGOSspYzql2tmJck2qZCfnXfYvAHgccBUHwOtRGUHK7NlTlGLG/OArJVybgph5qV0SdEEw==
X-Received: by 2002:ac8:35f9:: with SMTP id l54mr3105281qtb.25.1597935538466;
        Thu, 20 Aug 2020 07:58:58 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n85sm2428135qkn.80.2020.08.20.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 07:58:57 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:58:51 -0400
From:   Qian Cai <cai@lca.pw>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200820145850.GA4622@lca.pw>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> Since readahead page is charged on memcg too, in theory we don't have to
> check this exception now. Before safely remove them all, add a warning
> for the unexpected !memcg.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

This will trigger,

[ 1863.916499] LTP: starting move_pages12
[ 1863.946520] page:000000008ccc1062 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd3c0
[ 1863.946553] head:000000008ccc1062 order:5 compound_mapcount:0 compound_pincount:0
[ 1863.946568] anon flags: 0x7fff800001000d(locked|uptodate|dirty|head)
[ 1863.946584] raw: 007fff800001000d c000000016ebfcd8 c000000016ebfcd8 c000001feaf46d59
[ 1863.946609] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[ 1863.946632] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
[ 1863.946669] ------------[ cut here ]------------
[ 1863.946694] WARNING: CPU: 16 PID: 35307 at mm/memcontrol.c:6908 mem_cgroup_migrate+0x5f8/0x610
[ 1863.946708] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod bnx2x tg3 ahci libahci libphy mdio firmware_class libata dm_mirror dm_region_hash dm_log dm_mod
[ 1863.946801] CPU: 16 PID: 35307 Comm: move_pages12 Not tainted 5.9.0-rc1-next-20200820 #4
[ 1863.946834] NIP:  c0000000003fcb48 LR: c0000000003fcb38 CTR: 0000000000000000
[ 1863.946856] REGS: c000000016ebf6f0 TRAP: 0700   Not tainted  (5.9.0-rc1-next-20200820)
[ 1863.946879] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28242882  XER: 00000000
[ 1863.946915] CFAR: c00000000032c644 IRQMASK: 0 
               GPR00: c0000000003fcb38 c000000016ebf980 c000000005923200 0000000000000031 
               GPR04: 0000000000000000 0000000000000000 0000000000000027 c000001ffd727190 
               GPR08: 0000000000000023 0000000000000001 c0000000058f3200 0000000000000001 
               GPR12: 0000000000002000 c000001ffffe3800 c000000000b26a68 0000000000000000 
               GPR16: c000000016ebfc20 c000000016ebfcd8 0000000000000020 0000000000000001 
               GPR20: c00c00080724f000 c0000000003c8770 0000000000000000 c000000016ebfcd0 
               GPR24: 0000000000000000 fffffffffffffff5 0000000000000002 0000000000000000 
               GPR28: 0000000000000000 0000000000000001 0000000000000000 c00c000007f4f000 
[ 1863.947142] NIP [c0000000003fcb48] mem_cgroup_migrate+0x5f8/0x610
[ 1863.947164] LR [c0000000003fcb38] mem_cgroup_migrate+0x5e8/0x610
[ 1863.947185] Call Trace:
[ 1863.947203] [c000000016ebf980] [c0000000003fcb38] mem_cgroup_migrate+0x5e8/0x610 (unreliable)
[ 1863.947241] [c000000016ebf9c0] [c0000000003c9080] migrate_page_states+0x4e0/0xce0
[ 1863.947274] [c000000016ebf9f0] [c0000000003cbbec] migrate_page+0x8c/0x120
[ 1863.947307] [c000000016ebfa30] [c0000000003ccf10] move_to_new_page+0x190/0x670
[ 1863.947341] [c000000016ebfaf0] [c0000000003ced08] migrate_pages+0xfb8/0x1880
[ 1863.947365] [c000000016ebfc00] [c0000000003cf670] move_pages_and_store_status.isra.45+0xa0/0x160
[ 1863.947399] [c000000016ebfc80] [c0000000003cfef4] sys_move_pages+0x7c4/0xed0
[ 1863.947434] [c000000016ebfdc0] [c00000000002c678] system_call_exception+0xf8/0x1d0
[ 1863.947459] [c000000016ebfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 1863.947481] Instruction dump:
[ 1863.947502] 7fc3f378 4bfee82d 7c0802a6 3c82fb20 7fe3fb78 38844fc8 f8010050 4bf2fad5 
[ 1863.947527] 60000000 39200001 3d42fffd 992a82fb <0fe00000> e8010050 eb810020 7c0803a6 
[ 1863.947563] CPU: 16 PID: 35307 Comm: move_pages12 Not tainted 5.9.0-rc1-next-20200820 #4
[ 1863.947594] Call Trace:
[ 1863.947615] [c000000016ebf4d0] [c0000000006f6008] dump_stack+0xfc/0x174 (unreliable)
[ 1863.947642] [c000000016ebf520] [c0000000000c9004] __warn+0xc4/0x14c
[ 1863.947665] [c000000016ebf5b0] [c0000000006f4b68] report_bug+0x108/0x1f0
[ 1863.947689] [c000000016ebf650] [c0000000000234f4] program_check_exception+0x104/0x2e0
[ 1863.947724] [c000000016ebf680] [c000000000009664] program_check_common_virt+0x2c4/0x310
[ 1863.947751] --- interrupt: 700 at mem_cgroup_migrate+0x5f8/0x610
                   LR = mem_cgroup_migrate+0x5e8/0x610
[ 1863.947786] [c000000016ebf9c0] [c0000000003c9080] migrate_page_states+0x4e0/0xce0
[ 1863.947810] [c000000016ebf9f0] [c0000000003cbbec] migrate_page+0x8c/0x120
[ 1863.947843] [c000000016ebfa30] [c0000000003ccf10] move_to_new_page+0x190/0x670
[ 1863.947867] [c000000016ebfaf0] [c0000000003ced08] migrate_pages+0xfb8/0x1880
[ 1863.947901] [c000000016ebfc00] [c0000000003cf670] move_pages_and_store_status.isra.45+0xa0/0x160
[ 1863.947936] [c000000016ebfc80] [c0000000003cfef4] sys_move_pages+0x7c4/0xed0
[ 1863.947969] [c000000016ebfdc0] [c00000000002c678] system_call_exception+0xf8/0x1d0
[ 1863.948002] [c000000016ebfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
[ 1863.948034] irq event stamp: 410
[ 1863.948054] hardirqs last  enabled at (409): [<c000000000184564>] console_unlock+0x6b4/0x990
[ 1863.948092] hardirqs last disabled at (410): [<c00000000000965c>] program_check_common_virt+0x2bc/0x310
[ 1863.948126] softirqs last  enabled at (0): [<c0000000000c59a8>] copy_process+0x788/0x1950
[ 1863.948229] softirqs last disabled at (0): [<0000000000000000>] 0x0
[ 1863.948316] ---[ end trace 74f8f4df751b0259 ]---

> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmdebug.h | 13 +++++++++++++
>  mm/memcontrol.c         | 15 ++++++++-------
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> index 2ad72d2c8cc5..4ed52879ce55 100644
> --- a/include/linux/mmdebug.h
> +++ b/include/linux/mmdebug.h
> @@ -37,6 +37,18 @@
>  			BUG();						\
>  		}							\
>  	} while (0)
> +#define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
> +	static bool __section(.data.once) __warned;			\
> +	int __ret_warn_once = !!(cond);					\
> +									\
> +	if (unlikely(__ret_warn_once && !__warned)) {			\
> +		dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
> +		__warned = true;					\
> +		WARN_ON(1);						\
> +	}								\
> +	unlikely(__ret_warn_once);					\
> +})
> +
>  #define VM_WARN_ON(cond) (void)WARN_ON(cond)
>  #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
>  #define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
> @@ -48,6 +60,7 @@
>  #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
>  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> +#define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
>  #endif
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 130093bdf74b..299382fc55a9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1322,10 +1322,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	}
>  
>  	memcg = page->mem_cgroup;
> -	/*
> -	 * Swapcache readahead pages are added to the LRU - and
> -	 * possibly migrated - before they are charged.
> -	 */
> +	/* Readahead page is charged too, to see if other page uncharged */
> +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
>  	if (!memcg)
>  		memcg = root_mem_cgroup;
>  
> @@ -6906,8 +6904,9 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
>  	if (newpage->mem_cgroup)
>  		return;
>  
> -	/* Swapcache readahead pages can get replaced before being charged */
>  	memcg = oldpage->mem_cgroup;
> +	/* Readahead page is charged too, to see if other page uncharged */
> +	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
>  	if (!memcg)
>  		return;
>  
> @@ -7104,7 +7103,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  
>  	memcg = page->mem_cgroup;
>  
> -	/* Readahead page, never charged */
> +	/* Readahead page is charged too, to see if other page uncharged */
> +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
>  	if (!memcg)
>  		return;
>  
> @@ -7168,7 +7168,8 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
>  
>  	memcg = page->mem_cgroup;
>  
> -	/* Readahead page, never charged */
> +	/* Readahead page is charged too, to see if other page uncharged */
> +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
>  	if (!memcg)
>  		return 0;
>  
> -- 
> 1.8.3.1
> 
> 
