Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BB437280
	for <lists+cgroups@lfdr.de>; Fri, 22 Oct 2021 09:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhJVHIF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Oct 2021 03:08:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhJVHIF (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 22 Oct 2021 03:08:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A09D560ED3;
        Fri, 22 Oct 2021 07:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634886348;
        bh=iLRhWGhOtATtNXfjLsY/C/FzcVIkkj6omLPayvSrHVc=;
        h=From:To:Cc:Subject:Date:From;
        b=WvBpQzKjqVFToSn3i2NADviklR3XuCrbfuC3GBfqsU7+otQA2XAlMiiV1wNk7LED6
         T0Vu2AL+7me+PouplKBEcm7CD5tf8wQJ91BYw5i+tcyIBxIRl9I5A8bCQAaM8/ukdf
         4hOSK/JiM35OiNJP6W9PhHmDIRrotBP57yFezB7OjY3U+DWO7nKc7Xcqz9Vm/ELfDR
         BRfJczzddWZwsF620p9imsVc5UiigA2Rxk4jplLQL11LFAdYJ962ELZRsVcVMgEoLX
         Y+9K0EkVREF4npPNMmr3rcKTSeiwG/XEXNxmlxkFz2ILlfy336WBO7XpAU8+6EUP5w
         NB8i6vWNlwLZA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Shakeel Butt <shakeelb@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] memcg, kmem: mark cancel_charge() inline
Date:   Fri, 22 Oct 2021 09:05:35 +0200
Message-Id: <20211022070542.679839-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

cancel_charge() is no longer called for CONFIG_MEMCG_KMEM on NOMMU
targets, which causes a compiletime warning:

mm/memcontrol.c:2774:13: error: unused function 'cancel_charge' [-Werror,-Wunused-function]

Remove the now-incorrect #ifdef and just mark the function
'inline' like the other related helpers. This is simpler
and means we no longer have to match the #ifdef with the
caller.

Fixes: 5f3345c17079 ("memcg, kmem: further deprecate kmem.limit_in_bytes")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The 5f3345c17079 commit is in -mm, so the commit ID is not
stable. Feel free to just fold this into the other patch, or
take out that reference
---
 mm/memcontrol.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6538595994d2..9edccfeac804 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2770,8 +2770,7 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-#if defined(CONFIG_MEMCG_KMEM) || defined(CONFIG_MMU)
-static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
+static inline void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	if (mem_cgroup_is_root(memcg))
 		return;
@@ -2780,7 +2779,6 @@ static void cancel_charge(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (do_memsw_account())
 		page_counter_uncharge(&memcg->memsw, nr_pages);
 }
-#endif
 
 static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
-- 
2.29.2

