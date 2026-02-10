Return-Path: <cgroups+bounces-13819-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNEXOCp+imnVLAAAu9opvQ
	(envelope-from <cgroups+bounces-13819-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:39:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CA115AF4
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 01:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 761EC302D94F
	for <lists+cgroups@lfdr.de>; Tue, 10 Feb 2026 00:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDC825DB12;
	Tue, 10 Feb 2026 00:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IA+IiOz0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F823507B
	for <cgroups@vger.kernel.org>; Tue, 10 Feb 2026 00:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770683913; cv=none; b=K4V06tp3z/5mWd64BBNNfMubzwkS9tkdcs6TbrtYkfQPmvd4/L2aouU70lKKGY9cthW/yRaCCehqw0cYQMf7SjnaEbUXp7RH+tPCX9Ue7jBkjp2lgSriERIsiQJ5a6L6hylVQDbEjqouwnpMHsi9BAcmSVwMBLHpghEL+KdPL/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770683913; c=relaxed/simple;
	bh=teigoZqI95reTfkorAH782wxQYo6YePSlVBSeRHPhoo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ncxmUmNrTcwXfaaLFhgK3Gjl2eH7UfOhjNlVlQ4QFOuWwPSc1ccrTx1oYySHn/5WA+PhxWOPr5nyMOEhUr4pr9IUZXCSkQE2RZfJbLhEwMmAV0j8/Im+1cFkW3fhnnTyMV9TBTScT09laF058xG0F4wK8gTVMuqNgGqAT6AjiZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IA+IiOz0; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c6ddf336128so603981a12.1
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 16:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770683912; x=1771288712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKFhdZVLSybbb15qv/W0122KHQjxioqzTfb665HUCmk=;
        b=IA+IiOz046lBTzloYQ70v8VLS+rvP34AZ8k2MOTtoelZjufTSF5vPom5MfIsp6aNHP
         bd3F1S9gElEU77uSnHdfhasOGwyPnWBUlt72auOnaJV9aJWtBtiTp8ZcUrqMz1ZsGh8b
         wC4AptnNIVL8fPjfr2+jl5FmaV76i1RPciKCBDdtZ9YzH67jK2o0GONCHDwptc5i42jm
         6YIyMf8Wkm+k/is05jT1GOww3NAxegXQKMvmj5faF5C1i2T7YO3Q7g3yXAgJqXHiJF4m
         cjZFMWVFC0j8VyS8rL4GWidB3TFb6yjcE4BfTPXORDAaXgQw9nabFbZ18hMRTgrdtnIq
         T3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770683912; x=1771288712;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKFhdZVLSybbb15qv/W0122KHQjxioqzTfb665HUCmk=;
        b=gvW6A0Yuiv6vcHoTqsKkl8Z8ElqpFzm/7Rk5Hxatgw5tZyJUXOra+uq/cdgKacIaaa
         wHfGzTbmR6dxpZbnSzJmUD122zGkTKppdTulA/kr50l0AQjLZprLe94vtQAOpnAvL5ax
         TnJEI+WURfw2BiiP8aC83ez5BF2l5izUCLFrsfKuYf5OgnQWJ+uIUyk+qiDJ5TLDB+94
         siHV+L0J2Erpn1FaEcvVNvqPWgiLTqek5YTIsrTWTt+WSdxWLGNdPrJOR1Imz6KSPyF5
         Nu/hM8VxkhIQedugjKX/CTsti/XsHfg+BXlLmox7eFZg3+pRMUlAUO+1p3ljPznOpNI9
         4Rqg==
X-Forwarded-Encrypted: i=1; AJvYcCUn/LCNvp/qGFcbR2TCy/Si9ZY5y4bVF+nbfgIjVZaGHOPT+Q9jzqlz2R+9xWeRjXIBB8kfePtm@vger.kernel.org
X-Gm-Message-State: AOJu0YznqdtVPw1rv4pO8G9fImqrqeho4e2kV9PtKXBf+tLsHre4yIDR
	JNzdfiAfk8NF4qD3/BbiyCcrpTKKiapHkI2SPIj1u6hSzF1qBNOwVm89+kc0UPYjFhA1OmKb/dW
	iiY2p9ks5loRYpkbgOg==
X-Received: from pfbna12.prod.google.com ([2002:a05:6a00:3e0c:b0:81f:b161:df0e])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1a1a:b0:823:1392:ba5d with SMTP id d2e1a72fcca58-824416f8de9mr9591003b3a.38.1770683911999;
 Mon, 09 Feb 2026 16:38:31 -0800 (PST)
Date: Mon,  9 Feb 2026 16:38:00 -0800
In-Reply-To: <20260210003801.2834976-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260210003801.2834976-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210003801.2834976-3-tjmercier@google.com>
Subject: [PATCH 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13819-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: 652CA115AF4
X-Rspamd-Action: no action

Currently some kernfs files (e.g. cgroup.events, memory.events) support
inotify watches for IN_MODIFY, but unlike with regular filesystems, they
do not receive IN_DELETE_SELF or IN_IGNORED events when they are
removed.

This creates a problem for processes monitoring cgroups. For example, a
service monitoring memory.events for memory.high breaches needs to know
when a cgroup is removed to clean up its state. Where it's known that a
cgroup is removed when all processes die, without IN_DELETE_SELF the
service must resort to inefficient workarounds such as:
1.  Periodically scanning procfs to detect process death (wastes CPU and
    is susceptible to PID reuse).
2.  Placing an additional IN_DELETE watch on the parent directory
    (wastes resources managing double the watches).
3.  Holding a pidfd for every monitored cgroup (can exhaust file
    descriptors).

This patch enables kernfs to send IN_DELETE_SELF and IN_IGNORED events.
This allows applications to rely on a single existing watch on the file
of interest (e.g. memory.events) to receive notifications for both
modifications and the eventual removal of the file, as well as automatic
watch descriptor cleanup, simplifying userspace logic and improving
resource efficiency.

Implementation details:
The kernfs notification worker is updated to handle file deletion.
fsnotify handles sending MODIFY events to both a watched file and its
parent, but it does not handle sending a DELETE event to the parent and
a DELETE_SELF event to the watched file in a single call. Therefore,
separate fsnotify calls are made: one for the parent (DELETE) and one
for the child (DELETE_SELF), while retaining the optimized single call
for MODIFY events.

Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/kernfs/dir.c             | 21 +++++++++++++++++++++
 fs/kernfs/file.c            | 29 +++++++++++++++++++++++------
 fs/kernfs/kernfs-internal.h |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..74a4c347b78a 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/fsnotify_backend.h>
 #include <linux/namei.h>
 #include <linux/idr.h>
 #include <linux/slab.h>
@@ -1471,6 +1472,23 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 	up_write(&root->kernfs_rwsem);
 }
 
+static void kernfs_notify_file_deleted(struct kernfs_node *kn)
+{
+	static DECLARE_WORK(kernfs_notify_deleted_work,
+			    kernfs_notify_workfn);
+
+	guard(spinlock_irqsave)(&kernfs_notify_lock);
+	/* may overwite already pending FS_MODIFY events */
+	kn->attr.notify_event = FS_DELETE;
+
+	if (!kn->attr.notify_next) {
+		kernfs_get(kn);
+		kn->attr.notify_next = kernfs_notify_list;
+		kernfs_notify_list = kn;
+		schedule_work(&kernfs_notify_deleted_work);
+	}
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos, *parent;
@@ -1520,6 +1538,9 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			struct kernfs_iattrs *ps_iattr =
 				parent ? parent->iattr : NULL;
 
+			if (kernfs_type(kn) == KERNFS_FILE)
+				kernfs_notify_file_deleted(pos);
+
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e978284ff983..3e813b09ab05 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -37,8 +37,8 @@ struct kernfs_open_node {
  */
 #define KERNFS_NOTIFY_EOL			((void *)&kernfs_notify_list)
 
-static DEFINE_SPINLOCK(kernfs_notify_lock);
-static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
+DEFINE_SPINLOCK(kernfs_notify_lock);
+struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
@@ -909,12 +909,21 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 	return ret;
 }
 
-static void kernfs_notify_workfn(struct work_struct *work)
+static int fsnotify_self_event(int event)
+{
+	if (event == FS_DELETE)
+		return FS_DELETE_SELF;
+
+	return event;
+}
+
+void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
 	struct kernfs_root *root;
 	u32 notify_event;
+	u32 self_event;
 repeat:
 	/* pop one off the notify_list */
 	spin_lock_irq(&kernfs_notify_lock);
@@ -929,6 +938,8 @@ static void kernfs_notify_workfn(struct work_struct *work)
 	kn->attr.notify_event = 0;
 	spin_unlock_irq(&kernfs_notify_lock);
 
+	self_event = fsnotify_self_event(notify_event);
+
 	root = kernfs_root(kn);
 	/* kick fsnotify */
 
@@ -959,15 +970,21 @@ static void kernfs_notify_workfn(struct work_struct *work)
 			if (p_inode) {
 				fsnotify(notify_event | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE,
-					 p_inode, &name, inode, 0);
+					 p_inode, &name,
+					 (notify_event == self_event) ?
+						inode : NULL, 0);
 				iput(p_inode);
 			}
 
 			kernfs_put(parent);
 		}
 
-		if (!p_inode)
-			fsnotify_inode(inode, notify_event);
+		if (!p_inode || self_event != notify_event)
+			fsnotify_inode(inode, self_event);
+
+		/* For IN_IGNORED, and automatic watch descriptor removal */
+		if (self_event == FS_DELETE_SELF)
+			fsnotify_inode_delete(inode);
 
 		iput(inode);
 	}
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 6061b6f70d2a..cf4b21f4f3b6 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -199,6 +199,8 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
  * file.c
  */
 extern const struct file_operations kernfs_file_fops;
+extern struct kernfs_node *kernfs_notify_list;
+extern void kernfs_notify_workfn(struct work_struct *work);
 
 bool kernfs_should_drain_open_files(struct kernfs_node *kn);
 void kernfs_drain_open_files(struct kernfs_node *kn);
@@ -212,4 +214,5 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+extern spinlock_t kernfs_notify_lock;
 #endif	/* __KERNFS_INTERNAL_H */
-- 
2.53.0.rc2.204.g2597b5adb4-goog


