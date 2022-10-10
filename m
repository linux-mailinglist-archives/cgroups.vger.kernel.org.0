Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E85FA8C9
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 01:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiJJX65 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 19:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJJX6z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 19:58:55 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F217FE75
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:54 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id u5-20020a170902e5c500b0018280f6745dso2288171plf.12
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/Luj9QXdroeEgRRoLBw0457X0Ivb/R1ok7ODQ4YpCY=;
        b=c55GI3V+Me3kNu6VHoni2F4jTF6mn9ch1qJ2gFWmMuGr8r+fuTjoxSEIpckivCsZcD
         +coTipWE6Gwes6jm+uAMQKrcWL1aHLm7ruVhxJqaoYl9ILn808xPkiBz57F8bKRcGGJb
         jHuTnIRkxRkh6uee/HLM3Q6Si1G5ODZR296XB8GbMMawjlhBq8K9mOK3Etl8foffXvmD
         9ZnB1uvi3Yl1cLi9IwZlHO6huADUDMXiVmmADGxl9Gn/WWSDFrHS5qjqe++6Vm7hnccy
         mPuStsnwKPLQDBAobK0TcMi3Uq7Rkk8DyKyVI8XHcUoPM4fZD9FSBqEC6Cin71kFr4Kh
         rCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/Luj9QXdroeEgRRoLBw0457X0Ivb/R1ok7ODQ4YpCY=;
        b=C4OQ3U+fgqEghmR42n3aJo98cke4dsFZbOW0ICWN42EYUTEHmSKdWg0Cuo3TfPqY6x
         IsZcsBi8zeTS7nxnsMS0dpdyDyCXnkujiVOz5tx/SAmZ/385p6NO6KcedgHYvW0VU00Z
         wB5efQP6kSHhBaquGmlHhYX6lZRZ8vWPP5IiP/Wd6I8js/P2yL4KN2oB5jmflZKVmWir
         XKbrZbw3i9mdcQM5kWn5L/jnJj1C+dbeBXfrCk4042D9MdCHRDaXu/ommwJCXk5Sv+tz
         OjgfnuwwTMlbfIKAieQsly0JvyYgH4466ivLEEAGarvxvUGsG5/oSLLX2qnQzvk03y5o
         gb5Q==
X-Gm-Message-State: ACrzQf1pyapHsUKMXnjypUeRmGuJBplax5HUSIRqvxOcGDdY5JNs4QRH
        53J4ednOkYXlZbAFEIHHbcTyjNuOulGxPUgw
X-Google-Smtp-Source: AMsMyM5Jgfq/g8QlC7BWXrU0sXUvopvslaoZIbjp1ewyyc/G7qhpJhRrqHS6JQg7pfk91+RKrZZ2dp6z/K+1PIuY
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:4c92:b0:20b:a13:83c7 with SMTP
 id my18-20020a17090b4c9200b0020b0a1383c7mr27249326pjb.128.1665446333814; Mon,
 10 Oct 2022 16:58:53 -0700 (PDT)
Date:   Mon, 10 Oct 2022 23:58:43 +0000
In-Reply-To: <20221010235845.3379019-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20221010235845.3379019-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221010235845.3379019-2-yosryahmed@google.com>
Subject: [PATCH v1 1/3] Revert "cgroup: enable cgroup_get_from_file() on cgroup1"
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
        "Christian A . Ehrhardt" <lk@c--e.de>
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

This reverts commit f3a2aebdd6fb90e444d595e46de64e822af419da.

Some callers of this function depended on the fact that it only supports
cgroup v2. Revert it now, and introduce a new function in a later patch
that supports both cgroup v1 and v2, for callers that need to support
both.

Reported-by: Christian A. Ehrhardt <lk@c--e.de>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 kernel/cgroup/cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 764bdd5fd8d1..72e97422e9d9 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6218,6 +6218,11 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 		return ERR_CAST(css);
 
 	cgrp = css->cgroup;
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+
 	return cgrp;
 }
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

