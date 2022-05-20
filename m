Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3169B52F13C
	for <lists+cgroups@lfdr.de>; Fri, 20 May 2022 19:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352002AbiETRCR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 May 2022 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351999AbiETRCQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 May 2022 13:02:16 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928417EC0A;
        Fri, 20 May 2022 10:02:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so8375012pju.1;
        Fri, 20 May 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=o1byCpdVQiUFM7RT5J0ZZS8QAIMgCRWQMbEspomVBfk=;
        b=nWUHNztiOOoUrsK+bcjZbH1T/aOSc5WBrgXM3LFXHuiNEWY/GAAuPkB8kcHQihNJZp
         o342F+m3+6/+5yGNwbS/DDkAQZ1Owt/aUdH4RGMbMgVR4uW2VrLv8X/+zeltewpsD1YS
         Y96YZEMWY7nqrZ/HCSenS/ploHDKuDPUIL9L9M0B3FCRe643CGAk2bc1bGRMZ+mWJ97U
         +amIFLkc/XaEbb/O9DHmfsKe5wJeV3yyG2ZrjffZKbo8P/yxIhzpH0OxsGQFuVrqE50K
         VdjHqHijuIonv7Fy0C/rKErW42y2hE3ul7mzN7qEcfIHRgInZVg/gRQ2IAiH88yUcjYQ
         fj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=o1byCpdVQiUFM7RT5J0ZZS8QAIMgCRWQMbEspomVBfk=;
        b=W5iiYExxO1rcEw/UasGAxSyqdz1ryABXOmovv630n2mOPLkglS1e2Vn8R5dUDkIepT
         YCkOwlYnmdmJZPD08SPywjnfOC9hILYuEgDhC8y5a72smjZyocggKBrJBBwAjKQVGOo/
         frASMGXaHQ9fFWZ4ikX6TnmuTT/vjo2Lr71mKgNzb45JxyK0JMeiGQSmO/Z7NNQ/mrNo
         kqRPgwhRVqIZQQJTcmiZ0zG5wRTh4aMOeOLWJDV7uoFeLeGlU/JPOdEMvkQFjhocJDVE
         ev2bAGu8AKgPCAGTf1FVgv3rzGOlgs94V5foGmadAGfNPWh2613TxZLaFDnsUjlTU35S
         NaMg==
X-Gm-Message-State: AOAM532fefKYKspD8PhyTNepTnR0tPBScKEEDn/LX9Mgl17+RKBZhAdy
        WZeL8xQ2uR8lGPac0GoM1Po=
X-Google-Smtp-Source: ABdhPJy0orbrRVTqOzOn8DmBLqe4oIu9EYfHI5f4fkIcgsA4o07Z4zYLdo2EdzMnPSMCyeY2En8XOw==
X-Received: by 2002:a17:90b:180f:b0:1df:cc0c:bbfd with SMTP id lw15-20020a17090b180f00b001dfcc0cbbfdmr11738327pjb.84.1653066134015;
        Fri, 20 May 2022 10:02:14 -0700 (PDT)
Received: from ssy-OptiPlex-7050.mioffice.cn ([43.224.245.236])
        by smtp.gmail.com with ESMTPSA id v62-20020a622f41000000b0051835ccc008sm2013870pfv.115.2022.05.20.10.02.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 May 2022 10:02:13 -0700 (PDT)
From:   shisiyuan <shisiyuan19870131@gmail.com>
X-Google-Original-From: shisiyuan <shisiyuan@xiaomi.com>
Cc:     shisiyuan <shisiyuan@xiaomi.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: Return if dst_cgrp equals to src_cgrp
Date:   Sat, 21 May 2022 01:02:00 +0800
Message-Id: <1653066120-21262-1-git-send-email-shisiyuan@xiaomi.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In function cgroup_migrate_add_src(), if dst_cgrp
equals to src_cgroup which the tasks link, dont
go on migrating tasks to another css_set.
This can save the cost of unnecessary migration.

Signed-off-by: shisiyuan <shisiyuan@xiaomi.com>
---
 kernel/cgroup/cgroup.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6139460..97d7f68 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2634,6 +2634,9 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 
 	src_cgrp = cset_cgroup_from_root(src_cset, dst_cgrp->root);
 
+	if (src_cgrp == dst_cgrp)
+		return;
+
 	if (!list_empty(&src_cset->mg_preload_node))
 		return;
 
@@ -2780,6 +2783,9 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
+	if (list_empty(&mgctx.preloaded_src_csets))
+		return ret;
+
 	/* prepare dst csets and commit */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (!ret)
@@ -2927,7 +2933,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	struct cgroup_subsys_state *d_css;
 	struct cgroup *dsct;
 	struct css_set *src_cset;
-	int ret;
+	int ret = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -2943,6 +2949,9 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	}
 	spin_unlock_irq(&css_set_lock);
 
+	if (list_empty(&mgctx.preloaded_src_csets))
+		goto out_finish;
+
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (ret)
-- 
2.7.4

