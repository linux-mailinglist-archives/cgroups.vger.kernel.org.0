Return-Path: <cgroups+bounces-6540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C27A1A34422
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 16:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07C943AB184
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2025 14:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8701714A1;
	Thu, 13 Feb 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTWhXWLe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Pp+k0g8"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69138389;
	Thu, 13 Feb 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739458231; cv=none; b=rE95vAr4ZjRaX1cvV5yYFGg+dd6iI8deupjWofpsDMHbhk4PqZ/oR6FsLCsbSt7LRCOLAe1YUnrYp5S8kMD+rjeE5V4FuW8rexraY6KVHlMMgpD787USBithbgtRkbJW8nMyJOB4MgAioKYWfgDjnic+U/qoIjuOjXhFIpFg+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739458231; c=relaxed/simple;
	bh=NSCKzRekUECh1rgFngsoPBXi9xMzHFidKxXmjOlMdC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BBpU3DChc3FEzN87jK8JKHNPvFd5fD26QlAnUZjPlFc29mWHHR1iw16WVFN3w1WP5TbuSO3uU9Gz7ffY2NvuexwjJqBRME0yYQse2DlOUirZQ4g4cfMPk9SiPsRXRXf6GYARNsUDH5L5+HOaLgVDazQJaYTc6R5ccoHWFW3k3sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTWhXWLe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Pp+k0g8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OMukzCnamzmecBTc5qfvClioeFNM5qf8pYaykzEBLI4=;
	b=aTWhXWLeVJ0KdYXkm8NaNTcUOch0FWGmzLrpQrU0flghMgS+uoPynsWIDPEAxSGotnYAXC
	WunpDkO+2NuHVx03rWdiLzMmuD/I4ZcZokhmM/Vise5B0mK+XSX5fa1FH3NtOgHwvg+TgE
	3d6kB3RmLamj19x/pmaDIYrcjmhmZSOYExP87vsjZC3JTpnnwxUCPKLNLIP01HawWLXpOw
	oPr9UEICJDKukdYBz8ToEYYuZiigmxEay5kKEUN+JO5DS6q8YUfeZk8PFJUv2L6tNXGGPe
	2AOq7iRUES3mYAmZSzwzzs9Yr4t8QSscjxjXTLMMg7Z1OiomqXmX6rTgY3PECA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739458227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OMukzCnamzmecBTc5qfvClioeFNM5qf8pYaykzEBLI4=;
	b=3Pp+k0g8MXptG2Z8Op0bnCXvq+H/FP7ipp7CyAXh7C4ThRRnEhX6wwYl7nLrNeZCFB1TvS
	grbvYdnfVG4bV+Bg==
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
Subject: [PATCH v8 0/6] kernfs: Use RCU to access kernfs_node::{parent|name}.
Date: Thu, 13 Feb 2025 15:50:17 +0100
Message-ID: <20250213145023.2820193-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

This started as a bug report by Hillf Danton and aims to access
kernfs_node::{name|parent} with RCU to avoid the lock during
kernfs_path_from_node().

I've split the individual fixes in separate patches (#1 to #4). I've
also split the ::parent and ::name RCU conversation into a single patch
(#5 and #6).

v7=E2=80=A6v8 https://lore.kernel.org/all/20250203135023.416828-1-bigeasy@l=
inutronix.de/
  - A user in selftests/bpf is fixed in #5 as part of the rename.

v6=E2=80=A6v7 https://lore.kernel.org/all/20250130140207.1914339-1-bigeasy@=
linutronix.de/
  - Rebase on v6.14-rc1

v5=E2=80=A6v6 https://lore.kernel.org/all/20250128084226.1499291-1-bigeasy@=
linutronix.de/
  - s/rdt_kn_get_name/rdt_kn_name/
  - s/rdt_get_kn_parent_priv/rdt_kn_parent_priv/
  - s/kn_get_priv/kn_priv/
  - The comment, that has been removed in kernfs_put(), is back.
  - Using rcu_access_pointer() in kernfs_activate_one() and kernfs_dir_pos()
    instead of kernfs_parent() where the pointer is not dereferenced but
    just compared.

v4=E2=80=A6v5 https://lore.kernel.org/all/20250124174614.866884-1-bigeasy@l=
inutronix.de/
  - rdtgroup:
    - Add a comment to rdt_get_kn_parent_priv() regarding lifetime of
      parent.
    - Move individual rcu_dereference_check() invocations into
      rdt_kn_parent() with a comment on lifetime.
    - Use rcu_access_pointer() in kernfs_to_rdtgroup() instead
      rcu_dereference_check(, true)
  - s/kernfs_rcu_get_name/kernfs_rcu_name/
  - Move all rcu_dereference_check() within kernfs into kernfs_parent()
    and extend its checks to have all cases in one spot. Document why
    each case makes sense.
  - kernfs_notify_workfn(): Do unlocks in the reverse order of locks.
  - Add kernfs_root_flags() and use it in cgroup's kn_get_priv() to
    check the right KERNFS_ROOT_INVARIANT_PARENT flag.

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

 arch/x86/kernel/cpu/resctrl/internal.h        |   5 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c     |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c        |  73 +++---
 fs/kernfs/dir.c                               | 211 ++++++++++--------
 fs/kernfs/file.c                              |   6 +-
 fs/kernfs/kernfs-internal.h                   |  37 ++-
 fs/kernfs/mount.c                             |  21 +-
 fs/kernfs/symlink.c                           |  30 +--
 fs/sysfs/dir.c                                |   2 +-
 fs/sysfs/file.c                               |  24 +-
 include/linux/kernfs.h                        |  14 +-
 kernel/cgroup/cgroup-v1.c                     |   2 +-
 kernel/cgroup/cgroup.c                        |  24 +-
 security/selinux/hooks.c                      |   7 +-
 .../selftests/bpf/progs/profiler.inc.h        |   2 +-
 15 files changed, 308 insertions(+), 164 deletions(-)

