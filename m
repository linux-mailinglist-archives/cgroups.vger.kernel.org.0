Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F9267B48
	for <lists+cgroups@lfdr.de>; Sat, 12 Sep 2020 17:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725850AbgILPv1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 12 Sep 2020 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILPv0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 12 Sep 2020 11:51:26 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0D6C061757
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 08:51:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so3134003pjr.3
        for <cgroups@vger.kernel.org>; Sat, 12 Sep 2020 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MxdQf9tv8eKzDg+x6Dz/JKJDrhNk6PlqBxr5x7bwNs=;
        b=w6jbt/CYSIpBugZJMVeS5NXurkdpxIawr2/+p5QKDl9ySs+weYpHK8k+foGfrwF4Tp
         3OlxZZtGbi+3nDmKvs49wq0tcgm9aKlYhWTR3UW1f/XpTCA0ZN0qDZMrLgLDaz9VHxNj
         ZcDSWsLbsvbivWVPnacSeT37LPh5zNjNIlIOIzxFVJUJ0Fdx3y6mzxqX1c+s+u8dQSbA
         XlmPiOQeEZmWRaZs5WdzCjuHeBaNEWWN5v4HH3Skq/8Bptolk093bINUyVF1DDCcDgTk
         pf21/VIdwJvxHEGlpJmjwRF//wmPw7y7qPJ1p9FZ/xfr2LTYJpx2g6S1fnvTOGwRpLT+
         csKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MxdQf9tv8eKzDg+x6Dz/JKJDrhNk6PlqBxr5x7bwNs=;
        b=TzYAvNB5uuvHQX1K6Ozll32V8navWVDf567bYfqnEKaRTiRIJZYqtWZM7KzuHLnv78
         oPnDCOjEQ8aFt3kxD8KTep2SifuZQHLnq+S60QrNPNWYIKk8jPClizRTdad/ONTglXym
         Htj6e8R9cSo6kUWXQTaTOoBDbdZ6g7TZQx9mTa24ZYspWc2F9caDHPc1E7jlvj6QlSsS
         x+/BQ39kAfvuAWrBGA9wemHSMWazYXbSdBNxKEWOpuJlF7awg7tNL6GYmF54nuINHQHJ
         7bUf+yKWvD9NGKsHUzBJbEGT8btFRcx/wHSq4V1qHBno0ehVD8mMBMaC/Zlarz4yQfSq
         +drQ==
X-Gm-Message-State: AOAM531IezkIjnXbUsP+IyjgV6HxdkMP1GTaL1/CfFtOeECg1yji/RSt
        CDQyv/iBz6c5KfnWKhTs/bXa9w==
X-Google-Smtp-Source: ABdhPJy6/dMj1soW8/OLyYEGy7kbZ4UUlnazKCDGWJoQx26D4vqSHo2SJCAuXiLCgyi3+OIje1XQEg==
X-Received: by 2002:a17:90a:f415:: with SMTP id ch21mr7118293pjb.18.1599925884681;
        Sat, 12 Sep 2020 08:51:24 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id kf10sm4691156pjb.2.2020.09.12.08.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Sep 2020 08:51:23 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: Fix out-of-bounds on the buf returned by memory_stat_format
Date:   Sat, 12 Sep 2020 23:51:00 +0800
Message-Id: <20200912155100.25578-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memory_stat_format() returns a format string, but the return buf
may not including the trailing '\0'. So the users may read the buf
out of bounds.

Fixes: c8713d0b2312 ("mm: memcontrol: dump memory.stat during cgroup OOM")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f2ef9a770eeb..20c8a1080074 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1492,12 +1492,13 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 	return false;
 }
 
-static char *memory_stat_format(struct mem_cgroup *memcg)
+static const char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
 	int i;
 
-	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
+	/* Reserve a byte for the trailing null */
+	seq_buf_init(&s, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE - 1);
 	if (!s.buffer)
 		return NULL;
 
@@ -1606,7 +1607,8 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 	/* The above should easily fit into one page */
-	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
+	if (WARN_ON_ONCE(seq_buf_putc(&s, '\0')))
+		s.buffer[PAGE_SIZE - 1] = '\0';
 
 	return s.buffer;
 }
@@ -1644,7 +1646,7 @@ void mem_cgroup_print_oom_context(struct mem_cgroup *memcg, struct task_struct *
  */
 void mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
-	char *buf;
+	const char *buf;
 
 	pr_info("memory: usage %llukB, limit %llukB, failcnt %lu\n",
 		K((u64)page_counter_read(&memcg->memory)),
@@ -6415,7 +6417,7 @@ static int memory_events_local_show(struct seq_file *m, void *v)
 static int memory_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
-	char *buf;
+	const char *buf;
 
 	buf = memory_stat_format(memcg);
 	if (!buf)
-- 
2.20.1

