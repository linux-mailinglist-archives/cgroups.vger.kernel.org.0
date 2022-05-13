Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9679E526591
	for <lists+cgroups@lfdr.de>; Fri, 13 May 2022 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381639AbiEMPB6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 May 2022 11:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381842AbiEMPBI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 May 2022 11:01:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BA3FDB1;
        Fri, 13 May 2022 07:59:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso7997485pjb.5;
        Fri, 13 May 2022 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L6n+4dfll/BRetr32yeP/ERgzE6Vl2zW43Zw49sqvUE=;
        b=hnYXjKWw+87VL85SaN68rpIkMD9dCJnWQWKiMcWhIGGUu4WsnUKCWaRNmGQwUTj6XF
         7GMMIyIetdkFWw+LSKsbtqEVp0G7o9Rhwz5e5wipdEpIfSH8wMoCN0VtYEFx6kwpKY4c
         9vxJIt6CnuZNA4J3AR+FHs2Kly6vpvXwOwVsMcuhrO4po39rjEETXmriLaYAfGLokvvS
         bYv4rJMoEGTQX+uzgMEJ98GSwyaI5fTbUqzxqDmUBaRw/rGW8+a9+PWvk+0eX6CNYr22
         +IiGF82f4IrjiLG20M2yO23egnCmhbTOaBWWL7O/mPs5Vj3sMOKv6FC7w4+R4Ph3sFse
         qh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L6n+4dfll/BRetr32yeP/ERgzE6Vl2zW43Zw49sqvUE=;
        b=1fbGAgMI8r/E2YzW0O9Cc3tIn22+yx3vQ1dIO8F9Hy/7pjZlFpbk8dqSCnimH8ayTG
         4ymP/aU62wcxtonDMGDS/ZAP1ifTVfKY35K5uVaxCo1is9x4coYH+5CggLvpCX6anSR2
         AsK6f8Wjnigtq67Ncuq1LeL8dbtB2A1z7dSt01+x/BHQpUsBPV41EMaQxTmVlKj9kuFP
         oWxCPWO0rwaYKBIU1GwlLp7r9n7yrhxyQkAvOQD8LFItTjstqS6vQ1pRi0cDKh1qV6Yr
         KIuQ0LwxRsCHl8low5vWQz217CKrQeioi8tuwmr/Xjy+bUbPWgw5rwG/T1kkrPDsGaEG
         0tTg==
X-Gm-Message-State: AOAM533LivAwIXwnLnb3/Y4/oRnQfE1OEwzlbDxJ9OaNWkOXM3yMRzpC
        O1vIM160zyHZxx//wbZrxxI=
X-Google-Smtp-Source: ABdhPJyuaRFcd/12DbUN8KUJNVv6u6XAgTDMKNSA5HgDKgBB0oKA93xiH7TwON3D14cgZ9B7gocIrA==
X-Received: by 2002:a17:903:240e:b0:158:eab9:2662 with SMTP id e14-20020a170903240e00b00158eab92662mr4845446plo.87.1652453989501;
        Fri, 13 May 2022 07:59:49 -0700 (PDT)
Received: from DIDI-C02G33EXQ05D.xiaojukeji.com ([111.194.46.158])
        by smtp.gmail.com with ESMTPSA id z6-20020a170903018600b0015eb200cc00sm2011747plg.138.2022.05.13.07.59.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 May 2022 07:59:49 -0700 (PDT)
From:   Yahu Gao <gaoyahu19@gmail.com>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        Yahu Gao <yahugao@didiglobal.com>,
        Kunhai Dai <daikunhai@didiglobal.com>
Subject: [PATCH] block,iocost: fix potential kernel NULL
Date:   Fri, 13 May 2022 22:59:28 +0800
Message-Id: <20220513145928.29766-2-gaoyahu19@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220513145928.29766-1-gaoyahu19@gmail.com>
References: <20220513145928.29766-1-gaoyahu19@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Yahu Gao <yahugao@didiglobal.com>

Some inode pinned dying memory cgroup and its parent destroyed at first.
The parent's pd of iocost won't be allocated during function
blkcg_activate_policy.
Ignore the DYING CSS to avoid kernel NULL during iocost policy data init.

Signed-off-by: Yahu Gao <yahugao@didiglobal.com>
Signed-off-by: Kunhai Dai <daikunhai@didiglobal.com>

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index a91f8ae18b49..32472de2e61d 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1418,6 +1418,9 @@ int blkcg_activate_policy(struct request_queue *q,
 	list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
 		struct blkg_policy_data *pd;
 
+		if (blkg->blkcg->css.flags & CSS_DYING)
+			continue;
+
 		if (blkg->pd[pol->plid])
 			continue;
 
@@ -1459,8 +1462,11 @@ int blkcg_activate_policy(struct request_queue *q,
 
 	/* all allocated, init in the same order */
 	if (pol->pd_init_fn)
-		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node)
+		list_for_each_entry_reverse(blkg, &q->blkg_list, q_node) {
+			if (blkg->blkcg->css.flags & CSS_DYING)
+				continue;
 			pol->pd_init_fn(blkg->pd[pol->plid]);
+		}
 
 	__set_bit(pol->plid, q->blkcg_pols);
 	ret = 0;
-- 
2.30.1
