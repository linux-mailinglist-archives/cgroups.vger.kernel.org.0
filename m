Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3397BA0D3B
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 00:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfH1WGO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Aug 2019 18:06:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32916 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfH1WGO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Aug 2019 18:06:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id v38so1434922qtb.0;
        Wed, 28 Aug 2019 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bWZcH9vXISfuapb1ykMaOfyWg7zt+sgcAj3N+lm1Zag=;
        b=o2Et28SpDBqQxXHw6ogGlJgbvLPYCQ9MpmtRA9waNPizgA/7c8qe8GOzpK4LlrmKwY
         4s/GVlErvN8ncdVDDlFH6DgzcAJ6HHAoO2NsFgNzUCscUj7E0a+bcMQsZKuX/I/CP15B
         /ulO+fr/7cMn7ad6jyG3YhkxyVMH7x0b3zMLZj+55m2LUNpVZhcLkm26v83cyFcUV7eP
         hPTuRPwioPT8mtfHtPyjcwnMCLG8jzZZD+3NJDeSuT3Zcgw0i7QWUGTsxFA69uIeQsUg
         T5hGn7QgfqtCw1DYk352R2p3sXYSSD7IAQBCNmHSeMmtdh1gEk4NaxrEF/+pnsLJMq2x
         Ho4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bWZcH9vXISfuapb1ykMaOfyWg7zt+sgcAj3N+lm1Zag=;
        b=H8xy39le/EJlZIfapUCssNIJkoSIAyWBIg5QdUKdCfmcMb2ruxCYZ5ZcN8c3b1BHwF
         2TNUiOmAYEf0DQdDHtxT7gDHJsbBCCDk0fDH7JDAPmJGUMDH5RjOlj+KfC+X1O30D8es
         wTlVlkPufSo74dywalDAQHn+PpjXBA5iG6+4/Rs0nM/vEjAQtSNxaBnd8y0etu6tiUp0
         HE8LLcAqN9iwUbLTdSOohhaahnwqErA6GchppM6864M/SWZssgS8L+P2Zee9EWmAXtC7
         xxUsL9mz/gzy71SGG3/YYK/NQ3IHnuZ4Ib4DVHIJ+BhiXEr0GZeTO5i0Vh3tBgZtjj3+
         /rkw==
X-Gm-Message-State: APjAAAV+AZSsSX5gz6s4IproXL4GAkzBlDVzjb7qKpQW8jpSUSpVoYV+
        4DLv8volOq2oJvb/lPSUck8=
X-Google-Smtp-Source: APXvYqybSpMuLjQX2tkdLl2kJLayikZJb14zeOFfHLDbG3fAUkADxtQOeI7gvifFaUB0AlpkBWHvwA==
X-Received: by 2002:ac8:2c18:: with SMTP id d24mr6640580qta.292.1567029972482;
        Wed, 28 Aug 2019 15:06:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c231])
        by smtp.gmail.com with ESMTPSA id h13sm224305qkk.12.2019.08.28.15.06.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 15:06:11 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] blkcg: separate blkcg_conf_get_disk() out of blkg_conf_prep()
Date:   Wed, 28 Aug 2019 15:05:53 -0700
Message-Id: <20190828220600.2527417-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828220600.2527417-1-tj@kernel.org>
References: <20190828220600.2527417-1-tj@kernel.org>
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
index 78ccbdcfe723..0e2619c1a422 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -753,6 +753,44 @@ static struct blkcg_gq *blkg_lookup_check(struct blkcg *blkcg,
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
@@ -772,25 +810,11 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
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
 
@@ -856,7 +880,7 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 success:
 	ctx->disk = disk;
 	ctx->blkg = blkg;
-	ctx->body = body;
+	ctx->body = input;
 	return 0;
 
 fail_unlock:
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 261248e88eb1..bed9e43f9426 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -234,6 +234,7 @@ struct blkg_conf_ctx {
 	char				*body;
 };
 
+struct gendisk *blkcg_conf_get_disk(char **inputp);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
-- 
2.17.1

