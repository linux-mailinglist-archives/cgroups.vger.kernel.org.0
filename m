Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9702E183659
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 17:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCLQlk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 12:41:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54422 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgCLQlk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 12:41:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id n8so6833742wmc.4
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=N2Uu/Isy7NWEK22NJk3FeLyFIU8DnOEsZiiSW7A75uw=;
        b=t7xkgWzL7lP8/guUn9rLcXqc2L/I8M4mdPLj2rg4UyMUaDhBh7A5BFsyNeuUrfj5Sy
         sZUf9YD87y994A6gKWXRpHFpH80VKHCF7N3X/4Pv5qvlLvmKlvIqQmk2yNsoJjceEcwr
         RTAWrygWaUxgm6QfhsJnWIPCeHwo+bWOupSI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=N2Uu/Isy7NWEK22NJk3FeLyFIU8DnOEsZiiSW7A75uw=;
        b=YvbK/wc1aO84GBqh28LP7xTstTgyFESMOI9Doonmk/B/p231tZiC9tBfFHmKllDhMJ
         I9QYSsr/QwqwBRT6DTBS8UnP3X2L+5lW72jyPAFEJXGTg5uzhckZs2m63oSUftEwsigR
         EkmB7b97fI9T96OqanphIaETZqx7zHYHC6J++PbtubRB5IQmtEIXuMFFYBCQ1Z6jocqV
         yEdIJXWqMaKmF7lK5jpj1byPr5m4sG+DHGnKGG/z+tpxef0b1T+H8UKr1HPODQ1JXaIl
         DkJOIv97Rt01QAMd+zAA1OYjzsXzZ7fPGBQwSHQbGzdJ5THLMQtCxSvZ8St3c2+yz9Rw
         fQOw==
X-Gm-Message-State: ANhLgQ1jZj5aLkq+161tNWujYc5vV+aQ+6AUAIyyEc4oA8hXPb7PxwhJ
        6jYIdslFEHVHJYJ1EZYg/I+szA==
X-Google-Smtp-Source: ADFU+vvlNP+sTGWtwglGQNPghD1uV2b6E7MyhcfHEsjAve9zJzNS72Sz6SK5JO+Zicct59iWDQt/KQ==
X-Received: by 2002:a1c:5585:: with SMTP id j127mr5652787wmb.35.1584031298224;
        Thu, 12 Mar 2020 09:41:38 -0700 (PDT)
Received: from localhost ([89.32.122.5])
        by smtp.gmail.com with ESMTPSA id m19sm12906711wmc.34.2020.03.12.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 09:41:37 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:41:37 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm, memcg: Bypass high reclaim iteration for cgroup
 hierarchy root
Message-ID: <20200312164137.GA1753625@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The root of the hierarchy cannot have high set, so we will never reclaim
based on it. This makes that clearer and avoids another entry.

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kernel-team@fb.com
---
 mm/memcontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 63bb6a2aab81..ab9d24a657b9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2232,7 +2232,8 @@ static void reclaim_high(struct mem_cgroup *memcg,
 			continue;
 		memcg_memory_event(memcg, MEMCG_HIGH);
 		try_to_free_mem_cgroup_pages(memcg, nr_pages, gfp_mask, true);
-	} while ((memcg = parent_mem_cgroup(memcg)));
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		 !mem_cgroup_is_root(memcg));
 }
 
 static void high_work_func(struct work_struct *work)
-- 
2.25.1

