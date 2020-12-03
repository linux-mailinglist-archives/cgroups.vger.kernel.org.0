Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449802CCD21
	for <lists+cgroups@lfdr.de>; Thu,  3 Dec 2020 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgLCDOi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgLCDOh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 22:14:37 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E16C061A4E
        for <cgroups@vger.kernel.org>; Wed,  2 Dec 2020 19:13:57 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b23so341525pls.11
        for <cgroups@vger.kernel.org>; Wed, 02 Dec 2020 19:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwVqmku+KuF7CBDwCXmp7GQf251F6L0Ar739gqzf9cU=;
        b=tITewJgNthn6PxKyqtA6y7Hsga8qG37N3FDSi29gWHRtvQG+yNxwFH68T9T2/XjU2d
         McUpVdjLgYPQlC7j8HhQPXZO+rMwHmoB1qk4zk1HY/jZ92ViyXbppXXZsVTD8iN8M8Av
         TPbPm1yTQzGCsDMl7nhuEzLoA0QSHzG+aqEYuvfqcJ/7hAouPj31QXTnaVm4ZVCEB1hy
         WGBtEaiDvKXSp9rE0YOCwfzz5B4NsC8gRkvzGjKJZx9QyHNyuspmL6hPsDRI1+P5oYzd
         kEC1TPjDhslQHfF862x4i6EA/EofAGpWNJlm9oyLEjfSng0F8LXkHEddvJadX359XlfS
         20Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwVqmku+KuF7CBDwCXmp7GQf251F6L0Ar739gqzf9cU=;
        b=C3BwHPmpwvFkDSN1+8jhqjh4ky3OoHG1lVhpmJhCj+j2Z/YQg9u4zJeoko/6o2yt9X
         iARtQW4Ze1npOvKi+D+PtbdT0R2mXY12axUSfH9r2d/UI9F9mtQISoIYCJUhCboN3tko
         +XW//+FkzLk5pRFB404tcEAQ3pYrhnNa3LQM83VNPb7u4D0yQDXNYSc6/T9HjpsndZYn
         ozFOaSr9CD/dXRhDt9Z8U8vEKUPY9WBJ/p8p8groyw55XkYyPU6PyW+396c1h1oaYARG
         kiR9w6GzLptSqU1reyZVx2znwwCJ1u3jPvH929miPx4qpwKG1EXw+c0boLQojHJIs8Re
         aamw==
X-Gm-Message-State: AOAM530BQEWtMscBSb3Q5sh+3y8Mqsi9Ji7Nl38zZXN/1kOnvOAddMce
        yeL3DOuHUKJqnB5cBqS4RioAUg==
X-Google-Smtp-Source: ABdhPJzl03ea3XSeGXYOVgpi8aLf35MXOyZs4Z9pSvj8lIUn7ZAIrJEQm2Si9i8tcFkT/yKaS0jxEQ==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr1073959pjg.218.1606965236823;
        Wed, 02 Dec 2020 19:13:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.95])
        by smtp.gmail.com with ESMTPSA id f17sm418336pfk.70.2020.12.02.19.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 19:13:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2] mm/memcontrol: make the slab calculation consistent
Date:   Thu,  3 Dec 2020 11:11:11 +0800
Message-Id: <20201203031111.3187-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Although the ratio of the slab is one, we also should read the ratio
from the related memory_stats instead of hard-coding. And the local
variable of size is already the value of slab_unreclaimable. So we
do not need to read again. Simplify the code here.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
Changes in v2:
 - Add a comment in the memory_stat_format() suggested by Roman.

 mm/memcontrol.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9922f1510956..75df129b7a52 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
+		switch (memory_stats[i].idx) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS ||
-		    memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		case NR_ANON_THPS:
+		case NR_FILE_THPS:
+		case NR_SHMEM_THPS:
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
+			break;
 #endif
+		case NR_SLAB_UNRECLAIMABLE_B:
+			VM_BUG_ON(i < 1);
+			VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
+			break;
+		default:
+			break;
+		}
+
 		VM_BUG_ON(!memory_stats[i].ratio);
 		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
 	}
@@ -1586,9 +1596,15 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		size *= memory_stats[i].ratio;
 		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
+		/*
+		 * We are printing reclaimable, unreclaimable of the slab
+		 * and the sum of both.
+		 */
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
-			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+			int idx = i - 1;
+
+			size += memcg_page_state(memcg, memory_stats[idx].idx) *
+				memory_stats[idx].ratio;
 			seq_buf_printf(&s, "slab %llu\n", size);
 		}
 	}
-- 
2.11.0

