Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF209F8F6
	for <lists+cgroups@lfdr.de>; Wed, 28 Aug 2019 05:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1DzM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Aug 2019 23:55:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36333 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbfH1DzL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Aug 2019 23:55:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id w2so776027pfi.3
        for <cgroups@vger.kernel.org>; Tue, 27 Aug 2019 20:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bIgxA3Dicc5Em+9jvdlEZK29bkfLLIMFrYtwXp+us5U=;
        b=K2eGYL4IXh4PqkH4VQU9aqqpK9Ede0d7UemLz9b+BP0cRFvInRySZyzPCWi0kADk5R
         bEqWj/ITKXnZk0s3uvaRI4Rh1lddoKo+KijHfgB7uebG3LI3IAZ9iV77sMTiD8WkA5oV
         VP3KXf8BlOiIyabJqciJtI3kebyh1cs+b67Jg4MIzWRUw+GJTaA4Nxd2pSd7NMzENC8s
         fBKRi6mKljV0+yXTZqNPGam9oqiaHIxCXSqXOfg+XcuAVJHqM9ijxivmUtnDu/Slqq3M
         REPlAbwQOJLPZmbQ3ngmdd6Rh+wOLjvq8ob79mkCaw1OA80FTo0i6y3h0r8bc8wyY83d
         rnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bIgxA3Dicc5Em+9jvdlEZK29bkfLLIMFrYtwXp+us5U=;
        b=nSXT/fDsJvZ7CiFap8IaFfUoIVR4vTE6JbbWgISF7Z4xmPoWQZMZR/73SZIGYM5o9j
         w/fzEADtrhD3IfqJw0hWB5hy+BIg2S7dVK4KEy2tOmmJU8eqS0jTN1EeFU/Cwuuc7+2S
         g26vT01Qc+jlulNpqaTmaPl0Mbcd/kz72yG9bbCDfYmtepcqn/abdtgs5numi4md22Cr
         llvI9VnWwOCTyao9keLXppkNZMPUyZwXnNs+zKQS5nT6cZqcDkmQIiduJgzBs0o7iLfX
         VYAchJhY8xJzuSh2g3lVaky/vOr+lNw8URXQxcfTM2OKckjEUdgUNt5XDBnESpVIgTBk
         65tQ==
X-Gm-Message-State: APjAAAX2QyjfhPcGWW4SaEJmyqlh4ddyuQ9/yxw8LWwYOByb2sKxYVxG
        6O1oKSctSr9YP4dYRDgKwymcSQ==
X-Google-Smtp-Source: APXvYqxXSZ1dYlR4gh5x8SXVs7IgANnreCUJeM0SkjEhOj33QalvdbIEvLX5R4LLrWMJ9ef1gKsrqQ==
X-Received: by 2002:a63:1045:: with SMTP id 5mr1612800pgq.165.1566964510195;
        Tue, 27 Aug 2019 20:55:10 -0700 (PDT)
Received: from localhost ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id i11sm899575pfk.34.2019.08.27.20.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:55:09 -0700 (PDT)
From:   Fam Zheng <zhengfeiran@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, paolo.valente@linaro.org, fam@euphon.net,
        duanxiongchun@bytedance.com, cgroups@vger.kernel.org,
        zhangjiachen.jc@bytedance.com, tj@kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 3/3] bfq: Add per-device weight
Date:   Wed, 28 Aug 2019 11:54:53 +0800
Message-Id: <20190828035453.18129-4-zhengfeiran@bytedance.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20190828035453.18129-1-zhengfeiran@bytedance.com>
References: <20190828035453.18129-1-zhengfeiran@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This adds to BFQ the missing per-device weight interfaces:
blkio.bfq.weight_device on legacy and io.bfq.weight on unified. The
implementation pretty closely resembles what we had in CFQ and the parsing code
is basically reused.

Tests
=====

Using two cgroups and three block devices, having weights setup as:

Cgroup          test1           test2
============================================
default         100             500
sda             500             100
sdb             default         default
sdc             200             200

cgroup v1 runs
--------------

    sda.test1.out:   READ: bw=913MiB/s
    sda.test2.out:   READ: bw=183MiB/s

    sdb.test1.out:   READ: bw=213MiB/s
    sdb.test2.out:   READ: bw=1054MiB/s

    sdc.test1.out:   READ: bw=650MiB/s
    sdc.test2.out:   READ: bw=650MiB/s

cgroup v2 runs
--------------

    sda.test1.out:   READ: bw=915MiB/s
    sda.test2.out:   READ: bw=184MiB/s

    sdb.test1.out:   READ: bw=216MiB/s
    sdb.test2.out:   READ: bw=1069MiB/s

    sdc.test1.out:   READ: bw=621MiB/s
    sdc.test2.out:   READ: bw=622MiB/s

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  | 95 +++++++++++++++++++++++++++++++++++++++------
 block/bfq-iosched.h |  3 ++
 2 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 28e5a9241237..de4fd8b725aa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -904,7 +904,7 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
 
-static int bfq_io_show_weight(struct seq_file *sf, void *v)
+static int bfq_io_show_weight_legacy(struct seq_file *sf, void *v)
 {
 	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
 	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
@@ -918,8 +918,32 @@ static int bfq_io_show_weight(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight)
+static u64 bfqg_prfill_weight_device(struct seq_file *sf,
+				     struct blkg_policy_data *pd, int off)
+{
+	struct bfq_group *bfqg = pd_to_bfqg(pd);
+
+	if (!bfqg->entity.dev_weight)
+		return 0;
+	return __blkg_prfill_u64(sf, pd, bfqg->entity.dev_weight);
+}
+
+static int bfq_io_show_weight(struct seq_file *sf, void *v)
+{
+	struct blkcg *blkcg = css_to_blkcg(seq_css(sf));
+	struct bfq_group_data *bfqgd = blkcg_to_bfqgd(blkcg);
+
+	seq_printf(sf, "default %u\n", bfqgd->weight);
+	blkcg_print_blkgs(sf, blkcg, bfqg_prfill_weight_device,
+			  &blkcg_policy_bfq, 0, false);
+	return 0;
+}
+
+static void bfq_group_set_weight(struct bfq_group *bfqg, u64 weight, u64 dev_weight)
 {
+	weight = dev_weight ?: weight;
+
+	bfqg->entity.dev_weight = dev_weight;
 	/*
 	 * Setting the prio_changed flag of the entity
 	 * to 1 with new_weight == weight would re-set
@@ -967,28 +991,71 @@ static int bfq_io_set_weight_legacy(struct cgroup_subsys_state *css,
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
 		if (bfqg)
-			bfq_group_set_weight(bfqg, val);
+			bfq_group_set_weight(bfqg, val, 0);
 	}
 	spin_unlock_irq(&blkcg->lock);
 
 	return ret;
 }
 
-static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
-				 char *buf, size_t nbytes,
-				 loff_t off)
+static ssize_t bfq_io_set_device_weight(struct kernfs_open_file *of,
+					char *buf, size_t nbytes,
+					loff_t off)
 {
-	u64 weight;
-	/* First unsigned long found in the file is used */
-	int ret = kstrtoull(strim(buf), 0, &weight);
+	int ret;
+	struct blkg_conf_ctx ctx;
+	struct blkcg *blkcg = css_to_blkcg(of_css(of));
+	struct bfq_group *bfqg;
+	u64 v;
 
+	ret = blkg_conf_prep(blkcg, &blkcg_policy_bfq, buf, &ctx);
 	if (ret)
 		return ret;
 
-	ret = bfq_io_set_weight_legacy(of_css(of), NULL, weight);
+	if (sscanf(ctx.body, "%llu", &v) == 1) {
+		/* require "default" on dfl */
+		ret = -ERANGE;
+		if (!v)
+			goto out;
+	} else if (!strcmp(strim(ctx.body), "default")) {
+		v = 0;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	bfqg = blkg_to_bfqg(ctx.blkg);
+
+	ret = -ERANGE;
+	if (!v || (v >= BFQ_MIN_WEIGHT && v <= BFQ_MAX_WEIGHT)) {
+		bfq_group_set_weight(bfqg, bfqg->entity.weight, v);
+		ret = 0;
+	}
+out:
+	blkg_conf_finish(&ctx);
 	return ret ?: nbytes;
 }
 
+static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
+				 char *buf, size_t nbytes,
+				 loff_t off)
+{
+	char *endp;
+	int ret;
+	u64 v;
+
+	buf = strim(buf);
+
+	/* "WEIGHT" or "default WEIGHT" sets the default weight */
+	v = simple_strtoull(buf, &endp, 0);
+	if (*endp == '\0' || sscanf(buf, "default %llu", &v) == 1) {
+		ret = bfq_io_set_weight_legacy(of_css(of), NULL, v);
+		return ret ?: nbytes;
+	}
+
+	return bfq_io_set_device_weight(of, buf, nbytes, off);
+}
+
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
 static int bfqg_print_stat(struct seq_file *sf, void *v)
 {
@@ -1145,9 +1212,15 @@ struct cftype bfq_blkcg_legacy_files[] = {
 	{
 		.name = "bfq.weight",
 		.flags = CFTYPE_NOT_ON_ROOT,
-		.seq_show = bfq_io_show_weight,
+		.seq_show = bfq_io_show_weight_legacy,
 		.write_u64 = bfq_io_set_weight_legacy,
 	},
+	{
+		.name = "bfq.weight_device",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = bfq_io_show_weight,
+		.write = bfq_io_set_weight,
+	},
 
 	/* statistics, covers only the tasks in the bfqg */
 	{
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index e80adf822bbe..5d1a519640f6 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -168,6 +168,9 @@ struct bfq_entity {
 	/* budget, used also to calculate F_i: F_i = S_i + @budget / @weight */
 	int budget;
 
+	/* device weight, if non-zero, it overrides the default weight of
+	 * bfq_group_data */
+	int dev_weight;
 	/* weight of the queue */
 	int weight;
 	/* next weight if a change is in progress */
-- 
2.22.1

