Return-Path: <cgroups+bounces-6277-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4373AA1BBA9
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26F316B226
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E921A94F;
	Fri, 24 Jan 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZgOzCm4y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Ld2lZI7"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6731D288B1;
	Fri, 24 Jan 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740783; cv=none; b=t/AOVL32GEvLul2Lemrf+de5GzgGtCgsiv2pEBkHWZxZx1vF28ggV1SDabbKqm0wc3NUNaRaxbS4smvfyWNOiuWUwNMvTpi2h2MKWU0zBHAvEnvAay/louc3x7ESOEzBVIW2xMsTXeekTsM2hFzmZSoLD9Agi28X+LhT3qexpqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740783; c=relaxed/simple;
	bh=sKP9Ovfv8owaH3FMoRK2FJ++2Xzo4d5YAtPLrdPczeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVpJVATQGIc+HUaLMfW23ukDbd6Jd6bw3jSEAv13cdupffNav9ct5y9/Rj0SVvpBBhenuIyYSMbmiPsTwEBH0VL73nVMqJqeHfmxgKL5+j81e2fzMOTqtiZHl1BljniIMTQdV39vSyAinOWjD5GaQZguKxnErnfwYf9vMaAvyYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZgOzCm4y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Ld2lZI7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3Q1+Vvwb4kp5dejcmCieETsMwqGy3zcbxn14JV9LZw=;
	b=ZgOzCm4yb++y48a16IDgciHYa7APEkowJ4IbmWGXd/7HIAnYUNiCdXvkb7+7ap2gBZtzYE
	uemWI9RKUQFOdTpvjT8p+v1deGynnEvmmw2/V6lDMBWjdktuGJ+qNNJiSO2wBm25gKB8WB
	GIp260d6eLWQc5Ia5Sa57HJfUz0AwbL0vPVUcSF8xr/FrDzHpROi7tuWM5xGMVMDb97tnh
	8st0yAWDCfgXdPmivoqUIG5U6tVeWwRZQbs1Ezhn9QKMN7bT5t5/M8il7N438knQCJGqvq
	x+jtbzi+ulqhKQUugYapG80+dQoFYaMwxvxCnKztcpr5uqD4GwSi1x7Dp4SDag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3Q1+Vvwb4kp5dejcmCieETsMwqGy3zcbxn14JV9LZw=;
	b=6Ld2lZI7Wrp87/fv7D6hV8pxeuEO2k2Ln1dBFmTSSmwlXcoTTWSzb8K9GKUB0ES6zomRBs
	aNKGwrWqahzSKcBA==
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
	Zefan Li <lizefan.x@bytedance.com>,
	tglx@linutronix.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 4/6] kernfs: Don't re-lock kernfs_root::kernfs_rwsem in kernfs_fop_readdir().
Date: Fri, 24 Jan 2025 18:46:12 +0100
Message-ID: <20250124174614.866884-5-bigeasy@linutronix.de>
In-Reply-To: <20250124174614.866884-1-bigeasy@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
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


