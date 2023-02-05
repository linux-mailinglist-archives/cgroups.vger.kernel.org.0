Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0756A68AE9B
	for <lists+cgroups@lfdr.de>; Sun,  5 Feb 2023 07:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBEG65 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 5 Feb 2023 01:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBEG64 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 5 Feb 2023 01:58:56 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0A922DE1;
        Sat,  4 Feb 2023 22:58:41 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id bd15so6375738pfb.8;
        Sat, 04 Feb 2023 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJFamjlYxQHTtnnrxr9/CB6pQuqIvvtPFL7L8VSX2/I=;
        b=gVVFqTvJAZvfk8KKjegWy9aL927a4bXCh4S7/MsZ+dJ0CQpxeUSN6EnF7tyCklTTVQ
         OVsq1QzMjsCmcd4BOylXTpoB3f2DZmVqjGVsbDRHa5Lie0k/KIbmAGfFc/MYK1Jdcvp8
         kXbE1kfU4oELctIwFWc7kLsfhakbRJ8kr6itCLvgz2YzqPxDbiE1XUY/QiK1L4g+zGnf
         eI6yV7bDEnOzZWom77cfc2Ly8cBIzfy+2ALeyzmgSBVV37qlT46yiT8rx5iPwXyumGu9
         Ts4yaKM1P5BfT/IhvtQg1f+x7ANzPnIYfqWkXtcAVNgbvrPeUMWaS7CyzW7PnviXTyq1
         BwOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJFamjlYxQHTtnnrxr9/CB6pQuqIvvtPFL7L8VSX2/I=;
        b=arnYN10n0NgVjesYAB7wjDCP6SU5B2xSvEibTSlvn63ueNLUsWCag44w2td/ck+Ce7
         WPECM3lA8EGQiA5YzJT7NilOg7XROrGUW+mWAL0f8dg9SP4B/0RmOPj0Lm3Pc4fKd5mH
         YPvapUSxQEI0OtvhsxtW3tLQt6EokRyIwJIWsZ3WDcejrQR7QRiZQCULaJXxjR9rFR7R
         lH2VBjUETAGb8lYfPEtaFXjwpX7e9xtRMYpEbKMASRGSAMPyzQ070ItJy240nOOwDpHE
         wVZDImynU1DHndxDdjuFNKwzFq2G+EsZI+beOcKWobLQuPpZetAGJK1Fhzh5HaKwRB5b
         6qUg==
X-Gm-Message-State: AO0yUKUlVyUSZv/WafWR7QWc6aebqrb8evysPi/yP7ZurF2N+Z0t1310
        SVpFfYXhZlNpM814Nk3pVaU=
X-Google-Smtp-Source: AK7set+glF6tWjUrkVQNHbTTC350mIZnSUIpc9KCsFFirDloxXVTbOwqRd1Jx1RWYbBp3T31d8U1EA==
X-Received: by 2002:a05:6a00:1626:b0:586:b33c:be2 with SMTP id e6-20020a056a00162600b00586b33c0be2mr13886223pfc.26.1675580320593;
        Sat, 04 Feb 2023 22:58:40 -0800 (PST)
Received: from vultr.guest ([2401:c080:1c02:6a5:5400:4ff:fe4b:6fe6])
        by smtp.gmail.com with ESMTPSA id 144-20020a621596000000b00593ce7ebbaasm4596114pfv.184.2023.02.04.22.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 22:58:40 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 4/5] bpf: allow to disable bpf map memory accounting
Date:   Sun,  5 Feb 2023 06:58:04 +0000
Message-Id: <20230205065805.19598-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230205065805.19598-1-laoar.shao@gmail.com>
References: <20230205065805.19598-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We can simply set root memcg as the map's memcg to disable bpf memory
accounting. bpf_map_area_alloc is a little special as it gets the memcg
from current rather than from the map, so we need to disable GFP_ACCOUNT
specifically for it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/memalloc.c | 3 ++-
 kernel/bpf/syscall.c  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index ebcc3dd..6da9051 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -395,7 +395,8 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 		unit_size = size;
 
 #ifdef CONFIG_MEMCG_KMEM
-		objcg = get_obj_cgroup_from_current();
+		if (memcg_bpf_enabled())
+			objcg = get_obj_cgroup_from_current();
 #endif
 		for_each_possible_cpu(cpu) {
 			c = per_cpu_ptr(pc, cpu);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9d94a35..cda8d00 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -309,7 +309,7 @@ static void *__bpf_map_area_alloc(u64 size, int numa_node, bool mmapable)
 	 * __GFP_RETRY_MAYFAIL to avoid such situations.
 	 */
 
-	const gfp_t gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT;
+	gfp_t gfp = bpf_memcg_flags(__GFP_NOWARN | __GFP_ZERO);
 	unsigned int flags = 0;
 	unsigned long align = 1;
 	void *area;
@@ -418,7 +418,8 @@ static void bpf_map_save_memcg(struct bpf_map *map)
 	 * So we have to check map->objcg for being NULL each time it's
 	 * being used.
 	 */
-	map->objcg = get_obj_cgroup_from_current();
+	if (memcg_bpf_enabled())
+		map->objcg = get_obj_cgroup_from_current();
 }
 
 static void bpf_map_release_memcg(struct bpf_map *map)
-- 
1.8.3.1

