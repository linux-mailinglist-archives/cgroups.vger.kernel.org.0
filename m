Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103C4EF180
	for <lists+cgroups@lfdr.de>; Tue,  5 Nov 2019 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfKDX7z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 18:59:55 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44717 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbfKDX7y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Nov 2019 18:59:54 -0500
Received: by mail-qt1-f193.google.com with SMTP id o11so21680338qtr.11;
        Mon, 04 Nov 2019 15:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a2733NNsFxokkup0lhcVBrtsXILzyoujhJDoRXd/bI4=;
        b=TShh1e+BQLYznj4ucW5hDNMcFR/nNVUUwlQXKRpc7KpzypKIE1wYq6LoVHpBHD4TMm
         +wnnMXLEwlkIZa8SBuBaLGhV+7XH/eB4rswx4pn4bKU5RxMSW2p7OO/9Nt7darAFTbGL
         771HpZ/wDOEeAG1rGBZO7LCSEXYAiU39+LGU6CiZAKOFAu5zksX+xp5Ku6smdIULETrZ
         fLj00hHzq5OeEGhaeXWYs9NfypQeVt9AnIUWlM2XxECoHMPAovnXqw/a5aLj4FN9yef9
         cOMLx5BVbw4tDNLd9syRwMNYqLEudpk9NL14Hg1S/c5vvKx3wSFDd0yc01hPNCvuzG4/
         edXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=a2733NNsFxokkup0lhcVBrtsXILzyoujhJDoRXd/bI4=;
        b=DLNuJ3EQnRRDzeq494eL9m2vq9WH/vqwq/ANGCTxoyVucV9fEIyCz3o5jOp4UOkchj
         5VMw+xFyvNPOFkoc4jdl1nuB8cn6I9auvswSzSmvlYexfnX864sCLnyKPZjbGwIhEWtS
         znctwK2KUEq+lUxVhgu+ge7l9rVCfxX9N/s4CLRFwt8+KLVRNdRUxvah+r/h4oSJnCBD
         Fa6/4jig5kz4jWq0J5MIrty5Tu2LRlZOgPL/BMsaUC4dpTnvZ/xoeUDOPJpCHeaGPEUV
         L0UZ8p+e77H3tksprtl88abFXLks6mg3psDJQUctXyeZCmdlaWjZgcRA4t4e31lQHWW0
         DOCg==
X-Gm-Message-State: APjAAAWj4QRY2ox2FFoegHDEOkwaJZbsw0zTDrGAH/9n7ZBKE0WyxNtN
        Mc2z1R9cY8zrRoGSYgEsQtU=
X-Google-Smtp-Source: APXvYqxT6zL0MswOhYm/uHfaEiUDD7mRxv3rbZoh7pkdS4pwkzmBp4hembTNcher+xYlRa3jmcQutQ==
X-Received: by 2002:a0c:c2d3:: with SMTP id c19mr25141793qvi.158.1572911992991;
        Mon, 04 Nov 2019 15:59:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:51f8])
        by smtp.gmail.com with ESMTPSA id k7sm2019327qkf.40.2019.11.04.15.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 15:59:52 -0800 (PST)
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 02/10] writeback: use ino_t for inodes in tracepoints
Date:   Mon,  4 Nov 2019 15:59:36 -0800
Message-Id: <20191104235944.3470866-3-tj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
References: <20191104235944.3470866-1-tj@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Writeback TPs currently use mix of 32 and 64bits for inos.  This isn't
currently broken because only cgroup inos are using 32bits and they're
limited to 32bits.  cgroup inos will make use of 64bits.  Let's
uniformly use ino_t.

While at it, switch the default cgroup ino value used when cgroup is
disabled to 1 instead of -1U as root cgroup always uses ino 1.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Namhyung Kim <namhyung@kernel.org>
---
Hello,

This is to prepare for kernfs 64bit ino support.  It'd be best to
route this with the rest of kernfs patchset.

Thanks.

 include/trace/events/writeback.h | 88 ++++++++++++++++----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index c2ce6480b4b1..95e50677476b 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -61,7 +61,7 @@ DECLARE_EVENT_CLASS(writeback_page_template,
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(pgoff_t, index)
 	),
 
@@ -102,7 +102,7 @@ DECLARE_EVENT_CLASS(writeback_dirty_inode_template,
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, flags)
 	),
@@ -150,28 +150,28 @@ DEFINE_EVENT(writeback_dirty_inode_template, writeback_dirty_inode,
 #ifdef CREATE_TRACE_POINTS
 #ifdef CONFIG_CGROUP_WRITEBACK
 
-static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
+static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
 	return wb->memcg_css->cgroup->kn->id.ino;
 }
 
-static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
+static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
 	if (wbc->wb)
 		return __trace_wb_assign_cgroup(wbc->wb);
 	else
-		return -1U;
+		return 1;
 }
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
-static inline unsigned int __trace_wb_assign_cgroup(struct bdi_writeback *wb)
+static inline ino_t __trace_wb_assign_cgroup(struct bdi_writeback *wb)
 {
-	return -1U;
+	return 1;
 }
 
-static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *wbc)
+static inline ino_t __trace_wbc_assign_cgroup(struct writeback_control *wbc)
 {
-	return -1U;
+	return 1;
 }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
@@ -187,8 +187,8 @@ TRACE_EVENT(inode_foreign_history,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned long,	ino)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		ino)
+		__field(ino_t,		cgroup_ino)
 		__field(unsigned int,	history)
 	),
 
@@ -199,7 +199,7 @@ TRACE_EVENT(inode_foreign_history,
 		__entry->history	= history;
 	),
 
-	TP_printk("bdi %s: ino=%lu cgroup_ino=%u history=0x%x",
+	TP_printk("bdi %s: ino=%lu cgroup_ino=%lu history=0x%x",
 		__entry->name,
 		__entry->ino,
 		__entry->cgroup_ino,
@@ -216,9 +216,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned long,	ino)
-		__field(unsigned int,	old_cgroup_ino)
-		__field(unsigned int,	new_cgroup_ino)
+		__field(ino_t,		ino)
+		__field(ino_t,		old_cgroup_ino)
+		__field(ino_t,		new_cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -228,7 +228,7 @@ TRACE_EVENT(inode_switch_wbs,
 		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
 	),
 
-	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%u new_cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%lu new_cgroup_ino=%lu",
 		__entry->name,
 		__entry->ino,
 		__entry->old_cgroup_ino,
@@ -245,10 +245,10 @@ TRACE_EVENT(track_foreign_dirty,
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
 		__field(u64,		bdi_id)
-		__field(unsigned long,	ino)
+		__field(ino_t,		ino)
 		__field(unsigned int,	memcg_id)
-		__field(unsigned int,	cgroup_ino)
-		__field(unsigned int,	page_cgroup_ino)
+		__field(ino_t,		cgroup_ino)
+		__field(ino_t,		page_cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -263,7 +263,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
 	),
 
-	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%u page_cgroup_ino=%u",
+	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%lu page_cgroup_ino=%lu",
 		__entry->name,
 		__entry->bdi_id,
 		__entry->ino,
@@ -282,7 +282,7 @@ TRACE_EVENT(flush_foreign,
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 		__field(unsigned int,	frn_bdi_id)
 		__field(unsigned int,	frn_memcg_id)
 	),
@@ -294,7 +294,7 @@ TRACE_EVENT(flush_foreign,
 		__entry->frn_memcg_id	= frn_memcg_id;
 	),
 
-	TP_printk("bdi %s: cgroup_ino=%u frn_bdi_id=%u frn_memcg_id=%u",
+	TP_printk("bdi %s: cgroup_ino=%lu frn_bdi_id=%u frn_memcg_id=%u",
 		__entry->name,
 		__entry->cgroup_ino,
 		__entry->frn_bdi_id,
@@ -311,9 +311,9 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 
 	TP_STRUCT__entry (
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(int, sync_mode)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -324,7 +324,7 @@ DECLARE_EVENT_CLASS(writeback_write_inode_template,
 		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
 	),
 
-	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu sync_mode=%d cgroup_ino=%lu",
 		__entry->name,
 		__entry->ino,
 		__entry->sync_mode,
@@ -358,7 +358,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__field(int, range_cyclic)
 		__field(int, for_background)
 		__field(int, reason)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name,
@@ -374,7 +374,7 @@ DECLARE_EVENT_CLASS(writeback_work_class,
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
 	TP_printk("bdi %s: sb_dev %d:%d nr_pages=%ld sync_mode=%d "
-		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%u",
+		  "kupdate=%d range_cyclic=%d background=%d reason=%s cgroup_ino=%lu",
 		  __entry->name,
 		  MAJOR(__entry->sb_dev), MINOR(__entry->sb_dev),
 		  __entry->nr_pages,
@@ -413,13 +413,13 @@ DECLARE_EVENT_CLASS(writeback_class,
 	TP_ARGS(wb),
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 	TP_fast_assign(
 		strscpy_pad(__entry->name, dev_name(wb->bdi->dev), 32);
 		__entry->cgroup_ino = __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: cgroup_ino=%u",
+	TP_printk("bdi %s: cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->cgroup_ino
 	)
@@ -459,7 +459,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 		__field(int, range_cyclic)
 		__field(long, range_start)
 		__field(long, range_end)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -478,7 +478,7 @@ DECLARE_EVENT_CLASS(wbc_class,
 
 	TP_printk("bdi %s: towrt=%ld skip=%ld mode=%d kupd=%d "
 		"bgrd=%d reclm=%d cyclic=%d "
-		"start=0x%lx end=0x%lx cgroup_ino=%u",
+		"start=0x%lx end=0x%lx cgroup_ino=%lu",
 		__entry->name,
 		__entry->nr_to_write,
 		__entry->pages_skipped,
@@ -510,7 +510,7 @@ TRACE_EVENT(writeback_queue_io,
 		__field(long,		age)
 		__field(int,		moved)
 		__field(int,		reason)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 	TP_fast_assign(
 		unsigned long *older_than_this = work->older_than_this;
@@ -522,7 +522,7 @@ TRACE_EVENT(writeback_queue_io,
 		__entry->reason	= work->reason;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 	),
-	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%u",
+	TP_printk("bdi %s: older=%lu age=%ld enqueue=%d reason=%s cgroup_ino=%lu",
 		__entry->name,
 		__entry->older,	/* older_than_this in jiffies */
 		__entry->age,	/* older_than_this in relative milliseconds */
@@ -596,7 +596,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 		__field(unsigned long,	dirty_ratelimit)
 		__field(unsigned long,	task_ratelimit)
 		__field(unsigned long,	balanced_dirty_ratelimit)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -614,7 +614,7 @@ TRACE_EVENT(bdi_dirty_ratelimit,
 	TP_printk("bdi %s: "
 		  "write_bw=%lu awrite_bw=%lu dirty_rate=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
-		  "balanced_dirty_ratelimit=%lu cgroup_ino=%u",
+		  "balanced_dirty_ratelimit=%lu cgroup_ino=%lu",
 		  __entry->bdi,
 		  __entry->write_bw,		/* write bandwidth */
 		  __entry->avg_write_bw,	/* avg write bandwidth */
@@ -660,7 +660,7 @@ TRACE_EVENT(balance_dirty_pages,
 		__field(	 long,	pause)
 		__field(unsigned long,	period)
 		__field(	 long,	think)
-		__field(unsigned int,	cgroup_ino)
+		__field(ino_t,		cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -692,7 +692,7 @@ TRACE_EVENT(balance_dirty_pages,
 		  "bdi_setpoint=%lu bdi_dirty=%lu "
 		  "dirty_ratelimit=%lu task_ratelimit=%lu "
 		  "dirtied=%u dirtied_pause=%u "
-		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%u",
+		  "paused=%lu pause=%ld period=%lu think=%ld cgroup_ino=%lu",
 		  __entry->bdi,
 		  __entry->limit,
 		  __entry->setpoint,
@@ -718,10 +718,10 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -733,7 +733,7 @@ TRACE_EVENT(writeback_sb_inodes_requeue,
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(inode_to_wb(inode));
 	),
 
-	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%u",
+	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
@@ -789,13 +789,13 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 
 	TP_STRUCT__entry(
 		__array(char, name, 32)
-		__field(unsigned long, ino)
+		__field(ino_t, ino)
 		__field(unsigned long, state)
 		__field(unsigned long, dirtied_when)
 		__field(unsigned long, writeback_index)
 		__field(long, nr_to_write)
 		__field(unsigned long, wrote)
-		__field(unsigned int, cgroup_ino)
+		__field(ino_t, cgroup_ino)
 	),
 
 	TP_fast_assign(
@@ -811,7 +811,7 @@ DECLARE_EVENT_CLASS(writeback_single_inode_template,
 	),
 
 	TP_printk("bdi %s: ino=%lu state=%s dirtied_when=%lu age=%lu "
-		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%u",
+		  "index=%lu to_write=%ld wrote=%lu cgroup_ino=%lu",
 		  __entry->name,
 		  __entry->ino,
 		  show_inode_state(__entry->state),
@@ -845,7 +845,7 @@ DECLARE_EVENT_CLASS(writeback_inode_template,
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
-		__field(unsigned long,	ino			)
+		__field(	ino_t,	ino			)
 		__field(unsigned long,	state			)
 		__field(	__u16, mode			)
 		__field(unsigned long, dirtied_when		)
-- 
2.17.1

