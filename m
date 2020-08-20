Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D761F24BD64
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 15:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHTNEn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 09:04:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729885AbgHTNET (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 09:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597928658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=CJnfEEPsHTayufcqPRv869AJ8y4aZylFQ/z6R8psu84=;
        b=UPxACiMBxNxZKKUPQFu+PLJNdf7byO6EDqF1XmvvgISBNLd4RcyIIY3j1O05xec/rlwGOg
        Lo5AscxcF7r31vtNX+sv3ib4NmEcgDCHJ/daVBpFbn2Jfuf3+/11mVQMu6FbJfJ9EsuTyF
        gqIjrQX6qCANDD9GEET7IWzHHgzU2Lg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-VVfH2K2cNdKSB7y61NNuZA-1; Thu, 20 Aug 2020 09:04:16 -0400
X-MC-Unique: VVfH2K2cNdKSB7y61NNuZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B42A81F02B;
        Thu, 20 Aug 2020 13:04:14 +0000 (UTC)
Received: from llong.com (unknown [10.10.115.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAC0A600DD;
        Thu, 20 Aug 2020 13:04:12 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/3] mm/memcg: Unify swap and memsw page counters
Date:   Thu, 20 Aug 2020 09:03:50 -0400
Message-Id: <20200820130350.3211-4-longman@redhat.com>
In-Reply-To: <20200820130350.3211-1-longman@redhat.com>
References: <20200820130350.3211-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The swap page counter is v2 only while memsw is v1 only. As v1 and v2
controllers cannot be active at the same time, there is no point to keep
both swap and memsw page counters in mem_cgroup. The previous patch has
made sure that memsw page counter is updated and accessed only when in
v1 code paths. So it is now safe to alias the v1 memsw page counter to v2
swap page counter. This saves 14 long's in the size of mem_cgroup. This
is a saving of 112 bytes for 64-bit archs.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 3 +--
 mm/memcontrol.c            | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..d2a819d7db70 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -216,10 +216,9 @@ struct mem_cgroup {
 
 	/* Accounted resources */
 	struct page_counter memory;
-	struct page_counter swap;
+	struct page_counter swap;	/* memsw (memory+swap) for v1 */
 
 	/* Legacy consumer-oriented counters */
-	struct page_counter memsw;
 	struct page_counter kmem;
 	struct page_counter tcpmem;
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d219dca5239f..04c3794cdc98 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -68,6 +68,11 @@
 
 #include <trace/events/vmscan.h>
 
+/*
+ * The v1 memsw page counter is aliased to the v2 swap page counter.
+ */
+#define memsw	swap
+
 struct cgroup_subsys memory_cgrp_subsys __read_mostly;
 EXPORT_SYMBOL(memory_cgrp_subsys);
 
@@ -5279,13 +5284,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		memcg->use_hierarchy = true;
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
-		page_counter_init(&memcg->memsw, &parent->memsw);
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
-		page_counter_init(&memcg->memsw, NULL);
 		page_counter_init(&memcg->kmem, NULL);
 		page_counter_init(&memcg->tcpmem, NULL);
 		/*
@@ -5414,7 +5417,6 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	page_counter_set_min(&memcg->memory, 0);
-- 
2.18.1

