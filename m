Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B811F6EF59A
	for <lists+cgroups@lfdr.de>; Wed, 26 Apr 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbjDZNj1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Apr 2023 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240627AbjDZNj0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Apr 2023 09:39:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789181733
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 06:39:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f6dd3b329so118123847b3.0
        for <cgroups@vger.kernel.org>; Wed, 26 Apr 2023 06:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682516364; x=1685108364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NvDSnUS+MAA09hIqW3zUQhLkSsb1P4vBALA1mlThJ28=;
        b=aqdVpamTrjskGChIniYGsRwA8ufOxvP8FBQ/+/4SveoiRC/z/63BLZMtn021IyYVPH
         uF+kXYDs12M8b1BiTt6vyIpxzNIKQZwmmxGpOAGtuC+q1jVvmNH2SESK7inczKUamn3G
         th86Vzgr9WoCq31/yzzNvEiaP7RX6w9o/lcQDGmQZaR/qRHgyMWFZS8Z5Q6b8Y9x6QWD
         EXhkCqc5cbXomQgd2caoK3DuWBuZH5A+ghpQNxakhvKtZa/TVIUUxnv6WL5pDy5ZB0Ez
         xhplPlyQ6i/IKh0qKiWGI4Jvd/Yk/5R44c77s7+KAN34iQC7UO+g/zDrsosVqBapM/m/
         DXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682516364; x=1685108364;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvDSnUS+MAA09hIqW3zUQhLkSsb1P4vBALA1mlThJ28=;
        b=VIrBnNl0kX+mg+thaUVlt2UhoB5CPa0CpX4tsZq5lBI/YI/ANpQD7R5Z4OotlhYTDt
         39ZdMctWuep3sJ6WdvBFk5UiLfmF/vy4C772YuknVx6o3m8w9ckQ1ycVykChrD65jyyA
         ghGmHmkTbEv4ufa5dSuo07XNia+OWSeGVd3X1GFgUWj4fDboKf+sSi5wb10J06NnsW9h
         cDgYx5KrVj0BYI6bQ1rlmf6tJ7rFxDGrJDnX4n6e6/oqqtrAhdkY5pBnHPxNyrA8w+Ri
         86lFXtDKKp7tszcO0+G9AHb+QRJ9RjMuFhNphL71BbUQUH68Hebk7uUBcwIuczkqnCcH
         k9Dg==
X-Gm-Message-State: AC+VfDzMKsmy/I+8MKD+rQ29eUdaGmof+7wHlmBJ9JJaEeqUS99KiRWt
        3yNUcMzvCyLHRlOb0u+Or1Py3jCTJUFS7VaF
X-Google-Smtp-Source: ACHHUZ7BrencnsXSFnxZRqIJpm8puEkhg0w+PJX56s0RsOTeawPQAUSgeFXgLPLsqpHa4JBuyBH8e8Z6laJUJDz5
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:441f:0:b0:556:b875:500e with SMTP
 id r31-20020a81441f000000b00556b875500emr4361688ywa.5.1682516364732; Wed, 26
 Apr 2023 06:39:24 -0700 (PDT)
Date:   Wed, 26 Apr 2023 13:39:18 +0000
In-Reply-To: <20230426133919.1342942-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230426133919.1342942-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230426133919.1342942-2-yosryahmed@google.com>
Subject: [PATCH 1/2] memcg: use seq_buf_do_printk() with mem_cgroup_print_oom_meminfo()
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
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

