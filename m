Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7052C30A
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 21:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiERTJQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbiERTJQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 15:09:16 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F787A31
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 12:09:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x22so2363076qto.2
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYqL0MLG1DbGBmgYMURzmvbXpQhyxhj8gl5i89V5r90=;
        b=f4jYk60DD7udDhMwkKHqiV6/3YrbRjeifcxR7rq36/5EDL0R7jhskIGVLU0Im7kLx8
         70gOwl8k95pY8w6wTsYt4l1qya3jYGUjdU4krCPxnEwDJZa+O9K1GV6WOJqvpU0N2hsU
         jNbS2Xf5epeNioenJq5vogiBiqKhhtztNd332raQBunqiAtMwZXRSZ4vS9FZ2zahG2Xz
         Tdtr/WGcNNFQ3sVbXiMJDn7gQQlPw+hV9neokhvbfEx5F6p+rgK6OIluXTNfrNY5OHg2
         kr/uYhgBp3FfZ8WlbmqCx/n3SI1I2Qukgj7FPLw+jAg39ZLZlyNizMY6oHGkhfwWayAv
         A6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYqL0MLG1DbGBmgYMURzmvbXpQhyxhj8gl5i89V5r90=;
        b=Ea1YnVVEbOvlkFUGL+L2cVippOA7kZNInWAQaSHuXvtPXCGxDrWsYP7HuOKlr6gS+l
         yNb+jcenzkGSGKsIG2fKAxzBLebJnswgFSPJ0MClpT+pgaVmPDJS3yn9aNDo6ndsRddl
         jZfXpSTdS+Mz3s+PMkjyILmOholEZKaQA000nnI17vPxgA2ZhYus9/e1nVNjnZL7CYhy
         5GLWT7wZqB7OahZX300uu2BLADfDssjAr+aj/dHbBWIFBhM9fu0YRUAg8mcWDoukjWV7
         2MozX75nfirmy8b+vJ42r3osqbXCuOp6d2NZ7g77gTYopkhl9DAxc04lHPboQkyjDVBK
         Qlvg==
X-Gm-Message-State: AOAM530QXQVRmbJdYemkDZ0MnVxkD19CZW5d25nrga8Bx0wf1wHdNhPJ
        rCDaEHqSlRUIVy8POvUolFSq+w==
X-Google-Smtp-Source: ABdhPJwumIQaKq5F0GW4ytkYAWRSgYk3zDOPU/2iHgy/+RVZ51/DaRFHNuE+SaxmvNviRCqS28HKCw==
X-Received: by 2002:ac8:5f4c:0:b0:2f3:c99c:e246 with SMTP id y12-20020ac85f4c000000b002f3c99ce246mr1158818qta.122.1652900953299;
        Wed, 18 May 2022 12:09:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b35b])
        by smtp.gmail.com with ESMTPSA id f9-20020a05622a104900b002f39b99f69fsm3011qte.57.2022.05.18.12.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 12:09:12 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
Date:   Wed, 18 May 2022 15:09:11 -0400
Message-Id: <20220518190911.82400-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.

Its premise was that cgroup reclaim cares about freeing memory inside
the cgroup, and demotion just moves them around within the cgroup
limit. Hence, pages from toptier nodes should be reclaimed directly.

However, with NUMA balancing now doing tier promotions, demotion is
part of the page aging process. Global reclaim demotes the coldest
toptier pages to secondary memory, where their life continues and from
which they have a chance to get promoted back. Essentially, tiered
memory systems have an LRU order that spans multiple nodes.

When cgroup reclaims pages coming off the toptier directly, there can
be colder pages on lower tier nodes that were demoted by global
reclaim. This is an aging inversion, not unlike if cgroups were to
reclaim directly from the active lists while there are inactive pages.

Proactive reclaim is another factor. The goal of that it is to offload
colder pages from expensive RAM to cheaper storage. When lower tier
memory is available as an intermediate layer, we want offloading to
take advantage of it instead of bypassing to storage.

Revert the patch so that cgroups respect the LRU order spanning the
memory hierarchy.

Of note is a specific undercommit scenario, where all cgroup limits in
the system add up to <= available toptier memory. In that case,
shuffling pages out to lower tiers first to reclaim them from there is
inefficient. This is something could be optimized/short-circuited
later on (although care must be taken not to accidentally recreate the
aging inversion). Let's ensure correctness first.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
---
 mm/vmscan.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c6918fff06e1..7a4090712177 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -528,13 +528,8 @@ static bool can_demote(int nid, struct scan_control *sc)
 {
 	if (!numa_demotion_enabled)
 		return false;
-	if (sc) {
-		if (sc->no_demotion)
-			return false;
-		/* It is pointless to do demotion in memcg reclaim */
-		if (cgroup_reclaim(sc))
-			return false;
-	}
+	if (sc && sc->no_demotion)
+		return false;
 	if (next_demotion_node(nid) == NUMA_NO_NODE)
 		return false;
 
-- 
2.36.1

