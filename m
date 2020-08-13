Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F2B2437D8
	for <lists+cgroups@lfdr.de>; Thu, 13 Aug 2020 11:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMJqB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Aug 2020 05:46:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55693 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgHMJqA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Aug 2020 05:46:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0U5eFTQs_1597311955;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5eFTQs_1597311955)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Aug 2020 17:45:55 +0800
Subject: Re: [Resend PATCH 2/6] mm/memcg: remove useless check on
 page->mem_cgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <1597144232-11370-2-git-send-email-alex.shi@linux.alibaba.com>
 <20200811113008.GK4793@dhcp22.suse.cz>
 <776b0e6f-4129-9fb9-0f66-47757cf320d5@linux.alibaba.com>
 <20200811135626.GL4793@dhcp22.suse.cz>
 <0b5e1ac3-c9c7-35e9-2661-b58430314d0a@linux.alibaba.com>
 <20200813062049.GA9477@dhcp22.suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <abd9276b-31f8-a51d-43d6-6c8ae93237dc@linux.alibaba.com>
Date:   Thu, 13 Aug 2020 17:45:19 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200813062049.GA9477@dhcp22.suse.cz>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



ÔÚ 2020/8/13 ÏÂÎç2:20, Michal Hocko Ð´µÀ:
> On Wed 12-08-20 11:25:53, Alex Shi wrote:
>> >From 999b0fe5fc65865c3b59ff28500d45572a4a9570 Mon Sep 17 00:00:00 2001
>> From: Alex Shi <alex.shi@linux.alibaba.com>
>> Date: Wed, 5 Aug 2020 21:02:30 +0800
>> Subject: [PATCH 2/6] mm/memcg: bail out early from swap accounting when memcg
>>  is disabled
>>
>> If we disabled memcg by cgroup_disable=memory, page->memcg will be NULL
>> and so the charge is skipped and that will trigger a warning like below.
>> Let's return from the funcs earlier.
>>
>>  ---[ end trace f1f34bfc3b32ed2f ]---
>>  anon flags:0x5005b48008000d(locked|uptodate|dirty|swapbacked)
>>  raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
>>  raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
>>  page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
> 
> Yes this is better. It would be even more informative if you added the
> backtrace.

The stack is a bit long.
I still don't know where cause the asm_exc_page_fault? And seems the vma is from
kernel not user.

From 999b0fe5fc65865c3b59ff28500d45572a4a9570 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Wed, 5 Aug 2020 21:02:30 +0800
Subject: [PATCH 2/6] mm/memcg: bail out early from swap accounting when memcg
 is disabled

If we disabled memcg by cgroup_disable=memory, page->memcg will be NULL
and so the charge is skipped and that will trigger a warning like below.
Let's return from the funcs earlier.

 anon flags:0x5005b48008000d(locked|uptodate|dirty|swapbacked)
 raw: 005005b48008000d dead000000000100 dead000000000122 ffff8897c7c76ad1
 raw: 0000000000000022 0000000000000000 0000000200000000 0000000000000000
 page dumped because: VM_WARN_ON_ONCE_PAGE(!memcg)
...
 RIP: 0010:vprintk_emit+0x1f7/0x260
 Code: 00 84 d2 74 72 0f b6 15 27 58 64 01 48 c7 c0 00 d4 72 82 84 d2 74 09 f3 90 0f b6 10 84 d2 75 f7 e8 de 0d 00 00 4c 89 e7 57 9d <0f> 1f 44 00 00 e9 62 ff ff ff 80 3d 88 c9 3a 01 00 0f 85 54 fe ff
 RSP: 0018:ffffc9000faab358 EFLAGS: 00000202
 RAX: ffffffff8272d400 RBX: 000000000000005e RCX: ffff88afd80d0040
 RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000202
 RBP: ffffc9000faab3a8 R08: ffffffff8272d440 R09: 0000000000022480
 R10: 00120c77be68bfac R11: 0000000000cd7568 R12: 0000000000000202
 R13: 0057ffffc0080005 R14: ffffffff820a0130 R15: ffffc9000faab3e8
 ? vprintk_emit+0x140/0x260
 vprintk_default+0x1a/0x20
 vprintk_func+0x4f/0xc4
 ? vprintk_func+0x4f/0xc4
 printk+0x53/0x6a
 ? xas_load+0xc/0x80
 __dump_page.cold.6+0xff/0x4ee
 ? xas_init_marks+0x23/0x50
 ? xas_store+0x30/0x40
 ? free_swap_slot+0x43/0xd0
 ? put_swap_page+0x119/0x320
 ? update_load_avg+0x82/0x580
 dump_page+0x9/0xb
 mem_cgroup_try_charge_swap+0x16e/0x1d0
 get_swap_page+0x130/0x210
 add_to_swap+0x41/0xc0
 shrink_page_list+0x99e/0xdf0
 shrink_inactive_list+0x199/0x360
 shrink_lruvec+0x40d/0x650
 ? _cond_resched+0x14/0x30
 ? _cond_resched+0x14/0x30
 shrink_node+0x226/0x6e0
 do_try_to_free_pages+0xd0/0x400
 try_to_free_pages+0xef/0x130
 __alloc_pages_slowpath.constprop.127+0x38d/0xbd0
 ? ___slab_alloc+0x31d/0x6f0
 __alloc_pages_nodemask+0x27f/0x2c0
 alloc_pages_vma+0x75/0x220
 shmem_alloc_page+0x46/0x90
 ? release_pages+0x1ae/0x410
 shmem_alloc_and_acct_page+0x77/0x1c0
 shmem_getpage_gfp+0x162/0x910
 shmem_fault+0x74/0x210
 ? filemap_map_pages+0x29c/0x410
 __do_fault+0x37/0x190
 handle_mm_fault+0x120a/0x1770
 exc_page_fault+0x251/0x450
 ? asm_exc_page_fault+0x8/0x30
 asm_exc_page_fault+0x1e/0x30

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 299382fc55a9..419cf565f40b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7098,6 +7098,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 
+	if (mem_cgroup_disabled())
+		return;
+
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
@@ -7163,6 +7166,9 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
+	if (mem_cgroup_disabled())
+		return 0;
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
-- 
1.8.3.1

