Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8638D64DC1
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2019 22:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbfGJUvo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Jul 2019 16:51:44 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40219 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727917AbfGJUvm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Jul 2019 16:51:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1808596pla.7;
        Wed, 10 Jul 2019 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NSsXuJroaDqOlhMryi+iSYceW4KouvHH84idtExmGM0=;
        b=NuEfAEexdKe5z2kFDQNehIrB3aMB/hR+imA+acy7jtmdbjM2moXZf9UjPyRMqFUn7s
         PeGzkykFUiy3lBsdvRk03i9+xNY1FZYnYDeuNgzAKrK7T4dXIVOuZCtGobmHPS8S1Ge9
         +8zzZEyqPNhZw7ml2Q3Hce8U/K5GD0YpG1eHNZGgueLEDIscaK1MIsdGYPK4GlalISdb
         MU+p4BMnlTYl33MBfDtIFmE5kvqgZt69reT1+uqiOwpBDpKCnkP9dXCnBYcIrAqCglSN
         pINjO8k4G1kK9ovCBSXNPzb0+xAi9KSYMwvKPojE8DThJSFVAhUrLpt2tCchqcS9tiTX
         ZsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NSsXuJroaDqOlhMryi+iSYceW4KouvHH84idtExmGM0=;
        b=SpjdN+9d6d4ZxbQJub/2FRupE0BrnHZy8gfwib4FFoey7chuSAH7ERBiToHbw8Gd/8
         FraRNI1jcV3DYJJGToSpv2NhfqgTKAake6FYOEqetNq+9IMLJZIiT4etDHrF1sL8BDWI
         r5MVWQ0AugMMFT8znx0XTKC53T96PXR2QMRyvPoTEyzsHENekyyS3QS1B25ZmXYXK59T
         QQlyRQKYwIoz828izgHTGoIGLj8mYPqLKI+aORObcunCV3dJQF5tyqiGfuIIABrQhu7x
         GyHWcyOU3LdgpUUSrFe03ZDpVr4gIZqZ5JW1eXx/n/+cqdcwywR6YPmXT1mI/HHcxu6L
         KxCQ==
X-Gm-Message-State: APjAAAUtLn9/sc9JSfnQORd6jcywrkmFUgGx4rGXnlbebFjiFWS61Zx8
        QOPaQTU13RU5+0pXIVEvJhzDO73Mt/o=
X-Google-Smtp-Source: APXvYqxnQ8jQ7YsqtwbSMZRWqaQZgP92h51UQjHgW1G7QS0U0P0VCYbt6xYpRYOrDDfprUlZG0UZDA==
X-Received: by 2002:a17:902:8d95:: with SMTP id v21mr200974plo.225.1562791901434;
        Wed, 10 Jul 2019 13:51:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:2bbe])
        by smtp.gmail.com with ESMTPSA id p1sm3973087pff.74.2019.07.10.13.51.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 13:51:40 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, newella@fb.com, clm@fb.com, josef@toxicpanda.com,
        dennisz@fb.com, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] blkcg: separate blkcg_conf_get_disk() out of blkg_conf_prep()
Date:   Wed, 10 Jul 2019 13:51:21 -0700
Message-Id: <20190710205128.1316483-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710205128.1316483-1-tj@kernel.org>
References: <20190710205128.1316483-1-tj@kernel.org>
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
index 818e50b4cc7a..aed46a2c553e 100644
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
index 930631cad5cf..b0eacec11037 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -233,6 +233,7 @@ struct blkg_conf_ctx {
 	char				*body;
 };
 
+struct gendisk *blkcg_conf_get_disk(char **inputp);
 int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
-- 
2.17.1

