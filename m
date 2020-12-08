Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DDA2D2203
	for <lists+cgroups@lfdr.de>; Tue,  8 Dec 2020 05:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgLHEWT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 7 Dec 2020 23:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgLHEWS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 7 Dec 2020 23:22:18 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71464C0617A6
        for <cgroups@vger.kernel.org>; Mon,  7 Dec 2020 20:20:59 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c12so5553326pfo.10
        for <cgroups@vger.kernel.org>; Mon, 07 Dec 2020 20:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WYYxHKy2hNUOwy6YEzcM7TOwb+Qq885tP2jcyrxWyck=;
        b=gEpUnsZWYOjoACAUsQZDmde/SEQQIOvKt+ueoQYzxcPNg33SDVHk9FF1gWVVaN6rs4
         /aPL5PPxMnaE+DPh8DMDUoxFDpMJXOYSZs/IupuC1Q/TVUZZ1023ynmZ+enC3EPTOC3n
         hj8AGMbUX4SDYfWwFpT6VNLLopbu/Zp7aV83yNWA7hJAPq/+5Jqk9mYqHCVyp0bmK/o6
         ZfaRvPqDmHVJAhILi2YKpfJizlkIQL3Y04ky1LvHktsPKsw4k92k6hh6Bxam5CkIg4c+
         LHpPGdsTcqgRmcHOKKSym3csLwmcz5qUUiSxWAB9f8fTbZmkoNgnQshKdURnH/7YkbGs
         mUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WYYxHKy2hNUOwy6YEzcM7TOwb+Qq885tP2jcyrxWyck=;
        b=PIp5JlKmHssxLktxB9Tg6Ud5ILelLzuNt1OP7TEniVaHIsAMoa5Ep0DWwfTxwUqPna
         7nmPQb2t9zMMpb2DbS4xwvz6/0XcIumAK74OtIWasZvSmgnmQQ616avjjpCVClsnF2fT
         NshAVatlkJktdQmmCq6NH/FKPiL22qpt8sKu1qI2hhkYjq6bag2p+zvdlzBDzV2g5knk
         MSH1aSnV1hWGIhYi4JxF/y78FbNWzNgsHfUOEh6IudR8hg1is3cOltSDaX8Ybx7I6oLS
         7BoAX6vTwBaD0bLpVCwAW9ojA33tcTk+7Hg9sT9KI8rEof2oMVrA9/n6q3zErZq0R1tH
         08tA==
X-Gm-Message-State: AOAM5338NIEXFTBEXF5HHNWIhQ17nHNcewfwCSkYFQS4+hkfx+TfHg1i
        SF2HNkPsBSeloYlWDLlcToBUHw==
X-Google-Smtp-Source: ABdhPJx4XV3psoCYFQP0G4bYZi/2ONeVaNl9iWtUxxUXrX/TPLVKdBUrKH5so2rbiHM24rrZ0hcmDw==
X-Received: by 2002:a17:90b:1213:: with SMTP id gl19mr2312127pjb.232.1607401259049;
        Mon, 07 Dec 2020 20:20:59 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id mr7sm1031166pjb.31.2020.12.07.20.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Dec 2020 20:20:58 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 1/7] mm: memcontrol: fix NR_ANON_THPS account
Date:   Tue,  8 Dec 2020 12:18:41 +0800
Message-Id: <20201208041847.72122-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201208041847.72122-1-songmuchun@bytedance.com>
References: <20201208041847.72122-1-songmuchun@bytedance.com>
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

