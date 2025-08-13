Return-Path: <cgroups+bounces-9133-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB47B24CCF
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304EC1895040
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633A2F83AA;
	Wed, 13 Aug 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j9Pb+KuX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNKAacWJ"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023022BE7C3;
	Wed, 13 Aug 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755097202; cv=none; b=mNarCyaNdBSfF8P5vg01cxqkv7Ald4fECuz5ViMyxcmObQKtTRR8/ovSfkh3R2/pYwSnlYmiQGceNGEED0tyPlhHgukBZXweSvAfme7RcfXnGKVcjL+MQ+XB6gTUp0dR8DEqJZAqc9LE/0xzhPURP1Mp0xYieBbVE7jqM7y2bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755097202; c=relaxed/simple;
	bh=pTQBWOxYgQhk+BoQkUAnH1/ZqKl3sqMQ/v7cximXOZA=;
	h=From:To:Cc:MIME-Version:Content-Type:Subject:Date:Message-ID; b=fnBDjfmqkHJDq83NUD74flfuJxOOqGHQSQaCPP1iTzjo5D1TrYJIoGGI6ZkvaN2ofC/RE4wm+tPQ/NFOnRaZa3D3vfPhSzas1hk9liWDDfBkRkTbJZd+XG3ssnNN9VgMQ5LbzqmI7TGO96REmac+wYpi02NnwNSZvSJXPkOSLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j9Pb+KuX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNKAacWJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755097199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T/3FzEqj+EkRwMgr2W3oWcr9lCLmwSumjvYhh8G4h60=;
	b=j9Pb+KuXctvY2lTxSCAZnaN4GQGoc1+BorFUwisZCOVzGCJIL2lkY+/JlG6rj030lweA2R
	I8lUZqa0pzyNWRZL8oEsH4R29wTs7YGJ3dOW5ehZ81wxWqCVHQZAGpdrmbBNzs2oo4qMGm
	F/v0Xe67JW8iSDO4LuIBr6C2s5lIz6OfPIc0FA7LB42aC6AhO0ob30q1BkOZESlPl4lsXB
	RGCLsNCbdBhpTkimmsYfLBtKWA0oYq+2ELtMhLlxUnAuDJ/kzxqoi8v35gJH4pJVZAYGvU
	ZUsB8OQvIcS1cvqhY+QNe57CkicGan252Xq355yJN/lrxQlkF/L1MrEENzbHVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755097199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=T/3FzEqj+EkRwMgr2W3oWcr9lCLmwSumjvYhh8G4h60=;
	b=KNKAacWJ3+kT0844y5pZPtxbMDnzPfZo9nw/QM51NcL89DgDuuuk38wDtt4IiO2u1tS8X2
	eMSOTqiYPOfrjOCg==
To:linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>, Josef Bacik
 <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH] blkcg: Optimize exit to user space
Date: Wed, 13 Aug 2025 16:59:57 +0200
Message-ID: <87qzxf6zde.ffs@tglx>

blkcg uses TIF_NOTIFY_RESUME to handle throttling on exit to user
space. TIF_NOTIFY_RESUME is a multiplexing TIF bit, which is utilized by
other entities as well.

This results in a unconditional blkcg_maybe_throttle_current() call for
every invocation of resume_user_mode_work(), which is a pointless exercise
as most of the time there is no throttling work to do.

Optimize this by doing a quick check of the throttling condition before
invoking it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/blk-cgroup.c         |    4 ++--
 include/linux/blk-cgroup.h |   10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2001,7 +2001,7 @@ static void blkcg_maybe_throttle_blkg(st
 }
 
 /**
- * blkcg_maybe_throttle_current - throttle the current task if it has been marked
+ * __blkcg_maybe_throttle_current - throttle the current task if it has been marked
  *
  * This is only called if we've been marked with set_notify_resume().  Obviously
  * we can be set_notify_resume() for reasons other than blkcg throttling, so we
@@ -2010,7 +2010,7 @@ static void blkcg_maybe_throttle_blkg(st
  * to be called by people willy-nilly as it will actually do the work to
  * throttle the task if it is setup for throttling.
  */
-void blkcg_maybe_throttle_current(void)
+void __blkcg_maybe_throttle_current(void)
 {
 	struct gendisk *disk = current->throttle_disk;
 	struct blkcg *blkcg;
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -14,6 +14,7 @@
  * 	              Nauman Rafique <nauman@google.com>
  */
 
+#include <linux/sched.h>
 #include <linux/types.h>
 
 struct bio;
@@ -26,7 +27,14 @@ struct gendisk;
 extern struct cgroup_subsys_state * const blkcg_root_css;
 
 void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay);
-void blkcg_maybe_throttle_current(void);
+void __blkcg_maybe_throttle_current(void);
+
+static inline void blkcg_maybe_throttle_current(void)
+{
+	if (unlikely(current->throttle_disk))
+		__blkcg_maybe_throttle_current();
+}
+
 bool blk_cgroup_congested(void);
 void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css);
 void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);

