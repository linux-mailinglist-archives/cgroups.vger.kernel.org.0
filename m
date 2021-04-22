Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F667367D2C
	for <lists+cgroups@lfdr.de>; Thu, 22 Apr 2021 11:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhDVJGx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 22 Apr 2021 05:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbhDVJGw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 22 Apr 2021 05:06:52 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B6AC06138B
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:17 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u15so14644512plf.10
        for <cgroups@vger.kernel.org>; Thu, 22 Apr 2021 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZTf4VDhB+vsAlWiKaTvh+bcNfZdV5PiIE39ZO2UyLSc=;
        b=QKA0xpPzIE5m7ObGgIH4Ww862+GJtKlZgxONOym/4benb+hChVs1lThp8lwEvL6DZx
         gS1BnKHW2MgjI3Lqh5503JGP4B0YVGJFdTsikNoUyTXVN116heU7bqRphUrvPGj92oKd
         +u5PUlbGn7/JrtSL9OtxLTP32nBbFwhlhOx4HU414jrOF5HheHVeODie6K4UMF1xs22x
         1CBrFHKGf5P2fQHjAKP1nUFeiSwN9yC7eLv+/vTZUzLUSaD2Hd9Io2IVjr+e60skyXih
         6kNpW9gEiD1qkbAycdjVN/M0wr2e+UqQWumISWzgQUrI+Hf7bbUsUK9udCeOsfxOK0LO
         WP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZTf4VDhB+vsAlWiKaTvh+bcNfZdV5PiIE39ZO2UyLSc=;
        b=teh4Jv1V544SHG/rZc1SHFk2SX+zuUF3LuuJ2c5EUId7QbJuF89lc5rYPFKqxWyT3R
         ffsYH/KLeaFSB/ZPTjHcwDVFfNZHxZPg2p3QKPx9W36WOk4nAeOVE9TNL7fhzx//5EUD
         cPKawyjLx59FQqnFK7fiNdiKU5BhMoTXg+LEazD8QdUow6PulBefvWgsSsuWF+TfJrMj
         RWpVvhDlPI3uKYZDmOx0OGeIHmX97wioIcO8QNcdt2vQmwO5RwMLWIGAlNrksyBZa+Ru
         t0e33KdcC/5QMlX9zYId0CBgxLCSJkm5df0idp1CmOwpBoW4aHwcmRTRjM9P3Ou4y9dj
         V+LQ==
X-Gm-Message-State: AOAM533YH3O3vGhRoq6/8cJpgg84vw4BD1LMH/47MKpOx0i9I82gWr2K
        IrA0OBiw/3Wg6oZRrhepS8/I9g==
X-Google-Smtp-Source: ABdhPJy7hDjm/CvB0p5qTi+Hnk4OrdeiYrBuA5gdl7Zxb1Pv4C2IC+AbA17XxgO/+j11iunrSnKAAA==
X-Received: by 2002:a17:90a:4290:: with SMTP id p16mr16316343pjg.120.1619082377567;
        Thu, 22 Apr 2021 02:06:17 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id x2sm1514348pfu.77.2021.04.22.02.06.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Apr 2021 02:06:17 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     akpm@linux-foundation.org, lizefan.x@bytedance.com, tj@kernel.org,
        hannes@cmpxchg.org, corbet@lwn.net
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/3] mm/mempolicy: apply cpuset limits to tasks using default policy
Date:   Thu, 22 Apr 2021 17:06:06 +0800
Message-Id: <20210422090608.7160-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422090608.7160-1-wuyun.abel@bytedance.com>
References: <20210422090608.7160-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The nodemasks of non-default policies (pol->v) are calculated within
the restriction of task->mems_allowed, while default policies are not.
This may lead to improper results of mpol_misplaced(), since it can
return a target node outside of current->mems_allowed for tasks using
default policies. Although this is not a bug because migrating pages
to that out-of-cpuset node will fail eventually due to sanity checks
in page allocation, it still would be better to avoid such useless
efforts.

This patch also changes the behavior of autoNUMA a bit by showing
a tendency to move pages inside mems_allowed for tasks using default
policies, which is good for memory isolation.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 mm/mempolicy.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d79fa299b70c..e0ae6997bbfb 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2516,7 +2516,10 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 
 	/* Migrate the page towards the node whose CPU is referencing it */
 	if (pol->flags & MPOL_F_MORON) {
-		polnid = thisnid;
+		if (node_isset(thisnid, cpuset_current_mems_allowed))
+			polnid = thisnid;
+		else
+			polnid = node_random(&cpuset_current_mems_allowed);
 
 		if (!should_numa_migrate_memory(current, page, curnid, thiscpu))
 			goto out;
-- 
2.31.1

