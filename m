Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D12CBCC2
	for <lists+cgroups@lfdr.de>; Wed,  2 Dec 2020 13:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729879AbgLBMRW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Dec 2020 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbgLBMRV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Dec 2020 07:17:21 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0585FC0613D6
        for <cgroups@vger.kernel.org>; Wed,  2 Dec 2020 04:16:36 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id h7so539780pjk.1
        for <cgroups@vger.kernel.org>; Wed, 02 Dec 2020 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D0YvfFeRVroyy8DOM8jNI9C4k7vyQ+vFDUfvEXQRIw=;
        b=pZfhUnAfhJIC6/Dv5lxitZ9cKXI7bpi1N7AHDZuXk5iD1odIfF+g8ifMX49reRjF99
         yLEwUP6xyJa0nYkrqHO91vMYQ0XAv/FNqFSpBKoRgkUEIaxAezWlS9w7l1dzjubGclHz
         ThKFQZj7svmOUlI0TdwlQFxJqtLyJL8U5k8/hNqr/2y9OXXb/sFzwZi/Q8k5LSWxGNqG
         qLYgioFTLRmCw5DxE2volAw4/zrCDm+38iAqBgx7OE56INmP/Ga0CGzxUAxMMxQl5750
         sA7qPKmbiVH9tN0Hi/Oa6rm0yp0xRwGe3VrMmaVeLVrF2NOS+g5K8NvQLuwSa7TZc4TS
         d/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0D0YvfFeRVroyy8DOM8jNI9C4k7vyQ+vFDUfvEXQRIw=;
        b=hatd/ySLauDcvnvN09AW2hAoFsEawoEftd4zDFaE/MNYAxBs461boI+CEQiPUCQCuF
         ZYY9Ztm+H0CYcA35Xc7kdKQZ0etaIwghsWpNsMOzGprfTA6zWD+KDb4xQe9a4UnnGB/+
         OyMqH3gjsoUB5+dcGfXrR38jXVxxf6ngYRWr0sZWPwWQI5HYXt5dmYtxHo7znORPJLaf
         sL7nWwpw+0KJ4GcyscaS4LxCk+BACdz4hQELD4C1U+Fb4e9/Wfe9lgWLXJhslrYyLyyy
         3UcYkADasCG4nZmL1CJdXXJjuk3JYB5+OQAmuCNa6EGBRox/LUv2V33/6YWX2Beq8IkW
         /xtQ==
X-Gm-Message-State: AOAM531yfCkVlR6smotuTHIXTsLokdh0Kg/X7e1sej8dKx8KQsA5FjQI
        yRGbMARIUCIm5cLw+wqTULoBAw==
X-Google-Smtp-Source: ABdhPJwEcQ4LPF+w2bx+8qB8eyH1ySMsXXOgJG55j8ylaLQmmrGHP7+W2ehYLVoe0ItPybgrsHJf3g==
X-Received: by 2002:a17:902:bc81:b029:d8:ef30:b518 with SMTP id bb1-20020a170902bc81b02900d8ef30b518mr2274981plb.81.1606911395581;
        Wed, 02 Dec 2020 04:16:35 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id 77sm2348479pfv.16.2020.12.02.04.16.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 04:16:35 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/memcontrol: make the slab calculation consistent
Date:   Wed,  2 Dec 2020 20:14:34 +0800
Message-Id: <20201202121434.75099-1-songmuchun@bytedance.com>
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
---
 mm/memcontrol.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9922f1510956..03a9c64560f6 100644
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
@@ -1587,8 +1597,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
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

