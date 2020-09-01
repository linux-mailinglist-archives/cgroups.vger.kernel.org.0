Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F02259EB5
	for <lists+cgroups@lfdr.de>; Tue,  1 Sep 2020 20:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgIASxk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 1 Sep 2020 14:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731563AbgIASxh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 1 Sep 2020 14:53:37 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EDAC061245;
        Tue,  1 Sep 2020 11:53:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so1739689qtg.4;
        Tue, 01 Sep 2020 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9CT/Pfaa29kbHcQyFjwoJj23rZzAWWYwFA5TYGSz5M=;
        b=i/BXrQkgkv7QT7qjcqY0KSGlDoxBJwW4KpDXH82QhKpbGtbdebLOUTjaCUe5b5/nZw
         rCODKcxJIXdNwj42TeSpSGUushKooNwe0n3mlchxpiyPl8W3/5+zspLkQF/OyPcgR5RS
         FJV+btITXYPBoXMt3anyJhpBxeVwd5xHqtJEcBZFZK4HWZkN4xQDvh9WMz59KryVmlt5
         +sAX8KZrcybC1/u2MZn457a/XmuZ2TgsX5GmhJtNKYvATshK2VL+GZPE3iQg/N23x0Fx
         MLfIT9ZwD1/JbrvEZZaHDcKyfCDIuOLNTUPy0ERi4n1tVf3flcadR1IiAx/rpA1ZZ9rj
         XjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=b9CT/Pfaa29kbHcQyFjwoJj23rZzAWWYwFA5TYGSz5M=;
        b=cqsCcjHb5mhsuQuz+oYHGXC+ny2Si/C37i1dlC+DTot7YAHHVKf0od563E/j6mi4Vo
         c80UB3hpabjYXPfZ7XAGJ40jbm0zzHmLnf9H17rcNqGvU7RXryRpbKVjNhQtm7zdDBaF
         5zkmuUV7ItNxTer4uMTg0eVWlz9p5zNL12IFhwsxIBo9R7wCN8INWr87A3xnDuoRQiTQ
         cZjDtNhWrTlC3xy9XwGZJBPeKm1uLPOv3izfyDNOFCHLw9XUi/gLerUPl0VBCveEse2M
         egsa/rC/1Ad+c6cYJBMTn/v4RdhrTRBVFZryotbcqgin67m6tSrjl+SnTwE7zmIxucDJ
         KYCg==
X-Gm-Message-State: AOAM530cIrS9kQ4v+0MueOt/kjfz7DvKCpgw6Tg4Q6XisDJpevLdYBZ6
        TnyNGYSno/FBmBtzVc3e9u86+WTv9tZhCQ==
X-Google-Smtp-Source: ABdhPJwE7t2uWDiypDRMlzVcJMFvJe6QxLN4rRdw6ZVCIo8dU3IItrGwF39QORSjPGAbfwD9lV5b9g==
X-Received: by 2002:ac8:c8c:: with SMTP id n12mr3300144qti.226.1598986411316;
        Tue, 01 Sep 2020 11:53:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a198])
        by smtp.gmail.com with ESMTPSA id i1sm2585368qkd.58.2020.09.01.11.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:30 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, newella@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 09/27] blk-iocost: use WEIGHT_ONE based fixed point number for weights
Date:   Tue,  1 Sep 2020 14:52:39 -0400
Message-Id: <20200901185257.645114-10-tj@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901185257.645114-1-tj@kernel.org>
References: <20200901185257.645114-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

To improve weight donations, we want to able to scale inuse with a greater
accuracy and down below 1. Let's make non-hierarchical weights to use
WEIGHT_ONE based fixed point numbers too like hierarchical ones.

This doesn't cause any behavior changes yet.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-iocost.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5e6d56eec1c9..00c5a3ad2b5b 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -984,8 +984,8 @@ static void current_hweight(struct ioc_gq *iocg, u32 *hw_activep, u32 *hw_inusep
 	for (lvl = 0; lvl <= iocg->level - 1; lvl++) {
 		struct ioc_gq *parent = iocg->ancestors[lvl];
 		struct ioc_gq *child = iocg->ancestors[lvl + 1];
-		u32 active_sum = READ_ONCE(parent->child_active_sum);
-		u32 inuse_sum = READ_ONCE(parent->child_inuse_sum);
+		u64 active_sum = READ_ONCE(parent->child_active_sum);
+		u64 inuse_sum = READ_ONCE(parent->child_inuse_sum);
 		u32 active = READ_ONCE(child->active);
 		u32 inuse = READ_ONCE(child->inuse);
 
@@ -993,11 +993,11 @@ static void current_hweight(struct ioc_gq *iocg, u32 *hw_activep, u32 *hw_inusep
 		if (!active_sum || !inuse_sum)
 			continue;
 
-		active_sum = max(active, active_sum);
-		hwa = hwa * active / active_sum;	/* max 16bits * 10000 */
+		active_sum = max_t(u64, active, active_sum);
+		hwa = div64_u64((u64)hwa * active, active_sum);
 
-		inuse_sum = max(inuse, inuse_sum);
-		hwi = hwi * inuse / inuse_sum;		/* max 16bits * 10000 */
+		inuse_sum = max_t(u64, inuse, inuse_sum);
+		hwi = div64_u64((u64)hwi * inuse, inuse_sum);
 	}
 
 	iocg->hweight_active = max_t(u32, hwa, 1);
@@ -1022,7 +1022,8 @@ static void weight_updated(struct ioc_gq *iocg)
 	weight = iocg->cfg_weight ?: iocc->dfl_weight;
 	if (weight != iocg->weight && iocg->active)
 		propagate_weights(iocg, weight,
-			DIV64_U64_ROUND_UP(iocg->inuse * weight, iocg->weight));
+				  DIV64_U64_ROUND_UP((u64)iocg->inuse * weight,
+						     iocg->weight));
 	iocg->weight = weight;
 }
 
@@ -2050,7 +2051,7 @@ static struct blkcg_policy_data *ioc_cpd_alloc(gfp_t gfp)
 	if (!iocc)
 		return NULL;
 
-	iocc->dfl_weight = CGROUP_WEIGHT_DFL;
+	iocc->dfl_weight = CGROUP_WEIGHT_DFL * WEIGHT_ONE;
 	return &iocc->cpd;
 }
 
@@ -2136,7 +2137,7 @@ static u64 ioc_weight_prfill(struct seq_file *sf, struct blkg_policy_data *pd,
 	struct ioc_gq *iocg = pd_to_iocg(pd);
 
 	if (dname && iocg->cfg_weight)
-		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight);
+		seq_printf(sf, "%s %u\n", dname, iocg->cfg_weight / WEIGHT_ONE);
 	return 0;
 }
 
@@ -2146,7 +2147,7 @@ static int ioc_weight_show(struct seq_file *sf, void *v)
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct ioc_cgrp *iocc = blkcg_to_iocc(blkcg);
 
-	seq_printf(sf, "default %u\n", iocc->dfl_weight);
+	seq_printf(sf, "default %u\n", iocc->dfl_weight / WEIGHT_ONE);
 	blkcg_print_blkgs(sf, blkcg, ioc_weight_prfill,
 			  &blkcg_policy_iocost, seq_cft(sf)->private, false);
 	return 0;
@@ -2172,7 +2173,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 			return -EINVAL;
 
 		spin_lock(&blkcg->lock);
-		iocc->dfl_weight = v;
+		iocc->dfl_weight = v * WEIGHT_ONE;
 		hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
 			struct ioc_gq *iocg = blkg_to_iocg(blkg);
 
@@ -2203,7 +2204,7 @@ static ssize_t ioc_weight_write(struct kernfs_open_file *of, char *buf,
 	}
 
 	spin_lock(&iocg->ioc->lock);
-	iocg->cfg_weight = v;
+	iocg->cfg_weight = v * WEIGHT_ONE;
 	weight_updated(iocg);
 	spin_unlock(&iocg->ioc->lock);
 
-- 
2.26.2

