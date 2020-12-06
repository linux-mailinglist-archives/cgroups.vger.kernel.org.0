Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7BC2D01C8
	for <lists+cgroups@lfdr.de>; Sun,  6 Dec 2020 09:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgLFI1m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 6 Dec 2020 03:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbgLFI1l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 6 Dec 2020 03:27:41 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7CAC061A55
        for <cgroups@vger.kernel.org>; Sun,  6 Dec 2020 00:26:59 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q3so6377853pgr.3
        for <cgroups@vger.kernel.org>; Sun, 06 Dec 2020 00:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47URTm8Dh9aVQTOnIPzCjSnQ3r0uw/hpFPQHZdAjXJk=;
        b=eG205hX+pDpvkROXIp/8ly+flo4GPzQkCXAfOJJgFTCfdIFzCdFhcuqDMvjneptNZJ
         aeMSR9jUUbYX9EraVyvt3jdijq+UOYtp3ggHujHmFY1z3KjsnF+GIOxia7DKKPmGyYjy
         SLSYM++XbUKy0gCCX1/9wUTf1J8pL4XdIfv9T1syzxX+mKTC889A8lByeNZH+AngR2/9
         8z9vBwPGbAnFZf8LRVq5ZM7isVlZf/K6An6mTSaQAOD9GaA2dzaWG2p9ynUvrp+zZyB0
         SPGru/GfSF49sSC+esxQsR0u24DAGw6selULWv+Tg4zmmAoBTdS5qPuLpl/id6kOZN/D
         aYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47URTm8Dh9aVQTOnIPzCjSnQ3r0uw/hpFPQHZdAjXJk=;
        b=RueD2hd/rhaTCOFzdVPI4OZsnlTWQyqQlGOnQdgcffRj/nF3bs2pxLeHAR2KUGXN4A
         3AN+JQ1OyqOXWC1x/DAMF0u97noAS1Lm2yrLrPjQxqZ2QJJnB+/fS05B64h3BSJTDLG0
         8J005y1IU2R5pjnIb3HYTxqiNHi7V3NcZeI9sWia8BPLJ6TbIMNko2dvZ/p/OvsYS/Jc
         dgmJxyDB8vluu4Om01M6kAPuvjHPok07Fg3DcC8hBLos6cmJF86olkphJ3Jq0uKH4Nxh
         nbdqIfyugctHPAlxzuQniuP3KbiGHPvt+AwBO+N3s7uJDqsrp3kndUbWnBtgQX0ECLXk
         gaTg==
X-Gm-Message-State: AOAM531fLr7hSCJNEzls8s2q40kY1MEuWJFYvKR0JD5FiybeohaX5J9y
        3ixf8xH99XjxH9wz7aDWzaPHnw==
X-Google-Smtp-Source: ABdhPJwueve0zAzmxlHWZexsQpQXkSfvShg3LwjxqrhWs7wwySPo4QztA1BsP4WBkRCou/p9kEv7hg==
X-Received: by 2002:a05:6a00:1683:b029:19d:917a:616b with SMTP id k3-20020a056a001683b029019d917a616bmr11329583pfc.15.1607243219454;
        Sun, 06 Dec 2020 00:26:59 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id iq3sm6884104pjb.57.2020.12.06.00.26.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 00:26:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, will@kernel.org,
        guro@fb.com, rppt@kernel.org, tglx@linutronix.de, esyr@redhat.com,
        peterx@redhat.com, krisman@collabora.com, surenb@google.com,
        avagin@openvz.org, elver@google.com, rdunlap@infradead.org,
        iamjoonsoo.kim@lge.com
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 06/12] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Sun,  6 Dec 2020 16:23:08 +0800
Message-Id: <20201206082318.11532-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201206082318.11532-1-songmuchun@bytedance.com>
References: <20201206082318.11532-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert NR_FILE_PMDMAPPED account to pages

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/rmap.c           | 6 ++++--
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index e5abc6144dab..f77652e6339f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -465,8 +465,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
-			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
-				    HPAGE_PMD_NR)
+			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED))
 #endif
 			    );
 	len += hugetlb_report_node_meminfo(buf, len, nid);
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 84886b2cc2f7..5a83012d8b72 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -137,7 +137,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
-		    global_node_page_state(NR_FILE_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_FILE_PMDMAPPED));
 #endif
 
 #ifdef CONFIG_CMA
diff --git a/mm/rmap.c b/mm/rmap.c
index 3089ad6bf468..e383c5619501 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1222,7 +1222,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						HPAGE_PMD_NR);
 		else
-			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						HPAGE_PMD_NR);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1264,7 +1265,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-HPAGE_PMD_NR);
 		else
-			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						-HPAGE_PMD_NR);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			return;
-- 
2.11.0

