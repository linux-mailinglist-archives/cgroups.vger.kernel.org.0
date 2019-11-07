Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8636AF37E8
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfKGTFE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:05:04 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33453 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbfKGTFE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:05:04 -0500
Received: by mail-qk1-f195.google.com with SMTP id 71so3026442qkl.0;
        Thu, 07 Nov 2019 11:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D2aZYGhhhD0fueEZXuZZtBxsPvMYXcl+9GQ42VL43KI=;
        b=QMrL5nCAR853//4IbtMGC+V9cyv4Cci7a5ZLezHlo8P+sBwSZ7sdElMR64J11gVzVy
         +jwOVFRlQ856q0LydViBktS8UwVaYvjFOE8Hshwk2Kg7vFAvvi4cycqMZn6M4UAWCAOk
         PeT1uWVTEy/ffwMqLCnEsdpXLFwX2HCynQx+JcUjU+LUgFlomDNbysXZjfEQjPhC59zw
         O2XpzH5to18sUHc//d8yst74RbREs30kLGGRa/MLmBzkn8XRbti2wLANRh0SLmW0ZnAY
         IQNiOZe+U5oyogrSXJDnBlKz0bgOZnAV3g17MmtlrW7o0HwvJmZA2ABKMPy4EkCZv3fy
         jLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D2aZYGhhhD0fueEZXuZZtBxsPvMYXcl+9GQ42VL43KI=;
        b=PK5hs8P2lyeP0ENI0SJmWxb0lSmVUlD2kOy7ThllAhp4CJSkQMGX2fXsW+O6a+8E2f
         7Zg1I9qSpbd0JXrAZhgZR03iCXILa4Lxr4D4ec+wFtEKh4vZhbUbytiHME/6ilD/9/2B
         IGAVH1vmNAPbng0sKfmlAXbDiMXGowClvX+N8VX+4FxROJP9s8mhxPH5kxQXKhkQ9+xP
         QIvPyknFDLAgcLJQual4cqzepl4r+T9yZA1KVz2BYMqg1klF5wSvoSnHpU2ksPkuUq3n
         n3WgLWfV7t1WArgjUrjULui1W4MQfiFcxW5v83pNX1l5ohDI83l/jpKoLatXrwxMXvKm
         1v1Q==
X-Gm-Message-State: APjAAAWFgCxEJHle384Ak6iCZeqgiJympf0iesSWBH7oy2r8pecQoyPA
        fjHI/lMa5qw6HWHLdyAlUJk=
X-Google-Smtp-Source: APXvYqzl96Q5hW2MM5DuIR0U3yR8pKDS3P3ZF244FehkB7rIAWEa59eSpL/t9gsb+/nHA8O5jAi9gg==
X-Received: by 2002:a37:4654:: with SMTP id t81mr4466141qka.0.1573153502452;
        Thu, 07 Nov 2019 11:05:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id b2sm1834935qtc.21.2019.11.07.11.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:05:01 -0800 (PST)
Date:   Thu, 7 Nov 2019 11:04:59 -0800
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com
Subject: [PATCH 0.5/5] bfq-iosched: relocate bfqg_*rwstat*() helpers
Message-ID: <20191107190459.GA3622521@devbig004.ftw2.facebook.com>
References: <20191106215838.3973497-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From a7b9100d72d75a1472bed130b6edd271b734776f Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Thu, 7 Nov 2019 11:01:19 -0800

Collect them right under #ifdef CONFIG_BFQ_CGROUP_DEBUG.  The next
patch will use them from !DEBUG path and this makes it easy to move
them out of the ifdef block.

This is pure code reorganization.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Jens, this is an extra patch to help fixing the build bug when
!CONFIG_BFQ_CGROUP_DEBUG.  The git tree has been updated accordingly.
Please let me know if you want the whole series reposted.

Thanks.

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
