Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16885F2139
	for <lists+cgroups@lfdr.de>; Wed,  6 Nov 2019 22:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbfKFV6w (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 6 Nov 2019 16:58:52 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40062 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732529AbfKFV6v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 6 Nov 2019 16:58:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id o49so46415qta.7;
        Wed, 06 Nov 2019 13:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hn9KkzqqgL6eBUuXNep4FWvkAHRI9UbpMFZih9xc/gk=;
        b=CrWeS2vzp3f+rrsw9iSlgyevlGf1JDS+yU0NnM5k/bA/ISiQvAO/cvkiHZu5rjCUQT
         4NvbSmaFYWABriHUzGEB8ng8jgcrZGLEPfo1YQq/AjmsIyP7PW+5+h+f06T9T+jJuvn6
         ZcMhbsrE8kg/0fwM7xqR+TaL6ZGHmCiUYWJ5JPAn6PIwIdwdjFK+MVkgn5UJQHAJfu+n
         bqFXx2IW1iSZfNNWWqMBZtG2YX0fjaECvgoPur9LbQOwgHUF0rP1ct93vsXAn2eS7EvH
         CHpgLIEYn7azHVbap/XAtvbaWoQRD5PjxIKT96fpdMOuLAYFmVhP2iJV+S2obzwzTcJY
         6EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Hn9KkzqqgL6eBUuXNep4FWvkAHRI9UbpMFZih9xc/gk=;
        b=smuavDzCiFt/gH9Iy9OIGJUIMdb2M9dwqmc8B7SdNMDhAKqySUoJlRLJWnShajeRz3
         1vQQ5x1E08brEn9sZ3fdH07Q7lM4jG+2Eyg6LYarv4RMtp6ZfsF6GmtNOD1/P2iIfhEv
         wXsDLSoyrKrei9uXIPrKbhB8/Z/NtztB933hraL4hUWbFJWOl0wHV+bFYi2fUpFiE79b
         H9d6vgLLkqxU1IaGQYO+TKWXvKIJcvHONTk/SlpdnsmsNxPpK9nHz3Nz0ec/i/cORy5T
         0yGFpvrZayQKZqxy9OTEh0X3V9g7YaAQhSPn/GO8hY2UrZ49zr4se8LtOeoMOwRH4Ht+
         JTAw==
X-Gm-Message-State: APjAAAUt4VK05nizyYoYmkd37av6mKTOCOqpjZ2G+zW8goqAAmxYJjsv
        t7G+6QTwk5Vdmpc6r/xmwlU=
X-Google-Smtp-Source: APXvYqxQ5osSenXIM+ClCl7GN+RQbfFEMa6GlxDURLHQNNa/Xyen52l9jkC95mVxQGGDQUWGQ3BeCQ==
X-Received: by 2002:ac8:7186:: with SMTP id w6mr256456qto.220.1573077529901;
        Wed, 06 Nov 2019 13:58:49 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5bd1])
        by smtp.gmail.com with ESMTPSA id b10sm67804qkh.69.2019.11.06.13.58.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 13:58:49 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/5] blk-cgroup: remove now unused blkg_print_stat_{bytes|ios}_recursive()
Date:   Wed,  6 Nov 2019 13:58:36 -0800
Message-Id: <20191106215838.3973497-4-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106215838.3973497-1-tj@kernel.org>
References: <20191106215838.3973497-1-tj@kernel.org>
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
index 238d99aa0a99..e23a21ba6d46 100644
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

