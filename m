Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2174A798D
	for <lists+cgroups@lfdr.de>; Wed,  2 Feb 2022 21:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiBBUeG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Feb 2022 15:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347212AbiBBUeE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Feb 2022 15:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643834044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9zS1/+E6LbgkmQXXirvHhlSIzu5z9ShRmVZP1k7+Qso=;
        b=Tw3sMPEyIQ3HZj5du6TO5PPFwRlAorVqAKg8Kl9TToUQD/CJZOexCOn+PFtNt0Aga2/qX3
        uc6tlPn7G9M+4SnbOii64VBOBGFKR5UifDFJKE3yXzcdcH99NQImxdqzn8Yt1PYRP2jLTw
        XLcM1zivDg2Xpjcvy2Ni6P+R0drBC6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-4ssqO2vLPUybJrJ9eyi8_A-1; Wed, 02 Feb 2022 15:33:59 -0500
X-MC-Unique: 4ssqO2vLPUybJrJ9eyi8_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CA0B83DD20;
        Wed,  2 Feb 2022 20:33:56 +0000 (UTC)
Received: from llong.com (unknown [10.22.34.202])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E9FF654532;
        Wed,  2 Feb 2022 20:33:54 +0000 (UTC)
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
Subject: [PATCH v4 4/4] mm/page_owner: Record task command name
Date:   Wed,  2 Feb 2022 15:30:36 -0500
Message-Id: <20220202203036.744010-5-longman@redhat.com>
In-Reply-To: <20220131192308.608837-5-longman@redhat.com>
References: <20220131192308.608837-5-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The page_owner information currently includes the pid of the calling
task. That is useful as long as the task is still running. Otherwise,
the number is meaningless. To have more information about the allocating
tasks that had exited by the time the page_owner information is
retrieved, we need to store the command name of the task.

Add a new comm field into page_owner structure to store the command name
and display it when the page_owner information is retrieved.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/page_owner.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index f7820357e4d4..d56afa9c792e 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -29,6 +29,7 @@ struct page_owner {
 	depot_stack_handle_t free_handle;
 	u64 ts_nsec;
 	u64 free_ts_nsec;
+	char comm[TASK_COMM_LEN];
 	pid_t pid;
 };
 
@@ -165,6 +166,8 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->ts_nsec = local_clock();
+		strlcpy(page_owner->comm, current->comm,
+			sizeof(page_owner->comm));
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
@@ -232,6 +235,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
+	strcpy(new_page_owner->comm, old_page_owner->comm);
 
 	/*
 	 * We don't clear the bit on the old folio as it's going to be freed
@@ -379,10 +383,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = scnprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d, ts %llu ns, free_ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d (%s), ts %llu ns, free_ts %llu ns\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
-			page_owner->ts_nsec, page_owner->free_ts_nsec);
+			page_owner->comm, page_owner->ts_nsec,
+			page_owner->free_ts_nsec);
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
@@ -449,9 +454,10 @@ void __dump_page_owner(const struct page *page)
 	else
 		pr_alert("page_owner tracks the page as freed\n");
 
-	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d, ts %llu, free_ts %llu\n",
+	pr_alert("page last allocated via order %u, migratetype %s, gfp_mask %#x(%pGg), pid %d (%s), ts %llu, free_ts %llu\n",
 		 page_owner->order, migratetype_names[mt], gfp_mask, &gfp_mask,
-		 page_owner->pid, page_owner->ts_nsec, page_owner->free_ts_nsec);
+		 page_owner->pid, page_owner->comm, page_owner->ts_nsec,
+		 page_owner->free_ts_nsec);
 
 	handle = READ_ONCE(page_owner->handle);
 	if (!handle)
-- 
2.27.0

