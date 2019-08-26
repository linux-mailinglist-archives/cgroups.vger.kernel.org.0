Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 776859D3B6
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2019 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbfHZQHI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Aug 2019 12:07:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40594 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbfHZQHH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Aug 2019 12:07:07 -0400
Received: by mail-qk1-f194.google.com with SMTP id s145so14445798qke.7;
        Mon, 26 Aug 2019 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VLHZ6ZNZgqY5/GiQqVLdmuLaStLAgiw+ZiX1K52HrY4=;
        b=sNwCMXNqcvEyA4KghlQTGzgEiPrT39GgcA2FeeuElZKbfhHirdQcRItctuijuXXqOq
         kytMlb6po4B16uaQagwe48+I9ETxfswFZRqdvHwf/nJPr0VxltfNOfbOm3qUiHNDy0o+
         Vb/zF0BsMWZ/8iEhiNJIH8d8bYf5FlD8PT2vThdCDoX76yUthkG/kml9sRZe4ubIcTIF
         K5gPNKO3yvicvLQJ/RMICafnmg94MSCTsyHfDXelWtzsBERuEqohmd+/N5d+f0sIiBec
         3BI8y4q4wS3W3ITTG7UpWqM7DxxS0a4Hmk1tuYbee9Hh4moHaIRq/pqif4gBMk6aRXHo
         E6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=VLHZ6ZNZgqY5/GiQqVLdmuLaStLAgiw+ZiX1K52HrY4=;
        b=i59/8GUbaOlxmpPtDwX9OlJrmMYn3wLmdUDZ/7e7syLQEbll3v8kkMsXmvcD1KNltN
         E4sDq5Gv13NhwVvJivgYw9xSniePAg9K+oDrpZjrdFllwyImgWNyU4ZPcAZLIHrJ0bDn
         rr5CHUIws9lfUuay+gAOMNM3xKkf73J+DECUFjDPtqXJD6muaDFIxm2xjEkMLI4WSdMF
         w7Icd4OAHCGzksefj3anW8ZNZKfiZOkAkaGGw6FvTnMEsu2F7mfs8fmRuyfBRccqzYu+
         D2PKcmrtTrp7o/155tGudv5xg91EweyOFPe2yQJo9cCIgcQ1vvBSK7Me8bVOa2F1vUn3
         dcMA==
X-Gm-Message-State: APjAAAVxMYbB+ND1sQnqcO5KLL3SWNlkh9jVzVaqUSHS1Jwxs5Kvu7Ly
        vLUNdr+ZXrYDyzmWoc4V5TY=
X-Google-Smtp-Source: APXvYqwlluVR2FGCz1GaYgZtKsTrXxdhegOASK8N9AFXHtVRxexC+pNnumgVk+Ouc0c5UQRW6sJBeQ==
X-Received: by 2002:a37:454:: with SMTP id 81mr16595509qke.153.1566835626129;
        Mon, 26 Aug 2019 09:07:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::d081])
        by smtp.gmail.com with ESMTPSA id 20sm6237089qkg.59.2019.08.26.09.07.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 09:07:05 -0700 (PDT)
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] writeback: Generalize and expose wb_completion
Date:   Mon, 26 Aug 2019 09:06:52 -0700
Message-Id: <20190826160656.870307-2-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826160656.870307-1-tj@kernel.org>
References: <20190826160656.870307-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

wb_completion is used to track writeback completions.  We want to use
it from memcg side for foreign inode flushes.  This patch updates it
to remember the target waitq instead of assuming bdi->wb_waitq and
expose it outside of fs-writeback.c.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c                | 47 ++++++++++----------------------
 include/linux/backing-dev-defs.h | 20 ++++++++++++++
 include/linux/backing-dev.h      |  2 ++
 3 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index fddd8abd839a..9442f1fd6460 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -36,10 +36,6 @@
  */
 #define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
 
-struct wb_completion {
-	atomic_t		cnt;
-};
-
 /*
  * Passed into wb_writeback(), essentially a subset of writeback_control
  */
@@ -60,19 +56,6 @@ struct wb_writeback_work {
 	struct wb_completion *done;	/* set if the caller waits */
 };
 
-/*
- * If one wants to wait for one or more wb_writeback_works, each work's
- * ->done should be set to a wb_completion defined using the following
- * macro.  Once all work items are issued with wb_queue_work(), the caller
- * can wait for the completion of all using wb_wait_for_completion().  Work
- * items which are waited upon aren't freed automatically on completion.
- */
-#define DEFINE_WB_COMPLETION_ONSTACK(cmpl)				\
-	struct wb_completion cmpl = {					\
-		.cnt		= ATOMIC_INIT(1),			\
-	}
-
-
 /*
  * If an inode is constantly having its pages dirtied, but then the
  * updates stop dirtytime_expire_interval seconds in the past, it's
@@ -182,7 +165,7 @@ static void finish_writeback_work(struct bdi_writeback *wb,
 	if (work->auto_free)
 		kfree(work);
 	if (done && atomic_dec_and_test(&done->cnt))
-		wake_up_all(&wb->bdi->wb_waitq);
+		wake_up_all(done->waitq);
 }
 
 static void wb_queue_work(struct bdi_writeback *wb,
@@ -206,20 +189,18 @@ static void wb_queue_work(struct bdi_writeback *wb,
 
 /**
  * wb_wait_for_completion - wait for completion of bdi_writeback_works
- * @bdi: bdi work items were issued to
  * @done: target wb_completion
  *
  * Wait for one or more work items issued to @bdi with their ->done field
- * set to @done, which should have been defined with
- * DEFINE_WB_COMPLETION_ONSTACK().  This function returns after all such
- * work items are completed.  Work items which are waited upon aren't freed
+ * set to @done, which should have been initialized with
+ * DEFINE_WB_COMPLETION().  This function returns after all such work items
+ * are completed.  Work items which are waited upon aren't freed
  * automatically on completion.
  */
-static void wb_wait_for_completion(struct backing_dev_info *bdi,
-				   struct wb_completion *done)
+void wb_wait_for_completion(struct wb_completion *done)
 {
 	atomic_dec(&done->cnt);		/* put down the initial count */
-	wait_event(bdi->wb_waitq, !atomic_read(&done->cnt));
+	wait_event(*done->waitq, !atomic_read(&done->cnt));
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
@@ -854,7 +835,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 restart:
 	rcu_read_lock();
 	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
-		DEFINE_WB_COMPLETION_ONSTACK(fallback_work_done);
+		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
 		struct wb_writeback_work fallback_work;
 		struct wb_writeback_work *work;
 		long nr_pages;
@@ -901,7 +882,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		last_wb = wb;
 
 		rcu_read_unlock();
-		wb_wait_for_completion(bdi, &fallback_work_done);
+		wb_wait_for_completion(&fallback_work_done);
 		goto restart;
 	}
 	rcu_read_unlock();
@@ -2373,7 +2354,8 @@ static void wait_sb_inodes(struct super_block *sb)
 static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 				     enum wb_reason reason, bool skip_if_busy)
 {
-	DEFINE_WB_COMPLETION_ONSTACK(done);
+	struct backing_dev_info *bdi = sb->s_bdi;
+	DEFINE_WB_COMPLETION(done, bdi);
 	struct wb_writeback_work work = {
 		.sb			= sb,
 		.sync_mode		= WB_SYNC_NONE,
@@ -2382,14 +2364,13 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		.nr_pages		= nr,
 		.reason			= reason,
 	};
-	struct backing_dev_info *bdi = sb->s_bdi;
 
 	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
 		return;
 	WARN_ON(!rwsem_is_locked(&sb->s_umount));
 
 	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
-	wb_wait_for_completion(bdi, &done);
+	wb_wait_for_completion(&done);
 }
 
 /**
@@ -2451,7 +2432,8 @@ EXPORT_SYMBOL(try_to_writeback_inodes_sb);
  */
 void sync_inodes_sb(struct super_block *sb)
 {
-	DEFINE_WB_COMPLETION_ONSTACK(done);
+	struct backing_dev_info *bdi = sb->s_bdi;
+	DEFINE_WB_COMPLETION(done, bdi);
 	struct wb_writeback_work work = {
 		.sb		= sb,
 		.sync_mode	= WB_SYNC_ALL,
@@ -2461,7 +2443,6 @@ void sync_inodes_sb(struct super_block *sb)
 		.reason		= WB_REASON_SYNC,
 		.for_sync	= 1,
 	};
-	struct backing_dev_info *bdi = sb->s_bdi;
 
 	/*
 	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
@@ -2475,7 +2456,7 @@ void sync_inodes_sb(struct super_block *sb)
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
 	bdi_down_write_wb_switch_rwsem(bdi);
 	bdi_split_work_to_wbs(bdi, &work, false);
-	wb_wait_for_completion(bdi, &done);
+	wb_wait_for_completion(&done);
 	bdi_up_write_wb_switch_rwsem(bdi);
 
 	wait_sb_inodes(sb);
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 6a1a8a314d85..8fb740178d5d 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -67,6 +67,26 @@ enum wb_reason {
 	WB_REASON_MAX,
 };
 
+struct wb_completion {
+	atomic_t		cnt;
+	wait_queue_head_t	*waitq;
+};
+
+#define __WB_COMPLETION_INIT(_waitq)	\
+	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
+
+/*
+ * If one wants to wait for one or more wb_writeback_works, each work's
+ * ->done should be set to a wb_completion defined using the following
+ * macro.  Once all work items are issued with wb_queue_work(), the caller
+ * can wait for the completion of all using wb_wait_for_completion().  Work
+ * items which are waited upon aren't freed automatically on completion.
+ */
+#define WB_COMPLETION_INIT(bdi)		__WB_COMPLETION_INIT(&(bdi)->wb_waitq)
+
+#define DEFINE_WB_COMPLETION(cmpl, bdi)	\
+	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
+
 /*
  * For cgroup writeback, multiple wb's may map to the same blkcg.  Those
  * wb's can operate mostly independently but should share the congested
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 35b31d176f74..02650b1253a2 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -44,6 +44,8 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
 void wb_workfn(struct work_struct *work);
 void wb_wakeup_delayed(struct bdi_writeback *wb);
 
+void wb_wait_for_completion(struct wb_completion *done);
+
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
 
-- 
2.17.1

