Return-Path: <cgroups+bounces-6276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE67A1BBA5
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773363AFA58
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C21FDE1B;
	Fri, 24 Jan 2025 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3tQEz24w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bB7HNoL6"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37F1ADC64;
	Fri, 24 Jan 2025 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740783; cv=none; b=madWlQCs4KN/Ma8AqBdjolI1PWF08J2vZFqRjCRsNXRdJH9LunWewUVEgM8llVi25lUEZgfcp1G/kP/k0hx7nC3T2pzDAA6J9rvRhBUZfhAxqi9AR4qSorSW7fLyXDCOA5jS+mJl8XJenTjqJnCPASET4mlDcBEeQp/WW60KwYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740783; c=relaxed/simple;
	bh=IWDbIU38Rh2+08Ihtkig5CYQ8qvEr4yGvaBDP2hUv1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvfWBTfe+pYDbMhy+rFFYNBrYuGTIzs0DMG6x9QINVpT5SxUEwWzNEK0xRw1Zuh+dR7YuY0LGPCUhnggoPjCHJHrIjc6hwbmMJr7Ke3ZH2nW/1hAG8aH60mY6/3nYWvrk/N7LzhzFMLFkVx2Q59oBrOc5hwLRnkqGlH2HB9MOGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3tQEz24w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bB7HNoL6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBkTRcGuBbcJRhTdQo0138WYPmcl0es7O0+pKo9YHbg=;
	b=3tQEz24waH3xjslj+F0Q0Lzf/jJ8j0RxXSmpDReUcCVuGD1jcBXPLY2uK9EIvrVJLVSqlZ
	UVjFQqaGiJzdYDW+Q3zoET8idIpbJiw9rVxm6hgw7NxVql5snzsG2UMmA4Frt6gJ9HyHIJ
	NkoWfbVqgKKor/T/SB7ViWQ4AOHGvshnv4U7ULLYyaB2fIeChxshNZjMbwLan5DpNX3IDP
	b6RXaq5o6OfVVvx2CHI/dnVxKJA2J7/H22oWzTu4y8n8vNA+Fq8xwMAJ4l3ggDVDxfW02U
	62Bg8c4L1IHAXt5FV71Z0Q9n1OiUdXBb2RLER9O3FEtIl1pAA9FJRmrddyOtGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBkTRcGuBbcJRhTdQo0138WYPmcl0es7O0+pKo9YHbg=;
	b=bB7HNoL6H6fh76J5pA7Aibcg7/xoMp1pTuGQSIFsTaPB928k4tGC9RFSStrPlxjW8CzEwf
	n0VKF1d+MK/ySmAw==
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
Subject: [PATCH v4 2/6] kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
Date: Fri, 24 Jan 2025 18:46:10 +0100
Message-ID: <20250124174614.866884-3-bigeasy@linutronix.de>
In-Reply-To: <20250124174614.866884-1-bigeasy@linutronix.de>
References: <20250124174614.866884-1-bigeasy@linutronix.de>
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


