Return-Path: <cgroups+bounces-6349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3116BA2064D
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 09:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC301889EF7
	for <lists+cgroups@lfdr.de>; Tue, 28 Jan 2025 08:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321391DE891;
	Tue, 28 Jan 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZL0qkpj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rXpXk2lZ"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629BF18B476;
	Tue, 28 Jan 2025 08:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053751; cv=none; b=N5vroklIud8C8lYcrl5E4C/Wy7QhBmDka9R4so3d9CohX5VFb8C3vgS9np3Rje+7z6kzX4cydZoNsAFQ/I3hp+0s46Cy1gQ2wdUtTaoPSVuPJo5evkoZXUGbfkDUlPk1DHNXZadQ0Y96NmN8nDEhjnM5cugShtLrB0tktrGsaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053751; c=relaxed/simple;
	bh=ruI2ZKGgdPMRnFBOQr3nu/ZhYn2P20UeKsv0OBRMZA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q+GSHYjOVUl7729W+z4tRPPES5+Ak9sB/90sbOblgbx8dtG2Wxt416cGduZEEBvW0cYHrC/+KRTiKl/tohAwHhi6hvR9KNH96kYlpjtA0iHPbtSCBejz6uAGdSZqxpYdRcWOmzDXmV6hAA+7Tg+kU6JXYDBow7MsCYA76ihu5JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZL0qkpj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rXpXk2lZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738053747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAylB0Y8GIVu+2xs1Bj6B6+nVmN6OdQ644kBwDRkuXM=;
	b=yZL0qkpjkGikQyB3LbxnhFU3eUH7xfDLzRcIqgy8c+5tMzMVe3twawWDwWpXO0aV9WBIzP
	HZjEnDMw1ZusQHdDFlYHQzg0moaHLCze50tH4REVhfGcK1qsf4Cr0zq+EUUjQR/0D6z7oV
	2/BDkEk0kqye0uvfqLS+eI/HmEkz9CFC+Pwk/8bXS4LcxC870cm4smcV1zTKhfiHuO0b0v
	Qjl7T8coNAzn/vdcnSRCmuMwY22jXcYp0f+uwQ9OCo4duBPcGSKGuOEDBqtRJrQHwbJ6eb
	mhaLKXUdI2n8RoGaOTtvqR5ElSWxRGqneY5WjrTyKIatYvsQewOCBFB06aSJaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738053747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAylB0Y8GIVu+2xs1Bj6B6+nVmN6OdQ644kBwDRkuXM=;
	b=rXpXk2lZF4jPrGL5JjK8XkKgWlFY7q3jMRouO5NVGJFWruuS8iZ6jEhvhK6cpcY7dBSJpe
	+5CsSJZFVH7O5gCQ==
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
Subject: [PATCH v5 0/6] kernfs: Use RCU to access kernfs_node::{parent|name}.
Date: Tue, 28 Jan 2025 09:42:20 +0100
Message-ID: <20250128084226.1499291-1-bigeasy@linutronix.de>
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
 fs/kernfs/dir.c                           | 214 ++++++++++++----------
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
 14 files changed, 306 insertions(+), 167 deletions(-)

--=20
2.47.2


