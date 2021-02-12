Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35531A336
	for <lists+cgroups@lfdr.de>; Fri, 12 Feb 2021 18:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhBLRDl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Feb 2021 12:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhBLRDj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 12 Feb 2021 12:03:39 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26801C06178B
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:28 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n10so16606pgl.10
        for <cgroups@vger.kernel.org>; Fri, 12 Feb 2021 09:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mHQ3glb31sFuwvoGcKO+DumCO9HSr0Bb7Nri9jWV50=;
        b=mAnF3VGeuW6pSRvu2LN2xqj+dzYyLwh/OPEDqMeHluwaz2poT5if4WhFnoBubDskRD
         WhemKL3Sc0cI5yOpXFf9KOI9IxspEKlb0Yx00kM0w2z3lZWpHDh9nEqUqtIJIKQPqLA5
         xcpTmN54VOVH83PLYEfe7rFxnQwCu3TC8LcM+lp8sY5f2JdsTwXNHNUz/KY0RPxxBpqK
         ZJB6hm8JCvRjPWPpLFw2sWnkKZDw26g3HarWaEIjaNl5953EBj7UaCDr50tnWTqaScTC
         rvhmQZW1Vgq9yaElWbZpHKpFG09EA5M7Ga5tjZxGq+ijpVfQQ8fzo1Axg+qd6FtjiW1J
         52Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mHQ3glb31sFuwvoGcKO+DumCO9HSr0Bb7Nri9jWV50=;
        b=LHJ1D0jga6fKbW7cvZSeCMgGgoS7euLzTDFRujbY3E39JNndgUyC92sYjRDkMuFKvt
         7A5/8WM9g2Ok2W+8CxNb1XsnxEm92UddlSsWabt8wgOSzRAb7cv6LPmLnAkkRcITRZyr
         CLIO5YVnl5LIGuUJW+1M7dSUPA1e4rNPyHDt/n2HgMlbdAh9AzEEO9J+VeuIULeEpDcS
         emALuCUHacGQ6xheWg9dyHk4AKSnxV2n3RANWXsIQhSLlZGWkfJC8vpT6eU0kaXx1Q0K
         N9m96j942fD8JAxc0ATkyHveKmROvk+6fa85/9zW6HfoMuAUKTNUxbHA5JINfCOhSoom
         mS3g==
X-Gm-Message-State: AOAM532MX+H5gSgePdxbKULfgR8taUXmmXIF28YjvbU5fXKyVXFACv4i
        stLahK4Akv2FQGiHS3GaIAM4Lw==
X-Google-Smtp-Source: ABdhPJyYIF4+lkvlNFXhM8SAayi2rNZb5rZhRBWKr/m9i+0EfQyNSsW8uvtRc94AUdYeVdY9ep214Q==
X-Received: by 2002:a62:7fcb:0:b029:1da:36b1:8ac7 with SMTP id a194-20020a627fcb0000b02901da36b18ac7mr3749647pfd.13.1613149347766;
        Fri, 12 Feb 2021 09:02:27 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id e21sm9317815pgv.74.2021.02.12.09.02.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 09:02:27 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/4] mm: memcontrol: fix swap uncharge on cgroup v2
Date:   Sat, 13 Feb 2021 01:01:59 +0800
Message-Id: <20210212170159.32153-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210212170159.32153-1-songmuchun@bytedance.com>
References: <20210212170159.32153-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The swap charges the actual number of swap entries on cgroup v2.
If a swap cache page is charged successful, and then we uncharge
the swap counter. It is wrong on cgroup v2. Because the swap
entry is not freed.

Fixes: 2d1c498072de ("mm: memcontrol: make swap tracking an integral part of memory control")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c737c8f05992..be6bc5044150 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6753,7 +6753,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 
-	if (PageSwapCache(page)) {
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) && PageSwapCache(page)) {
 		swp_entry_t entry = { .val = page_private(page) };
 		/*
 		 * The swap entry might not get freed for a long time,
-- 
2.11.0

