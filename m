Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441D74ACD83
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 02:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240185AbiBHBGf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 20:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240357AbiBHAGG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 19:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BAA1C0612A4
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 16:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644278763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hp8wvZdS1P5SZuwA1phL5v+8erUCnmBhdeZatALDNps=;
        b=S3807IxVpMFwFCoOnlluXXKiKxldcNHJeU4uKmqgNWOGiEEcJvoZx/vzRQNlKmOadns/bU
        +jt9kQwfkmVRXS8SkXw+gVXjzPi1Ti6EE1utWV3Gi/in94r07THbPmA3ubHDKzCU02fX32
        CwsEgtEQe9TUc3oAB+Krqy+aPsEuCD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-n3pT6MGFOE-l5rV8R4WyZw-1; Mon, 07 Feb 2022 19:06:00 -0500
X-MC-Unique: n3pT6MGFOE-l5rV8R4WyZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D721B100C663;
        Tue,  8 Feb 2022 00:05:57 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CE875BC49;
        Tue,  8 Feb 2022 00:05:39 +0000 (UTC)
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
Subject: [PATCH v5 0/4] mm/page_owner: Extend page_owner to show memcg information
Date:   Mon,  7 Feb 2022 19:05:28 -0500
Message-Id: <20220208000532.1054311-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

 v5:
  - Apply the following changes to patch 3
    1) Make cgroup_name() write directly into kbuf without using an
       intermediate buffer.
    2) Change the terminology from "offline memcg" to "dying memcg" to align
       better with similar terms used elsewhere in the kernel.

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

While debugging the constant increase in percpu memory consumption on
a system that spawned large number of containers, it was found that a
lot of dying mem_cgroup structures remained in place without being
freed. Further investigation indicated that those mem_cgroup structures
were pinned by some pages.

In order to find out what those pages are, the existing page_owner
debugging tool is extended to show memory cgroup information and whether
those memcgs are dying or not. With the enhanced page_owner tool,
the following is a typical page that pinned the mem_cgroup structure
in my test case:

Page allocated via order 0, mask 0x1100cca(GFP_HIGHUSER_MOVABLE), pid 70984 (podman), ts 5421278969115 ns, free_ts 5420935666638 ns
PFN 3205061 type Movable Block 6259 type Movable Flags 0x17ffffc00c001c(uptodate|dirty|lru|reclaim|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
 prep_new_page+0x8e/0xb0
 get_page_from_freelist+0xc4d/0xe50
 __alloc_pages+0x172/0x320
 alloc_pages_vma+0x84/0x230
 shmem_alloc_page+0x3f/0x90
 shmem_alloc_and_acct_page+0x76/0x1c0
 shmem_getpage_gfp+0x48d/0x890
 shmem_write_begin+0x36/0xc0
 generic_perform_write+0xed/0x1d0
 __generic_file_write_iter+0xdc/0x1b0
 generic_file_write_iter+0x5d/0xb0
 new_sync_write+0x11f/0x1b0
 vfs_write+0x1ba/0x2a0
 ksys_write+0x59/0xd0
 do_syscall_64+0x37/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
Charged to dying memcg libpod-conmon-fbc62060b5377479a7371cc16c5c596002945f2aa00d3d6d73a0cd0d148b6637.scope

So the page was not freed because it was part of a shmem segment. That
is useful information that can help users to diagnose similar problems.

With cgroup v1, /proc/cgroups can be read to find out the total number
of memory cgroups (online + dying). With cgroup v2, the cgroup.stat
of the root cgroup can be read to find the number of dying cgroups
(most likely pinned by dying memcgs).

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
 mm/page_owner.c | 72 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 62 insertions(+), 18 deletions(-)

-- 
2.27.0

