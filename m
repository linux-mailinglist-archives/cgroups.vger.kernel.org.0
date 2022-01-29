Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB82A4A31EE
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 21:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353183AbiA2Ux4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jan 2022 15:53:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353170AbiA2Uxz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jan 2022 15:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643489634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=poPjjcFexMGp0K40SsFnRADO8VbhRo0jK19whIZnUJQ=;
        b=Zy/Z3ihjhNeS8iwaQHCQWt7LNXmR5CSO9Oigf0fs5yz5AA0AH8/HVoJZWrbXlCErFc7hO/
        A7PxOmpGpL4YDJKY4wqIAPOISXovKhZcQaLtGlYGmav55JLS6p1+bOtgYoL3p5SEIywVo0
        vslmjBbWCKBOoL0eQKdjzGElckzyulg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-tfjAvJFGOhmoKcB5pFVqXA-1; Sat, 29 Jan 2022 15:53:51 -0500
X-MC-Unique: tfjAvJFGOhmoKcB5pFVqXA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40870343CA;
        Sat, 29 Jan 2022 20:53:49 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0C605DF2E;
        Sat, 29 Jan 2022 20:53:47 +0000 (UTC)
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
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Date:   Sat, 29 Jan 2022 15:53:15 -0500
Message-Id: <20220129205315.478628-4-longman@redhat.com>
In-Reply-To: <20220129205315.478628-1-longman@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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
offlined memcgs, the page_owner feature is extended to dump memory
cgroup information especially whether the cgroup is offlined or not.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/page_owner.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 28dac73e0542..8dc5cd0fa227 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -10,6 +10,7 @@
 #include <linux/migrate.h>
 #include <linux/stackdepot.h>
 #include <linux/seq_file.h>
+#include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
 #include "internal.h"
@@ -331,6 +332,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		depot_stack_handle_t handle)
 {
 	int ret, pageblock_mt, page_mt;
+	unsigned long __maybe_unused memcg_data;
 	char *kbuf;
 
 	count = min_t(size_t, count, PAGE_SIZE);
@@ -365,6 +367,35 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migrate_reason_names[page_owner->last_migrate_reason]);
 	}
 
+#ifdef CONFIG_MEMCG
+	/*
+	 * Look for memcg information and print it out
+	 */
+	memcg_data = READ_ONCE(page->memcg_data);
+	if (memcg_data) {
+		struct mem_cgroup *memcg = page_memcg_check(page);
+		bool onlined;
+		char name[80];
+
+		if (memcg_data & MEMCG_DATA_OBJCGS)
+			ret += scnprintf(kbuf + ret, count - ret,
+					"Slab cache page\n");
+
+		if (!memcg)
+			goto copy_out;
+
+		onlined = (memcg->css.flags & CSS_ONLINE);
+		cgroup_name(memcg->css.cgroup, name, sizeof(name));
+		ret += scnprintf(kbuf + ret, count - ret,
+				"Charged %sto %smemcg %s\n",
+				PageMemcgKmem(page) ? "(via objcg) " : "",
+				onlined ? "" : "offlined ",
+				name);
+	}
+
+copy_out:
+#endif
+
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
 		goto err;
-- 
2.27.0

