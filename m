Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1291CB74D
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 20:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgEHScq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 14:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEHScp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 14:32:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D1DC061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 11:32:44 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id q13so2134969qtp.7
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 11:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjwifLkaxtnwjsDLki9oTn/ODVTE0c1W9xwEMFneqd4=;
        b=q2dyjdEbv83IUE3u02r2JwYp7811qVwPgshXKCrQ9XsOoThuy+yCgx3eE+3O06I4nk
         sA2UB6pDLm7Cl3ukEoSeqZ4absWqRl+rAuxVm35o9C8uulHk6tDaLg2OW64hPvYjMfPq
         h1nO3+CuPO7MSvFT8px0tCOrBddzqfjGfIsySPjI7CJLvGVVKfGcW9YX0CHvGlWCu3eI
         ZSOGDPjXfO7ba7ayjNCh1zngQEJvJ0Q7F/lJ9RAxmpg0eca0qEWUl/Zhn6BNtOlpc3JP
         KMXOdTZnVyl63bvpRi5/fbOGw/EtLtsnjpmczC5i18yY0lhPEZL3g44yjE/BuRqyt+9f
         tzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjwifLkaxtnwjsDLki9oTn/ODVTE0c1W9xwEMFneqd4=;
        b=rDw3CSNUufF5oIjw1RZAkc3tscHwLF8Ns0jPsBd28WI0BrSNGoM0c7lm05C2PiuKxN
         aYEMGDVHfMorMaNNmllPIwkJ/1ed73AV/2gRN6kg6pei+ehvFQVZLez/zLcGZhuZkHJP
         IXv4AhOyPUV5Xw3JT+JL4x5rEBbq0VH6TJxCmCLBO3GBOI2MkLDYkfGvs+r1oy7D2RE8
         M2JiveRP+5u3jJJgq3mhR4DNOe9I/m8eRb/kS3HaIiQnNW7VkZPf8mxjrVouCTdTbJVg
         4E1rnPzfQnZ2Hr+qQqfDOwMwmK89D9/VO9hot9kclgjfv+IjrDHUblGPzoiW1/nQNfou
         MPVg==
X-Gm-Message-State: AGi0PuZQmrJKXNR+yR7H6BMV146gfXoygy+OAZcA6tDY2MM1ahSXSzxF
        AD5v3a7pkEh6aSxyU6XnI0WbXdTNLkc=
X-Google-Smtp-Source: APiQypKVCx22J2K5w35bf60sV1gZioeQd40D9P2B8Ud1CnlBKzSyhGcvkchitCvEL8araIDX3HOMIw==
X-Received: by 2002:ac8:2c4f:: with SMTP id e15mr396815qta.27.1588962763459;
        Fri, 08 May 2020 11:32:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id u11sm2090127qtj.10.2020.05.08.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:32:42 -0700 (PDT)
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
Subject: [PATCH 17/19] mm: memcontrol: document the new swap control behavior
Date:   Fri,  8 May 2020 14:31:04 -0400
Message-Id: <20200508183105.225460-18-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508183105.225460-1-hannes@cmpxchg.org>
References: <20200508183105.225460-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alex Shi <alex.shi@linux.alibaba.com>

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 .../admin-guide/cgroup-v1/memory.rst          | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/memory.rst b/Documentation/admin-guide/cgroup-v1/memory.rst
index 0ae4f564c2d6..12757e63b26c 100644
--- a/Documentation/admin-guide/cgroup-v1/memory.rst
+++ b/Documentation/admin-guide/cgroup-v1/memory.rst
@@ -199,11 +199,11 @@ An RSS page is unaccounted when it's fully unmapped. A PageCache page is
 unaccounted when it's removed from radix-tree. Even if RSS pages are fully
 unmapped (by kswapd), they may exist as SwapCache in the system until they
 are really freed. Such SwapCaches are also accounted.
-A swapped-in page is not accounted until it's mapped.
+A swapped-in page is accounted after adding into swapcache.
 
 Note: The kernel does swapin-readahead and reads multiple swaps at once.
-This means swapped-in pages may contain pages for other tasks than a task
-causing page fault. So, we avoid accounting at swap-in I/O.
+Since page's memcg recorded into swap whatever memsw enabled, the page will
+be accounted after swapin.
 
 At page migration, accounting information is kept.
 
@@ -222,18 +222,13 @@ the cgroup that brought it in -- this will happen on memory pressure).
 But see section 8.2: when moving a task to another cgroup, its pages may
 be recharged to the new cgroup, if move_charge_at_immigrate has been chosen.
 
-Exception: If CONFIG_MEMCG_SWAP is not used.
-When you do swapoff and make swapped-out pages of shmem(tmpfs) to
-be backed into memory in force, charges for pages are accounted against the
-caller of swapoff rather than the users of shmem.
-
-2.4 Swap Extension (CONFIG_MEMCG_SWAP)
+2.4 Swap Extension
 --------------------------------------
 
-Swap Extension allows you to record charge for swap. A swapped-in page is
-charged back to original page allocator if possible.
+Swap usage is always recorded for each of cgroup. Swap Extension allows you to
+read and limit it.
 
-When swap is accounted, following files are added.
+When CONFIG_SWAP is enabled, following files are added.
 
  - memory.memsw.usage_in_bytes.
  - memory.memsw.limit_in_bytes.
-- 
2.26.2

