Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC212E6900
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 17:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441155AbgL1Qmz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 11:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441130AbgL1Qmx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Dec 2020 11:42:53 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9A3C06179E
        for <cgroups@vger.kernel.org>; Mon, 28 Dec 2020 08:41:53 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h10so5589134pfo.9
        for <cgroups@vger.kernel.org>; Mon, 28 Dec 2020 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sihbqHAwSrWiI/mby0PYKEUO9C1z2oJ0qLp+LWcjDHg=;
        b=j0OfcSNpacng4hvdoRiR1uS85K8rrj0CdsiliQJQ8Og/XxzfCZ6Ea3Vf62WLk18s1t
         097T5NlYVhpsy3KHkrlBaAGQB/80yljFxfLNi69xsPgf/5Pv/HhU0nZPqmt35olPihVB
         oyfOiR0eqLBYui3e9zAcs8ntUCbtnuGhNAlBLauG7rodu0rZJfaNb3ApAb0ONT0iokb7
         TnqteMs2En4iGsY7j/R/QtN4G9zGXpf1NW8pmmCI3Gqj5tbjpETbvDBGHFDTLcqFhejr
         TFjBesOPf+dliiY+rEfOv5tFQAYyf7MvvZ3PWlCwDOXxqIVJk0ENuaH8f2Jp8QrEVSrM
         EiVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sihbqHAwSrWiI/mby0PYKEUO9C1z2oJ0qLp+LWcjDHg=;
        b=LC/5iTEdka5siU19k/oPK4bnzxFN059+UvWR+5GuZ2SS6XbmBMXzwshB+xdrZzkAJT
         oDhcGcA4rjuLyeaXSq3niYdWGw2SkYut02AWmd5PJLg6YeO7hjwV1AAb4nlWTOwkl5Sj
         2rlP9l6ptfE2VhR/imY8qVuOhJKJlaDZgpnUQFrpM2095RO0XsRcW9ueXbJzMItoGlWj
         isHEOWOLScgPboZa/G7nlebvI92K2mU/h4laUzmbcBx9toKT4IL14zD6E8RsogkAiQ6V
         RCyI1MPueQkAlOqth0gkROvmFkOuG6TEuAPVwGNAtq3uYIiHKoSRVy0WczMgH6g96Tw0
         W8jA==
X-Gm-Message-State: AOAM530LRSvA+9Qbh44tcViQ2JbWqY64qSIEpJW7pmTrJCLJIrXfy6XS
        CDzsuKuBkB4/iH5d1LdtuKLVcw==
X-Google-Smtp-Source: ABdhPJwgt9/FNVb762Lx0ORcxyFLt25nlg3jWJEd+VXqNkkS117ss5mN792yc3AK8kPbqoIbIdOg7g==
X-Received: by 2002:a63:78ca:: with SMTP id t193mr11854899pgc.391.1609173712855;
        Mon, 28 Dec 2020 08:41:52 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.41.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:41:52 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Subject: [PATCH v6 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in charge moving
Date:   Tue, 29 Dec 2020 00:41:04 +0800
Message-Id: <20201228164110.2838-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201228164110.2838-1-songmuchun@bytedance.com>
References: <20201228164110.2838-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The unit of NR_ANON_THPS is HPAGE_PMD_NR already. So it should inc/dec
by one rather than nr_pages.

Fixes: 468c398233da ("mm: memcontrol: switch to native NR_ANON_THPS counter")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b80328f52fb4..8818bf64d6fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5653,10 +5653,8 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__mod_lruvec_state(from_vec, NR_ANON_THPS,
-						   -nr_pages);
-				__mod_lruvec_state(to_vec, NR_ANON_THPS,
-						   nr_pages);
+				__dec_lruvec_state(from_vec, NR_ANON_THPS);
+				__inc_lruvec_state(to_vec, NR_ANON_THPS);
 			}
 
 		}
-- 
2.11.0

