Return-Path: <cgroups+bounces-14049-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGw2FEv3l2ks+wIAu9opvQ
	(envelope-from <cgroups+bounces-14049-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:55:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07CF164D8D
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 06:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9F400300C0CF
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 05:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8A32E141;
	Fri, 20 Feb 2026 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zR6xDTLP"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396532FA32
	for <cgroups@vger.kernel.org>; Fri, 20 Feb 2026 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771566920; cv=none; b=G8RoOHk1UTByfM4d/pg51d3k2zYWib9eOOIYQsDLY0x7lUo1t5GxZ0/ImlIIQVL/DwJ2o9+RoUrqczH/VO1VgmtHr2ZrV93atgH1nBu8MpzHRlKU2BML2//HML9qYCGgMJG5Q+LYF45wRIzOstM19VycF5LirZzfbVFhv7sJVcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771566920; c=relaxed/simple;
	bh=yUmonH/CIzK5lTEiC0IVbnht7EAF3Vi0dnZPfCMsJ2Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WCyv6lfjj/ntfbAOJt0pl6GbUFfao/NNb4bBIziPftWTREtVT5cu8aGTC7o7KajRJYwrd60d/2oG65FQRqWypn4UeW23wtD/lUdtcyUSytbec4F9XHvGHc70J0Y9vRPmCElXEm41TnZ2hmAsP6FhBfZ3gLQDOHuYb6loEU1RpG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zR6xDTLP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tjmercier.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1236530a12.3
        for <cgroups@vger.kernel.org>; Thu, 19 Feb 2026 21:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771566918; x=1772171718; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZMtE/y1E7pRM+BgrGCWh1tlQyBGUgnD2quexZvuA3I=;
        b=zR6xDTLPIPyJj2ALo9HaoWuJs6szIUR+nw7pPRGuF1WpLcPk8rr+gjBHszKvgOwDDS
         5J2thD5hWM+ZTTf4OSQm9HHXsb0VlkjqmId4q83snqdN/xQRaaTwcZshS31qA4eRsrgi
         wU4B/xGC2OLSknGeix8ezWoR4h7rbKLFShQgQHLoM0T+Wha6tStVyWhXSXsrCvCFsLDi
         aNM0lHBpHipClhsx4YeeFho7V6/WKMy3V3S9BDX3zrDGarJe8SQXixmSGCQnxv64lJIr
         VboUZBfNEMKuZKR9spnhZk6zz847djmH3lmWDfxxwVl9qbIr9r/LGt/Q7WoTg8RBkjv2
         JhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771566918; x=1772171718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gZMtE/y1E7pRM+BgrGCWh1tlQyBGUgnD2quexZvuA3I=;
        b=uF4/hbi0FAqINuCwjw278hDJdZgsLytjcJqdK16nVCKe2z/N8B16RYrZFE2JRySNSO
         u0YDwsqnFAQ0tZRYbDNyQgRc/6nYj0+ZxajKaWM0XAdOVg2rrfY0ysidjiyClAbf6PUj
         mhCeSBddGffizKYFH86gGdD8xMM9vNDR97Gn39ZQkju1l0J0OVKMAfOOYjGigz5SBfPA
         SftIFrHY2SQUdKU/8EAjM+/MU6YZucogsleaw6Fo175okiw2IE+CPpZfaUoxtUGDTDsO
         ObzgI6B/ANVr3kKkztbKchiYj7C/wSoKgsMg0SF+AAJgTJhD/IVAoMQ3Q0VHwuXcwqFk
         90QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGTXKsrSWhJQ8Lhlq9ZqvZTolY+G11JbEsInPl60iu+EB7tFGE2O33vOqgRRP/eD9HDU7ReAui@vger.kernel.org
X-Gm-Message-State: AOJu0YzVAoQ294k1Ozbm5paodyTuvYgjIU4c4HcDMRQsTl8RckIKopRf
	aae5QQm8eGpoVM1GKW23vax6p24EoNegdOvcjSrKey31smcyzvdTfIK/vbRSt53s2qz+ANaG8we
	JQ9ZSoLNn4PMnrJChsg==
X-Received: from pgac4.prod.google.com ([2002:a05:6a02:2944:b0:c66:4148:f3f6])
 (user=tjmercier job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:918e:b0:38c:792:56b0 with SMTP id adf61e73a8af0-394839d9911mr18666582637.38.1771566917867;
 Thu, 19 Feb 2026 21:55:17 -0800 (PST)
Date: Thu, 19 Feb 2026 21:54:47 -0800
In-Reply-To: <20260220055449.3073-1-tjmercier@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260220055449.3073-1-tjmercier@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260220055449.3073-3-tjmercier@google.com>
Subject: [PATCH v4 2/3] kernfs: Send IN_DELETE_SELF and IN_IGNORED
From: "T.J. Mercier" <tjmercier@google.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, amir73il@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc: "T.J. Mercier" <tjmercier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14049-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,lists.linux.dev,vger.kernel.org,suse.cz,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: F07CF164D8D
X-Rspamd-Action: no action

Currently some kernfs files (e.g. cgroup.events, memory.events) support
inotify watches for IN_MODIFY, but unlike with regular filesystems, they
do not receive IN_DELETE_SELF or IN_IGNORED events when they are
removed. This means inotify watches persist after file deletion until
the process exits and the inotify file descriptor is cleaned up, or
until inotify_rm_watch is called manually.

This creates a problem for processes monitoring cgroups. For example, a
service monitoring memory.events for memory.high breaches needs to know
when a cgroup is removed to clean up its state. Where it's known that a
cgroup is removed when all processes die, without IN_DELETE_SELF the
service must resort to inefficient workarounds such as:
  1) Periodically scanning procfs to detect process death (wastes CPU
     and is susceptible to PID reuse).
  2) Holding a pidfd for every monitored cgroup (can exhaust file
     descriptors).

This patch enables IN_DELETE_SELF and IN_IGNORED events for kernfs files
and directories by clearing inode i_nlink values during removal. This
allows VFS to make the necessary fsnotify calls so that userspace
receives the inotify events.

As a result, applications can rely on a single existing watch on a file
of interest (e.g. memory.events) to receive notifications for both
modifications and the eventual removal of the file, as well as automatic
watch descriptor cleanup, simplifying userspace logic and improving
efficiency.

There is gap in this implementation for certain file removals due their
unique nature in kernfs. Directory removals that trigger file removals
occur through vfs_rmdir, which shrinks the dcache and emits fsnotify
events after the rmdir operation; there is no issue here. However kernfs
writes to particular files (e.g. cgroup.subtree_control) can also cause
file removal, but vfs_write does not attempt to emit fsnotify events
after the write operation, even if i_nlink counts are 0. As a usecase
for monitoring this category of file removals is not known, they are
left without having IN_DELETE or IN_DELETE_SELF events generated.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: T.J. Mercier <tjmercier@google.com>
---
 fs/kernfs/dir.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5b6ce2351a53..41541b969fb2 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1471,6 +1471,23 @@ void kernfs_show(struct kernfs_node *kn, bool show)
 	up_write(&root->kernfs_rwsem);
 }
 
+static void kernfs_clear_inode_nlink(struct kernfs_node *kn)
+{
+	struct kernfs_root *root = kernfs_root(kn);
+	struct kernfs_super_info *info;
+
+	lockdep_assert_held_read(&root->kernfs_supers_rwsem);
+
+	list_for_each_entry(info, &root->supers, node) {
+		struct inode *inode = ilookup(info->sb, kernfs_ino(kn));
+
+		if (inode) {
+			clear_nlink(inode);
+			iput(inode);
+		}
+	}
+}
+
 static void __kernfs_remove(struct kernfs_node *kn)
 {
 	struct kernfs_node *pos, *parent;
@@ -1479,6 +1496,7 @@ static void __kernfs_remove(struct kernfs_node *kn)
 	if (!kn)
 		return;
 
+	lockdep_assert_held_read(&kernfs_root(kn)->kernfs_supers_rwsem);
 	lockdep_assert_held_write(&kernfs_root(kn)->kernfs_rwsem);
 
 	/*
@@ -1522,9 +1540,11 @@ static void __kernfs_remove(struct kernfs_node *kn)
 			struct kernfs_iattrs *ps_iattr =
 				parent ? parent->iattr : NULL;
 
-			/* update timestamps on the parent */
 			down_write(&kernfs_root(kn)->kernfs_iattr_rwsem);
 
+			kernfs_clear_inode_nlink(pos);
+
+			/* update timestamps on the parent */
 			if (ps_iattr) {
 				ktime_get_real_ts64(&ps_iattr->ia_ctime);
 				ps_iattr->ia_mtime = ps_iattr->ia_ctime;
@@ -1553,9 +1573,11 @@ void kernfs_remove(struct kernfs_node *kn)
 
 	root = kernfs_root(kn);
 
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 	__kernfs_remove(kn);
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 }
 
 /**
@@ -1646,6 +1668,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	bool ret;
 	struct kernfs_root *root = kernfs_root(kn);
 
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 	kernfs_break_active_protection(kn);
 
@@ -1675,7 +1698,9 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 				break;
 
 			up_write(&root->kernfs_rwsem);
+			up_read(&root->kernfs_supers_rwsem);
 			schedule();
+			down_read(&root->kernfs_supers_rwsem);
 			down_write(&root->kernfs_rwsem);
 		}
 		finish_wait(waitq, &wait);
@@ -1690,6 +1715,7 @@ bool kernfs_remove_self(struct kernfs_node *kn)
 	kernfs_unbreak_active_protection(kn);
 
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 	return ret;
 }
 
@@ -1716,6 +1742,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	root = kernfs_root(parent);
+	down_read(&root->kernfs_supers_rwsem);
 	down_write(&root->kernfs_rwsem);
 
 	kn = kernfs_find_ns(parent, name, ns);
@@ -1726,6 +1753,7 @@ int kernfs_remove_by_name_ns(struct kernfs_node *parent, const char *name,
 	}
 
 	up_write(&root->kernfs_rwsem);
+	up_read(&root->kernfs_supers_rwsem);
 
 	if (kn)
 		return 0;
-- 
2.53.0.414.gf7e9f6c205-goog


