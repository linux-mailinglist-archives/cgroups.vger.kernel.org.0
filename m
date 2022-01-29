Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56564A31EA
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 21:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353154AbiA2Uxu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jan 2022 15:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231767AbiA2Uxu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jan 2022 15:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643489629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sryFgTCSFHX+LlbTjqU4BHuCFjlOyZxrEe4xCO3rDAc=;
        b=TKZG6Uqr7+NHBTjcGbv44utqlXgrIhxlYVNUggLiRasjDmc607k70QUpCt3ZRPY5fwLBta
        GrISyGci5bZdSn4Z3WTDXhvMRTcjuvTIreaDDJwC0qpOHe2RgFwdh10xmbcyQOxc3XqH0C
        Oh6oAHzDjdEnLdbgubcAY6OH6dKZm7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-nmrD0L9aMs-rQecuq2Gl_w-1; Sat, 29 Jan 2022 15:53:46 -0500
X-MC-Unique: nmrD0L9aMs-rQecuq2Gl_w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3B8683DD20;
        Sat, 29 Jan 2022 20:53:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BB0D5E24E;
        Sat, 29 Jan 2022 20:53:41 +0000 (UTC)
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
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 0/3] mm/page_owner: Extend page_owner to show memcg information
Date:   Sat, 29 Jan 2022 15:53:12 -0500
Message-Id: <20220129205315.478628-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Page allocated via order 0, mask 0x1100cca(GFP_HIGHUSER_MOVABLE), pid 62760, ts 119274296592 ns, free_ts 118989764823 ns
PFN 1273412 type Movable Block 2487 type Movable Flags 0x17ffffc00c001c(uptodate|dirty|lru|reclaim|swapbacked|node=0|zone=2|lastcpupid=0x1fffff)
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
Charged to offlined memcg libpod-conmon-e59cc83faf807bacc61223fec6a80c1540ebe8f83c802870c6af4708d58f77ea

So the page was not freed because it was part of a shmem segment. That
is useful information that can help users to diagnose similar problems.

Waiman Long (3):
  lib/vsprintf: Avoid redundant work with 0 size
  mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
  mm/page_owner: Dump memcg information

 lib/vsprintf.c  |  8 +++++---
 mm/page_owner.c | 45 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 39 insertions(+), 14 deletions(-)

-- 
2.27.0

