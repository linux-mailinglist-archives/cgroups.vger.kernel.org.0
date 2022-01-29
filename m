Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3F24A31EC
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 21:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353017AbiA2Uxw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 29 Jan 2022 15:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353163AbiA2Uxw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 29 Jan 2022 15:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643489631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f1x6j7RB7xRENYfNa+FT/BlT6fNQP5UqbN6D/s+vZCU=;
        b=BOsTCullRWUIjRtIgfa0syBgm4klReLuo32xYTKRIBBad/MVHgzRjbjSFGf5LYlLTwOMEy
        i3wjIg76Vn0bCOZw+DUHPHKjlxDo22YaLaJnqgr1QlP+Nw4scucH+GjbM5Zrq8xjTnR+oX
        Gu9dspbRda6M/+n3uZSaSCycvH/ZHxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-y4KFQNNXPxewucIo98fB5w-1; Sat, 29 Jan 2022 15:53:49 -0500
X-MC-Unique: y4KFQNNXPxewucIo98fB5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF0101006AA0;
        Sat, 29 Jan 2022 20:53:47 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 286535DF3A;
        Sat, 29 Jan 2022 20:53:46 +0000 (UTC)
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
Subject: [PATCH v2 2/3] mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
Date:   Sat, 29 Jan 2022 15:53:14 -0500
Message-Id: <20220129205315.478628-3-longman@redhat.com>
In-Reply-To: <20220129205315.478628-1-longman@redhat.com>
References: <20220129205315.478628-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The snprintf() function can return a length greater than the given
input size. That will require a check for buffer overrun after each
invocation of snprintf(). scnprintf(), on the other hand, will never
return a greater length. By using scnprintf() in selected places, we
can avoid some buffer overrun checks except after stack_depot_snprint()
and after the last snprintf().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/page_owner.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 99e360df9465..28dac73e0542 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -338,19 +338,16 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (!kbuf)
 		return -ENOMEM;
 
-	ret = snprintf(kbuf, count,
+	ret = scnprintf(kbuf, count,
 			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
 			page_owner->ts_nsec, page_owner->free_ts_nsec);
 
-	if (ret >= count)
-		goto err;
-
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
 	page_mt  = gfp_migratetype(page_owner->gfp_mask);
-	ret += snprintf(kbuf + ret, count - ret,
+	ret += scnprintf(kbuf + ret, count - ret,
 			"PFN %lu type %s Block %lu type %s Flags %pGp\n",
 			pfn,
 			migratetype_names[page_mt],
@@ -358,19 +355,14 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 			migratetype_names[pageblock_mt],
 			&page->flags);
 
-	if (ret >= count)
-		goto err;
-
 	ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
 	if (ret >= count)
 		goto err;
 
 	if (page_owner->last_migrate_reason != -1) {
-		ret += snprintf(kbuf + ret, count - ret,
+		ret += scnprintf(kbuf + ret, count - ret,
 			"Page has been migrated, last migrate reason: %s\n",
 			migrate_reason_names[page_owner->last_migrate_reason]);
-		if (ret >= count)
-			goto err;
 	}
 
 	ret += snprintf(kbuf + ret, count - ret, "\n");
-- 
2.27.0

