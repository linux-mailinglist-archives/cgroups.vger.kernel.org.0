Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F76B0EA6
	for <lists+cgroups@lfdr.de>; Wed,  8 Mar 2023 17:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCHQ0h (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Mar 2023 11:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCHQ0b (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Mar 2023 11:26:31 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5E8CA1EF;
        Wed,  8 Mar 2023 08:26:24 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c3so18617966qtc.8;
        Wed, 08 Mar 2023 08:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678292783;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kqeFiKRizo4EGYqriaZmF5h1PWpLfju0MvbdsBusLUQ=;
        b=RrUABNuCm23cw7zAS2r7lcfX6PoRi1Q4A6nYTvlFu+h/X4B289H2dUHucrYXkd+iTy
         hsSB64i59WWfc0uy40q5BicLg5T3NqA4EyM2HtbP9aMG90H7ysqkcwwRIBDQM+oKsL2c
         jPzCGI3yBDcGPpWH5BAjJXwdZxPUUwC1rqqb3BWim1UFKIptfQROIZjUOFkUF2Ymg+N5
         n6LeGStUZx/yL69zcRf/KOjYv/sAPzIADkPqKSYyNQGpBeLOeQvpPCva8YqeIATfzeqG
         ztixlNoZ28CemrDp8oaWk6AisdpRAoEDS3zAo3qrU3z2NhNSc3zR/aUp1Y8rFBkKVIEI
         GWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678292783;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kqeFiKRizo4EGYqriaZmF5h1PWpLfju0MvbdsBusLUQ=;
        b=Nz0OVDSBneAze1CZa2CpTmwZmT8ZVbWn0He3GdyDwG2GafhSJOsasdOZ7rs7KH1Thz
         zlJfvmK37MrXMEAwpdAq3rUGaKizZr3ven9l1ajtc441hp5SkB5jDKjHo0CPdds4vKCy
         FRU5YznokMjEpLEFxP/V2ldMCEhSv3VWHlSHgzE8Y+CihpqJHoSrfdDZjbXWIHUI4+XP
         B5dvD5jOln5E6d3qqYxkSgCMUdf2MJ7ucL6G+hukMlQUEQgFV017TpbGpwMup6JPKLpN
         9kDQi8mmNSbBGR+ZTTUM1/qjo3/dusHjg+Qa+Rf1uBaBg+HnwfKNqJfzQSTSJRYHLS+s
         7/Rg==
X-Gm-Message-State: AO0yUKWGDaQCEWZQDuL2AxlfgC2kwO0FMojB+AJtF1KQdsszI5IHTG+r
        /a/KH3VucJGwiSsK1/5lEtA=
X-Google-Smtp-Source: AK7set9S3qW7rerankN3AMXxiZeWoehZYZsS5K65VfhGp7RyFY4IEwJ/A1jtYx9iu85RIgpQlXI21Q==
X-Received: by 2002:a05:622a:104c:b0:3b6:3995:2ec2 with SMTP id f12-20020a05622a104c00b003b639952ec2mr34051919qte.19.1678292783733;
        Wed, 08 Mar 2023 08:26:23 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a0e9400b0073b8459d221sm11619813qkm.31.2023.03.08.08.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 08:26:23 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v3, 3/4] mm, memcg: Prevent memory.oom_control load/store tearing
Date:   Thu,  9 Mar 2023 00:25:54 +0800
Message-Id: <20230308162555.14195-4-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230308162555.14195-1-findns94@gmail.com>
References: <20230308162555.14195-1-findns94@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The knob for cgroup v1 memory controller: memory.oom_control
is not protected by any locking so it can be modified while it is used.
This is not an actual problem because races are unlikely.
But it is better to use [READ|WRITE]_ONCE to prevent compiler from
doing anything funky.

The access of memcg->oom_kill_disable is lockless,
so it can be concurrently set at the same time as we are
trying to read it. All occurrences of memcg->oom_kill_disable
are updated with [READ|WRITE]_ONCE.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1b0112afcad3..5b7062d0f5e0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1929,7 +1929,7 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
 	 * Please note that mem_cgroup_out_of_memory might fail to find a
 	 * victim and then we have to bail out from the charge path.
 	 */
-	if (memcg->oom_kill_disable) {
+	if (READ_ONCE(memcg->oom_kill_disable)) {
 		if (current->in_user_fault) {
 			css_get(&memcg->css);
 			current->memcg_in_oom = memcg;
@@ -1999,7 +1999,7 @@ bool mem_cgroup_oom_synchronize(bool handle)
 	if (locked)
 		mem_cgroup_oom_notify(memcg);
 
-	if (locked && !memcg->oom_kill_disable) {
+	if (locked && !READ_ONCE(memcg->oom_kill_disable)) {
 		mem_cgroup_unmark_under_oom(memcg);
 		finish_wait(&memcg_oom_waitq, &owait.wait);
 		mem_cgroup_out_of_memory(memcg, current->memcg_oom_gfp_mask,
@@ -4515,7 +4515,7 @@ static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
 
-	seq_printf(sf, "oom_kill_disable %d\n", memcg->oom_kill_disable);
+	seq_printf(sf, "oom_kill_disable %d\n", READ_ONCE(memcg->oom_kill_disable));
 	seq_printf(sf, "under_oom %d\n", (bool)memcg->under_oom);
 	seq_printf(sf, "oom_kill %lu\n",
 		   atomic_long_read(&memcg->memory_events[MEMCG_OOM_KILL]));
@@ -4531,7 +4531,7 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 	if (mem_cgroup_is_root(memcg) || !((val == 0) || (val == 1)))
 		return -EINVAL;
 
-	memcg->oom_kill_disable = val;
+	WRITE_ONCE(memcg->oom_kill_disable, val);
 	if (!val)
 		memcg_oom_recover(memcg);
 
@@ -5354,7 +5354,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
-		memcg->oom_kill_disable = parent->oom_kill_disable;
+		WRITE_ONCE(memcg->oom_kill_disable, READ_ONCE(parent->oom_kill_disable));
 
 		page_counter_init(&memcg->memory, &parent->memory);
 		page_counter_init(&memcg->swap, &parent->swap);
-- 
2.17.1

