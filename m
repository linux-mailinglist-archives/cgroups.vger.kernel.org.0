Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA95209F9
	for <lists+cgroups@lfdr.de>; Tue, 10 May 2022 02:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbiEJAWe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 May 2022 20:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbiEJAWb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 May 2022 20:22:31 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2E28ED0E
        for <cgroups@vger.kernel.org>; Mon,  9 May 2022 17:18:32 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id y2-20020a17090a474200b001dead634389so37858pjg.9
        for <cgroups@vger.kernel.org>; Mon, 09 May 2022 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2lpWRE3YG+N9rpa27nVaVWWHXRfllKAdvtsLrNhKAK8=;
        b=E2tVTWuknXlQ+T7MTDseqm2kLasAoY5TbquTKQN6G7HFagvNqmuYGwrGCvXPasSU3N
         X7Hfaz6BkAsSlJCS8floN1LW1Ls3ez8PP3Qk4CDVxNmG8LczACkldG8ojDGR0v0+Q7lZ
         21MumA+UYt52X45SeiI4gFrF5deapKiOdu+hj+4jT0AI8QNFnGPAtcYnE+rE1vLh3I/p
         DgTM+ee4LV0B+gFa0sepONWuiGDP56tlAl4OGQqNbhtSDbkgWBB0l4UraO/yy1Apvxzl
         ZeZuNJv+q2z07LlTR07+RdQp7xf+QnHW2FhcVMIRWFBWLCQI9fLvZVExE5a870tRXnw3
         sazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2lpWRE3YG+N9rpa27nVaVWWHXRfllKAdvtsLrNhKAK8=;
        b=MHUNX8gSiCFTTgXhwCtWgrp1T3GC2/mBC0W9RmDX45ONCWYefqGE+vkpqnM2tJViOo
         pYykIVurgpZsdPFwmNjZ3NJ4LSKW3CtHIU8QMZjicExXgmIoastbEsBpa3hUe7ut8C6g
         5kfCEJ/jaS3CE1LUTl1KC829aCcb50Ur4N0hrAXf2qRoPKWVYlnS8H2f6QCwmiWuVD+U
         mQ/O8z/T7CCUlt6uyXwKKzrK6BDgiNextA2XU3MsXoj3vezu7Do8TFaup/YeKnbVWdi1
         SIl3EVMO+tnGTY0ZhsXIxtJA74NeicTfDDmZC2KhvCEfB2tC31OF6O2Xhx7Cjafoq6Sk
         sc/A==
X-Gm-Message-State: AOAM530aZa9uYXUMbsArQnD1WF79k/uT3j/aYyVtZK7Jze3rNntCQ94K
        TLsxXiGiUiWb8lgFVKOIWN2zI4xwBIrGzX9P
X-Google-Smtp-Source: ABdhPJy/UitjFbSu8JI5SJOkgoBGVuKW70iU2528pDg3GbFKneC3JYejg17wXmGVU2MICHcJbmM/y4RyYnBm86oa
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:8ac7:0:b0:3aa:fa62:5a28 with SMTP
 id y190-20020a638ac7000000b003aafa625a28mr15111188pgd.400.1652141912340; Mon,
 09 May 2022 17:18:32 -0700 (PDT)
Date:   Tue, 10 May 2022 00:18:05 +0000
In-Reply-To: <20220510001807.4132027-1-yosryahmed@google.com>
Message-Id: <20220510001807.4132027-8-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220510001807.4132027-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [RFC PATCH bpf-next 7/9] cgroup: Add cgroup_put() in !CONFIG_CGROUPS case
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Stanislav Fomichev <sdf@google.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, cgroups@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Hao Luo <haoluo@google.com>

There is already a cgroup_get_from_id() in the !CONFIG_CGROUPS case,
let's have a matching cgroup_put() in !CONFIG_CGROUPS too.

Signed-off-by: Hao Luo <haoluo@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/cgroup.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 5408c74d5c44..4f1d8febb9fd 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -759,6 +759,9 @@ static inline struct cgroup *cgroup_get_from_id(u64 id)
 {
 	return NULL;
 }
+
+static inline struct cgroup *cgroup_put(void)
+{}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
-- 
2.36.0.512.ge40c2bad7a-goog

