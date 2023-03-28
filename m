Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311F86CC1FB
	for <lists+cgroups@lfdr.de>; Tue, 28 Mar 2023 16:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbjC1OX0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 10:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjC1OXZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 10:23:25 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB765FD6
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d10so7289099pgt.12
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680013403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fbUthmvZJbP0uWypvRq6mwPD7H6UG/v/3UyHU90H3o0=;
        b=NTg1JCEYXIL5mZ4LMW8DcsZJvrDf8IwNw9hp30j9TO7GBAGr0SEnuxFWhsFCWyvFD2
         O8bQkmMtjNy8tLclBcd6RNNFBrbtlCs5oxp1OKNk02oxnYYHOFkNH8j/Q/xQ+YVNPwDP
         ln+p36VFbYTbqUl1pKr0haZetqg2MamAFX+iM2arG8XIoKYEXwDDduY8YJCOEaEAzPcF
         tPMHjJPM810hJNCv2O4ZNsByZFmSSIE/8vXL5oFEUfVjB7yXmRhgI+UeQlxMw1P1qnvP
         fQT6rdeMMdTdB5xL5+pgB7wmQEhbrrZml75ao9Yh+IjqjDMfoEAv/5QPwCuNaEjh50+i
         vAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbUthmvZJbP0uWypvRq6mwPD7H6UG/v/3UyHU90H3o0=;
        b=UaRlg+RE/Ht9ZJnYkoAeY1BxKpEz+cnQMFC1h2FDGOeuHSzshD/TumsXBBbWbtueNU
         83VmRrHCmf+fq9sqRfTqJ/we+K44B0yxPVKAmgelqD1vGhQozokTOvgNDLVSxYQRkoXN
         xyr35QY4EAPTsUWA+/Oy5O+BqLqAJRk8zE3WbcfVyieKwvQ8sZPr/JSd9IK0YrdtMRsT
         qLVstE9bYOj+as11uiWWqjFZPUVgp1UhwbqckJPuuHaz7/o2Rs8wLVx8UxMaItwnyRNz
         GnZdn3xgmr3/hAtCBYdsVDCPH6S4T9fCuA3dR4Dht+XFfqkaUoq8ylbFgnkuOsdj+7MN
         Y/2g==
X-Gm-Message-State: AO0yUKU3GWyU6Gnb1tPTyKrtivd7eC4z6SUD6hNNtDuwRcc6yk8E7M2C
        aoHfH+R6prXHlyq46fYq17mbSQ==
X-Google-Smtp-Source: AK7set8BxkafKwct0/+6wDAtkPyJha1sx6HWpCvpzcdjdcFpOATI2Kzlc+6YebBnscJAdFsSJjYqDw==
X-Received: by 2002:a05:6a00:190a:b0:626:f690:e745 with SMTP id y10-20020a056a00190a00b00626f690e745mr26435591pfi.6.1680013403339;
        Tue, 28 Mar 2023 07:23:23 -0700 (PDT)
Received: from C02GD5ZHMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id g6-20020a62e306000000b005a8bf239f5csm21156215pfh.193.2023.03.28.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:23:22 -0700 (PDT)
From:   Jinke Han <hanjinke.666@bytedance.com>
X-Google-Original-From: Jinke Han <hnajinke.666@bytedance>
To:     tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinke Han <hanjinke.666@bytedance.com>
Subject: [PATCH] blk-throttle: Fix io statistics for cgroup v1
Date:   Tue, 28 Mar 2023 22:23:09 +0800
Message-Id: <20230328142309.73413-1-hanjinke.666@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Jinke Han <hanjinke.666@bytedance.com>

Now the io statistics of cgroup v1 are no longer accurate. Although
in the long run it's best that rstat is a good implementation of
cgroup v1 io statistics. But before that, we'd better fix this issue.

Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>
---
 block/blk-cgroup.c   | 3 +++
 block/blk-throttle.c | 6 ------
 block/blk-throttle.h | 9 +++++++++
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index bd50b55bdb61..677e4473e45e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2033,6 +2033,9 @@ void blk_cgroup_bio_start(struct bio *bio)
 	struct blkg_iostat_set *bis;
 	unsigned long flags;
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys))
+		return;
+
 	/* Root-level stats are sourced from system-wide IO stats */
 	if (!cgroup_parent(blkcg->css.cgroup))
 		return;
diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 47e9d8be68f3..2be66e9430f7 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -2174,12 +2174,6 @@ bool __blk_throtl_bio(struct bio *bio)
 
 	rcu_read_lock();
 
-	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
-		blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
-				bio->bi_iter.bi_size);
-		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
-	}
-
 	spin_lock_irq(&q->queue_lock);
 
 	throtl_update_latency_buckets(td);
diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index ef4b7a4de987..d1ccbfe9f797 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -185,6 +185,15 @@ static inline bool blk_should_throtl(struct bio *bio)
 	struct throtl_grp *tg = blkg_to_tg(bio->bi_blkg);
 	int rw = bio_data_dir(bio);
 
+	if (!cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {
+			bio_set_flag(bio, BIO_CGROUP_ACCT);
+			blkg_rwstat_add(&tg->stat_bytes, bio->bi_opf,
+					bio->bi_iter.bi_size);
+		}
+		blkg_rwstat_add(&tg->stat_ios, bio->bi_opf, 1);
+	}
+
 	/* iops limit is always counted */
 	if (tg->has_rules_iops[rw])
 		return true;
-- 
2.20.1

