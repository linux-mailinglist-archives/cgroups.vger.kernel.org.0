Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5D2620B3
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 22:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgIHUOi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 16:14:38 -0400
Received: from rcdn-iport-9.cisco.com ([173.37.86.80]:59051 "EHLO
        rcdn-iport-9.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbgIHUOd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 16:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1785; q=dns/txt; s=iport;
  t=1599596072; x=1600805672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T8mkCE6PfAz3UDsDi/PeT6rnbi3jy36h40OMXp16Ecg=;
  b=jCZK8OZ67a1lYCRulutuBlJ13wtVq7igOdRqKQokHP+OckMclQuQ58KZ
   wPCavBuUZa0qw1h1O+GliN6ZWXTX+7OfFwavQxMw3TVuj1rcSfgVuwmBn
   vklexWsVe6KNiXdYSJFGHv8wOkLt8MmTCqYwjamimMfO62drJJwpiarg9
   8=;
X-IronPort-AV: E=Sophos;i="5.76,406,1592870400"; 
   d="scan'208";a="732193483"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 08 Sep 2020 20:14:30 +0000
Received: from sjc-ads-9087.cisco.com (sjc-ads-9087.cisco.com [10.30.208.97])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTP id 088KETHu020960;
        Tue, 8 Sep 2020 20:14:30 GMT
Received: by sjc-ads-9087.cisco.com (Postfix, from userid 396877)
        id BDD7AA40; Tue,  8 Sep 2020 13:14:29 -0700 (PDT)
From:   Julius Hemanth Pitti <jpitti@cisco.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, guro@fb.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xe-linux-external@cisco.com,
        Julius Hemanth Pitti <jpitti@cisco.com>
Subject: [PATCH v2] mm: memcg: yield cpu when we fail to charge pages
Date:   Tue,  8 Sep 2020 13:14:26 -0700
Message-Id: <20200908201426.14837-1-jpitti@cisco.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.30.208.97, sjc-ads-9087.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For non root CG, in try_charge(), we keep trying
to charge until we succeed. On non-preemptive
kernel, when we are OOM, this results in holding
CPU forever.

On SMP systems, this doesn't create a big problem
because oom_reaper get a change to kill victim
and make some free pages. However on a single-core
CPU (or cases where oom_reaper pinned to same CPU
where try_charge is executing), oom_reaper shall
never get scheduled and we stay in try_charge forever.

Steps to repo this on non-smp:
1. mount -t tmpfs none /sys/fs/cgroup
2. mkdir /sys/fs/cgroup/memory
3. mount -t cgroup none /sys/fs/cgroup/memory -o memory
4. mkdir /sys/fs/cgroup/memory/0
5. echo 40M > /sys/fs/cgroup/memory/0/memory.limit_in_bytes
6. echo $$ > /sys/fs/cgroup/memory/0/tasks
7. stress -m 5 --vm-bytes 10M --vm-hang 0

Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>
Acked-by: Roman Gushchin <guro@fb.com>
---

Changes in v2:
 - Added comments.
 - Added "Acked-by: Roman Gushchin <guro@fb.com>".
---
 mm/memcontrol.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cfa6cbad21d5..4f293bf8c7ed 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2745,6 +2745,15 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (fatal_signal_pending(current))
 		goto force;
 
+	/*
+	 * We failed to charge even after retries, give oom_reaper or
+	 * other process a change to make some free pages.
+	 *
+	 * On non-preemptive, Non-SMP system, this is critical, else
+	 * we keep retrying with no success, forever.
+	 */
+	cond_resched();
+
 	/*
 	 * keep retrying as long as the memcg oom killer is able to make
 	 * a forward progress or bypass the charge if the oom killer
-- 
2.17.1

