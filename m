Return-Path: <cgroups+bounces-13921-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHWEExdNjmkaBgEAu9opvQ
	(envelope-from <cgroups+bounces-13921-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:58:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08445131696
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 22:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEAA73010603
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 21:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45FD35DD19;
	Thu, 12 Feb 2026 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WXnY8bkK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E5B35E556
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770933516; cv=none; b=c7Tj8+FlY7ytkzQESc3LbXz/JYYU2bpN/CpLpVIqI5WmxBBtV6K0n1L+ylkfaQob5SSujkCWYt2Y3mwMmDxHdKgft5k6gJRqY50iOYeOAjxpJEvM1jqh5qKNV3Z8aYvalTYLpAahYzUFy2Epre6JL10+SlnCOvRXzPeuNVf5O1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770933516; c=relaxed/simple;
	bh=JZj4LpEl8D/f9PumooC8+GYc0Dg8nxxVo/kQgge2600=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fuPfhfaIf0/7jyyNGO3ZxbxVTeQP9Xzcnh50qbv4wNRpJyqkW8+IpmE0sajvY6rbjDBPFCR5E+ipG35eXmkY3Dqx1z13D3OWCqRYuVTKIxd5FmPUlhP87aAbibNmg3B8dJy7RuHfzY9kGGjDQ/dLNEsFKq88uctBBh4VxM4Bae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WXnY8bkK; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354c7a38429so1791262a91.0
        for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 13:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770933515; x=1771538315; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ajT1DeXeAjXwu6HaXbFv5+sD4L7P9mYZ5NNigjqhjfQ=;
        b=WXnY8bkKdBf5dKEscJFH2TB+k5QETGokMg0QvFEedO2G5/puiVWwC6Hy5Ld1zCDKrw
         Iu+5G1LG8Pi6fVO0FRyoNwWonRTzzFsL0PLEIEC7uOZ9MJrG1L0fKgHEJ1KVkRNXDLue
         lrcQGHd/IsSmFSA33wiYTWFZMTh4e1FyAztXCJDVLD6mAA6IBtx6QHgK9RpTlcxdaIi1
         ESCAjOp66gX2Yml+fDvOOM7JG2Y36+TSeqHxDDu6sreMYn3l2/hZyw28iv0NsF+wn5nL
         EX+4cTWC39dp/LCm4fEJLVUQXevKc85fErseWVGkEkYoWXSianGd5qu519EGQRvb+vDI
         2P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770933515; x=1771538315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ajT1DeXeAjXwu6HaXbFv5+sD4L7P9mYZ5NNigjqhjfQ=;
        b=vWoCwzHlOk0HeMckRRss6gRADtSdK97yPxQf9xp+NACd5XYRHbfE5P9uGWzcwMuKQn
         KcjmUI5Ln1WDURha8vJaOtefYWrHwz2A4Twqkx6neKnpxI5xBmJB+roKsW12zD7oPFA1
         004d090Puat4nk0v4GeaNr6q5Kdn+Mzw12u7qrG+aDsVZB3ui5joQo9zTtFbBggIxS91
         i8cwZpYaB0UWRy8mOGBX4TvtiLb4akF6YiXMJNEgbW6yKwD2CseDpl1aRdzonxbEe8bN
         mJ0XFE1vBlQmThuQFfZi1D4XHOkbtGpA6A2WQS32SW6JALrkAQzdclrPRl+aVRWxc8DQ
         Hv2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJ/77FIWgqTp416SiyDRUmdrhgLWcf2zRAphU20XnznKbjfNUB2gj+E/4xJ4qmLOYiTKm2lmX4@vger.kernel.org
X-Gm-Message-State: AOJu0YwWTx7AInvw5ovn9z4TWWK4Ex2rERHUdmd7KrHliOYdkTJcEK3l
	kBxfhE3A/ckhy9PzY5KOx/BzM/RFYYV+xPxMKxEgofFSL67T4lkstX8aigEyDftPsPLPNsnSjTc
	KQ9D7Cyr1JqJla2DXCQ==
X-Received: from ploe4.prod.google.com ([2002:a17:903:2404:b0:2a0:f5f5:419d])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:b598:b0:394:4d99:ff56 with SMTP id adf61e73a8af0-394669e12eamr341305637.11.1770933514447;
 Thu, 12 Feb 2026 13:58:34 -0800 (PST)
Date: Thu, 12 Feb 2026 13:58:13 -0800
In-Reply-To: <20260212215814.629709-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260212215814.629709-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260212215814.629709-3-tjmercier@google.com>
Subject: [PATCH v2 2/3] kernfs: send IN_DELETE_SELF and IN_IGNORED on file deletion
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13921-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,memory.events:url]
X-Rspamd-Queue-Id: 08445131696
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
 fs/kernfs/file.c            | 16 ++++++++++------
 fs/kernfs/kernfs-internal.h |  3 +++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 29baeeb97871..e5bda829fcb8 100644
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
 
+			if (kernfs_type(pos) == KERNFS_FILE)
+				kernfs_notify_file_deleted(pos);
+
 			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index e978284ff983..2d21af3cfcad 100644
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
@@ -909,7 +909,7 @@ static loff_t kernfs_fop_llseek(struct file *file, loff_t offset, int whence)
 	return ret;
 }
 
-static void kernfs_notify_workfn(struct work_struct *work)
+void kernfs_notify_workfn(struct work_struct *work)
 {
 	struct kernfs_node *kn;
 	struct kernfs_super_info *info;
@@ -959,15 +959,19 @@ static void kernfs_notify_workfn(struct work_struct *work)
 			if (p_inode) {
 				fsnotify(notify_event | FS_EVENT_ON_CHILD,
 					 inode, FSNOTIFY_EVENT_INODE,
-					 p_inode, &name, inode, 0);
+					 p_inode, &name,
+					 (notify_event == FS_MODIFY) ?
+						inode : NULL, 0);
 				iput(p_inode);
 			}
 
 			kernfs_put(parent);
 		}
 
-		if (!p_inode)
-			fsnotify_inode(inode, notify_event);
+		if (notify_event == FS_DELETE)
+			fsnotify_inoderemove(inode);
+		else if (!p_inode)
+			fsnotify_inode(inode, FS_MODIFY);
 
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
2.53.0.273.g2a3d683680-goog


