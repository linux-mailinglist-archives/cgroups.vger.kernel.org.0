Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF3E56F31
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfFZQ4s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:56:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfFZQ4s (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Jun 2019 12:56:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 286DE83F3C;
        Wed, 26 Jun 2019 16:56:33 +0000 (UTC)
Received: from llong.com (dhcp-17-85.bos.redhat.com [10.18.17.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C46A119C5B;
        Wed, 26 Jun 2019 16:56:29 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] memcg: Add kmem.slabinfo to v2 for debugging purpose
Date:   Wed, 26 Jun 2019 12:56:14 -0400
Message-Id: <20190626165614.18586-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Wed, 26 Jun 2019 16:56:48 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

With memory cgroup v1, there is a kmem.slabinfo file that can be
used to view what slabs are allocated to the memory cgroup. There
is currently no such equivalent in memory cgroup v2. This file can
be useful for debugging purpose.

This patch adds an equivalent kmem.slabinfo to v2 with the caveat that
this file will only show up as ".__DEBUG__.memory.kmem.slabinfo" when the
"cgroup_debug" parameter is specified in the kernel boot command line.
This is to avoid cluttering the cgroup v2 interface with files that
are seldom used by end users.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba9138a4a1de..236554a23f8f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5812,6 +5812,22 @@ static struct cftype memory_files[] = {
 		.seq_show = memory_oom_group_show,
 		.write = memory_oom_group_write,
 	},
+#ifdef CONFIG_MEMCG_KMEM
+	{
+		/*
+		 * This file is for debugging purpose only and will show
+		 * up as ".__DEBUG__.memory.kmem.slabinfo" when the
+		 * "cgroup_debug" parameter is specified in the kernel
+		 * boot command line.
+		 */
+		.name = "kmem.slabinfo",
+		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_DEBUG,
+		.seq_start = memcg_slab_start,
+		.seq_next = memcg_slab_next,
+		.seq_stop = memcg_slab_stop,
+		.seq_show = memcg_slab_show,
+	},
+#endif
 	{ }	/* terminate */
 };
 
-- 
2.18.1

