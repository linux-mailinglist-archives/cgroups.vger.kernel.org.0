Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DA24ACD84
	for <lists+cgroups@lfdr.de>; Tue,  8 Feb 2022 02:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbiBHBGa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Feb 2022 20:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343919AbiBHAGL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Feb 2022 19:06:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 60B9AC0612A4
        for <cgroups@vger.kernel.org>; Mon,  7 Feb 2022 16:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644278769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARpUf0IirgM+NjOFiLN9kgiVvRtzmNfHi46LW66TM0Q=;
        b=UnqOYMtHOi4mNI6oftcM/R9dY4MBP4MvNHMngWAn8y0YJ+tpL+pe6kSwg6syxjrzWYpIj2
        U3zH2IoUuOjIrSujJ/MzLv8lxPOJ4IzGkr82WvC4nYWEekNufimZk+cblOL0CKKyEJlAxj
        IM+b91UIm6nIBVZ64pFNegcNTjt1N0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-UwoFt0qcNrqvMjJbZo_NBA-1; Mon, 07 Feb 2022 19:06:04 -0500
X-MC-Unique: UwoFt0qcNrqvMjJbZo_NBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BBDE100C660;
        Tue,  8 Feb 2022 00:06:01 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D29C85C2EF;
        Tue,  8 Feb 2022 00:05:59 +0000 (UTC)
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
Subject: [PATCH v5 2/4] mm/page_owner: Use scnprintf() to avoid excessive buffer overrun check
Date:   Mon,  7 Feb 2022 19:05:30 -0500
Message-Id: <20220208000532.1054311-3-longman@redhat.com>
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

The snprintf() function can return a length greater than the given
input size. That will require a check for buffer overrun after each
invocation of snprintf(). scnprintf(), on the other hand, will never
return a greater length. By using scnprintf() in selected places, we
can avoid some buffer overrun checks except after stack_depot_snprint()
and after the last snprintf().

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
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

