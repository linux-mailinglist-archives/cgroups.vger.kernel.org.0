Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE85B24D528
	for <lists+cgroups@lfdr.de>; Fri, 21 Aug 2020 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgHUMjy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Aug 2020 08:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbgHUMjq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Aug 2020 08:39:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C330C061387
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 05:39:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id x69so1197879qkb.1
        for <cgroups@vger.kernel.org>; Fri, 21 Aug 2020 05:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+HsDmCJL6xMdaRhjao0v3a+DQ1cZEhspj6wmqySoCco=;
        b=ON51P3JZHx1/Sb+dLvXsQ5/auh/0yXcnyDXDwYLz0HR3UZEN2TyDtfi0jZWrVe7U+1
         UTtrrETq5BKPPYquHRKels8CsOCwohrS2oCFp8M7X9FYKqHUbQTLFT0p3mF+J8EZ+NsE
         RvdEUFog9XTi/LDwmH9/1o0DyAC48MgijNLLYcEu91SHn2WWXRk9JlHvSKbgsWmneWgV
         UVd8vlEWCldXIiKMphKoyedLHlj34dVHKwEALG1Pi36DLNPuJYC0CifjxjRBuQd9sQLM
         LCfjQxQ1xQ2wBRz5t3BDYM9AmF3jdL9JeJ8YAhOcFEiuYCmQ8bIi3HnI0S2hbS+guURR
         e1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+HsDmCJL6xMdaRhjao0v3a+DQ1cZEhspj6wmqySoCco=;
        b=ZSK4DCRzkgPnXf3fi8kG7CRI+bcQAoDjr5Nr+I73SMsu7WfmiJqUpzNbdybFlQdxww
         YY9dCNmuKJJChHdwXyF9XvDdp7yJit/F4BnVeOYZWSkvXkpJbgrjYYFHME6Ztq8TaT1S
         ZlvYhWPn1MdCtM7j+NPpw6LW0WoF07qtewah/2uvXEJOu0ycPwQbvuHSePVVRhIJtREI
         NbfcfZ3D2gqF8FJ/Yr6H+9gBsUwhn1OMFAVFq7BzmGNvK291PLB/oNcO73lsgUZy79ER
         vPwrWSsFObDDE5VgpPZNAi+Kj2AJnVAbxF3nC91UfnLslRBcUPRLttqh93353/K+9G/x
         rKfA==
X-Gm-Message-State: AOAM532jcYOmRRbT8H6nUYvWpZrs9zHjqZd0n+6gc+wrNtkmwba95uT3
        P/zgpaWWSZ3IfsFTazv6v6P3YA==
X-Google-Smtp-Source: ABdhPJwH8U1rA8n7CvUUpPymWZ48dDAaSK8wb74nf9dgnMTbIdKv0K6VvewTiDG8WYLhQYtLnLmSVw==
X-Received: by 2002:a05:620a:12c7:: with SMTP id e7mr2431163qkl.433.1598013583510;
        Fri, 21 Aug 2020 05:39:43 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p26sm1612398qkm.23.2020.08.21.05.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:39:42 -0700 (PDT)
Date:   Fri, 21 Aug 2020 08:39:37 -0400
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200821123934.GA4314@lca.pw>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200821080127.GD32537@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821080127.GD32537@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 21, 2020 at 10:01:27AM +0200, Michal Hocko wrote:
> On Thu 20-08-20 10:58:51, Qian Cai wrote:
> > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > > Since readahead page is charged on memcg too, in theory we don't have to
> > > check this exception now. Before safely remove them all, add a warning
> > > for the unexpected !memcg.
> > > 
> > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This will trigger,
> 
> Thanks for the report!
>  
> > [ 1863.916499] LTP: starting move_pages12
> > [ 1863.946520] page:000000008ccc1062 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fd3c0
> > [ 1863.946553] head:000000008ccc1062 order:5 compound_mapcount:0 compound_pincount:0
> 
> Hmm, this is really unexpected. How did we get order-5 page here? Is
> this some special mappaing that sys_move_pages should just ignore?

Well, I thought everybody should be able to figure out where to find the LTP
tests source code at this stage to see what it does. Anyway, the test simply
migrate hugepages while soft offlining, so order 5 is expected as that is 2M
hugepage on powerpc (also reproduced on x86 below). It might be easier to
reproduce using our linux-mm random bug collection on NUMA systems.

# git clone https://gitlab.com/cailca/linux-mm
# cd linux-mm; make
# ./random 1

The main code is here:

https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L786

Reproduced on x86 as well:

[  314.171411][ T1762] Offlined Pages 524288
[  315.265413][ T1762] Soft offlining pfn 0x1e86e00 at process virtual address 0x7f221b800000
[  315.307179][ T1762] soft offline: 0x1e86e00: hugepage isolation failed: 0, page count 2, type 3bfffc00001000f (locked|referenced|uptodate|dirty|head)
[  315.372397][ T1762] Soft offlining pfn 0x1880000 at process virtual address 0x7f221ba00000
[  315.372788][ T1939] page:000000004b7fe362 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e86e00
[  315.461283][ T1939] head:000000004b7fe362 order:9 compound_mapcount:0 compound_pincount:0
[  315.501050][ T1939] anon flags: 0x3bfffc00001000f(locked|referenced|uptodate|dirty|head)
[  315.539977][ T1939] raw: 03bfffc00001000f ffffc9000aaefe30 ffffc9000aaefe30 ffff888fefec5a49
[  315.580841][ T1939] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
[  315.621327][ T1939] page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
[  315.677964][ T1939] WARNING: CPU: 30 PID: 1939 at mm/memcontrol.c:6908 mem_cgroup_migrate+0x50e/0x850
[  315.722090][ T1939] Modules linked in: nls_ascii nls_cp437 vfat fat kvm_intel kvm irqbypass efivars ip_tables x_tables sd_mod bnx2x hpsa mdio scsi_transport_sas firmware_class dm_mirror dm_region_hash dm_log dm_mod efivarfs
[  315.819298][ T1939] CPU: 30 PID: 1939 Comm: random Not tainted 5.9.0-rc1-next-20200821 #2
[  315.858186][ T1939] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[  315.894272][ T1939] RIP: 0010:mem_cgroup_migrate+0x50e/0x850
[  315.922436][ T1939] Code: 2d c0 5c 5d 06 40 80 fd 01 0f 87 3f 2d 00 00 83 e5 01 75 18 48 c7 c6 80 14 4e ad 48 89 df e8 99 4f eb ff c6 05 9b 5c 5d 06 01 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c6 60 04
[  316.018174][ T1939] RSP: 0018:ffffc9000aaefa98 EFLAGS: 00010296
[  316.047132][ T1939] RAX: 0000000000000000 RBX: ffffea007a1b8000 RCX: ffffffffac899a12
[  316.084567][ T1939] RDX: 1ffffd400f437007 RSI: 0000000000000000 RDI: ffffea007a1b8038
[  316.122817][ T1939] RBP: 0000000000000000 R08: ffffed120bf75e7a R09: ffffed120bf75e7a
[  316.160571][ T1939] R10: ffff88905fbaf3cf R11: ffffed120bf75e79 R12: 0000000000000000
[  316.198278][ T1939] R13: ffffea000e108038 R14: ffffea000e108008 R15: 0000000000000001
[  316.235465][ T1939] FS:  00007f221c461740(0000) GS:ffff88905fb80000(0000) knlGS:0000000000000000
[  316.277658][ T1939] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  316.309711][ T1939] CR2: 000055acde5279d8 CR3: 0000000fec490003 CR4: 00000000001706e0
[  316.349521][ T1939] Call Trace:
[  316.364537][ T1939]  ? migrate_page_states+0xb4c/0x1970
[  316.389115][ T1939]  migrate_page+0xea/0x190
[  316.409463][ T1939]  move_to_new_page+0x338/0xca0
[  316.432024][ T1939]  ? remove_migration_ptes+0xd0/0xd0
[  316.456464][ T1939]  ? __page_mapcount+0x19a/0x250
[  316.479465][ T1939]  ? try_to_unmap+0x1bf/0x2d0
[  316.501801][ T1939]  ? rmap_walk_locked+0x140/0x140
[  316.524702][ T1939]  ? PageHuge+0xf/0xd0
[  316.543478][ T1939]  ? page_mapped+0x155/0x2e0
[  316.564341][ T1939]  ? hugetlb_page_mapping_lock_write+0x97/0x180
[  316.593160][ T1939]  migrate_pages+0x1496/0x2290
[  316.615520][ T1939]  ? remove_migration_pte+0xac0/0xac0
[  316.640773][ T1939]  move_pages_and_store_status.isra.47+0xd7/0x1a0
[  316.670470][ T1939]  ? migrate_pages+0x2290/0x2290
[  316.693733][ T1939]  __x64_sys_move_pages+0x8b7/0x1180
[  316.717974][ T1939]  ? move_pages_and_store_status.isra.47+0x1a0/0x1a0
[  316.749559][ T1939]  ? syscall_enter_from_user_mode+0x1b/0x210
[  316.776749][ T1939]  ? lockdep_hardirqs_on_prepare+0x33e/0x4e0
[  316.804892][ T1939]  ? syscall_enter_from_user_mode+0x20/0x210
[  316.833657][ T1939]  ? trace_hardirqs_on+0x20/0x1b5
[  316.858450][ T1939]  do_syscall_64+0x33/0x40
[  316.879205][ T1939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  316.905709][ T1939] RIP: 0033:0x7f221bd5d6ed
[  316.925937][ T1939] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 57 2c 00 f7 d8 64 89 01 48
[  317.017819][ T1939] RSP: 002b:00007ffff6c4d448 EFLAGS: 00000212 ORIG_RAX: 0000000000000117
[  317.057248][ T1939] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f221bd5d6ed
[  317.094612][ T1939] RDX: 000000000151bc40 RSI: 0000000000000400 RDI: 00000000000006e2
[  317.131770][ T1939] RBP: 00007ffff6c4d4b0 R08: 000000000151ac30 R09: 0000000000000004
[  317.169009][ T1939] R10: 0000000001519c20 R11: 0000000000000212 R12: 0000000000401cb0
[  317.206463][ T1939] R13: 00007ffff6c58970 R14: 0000000000000000 R15: 0000000000000000
[  317.243922][ T1939] CPU: 30 PID: 1939 Comm: random Not tainted 5.9.0-rc1-next-20200821 #2
[  317.282806][ T1939] Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018
[  317.318693][ T1939] Call Trace:
[  317.334040][ T1939]  dump_stack+0x9d/0xe0
[  317.354529][ T1939]  __warn.cold.13+0xe/0x57
[  317.376117][ T1939]  ? mem_cgroup_migrate+0x50e/0x850
[  317.400959][ T1939]  report_bug+0x1af/0x260
[  317.420960][ T1939]  handle_bug+0x44/0x80
[  317.439737][ T1939]  exc_invalid_op+0x13/0x40
[  317.460081][ T1939]  asm_exc_invalid_op+0x12/0x20
[  317.483336][ T1939] RIP: 0010:mem_cgroup_migrate+0x50e/0x850
[  317.510309][ T1939] Code: 2d c0 5c 5d 06 40 80 fd 01 0f 87 3f 2d 00 00 83 e5 01 75 18 48 c7 c6 80 14 4e ad 48 89 df e8 99 4f eb ff c6 05 9b 5c 5d 06 01 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 c7 c6 60 04
[  317.603479][ T1939] RSP: 0018:ffffc9000aaefa98 EFLAGS: 00010296
[  317.630605][ T1939] RAX: 0000000000000000 RBX: ffffea007a1b8000 RCX: ffffffffac899a12
[  317.666432][ T1939] RDX: 1ffffd400f437007 RSI: 0000000000000000 RDI: ffffea007a1b8038
[  317.703630][ T1939] RBP: 0000000000000000 R08: ffffed120bf75e7a R09: ffffed120bf75e7a
[  317.739491][ T1939] R10: ffff88905fbaf3cf R11: ffffed120bf75e79 R12: 0000000000000000
[  317.777498][ T1939] R13: ffffea000e108038 R14: ffffea000e108008 R15: 0000000000000001
[  317.815155][ T1939]  ? llist_add_batch+0x52/0x90
[  317.837438][ T1939]  ? mem_cgroup_migrate+0x507/0x850
[  317.862628][ T1939]  ? migrate_page_states+0xb4c/0x1970
[  317.888821][ T1939]  migrate_page+0xea/0x190
[  317.910213][ T1939]  move_to_new_page+0x338/0xca0
[  317.932614][ T1939]  ? remove_migration_ptes+0xd0/0xd0
[  317.956549][ T1939]  ? __page_mapcount+0x19a/0x250
[  317.979397][ T1939]  ? try_to_unmap+0x1bf/0x2d0
[  318.000960][ T1939]  ? rmap_walk_locked+0x140/0x140
[  318.023999][ T1939]  ? PageHuge+0xf/0xd0
[  318.042729][ T1939]  ? page_mapped+0x155/0x2e0
[  318.063725][ T1939]  ? hugetlb_page_mapping_lock_write+0x97/0x180
[  318.092655][ T1939]  migrate_pages+0x1496/0x2290
[  318.114177][ T1939]  ? remove_migration_pte+0xac0/0xac0
[  318.139797][ T1939]  move_pages_and_store_status.isra.47+0xd7/0x1a0
[  318.170609][ T1939]  ? migrate_pages+0x2290/0x2290
[  318.193481][ T1939]  __x64_sys_move_pages+0x8b7/0x1180
[  318.217652][ T1939]  ? move_pages_and_store_status.isra.47+0x1a0/0x1a0
[  318.248748][ T1939]  ? syscall_enter_from_user_mode+0x1b/0x210
[  318.276536][ T1939]  ? lockdep_hardirqs_on_prepare+0x33e/0x4e0
[  318.304077][ T1939]  ? syscall_enter_from_user_mode+0x20/0x210
[  318.331847][ T1939]  ? trace_hardirqs_on+0x20/0x1b5
[  318.355312][ T1939]  do_syscall_64+0x33/0x40
[  318.376825][ T1939]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  318.405938][ T1939] RIP: 0033:0x7f221bd5d6ed
[  318.426072][ T1939] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 6b 57 2c 00 f7 d8 64 89 01 48
[  318.519665][ T1939] RSP: 002b:00007ffff6c4d448 EFLAGS: 00000212 ORIG_RAX: 0000000000000117
[  318.560049][ T1939] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f221bd5d6ed
[  318.597747][ T1939] RDX: 000000000151bc40 RSI: 0000000000000400 RDI: 00000000000006e2
[  318.635143][ T1939] RBP: 00007ffff6c4d4b0 R08: 000000000151ac30 R09: 0000000000000004
[  318.672919][ T1939] R10: 0000000001519c20 R11: 0000000000000212 R12: 0000000000401cb0
[  318.710619][ T1939] R13: 00007ffff6c58970 R14: 0000000000000000 R15: 0000000000000000
[  318.747920][ T1939] irq event stamp: 1465
[  318.766713][ T1939] hardirqs last  enabled at (1475): [<ffffffffabe671bf>] console_unlock+0x75f/0xaf0
[  318.810473][ T1939] hardirqs last disabled at (1484): [<ffffffffabe66cad>] console_unlock+0x24d/0xaf0
[  318.854253][ T1939] softirqs last  enabled at (1464): [<ffffffffad20070f>] __do_softirq+0x70f/0xa9f
[  318.900757][ T1939] softirqs last disabled at (1455): [<ffffffffad000ec2>] asm_call_on_stack+0x12/0x20
[  318.945713][ T1939] ---[ end trace 5a58095b9439b080 ]---

