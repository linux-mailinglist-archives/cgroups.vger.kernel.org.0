Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234256AC5BA
	for <lists+cgroups@lfdr.de>; Mon,  6 Mar 2023 16:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCFPnE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Mar 2023 10:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjCFPm5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Mar 2023 10:42:57 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1140B746;
        Mon,  6 Mar 2023 07:42:22 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id d7so10918386qtr.12;
        Mon, 06 Mar 2023 07:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678117337;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pu8gC0LE8S+gTMZ95T5G8zWPtdy0mtS5OOYges0wR78=;
        b=SktXouP2u6iR+PuI3ihPB0oXgFl+wFxiiVq1JIZ3tE+tE4sOmr1Lbs5jbm66PznnlR
         kovLcAf/bc063xYce2U2FcEy7NfMkuYO8JoFH7K31GVBQBb6xAM2vzsJSlhVeunCYvRD
         8EdtfAd7SDVWsB9Tp4JRbo732vcFHfMtgysX4rMVavgWY5Mox+K5fKlvGPputGgXIgaG
         DM57pLuWYHI3SwiTgJOzdvKFOO3gi8g3VBC8aMOstDyDvaevAbq4cFxgSKqswnbda0b0
         nuxqThgomDx5Q1b2CAAy4IcQSGnfRE/6ejxbCiihoVF8U3zSeZ8nwbRo1HagXKSqXp0x
         kHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678117337;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pu8gC0LE8S+gTMZ95T5G8zWPtdy0mtS5OOYges0wR78=;
        b=C4QIhAgO7JDxm38iA69h+NM+Qm9uZjww0iNPmiVLLvfwUQdo9tFymeJXuqcPZVSkby
         i5dLLqEbRxM9zD7MfiXKIdS2lS8M9S0FynbeZ3rioml5kRj138UyCbLTuiFJLOFMQK1v
         VuLwe2IODvZ95XG6oYZZW4Kq5XbOmzoQ8JdSOdMRpR5H7Mivh6XmCWGnM/PgwwBgCGQg
         iCVqdPNmuAwn9j1pgFLrKOJvOk9bP+07gLjfUmhBpyct42Z/yvak4PwqdHgmZkvSj3uY
         elUM7UZf4JPK2U8RAK5iBdtDbWelL7/ASEkFeAESSI0QKCPBhUvUoOzljEQkUiQG4MOU
         lteQ==
X-Gm-Message-State: AO0yUKUvoKQNN993RaBylzHPCPw0pDFwU4sAxHtl49V1r5nUvpV/kNIw
        E2hvgSqYGEHVW6L88cOIhPU=
X-Google-Smtp-Source: AK7set+e4N84A/a0YvzVrdLmBBm2Bq6WtbGrELmEP1Eenmwcb6A7JCAiUo7ENQ31cT0sg9wOrRPUFw==
X-Received: by 2002:a05:622a:303:b0:3bf:c407:10c6 with SMTP id q3-20020a05622a030300b003bfc40710c6mr16011007qtw.13.1678117337430;
        Mon, 06 Mar 2023 07:42:17 -0800 (PST)
Received: from MSI-FindNS.localdomain ([107.191.40.138])
        by smtp.gmail.com with ESMTPSA id u19-20020a05620a121300b007424376ca4bsm7618400qkj.18.2023.03.06.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 07:42:17 -0800 (PST)
From:   Yue Zhao <findns94@gmail.com>
To:     akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, hannes@cmpxchg.org, mhocko@kernel.org,
        shakeelb@google.com, muchun.song@linux.dev, willy@infradead.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyeechou@gmail.com,
        Yue Zhao <findns94@gmail.com>
Subject: [PATCH v2, 3/4] mm, memcg: Prevent memory.oom_control load/store tearing
Date:   Mon,  6 Mar 2023 23:41:37 +0800
Message-Id: <20230306154138.3775-4-findns94@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230306154138.3775-1-findns94@gmail.com>
References: <20230306154138.3775-1-findns94@gmail.com>
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
But it is better to use READ_ONCE/WRITE_ONCE to prevent compiler from
doing anything funky.

The access of memcg->oom_kill_disable is lockless,
so it can be concurrently set at the same time as we are
trying to read it.

Signed-off-by: Yue Zhao <findns94@gmail.com>
---
 mm/memcontrol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dca895c66a9b..26605b2f51b1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
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
 
-- 
2.17.1

