Return-Path: <cgroups+bounces-6278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B227A1BBAC
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910073AFD28
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64AF21B909;
	Fri, 24 Jan 2025 17:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFGBoA5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OUIfk7qx"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C741C6E;
	Fri, 24 Jan 2025 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737740784; cv=none; b=Tke9CRg0X5Odjz2Ma6yZtb73SXyP0TrE2h+shRsGsKQILeKpdNNGr8Jp9GinqAbAWccwpe2c3ChKY5mj6N8tL1a0ZUFqT9R0cRmTQAExbLOI8DDYW79wiyAqXDp66Twsa/q8vTyrtPkQuj6XxmTHaK4pe9qBbrk9u5wMEAsguxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737740784; c=relaxed/simple;
	bh=2U+TnUXzNFPpRq5Rj1IZFr0OpkHn6hHe406ekPzlmnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ihijoK+1NJsjnlj/Ns9pQtkPoWRGLt2KnwP6VFn5o0Vbr9ShaiEufTdR85/srcqXH2ppJgM6ZkA0d7qz5Dxu0JC6mppIPpwgbSxqSV0xo/X9fV3HPF/08z9YAPHkawiXeFbARWE4I2SMKtFLJTSifppkEvjY2ZlpcYwenPLCD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFGBoA5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OUIfk7qx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737740778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZTl+aBAzqFqtaPbtY4cWvmm/92t1aY9k55xRPxInDNs=;
	b=mFGBoA5AvchusMsg/JEv1EptGESOSVQGNQGFpXnCnCiyUza5dq25nyu6NN8OUtNqQaJT3W
	4FFW/kIdFdxQk2fvYA+4vyKuABa7yFiYExk3yrYbzTp+qqDhp6DIv5sVvWl36hGMS7bdE3
	zv1rn60VTthOhEYSSV+OhQa6fKLne4ElpkiNKgIyOJkCemBU6nqryWv+mSxAao0tFJ4DBV
	Qz0DCcxK1CHv5du4N2AE0Mmh9e79KYpWruRK2igbYdqaptaKSshobqLfGLwvVTIS0euo4q
	KRBEFE+OGUIFiINqPqhQrXF5aFvhHWj39oaefeZ/rX5kgR2Hbl9Ue/JkmD8Ovg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737740778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZTl+aBAzqFqtaPbtY4cWvmm/92t1aY9k55xRPxInDNs=;
	b=OUIfk7qxc/iEW+tar6T2s81JA58wQwEyArmSu1S4FGYCPeMxlRqr28io+49KuIXp25+Ddg
	PY+nyIRhnXhRVADg==
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
Subject: [PATCH v4 0/6] kernfs: Use RCU to access kernfs_node::{parent|name}.
Date: Fri, 24 Jan 2025 18:46:08 +0100
Message-ID: <20250124174614.866884-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

This started as a bug report by Hillf Danton and aims to access
kernfs_node::{name|parent} with RCU to avoid the lock during
kernfs_path_from_node().

I've split the individual fixes in separate patches (#1 to #4). I've
also split the ::parent and ::name RCU conversation into a single patch
(#5 and #6).

v3: https://lore.kernel.org/all/20241121175250.EJbI7VMb@linutronix.de/
v2: https://lore.kernel.org/all/20241112155713.269214-1-bigeasy@linutronix.=
de/
v1: https://lore.kernel.org/all/20241108222406.n5azgO98@linutronix.de/

Sebastian

Sebastian Andrzej Siewior (6):
  kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().
  kernfs: Acquire kernfs_rwsem in kernfs_get_parent_dentry().
  kernfs: Acquire kernfs_rwsem in kernfs_node_dentry().
  kernfs: Don't re-lock kernfs_root::kernfs_rwsem in
    kernfs_fop_readdir().
  kernfs: Use RCU to access kernfs_node::parent.
  kernfs: Use RCU to access kernfs_node::name.

 arch/x86/kernel/cpu/resctrl/internal.h    |   5 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  60 ++++---
 fs/kernfs/dir.c                           | 203 ++++++++++++----------
 fs/kernfs/file.c                          |   6 +-
 fs/kernfs/kernfs-internal.h               |  24 ++-
 fs/kernfs/mount.c                         |  21 ++-
 fs/kernfs/symlink.c                       |  30 ++--
 fs/sysfs/dir.c                            |   2 +-
 fs/sysfs/file.c                           |  24 ++-
 include/linux/kernfs.h                    |  11 +-
 kernel/cgroup/cgroup-v1.c                 |   2 +-
 kernel/cgroup/cgroup.c                    |  16 +-
 security/selinux/hooks.c                  |   7 +-
 14 files changed, 263 insertions(+), 162 deletions(-)

--=20
2.47.2


