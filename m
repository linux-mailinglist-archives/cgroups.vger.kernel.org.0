Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B364A0139
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 20:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349872AbiA1T5d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 14:57:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351005AbiA1T52 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 14:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643399848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4AGco3DPR26g1wodgd1tvssEUzEAzvT6zrwEdwptTuI=;
        b=O2RyyyQTcsLDCoHy8P5gN8RCTM1P4YNXAecVG4YyurJgpeF3ccBj+M1Lp9QxbYrIyI5j3y
        ufRV1HV1qtI2WYNTrQI3wIXB8GodNA8Jwo8+XXNqTcFyB4UNabUVOi8uFbE6KBZYkYZzNa
        3m7mWRsPexD8D18VIAapfM+oqB9cyXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-fDMU9u6qPrK01Ep4O1Qnuw-1; Fri, 28 Jan 2022 14:57:24 -0500
X-MC-Unique: fDMU9u6qPrK01Ep4O1Qnuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 818EF1083F64;
        Fri, 28 Jan 2022 19:57:23 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D5925DB82;
        Fri, 28 Jan 2022 19:57:10 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 0/2] mm/page_owner: Extend page_owner to show memcg
Date:   Fri, 28 Jan 2022 14:56:40 -0500
Message-Id: <20220128195642.416743-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

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

Waiman Long (2):
  mm/page_owner: Introduce SNPRINTF() macro that includes length error
    check
  mm/page_owner: Dump memcg information

 mm/page_owner.c | 76 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 26 deletions(-)

-- 
2.27.0

