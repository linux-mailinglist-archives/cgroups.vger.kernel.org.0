Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3344DF385E
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 20:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfKGTSU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 14:18:20 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41436 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfKGTST (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 14:18:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id m125so3013657qkd.8;
        Thu, 07 Nov 2019 11:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Y+pHXtP5O8Okj4I0mI2qlT4EC3+7maC5emZuz1NNRA=;
        b=dSIVX8HNakf4UCSDoL9GG1/oa+JSiZjL1/w344VGzrazd/6fAm080EaF9aM6QD3MFA
         vq5u1kxJxiBZLyIF2H2xhW+la8wFC8tcKKkGNbQez6kyomQU1uijmoEMK9HT1AqS+CV3
         vIYYkZKpcIM/GAewRf3OCKq81YJZ1gw7Dw2T86U5a3lNuiy0/4ScCO2uJeX+RsV7PgAq
         UP1MEMD/D78B7sO0L+tyC6BPtLKx1QOf+C4p7t7ppanFT0Hp1KTAWvSpEOx9rjllz0T9
         bsRnu/XNTsEeQckp1QUWnXntos/XMOMa9VPkmJTOUiue0zs7Fx6LmS7jqs8dQQuFi1y3
         dFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=2Y+pHXtP5O8Okj4I0mI2qlT4EC3+7maC5emZuz1NNRA=;
        b=VZEQ3ZHRyOXdAg97P8pc1UwGplkxM01Dnu0b5pUWnh3X+dh1ucsx+a4yiMgZGsfvEn
         kmmZaSyh603uMpIUaJRTXkg8JSWa5GZQQ1Gdm76DxTRsifWofQR/Woarfl9/UIpFtWDb
         G7+DFY6c/XkZ8qlhsIrTQeEMjF46AfIs9GCRDCjI5Wh7UWYs0fiMCKnrlJMzOD+uAy3c
         N+/4HQZZj5lJkjS3vLmljP7pkTnvo7TBcOoIEYVvo7vjdRM5nIPwKMZWYwE3Z2W/B1EB
         3v2nAhy0f1Ic8olUCsdRedtOMiu3hhZV40NtNRTyEXd7qyqvBQZL1I9knwfLe+mPpIpv
         UXtQ==
X-Gm-Message-State: APjAAAWW9Ui0PvicP8+wiqAEGfccfyn4+mfqRFVG74yWwWfYO/kchDvx
        XI7ZaH6ddlkFRX7mPqfY4VJZ+PkC
X-Google-Smtp-Source: APXvYqxEzXjT/Yjh2YaX2GmIVA2JV8RHUOMpZm34G+LXXpps6UG6QGzE2IzX5MEqSD4vNWt/wk/rmw==
X-Received: by 2002:a37:5bc4:: with SMTP id p187mr4430131qkb.420.1573154298093;
        Thu, 07 Nov 2019 11:18:18 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id h12sm1541234qkh.123.2019.11.07.11.18.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 11:18:17 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/6] blk-cgroup: remove now unused blkg_print_stat_{bytes|ios}_recursive()
Date:   Thu,  7 Nov 2019 11:18:02 -0800
Message-Id: <20191107191804.3735303-5-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191107191804.3735303-1-tj@kernel.org>
References: <20191107191804.3735303-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

These don't have users anymore.  Remove them.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c         | 83 --------------------------------------
 include/linux/blk-cgroup.h |  5 ---
 2 files changed, 88 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1eb8895be4c6..e7e93377e320 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -615,89 +615,6 @@ u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 }
 EXPORT_SYMBOL_GPL(blkg_prfill_rwstat);
 
-static u64 blkg_prfill_rwstat_field(struct seq_file *sf,
-				    struct blkg_policy_data *pd, int off)
-{
-	struct blkg_rwstat_sample rwstat = { };
-
-	blkg_rwstat_read((void *)pd->blkg + off, &rwstat);
-	return __blkg_prfill_rwstat(sf, pd, &rwstat);
-}
-
-/**
- * blkg_print_stat_bytes - seq_show callback for blkg->stat_bytes
- * @sf: seq_file to print to
- * @v: unused
- *
- * To be used as cftype->seq_show to print blkg->stat_bytes.
- * cftype->private must be set to the blkcg_policy.
- */
-int blkg_print_stat_bytes(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  blkg_prfill_rwstat_field, (void *)seq_cft(sf)->private,
-			  offsetof(struct blkcg_gq, stat_bytes), true);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blkg_print_stat_bytes);
-
-/**
- * blkg_print_stat_bytes - seq_show callback for blkg->stat_ios
- * @sf: seq_file to print to
- * @v: unused
- *
- * To be used as cftype->seq_show to print blkg->stat_ios.  cftype->private
- * must be set to the blkcg_policy.
- */
-int blkg_print_stat_ios(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  blkg_prfill_rwstat_field, (void *)seq_cft(sf)->private,
-			  offsetof(struct blkcg_gq, stat_ios), true);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blkg_print_stat_ios);
-
-static u64 blkg_prfill_rwstat_field_recursive(struct seq_file *sf,
-					      struct blkg_policy_data *pd,
-					      int off)
-{
-	struct blkg_rwstat_sample rwstat;
-
-	blkg_rwstat_recursive_sum(pd->blkg, NULL, off, &rwstat);
-	return __blkg_prfill_rwstat(sf, pd, &rwstat);
-}
-
-/**
- * blkg_print_stat_bytes_recursive - recursive version of blkg_print_stat_bytes
- * @sf: seq_file to print to
- * @v: unused
- */
-int blkg_print_stat_bytes_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  blkg_prfill_rwstat_field_recursive,
-			  (void *)seq_cft(sf)->private,
-			  offsetof(struct blkcg_gq, stat_bytes), true);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blkg_print_stat_bytes_recursive);
-
-/**
- * blkg_print_stat_ios_recursive - recursive version of blkg_print_stat_ios
- * @sf: seq_file to print to
- * @v: unused
- */
-int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v)
-{
-	blkcg_print_blkgs(sf, css_to_blkcg(seq_css(sf)),
-			  blkg_prfill_rwstat_field_recursive,
-			  (void *)seq_cft(sf)->private,
-			  offsetof(struct blkcg_gq, stat_ios), true);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(blkg_print_stat_ios_recursive);
-
 /**
  * blkg_rwstat_recursive_sum - collect hierarchical blkg_rwstat
  * @blkg: blkg of interest
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index bed9e43f9426..914ce55fa8c2 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -220,11 +220,6 @@ u64 __blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 			 const struct blkg_rwstat_sample *rwstat);
 u64 blkg_prfill_rwstat(struct seq_file *sf, struct blkg_policy_data *pd,
 		       int off);
-int blkg_print_stat_bytes(struct seq_file *sf, void *v);
-int blkg_print_stat_ios(struct seq_file *sf, void *v);
-int blkg_print_stat_bytes_recursive(struct seq_file *sf, void *v);
-int blkg_print_stat_ios_recursive(struct seq_file *sf, void *v);
-
 void blkg_rwstat_recursive_sum(struct blkcg_gq *blkg, struct blkcg_policy *pol,
 		int off, struct blkg_rwstat_sample *sum);
 
-- 
2.17.1

