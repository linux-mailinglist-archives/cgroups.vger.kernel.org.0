Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A9D12F93D
	for <lists+cgroups@lfdr.de>; Fri,  3 Jan 2020 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgACOeJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jan 2020 09:34:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:19884 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbgACOeJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 3 Jan 2020 09:34:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 06:34:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="252604822"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jan 2020 06:34:06 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     kirill.shutemov@linux.intel.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Date:   Fri,  3 Jan 2020 22:34:07 +0800
Message-Id: <20200103143407.1089-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

As all the other places, we grab the lock before manipulate the defer list.
Current implementation may face a race condition.

Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

---
I notice the difference during code reading and just confused about the
difference. No specific test is done since limited knowledge about cgroup.

Maybe I miss something important?
---
 mm/memcontrol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bc01423277c5..62b7ec34ef1a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5368,12 +5368,12 @@ static int mem_cgroup_move_account(struct page *page,
 	}
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock(&from->deferred_split_queue.split_queue_lock);
 	if (compound && !list_empty(page_deferred_list(page))) {
-		spin_lock(&from->deferred_split_queue.split_queue_lock);
 		list_del_init(page_deferred_list(page));
 		from->deferred_split_queue.split_queue_len--;
-		spin_unlock(&from->deferred_split_queue.split_queue_lock);
 	}
+	spin_unlock(&from->deferred_split_queue.split_queue_lock);
 #endif
 	/*
 	 * It is safe to change page->mem_cgroup here because the page
@@ -5385,13 +5385,13 @@ static int mem_cgroup_move_account(struct page *page,
 	page->mem_cgroup = to;
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	spin_lock(&to->deferred_split_queue.split_queue_lock);
 	if (compound && list_empty(page_deferred_list(page))) {
-		spin_lock(&to->deferred_split_queue.split_queue_lock);
 		list_add_tail(page_deferred_list(page),
 			      &to->deferred_split_queue.split_queue);
 		to->deferred_split_queue.split_queue_len++;
-		spin_unlock(&to->deferred_split_queue.split_queue_lock);
 	}
+	spin_unlock(&to->deferred_split_queue.split_queue_lock);
 #endif
 
 	spin_unlock_irqrestore(&from->move_lock, flags);
-- 
2.17.1

