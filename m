Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13F1438F4A
	for <lists+cgroups@lfdr.de>; Mon, 25 Oct 2021 08:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhJYGWH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 25 Oct 2021 02:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJYGWG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 25 Oct 2021 02:22:06 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC48C061764
        for <cgroups@vger.kernel.org>; Sun, 24 Oct 2021 23:19:45 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id p10-20020a056a000b4a00b0044cf01eccdbso5872486pfo.19
        for <cgroups@vger.kernel.org>; Sun, 24 Oct 2021 23:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZWcH7rWC3ZsHErnrMwwxWzyNMoxVakai+vPjAaFHzVQ=;
        b=hOMf4il33vbkfJyrzLVbrglaaETehyTreBSt+7K7c6eZFmlWBxyFhb8QmG53tAMHjo
         9A8hK5RqzXNl6UGb+aHrz3o1OoeY2Qi/m87JHrptd2Cscjtjhi5OKqHdS3euGZ+DDudF
         vDpFkGp7HmYoSHhDu/i8JDYjJ/9Lj7E5M5UyH79Xjg+64TS9RKsRfayisnySku0cQpbz
         UtDKoXNGhPG1DtxPSW40RGRHQEKG2ZqIpmm1+0BsfREZ2y4LufrJHNbKls/e8a1bWs3t
         JqdKSFi/RIalkhdeKVCE8qoaIHmviBIT1IK5Avzg832qRyK/hHnWPb2D5A/j1A1wC+am
         eBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZWcH7rWC3ZsHErnrMwwxWzyNMoxVakai+vPjAaFHzVQ=;
        b=GbR+TOaXb6/+aw/hqSqn65ZoJGs+rgYO+K8JydT6OxOes5mHQLfPnw+Bdjq40Y1Imd
         9PY58d6KVQse8cvaL+T57m7BKovFUb12SiwXGXhg/3mwmvuP/31AtTZTX92HtOrrEg64
         iVBY2a4PUYhALAJxncztsin7Dhh0zxTSEUMj2p0WqmIxjanwBQokATh+/Meu0h8yy+hp
         /ZiNfGd418m+RoeMBfO9D0E81NapgxejDW4cebqwUJxG/RDf2U64f3yvGPmfueSb7qao
         FRetzHzxRzNt6DDSvPGJoIrbS2TwhlFZzB65uxJit1/tQuJdCGMuNDIymMI9T2eT7xsx
         oCMw==
X-Gm-Message-State: AOAM532d+ZlQ8vnbOHHaOay3cPisKX/G1S9/3Gw3k0QWbMsk+55dqRIm
        kRrK4cJoXdh8EQIAJ9Oo8fzyp4kg5fnSiA==
X-Google-Smtp-Source: ABdhPJx9F7pAWgZ6WYTAsccOwUOsCSZiJ6kXBdE/NiUDfqEGLGo/WzXciBcY4CWxMDQ4aOh3tIen2NBAb17VnA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:faf1:73d1:a656:9f7e])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:62ca:: with SMTP id
 k10mr18394369pjs.38.1635142784779; Sun, 24 Oct 2021 23:19:44 -0700 (PDT)
Date:   Sun, 24 Oct 2021 23:19:15 -0700
In-Reply-To: <20211025061916.3853623-1-shakeelb@google.com>
Message-Id: <20211025061916.3853623-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20211025061916.3853623-1-shakeelb@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 2/3] cgroup: remove cgroup_mutex from cgroupstats_build
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The function cgroupstats_build extracts cgroup from the kernfs_node's
priv pointer which is a RCU pointer. So, there is no need to grab
cgroup_mutex. Just get the reference on the cgroup before using and
remove the cgroup_mutex altogether.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 kernel/cgroup/cgroup-v1.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index f6cc5f8484dc..fd14a60379c1 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -698,8 +698,6 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	    kernfs_type(kn) != KERNFS_DIR)
 		return -EINVAL;
 
-	mutex_lock(&cgroup_mutex);
-
 	/*
 	 * We aren't being called from kernfs and there's no guarantee on
 	 * @kn->priv's validity.  For this and css_tryget_online_from_dir(),
@@ -707,9 +705,8 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	 */
 	rcu_read_lock();
 	cgrp = rcu_dereference(*(void __rcu __force **)&kn->priv);
-	if (!cgrp || cgroup_is_dead(cgrp)) {
+	if (!cgrp || !cgroup_tryget(cgrp)) {
 		rcu_read_unlock();
-		mutex_unlock(&cgroup_mutex);
 		return -ENOENT;
 	}
 	rcu_read_unlock();
@@ -737,7 +734,7 @@ int cgroupstats_build(struct cgroupstats *stats, struct dentry *dentry)
 	}
 	css_task_iter_end(&it);
 
-	mutex_unlock(&cgroup_mutex);
+	cgroup_put(cgrp);
 	return 0;
 }
 
-- 
2.33.0.1079.g6e70778dc9-goog

