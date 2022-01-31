Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF20F4A4F5F
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 20:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376277AbiAaTXr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 14:23:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55749 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376311AbiAaTXi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 14:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643657017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Xg9VDn8wGaFMcda+Zs1goFaj5CYRr9QqJudVlDax4M=;
        b=RAQpvnKq5d/hv2m15Bm6EfoABIpQO1n2OiBUanKyomEXfgAZ1kI2IYKSr0lgz+sLC9kljM
        a6X2YojZdQIXc9A4SD5kdMieWmf3HBP1RC2lXhLf4h3aaYXGYx0vst2d2EZdpBxIZUHN2l
        qAMCXvD6ZDzbVjOmC+FXhjn4F1Vi88U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-AuHzqSQZMpyaJnb7UlIgPQ-1; Mon, 31 Jan 2022 14:23:34 -0500
X-MC-Unique: AuHzqSQZMpyaJnb7UlIgPQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61EF839384;
        Mon, 31 Jan 2022 19:23:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4427110013C1;
        Mon, 31 Jan 2022 19:23:28 +0000 (UTC)
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
Subject: [PATCH v3 4/4] mm/page_owner: Record task command name
Date:   Mon, 31 Jan 2022 14:23:08 -0500
Message-Id: <20220131192308.608837-5-longman@redhat.com>
In-Reply-To: <20220131192308.608837-1-longman@redhat.com>
References: <20220131192308.608837-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The page_owner information currently includes the pid of the calling
task. That is useful as long as the task is still running. Otherwise,
the number is meaningless. To have more information about the allocating
tasks that had exited by the time the page_owner information is
retrieved, we need to store the command name of the task.

Add a new comm field into page_owner structure to store the command name
and display it when the page_owner information is retrieved. Only the
first 15 characters of the command name will be copied, but that should
be enough in most cases. Even for those commands with longer names,
it shouldn't be hard to guess what they are.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/page_owner.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index a471c74c7fe0..8b2b381fd986 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -20,6 +20,7 @@
  * to use off stack temporal storage
  */
 #define PAGE_OWNER_STACK_DEPTH (16)
+#define PAGE_OWNER_COMM_LEN	16
 
 struct page_owner {
 	unsigned short order;
@@ -29,6 +30,7 @@ struct page_owner {
 	depot_stack_handle_t free_handle;
 	u64 ts_nsec;
 	u64 free_ts_nsec;
+	char comm[PAGE_OWNER_COMM_LEN];
 	pid_t pid;
 };
 
@@ -146,6 +148,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->comm[0] = '\0';
 		page_ext = page_ext_next(page_ext);
 	}
 }
@@ -165,6 +168,8 @@ static inline void __set_page_owner_handle(struct page_ext *page_ext,
 		page_owner->last_migrate_reason = -1;
 		page_owner->pid = current->pid;
 		page_owner->ts_nsec = local_clock();
+		strlcpy(page_owner->comm, current->comm,
+			sizeof(page_owner->comm));
 		__set_bit(PAGE_EXT_OWNER, &page_ext->flags);
 		__set_bit(PAGE_EXT_OWNER_ALLOCATED, &page_ext->flags);
 
@@ -232,6 +237,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->pid = old_page_owner->pid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
+	strcpy(new_page_owner->comm, old_page_owner->comm);
 
 	/*
 	 * We don't clear the bit on the old folio as it's going to be freed
@@ -376,10 +382,11 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
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
@@ -446,9 +453,10 @@ void __dump_page_owner(const struct page *page)
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

