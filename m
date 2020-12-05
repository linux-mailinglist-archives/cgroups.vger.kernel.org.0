Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252F92CFBCC
	for <lists+cgroups@lfdr.de>; Sat,  5 Dec 2020 16:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgLEPkE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 5 Dec 2020 10:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbgLEP3O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 5 Dec 2020 10:29:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE70C09425D
        for <cgroups@vger.kernel.org>; Sat,  5 Dec 2020 05:03:43 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id o9so5738098pfd.10
        for <cgroups@vger.kernel.org>; Sat, 05 Dec 2020 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZOUEjYnrw/jKRYqpi7q020fqNgK9R8UvUzzMbw50zY=;
        b=neYDpg4r2y9kA8bSIzVIJ2XJBnhDklsaXMPeNsZUDajIujwhGMeEFhY+XngVY5qv8u
         IYh5151ZcZtLBQsFRPs2SNjyK1NhJq+NVy4gswyaAdkA94CsNPNg/atj6y+aNTBSlYD6
         gNQrw6rGfg8uRBsZgcdDNhrcRCWvx5RjKJVD3sAabpSf3vnHCWmmGbHI3pywzLcmNDOZ
         sP2YEZeBeHFVXYlVwSw1cKnhg4GAgCFJVxmzFgOOwCzgTMcu7CxRdpdjfhnn+IkHGoqI
         P/Z7nXl9EfZYolJ9/kaAWPLl8ZUvmXv3zGIY+9XoTHJKnfUatUnrDe/8gBSjCCnvGYaM
         MxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZOUEjYnrw/jKRYqpi7q020fqNgK9R8UvUzzMbw50zY=;
        b=Tfvz2VX4MLfEWuyIpsPaGL8YRzR8r+scR1QN+HDRrPCBbAZO652QrFTA7u2EGKjdU+
         06P6J4VdGArRbJs5mcwk+IIXjTVIhA+6na1kkqMldVm1lqN3zguxVgjs6HAFXD9sjU5p
         CvmTzFRtyQ6gdMQ/fzDqf4hAek+Ot8s6IdaI/ihf+7Ru0+2J/J7nSA7C5MYDx01szOHG
         p9S5r42BjrYdfVO0/IJyzCxN50FfR7Pq4gHXvK8HFsRKEq0/V8S/C1TL9Bb6yzqegqIG
         0I5vt4+CWrLkWqExIKR0W9G5kqcPu3kGghBW8kJW5p4Vt2Jq/zBzJVjdkOaVkRvF8ssu
         fzMw==
X-Gm-Message-State: AOAM530wZjCqT0mok298d8ZPy/zXpkmsV7HvLQeyyn1r1o4sImYyVAFF
        52KgT38URLMKTQqSmTHrt6fmaQ==
X-Google-Smtp-Source: ABdhPJwqvYfk7WrXCeek5zIgmaL6JHMd+SCgDfry5zzeu3DJFq3BmX1JwmtE9dLTcxi/BJFMeSUD5A==
X-Received: by 2002:a62:1b06:0:b029:19d:d05d:f67a with SMTP id b6-20020a621b060000b029019dd05df67amr2471401pfb.78.1607173423110;
        Sat, 05 Dec 2020 05:03:43 -0800 (PST)
Received: from localhost.bytedance.net ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id kb12sm5047790pjb.2.2020.12.05.05.03.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Dec 2020 05:03:42 -0800 (PST)
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
Subject: [PATCH 7/9] mm: memcontrol: convert NR_SHMEM_PMDMAPPED account to pages
Date:   Sat,  5 Dec 2020 21:02:22 +0800
Message-Id: <20201205130224.81607-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201205130224.81607-1-songmuchun@bytedance.com>
References: <20201205130224.81607-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Convert NR_SHMEM_PMDMAPPED account to pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c | 3 +--
 fs/proc/meminfo.c   | 2 +-
 mm/page_alloc.c     | 3 +--
 mm/rmap.c           | 6 ++++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index a64f9c5484a0..fe90888f90a8 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -463,8 +463,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     ,
 			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			     nid, K(node_page_state(pgdat, NR_FILE_THPS)),
 			     nid, K(node_page_state(pgdat, NR_FILE_PMDMAPPED) *
 				    HPAGE_PMD_NR)
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 574779b6e48c..b2bff8359497 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -133,7 +133,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS));
 	show_val_kb(m, "ShmemPmdMapped: ",
-		    global_node_page_state(NR_SHMEM_PMDMAPPED) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_SHMEM_PMDMAPPED));
 	show_val_kb(m, "FileHugePages:  ",
 		    global_node_page_state(NR_FILE_THPS));
 	show_val_kb(m, "FilePmdMapped:  ",
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8fb9f3d38b67..ddaa1dcd6e38 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5568,8 +5568,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM)),
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			K(node_page_state(pgdat, NR_SHMEM_THPS)),
-			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
-					* HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)),
 			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
diff --git a/mm/rmap.c b/mm/rmap.c
index f59e92e26b61..3089ad6bf468 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1219,7 +1219,8 @@ void page_add_file_rmap(struct page *page, bool compound)
 		if (!atomic_inc_and_test(compound_mapcount_ptr(page)))
 			goto out;
 		if (PageSwapBacked(page))
-			__inc_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						HPAGE_PMD_NR);
 		else
 			__inc_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
@@ -1260,7 +1261,8 @@ static void page_remove_file_rmap(struct page *page, bool compound)
 		if (!atomic_add_negative(-1, compound_mapcount_ptr(page)))
 			return;
 		if (PageSwapBacked(page))
-			__dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
+			__mod_lruvec_page_state(page, NR_SHMEM_PMDMAPPED,
+						-HPAGE_PMD_NR);
 		else
 			__dec_node_page_state(page, NR_FILE_PMDMAPPED);
 	} else {
-- 
2.11.0

