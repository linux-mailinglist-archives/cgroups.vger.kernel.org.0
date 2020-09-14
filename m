Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26962682BF
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 04:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgINCph (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 13 Sep 2020 22:45:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58339 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbgINCp1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 13 Sep 2020 22:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600051523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=+lAeArrGnV/U+syM1+KcWlJ8jKPBVWf17BzUlWjyOt4=;
        b=dhYauM8N3r55e3G3TewVXxAFtcwg01mcYLGSYNC3V39kjJwaHGxIG/Myli6KbILJ+ugohc
        8A4Bu2rAt9YmC3czjJ/6KI2xu0QM5LMCfv+5RH89r1K2SMBcaPYhEh+syt8//wmXUrkwDY
        I2ISwIL5LM28PYXajHDk8uspnudTXpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-eMyESoohPpSowlGoOucfLg-1; Sun, 13 Sep 2020 22:45:19 -0400
X-MC-Unique: eMyESoohPpSowlGoOucfLg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1C7800D53;
        Mon, 14 Sep 2020 02:45:18 +0000 (UTC)
Received: from llong.com (ovpn-113-90.rdu2.redhat.com [10.10.113.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE0D460BF3;
        Mon, 14 Sep 2020 02:45:16 +0000 (UTC)
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
Subject: [PATCH v2 3/3] mm/memcg: Unify swap and memsw page counters
Date:   Sun, 13 Sep 2020 22:44:52 -0400
Message-Id: <20200914024452.19167-4-longman@redhat.com>
In-Reply-To: <20200914024452.19167-1-longman@redhat.com>
References: <20200914024452.19167-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

While at it, also document which page counters are used in v1 and/or v2.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h | 13 ++++++++-----
 mm/memcontrol.c            |  3 ---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d0b036123c6a..6ef4a552e09d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -215,13 +215,16 @@ struct mem_cgroup {
 	struct mem_cgroup_id id;
 
 	/* Accounted resources */
-	struct page_counter memory;
-	struct page_counter swap;
+	struct page_counter memory;		/* Both v1 & v2 */
+
+	union {
+		struct page_counter swap;	/* v2 only */
+		struct page_counter memsw;	/* v1 only */
+	};
 
 	/* Legacy consumer-oriented counters */
-	struct page_counter memsw;
-	struct page_counter kmem;
-	struct page_counter tcpmem;
+	struct page_counter kmem;		/* v1 only */
+	struct page_counter tcpmem;		/* v1 only */
 
 	/* Range enforcement for interrupt charges */
 	struct work_struct high_work;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ca36bed588d1..188901f3a3db 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5281,13 +5281,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
@@ -5416,7 +5414,6 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 
 	page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
-	page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
 	page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
 	page_counter_set_min(&memcg->memory, 0);
-- 
2.18.1

