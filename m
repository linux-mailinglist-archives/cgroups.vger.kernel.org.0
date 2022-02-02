Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478C34A7981
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbiBBUcu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 15:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347163AbiBBUcu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 15:32:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643833969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wcENReRHFRW4er+uIjMQ9SA6VL83pYAObKBta+stQfk=;
        b=CItthku6zFHj0xmg0kZGjAPRrcPN/tP42c2eYVpZmcDJQdxvv3mD4SsOkVdTwf7Sj2LGeZ
        eyPf3Fnu2LuL6tmyO9BA/pAz58MO7GLLEXNRTj+1B3nNq9mD+vdfGKVTEtUu3xse5Rnx6s
        /veLdam3XteHCvbgOYRFIusgbHnr/5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-cg6h955nOXS8hPI6xg15BQ-1; Wed, 02 Feb 2022 15:32:46 -0500
X-MC-Unique: cg6h955nOXS8hPI6xg15BQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16AC2344DD;
        Wed,  2 Feb 2022 20:32:44 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E86B012E23;
        Wed,  2 Feb 2022 20:32:19 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/4] mm/page_owner: Extend page_owner to show memcg information
Date:   Wed,  2 Feb 2022 15:30:32 -0500
Message-Id: <20220202203036.744010-1-longman@redhat.com>
In-Reply-To: <20220131192308.608837-5-longman@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v4:
  - Take rcu_read_lock() when memcg is being accessed as suggested by
    Michal.
  - Make print_page_owner_memcg() return the new offset into the buffer
    and put CONFIG_MEMCG block inside as suggested by Mike.
  - Directly use TASK_COMM_LEN as length of name buffer as suggested by
    Roman.

 v3:
  - Add unlikely() to patch 1 and clarify that -1 will not be returned.
  - Use a helper function to print out memcg information in patch 3.
  - Add a new patch 4 to store task command name in page_owner
    structure.

 v2:
  - Remove the SNPRINTF() macro as suggested by Ira and use scnprintf()
    instead to remove some buffer overrun checks.
  - Add a patch to optimize vscnprintf with a size parameter of 0.

While debugging the constant increase in percpu memory consumption on
a system that spawned large number of containers, it was found that a
lot of offline mem_cgroup structures remained in place without being
freed. Further investigation indicated that those mem_cgroup structures
were pinned by some pages.

In order to find out what those pages are, the existing page_owner
debugging tool is extended to show memory cgroup information and whether
those memcgs are offline or not. With the enhanced page_owner tool,
the following is a typical page that pinned the mem_cgroup structure
in my test case:

Page allocated via order 0, mask 0x1100cca(GFP_HIGHUSER_MOVABLE), pid 162970 (podman), ts 1097761405537 ns, free_ts 1097760838089 ns
PFN 1925700 type Movable Block 3761 type Movable Flags 0x17ffffc00c001c(uptodate|dirty|lru|reclaim|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
 prep_new_page+0xac/0xe0
 get_page_from_freelist+0x1327/0x14d0
 __alloc_pages+0x191/0x340
 alloc_pages_vma+0x84/0x250
 shmem_alloc_page+0x3f/0x90
 shmem_alloc_and_acct_page+0x76/0x1c0
 shmem_getpage_gfp+0x281/0x940
 shmem_write_begin+0x36/0xe0
 generic_perform_write+0xed/0x1d0
 __generic_file_write_iter+0xdc/0x1b0
 generic_file_write_iter+0x5d/0xb0
 new_sync_write+0x11f/0x1b0
 vfs_write+0x1ba/0x2a0
 ksys_write+0x59/0xd0
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
Charged to offline memcg libpod-conmon-15e4f9c758422306b73b2dd99f9d50a5ea53cbb16b4a13a2c2308a4253cc0ec8.

So the page was not freed because it was part of a shmem segment. That
is useful information that can help users to diagnose similar problems.

With cgroup v1, /proc/cgroups can be read to find out the total number
of memory cgroups (online + offline). With cgroup v2, the cgroup.stat of
the root cgroup can be read to find the number of dying cgroups (most
likely pinned by dying memcgs).

The page_owner feature is not supposed to be enabled for production
system due to its memory overhead. However, if it is suspected that
dying memcgs are increasing over time, a test environment with page_owner
enabled can then be set up with appropriate workload for further analysis
on what may be causing the increasing number of dying memcgs.

Waiman Long (4):
  lib/vsprintf: Avoid redundant work with 0 size
  mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
  mm/page_owner: Print memcg information
  mm/page_owner: Record task command name

 lib/vsprintf.c  |  8 +++---
 mm/page_owner.c | 70 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 60 insertions(+), 18 deletions(-)

-- 
2.27.0

