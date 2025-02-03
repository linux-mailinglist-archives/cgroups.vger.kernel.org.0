Return-Path: <cgroups+bounces-6414-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1434BA25B56
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 14:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906121669A1
	for <lists+cgroups@lfdr.de>; Mon,  3 Feb 2025 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD0A2063C5;
	Mon,  3 Feb 2025 13:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+qF5Fk8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GM6q6txW"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D40205E36;
	Mon,  3 Feb 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738590633; cv=none; b=dgii389/KcIbc+hKmQszq7o160FjA3V2hoRTitrMWNR/uZy/zzf9PYtEYdX94f5IKSW700TydUrzNCUSfDsSeZhsCuEBA/x+csEXuBACe0xdHvzFj1HACXsZlqI5tIuf/D1IqJ9PxnBFwtn8DRFY+0jXR8LF83h4uEl7elZaR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738590633; c=relaxed/simple;
	bh=ii/51m6x50IY+r9TE9aMeKGEqDTfVtOJ1oJZbzrlvlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BXd9gZqSIYWtlnPDsyChnXRmqJArrH2GVNZ81+36UiCXYzgeNwpJLW4EcZLandUnb49p7pGFiE/fdpW7bvHu+aE7L5J7i0+hGMSrkRvC0ss05Ugw5ztHrFEMcoBGYxzE+oG/MDnZIZFMWNi3Tq5SuTIgcMrcsMbxlujVvIXRY3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+qF5Fk8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GM6q6txW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738590630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ThPtUvkXfih08qgTdyI82FS9ob4HAJLy2JPUcqtfgQ=;
	b=G+qF5Fk8Jl6/U5fBRpyiSEBc/oivYzKKuRlWsU5w26m9OgOWRDQkTtVIwJX/5tPf3xMGJA
	lU1mCScS+H/pO05XwHUxLes5qzZmcENVC6587FO9HbqMv7XPDogiaVkks2JX3+3G8uLp5p
	JiZVdulU7TaQHZFs2qs7+jVjt3OCiglV1eGY7eAW9q8XQsISR311lDiS5bSk4XNDuk0ELv
	si9pZ3j6wvaYb4cpbPFBo6sfjsSY1ExDTKoyO+Y99C7aVd8kL9zCuYlkMI/UsadWjdoG3B
	+yM4YOquZ7ERSYLtk0GxHD2wXEZH4gYacz6oDoWqdLnr7h+RBis0IguBvUNyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738590630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8ThPtUvkXfih08qgTdyI82FS9ob4HAJLy2JPUcqtfgQ=;
	b=GM6q6txWhjPnnesm4vREjTU+I/F0ekWwrJLSlklfq+7WQ7I1fsxd3NNWNqGh7HvXrFqaCO
	+nIJVKp0+0JDV8Bg==
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
Subject: [PATCH v7 0/6] kernfs: Use RCU to access kernfs_node::{parent|name}.
Date: Mon,  3 Feb 2025 14:50:17 +0100
Message-ID: <20250203135023.416828-1-bigeasy@linutronix.de>
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

 arch/x86/kernel/cpu/resctrl/internal.h    |   5 +
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  14 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  73 +++++---
 fs/kernfs/dir.c                           | 211 +++++++++++++---------
 fs/kernfs/file.c                          |   6 +-
 fs/kernfs/kernfs-internal.h               |  37 +++-
 fs/kernfs/mount.c                         |  21 ++-
 fs/kernfs/symlink.c                       |  30 +--
 fs/sysfs/dir.c                            |   2 +-
 fs/sysfs/file.c                           |  24 ++-
 include/linux/kernfs.h                    |  14 +-
 kernel/cgroup/cgroup-v1.c                 |   2 +-
 kernel/cgroup/cgroup.c                    |  24 ++-
 security/selinux/hooks.c                  |   7 +-
 14 files changed, 307 insertions(+), 163 deletions(-)

--=20
2.47.2


