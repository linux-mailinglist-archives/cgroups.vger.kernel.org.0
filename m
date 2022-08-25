Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9945A1701
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiHYQoX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241730AbiHYQnm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:43:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3187BC11D
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:51 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id x26so3071929pfo.8
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=KFhoipy95bP113xci+lGCwwditMpaEg770tCZfK2FCQ=;
        b=rnj3VBn/MhfZHnIBhXiPV3dAIiOKhTdG3N9c6tQZbbmST0ZwO/XwgL1cpBP0HCijxa
         z4TaTH9FWOVs97NqlVz7IVrxwH3vpxw5wTzUUxlt1FRc1a2wE5Nm9IsZDzqqUxs1En42
         mM5zHiB6x2roWKOP0Z6lROQMejSsqZxUzgEWt5LvTryYKRMi2nh8Q5g/k+HilzMVcD3Q
         iJ18Ki2jbPVPv1wta/DxdZx+dR4yM+WxjEM5JWnwC90G5YPBii5lykHk6lLfdWu3z79J
         QwjMMA9Xc7CmeHHpE/bF5hMfKfFKJmCd3t74sAt0L/3Cpbk1Eb6sPm59pnLn0VZ+GJus
         Y4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=KFhoipy95bP113xci+lGCwwditMpaEg770tCZfK2FCQ=;
        b=CpTjf1i7p1eQq65/u+X8KXzCe875APponped+ZkFcpxFk7Rxtgx4GudYQKmk1MjSVX
         YzKGdqRc2tBqnKrLNLCB8wPfIy5ICpvYgz0yjF9mOMSq9qzhyVzStwNY2lwIzMjI42Le
         mrTZFzifGZITl3/BOY3IdfwdzVgmoBpWd5X4HOTdLYQgkt9ZGPJxWhjkJh5PkzFlgYXR
         BOBowr5ch+GriiG7QYmUD09bUUCqPjEgiFWgmrb/cs+4NfLt5ZUqo9t8hvD3fkZmo9nV
         sr5D86QnvStZS4LqUoP+OjGvGzwatgJ9S7i5nvRe8GNn+3q206z1Lt0Snm+pcaR2pGyP
         Pf1g==
X-Gm-Message-State: ACgBeo0uezz4vfXJE6TveFAZYfAXdEUMhRn1YyXbFlDZ6fCvIlsicyae
        GgSEpju2ic5BbdZYT/IQcUSXFg==
X-Google-Smtp-Source: AA6agR4XuZNrg70sDQ9tHgd2IZF0CQDjhmKOIsDO1T71ZQBR0mwZiSOlCcWerAsbM2iTQqRq/mtHuA==
X-Received: by 2002:a63:ff09:0:b0:42a:59ee:1775 with SMTP id k9-20020a63ff09000000b0042a59ee1775mr3899200pgi.85.1661445770749;
        Thu, 25 Aug 2022 09:42:50 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:42:50 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 03/10] sched/psi: save percpu memory when !psi_cgroups_enabled
Date:   Fri, 26 Aug 2022 00:41:04 +0800
Message-Id: <20220825164111.29534-4-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We won't use cgroup psi_group when !psi_cgroups_enabled, so don't
bother to alloc percpu memory and init for it.

Also don't need to migrate task PSI stats between cgroups in
cgroup_move_task().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 kernel/sched/psi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 39463dcc16bb..77d53c03a76f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -201,6 +201,7 @@ void __init psi_init(void)
 {
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
+		static_branch_disable(&psi_cgroups_enabled);
 		return;
 	}
 
@@ -950,7 +951,7 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
 	cgroup->psi = kzalloc(sizeof(struct psi_group), GFP_KERNEL);
@@ -968,7 +969,7 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 
 void psi_cgroup_free(struct cgroup *cgroup)
 {
-	if (static_branch_likely(&psi_disabled))
+	if (!static_branch_likely(&psi_cgroups_enabled))
 		return;
 
 	cancel_delayed_work_sync(&cgroup->psi->avgs_work);
@@ -996,7 +997,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	struct rq_flags rf;
 	struct rq *rq;
 
-	if (static_branch_likely(&psi_disabled)) {
+	if (!static_branch_likely(&psi_cgroups_enabled)) {
 		/*
 		 * Lame to do this here, but the scheduler cannot be locked
 		 * from the outside, so we move cgroups from inside sched/.
-- 
2.37.2

