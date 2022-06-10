Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1942A546D73
	for <lists+cgroups@lfdr.de>; Fri, 10 Jun 2022 21:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350216AbiFJTo4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 Jun 2022 15:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiFJTor (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 Jun 2022 15:44:47 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB9A3631E
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:44:45 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id cd16-20020a056a00421000b00520785db095so113293pfb.15
        for <cgroups@vger.kernel.org>; Fri, 10 Jun 2022 12:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BoKrpJKf0NJs+gRVFUxqhFbhSmPUCp4fm3z5hnvOZp8=;
        b=AwMbVnbr5q4cAXvZEcfd1LqfchA948H9iCk6EgWRZCrU9JhEVm5ktf2o6ZcthFHxtp
         fJR2NLnd0CP1ZVB3DUwvjogVI2lGFx+c1jhyCuYfDxaBpbmiyoNPt/4toEyzPoI8aG2L
         l7EJEOOgOdJokfnVs39pZpvlN/bMYVF8zi3c8INe95INBFA4jl4lIxoLgkCtuPsoV8/a
         1XXWK4i4F34ceL4ZDMye01r9T5dL4OyM1vSa6CjC9wbd/gsB2aegqtszm1WaBXpeIDBW
         OkwEXnjpF+TFyYLJeSn6Le2Zl5Qm8eGCj8UZgJcfVmdvtpSuHd21o5lvW7PAjhTT2Zlu
         rkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BoKrpJKf0NJs+gRVFUxqhFbhSmPUCp4fm3z5hnvOZp8=;
        b=PMOb3d1MXNppifEXrXMGDQ06zIvU5BRTV1KXidTejxCYr+E/Q+tZMhlZd8z7VId4B7
         GbmTfPMS3Fo6MEWSRGnUVX3nz4NvpMIKuLVFN950Pv0g0dYFd43PXVZ/0HfhbUkm0tRZ
         AgFGUqiJKxbOa5HmJqkDndzA2Z1Ga7Lg8yGVnR80xBGF5zSG89QfwLTODoareeXbi7YS
         YsLsHaieJOVRmYAPykxgHfzuybLthGOdsaig/8qdY+55usyipKM9MGl14HcFTQEE1lFL
         KvtX5+4sAvk9JJANpagc1p/kIF0uNKo04trU4KfCPEzkewyuPQ/jrJV7sdPGIP2nd0XM
         I2Ug==
X-Gm-Message-State: AOAM5308ifi/sdDVNj0dV2GU3/mKRLUzqFL057/N1AsvzIe6g8rc0fDC
        EPoHyiCjt2rj4zQ9pnsGYM7VfZpyj2JJON7i
X-Google-Smtp-Source: ABdhPJwQ9/O3cLtL091G/r5wtBr7xRRylG/pClmo9oRqteMdlU54kund+SWaTzWoyJFSyaMFBAR9HfurzCkT4g19
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:902:e0c2:b0:167:6128:e63d with SMTP
 id e2-20020a170902e0c200b001676128e63dmr35223277pla.16.1654890284796; Fri, 10
 Jun 2022 12:44:44 -0700 (PDT)
Date:   Fri, 10 Jun 2022 19:44:29 +0000
In-Reply-To: <20220610194435.2268290-1-yosryahmed@google.com>
Message-Id: <20220610194435.2268290-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220610194435.2268290-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH bpf-next v2 2/8] cgroup: Add cgroup_put() in !CONFIG_CGROUPS case
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
        Shuah Khan <shuah@kernel.org>, Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Stanislav Fomichev <sdf@google.com>,
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
index 0d1ada8968d75..7485a2f939119 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -757,6 +757,9 @@ static inline struct cgroup *cgroup_get_from_id(u64 id)
 {
 	return NULL;
 }
+
+static inline void cgroup_put(struct cgroup *cgrp)
+{}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
-- 
2.36.1.476.g0c4daa206d-goog

