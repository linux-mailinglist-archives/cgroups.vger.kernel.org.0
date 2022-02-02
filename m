Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFC34A798C
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 21:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347219AbiBBUeD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 15:34:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23955 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347204AbiBBUd7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 15:33:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643834039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w+Q+AFP6tIEythEP8N9DfZ2WkxdGuyQHwcgj9xdFRo8=;
        b=VFh9NlQpERcsQoFCMSBNisaXlntkey8qbZMssh5OJlztEiP3n8aW0NiuEPrV3inBlHBNSG
        AGRE0E7ekOnGWV2RKus+tD6m25Y/TetvqdeJ9C4kfvfNwNLJgPQgnQ+1X0S5Q5k2CGpCWy
        Pyg9p1+NYChTBeK5sK83hWooK8WeeAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-JMKTMjwwPiuyP6GqA7MOVg-1; Wed, 02 Feb 2022 15:33:58 -0500
X-MC-Unique: JMKTMjwwPiuyP6GqA7MOVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BAC7B100C68A;
        Wed,  2 Feb 2022 20:33:54 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DACAD4F864;
        Wed,  2 Feb 2022 20:33:52 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/4] mm/page_owner: Print memcg information
Date:   Wed,  2 Feb 2022 15:30:35 -0500
Message-Id: <20220202203036.744010-4-longman@redhat.com>
In-Reply-To: <20220131192308.608837-5-longman@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that a number of offline memcgs were not freed because
they were pinned by some charged pages that were present. Even "echo 1 >
/proc/sys/vm/drop_caches" wasn't able to free those pages. These offline
but not freed memcgs tend to increase in number over time with the side
effect that percpu memory consumption as shown in /proc/meminfo also
increases over time.

In order to find out more information about those pages that pin
offline memcgs, the page_owner feature is extended to print memory
cgroup information especially whether the cgroup is offline or not.
RCU read lock is taken when memcg is being accessed to make sure
that it won't be freed.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/page_owner.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28dac73e0542..f7820357e4d4 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
 #include "internal.h"
@@ -325,6 +326,45 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
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
+	bool online;
+	char name[80];
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
+	online = (memcg->css.flags & CSS_ONLINE);
+	cgroup_name(memcg->css.cgroup, name, sizeof(name));
+	ret += scnprintf(kbuf + ret, count - ret,
+			"Charged %sto %smemcg %s\n",
+			PageMemcgKmem(page) ? "(via objcg) " : "",
+			online ? "" : "offline ",
+			name);
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
@@ -365,6 +405,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
+	ret = print_page_owner_memcg(kbuf, count, ret, page);
+
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
 		goto err;
-- 
2.27.0

