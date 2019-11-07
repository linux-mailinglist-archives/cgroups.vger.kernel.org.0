Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7862EF3866
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfKGTSM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:18:12 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33834 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGTSL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:18:11 -0500
Received: by mail-qt1-f196.google.com with SMTP id c25so2975518qtq.1;
        Thu, 07 Nov 2019 11:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=znlRTNHoKykO2PNyEazvN0YZ+bFmJkjSeLacwzzLw1A=;
        b=tjG1KjgaTrTGNnprsl2NxFJreLf/OjzVAt0A6QrnOxpwd0AHDEMI0Y26C72AY7F2MU
         zKhDevIrcosd7yDgfQEfu6gx1ezxW3hiCHBjwwp9Hg0BRg9qmf3F7twiyESf28ieVBfz
         M6EI3Yf4APy4CwFNOVkRfDMUUl876WTZNb9ueC3SyuC9KGpuY7sQJhS63dcc/tdTJa/q
         vBv7EwAjxDKFuZtzStKbDkhBcy2q7W9qsFpmBNRh+coxxeF6GMqItIdziVMN/1NLCRjC
         62tsHMUPgDU/e7x/ylQf7TzBAIcsOzKWB51wQp9jtbQjsS/lrgAT5PZYce/5/6+wojid
         Y5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=znlRTNHoKykO2PNyEazvN0YZ+bFmJkjSeLacwzzLw1A=;
        b=slo9XBJxkfqSzM5BphDcd4mj/iADqaupOMxpQ9VhQVxRe45A+JOAnJvITJ65JN8V30
         bsGPHESccnNfM2IjaMb30yfTePj9Lkyle3wWVijIldQh06ok6sqq7Vd/yx1OtwujvuSa
         X/q4GPEq/UgYaXQkD6QCPUCGcjaTdfox1Hp8jKeuZA0RbK7sAg8+UHVwu4aCAMCFVi9s
         PKARqpYtmaR7oZvwsGc4LNTbo0/nPUPeW2DDHvKAb6BkoH2w6zMiF+MeovohJ3ZzZSxB
         wfAl/flpE02uKOQ7sDhJ5rluCymVVLBlwS8dVprAThvNaFIhO4ufPU4viKrIYyZbX6wf
         VCFQ==
X-Gm-Message-State: APjAAAUGqfPLYJxDrO4ZV2J/1ll479ZsvCiDpdNfrzOUfjYtqlW1aY7D
        Gv6KhxfzO48sHDCntrRQ0vk=
X-Google-Smtp-Source: APXvYqxr5bVBbF246UZewTgmCA6ffw+w2tBv0vJNSbEB5Y+O60muyD2EofKG0zvGXSxg1TGWfudM7A==
X-Received: by 2002:ac8:7216:: with SMTP id a22mr5692998qtp.187.1573154290213;
        Thu, 07 Nov 2019 11:18:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id w20sm1395361qkj.87.2019.11.07.11.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:18:09 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] bfq-iosched: relocate bfqg_*rwstat*() helpers
Date:   Thu,  7 Nov 2019 11:17:59 -0800
Message-Id: <20191107191804.3735303-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107191804.3735303-1-tj@kernel.org>
References: <20191107191804.3735303-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Collect them right under #ifdef CONFIG_BFQ_CGROUP_DEBUG.  The next
patch will use them from !DEBUG path and this makes it easy to move
them out of the ifdef block.

This is pure code reorganization.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/bfq-cgroup.c | 46 +++++++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 86a607cf19a1..d4755d4ad009 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1058,17 +1058,34 @@ static ssize_t bfq_io_set_weight(struct kernfs_open_file *of,
 }
 
 #ifdef CONFIG_BFQ_CGROUP_DEBUG
-static int bfqg_print_stat(struct seq_file *sf, void *v)
+static int bfqg_print_rwstat(struct seq_file *sf, void *v)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
 	return 0;
 }
 
-static int bfqg_print_rwstat(struct seq_file *sf, void *v)
+static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
+					struct blkg_policy_data *pd, int off)
 {
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_rwstat,
-			  &blkcg_policy_bfq, seq_cft(sf)->private, true);
+	struct blkg_rwstat_sample sum;
+
+	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
+	return __blkg_prfill_rwstat(sf, pd, &sum);
+}
+
+static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
+			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
+			  seq_cft(sf)->private, true);
+	return 0;
+}
+
+static int bfqg_print_stat(struct seq_file *sf, void *v)
+{
+	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)), blkg_prfill_stat,
+			  &blkcg_policy_bfq, seq_cft(sf)->private, false);
 	return 0;
 }
 
@@ -1097,15 +1114,6 @@ static u64 bfqg_prfill_stat_recursive(struct seq_file *sf,
 	return __blkg_prfill_u64(sf, pd, sum);
 }
 
-static u64 bfqg_prfill_rwstat_recursive(struct seq_file *sf,
-					struct blkg_policy_data *pd, int off)
-{
-	struct blkg_rwstat_sample sum;
-
-	blkg_rwstat_recursive_sum(pd_to_blkg(pd), &blkcg_policy_bfq, off, &sum);
-	return __blkg_prfill_rwstat(sf, pd, &sum);
-}
-
 static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 {
 	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
@@ -1114,14 +1122,6 @@ static int bfqg_print_stat_recursive(struct seq_file *sf, void *v)
 	return 0;
 }
 
-static int bfqg_print_rwstat_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  bfqg_prfill_rwstat_recursive, &blkcg_policy_bfq,
-			  seq_cft(sf)->private, true);
-	return 0;
-}
-
 static u64 bfqg_prfill_sectors(struct seq_file *sf, struct blkg_policy_data *pd,
 			       int off)
 {
-- 
2.17.1

