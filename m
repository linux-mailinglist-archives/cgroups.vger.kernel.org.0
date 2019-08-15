Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2D68F532
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 21:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfHOT5X (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 15:57:23 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34698 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728956AbfHOT5X (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Aug 2019 15:57:23 -0400
Received: by mail-qt1-f194.google.com with SMTP id q4so3673873qtp.1;
        Thu, 15 Aug 2019 12:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LFxVzI9MepcAl4Lnqm6SEvMCLIi+u2ZqmJKlF6ic0o=;
        b=jjTNHUJ+CSG6+ZUiOmqZD7r0T3PUVCgfjcmbNMfGfPR8DHnctfki8PyRgCaQiyB90S
         UWKnZoGdq8+gWKBRhfYYqTZFxccfzAN8droy/uuQAn/QQj/WXaMpDNOoUqAixilN6XWZ
         Sk53sgnFEFB4AG7XxGGusOOxgwx2THclF1wyqs+7Qb2gzDgFcnq4EhL3ld/Ls5TSy4Q5
         LIUIN5BhMM68p6SVE3RIkRWEwox+dN2CEbkaavpnNzDMj+eCiq2B1UGpU7K14QSpw51w
         1SO27McqrcnIjLscZNURHZZeQ+IdchCWOkYO6u9avMv8pnjE+yYMDugbMHQaNhDFI9JN
         y/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LFxVzI9MepcAl4Lnqm6SEvMCLIi+u2ZqmJKlF6ic0o=;
        b=Xk18+Gw0nyCbCzE8omgSUbQ9XQ7cFzO5CeFyB6g+LUCoXlzyMiPgzIwcNTEryoXA2+
         LVfxCSC+1Pd6sc2LVs6Umu3kJ7OQuH+5yNyS0gUj47Xqaef/or1vsrPIs998eg1fb+71
         7aIic4DpgNvlNlopHeZ4UnvgAca8RVMadveXp7CHyk45uWXwEJFdIEhg2YuzxQxk9t0w
         m5JcE/9hOOrr69clf7MxhmU83DQWSI7MqT+2JVhu85DNDu2kii3Z5ouKWE3i7uoJzMCV
         iIdRivtIaTdm75nQvB0UlZo09yFYKR0gOoBKMxlGAv25yvDoJlbQnF2vwscUN7+HFNhu
         ehAw==
X-Gm-Message-State: APjAAAVed38oAX/HKB519ZZKYA1oosx8Kd5JRtv/YEObtVfqlfFToJVV
        HEX+1lrPGpazaG7DEvrc8wE=
X-Google-Smtp-Source: APXvYqwvGoz95kfeW/o6YJ39eK/95vaFIXp94ZgS9UtlL7U+AC31LouqDrLwGVqyFtoh8BCsILyYSA==
X-Received: by 2002:ac8:289b:: with SMTP id i27mr5552503qti.67.1565899041355;
        Thu, 15 Aug 2019 12:57:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:25cd])
        by smtp.gmail.com with ESMTPSA id h1sm2042852qkh.101.2019.08.15.12.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 12:57:20 -0700 (PDT)
Date:   Thu, 15 Aug 2019 12:57:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, guro@fb.com, akpm@linux-foundation.org
Subject: [PATCH 1/5] writeback: Generalize and expose wb_completion
Message-ID: <20190815195719.GB2263813@devbig004.ftw2.facebook.com>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
 fs/fs-writeback.c                |   47 +++++++++++----------------------------
 include/linux/backing-dev-defs.h |   20 ++++++++++++++++
 include/linux/backing-dev.h      |    2 +
 3 files changed, 36 insertions(+), 33 deletions(-)

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
@@ -61,19 +57,6 @@ struct wb_writeback_work {
 };
 
 /*
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
-/*
  * If an inode is constantly having its pages dirtied, but then the
  * updates stop dirtytime_expire_interval seconds in the past, it's
  * possible for the worst case time between when an inode has its
@@ -182,7 +165,7 @@ static void finish_writeback_work(struct
 	if (work->auto_free)
 		kfree(work);
 	if (done && atomic_dec_and_test(&done->cnt))
-		wake_up_all(&wb->bdi->wb_waitq);
+		wake_up_all(done->waitq);
 }
 
 static void wb_queue_work(struct bdi_writeback *wb,
@@ -206,20 +189,18 @@ static void wb_queue_work(struct bdi_wri
 
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
@@ -854,7 +835,7 @@ static void bdi_split_work_to_wbs(struct
 restart:
 	rcu_read_lock();
 	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
-		DEFINE_WB_COMPLETION_ONSTACK(fallback_work_done);
+		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
 		struct wb_writeback_work fallback_work;
 		struct wb_writeback_work *work;
 		long nr_pages;
@@ -901,7 +882,7 @@ restart:
 		last_wb = wb;
 
 		rcu_read_unlock();
-		wb_wait_for_completion(bdi, &fallback_work_done);
+		wb_wait_for_completion(&fallback_work_done);
 		goto restart;
 	}
 	rcu_read_unlock();
@@ -2373,7 +2354,8 @@ static void wait_sb_inodes(struct super_
 static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 				     enum wb_reason reason, bool skip_if_busy)
 {
-	DEFINE_WB_COMPLETION_ONSTACK(done);
+	struct backing_dev_info *bdi = sb->s_bdi;
+	DEFINE_WB_COMPLETION(done, bdi);
 	struct wb_writeback_work work = {
 		.sb			= sb,
 		.sync_mode		= WB_SYNC_NONE,
@@ -2382,14 +2364,13 @@ static void __writeback_inodes_sb_nr(str
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
@@ -2451,7 +2432,8 @@ EXPORT_SYMBOL(try_to_writeback_inodes_sb
  */
 void sync_inodes_sb(struct super_block *sb)
 {
-	DEFINE_WB_COMPLETION_ONSTACK(done);
+	struct backing_dev_info *bdi = sb->s_bdi;
+	DEFINE_WB_COMPLETION(done, bdi);
 	struct wb_writeback_work work = {
 		.sb		= sb,
 		.sync_mode	= WB_SYNC_ALL,
@@ -2461,7 +2443,6 @@ void sync_inodes_sb(struct super_block *
 		.reason		= WB_REASON_SYNC,
 		.for_sync	= 1,
 	};
-	struct backing_dev_info *bdi = sb->s_bdi;
 
 	/*
 	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
@@ -2475,7 +2456,7 @@ void sync_inodes_sb(struct super_block *
 	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
 	bdi_down_write_wb_switch_rwsem(bdi);
 	bdi_split_work_to_wbs(bdi, &work, false);
-	wb_wait_for_completion(bdi, &done);
+	wb_wait_for_completion(&done);
 	bdi_up_write_wb_switch_rwsem(bdi);
 
 	wait_sb_inodes(sb);
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
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -44,6 +44,8 @@ void wb_start_background_writeback(struc
 void wb_workfn(struct work_struct *work);
 void wb_wakeup_delayed(struct bdi_writeback *wb);
 
+void wb_wait_for_completion(struct wb_completion *done);
+
 extern spinlock_t bdi_lock;
 extern struct list_head bdi_list;
 
