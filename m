Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4A92DCB67
	for <lists+cgroups@lfdr.de>; Thu, 17 Dec 2020 04:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgLQDqX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Dec 2020 22:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLQDqX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Dec 2020 22:46:23 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831DFC06138C
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 19:45:43 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e2so7228229plt.12
        for <cgroups@vger.kernel.org>; Wed, 16 Dec 2020 19:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I8JqAljVYtmaPaBvHCRChrR0oheI9SrolUe2et8YFn8=;
        b=LFRZS+7DcgILx1b9ou9M96wmw6taZL3I+iRan+cCcipo6HVZ24/ujb+bZ41PZXuLCZ
         1ReDBz6W6bu3NpG+2xk3pKfOFqrr9g2Qrb+uxz9T03e6UIzD/fN/FfVR0NBGQ5XLo0iW
         92K9qsyjSKNMYvLIcXdcn4DmKQ6yGUXvZ65QwyV7KMh0r+dZcCC79wnl9nGlvvWbYfOn
         RsEhQDpDm1uB7/ugs30Y6r4YkQ5eTOqbqec+OmXWgHo8olU4a4utfAysCogecVHdUejg
         SBw8Ad8KH0AGA1ChhpBwqy5mYnB+rBtL8Da74sdNyCe6Hm4IgtSSQ7doCiueJfa1paez
         mfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I8JqAljVYtmaPaBvHCRChrR0oheI9SrolUe2et8YFn8=;
        b=HZ3fyyWC7d+zo4OepokzoQRbhL1oJOrLw+8syVU7wZUaa1o3iWfC/3bRb0pY0GZrgr
         l6SDTgJbn77wmuqkhpt0WGrSyYh4jl8ZQoMVlgEZ89+QEB7HTYwnoAaNogj57VmWcGO1
         83oK0aU2O/pTi3/Ao9JhB1pMy8ATW7mlLVNjOg6vKE25VW0iMXMe7a4LV2XC5EHfGAaT
         UGrmTAmv1QeHICx/e6iSN+jOacPgpCT7GCRApFWRLXVmLDYyAsvHk5FmU/o47ARM85te
         rPek90hnaivBPNQyA6wMZMWfebRm2rKsvXZRjh748Xo/d0N+U4MhDA26pbG8rTAsaVBq
         Iz5g==
X-Gm-Message-State: AOAM531VRmzu8x3xNoC8bBnAL5IGQ0BViTKKEVxQutDH4WsTl+6wQ5Ey
        TKA8SC5mWKV0/E+JVeImLO6xDQ==
X-Google-Smtp-Source: ABdhPJw4NdNDKtIfv8xy6x6h9OgRGXasL/6YLMvw+2wPMLJxvSJx/uoemPCfa3HQ7YnKhTF68dvRxw==
X-Received: by 2002:a17:90a:bc0a:: with SMTP id w10mr5877433pjr.79.1608176742627;
        Wed, 16 Dec 2020 19:45:42 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id b2sm3792412pfo.164.2020.12.16.19.45.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 19:45:41 -0800 (PST)
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
Subject: [PATCH v5 1/7] mm: memcontrol: fix NR_ANON_THPS accounting in charge moving
Date:   Thu, 17 Dec 2020 11:43:50 +0800
Message-Id: <20201217034356.4708-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201217034356.4708-1-songmuchun@bytedance.com>
References: <20201217034356.4708-1-songmuchun@bytedance.com>
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

