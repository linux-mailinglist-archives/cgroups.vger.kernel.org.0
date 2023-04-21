Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDDC6EB0CD
	for <lists+cgroups@lfdr.de>; Fri, 21 Apr 2023 19:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjDURki (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Apr 2023 13:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjDURk2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Apr 2023 13:40:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF72D12C9A
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 10:40:26 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-24b28355b5eso2211503a91.0
        for <cgroups@vger.kernel.org>; Fri, 21 Apr 2023 10:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098826; x=1684690826;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ze/kPlw8gotaEo1sJnB2fYrZx8MA/zlu9x0xYHZ+g7E=;
        b=evkdgDpSyqlLAXON2ZuU2lSGfLM1dQnhdPP+fmyZWeKwGNZTWFCJKPVGhM2bZZGKOC
         f7YfSGCo2Nf3oXwwYJmGjEDgBvFsw6i76b70QgcRaecrvTKD295qL9CqwnO4UztiMSAR
         wca4o1fBiZOb2DZIrqp+VDQfAwIcLci5K41MPeROy0/47HRyQgXuMC8OBwZyCxCgwh/S
         8f4JUGNY1xeou8G6F0i+W3dKhEWQ3Zv+nckYooRRkUzwRcW77nDMDOwXtSb1IOOWcx0Y
         jIqwdtbmW/rhz4VKzZZ8k/jeg5TikDCeSv0Wmg2wr9UElKoOoUpGS9AakxlgHuAC0y31
         KsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098826; x=1684690826;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ze/kPlw8gotaEo1sJnB2fYrZx8MA/zlu9x0xYHZ+g7E=;
        b=dD3ZwkbzfYTafKxxd56mj3U6p1EMZ6WZbUQR1nrdwKSgLK5TPQYIyfH3/XzHerBz75
         6/fM0yuMf7uS9CXDwknv7z/fv8ks5GfDGMQve3+S+t2mrvbCxeUrGPnmvNh+eKRA3cW1
         jarT/pfxOq4ZaYk0Yaw+hFMb7+3DUdKHoeOxd9zkekpsAMp6TnoKDQDXpzH4omrYRI/A
         vtdMv5pkl8nINYtnZco0oUw6MkL6AnisrnfM+1DwfmDLS/RkATttV25jmgQpmxdQYJXM
         uVpL38yJcVj1iCztix1VpFUelVvTkHJMfuF4yJ5EsoMlGPTr1CY7LTGRj+1U+bp7DM87
         EhHA==
X-Gm-Message-State: AAQBX9eIS34V5KV64S2uLA1MOXnE2v8yJzzMikjpTUCmBI5EgoqQUW/4
        c2V4P71lt2NDr00IHkKG+bAdGBsF16e3N4oA
X-Google-Smtp-Source: AKy350aoZj3p9w7xLo2ekZAFCbJRpr+XbYHOfgfJjD/OnpfpL06mwTgu6bL4JQHk39cy27rMag7V9/fdDGHimXJS
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:3fcd:b0:24b:27db:3cfc with SMTP
 id u13-20020a17090a3fcd00b0024b27db3cfcmr1409596pjm.8.1682098826505; Fri, 21
 Apr 2023 10:40:26 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:17 +0000
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-3-yosryahmed@google.com>
Subject: [PATCH v5 2/5] memcg: flush stats non-atomically in mem_cgroup_wb_stats()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The previous patch moved the wb_over_bg_thresh()->mem_cgroup_wb_stats()
code path in wb_writeback() outside the lock section. We no longer need
to flush the stats atomically. Flush the stats non-atomically.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4b27e245a055..5e79fdf8442b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4648,11 +4648,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, u=
nsigned long *pfilepages,
 	struct mem_cgroup *memcg =3D mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
=20
-	/*
-	 * wb_writeback() takes a spinlock and calls
-	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
-	 */
-	mem_cgroup_flush_stats_atomic();
+	mem_cgroup_flush_stats();
=20
 	*pdirty =3D memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback =3D memcg_page_state(memcg, NR_WRITEBACK);
--=20
2.40.0.634.g4ca3ef3211-goog

