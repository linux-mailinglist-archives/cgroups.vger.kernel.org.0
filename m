Return-Path: <cgroups+bounces-6353-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E99A20655
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AD537A4472
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 08:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783CD1E009F;
	Tue, 28 Jan 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GKESxpaf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ciei6yNc"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF65F1DF997;
	Tue, 28 Jan 2025 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053762; cv=none; b=dzGofJdyxejUo01yB67DvsOkVAHqGQiUfrfJK+H9+JyOZQ21MS2BLppXoYBE1zlqQq41wZWC9StSQ1Vnh62HZrHbUUnv3Vr8rAkY+yr9FerEHrgCf/JevEXXX9iThv4IZWCoZhyeH6SjUIW7E/31XhTQ53cfhmr1jzVzmcXeJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053762; c=relaxed/simple;
	bh=tR45VY94czRZPH94WmhYPOQ1mLEIOTHPhxsX88grZxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NufsLL37YUGHpNX8HEz07bv6MMHfm7Q6JZw87zdIBi7Ihj4WMs3FbGFTzV8dcipnlKUSAKH0E0guqeA8DLhxaFy7pGUsoBCMwWQBAM2wGMYAVVQwvdevY7OrXjJXJD7AAmdqHyZyzO09ZIyjc5AjGezksBT+9xJK8neF7cnej4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GKESxpaf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ciei6yNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738053758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHJX6bEa0XtyQR0u+s3KZKeiU8ZuhShX3XwcYletJb0=;
	b=GKESxpafRsgm7IButNytWF04BcV6DnCs/5V2lHp313vJx0AMJ9oDsCIR8blzhQTmWnZfSd
	qDF1N5DFIYc2YrXogFVkFTnzsdrpbxRagTdtlsJ+xr+IQr9kZ6GHhuYfct9Rm6AwOsWhPc
	eDRGnQpRLq6EFgU4bRnUgbN+6fwjyd94tiV17SYaxK1DDqOlOq11YZxUsKayhBwR6grJth
	PeqKwD8Wib1BfiarmNUJunDpwthI7PH7VcsJyOgJ7FGihoD/+MM+OPPphr5hJOmV8b54Nn
	h+KzX8XbZGjehB8i2lt0mB5V8g9TK2Zn4EJ4GunVccbNNXP/NUgGCOZf9v2ekA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738053758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jHJX6bEa0XtyQR0u+s3KZKeiU8ZuhShX3XwcYletJb0=;
	b=ciei6yNcXBLnhB9mBSfCrvcJCLLx1xOIptlZhPhp09Jh/Q/t/Kfqc6V59Fl9bw5hiqjqVH
	Ug7knbuQGsHZppDg==
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
Subject: [PATCH v5 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Tue, 28 Jan 2025 09:42:24 +0100
Message-ID: <20250128084226.1499291-5-bigeasy@linutronix.de>
In-Reply-To: <20250128084226.1499291-1-bigeasy@linutronix.de>
References: <20250128084226.1499291-1-bigeasy@linutronix.de>
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
index 458519e416fe7..5a1fea414996e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1868,10 +1868,10 @@ static int kernfs_fop_readdir(struct file *file, st=
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


