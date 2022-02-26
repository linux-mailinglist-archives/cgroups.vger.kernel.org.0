Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBC4C5804
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 21:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiBZUm2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Feb 2022 15:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiBZUm1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Feb 2022 15:42:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38FD244A3C
        for <cgroups@vger.kernel.org>; Sat, 26 Feb 2022 12:41:52 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645908110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCAlyN0P4ukGqzwBCvXW6Rkz9k8c5aTlYxZl8s5hStA=;
        b=fCdNKAjBl9vrngXspjT4kthbVsz22PPfH6UHiXaEHFCeN4KcqBX5IWCdsnsQUUVeexcNtL
        SpTlOdFuj7/zHfimvuMqbtbGYTjYzJzbUguDj1VuRv/it0vVlhImh/XOCUyxgAEW3NKxpX
        AV+9TpdXiMxDBv0N4ClnwthK/6LHCVLTGNOjBszWLe2oRVdzq+bidJqB+U8vfXKhr0Xm2u
        +gL3IDLk4MNGj72E2QIwbCl623ngVtj/CS4KBtiP/r6pYEX+stf3R34MENtey27SATvQyh
        K2kcybvipOdQa+fO6RkZcLN41ytpd73Foq22M0NJd+mHDeI30UyL9l4iC7i60w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645908110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCAlyN0P4ukGqzwBCvXW6Rkz9k8c5aTlYxZl8s5hStA=;
        b=Rs1WEMa1ifWXq4y53hwbdfO0lQ0WYxNEVxrEC0jtRH0+Aq8afuL4MsApwNy5YZnE8gQhaZ
        c0dc4lNFT6zIGlBw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v5 2/6] mm/memcg: Disable threshold event handlers on PREEMPT_RT
Date:   Sat, 26 Feb 2022 21:41:40 +0100
Message-Id: <20220226204144.1008339-3-bigeasy@linutronix.de>
In-Reply-To: <20220226204144.1008339-1-bigeasy@linutronix.de>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During the integration of PREEMPT_RT support, the code flow around
memcg_check_events() resulted in `twisted code'. Moving the code around
and avoiding then would then lead to an additional local-irq-save
section within memcg_check_events(). While looking better, it adds a
local-irq-save section to code flow which is usually within an
local-irq-off block on non-PREEMPT_RT configurations.

The threshold event handler is a deprecated memcg v1 feature. Instead of
trying to get it to work under PREEMPT_RT just disable it. There should
be no users on PREEMPT_RT. From that perspective it makes even less
sense to get it to work under PREEMPT_RT while having zero users.

Make memory.soft_limit_in_bytes and cgroup.event_control return
-EOPNOTSUPP on PREEMPT_RT. Make an empty memcg_check_events() and
memcg_write_event_control() which return only -EOPNOTSUPP on PREEMPT_RT.
Document that the two knobs are disabled on PREEMPT_RT.

Suggested-by: Michal Hocko <mhocko@kernel.org>
Suggested-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 Documentation/admin-guide/cgroup-v1/memory.rst |  2 ++
 mm/memcontrol.c                                | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation=
/admin-guide/cgroup-v1/memory.rst
index faac50149a222..2cc502a75ef64 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -64,6 +64,7 @@ Brief summary of control files.
 				     threads
  cgroup.procs			     show list of processes
  cgroup.event_control		     an interface for event_fd()
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.usage_in_bytes		     show current usage for memory
 				     (See 5.5 for details)
  memory.memsw.usage_in_bytes	     show current usage for memory+Swap
@@ -75,6 +76,7 @@ Brief summary of control files.
  memory.max_usage_in_bytes	     show max memory usage recorded
  memory.memsw.max_usage_in_bytes     show max memory+Swap usage recorded
  memory.soft_limit_in_bytes	     set/show soft limit of memory usage
+				     This knob is not available on CONFIG_PREEMPT_RT systems.
  memory.stat			     show various statistics
  memory.use_hierarchy		     set/show hierarchical account enabled
                                      This knob is deprecated and shouldn't=
 be
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8ab2dc75e70ec..0b5117ed2ae08 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -859,6 +859,9 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgrou=
p *memcg,
  */
 static void memcg_check_events(struct mem_cgroup *memcg, int nid)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return;
+
 	/* threshold event is triggered in finer grain than soft limit */
 	if (unlikely(mem_cgroup_event_ratelimit(memcg,
 						MEM_CGROUP_TARGET_THRESH))) {
@@ -3731,8 +3734,12 @@ static ssize_t mem_cgroup_write(struct kernfs_open_f=
ile *of,
 		}
 		break;
 	case RES_SOFT_LIMIT:
-		memcg->soft_limit =3D nr_pages;
-		ret =3D 0;
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			ret =3D -EOPNOTSUPP;
+		} else {
+			memcg->soft_limit =3D nr_pages;
+			ret =3D 0;
+		}
 		break;
 	}
 	return ret ?: nbytes;
@@ -4708,6 +4715,9 @@ static ssize_t memcg_write_event_control(struct kernf=
s_open_file *of,
 	char *endp;
 	int ret;
=20
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		return -EOPNOTSUPP;
+
 	buf =3D strstrip(buf);
=20
 	efd =3D simple_strtoul(buf, &endp, 10);
--=20
2.35.1

