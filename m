Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D03C71CB73C
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEHScR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727088AbgEHScP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:15 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E24BC061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:14 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g16so1375698qtp.11
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OaDRgIP/LaVuaLkrKFBfAyYPwFi/McMfSqQvrDbKR0=;
        b=qFPqOIpOx/A+KsibW/cl0Kiy5Z1zAe7JNze5nGAi3sKwnpKqCbDXG2CIi9NwZruWit
         wyxuR/txmqvpZmMGhWtGhWqeVGfp5U2i5eUyFvQqxo0BpnWaC2X0vKVkXvOzDTk9sGcb
         Uz/DvNHU/dVL72Or2yDR9sr0k8DlR4YkTusMw4uJRoRuMmjKgQkI439rEFMZvkny6vQ+
         XxesdgdLu6f8XL+v/h6bU3OHfAtVtdYFEQtFsVlICLaRcMptHDEnpI4s3O3V35JX2Sji
         ykBrfgj72yhUYyNQJZRPD2mVo6pertJvdn+XSfP9aqaR9RyW3W5nXMy2hyAUN2sdHSMH
         kEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OaDRgIP/LaVuaLkrKFBfAyYPwFi/McMfSqQvrDbKR0=;
        b=mNz+me7QTwjhHyZXLZEjsP7lltNboQjdQOYAC+nUc9yUh4JWW1vjvlKKRZ7D1wvobW
         ljl6Wl9zOW7nVXRZAWQ+WPCEAV2yQ7vZNXKg7XsU6rsyknUOVP1jlIPuApUpD9K/e1Q5
         0Rum0Ta4whimWEf+hHC2P5lHbxWcadsdmtormol0nuQMHG5bpJLNiI7J3OEyQSiF+KNh
         +DQ9EJAYmgVFrvPp7yW4FZryXTwPxCaRQLlPWHgZgM2JHMIhSSVpTMq1EvxyPCIGCjWp
         ZkWxkSB/LrxSpKr/2ZLDAsZqDKAipUbXKXN9f779boS/1WsREKmfa6raZyXOwCPwP51T
         Z/uA==
X-Gm-Message-State: AGi0PuZh0T+5Z8eiJb1o6mkb+qndlB+QRQ1TUQxV0ppAOA678vongV73
        wIiemHpm8B9jZfs0jgs0OxQvHQ==
X-Google-Smtp-Source: APiQypL6bxt/DQCIOwoBK2IN92lKSHldYkBgPF/Y2re35ZWYFNZiUvxC/szX/AkYe5Gr6EiezpkU5A==
X-Received: by 2002:aed:2b43:: with SMTP id p61mr4384521qtd.298.1588962733581;
        Fri, 08 May 2020 11:32:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id x34sm2225542qta.43.2020.05.08.11.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:13 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Joonsoo Kim <js1304@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 01/19] mm: fix NUMA node file count error in replace_page_cache()
Date:   Fri,  8 May 2020 14:30:48 -0400
Message-Id: <20200508183105.225460-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When replacing one page with another one in the cache, we have to
decrease the file count of the old page's NUMA node and increase the
one of the new NUMA node, otherwise the old node leaks the count and
the new node eventually underflows its counter.

Fixes: 74d609585d8b ("page cache: Add and replace pages using the XArray")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/filemap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index af1c6adad5bd..2b057b0aa882 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -808,11 +808,11 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
 	old->mapping = NULL;
 	/* hugetlb pages do not participate in page cache accounting. */
 	if (!PageHuge(old))
-		__dec_node_page_state(new, NR_FILE_PAGES);
+		__dec_node_page_state(old, NR_FILE_PAGES);
 	if (!PageHuge(new))
 		__inc_node_page_state(new, NR_FILE_PAGES);
 	if (PageSwapBacked(old))
-		__dec_node_page_state(new, NR_SHMEM);
+		__dec_node_page_state(old, NR_SHMEM);
 	if (PageSwapBacked(new))
 		__inc_node_page_state(new, NR_SHMEM);
 	xas_unlock_irqrestore(&xas, flags);
-- 
2.26.2

