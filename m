Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E66B4A4F5C
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 20:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359798AbiAaTXl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 14:23:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58606 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1359719AbiAaTXe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 14:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643657013;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqKO5lknN2+Nsr0yWLMZlCagaD5YFaBIvpU1YV0vjJ8=;
        b=D5HLeURrdhU7FmHdatBQz2nXIU/paVkcnKNrmYr7x6cyBCsqvRlnlzKJSZKENfKsV/8Hce
        4Sf/23xr9hAOFaK7MpItlMXai9OCwvRw5lQf3YW78dh3hsfqZgJJNDUwDsWqCHqinJ3B4U
        xzoQ+uyYhiysfdaNt4lkdenE7pR4bjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-YH4BwOw-OHeQDi8OdBzUZA-1; Mon, 31 Jan 2022 14:23:30 -0500
X-MC-Unique: YH4BwOw-OHeQDi8OdBzUZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19CB48143E5;
        Mon, 31 Jan 2022 19:23:28 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F296D10013C1;
        Mon, 31 Jan 2022 19:23:25 +0000 (UTC)
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
Subject: [PATCH v3 3/4] mm/page_owner: Print memcg information
Date:   Mon, 31 Jan 2022 14:23:07 -0500
Message-Id: <20220131192308.608837-4-longman@redhat.com>
In-Reply-To: <20220131192308.608837-1-longman@redhat.com>
References: <20220131192308.608837-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that a number of offlined memcgs were not freed because
they were pinned by some charged pages that were present. Even "echo
1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
offlined but not freed memcgs tend to increase in number over time with
the side effect that percpu memory consumption as shown in /proc/meminfo
also increases over time.

In order to find out more information about those pages that pin
offlined memcgs, the page_owner feature is extended to print memory
cgroup information especially whether the cgroup is offlined or not.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 mm/page_owner.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28dac73e0542..a471c74c7fe0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
 #include "internal.h"
@@ -325,6 +326,42 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 	seq_putc(m, '\n');
 }
 
+#ifdef CONFIG_MEMCG
+/*
+ * Looking for memcg information and print it out
+ */
+static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
+					  struct page *page)
+{
+	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+	struct mem_cgroup *memcg;
+	bool onlined;
+	char name[80];
+
+	if (!memcg_data)
+		return;
+
+	if (memcg_data & MEMCG_DATA_OBJCGS)
+		*pret += scnprintf(kbuf + *pret, count - *pret,
+				"Slab cache page\n");
+
+	memcg = page_memcg_check(page);
+	if (!memcg)
+		return;
+
+	onlined = (memcg->css.flags & CSS_ONLINE);
+	cgroup_name(memcg->css.cgroup, name, sizeof(name));
+	*pret += scnprintf(kbuf + *pret, count - *pret,
+			"Charged %sto %smemcg %s\n",
+			PageMemcgKmem(page) ? "(via objcg) " : "",
+			onlined ? "" : "offlined ",
+			name);
+}
+#else /* CONFIG_MEMCG */
+static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
+					  struct page *page) { }
+#endif /* CONFIG_MEMCG */
+
 static ssize_t
 print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		struct page *page, struct page_owner *page_owner,
@@ -365,6 +402,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
+	print_page_owner_memcg(kbuf, count, &ret, page);
+
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
 		goto err;
-- 
2.27.0

