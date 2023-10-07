Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460AC7BC7ED
	for <lists+cgroups@lfdr.de>; Sat,  7 Oct 2023 15:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343627AbjJGNJV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Oct 2023 09:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjJGNJU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Oct 2023 09:09:20 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3506CB6;
        Sat,  7 Oct 2023 06:09:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bdf4752c3cso21653965ad.2;
        Sat, 07 Oct 2023 06:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696684158; x=1697288958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMaVybiPBatBJav/uAY5haebs3qdPaDSXyI+W1B54LU=;
        b=J16e16zcN2hHuItZAqDET8T6zGvBuIaDmEZ0kYpTsqTHSTlQLrRUs0bdNenr+u0nVH
         bQMts4RfBFYxF+9lyA7OD0BVuqQlIZyD0NrIFBgNIlsmfSicqTD+PAAvNTbnXTiZDLGa
         cYtW3mvrrbCVXqP9PeTib9p9x88eu2eCenCNDAjD3ILKaVM/Gf19B0Dweehg7GX0pNNr
         Zm9ZPGpWIAUCgYOibHoPOeJXKYZLfdUyPcRLR2tXs2keuMR39I7xM3szO6u5uxeiwomW
         R2F0ihAc1DAYa487+L36NU3RoQZaQehpFyqY6+j8pmFrMuVgFdkmUDrKI0bEzrfN1ztJ
         sBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696684158; x=1697288958;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMaVybiPBatBJav/uAY5haebs3qdPaDSXyI+W1B54LU=;
        b=hyt5mEHpdceZNcTKTWdKgztTgy833gP1cjXOJY64fOO8fb4MEnh0N9Xqyy89xoEsZB
         YXqrfQX9/tM2G2Vgu3EGqmYH0+MlWzQ4YIW9IDj017a7XDVAgbfKAe3bwHUhf1a53iGj
         6U1BpOztnSPdbQev8VNlFh06egDb+C8ZXq2mztWct8bvU3jPdL5vgcY49d5Sw1irGsNu
         FUC/c5m4b7bnP7GTK/R6IXd/bHLAL4bpctRRJ5vQya30vCyXqUWIAIjucaOFjfO6aooS
         fVAOLGwznuuXszCk0juak5L899OVy8o54cGgREs1iULoc5PBE1Li7xCxJUbhM5yLOO4o
         qJoQ==
X-Gm-Message-State: AOJu0Yx6qt5YMGuPAtgDz63qXzHhgSEqVMlpmrkx+ZQWdw06n6ndsWRX
        CmyLYEReFp8yUmNihmbN/GFC9hdbO7AUHxOx
X-Google-Smtp-Source: AGHT+IFaP6eO2guWjq/4dtQ6Exq/ime9W2re4abFClQj8KUDhyM4H+ySjxMg1zDh0IzF3fPDy7Ob/Q==
X-Received: by 2002:a17:90b:1997:b0:26d:54de:b0d6 with SMTP id mv23-20020a17090b199700b0026d54deb0d6mr9656193pjb.20.1696684158515;
        Sat, 07 Oct 2023 06:09:18 -0700 (PDT)
Received: from C02FV47ZMD6T.corp.ebay.com ([202.76.247.146])
        by smtp.googlemail.com with ESMTPSA id fw14-20020a17090b128e00b002680b2d2ab6sm7130957pjb.19.2023.10.07.06.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 06:09:18 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
X-Google-Original-From: Jianlin Lv <jianlv@ebay.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, muchun.song@linux.dev,
        akpm@linux-foundation.org, yosryahmed@google.com,
        willy@infradead.org, linmiaohe@huawei.com,
        wangkefeng.wang@huawei.com, laoar.shao@gmail.com,
        yuzhao@google.com, wuyun.abel@bytedance.com, david@redhat.com,
        ying.huang@intel.com, peterx@redhat.com, vishal.moola@gmail.com,
        hughd@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, jianlv@ebay.com,
        iecedge@gmail.com
Subject: [PATCH] memcg: add interface to force disable swap
Date:   Sat,  7 Oct 2023 21:09:05 +0800
Message-ID: <20231007130905.78554-1-jianlv@ebay.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Jianlin Lv <iecedge@gmail.com>

Global reclaim will swap even if swappiness is set to 0. In particular
case, users wish to be able to completely disable swap for specific
processes. One scenario is that if JVM memory pages falls into swap,
the performance will noticeably reduce and the GC pauses tend to increase
to levels not tolerable by most applications.
If it's possible to only disable swap out for specific processes, it can
address the JVM GC pauses issues, and at the same time, memory reclaim
pressure is also manageable.

This patch adds "memory.swap_force_disable" control file to support disable
swap for non-root cgroup. When process is associated with a cgroup,
'echo 1 > memory.swap_force_disable' will forbid anon pages be swapped out.
This patch also adds read and write handler of the control file.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 .../admin-guide/cgroup-v1/memory.rst          | 15 ++++++++++
 include/linux/memcontrol.h                    |  1 +
 include/linux/swap.h                          | 15 ++++++++++
 mm/memcontrol.c                               | 28 +++++++++++++++++++
 mm/vmscan.c                                   |  3 +-
 5 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index ff456871bf4b..be84b98bc6fe 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -86,6 +86,7 @@ Brief summary of control files.
  memory.pressure_level		     set memory pressure notifications
  memory.swappiness		     set/show swappiness parameter of vmscan
 				     (See sysctl's vm.swappiness)
+ memory.swap_force_disable           set/show force disable swap
  memory.move_charge_at_immigrate     set/show controls of moving charges
                                      This knob is deprecated and shouldn't be
                                      used.
@@ -615,6 +616,20 @@ enforces that 0 swappiness really prevents from any swapping even if
 there is a swap storage available. This might lead to memcg OOM killer
 if there are no file pages to reclaim.
 
+swap_force_disable is used to allow control group to disable swap even if swap
+storage is available. This feature is disabled by default. If you want to
+disable swap for specified processes, swap_force_disable can be setup by
+following commands::
+
+	# cd /sys/fs/cgroup/memory/
+	# mkdir test
+	# cd test
+	# echo 1 > memory.swap_force_disable
+	# echo <PID> > cgroup.procs
+
+.. note::
+	swap_force_disable only take effect for non-root cgroups.
+
 5.4 failcnt
 -----------
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e4e24da16d2c..b26dcb0756c0 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -246,6 +246,7 @@ struct mem_cgroup {
 	int		under_oom;
 
 	int	swappiness;
+	int	swap_force_disable;
 	/* OOM-Killer disable */
 	int		oom_kill_disable;
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 493487ed7c38..b202de576984 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -624,6 +624,21 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 }
 #endif
 
+#ifdef CONFIG_MEMCG
+static inline int mem_cgroup_swap_force_disable(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled() || mem_cgroup_is_root(memcg))
+		return 0;
+
+	return memcg->swap_force_disable;
+}
+#else
+static inline int mem_cgroup_swap_force_disable(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+#endif
+
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
 void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp);
 static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5b009b233ab8..024750444c79 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4196,6 +4196,28 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
 	return 0;
 }
 
+static u64 mem_cgroup_swap_force_disable_read(struct cgroup_subsys_state *css,
+					struct cftype *cft)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	return mem_cgroup_swap_force_disable(memcg);
+}
+
+static int mem_cgroup_swap_force_disable_write(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	/* cannot set to root cgroup and only 0 and 1 are allowed */
+	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
+		return -EINVAL;
+
+	memcg->swap_force_disable = val;
+
+	return 0;
+}
+
 static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
 {
 	struct mem_cgroup_threshold_ary *t;
@@ -5064,6 +5086,11 @@ static struct cftype mem_cgroup_legacy_files[] = {
 		.read_u64 = mem_cgroup_swappiness_read,
 		.write_u64 = mem_cgroup_swappiness_write,
 	},
+	{
+		.name = "swap_force_disable",
+		.read_u64 = mem_cgroup_swap_force_disable_read,
+		.write_u64 = mem_cgroup_swap_force_disable_write,
+	},
 	{
 		.name = "move_charge_at_immigrate",
 		.read_u64 = mem_cgroup_move_charge_read,
@@ -5367,6 +5394,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
+		WRITE_ONCE(memcg->swap_force_disable, mem_cgroup_swap_force_disable(parent));
 		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 
 		page_counter_init(&memcg->memory, &parent->memory);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..5fdb4ac07007 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3029,6 +3029,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	unsigned long anon_cost, file_cost, total_cost;
 	int swappiness = mem_cgroup_swappiness(memcg);
+	int swap_force_disable = mem_cgroup_swap_force_disable(memcg);
 	u64 fraction[ANON_AND_FILE];
 	u64 denominator = 0;	/* gcc */
 	enum scan_balance scan_balance;
@@ -3036,7 +3037,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	enum lru_list lru;
 
 	/* If we have no swap space, do not bother scanning anon folios. */
-	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
+	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc) || swap_force_disable) {
 		scan_balance = SCAN_FILE;
 		goto out;
 	}
-- 
2.34.1

