Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C4575A80
	for <lists+cgroups@lfdr.de>; Fri, 15 Jul 2022 06:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGOEiU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Jul 2022 00:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGOEiU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 Jul 2022 00:38:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D2622B03;
        Thu, 14 Jul 2022 21:38:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso10507742pjc.1;
        Thu, 14 Jul 2022 21:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=kUYCCkCp2sZaFmaobvAgo9eIoVvtPeHxItnEuLVK4Pw=;
        b=pvgxeU3HgvzlG1Ih8myLZ5v7kjtFLSKMmhkrsYSOL06XJOSBeokm6WYkCPBF/VJvn+
         C3fnZnZgBPiA6Jwqi74UoFqyQkXq7b2Vdmi2//HmEGDrkbKH8+cBhFCG2NQqus+foDOw
         MyUCZ51bODeq7F0bkhYdjvzu0jQn8QeHJ58mRkZmWh6dD5D3DXlvmyTgtaJbbHyg57Ns
         qDstWAtJfgEzCEhmK8gCY7i2J1KoHycaQoU+7mBmb8LIePeSjKDOXRdeNOIknMtGn81y
         RBtQrdOdqqSr2ZaTmv71trPPP7o7EPBTkg5SX6UaEMwuF4TYc48OXftNZ2duZVaJHa+i
         hA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=kUYCCkCp2sZaFmaobvAgo9eIoVvtPeHxItnEuLVK4Pw=;
        b=6xyuDTiM+F4JyH/dzdTkiMiYKMHtuzcot7rUolePyMtd1M7aXFY8Tl3EbH36JwUZUV
         z2q82arE+tvytS3v6w9sVyVCzc2toUiZyT2bK4K2UKT5ouAYZ8Y5vgDK7dk6W3gHgZPK
         WmSoa7tG0T1tT28ZR/yLkCrhY2LY6YFHZvz9vRndttQLFCW8YjzUngpJGCLCBe312uue
         8yARLl2yjvhSHj30te+NkNwnY5g2RhGrwdGECvQZlCFocudXBjLp0qrlY58VYdsc/s5S
         Pb3YHpgkerUeDy30U62kWRXWovSBUIocOS2vrbK4jpPiFEQ2QYzxANxa+nEUJMebul8W
         UQnA==
X-Gm-Message-State: AJIora9zXZm7C0G1oHV7qQ4gBS9RJKIkTLe0vyYHoM0gok9z0Wd6dE42
        hSP+4Dcu86NVrjEWzzPggU4=
X-Google-Smtp-Source: AGRyM1umb5MalBeftqA06sH77Vs1AZbJ0KUX97UjKtpw7fQ1CIvCzT26xMRiSSTjKglcy9Kr+UrMIg==
X-Received: by 2002:a17:903:2654:b0:16c:5120:f379 with SMTP id je20-20020a170903265400b0016c5120f379mr11881773plb.3.1657859898626;
        Thu, 14 Jul 2022 21:38:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id v188-20020a6261c5000000b0051bc36b7995sm2598807pfb.62.2022.07.14.21.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 21:38:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 14 Jul 2022 18:38:15 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: [PATCH 1/3 cgroup/for-5.20] cgroup: Elide write-locking
 threadgroup_rwsem when updating csses on an empty subtree
Message-ID: <YtDvN0wJ6CKaEPN8@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cgroup_update_dfl_csses() write-lock the threadgroup_rwsem as updating the
csses can trigger process migrations. However, if the subtree doesn't
contain any tasks, there aren't gonna be any cgroup migrations. This
condition can be trivially detected by testing whether
mgctx.preloaded_src_csets is empty. Elide write-locking threadgroup_rwsem if
the subtree is empty.

After this optimization, the usage pattern of creating a cgroup, enabling
the necessary controllers, and then seeding it with CLONE_INTO_CGROUP and
then removing the cgroup after it becomes empty doesn't need to write-lock
threadgroup_rwsem at all.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2933,12 +2933,11 @@ static int cgroup_update_dfl_csses(struc
 	struct cgroup_subsys_state *d_css;
 	struct cgroup *dsct;
 	struct css_set *src_cset;
+	bool has_tasks;
 	int ret;
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
-
 	/* look up all csses currently attached to @cgrp's subtree */
 	spin_lock_irq(&css_set_lock);
 	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
@@ -2949,6 +2948,16 @@ static int cgroup_update_dfl_csses(struc
 	}
 	spin_unlock_irq(&css_set_lock);
 
+	/*
+	 * We need to write-lock threadgroup_rwsem while migrating tasks.
+	 * However, if there are no source csets for @cgrp, changing its
+	 * controllers isn't gonna produce any task migrations and the
+	 * write-locking can be skipped safely.
+	 */
+	has_tasks = !list_empty(&mgctx.preloaded_src_csets);
+	if (has_tasks)
+		percpu_down_write(&cgroup_threadgroup_rwsem);
+
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
 	if (ret)
@@ -2967,7 +2976,8 @@ static int cgroup_update_dfl_csses(struc
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	if (has_tasks)
+		percpu_up_write(&cgroup_threadgroup_rwsem);
 	return ret;
 }
 
