Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C965545190
	for <lists+cgroups@lfdr.de>; Fri, 14 Jun 2019 03:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfFNB4p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jun 2019 21:56:45 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43760 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfFNB4l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jun 2019 21:56:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id cl9so296267plb.10;
        Thu, 13 Jun 2019 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/dt7OIYKRyqSFJ5T6pacHG+4yCBCFpQgQA95nh2n3c=;
        b=twFpAuIy4fKcnPgu3N4Iw7eSYmslqgf+TrDrCRF4qu+6D1Mi0+nG/cYLmuewTTvxNF
         5f01wYaIexeFY3MRXwMddmskp9x9UjKGdoRflZPgiiItAvHA91L/Gc1yZEfY6ni53YeF
         CmlDEQCPYw7Utz5KBidT8i2HwJAwMplpfDeojP/wWx9HxsJJ7ZK8bRjEdRW5No5B7Ac2
         6q2OpEifZmj0rAnAGVokzAmb8dS8iAYCBfby0va6y/rllSj2Nz9JX5zuai0lRxaHMKY/
         g+r7oKOpiS/J+1RRESmqkCXUIWcwRM3hb5uje+gMtL/vHOK1ApOwY7GNADGIsDjmdV0T
         8tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2/dt7OIYKRyqSFJ5T6pacHG+4yCBCFpQgQA95nh2n3c=;
        b=NE3+AQ8iFIDrmERK1+0baPVi6eH29oPBr3oChd+goyJcTz+fok4HgSaHrfAXutMhEd
         O0UXwr72Zcjcn7NTDDALV9U8K7RnfKygq8rK2VliHsUipfJOCzmlz2YKd2lGA1PZNlL9
         7cvCwETGMBSwx3/4jp6c3TrYt9KjMUjuPR+NCDc2ABcYZ7pjVfCbdk0Y00ZBrc4jLtwd
         nB2ds5aXSlg8XtMf+tO6ylpibF6E9uP0K+cTu7KpC3/6km87IeEvIQoSqK7SbjaYzusl
         tGdrEDPM0Wz6VGR8ID1IKSfBy2+QAulepL1Zf4mP75An7a93ewP7PLgz6zIWEOC2a8ok
         gmFA==
X-Gm-Message-State: APjAAAVaGybNvyEEY1uPZd6EIJtnFeeHjrp4n2A+3/vuesBubbWJ0reg
        35QB2In7V1Bckb7yBLkJGsE=
X-Google-Smtp-Source: APXvYqyGtPIRx4SFYdn9zSTKZylsoZ94d80F/ghnnx5FcWmNt9d6nBuVfppXLk5CA5eeofT0grPayQ==
X-Received: by 2002:a17:902:26c:: with SMTP id 99mr93240767plc.215.1560477400399;
        Thu, 13 Jun 2019 18:56:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:9d14])
        by smtp.gmail.com with ESMTPSA id y22sm983694pfo.39.2019.06.13.18.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 18:56:39 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] blkcg: separate blkcg_conf_get_disk() out of blkg_conf_prep()
Date:   Thu, 13 Jun 2019 18:56:13 -0700
Message-Id: <20190614015620.1587672-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614015620.1587672-1-tj@kernel.org>
References: <20190614015620.1587672-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Separate out blkcg_conf_get_disk() so that it can be used by blkcg
policy interface file input parsers before the policy is actually
enabled.  This doesn't introduce any functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 62 ++++++++++++++++++++++++++------------
 include/linux/blk-cgroup.h |  1 +
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 60ad9b96e6eb..b66ee908db7c 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -809,6 +809,44 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
 	return __blkg_lookup(blkcg, q, true /* update_hint */);
 }
 
+/**
+ * blkg_conf_prep - parse and prepare for per-blkg config update
+ * @inputp: input string pointer
+ *
+ * Parse the device node prefix part, MAJ:MIN, of per-blkg config update
+ * from @input and get and return the matching gendisk.  *@inputp is
+ * updated to point past the device node prefix.  Returns an ERR_PTR()
+ * value on error.
+ *
+ * Use this function iff blkg_conf_prep() can't be used for some reason.
+ */
+struct gendisk *blkcg_conf_get_disk(char **inputp)
+{
+	char *input = *inputp;
+	unsigned int major, minor;
+	struct gendisk *disk;
+	int key_len, part;
+
+	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
+		return ERR_PTR(-EINVAL);
+
+	input += key_len;
+	if (!isspace(*input))
+		return ERR_PTR(-EINVAL);
+	input = skip_spaces(input);
+
+	disk = get_gendisk(MKDEV(major, minor), &part);
+	if (!disk)
+		return ERR_PTR(-ENODEV);
+	if (part) {
+		put_disk_and_module(disk);
+		return ERR_PTR(-ENODEV);
+	}
+
+	*inputp = input;
+	return disk;
+}
+
 /**
  * blkg_conf_prep - parse and prepare for per-blkg config update
  * @blkcg: target block cgroup
@@ -828,25 +866,11 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 	struct gendisk *disk;
 	struct request_queue *q;
 	struct blkcg_gq *blkg;
-	unsigned int major, minor;
-	int key_len, part, ret;
-	char *body;
-
-	if (sscanf(input, "%u:%u%n", &major, &minor, &key_len) != 2)
-		return -EINVAL;
-
-	body = input + key_len;
-	if (!isspace(*body))
-		return -EINVAL;
-	body = skip_spaces(body);
+	int ret;
 
-	disk = get_gendisk(MKDEV(major, minor), &part);
-	if (!disk)
-		return -ENODEV;
-	if (part) {
-		ret = -ENODEV;
-		goto fail;
-	}
+	disk = blkcg_conf_get_disk(&input);
+	if (IS_ERR(disk))
+		return PTR_ERR(disk);
 
 	q = disk->queue;
 
@@ -912,7 +936,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 success:
 	ctx->disk = disk;
 	ctx->blkg = blkg;
-	ctx->body = body;
+	ctx->body = input;
 	return 0;
 
 fail_unlock:
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 1ed27977f88f..674c482ec689 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -231,6 +231,7 @@ struct blkg_conf_ctx {
 	char				*body;
 };
 
+struct gendisk *blkcg_conf_get_disk(char **inputp);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
-- 
2.17.1

