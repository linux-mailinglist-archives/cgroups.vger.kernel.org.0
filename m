Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E425002C
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 16:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHXOwL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbgHXOwH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 10:52:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD475C061575
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 07:52:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so7621799qka.3
        for <cgroups@vger.kernel.org>; Mon, 24 Aug 2020 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P2gF7CEfSZqekGdtAvzPs99aEJUMm7+McrP8NpFEMwQ=;
        b=ZHlMoF9q2W/ayrsui7VEK6dh7Lr/f/+exjmaZhag2+clowWjBlF1BkEB1uYPtnT0q1
         zhGlggZnhPZ3gpdWpQN2SsUAQYHZo7WKwvNxQnoZF1dilZcxci+6MsK8ry2gEQC/pOeQ
         YaklW4gEvbYuEILWMrTqnELlAGCxMgW19wAR+IIjw3pD7yYpU7PQzudD6XOVlWHbnsvI
         NZiX7aqU+kTGyw/2tYdtCai0YNGWAsztea36IM/XjWvVtzlz9CzIFFXXULOCJHcgFOVq
         d60TcPac0rAFjoozPKasOo8oh0hxK3kKPob9nvGF7qd3+FeJxEPZ6pqq6sBlmhZluwRn
         1g+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P2gF7CEfSZqekGdtAvzPs99aEJUMm7+McrP8NpFEMwQ=;
        b=r6EB6oWcLVY0gT8DA8ZaNulI2Ej4gGf/wiiKeIFnk6/lmiAfDaFHs+MV0v8YqnN/VG
         rH3j4xNNsPADNzp7cffnbQB580P78viNGpOKZo4Wjd0tj8UtC9YIcyBnjPoMwLjfTmbK
         6t3MNl2WM6I3TwXQUC695tk9qkxHNnbmnOSBVFErRjM14KiotTeX30JYoMxktPggTZ7t
         2ZnO0aSXYwCeaC7YeR3cCLVARnd9bHEGzA+uHA11bBy9nuMSPWpa0JOacGaNm9D9CLU2
         zRojul+MdGQMBpCwPrlgJGSzwIL3a5NWq/mfff8d8kleH6HsyS24reqTwjBwyzbQmiHU
         7DZw==
X-Gm-Message-State: AOAM5309U79oZ4am0EthGfU8bYnevBPbE8N6T8zhFMGTmGfHDJT+nUOE
        WeRZF5meNV7Kxk7qK5IDfo65sA==
X-Google-Smtp-Source: ABdhPJzOZ/cb3v5mFP3GjNZ9CUSXslM7T9KivnNwY2sOUna2jUftQKid/qQcEMUTszgbH8rXFcA5EQ==
X-Received: by 2002:a05:620a:4051:: with SMTP id i17mr2451108qko.457.1598280725812;
        Mon, 24 Aug 2020 07:52:05 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q4sm9574362qkm.78.2020.08.24.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:52:04 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:52:02 -0400
From:   Qian Cai <cai@lca.pw>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200824145201.GB4337@lca.pw>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820145850.GA4622@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 10:58:50AM -0400, Qian Cai wrote:
> On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > Since readahead page is charged on memcg too, in theory we don't have to
> > check this exception now. Before safely remove them all, add a warning
> > for the unexpected !memcg.
> > 
> > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> This will trigger,

Andrew, Stephen, can you drop this series for now? I did manage to trigger this
warning on all arches, powerpc, x86 and arm64 (below).

[ 7380.751929][T73938] WARNING: CPU: 160 PID: 73938 at mm/memcontrol.c:6908 mem_cgroup_migrate+0x5a4/0x6d8
[ 7380.761317][T73938] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_type1 vfio loop processor efivarfs ip_tables x_tables sd_mod ahci libahci mlx5_core firmware_class libata dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 7380.783242][T73938] CPU: 160 PID: 73938 Comm: move_pages12 Tainted: G           O L    5.9.0-rc2-next-20200824 #1
[ 7380.793499][T73938] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.15 05/08/2020
[ 7380.803932][T73938] pstate: 00400009 (nzcv daif +PAN -UAO BTYPE=--)
[ 7380.810196][T73938] pc : mem_cgroup_migrate+0x5a4/0x6d8
[ 7380.815419][T73938] lr : mem_cgroup_migrate+0x59c/0x6d8
[ 7380.820641][T73938] sp : ffff008de9d0f6a0
[ 7380.824647][T73938] x29: ffff008de9d0f6a0 x28: 0000000000000002 
[ 7380.830661][T73938] x27: ffffffe022880018 x26: 1ffffffc04510003 
[ 7380.836674][T73938] x25: 0000000000000001 x24: 0000000000000001 
[ 7380.842687][T73938] x23: ffffffe003280038 x22: 1ffffffc00650007 
[ 7380.848701][T73938] x21: 0000000000000000 x20: ffffa0001703692c 
[ 7380.854714][T73938] x19: ffffffe022880000 x18: 0000000000000000 
[ 7380.860726][T73938] x17: 0000000000000000 x16: 0000000000000000 
[ 7380.866738][T73938] x15: 0000000000000000 x14: 0000000000000001 
[ 7380.872751][T73938] x13: ffff8011cf16f0ff x12: 1fffe011cf16f0fe 
[ 7380.878764][T73938] x11: 1fffe011cf16f0fe x10: ffff8011cf16f0fe 
[ 7380.884777][T73938] x9 : dfffa00000000000 x8 : ffff008e78b787f7 
[ 7380.890789][T73938] x7 : 0000000000000001 x6 : ffff8011cf16f0ff 
[ 7380.896802][T73938] x5 : ffff8011cf16f0ff x4 : ffff8011cf16f0ff 
[ 7380.902815][T73938] x3 : 1fffe011c1a4ae72 x2 : 1ffffffc04510007 
[ 7380.908828][T73938] x1 : 53d80e6b46c19e00 x0 : 0000000000000001 
[ 7380.914842][T73938] Call trace:
[ 7380.917982][T73938]  mem_cgroup_migrate+0x5a4/0x6d8
[ 7380.922862][T73938]  migrate_page_states+0x938/0x17c0
[ 7380.927911][T73938]  migrate_page_copy+0x6c0/0x1018
[ 7380.932787][T73938]  migrate_page+0xe0/0x1a0
[ 7380.937055][T73938]  move_to_new_page+0x2b0/0x9e8
[ 7380.941757][T73938]  migrate_pages+0x1650/0x23a0
[ 7380.946373][T73938]  move_pages_and_store_status.isra.40+0xe4/0x170
[ 7380.952638][T73938]  do_pages_move+0x484/0xb88
[ 7380.957079][T73938]  __arm64_sys_move_pages+0x3a8/0x7d0
[ 7380.962314][T73938]  do_el0_svc+0x124/0x228
[ 7380.966502][T73938]  el0_sync_handler+0x260/0x410
[ 7380.971204][T73938]  el0_sync+0x140/0x180
[ 7380.975213][T73938] CPU: 160 PID: 73938 Comm: move_pages12 Tainted: G           O L    5.9.0-rc2-next-20200824 #1
[ 7380.985469][T73938] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.15 05/08/2020
[ 7380.995898][T73938] Call trace:
[ 7380.999041][T73938]  dump_backtrace+0x0/0x398
[ 7381.003396][T73938]  show_stack+0x14/0x20
[ 7381.007412][T73938]  dump_stack+0x140/0x1c8
[ 7381.011604][T73938]  __warn+0x23c/0x2c8
[ 7381.015439][T73938]  report_bug+0x18c/0x2a8
[ 7381.019621][T73938]  bug_handler+0x34/0x88
[ 7381.023715][T73938]  brk_handler+0x138/0x240
[ 7381.027987][T73938]  do_debug_exception+0x138/0x544
[ 7381.032862][T73938]  el1_sync_handler+0x13c/0x1b8
[ 7381.037564][T73938]  el1_sync+0x7c/0x100
[ 7381.041484][T73938]  mem_cgroup_migrate+0x5a4/0x6d8
[ 7381.046359][T73938]  migrate_page_states+0x938/0x17c0
[ 7381.051408][T73938]  migrate_page_copy+0x6c0/0x1018
[ 7381.056283][T73938]  migrate_page+0xe0/0x1a0
[ 7381.060551][T73938]  move_to_new_page+0x2b0/0x9e8
[ 7381.065252][T73938]  migrate_pages+0x1650/0x23a0
[ 7381.069867][T73938]  move_pages_and_store_status.isra.40+0xe4/0x170
[ 7381.076131][T73938]  do_pages_move+0x484/0xb88
[ 7381.080573][T73938]  __arm64_sys_move_pages+0x3a8/0x7d0
[ 7381.085796][T73938]  do_el0_svc+0x124/0x228
[ 7381.089977][T73938]  el0_sync_handler+0x260/0x410
[ 7381.094678][T73938]  el0_sync+0x140/0x180
[ 7381.098684][T73938] irq event stamp: 470
[ 7381.102614][T73938] hardirqs last  enabled at (469): [<ffffa000103b5b5c>] console_unlock+0x7f4/0xf10
[ 7381.111745][T73938] hardirqs last disabled at (470): [<ffffa000101cd934>] do_debug_exception+0x304/0x544
[ 7381.121222][T73938] softirqs last  enabled at (408): [<ffffa000101a1b50>] efi_header_end+0xb50/0x14d4
[ 7381.130448][T73938] softirqs last disabled at (403): [<ffffa0001028df98>] irq_exit+0x440/0x510

== powerpc ==

> 
> [ 1863.916499] LTP: starting move_pages12
> [ 1863.946520] page:000000008ccc1062 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd3c0
> [ 1863.946553] head:000000008ccc1062 order:5 compound_mapcount:0 compound_pincount:0
> [ 1863.946568] anon flags: 0x7fff800001000d(locked|uptodate|dirty|head)
> [ 1863.946584] raw: 007fff800001000d c000000016ebfcd8 c000000016ebfcd8 c000001feaf46d59
> [ 1863.946609] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> [ 1863.946632] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> [ 1863.946669] ------------[ cut here ]------------
> [ 1863.946694] WARNING: CPU: 16 PID: 35307 at mm/memcontrol.c:6908 mem_cgroup_migrate+0x5f8/0x610
> [ 1863.946708] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod bnx2x tg3 ahci libahci libphy mdio firmware_class libata dm_mirror dm_region_hash dm_log dm_mod
> [ 1863.946801] CPU: 16 PID: 35307 Comm: move_pages12 Not tainted 5.9.0-rc1-next-20200820 #4
> [ 1863.946834] NIP:  c0000000003fcb48 LR: c0000000003fcb38 CTR: 0000000000000000
> [ 1863.946856] REGS: c000000016ebf6f0 TRAP: 0700   Not tainted  (5.9.0-rc1-next-20200820)
> [ 1863.946879] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 28242882  XER: 00000000
> [ 1863.946915] CFAR: c00000000032c644 IRQMASK: 0 
>                GPR00: c0000000003fcb38 c000000016ebf980 c000000005923200 0000000000000031 
>                GPR04: 0000000000000000 0000000000000000 0000000000000027 c000001ffd727190 
>                GPR08: 0000000000000023 0000000000000001 c0000000058f3200 0000000000000001 
>                GPR12: 0000000000002000 c000001ffffe3800 c000000000b26a68 0000000000000000 
>                GPR16: c000000016ebfc20 c000000016ebfcd8 0000000000000020 0000000000000001 
>                GPR20: c00c00080724f000 c0000000003c8770 0000000000000000 c000000016ebfcd0 
>                GPR24: 0000000000000000 fffffffffffffff5 0000000000000002 0000000000000000 
>                GPR28: 0000000000000000 0000000000000001 0000000000000000 c00c000007f4f000 
> [ 1863.947142] NIP [c0000000003fcb48] mem_cgroup_migrate+0x5f8/0x610
> [ 1863.947164] LR [c0000000003fcb38] mem_cgroup_migrate+0x5e8/0x610
> [ 1863.947185] Call Trace:
> [ 1863.947203] [c000000016ebf980] [c0000000003fcb38] mem_cgroup_migrate+0x5e8/0x610 (unreliable)
> [ 1863.947241] [c000000016ebf9c0] [c0000000003c9080] migrate_page_states+0x4e0/0xce0
> [ 1863.947274] [c000000016ebf9f0] [c0000000003cbbec] migrate_page+0x8c/0x120
> [ 1863.947307] [c000000016ebfa30] [c0000000003ccf10] move_to_new_page+0x190/0x670
> [ 1863.947341] [c000000016ebfaf0] [c0000000003ced08] migrate_pages+0xfb8/0x1880
> [ 1863.947365] [c000000016ebfc00] [c0000000003cf670] move_pages_and_store_status.isra.45+0xa0/0x160
> [ 1863.947399] [c000000016ebfc80] [c0000000003cfef4] sys_move_pages+0x7c4/0xed0
> [ 1863.947434] [c000000016ebfdc0] [c00000000002c678] system_call_exception+0xf8/0x1d0
> [ 1863.947459] [c000000016ebfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
> [ 1863.947481] Instruction dump:
> [ 1863.947502] 7fc3f378 4bfee82d 7c0802a6 3c82fb20 7fe3fb78 38844fc8 f8010050 4bf2fad5 
> [ 1863.947527] 60000000 39200001 3d42fffd 992a82fb <0fe00000> e8010050 eb810020 7c0803a6 
> [ 1863.947563] CPU: 16 PID: 35307 Comm: move_pages12 Not tainted 5.9.0-rc1-next-20200820 #4
> [ 1863.947594] Call Trace:
> [ 1863.947615] [c000000016ebf4d0] [c0000000006f6008] dump_stack+0xfc/0x174 (unreliable)
> [ 1863.947642] [c000000016ebf520] [c0000000000c9004] __warn+0xc4/0x14c
> [ 1863.947665] [c000000016ebf5b0] [c0000000006f4b68] report_bug+0x108/0x1f0
> [ 1863.947689] [c000000016ebf650] [c0000000000234f4] program_check_exception+0x104/0x2e0
> [ 1863.947724] [c000000016ebf680] [c000000000009664] program_check_common_virt+0x2c4/0x310
> [ 1863.947751] --- interrupt: 700 at mem_cgroup_migrate+0x5f8/0x610
>                    LR = mem_cgroup_migrate+0x5e8/0x610
> [ 1863.947786] [c000000016ebf9c0] [c0000000003c9080] migrate_page_states+0x4e0/0xce0
> [ 1863.947810] [c000000016ebf9f0] [c0000000003cbbec] migrate_page+0x8c/0x120
> [ 1863.947843] [c000000016ebfa30] [c0000000003ccf10] move_to_new_page+0x190/0x670
> [ 1863.947867] [c000000016ebfaf0] [c0000000003ced08] migrate_pages+0xfb8/0x1880
> [ 1863.947901] [c000000016ebfc00] [c0000000003cf670] move_pages_and_store_status.isra.45+0xa0/0x160
> [ 1863.947936] [c000000016ebfc80] [c0000000003cfef4] sys_move_pages+0x7c4/0xed0
> [ 1863.947969] [c000000016ebfdc0] [c00000000002c678] system_call_exception+0xf8/0x1d0
> [ 1863.948002] [c000000016ebfe20] [c00000000000d0a8] system_call_common+0xe8/0x218
> [ 1863.948034] irq event stamp: 410
> [ 1863.948054] hardirqs last  enabled at (409): [<c000000000184564>] console_unlock+0x6b4/0x990
> [ 1863.948092] hardirqs last disabled at (410): [<c00000000000965c>] program_check_common_virt+0x2bc/0x310
> [ 1863.948126] softirqs last  enabled at (0): [<c0000000000c59a8>] copy_process+0x788/0x1950
> [ 1863.948229] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [ 1863.948316] ---[ end trace 74f8f4df751b0259 ]---
> 
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: cgroups@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  include/linux/mmdebug.h | 13 +++++++++++++
> >  mm/memcontrol.c         | 15 ++++++++-------
> >  2 files changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/include/linux/mmdebug.h b/include/linux/mmdebug.h
> > index 2ad72d2c8cc5..4ed52879ce55 100644
> > --- a/include/linux/mmdebug.h
> > +++ b/include/linux/mmdebug.h
> > @@ -37,6 +37,18 @@
> >  			BUG();						\
> >  		}							\
> >  	} while (0)
> > +#define VM_WARN_ON_ONCE_PAGE(cond, page)	({			\
> > +	static bool __section(.data.once) __warned;			\
> > +	int __ret_warn_once = !!(cond);					\
> > +									\
> > +	if (unlikely(__ret_warn_once && !__warned)) {			\
> > +		dump_page(page, "VM_WARN_ON_ONCE_PAGE(" __stringify(cond)")");\
> > +		__warned = true;					\
> > +		WARN_ON(1);						\
> > +	}								\
> > +	unlikely(__ret_warn_once);					\
> > +})
> > +
> >  #define VM_WARN_ON(cond) (void)WARN_ON(cond)
> >  #define VM_WARN_ON_ONCE(cond) (void)WARN_ON_ONCE(cond)
> >  #define VM_WARN_ONCE(cond, format...) (void)WARN_ONCE(cond, format)
> > @@ -48,6 +60,7 @@
> >  #define VM_BUG_ON_MM(cond, mm) VM_BUG_ON(cond)
> >  #define VM_WARN_ON(cond) BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN_ON_ONCE(cond) BUILD_BUG_ON_INVALID(cond)
> > +#define VM_WARN_ON_ONCE_PAGE(cond, page)  BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN_ONCE(cond, format...) BUILD_BUG_ON_INVALID(cond)
> >  #define VM_WARN(cond, format...) BUILD_BUG_ON_INVALID(cond)
> >  #endif
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 130093bdf74b..299382fc55a9 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1322,10 +1322,8 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
> >  	}
> >  
> >  	memcg = page->mem_cgroup;
> > -	/*
> > -	 * Swapcache readahead pages are added to the LRU - and
> > -	 * possibly migrated - before they are charged.
> > -	 */
> > +	/* Readahead page is charged too, to see if other page uncharged */
> > +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> >  	if (!memcg)
> >  		memcg = root_mem_cgroup;
> >  
> > @@ -6906,8 +6904,9 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
> >  	if (newpage->mem_cgroup)
> >  		return;
> >  
> > -	/* Swapcache readahead pages can get replaced before being charged */
> >  	memcg = oldpage->mem_cgroup;
> > +	/* Readahead page is charged too, to see if other page uncharged */
> > +	VM_WARN_ON_ONCE_PAGE(!memcg, oldpage);
> >  	if (!memcg)
> >  		return;
> >  
> > @@ -7104,7 +7103,8 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
> >  
> >  	memcg = page->mem_cgroup;
> >  
> > -	/* Readahead page, never charged */
> > +	/* Readahead page is charged too, to see if other page uncharged */
> > +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> >  	if (!memcg)
> >  		return;
> >  
> > @@ -7168,7 +7168,8 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
> >  
> >  	memcg = page->mem_cgroup;
> >  
> > -	/* Readahead page, never charged */
> > +	/* Readahead page is charged too, to see if other page uncharged */
> > +	VM_WARN_ON_ONCE_PAGE(!memcg, page);
> >  	if (!memcg)
> >  		return 0;
> >  
> > -- 
> > 1.8.3.1
> > 
> > 
