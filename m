Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742A075A753
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 09:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjGTHJY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 03:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjGTHIs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 03:08:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E5326B8
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57059f90cc5so5536147b3.0
        for <cgroups@vger.kernel.org>; Thu, 20 Jul 2023 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689836921; x=1692428921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n6O0Lt5KhyslMSHzCGrHaCXx7KAwNPu5E55KNetzzTM=;
        b=sV87N/HxxcZHHL1alJO5nBf8HzjYMdw6nkcR38Ddq2rUuAf28cTRr0rb709fkiRMW+
         qEy3FdhFn01ikwkfx7y9qLguXlaMHGLFmuRtJXH+L+mW9RyHbcOJWlAUGrGs6aAu/INw
         41Y2qTn8C7MjL6RvRw/y0YgIGxiJWL68zL7cWNRAYxyzZ5Cms/cFb5dUzlTJ6iCOM/ec
         43odK5EQY91sLY+01W8AhKo4cVLmfc3JuvWr3teNDoKfkk1Lyj7dpYXltbO4KTOFr6c4
         DheP8D0OnAwjx0EXPzUp5uV1Ui6HMxgha12C+iK56/iEaIj2+ON6C0S7v2ijUdptonk9
         M9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836921; x=1692428921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6O0Lt5KhyslMSHzCGrHaCXx7KAwNPu5E55KNetzzTM=;
        b=DDQsqTc2gTKNyeIOn9kkuW21Zf4iKV1aHYSkbZxmp+ljjJWJF6+xFfLQ7h7wWLnf3/
         X+cogBWCPZDa4N30CRq/R6YUoz9mkHj+/BY4YHZOwGJLOqGW4wSODSSrgDqGvnEKCV6E
         iNJOCWhqFoYk1jaryWd8tBD9yVji1QZWniFlUGp8AKKhXeHJr/LHdhkH/H1xVM4e6zxI
         wNj6HrfORvStamDMCxWFXiMpnOWJZDA+SJ5Np7/7+bPiMyTMw6hZQ9bIf+b4pmf8FhIM
         8Ry4TIbeCbGzbMRJv1b7w0vP8p3Rbnk8myXwe6S5GbRW9SYeHaeB5UnbcNnTHo/wLJI/
         g5iQ==
X-Gm-Message-State: ABy/qLYaE7aNSFkXHu8TNberWAANuYx1U8rviJ21/JsF0AjzbESMH3Fh
        fIQ5XaLrpxxs6Uq76ZyXPWyL0wCst6zIB5/O
X-Google-Smtp-Source: APBJJlGMoGTZrbru1fVb9JslthbAiF2wsIl2HsR1Hk3nalG2jl6ctXDHaNYmeI9gMwOHtknP/aKqVV0pkkfu/CUf
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a5b:b8b:0:b0:c4c:f97e:421a with SMTP id
 l11-20020a5b0b8b000000b00c4cf97e421amr39950ybq.4.1689836920855; Thu, 20 Jul
 2023 00:08:40 -0700 (PDT)
Date:   Thu, 20 Jul 2023 07:08:24 +0000
In-Reply-To: <20230720070825.992023-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720070825.992023-8-yosryahmed@google.com>
Subject: [RFC PATCH 7/8] memcg: add sysctl and config option to control memory recharging
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a sysctl to enable/disable memory recharging for offline memcgs. Add
a config option to control whether or not it is enabled by default.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  2 ++
 kernel/sysctl.c            | 11 +++++++++++
 mm/Kconfig                 | 12 ++++++++++++
 mm/memcontrol.c            |  9 ++++++++-
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 59b653d4a76e..ae9f09ee90cb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -60,6 +60,8 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
+extern int sysctl_recharge_offline_memcgs;
+
 #define MEM_CGROUP_ID_SHIFT	16
 #define MEM_CGROUP_ID_MAX	USHRT_MAX
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 354a2d294f52..1735d1d95652 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2249,6 +2249,17 @@ static struct ctl_table vm_table[] = {
 		.extra2		= (void *)&mmap_rnd_compat_bits_max,
 	},
 #endif
+#ifdef CONFIG_MEMCG
+	{
+		.procname	= "recharge_offline_memcgs",
+		.data		= &sysctl_recharge_offline_memcgs,
+		.maxlen		= sizeof(sysctl_recharge_offline_memcgs),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_MEMCG */
 	{ }
 };
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..9462c4b598d9 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1236,6 +1236,18 @@ config LOCK_MM_AND_FIND_VMA
 	bool
 	depends on !STACK_GROWSUP
 
+config MEMCG_RECHARGE_OFFLINE_ENABLED
+	bool "Recharge memory charged to offline memcgs"
+	depends on MEMCG
+	help
+	  When a memory cgroup is removed by userspace, try to recharge any
+	  memory still charged to it to avoid having it live on as an offline
+	  memcg. Offline memcgs potentially consume memory and limit scalability
+	  of some operations.
+
+	  This option enables the above behavior by default. It can be override
+	  at runtime through /proc/sys/vm/recharge_offline_memcgs.
+
 source "mm/damon/Kconfig"
 
 endmenu
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2fe9c6f1be80..25cdb17eaaa3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,9 @@ static bool cgroup_memory_nobpf __ro_after_init;
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
 
+int sysctl_recharge_offline_memcgs __read_mostly = IS_ENABLED(
+		CONFIG_MEMCG_RECHARGE_OFFLINE_ENABLED);
+
 static struct workqueue_struct *memcg_recharge_wq;
 
 /* Whether legacy memory+swap accounting is active */
@@ -6592,7 +6595,8 @@ static void memcg_recharge_mapped_folios(struct mem_cgroup *memcg)
 	INIT_DELAYED_WORK(&memcg->recharge_mapped_work.dwork,
 			  memcg_do_recharge_mapped_folios);
 
-	if (memcg_recharge_wq && memcg_nr_local_mapped_pages(memcg)) {
+	if (sysctl_recharge_offline_memcgs &&
+	    memcg_recharge_wq && memcg_nr_local_mapped_pages(memcg)) {
 		memcg->recharge_mapped_work.retries = 0;
 		queue_delayed_work(memcg_recharge_wq,
 				   &memcg->recharge_mapped_work.dwork, 0);
@@ -6605,6 +6609,9 @@ static bool should_do_deferred_recharge(struct folio *folio)
 	struct mem_cgroup *memcg;
 	bool ret;
 
+	if (!sysctl_recharge_offline_memcgs)
+		return false;
+
 	rcu_read_lock();
 	memcg = folio_memcg_rcu(folio);
 	ret = memcg && !!(memcg->css.flags & CSS_DYING);
-- 
2.41.0.255.g8b1d071c50-goog

