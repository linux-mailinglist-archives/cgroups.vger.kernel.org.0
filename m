Return-Path: <cgroups+bounces-6416-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C87BA25B59
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C941883477
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5078B2063DA;
	Mon,  3 Feb 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P23h3z9l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qErgRXyT"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A545E2063C0;
	Mon,  3 Feb 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590634; cv=none; b=XqA/48SXj9Q33ZDVxacSMyOvvpstpWEbWs8kyZqECKl1UIk+ydGeRTWse4iUXpgrlSZsRA1D1DRCFZl1YY+TNyQXWro7HHIwGAQscmJpBivqb5ZVK60RPAsojkchkNlZK4NWPyiINsVunT603gclIsy5xI0KoFgT+851mT61QwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590634; c=relaxed/simple;
	bh=DGTpLamWHUkgj5xFOJwd0o2/wv8b1YO9QjSjYXScsrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm9SNQ8W5U6Mp46H2CCtapFKwbuxGAms0Cs7sNQvPejw++IPairOih+y75T7m9acekLUvFqr3t3v7ZY6aELD05aCQRj1TOS2Lft3VuLLj/Vo+MRRtWQhcfmB1uCqOYQa/IRi83J9ort/U0m9fG9KYKGfaZy8KeHkMjx22j8Z1tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P23h3z9l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qErgRXyT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=P23h3z9ljOr48rWq8a0Gi7GtWr7cw7+7CPgf3cWKnFrdjEZxQC5yoQcMHfteUcEm0FQM3h
	sKlwbFmE/7Jho3BV4ECSxpCwDclwSUGDQw7dAkyA71GaBX+cfjL2jAZBMxoym+VMVmZJrJ
	d/DSe156V8+or3zsiuulN+VsCNDGHDr/QNvtBq90EOy40g1bP59c2v5nt/zFpNuvuIPjF3
	mwvWOba3kSbg0Lsb3g56UzivRr0CPb2esiuVH81emHiVVui7SHLPs/uPF8Ap0G0BObfMr9
	TZKpYXjpJlGP53r1xshJdCteIqIgBFnnUXPstRUA0NZzf9rvv4U1dPOK/bztvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAwgdfGiuXTUsdwQtdHn2gNdWY/bb3vNi/5j2k4yIQY=;
	b=qErgRXyTka1IEdCtGQuW8mZ7EctbEUAcXzRIg7NeETfyVhHun6mK2uSNIVYo/wOumikK+G
	azOIJaYZrHl8+4BQ==
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
Subject: [PATCH v7 2/6] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Mon,  3 Feb 2025 14:50:19 +0100
Message-ID: <20250203135023.416828-3-bigeasy@linutronix.de>
In-Reply-To: <20250203135023.416828-1-bigeasy@linutronix.de>
References: <20250203135023.416828-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

kernfs_get_parent_dentry() passes kernfs_node::parent to
kernfs_get_inode().

Acquire kernfs_root::kernfs_rwsem to ensure kernfs_node::parent isn't
replaced during the operation.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 fs/kernfs/mount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1a..b9b16e97bff18 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -145,7 +145,9 @@ static struct dentry *kernfs_fh_to_parent(struct super_=
block *sb,
 static struct dentry *kernfs_get_parent_dentry(struct dentry *child)
 {
 	struct kernfs_node *kn =3D kernfs_dentry_node(child);
+	struct kernfs_root *root =3D kernfs_root(kn);
=20
+	guard(rwsem_read)(&root->kernfs_rwsem);
 	return d_obtain_alias(kernfs_get_inode(child->d_sb, kn->parent));
 }
=20
--=20
2.47.2


