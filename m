Return-Path: <cgroups+bounces-6544-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09697A3441D
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1DF2188EB9D
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111671EEA36;
	Thu, 13 Feb 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCR3NFgU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tx8EUuYw"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4E16D4E6;
	Thu, 13 Feb 2025 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458232; cv=none; b=uQp9ar3f+f7cquoOkNt2T20ipAIqKSLTG0ORM8oAXPB3MKuPhykZ4sQdXFhOlIfVDOqO033mzLMgIfW22C3+4NtmWssDdQFW9vTHM7sW+ne1jaxPKYCouqZ27oQKWdVjMywE98LFWmvggyuhUL92fZUiothIUfXLUBXUsnvqzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458232; c=relaxed/simple;
	bh=jRtxnvMKTrmUneuXhzp9bSsgkfIudGb2kb3B0g27mE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t6OY8UoLNOTmtic/TLSIW2uS24PX1hD78dQxndzqNd7safdDapjYQrMA4bUhZDZ6W2zxkY43g3ptaI6RbvPJtbqAjBGPM8rjN5CiaTBdAP+sCSycFT0suhZCRp87DPxqlMERwvx4s2ofozw84rZtU7TTEesKzqulzxHA0d2vyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCR3NFgU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tx8EUuYw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRIhg8vdo/wvsNrZnYDJtZOogVWqQ5PCr1FBg/yMGAA=;
	b=aCR3NFgUuNpxvz+xEVCLIoMTkAxiIqT4qkMcNHCT0q3Tk3BiUnwUgO//AISqvEXYG4+O+r
	QCoZaBDY7Zu6b45vBVX6jbTWHXWbvnsD7iwGTetddq8NpaTNuTw2hM+dojpuhI1o3MA5ku
	ZcKrHYudryzg9S4+27rxS90tDI3YWmWwaxq4sLg+96rn6gFuYAWcOW29SN/qMjO/31ulc2
	cwXhul2w426uAc2kOLxc0EFLMPAFzppPq9Ovxzn29hrhEn9hSSKpbsQdKR22Rn2Mlpi5O5
	N0zYETTxbk9nglH5z3qfTWYkHudCHMpGYcukKvazZHFIYLtjCtTltGIqqh+ILg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739458228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRIhg8vdo/wvsNrZnYDJtZOogVWqQ5PCr1FBg/yMGAA=;
	b=Tx8EUuYwwK7FWHWiz27fLuD9BA23d1hOd6Ilu6nNrmgQd3M39ym/0SqGBMUQT0XkGLg/o2
	BTavxQLZLqoN/cCg==
To: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hillf Danton <hdanton@sina.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Elver <elver@google.com>,
	Tejun Heo <tj@kernel.org>,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v8 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Thu, 13 Feb 2025 15:50:21 +0100
Message-ID: <20250213145023.2820193-5-bigeasy@linutronix.de>
In-Reply-To: <20250213145023.2820193-1-bigeasy@linutronix.de>
References: <20250213145023.2820193-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The readdir operation iterates over all entries and invokes dir_emit()
for every entry passing kernfs_node::name as argument.
Since the name argument can change, and become invalid, the
kernfs_root::kernfs_rwsem lock should not be dropped to prevent renames
during the operation.

The lock drop around dir_emit() has been initially introduced in commit
   1e5289c97bba2 ("sysfs: Cache the last sysfs_dirent to improve readdir sc=
alability v2")

to avoid holding a global lock during a page fault. The lock drop is
wrong since the support of renames and not a big burden since the lock
is no longer global.

Don't re-acquire kernfs_root::kernfs_rwsem while copying the name to the
userpace buffer.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 5f0f8b95f44c0..43fbada678381 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1869,10 +1869,10 @@ static int kernfs_fop_readdir(struct file *file, st=
ruct dir_context *ctx)
 		file->private_data =3D pos;
 		kernfs_get(pos);
=20
-		up_read(&root->kernfs_rwsem);
-		if (!dir_emit(ctx, name, len, ino, type))
+		if (!dir_emit(ctx, name, len, ino, type)) {
+			up_read(&root->kernfs_rwsem);
 			return 0;
-		down_read(&root->kernfs_rwsem);
+		}
 	}
 	up_read(&root->kernfs_rwsem);
 	file->private_data =3D NULL;
--=20
2.47.2


