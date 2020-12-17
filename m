Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F642DCB77
	for <lists+cgroups@lfdr.de>; Thu, 17 Dec 2020 04:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728628AbgLQDrQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 22:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgLQDrL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Dec 2020 22:47:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C42C061794
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 19:46:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v1so2899721pjr.2
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 19:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UauSishbX7RnBX7K58fFhe45sU8LPO/cdBxsyz6B3SU=;
        b=x2tW2mmU9L1wdYbgWOJBGPpHM/c0zI8LzK8gbOzNeqMxSEvT39yMzMhK++aZe0mwnn
         UinbyALx0XGkuKBzBEpw1U6woTvBcMG/jgBdIE4CBIJncj5dCI5UZCrZrfM+gMfOSwdL
         ACAo8bNr3y5hvoVxik4WNw2ddz1fy7xbFYjKRSGPCMzO7CurA/OzBtahS8sDWKzI6MmK
         298avBcWSmMbmXgRVITspGUDf89lCfA3YRdR/hKPVBOkgZ5awc2EfPtXGiKyq+NmIRYl
         y9xg9gYEOwFylyDulLVSIAG3C7MUDet7P51oa8ankzc64E8dTk4d6TSA+knwLlzFmnqT
         7KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UauSishbX7RnBX7K58fFhe45sU8LPO/cdBxsyz6B3SU=;
        b=gWJt1EmE3fcitMH36hk2KA6oEInX57zqAgyohhHi6EIcV/9Qj/F91CPpRAw1HL7CPR
         DVHTITopUR4THJoDkzgX7O+Sesaxm5DUNb1S/is01KMjXUTTdxthlJtPFLRFPYWUrVZW
         B/k7HBU6xrIvvMZGgKJ0pFOFAEwcj0Fx75yY/Vgup5LCYXZaCdpCiiVs9PIFyacR+3J1
         PnSTmKGzcCjIOOTWwCP5GniNinIiJHSokOQUMnyeXbgVmiweUEjt+IfbpaMFHyRO3naa
         COnQHCiAj8q774zCrF45vLICz3IIjFlfXla27NuxeI4fjfOjWrL+mDOt97X8r+jRoYAI
         fcoA==
X-Gm-Message-State: AOAM531NR0sCHy5EEd3Iws/4C0ZRAkMF7tzDlc9dUyXJZBOx/6jWKr6G
        ldCjPI9P6m07EHWSN6TNyAtp/Q==
X-Google-Smtp-Source: ABdhPJxeMkklPh+rYfkTZFFo93lMxHKhiwftHUyUbrO6fSQpXmBiTaS5E/LJ4Nh1ONcKI8Djt2NVjQ==
X-Received: by 2002:a17:902:59d0:b029:da:69a8:11a8 with SMTP id d16-20020a17090259d0b02900da69a811a8mr34531436plj.63.1608176781034;
        Wed, 16 Dec 2020 19:46:21 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:46:20 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 6/7] mm: memcontrol: convert NR_FILE_PMDMAPPED account to pages
Date:   Thu, 17 Dec 2020 11:43:55 +0800
Message-Id: <20201217034356.4708-7-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217034356.4708-1-songmuchun@bytedance.com>
References: <20201217034356.4708-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics expecially THP
vmstat counters. In the systems with hundreads of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_FILE_PMDMAPPED account to pages. This
patch is consistent with 8f182270dfec ("mm/swap.c: flush lru
pvecs on compound page arrival"). Doing this also can make the
unit of vmstat counters more unified. Finally, the unit of the
vmstat counters are pages, kB and bytes. The B/KB suffix can
tell us that the unit is bytes or kB. The rest which is without
suffix are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 3 +--
 fs/proc/meminfo.c      | 2 +-
 include/linux/mmzone.h | 3 ++-
 mm/rmap.c              | 6 ++++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 7a66aefe4e46..d02d86aec19f 100644
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
index c61f440570f9..6fa761c9cc78 100644
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
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1ca6a34f6a4a..6139479ba417 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -219,7 +219,8 @@ static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
 	return item == NR_ANON_THPS ||
 	       item == NR_FILE_THPS ||
 	       item == NR_SHMEM_THPS ||
-	       item == NR_SHMEM_PMDMAPPED;
+	       item == NR_SHMEM_PMDMAPPED ||
+	       item == NR_FILE_PMDMAPPED;
 }
 
 /*
diff --git a/mm/rmap.c b/mm/rmap.c
index 1c1b576c0627..5ebf16fae4b9 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1223,7 +1223,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						nr_pages);
 		else
-			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						nr_pages);
 	} else {
 		if (PageTransCompound(page) && page_mapping(page)) {
 			VM_WARN_ON_ONCE(!PageLocked(page));
@@ -1267,7 +1268,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
 						-nr_pages);
 		else
-			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_FILE_PMDMAPPED,
+						-nr_pages);
 	} else {
 		if (!atomic_add_negative(-1, &page->_mapcount))
 			return;
-- 
2.11.0

