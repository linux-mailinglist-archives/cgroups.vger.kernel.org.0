Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDF57D84F
	for <lists+cgroups@lfdr.de>; Fri, 22 Jul 2022 04:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiGVCNX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 22:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiGVCNV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 22:13:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6B9749A
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 19:13:20 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 92-20020a17090a09e500b001d917022847so1633920pjo.1
        for <cgroups@vger.kernel.org>; Thu, 21 Jul 2022 19:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=DhjjSNuficgbRYAqqQ0W8XZGDABdrTHUp2H4nxtLaug=;
        b=PI4AMB4vSbp0OIWCtIi99l5y4UFdCqR/ok0FBs166w/hgCwQvkncSijD7lGvRoGySS
         Ua+FnMCqGvIRXN2qe0qH77bKrmYhFAwB5e6L+hNKsACMXnx+MLuG6goCLrTFH/hCi3Pl
         QHMcf1tqWKZKns+LlKiQ9RodcMfMMI5jeZmU4Sv4uRY3wo8nJnqQubNwUPaJLeqve4w0
         18WyJP6Wa1gNf02gbU0YwudKDR8P47mc6mIu2MjlZoyN6nr/mHEZFIYgVUiXCTFQY+5Q
         PSF8Ximzmamk1QeoF2Wacsv93SLBXFR/+gXPNly8OgWAOCz3BLuAMNV6K0Rvv1ycTXz8
         fIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=DhjjSNuficgbRYAqqQ0W8XZGDABdrTHUp2H4nxtLaug=;
        b=6t2wTJxbQmqIa3+7YEOhTSJd6WlrwSpA9AtFvyPlLSFNHBbD21NmV6aFFtJ52TWLFi
         CtLQSiV85uVbxJVMqF9vB8kX4o1TzfsW42CXivN0y23lkfpqOGDSzMg5Z+iM7zEgUNSH
         vMcERRHmHBliNpATD1e+p7AaxTXPSkp1BqNfr931f9AXgw6CjmYUBVw6RYo5A96eHk3y
         RllltHljmc7Ucn7oOcVs6KfJiS6W0PE4W/nDpHKwXXZQVpwC2QfC8rk4RY8OaNbK9hJ0
         cKd7km8YZMKwkUgZt4btxwuv/gES5P9u3UZSEv2W2/fLhdk7xrfI1t8vRLZK6Chocso0
         kUZg==
X-Gm-Message-State: AJIora96Qj3YGVcKqhhnd+xiSpvBKVtq5Dh+LflbEnaBQBMdZFnF7qAY
        7S+kwh78IOxcXjN8L8cKiDwVTIfW8M35j4WZ
X-Google-Smtp-Source: AGRyM1sxVbhJAl0O1lOjA9XaioVuQButGgTNpgtk+la7oca/XTSvlK2lHRWIXeRdai+FgRh0VzQIg3+/kc0LFxFH
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:10e:b0:1f1:f3b0:9304 with SMTP
 id p14-20020a17090b010e00b001f1f3b09304mr837705pjz.1.1658455999390; Thu, 21
 Jul 2022 19:13:19 -0700 (PDT)
Date:   Fri, 22 Jul 2022 02:13:07 +0000
In-Reply-To: <20220722021313.3150035-1-yosryahmed@google.com>
Message-Id: <20220722021313.3150035-3-yosryahmed@google.com>
Mime-Version: 1.0
References: <20220722021313.3150035-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH bpf-next v4 2/8] cgroup: enable cgroup_get_from_file() on cgroup1
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_get_from_file() currently fails with -EBADF if called on cgroup
v1. However, the current implementation works on cgroup v1 as well, so
the restriction is unnecessary.

This enabled cgroup_get_from_fd() to work on cgroup v1, which would be
the only thing stopping bpf cgroup_iter from supporting cgroup v1.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1779ccddb734..9943fcb1e574 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6090,11 +6090,6 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 
-- 
2.37.1.359.gd136c6c3e2-goog

