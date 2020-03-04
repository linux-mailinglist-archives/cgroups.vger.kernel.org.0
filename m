Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1FF17923D
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 15:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgCDOYE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 09:24:04 -0500
Received: from foss.arm.com ([217.140.110.172]:34938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbgCDOYE (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 4 Mar 2020 09:24:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3FF31B;
        Wed,  4 Mar 2020 06:24:03 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D5D63F6CF;
        Wed,  4 Mar 2020 06:24:02 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and MEMCG_SWAP
Date:   Wed,  4 Mar 2020 14:23:48 +0000
Message-Id: <20200304142348.48167-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
configuration options are enabled. Having them disabled triggers the
following warning at compile time:

linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
but not used [-Wunused-function]
 static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
 int n)

Make mem_cgroup_id_get_many() dependent on MMU and MEMCG_SWAP to address
the issue.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/memcontrol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776cd6e10..628cebeb4bdd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4794,10 +4794,12 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
+#if defined(CONFIG_MEMCG_SWAP) || defined(CONFIG_MMU)
 static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
 {
 	refcount_add(n, &memcg->id.ref);
 }
+#endif
 
 static void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n)
 {
-- 
2.25.1

