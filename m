Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0C3920FF
	for <lists+cgroups@lfdr.de>; Wed, 26 May 2021 21:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhEZTiG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 May 2021 15:38:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231659AbhEZTiF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 May 2021 15:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622057791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lvXIzW1vboiHDAOnYTe4b5RTNGtYwyUKmFA6LenTEYg=;
        b=XzjstuFw0W+1Gegcc64NyEjxfe+peoxq/ghdk3LAg+7TUEfxd+o41+1rmPTuXfOvKg6o8P
        QoKzzeWlXlzAkX//WI5gRdklqKeeMksmu4N/hgO+zTlLpgV7LLuoEWjwf4d6eCL9cjDrRH
        poIhyAJ//1ZjpwkC/DUdHtEBO87asu8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-8fnfKFh9MMuYF7AksyzIIg-1; Wed, 26 May 2021 15:36:27 -0400
X-MC-Unique: 8fnfKFh9MMuYF7AksyzIIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4E40180FD69;
        Wed, 26 May 2021 19:36:25 +0000 (UTC)
Received: from llong.com (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65D345D723;
        Wed, 26 May 2021 19:36:21 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-next] mm/memcontrol.c: Fix potential uninitialized variable warning
Date:   Wed, 26 May 2021 15:36:02 -0400
Message-Id: <20210526193602.8742-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

If the -Wno-maybe-uninitialized gcc option is not specified, compilation
of memcontrol.c may generate the following warnings:

mm/memcontrol.c: In function ‘refill_obj_stock’:
./arch/x86/include/asm/irqflags.h:127:17: warning: ‘flags’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  return !(flags & X86_EFLAGS_IF);
          ~~~~~~~^~~~~~~~~~~~~~~~
mm/memcontrol.c:3216:16: note: ‘flags’ was declared here
  unsigned long flags;
                ^~~~~
In file included from mm/memcontrol.c:29:
mm/memcontrol.c: In function ‘uncharge_page’:
./include/linux/memcontrol.h:797:2: warning: ‘objcg’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  percpu_ref_put(&objcg->refcnt);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix that by properly initializing *pflags in get_obj_stock() and
introducing a use_objcg bool variable in uncharge_page() to avoid
potentially accessing the struct page data twice.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/memcontrol.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb864f87b01d..b9a6db6a7d4f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2108,6 +2108,7 @@ static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
 	struct memcg_stock_pcp *stock;
 
 	if (likely(in_task())) {
+		*pflags = 0UL;
 		preempt_disable();
 		stock = this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
@@ -6840,6 +6841,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	unsigned long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
+	bool use_objcg = PageMemcgKmem(page);
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 
@@ -6848,7 +6850,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 	 * page memcg or objcg at this point, we have fully
 	 * exclusive access to the page.
 	 */
-	if (PageMemcgKmem(page)) {
+	if (use_objcg) {
 		objcg = __page_objcg(page);
 		/*
 		 * This get matches the put at the end of the function and
@@ -6876,7 +6878,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 
 	nr_pages = compound_nr(page);
 
-	if (PageMemcgKmem(page)) {
+	if (use_objcg) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
 
-- 
2.18.1

