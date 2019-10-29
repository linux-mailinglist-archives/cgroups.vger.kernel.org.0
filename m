Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB8E83C3
	for <lists+cgroups@lfdr.de>; Tue, 29 Oct 2019 10:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfJ2JDv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 29 Oct 2019 05:03:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:35666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730523AbfJ2JDv (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 29 Oct 2019 05:03:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32C57AE46;
        Tue, 29 Oct 2019 09:03:49 +0000 (UTC)
Date:   Tue, 29 Oct 2019 10:03:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Greg Thelen <gthelen@google.com>,
        syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm: memcontrol: fix data race in
 mem_cgroup_select_victim_node
Message-ID: <20191029090347.GG31513@dhcp22.suse.cz>
References: <20191029005405.201986-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191029005405.201986-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 28-10-19 17:54:05, Shakeel Butt wrote:
> Syzbot reported the following bug:
> 
> BUG: KCSAN: data-race in mem_cgroup_select_victim_node / mem_cgroup_select_victim_node
> 
> write to 0xffff88809fade9b0 of 4 bytes by task 8603 on cpu 0:
>  mem_cgroup_select_victim_node+0xb5/0x3d0 mm/memcontrol.c:1686
>  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
>  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
>  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
>  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
>  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
>  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
>  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> 
> read to 0xffff88809fade9b0 of 4 bytes by task 7290 on cpu 1:
>  mem_cgroup_select_victim_node+0x92/0x3d0 mm/memcontrol.c:1675
>  try_to_free_mem_cgroup_pages+0x175/0x4c0 mm/vmscan.c:3376
>  reclaim_high.constprop.0+0xf7/0x140 mm/memcontrol.c:2349
>  mem_cgroup_handle_over_high+0x96/0x180 mm/memcontrol.c:2430
>  tracehook_notify_resume include/linux/tracehook.h:197 [inline]
>  exit_to_usermode_loop+0x20c/0x2c0 arch/x86/entry/common.c:163
>  prepare_exit_to_usermode+0x180/0x1a0 arch/x86/entry/common.c:194
>  swapgs_restore_regs_and_return_to_usermode+0x0/0x40
> 
> mem_cgroup_select_victim_node() can be called concurrently which reads
> and modifies memcg->last_scanned_node without any synchrnonization. So,
> read and modify memcg->last_scanned_node with READ_ONCE()/WRITE_ONCE()
> to stop potential reordering.

I am sorry but I do not understand the problem and the fix. Why does the
race happen and why does _ONCE fixes it? There is still no
synchronization. Do you want to prevent from memcg->last_scanned_node
reloading?

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Reported-by: syzbot+13f93c99c06988391efe@syzkaller.appspotmail.com
> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c4c555055a72..5a06739dd3e4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1667,7 +1667,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
>  	int node;
>  
>  	mem_cgroup_may_update_nodemask(memcg);
> -	node = memcg->last_scanned_node;
> +	node = READ_ONCE(memcg->last_scanned_node);
>  
>  	node = next_node_in(node, memcg->scan_nodes);
>  	/*
> @@ -1678,7 +1678,7 @@ int mem_cgroup_select_victim_node(struct mem_cgroup *memcg)
>  	if (unlikely(node == MAX_NUMNODES))
>  		node = numa_node_id();
>  
> -	memcg->last_scanned_node = node;
> +	WRITE_ONCE(memcg->last_scanned_node, node);
>  	return node;
>  }
>  #else
> -- 
> 2.24.0.rc0.303.g954a862665-goog

-- 
Michal Hocko
SUSE Labs
