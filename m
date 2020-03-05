Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE7617AAC1
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2020 17:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEQoH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 11:44:07 -0500
Received: from foss.arm.com ([217.140.110.172]:51010 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgCEQoH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 5 Mar 2020 11:44:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34BD330E;
        Thu,  5 Mar 2020 08:44:07 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19CB93F534;
        Thu,  5 Mar 2020 08:44:05 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm: Make mem_cgroup_id_get_many() __maybe_unused
Date:   Thu,  5 Mar 2020 16:43:54 +0000
Message-Id: <20200305164354.48147-1-vincenzo.frascino@arm.com>
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

Make mem_cgroup_id_get_many() __maybe_unused to address the issue.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776cd6e10..2b9533ed52f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4794,7 +4794,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
 	}
 }
 
-static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
+static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
+						  unsigned int n)
 {
 	refcount_add(n, &memcg->id.ref);
 }
-- 
2.25.1

