Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB227AB8C1
	for <lists+cgroups@lfdr.de>; Fri, 22 Sep 2023 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbjIVSAO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Sep 2023 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjIVR7i (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Sep 2023 13:59:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198F42D50
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d814a1f7378so458179276.1
        for <cgroups@vger.kernel.org>; Fri, 22 Sep 2023 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405467; x=1696010267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CSLPc6OXSIH75VPEK2Or6+ByoA8DGo3BCTW1zZyxTA=;
        b=XSDFVFUj0s4Agwlv19dfVnA8fyANS3Lio1Mu22DmB1ClvVA1YT+CSVeqE0EWxIbDkm
         SAOwHueWm2RAHr7SLAyT7mtrmUF/p3ORh/dRzumeM8ShBlB/eZ49uVQkTDrPZvOXa3XG
         U29dF0ipmdT7qgaXW/sTeHjT5QcTJTbW0lQMSCXZoeo/RTkaUTIwfORnOtEzIRVTLqd8
         bXAbpQVdO5Lhp7LQ1XxgAJ4MTH98wJEJ9XVqEtqyOKGB7vCX6eCUAODfsLHNMKALhOHf
         9vlWXS0Zt6co266BHa3btRr3isBFVGn1eqvxEeXTsc7qG3q58Ws3hXBi5lb3+lId+t+K
         Pq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405467; x=1696010267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3CSLPc6OXSIH75VPEK2Or6+ByoA8DGo3BCTW1zZyxTA=;
        b=LpKqQTpEBlwHlYNrw98DlgqvRwStYZ0efms/rbxteqHml8PybDl+6sxOk4sAiDBdV3
         BzWt3Fpizhp/nFJvBuJcKG/mNq8Kq15wGJvYT2SLtywt2ZsKqSkk/y8ZAUmZo9otVqF9
         wDcQ5QLN1+hnlVjh5kndDXZ7YrWUVEI6bmxZwrOySFv5r9zre47VtUsS/uns3h0LjgW3
         RUtxwnaDQ6cCUgDRxIsCALT+LbTQEJ2Wgr2WAnOPRtrxt7z/NFOQZh7Jbxmidjbnw4nk
         L/Wu8ouI8xcutbhAn80RBZomiojlks/HmGvedNAc2dVxgh4guFvoaZspwmZSURt4rwne
         AI6Q==
X-Gm-Message-State: AOJu0YyEReVTKZt0QiMYdlJR/PxkSNJi0X/Mxgct3qM1tmLWUWKqyxc8
        t0v1fx5KnHs2+0tLVTyCtQxxnNHI9hP9ia5m
X-Google-Smtp-Source: AGHT+IH/GVgcWoyTnI6CjuidQQj2eCHCb/7OcETmpcRHx+mMydVisjSv3mlfwbIqt/FcEH+WIvuFEmX/eSnvqJcR
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:8304:0:b0:d86:5913:55cb with SMTP
 id s4-20020a258304000000b00d86591355cbmr1694ybk.0.1695405467283; Fri, 22 Sep
 2023 10:57:47 -0700 (PDT)
Date:   Fri, 22 Sep 2023 17:57:40 +0000
In-Reply-To: <20230922175741.635002-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922175741.635002-3-yosryahmed@google.com>
Subject: [PATCH v2 2/2] mm: memcg: normalize the value passed into memcg_rstat_updated()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

memcg_rstat_updated() uses the value of the state update to keep track
of the magnitude of pending updates, so that we only do a stats flush
when it's worth the work. Most values passed into memcg_rstat_updated()
are in pages, however, a few of them are actually in bytes or KBs.

To put this into perspective, a 512 byte slab allocation today would
look the same as allocating 512 pages. This may result in premature
flushes, which means unnecessary work and latency.

Normalize all the state values passed into memcg_rstat_updated() to
pages. Round up non-zero sub-page to 1 page, because
memcg_rstat_updated() ignores 0 page updates.

Fixes: 5b3be698a872 ("memcg: better bounds on the memcg stats updates")
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 308cc7353ef0..d1a322a75172 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -763,6 +763,22 @@ unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
+static int memcg_page_state_unit(int item);
+
+/*
+ * Normalize the value passed into memcg_rstat_updated() to be in pages. Round
+ * up non-zero sub-page updates to 1 page as zero page updates are ignored.
+ */
+static int memcg_state_val_in_pages(int idx, int val)
+{
+	int unit = memcg_page_state_unit(idx);
+
+	if (!val || unit == PAGE_SIZE)
+		return val;
+	else
+		return max(val * unit / PAGE_SIZE, 1UL);
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -775,7 +791,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -826,7 +842,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
 	memcg_stats_unlock();
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

