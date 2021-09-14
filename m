Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6040A99C
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 10:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhINIwE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 04:52:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:56936 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhINIwD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 04:52:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 05A72220AA;
        Tue, 14 Sep 2021 08:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631609446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RIR51aRmRzF9ysiiqxPdyfX2llfs7AgTy30SBBy95CA=;
        b=HtutwS70JO8Ho9xUdBv7Bi3Q/ZY6iS+qzxhp6HeWUCOn+6CjpLvmoi3giAu1RZlyAYMDXt
        z7bamzxvTd84ZTwBf1vI15afJpc1YZSPgIv4FzHO0/yiFaIMUCrpaPtq9bo+Q38aW8ZRpf
        38Olfd3LJFORT/GcoU/KLZPbOE0gk4Q=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 176EAA3B8E;
        Tue, 14 Sep 2021 08:50:44 +0000 (UTC)
Date:   Tue, 14 Sep 2021 10:50:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YUBiYgXWSoKSG7f2@dhcp22.suse.cz>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-09-21 11:40:28, Feng Tang wrote:
> There was report that starting an Ubuntu in docker while using cpuset
> to bind it to movable nodes (a node only has movable zone, like a node
> for hotplug or a Persistent Memory  node in normal usage) will fail
> due to memory allocation failure, and then OOM is involved and many
> other innocent processes got killed. It can be reproduced with command:
> $docker run -it --rm  --cpuset-mems 4 ubuntu:latest bash -c
> "grep Mems_allowed /proc/self/status" (node 4 is a movable node)
> 
>   runc:[2:INIT] invoked oom-killer: gfp_mask=0x500cc2(GFP_HIGHUSER|__GFP_ACCOUNT), order=0, oom_score_adj=0
>   CPU: 8 PID: 8291 Comm: runc:[2:INIT] Tainted: G        W I E     5.8.2-0.g71b519a-default #1 openSUSE Tumbleweed (unreleased)
>   Hardware name: Dell Inc. PowerEdge R640/0PHYDR, BIOS 2.6.4 04/09/2020
>   Call Trace:
>    dump_stack+0x6b/0x88
>    dump_header+0x4a/0x1e2
>    oom_kill_process.cold+0xb/0x10
>    out_of_memory.part.0+0xaf/0x230
>    out_of_memory+0x3d/0x80
>    __alloc_pages_slowpath.constprop.0+0x954/0xa20
>    __alloc_pages_nodemask+0x2d3/0x300
>    pipe_write+0x322/0x590
>    new_sync_write+0x196/0x1b0
>    vfs_write+0x1c3/0x1f0
>    ksys_write+0xa7/0xe0
>    do_syscall_64+0x52/0xd0
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>   Mem-Info:
>   active_anon:392832 inactive_anon:182 isolated_anon:0
>    active_file:68130 inactive_file:151527 isolated_file:0
>    unevictable:2701 dirty:0 writeback:7
>    slab_reclaimable:51418 slab_unreclaimable:116300
>    mapped:45825 shmem:735 pagetables:2540 bounce:0
>    free:159849484 free_pcp:73 free_cma:0
>   Node 4 active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB all_unreclaimable? no
>   Node 4 Movable free:130021408kB min:9140kB low:139160kB high:269180kB reserved_highatomic:0KB active_anon:1448kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:130023424kB managed:130023424kB mlocked:0kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:292kB local_pcp:84kB free_cma:0kB
>   lowmem_reserve[]: 0 0 0 0 0
>   Node 4 Movable: 1*4kB (M) 0*8kB 0*16kB 1*32kB (M) 0*64kB 0*128kB 1*256kB (M) 1*512kB (M) 1*1024kB (M) 0*2048kB 31743*4096kB (M) = 130021156kB
> 
>   oom-kill:constraint=CONSTRAINT_CPUSET,nodemask=(null),cpuset=docker-9976a269caec812c134fa317f27487ee36e1129beba7278a463dd53e5fb9997b.scope,mems_allowed=4,global_oom,task_memcg=/system.slice/containerd.service,task=containerd,pid=4100,uid=0
>   Out of memory: Killed process 4100 (containerd) total-vm:4077036kB, anon-rss:51184kB, file-rss:26016kB, shmem-rss:0kB, UID:0 pgtables:676kB oom_score_adj:0
>   oom_reaper: reaped process 8248 (docker), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 2054 (node_exporter), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 1452 (systemd-journal), now anon-rss:0kB, file-rss:8564kB, shmem-rss:4kB
>   oom_reaper: reaped process 2146 (munin-node), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
>   oom_reaper: reaped process 8291 (runc:[2:INIT]), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
> 
> The reason is, in the case, the target cpuset nodes only have movable
> zone, while the creation of an OS in docker sometimes needs to allocate
> memory in non-movable zones (dma/dma32/normal) like GFP_HIGHUSER, and
> the cpuset limit forbids the allocation, then out-of-memory killing is
> involved even when normal nodes and movable nodes both have many free
> memory.
> 
> The OOM killer cannot help to resolve the situation as there is no
> usable memory for the request in the cpuset scope. The only reasonable
> measure to take is to fail the allocation right away and have the caller
> to deal with it.
> 
> So add a check for cases like this in the slowpath of allocation, and
> bail out early returning NULL for the allocation.
> 
> As page allocation is one of the hottest path in kernel, this check
> will hurt all users with sane cpuset configuration, add a static branch
> check and detect the abnormal config in cpuset memory binding setup so
> that the extra check in page allocation is not paid by everyone.
> 
> [thanks to Micho Hocko and David Rientjes for suggesting not handle
>  it inside OOM code, adding cpuset check, refining comments]
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Minor nit below
[...]
> +/* Whether the 'nodes' are all movable nodes */
> +static inline bool movable_only_nodes(nodemask_t *nodes)
> +{
> +	struct zonelist *zonelist;
> +	struct zoneref *z;
> +
> +	if (nodes_empty(*nodes))
> +		return false;
> +
> +	zonelist =
> +	    &NODE_DATA(first_node(*nodes))->node_zonelists[ZONELIST_FALLBACK];
> +	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> +	return (!z->zone) ? true : false;

This would read easier to me
	/*
	 * We can chose arbitrary node from the nodemask to get a
	 * zonelist as they are interlinked. We just need to find
	 * at least one zone that can satisfy kernel allocations.
	 */
	node = NODE_DATA(first_node(*nodes));
	zonelist = node_zonelist(node, GFP_KERNEL);
	z = first_zones_zonelist(zonelist, ZONE_NORMAL, nodes);
-- 
Michal Hocko
SUSE Labs
