Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD27561AD
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 13:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjGQLgn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 07:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGQLgm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 07:36:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9EE4F;
        Mon, 17 Jul 2023 04:36:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4R4Kjc0KmFzLnnh;
        Mon, 17 Jul 2023 19:34:12 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 19:36:36 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hannes@cmpxchg.org>,
        <mhocko@kernel.org>, <roman.gushchin@linux.dev>,
        <shakeelb@google.com>
CC:     <muchun.song@linux.dev>, <linux-mm@kvack.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/memcg: minor cleanup for mc_handle_present_pte()
Date:   Mon, 17 Jul 2023 19:36:44 +0800
Message-ID: <20230717113644.3026478-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When pagetable lock is held, the page will always be page_mapped(). So
remove unneeded page_mapped() check. Also the page can't be freed from
under us in this case. So use get_page() to get extra page reference to
simplify the code. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memcontrol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 284396ea8a33..60b5ff3b4a52 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5649,7 +5649,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
 {
 	struct page *page = vm_normal_page(vma, addr, ptent);
 
-	if (!page || !page_mapped(page))
+	if (!page)
 		return NULL;
 	if (PageAnon(page)) {
 		if (!(mc.flags & MOVE_ANON))
@@ -5658,8 +5658,7 @@ static struct page *mc_handle_present_pte(struct vm_area_struct *vma,
 		if (!(mc.flags & MOVE_FILE))
 			return NULL;
 	}
-	if (!get_page_unless_zero(page))
-		return NULL;
+	get_page(page);
 
 	return page;
 }
-- 
2.33.0

