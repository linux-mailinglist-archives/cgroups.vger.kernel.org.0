Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10B14A4F59
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 20:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359382AbiAaTX2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 14:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46391 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359530AbiAaTX1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 14:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643657007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=r2v/Wpxpyf53Gc+td9aFV8h4H9KkP9JhzJaU9W2Ncas=;
        b=OYNnFYEX83tX1cAeisMpYbBJWia2nevTeS7bUAsqUdEPAR8lKUrHjS8mZRcHyJKlXFIErg
        +xXCitGWsMemZRuGXxL0WqUH8eFjfmVrgKcclZFg6M+ZCsUMBSMeTKopue/U1S2/46ZRWZ
        hQ/9SAiY5Fpfqn4+jCS7PwcaT8js034=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-wGadArTENUapG0zdubBHnQ-1; Mon, 31 Jan 2022 14:23:23 -0500
X-MC-Unique: wGadArTENUapG0zdubBHnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6971083F67;
        Mon, 31 Jan 2022 19:23:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFD2810013C1;
        Mon, 31 Jan 2022 19:23:18 +0000 (UTC)
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
Subject: [PATCH v3 0/4] mm/page_owner: Extend page_owner to show memcg information
Date:   Mon, 31 Jan 2022 14:23:04 -0500
Message-Id: <20220131192308.608837-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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
lot of offlined mem_cgroup structures remained in place without being
freed. Further investigation indicated that those mem_cgroup structures
were pinned by some pages.

In order to find out what those pages are, the existing page_owner
debugging tool is extended to show memory cgroup information and whether
those memcgs are offlined or not. With the enhanced page_owner tool,
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
Charged to offlined memcg libpod-conmon-15e4f9c758422306b73b2dd99f9d50a5ea53cbb16b4a13a2c2308a4253cc0ec8.

So the page was not freed because it was part of a shmem segment. That
is useful information that can help users to diagnose similar problems.

Waiman Long (4):
  lib/vsprintf: Avoid redundant work with 0 size
  mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
  mm/page_owner: Print memcg information
  mm/page_owner: Record task command name

 lib/vsprintf.c  |  8 +++---
 mm/page_owner.c | 69 ++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 18 deletions(-)

-- 
2.27.0

