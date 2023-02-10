Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196769229D
	for <lists+cgroups@lfdr.de>; Fri, 10 Feb 2023 16:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjBJPsC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Feb 2023 10:48:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjBJPsB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Feb 2023 10:48:01 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FCA73592;
        Fri, 10 Feb 2023 07:48:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id a23so3953900pga.13;
        Fri, 10 Feb 2023 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSCoSnxCH+oujuHlV2ueRvXQv9wOk6fb9r3EfXFy+Xw=;
        b=Jn96c5OSkEZ79jtvvUAgxCfdeK/vT5MXjAismyeWwqGOzgWUC7tOQxF5/wxGDKBd1+
         NQDqmadFBtS46XsKBvPQanuRJ4CwVD32afSccI431oQcKgoPI4yakO5ePhv3luG5q4Kq
         G1OmhSBaxjhnTpnCLISjIYzOyY4hc8swEO+5XOnMEsBhV8Ya3KN0EuX4XEAqdxIK1Qux
         u/rEUAhudYR05Nnyx77XVHNXBp+2OJQuOwOWJb7EYssyfW/YRSbb/a/Nj8C/Epr16s8S
         l5ToX2SA9BGj3aEmQ8g2629uZDbs5iDhJl7GvAh40gqex9vmEEaTyV1bl6WUkifgR+Ui
         sbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSCoSnxCH+oujuHlV2ueRvXQv9wOk6fb9r3EfXFy+Xw=;
        b=irrU8/830R0eeZgBKLH8IVal794TYOPFLDMTu1CEtADe1eKq9lyuQcWF8lzAQ1V/Tu
         Qjx5Wo674bgjm8AbLxa/p5OgzdjBbPq4PwmgnVkvSskMGUo4omDzn3OmylmwmeMKvCcO
         B812iRpLG2hoYOqs8J3QPbblVAWnqfO3ovaaC89nLCUU998HzZKidYJUROn299XS/nxP
         hB3HMhUApZfrt3/pG/ThD9gS9HRtfBaBQwQxgEyZOklQrMaw9rBvGHL1tjOY/DVCo8YX
         dKuuzUrGP/1/sj9qIvIyo1Hohqmln+c4Bjzeq+vSWDbIWY02bbpplbrKRXgDkgAgP8HD
         Ma/Q==
X-Gm-Message-State: AO0yUKUhEJAPYOBZ5bjyo9y0D/6ZSbr5RfC+V88o2mdRPmA2zZAcucn4
        1Ju8XsH93+HjreCuaxwW9Jis974KV/QQ+mb1vCk=
X-Google-Smtp-Source: AK7set+0d0W5Q0AkiHpDwGMIBAsDbfXJdRCxZFFceps6/hPlTFfDvxf+o5NgKqtSmcIekhrFGRYC2A==
X-Received: by 2002:a62:8490:0:b0:5a8:4b27:5db1 with SMTP id k138-20020a628490000000b005a84b275db1mr8495229pfd.3.1676044080310;
        Fri, 10 Feb 2023 07:48:00 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:2f6a:5400:4ff:fe4c:e050])
        by smtp.gmail.com with ESMTPSA id t20-20020aa79394000000b005921c46cbadsm3520069pfe.99.2023.02.10.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:47:59 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     tj@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, akpm@linux-foundation.org
Cc:     bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 3/4] bpf: allow to disable bpf map memory accounting
Date:   Fri, 10 Feb 2023 15:47:33 +0000
Message-Id: <20230210154734.4416-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230210154734.4416-1-laoar.shao@gmail.com>
References: <20230210154734.4416-1-laoar.shao@gmail.com>
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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/bpf.h   | 8 ++++++++
 kernel/bpf/memalloc.c | 3 ++-
 kernel/bpf/syscall.c  | 5 +++--
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fe0bf48..4385418 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -28,6 +28,7 @@
 #include <linux/btf.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/static_call.h>
+#include <linux/memcontrol.h>
 
 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2933,4 +2934,11 @@ static inline bool type_is_alloc(u32 type)
 	return type & MEM_ALLOC;
 }
 
+static inline gfp_t bpf_memcg_flags(gfp_t flags)
+{
+	if (memcg_bpf_enabled())
+		return flags | __GFP_ACCOUNT;
+	return flags;
+}
+
 #endif /* _LINUX_BPF_H */
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

