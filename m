Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3F6D9B45
	for <lists+cgroups@lfdr.de>; Thu,  6 Apr 2023 16:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjDFOw5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 6 Apr 2023 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjDFOwc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 6 Apr 2023 10:52:32 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E2A273
        for <cgroups@vger.kernel.org>; Thu,  6 Apr 2023 07:51:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id iw3so37709468plb.6
        for <cgroups@vger.kernel.org>; Thu, 06 Apr 2023 07:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680792669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhKhQOgHY4omeSf5oEZtApwayoKc6MIO22TQQuOJpsE=;
        b=CZieEMBTQy1sXreaOD5ONqXZQm9UZPO2FMYEGmaNnkHl66lF7X+TBFOBF6YevEuu8i
         3Un4k80LJ/JCkwFV5Sh2Sy/bEr8qsUPVwTEVaLCnDM7bLXbriwFdcGb0kp5rcx24Z+S4
         KTTkHmaT256dZfW4jWHyf4zlv/oHcnh+7+HqdkStMzmJ0UgKtY9uiliIZwqdHLzNML6R
         vMURaaBcOSPsvGPNdYwg5hrkebPPacRI9ZQresV32Nc6IzjvZHk1zUDKaQU1BoBryxgI
         oKT7HJQsPcdgYvEb0bhL8hVdsV1uB5W8kEneVCkEVjDIEv0GA7zDkS3RCzs+xtmQ5Z25
         NJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhKhQOgHY4omeSf5oEZtApwayoKc6MIO22TQQuOJpsE=;
        b=ipmskJ7V3w0DGPwgNd2y3naTltz86Jmp0JxILdAH7ZxqjCcVouEH1sQ5xWV3Mc0auN
         QYI7tQl+RG4sINgbn5TV/vhUJ7zNQMHYPGPQM5TVIEXLJ04A7GYEqxod3Gbxf0Kxkz1/
         9T0JWseS0UhVWERdc4Cfbfx0mu5fOCrT1HoQ/jN3h2M6frPoskbsYSrZ/fV7cLG1ISwF
         tHWWAfo6128X+LXoV080/e/BoEH9alKxuq8yfUjsgYlJ5q6i6T5Z16K6poIg1e0CsYLj
         HNRxiXIfTieMkfWwWHGn/cumQ0LzGRBjTD+5rh+pUmKCQFSf3oYXs506WuhOcMPiy+jY
         UFEw==
X-Gm-Message-State: AAQBX9fJzHO29E8Pmb4HVOvtMRgKVqjeM0ygq0LoGZE8NgYbwomXDZ5k
        mSPsgDgSBtjzk+TYy+deLT6/mA==
X-Google-Smtp-Source: AKy350ZQlx8Idn2uhz4vLL63pEGLj/FKmdzGq3i37RUJDB+3tHU2onX4M5SQjH88NwD6MJymZZGhsA==
X-Received: by 2002:a17:902:d510:b0:1a1:8007:d370 with SMTP id b16-20020a170902d51000b001a18007d370mr7141311plg.33.1680792668969;
        Thu, 06 Apr 2023 07:51:08 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a28:e63:f500:18d3:10f7:2e64:a1a7])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902eb4400b0019ca68ef7c3sm1487398pli.74.2023.04.06.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:51:08 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 2/3] blk-cgroup: delete cpd_bind_fn of blkcg_policy
Date:   Thu,  6 Apr 2023 22:50:49 +0800
Message-Id: <20230406145050.49914-3-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230406145050.49914-1-zhouchengming@bytedance.com>
References: <20230406145050.49914-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

cpd_bind_fn is just used for update default weight when block
subsys attached to a hierarchy. No any policy need it anymore.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c | 21 ---------------------
 block/blk-cgroup.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 18c922579719..f663178f3a19 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1395,26 +1395,6 @@ void blkcg_exit_disk(struct gendisk *disk)
 	blk_throtl_exit(disk);
 }
 
-static void blkcg_bind(struct cgroup_subsys_state *root_css)
-{
-	int i;
-
-	mutex_lock(&blkcg_pol_mutex);
-
-	for (i = 0; i < BLKCG_MAX_POLS; i++) {
-		struct blkcg_policy *pol = blkcg_policy[i];
-		struct blkcg *blkcg;
-
-		if (!pol || !pol->cpd_bind_fn)
-			continue;
-
-		list_for_each_entry(blkcg, &all_blkcgs, all_blkcgs_node)
-			if (blkcg->cpd[pol->plid])
-				pol->cpd_bind_fn(blkcg->cpd[pol->plid]);
-	}
-	mutex_unlock(&blkcg_pol_mutex);
-}
-
 static void blkcg_exit(struct task_struct *tsk)
 {
 	if (tsk->throttle_disk)
@@ -1428,7 +1408,6 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
 	.css_rstat_flush = blkcg_rstat_flush,
-	.bind = blkcg_bind,
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
 	.legacy_name = "blkio",
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index e98d2c1be354..073488b9c7a0 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -176,7 +176,6 @@ struct blkcg_policy {
 	blkcg_pol_alloc_cpd_fn		*cpd_alloc_fn;
 	blkcg_pol_init_cpd_fn		*cpd_init_fn;
 	blkcg_pol_free_cpd_fn		*cpd_free_fn;
-	blkcg_pol_bind_cpd_fn		*cpd_bind_fn;
 
 	blkcg_pol_alloc_pd_fn		*pd_alloc_fn;
 	blkcg_pol_init_pd_fn		*pd_init_fn;
-- 
2.39.2

