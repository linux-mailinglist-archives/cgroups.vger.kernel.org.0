Return-Path: <cgroups+bounces-6418-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8492BA25B5D
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CACA43A6576
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406C52066CE;
	Mon,  3 Feb 2025 13:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1NVL9XY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyLpTbQ1"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F6205E06;
	Mon,  3 Feb 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590635; cv=none; b=mjxIHXM714BNc2w3uIhejtnFZ9jdIzDWP+tgyaQrdeBOod29rxXr4eTFKJSbsFFqbC26f1Gh4pZ7Y6QYNU8KODIbhtKSyZR3DvXcmRGWm0NTv2NffdP2cpfOJ8BoTmAY5iTEaoSKTd28V6S459hP54hjAcHqo5elq5209sHwI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590635; c=relaxed/simple;
	bh=jRtxnvMKTrmUneuXhzp9bSsgkfIudGb2kb3B0g27mE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfHCbn+gfEOusLdfX/ifyzG5qkrHDqL2ErOSg1QPnxv9M8xfkwBGrvUgjkqH0g7Kzy9F26+W+5sZNxegmqqGB10fLACTA+hQsdid6e/T566lkQmsBzO5ftf1Zxvyz16O9ISl/rSzMtK1EESw8b39TWnn4XPPwLcNLxcRaT0u1wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1NVL9XY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyLpTbQ1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRIhg8vdo/wvsNrZnYDJtZOogVWqQ5PCr1FBg/yMGAA=;
	b=Y1NVL9XY2i0CaxZ2YZJ/0CPwMcFSZhgB5nn7cYVCGjKehXFnbQ8JIN1ODcdgO0yukj99qz
	PyioV9bZqrlcAfaskT0o2NqrX0D5bf/4N/mDvSHW+DwSGTN+4wc6pHwc+uCMDFOwksT5xC
	Vj3FCPY/opOFSFJXIXRE8nrYQBwb+vL3ly6zV4FxPU/p4/X1dw/PkNxlB6BtGgg2Ax7HCR
	Qer9uzCnGDz2oePTa8DXg83v/ja9fIOauqgBhNNz21RtRSYYzDSnSpirEYR8DV85/XinIw
	X+9gV4hMzYj24sUY4++22AH5a8Zg7Ka36Bvk+LlcXJlL2pkq4Np6BFLWWRxDhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRIhg8vdo/wvsNrZnYDJtZOogVWqQ5PCr1FBg/yMGAA=;
	b=JyLpTbQ14mYkwd11LFoQL9LQynGrdxu+m8UM+TgXilxBdfNbkNaY60kXxmG3pw1CVXhB2y
	OR6KQhNg846zl4Ag==
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
Subject: [PATCH v7 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Mon,  3 Feb 2025 14:50:21 +0100
Message-ID: <20250203135023.416828-5-bigeasy@linutronix.de>
In-Reply-To: <20250203135023.416828-1-bigeasy@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
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


