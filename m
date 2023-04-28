Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F2F6F1950
	for <lists+cgroups@lfdr.de>; Fri, 28 Apr 2023 15:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346243AbjD1NYQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Apr 2023 09:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346238AbjD1NYO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Apr 2023 09:24:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6876E46
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f9af249edso165485817b3.1
        for <cgroups@vger.kernel.org>; Fri, 28 Apr 2023 06:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682688252; x=1685280252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FzrFpmnoCmeFQ217D+x4Ju8+C0DQecKfFykJdZXOk=;
        b=ahJ5tf1zjA7jhOV/9LiwCRyuWOWHRwEdLk7R0d3XMmILa09rKnfx5nny2uPly2tetM
         yQe3PTogi+hkDTWAyAo3/jS9Bq4LZKPSzrbVPycPHL0j37hx58O3J7vo7Edyyivmccmm
         18Pb9GBVLPvYnxrvGeLG3aEwVfIhh0fflwdlhi4SSOB7+PY4t+ZYcJNyWcYRam9KFuAA
         PmhzEKiIFCk0EIXEsZHJ8Nv/iwsB92yyqpsd4da+lc/aDt5ZKzGH3eSQwh3kWSWXQgsr
         XAdD201Y1DEr8SPDG9gavkbwwkpUB/LVYwXboCYPhs7zxuzM6GotdmSf09vq72UBrtAr
         SZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682688252; x=1685280252;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+FzrFpmnoCmeFQ217D+x4Ju8+C0DQecKfFykJdZXOk=;
        b=YdZEPMA+T5Lw3xCoVij/aPUqsoiAWMS+wvRLmU7aiOzf/W7cphzWylHIAnvMbm46Zw
         Wum3fImlqE4yMfs1gmhLRGUYAb1L13fWamsEbUO8ewYS1XoX/Yg9Q0vZXbZE81OkdQNV
         +a/g5EsuiUZPVYosG3/LXoRmpkn1+eicOqntQsGNClivz2QP3usCoPRhFvkoAd2mm3W6
         +i41cVuAv7ajvyP9teBHdWpatrFyL2Yv7iJYV7NocgGtLPoxbU4p6sOhqjJKxe3UE23U
         NEJSS+sNQYENNa7grG5zqOUgw/BMuanRSFgYSfn4WuipZHPrDTKdoODD0JbU+6J36D5J
         KD1A==
X-Gm-Message-State: AC+VfDwiIesMN6cdjvSnsn3vvldwFLy5w/J4tduEGIIKFKYFtRFx3TJo
        +RDhusCcqHZx3+TbmaeWB7k4j1HEVTAjggH3
X-Google-Smtp-Source: ACHHUZ6GoDmbt3beV9QlXSTxOyplLo7KKBwAqbwxaQGER72TavmJAupPAyv7ANVUtRJ7bxflY5Y1p3fIF8lhgUMf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:431e:0:b0:54c:fd7:476e with SMTP id
 q30-20020a81431e000000b0054c0fd7476emr3309474ywa.3.1682688252124; Fri, 28 Apr
 2023 06:24:12 -0700 (PDT)
Date:   Fri, 28 Apr 2023 13:24:05 +0000
In-Reply-To: <20230428132406.2540811-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230428132406.2540811-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428132406.2540811-2-yosryahmed@google.com>
Subject: [PATCH v2 1/2] memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>, Chris Li <chrisl@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, we format all the memcg stats into a buffer in
mem_cgroup_print_oom_meminfo() and use pr_info() to dump it to the logs.
However, this buffer is large in size. Although it is currently working
as intended, ther is a dependency between the memcg stats buffer and the
printk record size limit.

If we add more stats in the future and the buffer becomes larger than
the printk record size limit, or if the prink record size limit is
reduced, the logs may be truncated.

It is safer to use seq_buf_do_printk(), which will automatically break
up the buffer at line breaks and issue small printk() calls.

Refactor the code to move the seq_buf from memory_stat_format() to its
callers, and use seq_buf_do_printk() to print the seq_buf in
mem_cgroup_print_oom_meminfo().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/memcontrol.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5abffe6f8389..5922940f92c9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1551,13 +1551,10 @@ static inline unsigned long memcg_page_state_output(struct mem_cgroup *memcg,
 	return memcg_page_state(memcg, item) * memcg_page_state_unit(item);
 }
 
-static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
+static void memory_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
-	struct seq_buf s;
 	int i;
 
-	seq_buf_init(&s, buf, bufsize);
-
 	/*
 	 * Provide statistics on the state of the memory subsystem as
 	 * well as cumulative event counters that show past behavior.
@@ -1574,21 +1571,21 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		u64 size;
 
 		size = memcg_page_state_output(memcg, memory_stats[i].idx);
-		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
+		seq_buf_printf(s, "%s %llu\n", memory_stats[i].name, size);
 
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
 			size += memcg_page_state_output(memcg,
 							NR_SLAB_RECLAIMABLE_B);
-			seq_buf_printf(&s, "slab %llu\n", size);
+			seq_buf_printf(s, "slab %llu\n", size);
 		}
 	}
 
 	/* Accumulated memory events */
-	seq_buf_printf(&s, "pgscan %lu\n",
+	seq_buf_printf(s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
 		       memcg_events(memcg, PGSCAN_DIRECT) +
 		       memcg_events(memcg, PGSCAN_KHUGEPAGED));
-	seq_buf_printf(&s, "pgsteal %lu\n",
+	seq_buf_printf(s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT) +
 		       memcg_events(memcg, PGSTEAL_KHUGEPAGED));
@@ -1598,13 +1595,13 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		    memcg_vm_event_stat[i] == PGPGOUT)
 			continue;
 
-		seq_buf_printf(&s, "%s %lu\n",
+		seq_buf_printf(s, "%s %lu\n",
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
 	}
 
 	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	WARN_ON_ONCE(seq_buf_has_overflowed(s));
 }
 
 #define K(x) ((x) << (PAGE_SHIFT-10))
@@ -1642,6 +1639,7 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 	/* Use static buffer, for the caller is holding oom_lock. */
 	static char buf[PAGE_SIZE];
+	struct seq_buf s;
 
 	lockdep_assert_held(&oom_lock);
 
@@ -1664,8 +1662,9 @@ void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 	pr_info("Memory cgroup stats for ");
 	pr_cont_cgroup_path(memcg->css.cgroup);
 	pr_cont(":");
-	memory_stat_format(memcg, buf, sizeof(buf));
-	pr_info("%s", buf);
+	seq_buf_init(&s, buf, sizeof(buf));
+	memory_stat_format(memcg, &s);
+	seq_buf_do_printk(&s, KERN_INFO);
 }
 
 /*
@@ -6573,10 +6572,12 @@ static int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	struct seq_buf s;
 
 	if (!buf)
 		return -ENOMEM;
-	memory_stat_format(memcg, buf, PAGE_SIZE);
+	seq_buf_init(&s, buf, PAGE_SIZE);
+	memory_stat_format(memcg, &s);
 	seq_puts(m, buf);
 	kfree(buf);
 	return 0;
-- 
2.40.1.495.gc816e09b53d-goog

