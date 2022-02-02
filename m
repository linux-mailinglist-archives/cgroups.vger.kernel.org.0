Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87B284A7B76
	for <lists+cgroups@lfdr.de>; Thu,  3 Feb 2022 00:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiBBXG5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 18:06:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:45063 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232019AbiBBXG4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 18:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643843216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=srHq4RerCPcuK2/I9lWBI5nczQqLUr4zYMys9nonwW0=;
        b=ANHHMEoEt4kme7PJSzZBjj3biAAgFIaNGmWaDG62aj49RUPavtiX6235XGQ+nM/Ujpq3L/
        rIfzsl9T9wEBizsO/qTCKd+8YrhVswQpFyCxekSzqghzOobv74asghUS6tWYHam7OdDaIt
        YqWDL/Yz3GlXUlf2bzJ/WHdnPYpJl2k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-t50uVmtSOVad0sf5I0cVQQ-1; Wed, 02 Feb 2022 18:06:55 -0500
X-MC-Unique: t50uVmtSOVad0sf5I0cVQQ-1
Received: by mail-qt1-f199.google.com with SMTP id w25-20020ac84d19000000b002d2966d66a8so513315qtv.18
        for <cgroups@vger.kernel.org>; Wed, 02 Feb 2022 15:06:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=srHq4RerCPcuK2/I9lWBI5nczQqLUr4zYMys9nonwW0=;
        b=wkyJZj6Bc4ViITFTr2X1PSON00kv1EOQgbTBialYrDQGcI97iwXZg4f345/lh8Je3l
         3nwv56ko79meJQxmSXDvANLl0iak4R2u3kMsARIB4OT6O0pEwYQxo227Eic/iVQm/2YL
         k9+cKT9FMNhFYuIuyd6ktLXPwr2adOTXSbnDEWzmUCE+WmGO3GrbfQQNTY4ZHtuH24Ot
         fR1pqmkcfVFzgdMlAcSQvzY7oAHyxFuJiy2pQmBSYtrS/hJZhgAuEO6DiYy302UfQrWZ
         BqEU3TOqWZq6RPRl7MhVKDM9bwnB9cZsFZxEzAgVz8rvajaE799DRGqK37Lnr3qy1jkW
         24Ig==
X-Gm-Message-State: AOAM530pQ8jzczf4plcWjAPdRgC2m+qQat/0/UBTwnXiCom/sJmgNPP0
        eH0W96tRrGyhoX92URb/jvoiC6owU/7WcnAeEl8Y9Wzb+k6eJLLD+n/3RIcniJl7fPyEt3ARD8f
        K9DklvGklLgT+61XVfA==
X-Received: by 2002:a05:622a:144a:: with SMTP id v10mr16612658qtx.350.1643843214566;
        Wed, 02 Feb 2022 15:06:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwhd9wQP9nLOoPNf+zPu0Q9gF2MAe960omGhUqE/PcrJrAiip/p0+OPiu1a41WQoa5ljwp9Zg==
X-Received: by 2002:a05:622a:144a:: with SMTP id v10mr16612625qtx.350.1643843214253;
        Wed, 02 Feb 2022 15:06:54 -0800 (PST)
Received: from optiplex-fbsd (c-73-182-255-193.hsd1.nh.comcast.net. [73.182.255.193])
        by smtp.gmail.com with ESMTPSA id h7sm3106143qtb.27.2022.02.02.15.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:06:53 -0800 (PST)
Date:   Wed, 2 Feb 2022 18:06:51 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v4 0/4] mm/page_owner: Extend page_owner to show memcg
 information
Message-ID: <YfsOi38nXkyCrYam@optiplex-fbsd>
References: <20220131192308.608837-5-longman@redhat.com>
 <20220202203036.744010-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202203036.744010-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 02, 2022 at 03:30:32PM -0500, Waiman Long wrote:
>  v4:
>   - Take rcu_read_lock() when memcg is being accessed as suggested by
>     Michal.
>   - Make print_page_owner_memcg() return the new offset into the buffer
>     and put CONFIG_MEMCG block inside as suggested by Mike.
>   - Directly use TASK_COMM_LEN as length of name buffer as suggested by
>     Roman.
> 
>  v3:
>   - Add unlikely() to patch 1 and clarify that -1 will not be returned.
>   - Use a helper function to print out memcg information in patch 3.
>   - Add a new patch 4 to store task command name in page_owner
>     structure.
> 
>  v2:
>   - Remove the SNPRINTF() macro as suggested by Ira and use scnprintf()
>     instead to remove some buffer overrun checks.
>   - Add a patch to optimize vscnprintf with a size parameter of 0.
> 
> While debugging the constant increase in percpu memory consumption on
> a system that spawned large number of containers, it was found that a
> lot of offline mem_cgroup structures remained in place without being
> freed. Further investigation indicated that those mem_cgroup structures
> were pinned by some pages.
> 
> In order to find out what those pages are, the existing page_owner
> debugging tool is extended to show memory cgroup information and whether
> those memcgs are offline or not. With the enhanced page_owner tool,
> the following is a typical page that pinned the mem_cgroup structure
> in my test case:
> 
> Page allocated via order 0, mask 0x1100cca(GFP_HIGHUSER_MOVABLE), pid 162970 (podman), ts 1097761405537 ns, free_ts 1097760838089 ns
> PFN 1925700 type Movable Block 3761 type Movable Flags 0x17ffffc00c001c(uptodate|dirty|lru|reclaim|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
>  prep_new_page+0xac/0xe0
>  get_page_from_freelist+0x1327/0x14d0
>  __alloc_pages+0x191/0x340
>  alloc_pages_vma+0x84/0x250
>  shmem_alloc_page+0x3f/0x90
>  shmem_alloc_and_acct_page+0x76/0x1c0
>  shmem_getpage_gfp+0x281/0x940
>  shmem_write_begin+0x36/0xe0
>  generic_perform_write+0xed/0x1d0
>  __generic_file_write_iter+0xdc/0x1b0
>  generic_file_write_iter+0x5d/0xb0
>  new_sync_write+0x11f/0x1b0
>  vfs_write+0x1ba/0x2a0
>  ksys_write+0x59/0xd0
>  do_syscall_64+0x37/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> Charged to offline memcg libpod-conmon-15e4f9c758422306b73b2dd99f9d50a5ea53cbb16b4a13a2c2308a4253cc0ec8.
> 
> So the page was not freed because it was part of a shmem segment. That
> is useful information that can help users to diagnose similar problems.
> 
> With cgroup v1, /proc/cgroups can be read to find out the total number
> of memory cgroups (online + offline). With cgroup v2, the cgroup.stat of
> the root cgroup can be read to find the number of dying cgroups (most
> likely pinned by dying memcgs).
> 
> The page_owner feature is not supposed to be enabled for production
> system due to its memory overhead. However, if it is suspected that
> dying memcgs are increasing over time, a test environment with page_owner
> enabled can then be set up with appropriate workload for further analysis
> on what may be causing the increasing number of dying memcgs.
> 
> Waiman Long (4):
>   lib/vsprintf: Avoid redundant work with 0 size
>   mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
>   mm/page_owner: Print memcg information
>   mm/page_owner: Record task command name
> 
>  lib/vsprintf.c  |  8 +++---
>  mm/page_owner.c | 70 ++++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 60 insertions(+), 18 deletions(-)
> 
> -- 
> 2.27.0
>

Thank you, Waiman.

Acked-by: Rafael Aquini <aquini@redhat.com>

