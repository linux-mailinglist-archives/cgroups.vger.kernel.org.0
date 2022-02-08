Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B624ACD82
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 02:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbiBHBGe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 20:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiBHAGn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 19:06:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98771C061355
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 16:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644278801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PV5Mmr2VlS4HwOkDqkagpZEdfNnA+PNHZfxNlSNeOwY=;
        b=GC6E6xQHb4qhRiUBgAM/MTDp2yeJ1zGBTGApe1wdDvdlzv+gUYJ2LcPycAm/cgbsphhaZ6
        OVwKfzG5yxDX8bggYF0/Tm+V9uykFfirsYvGrZv6OeHgDISLfAn5OuVuIqVHPOn0E8ig86
        PYWpH2e1epIsvw5FLOJ4gzb6q0e2Rgg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-_M34AWNBMSe7Z7hE3yHh8Q-1; Mon, 07 Feb 2022 19:06:38 -0500
X-MC-Unique: _M34AWNBMSe7Z7hE3yHh8Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECB0018397A7;
        Tue,  8 Feb 2022 00:06:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C63395C2F1;
        Tue,  8 Feb 2022 00:06:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v5 3/4] mm/page_owner: Print memcg information
Date:   Mon,  7 Feb 2022 19:05:31 -0500
Message-Id: <20220208000532.1054311-4-longman@redhat.com>
In-Reply-To: <20220208000532.1054311-1-longman@redhat.com>
References: <20220208000532.1054311-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that a number of dying memcgs were not freed because
they were pinned by some charged pages that were present. Even "echo 1 >
/proc/sys/vm/drop_caches" wasn't able to free those pages. These dying
but not freed memcgs tend to increase in number over time with the side
effect that percpu memory consumption as shown in /proc/meminfo also
increases over time.

In order to find out more information about those pages that pin
dying memcgs, the page_owner feature is extended to print memory
cgroup information especially whether the cgroup is dying or not.
RCU read lock is taken when memcg is being accessed to make sure
that it won't be freed.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_owner.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28dac73e0542..d4c311455753 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
 #include "internal.h"
@@ -325,6 +326,47 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	seq_putc(m, '\n');
 }
 
+/*
+ * Looking for memcg information and print it out
+ */
+static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
+					 struct page *page)
+{
+#ifdef CONFIG_MEMCG
+	unsigned long memcg_data;
+	struct mem_cgroup *memcg;
+	bool dying;
+
+	rcu_read_lock();
+	memcg_data = READ_ONCE(page->memcg_data);
+	if (!memcg_data)
+		goto out_unlock;
+
+	if (memcg_data & MEMCG_DATA_OBJCGS)
+		ret += scnprintf(kbuf + ret, count - ret,
+				"Slab cache page\n");
+
+	memcg = page_memcg_check(page);
+	if (!memcg)
+		goto out_unlock;
+
+	dying = (memcg->css.flags & CSS_DYING);
+	ret += scnprintf(kbuf + ret, count - ret,
+			"Charged %sto %smemcg ",
+			PageMemcgKmem(page) ? "(via objcg) " : "",
+			dying ? "dying " : "");
+
+	/* Write cgroup name directly into kbuf */
+	cgroup_name(memcg->css.cgroup, kbuf + ret, count - ret);
+	ret += strlen(kbuf + ret);
+	ret += scnprintf(kbuf + ret, count - ret, "\n");
+out_unlock:
+	rcu_read_unlock();
+#endif /* CONFIG_MEMCG */
+
+	return ret;
+}
+
 static ssize_t
 print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		struct page *page, struct page_owner *page_owner,
@@ -365,6 +407,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
+	ret = print_page_owner_memcg(kbuf, count, ret, page);
+
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
 		goto err;
-- 
2.27.0

