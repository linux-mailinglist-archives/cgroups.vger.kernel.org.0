Return-Path: <cgroups+bounces-9861-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3980FB50E9B
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45B116E622
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94863064AA;
	Wed, 10 Sep 2025 06:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RLrV5EXO"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50912306488;
	Wed, 10 Sep 2025 06:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487597; cv=none; b=cTiFuPCRKeK1q2olQMbKA0MOEHemvhqgSm2UGeyr1voeA8togPUCxI+Kg1otlacPPlySkOmswbmdLG1bJ8Cedpkb/UPrqTfTskbLxc7xECm+e0Yx1noqf6CaI/B66HzhEnA16xgn+QTI5SF/yB9XYfr3t6XUdYD78GHrORvvvb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487597; c=relaxed/simple;
	bh=UV9aNJxf0IwQww5C7kEiuRay+kqbh0JrXnwpbCW7B0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhzMBrHv2bH+bsEiE6xEb0upXMDq7SunQdjTWo0zkHRsWgNh+s9aL60/xpU7JxIwho9DICxCvxAhUO6oSA7SmkPVVCXo/I+QzXbBdDnPWBC8JSsi1TU67EnyhtpnYyVdMh8g8iGBsv6hSnLIW5fGynJCS5jWdCeyKSiQ8g7hGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RLrV5EXO; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757487586; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=FKG5cpivebjq2rxTAESMDDA6C1QPfjMqGUnxWLOgkT8=;
	b=RLrV5EXO73VEoTk3/MZZOHbVHksbyluIvxp/7HMnH7iTxdabX/RBbGpP4P+InUTUFf+9kC9mQuY1YOymg0Hmo78XYgzbEqqhZ5ISWfKIYs4SAjRhLO4KCKqGoPWTNeq/aYfapV7YTPPqAi6AVeuOsUZQ+KxRu9MO8yJFMKW/SqQ=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnh86zd_1757487585 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 14:59:45 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs
Date: Wed, 10 Sep 2025 14:59:32 +0800
Message-Id: <cover.1757486368.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v5:
- Adjust the order of patches.
- Add the type name for enum used by cgroup_attach_lock.

Changes in v4:
- Adjust commit log and comments.
- Rename take_per_threadgroup_rwsem to cgroup_enable_per_threadgroup_rwsem
and add attr __read_mostly.
- Trigger a warning that per_threadgroup opreation can't be
disabled once enabled instead of actually turning it off.
- Split the code for retrying when the threadgroup leader changes into a
separate patch.
- Refactor the cgroup_attach_lock code to make it clearer.

Changes in v3:
- Expend commit log and comments.
- Put argument @tsk at end in cgroup_attach_lock/unlock.
- down_write global cgroup_thread_rwsem when flipping favordynmods to
synchronize with task between cgroup_threadgroup_change_begin and end.
- Rename group_rwsem to cgroup_threadgroup_rwsem.
- Fix bug causing abnormal cgroup migration due to threadgroup leader
changes。

Changes in v2:
- Use favordynmods as the enabling switch.
- Determine whether to use the per-thread-group rwsem based on whether
the task is NULL.
- Fix system hang caused by acquiring cgroup_threadgroup_rwsem inside
rcu_read_lock.

Yi Tao (3):
  cgroup: refactor the cgroup_attach_lock code to make it clearer
  cgroup: relocate cgroup_attach_lock within cgroup_procs_write_start
  cgroup: replace global percpu_rwsem with per threadgroup resem when
    writing to cgroup.procs

 include/linux/cgroup-defs.h     |  25 +++++-
 include/linux/sched/signal.h    |   4 +
 init/init_task.c                |   3 +
 kernel/cgroup/cgroup-internal.h |  11 ++-
 kernel/cgroup/cgroup-v1.c       |  14 +--
 kernel/cgroup/cgroup.c          | 153 ++++++++++++++++++++++++--------
 kernel/fork.c                   |   4 +
 7 files changed, 167 insertions(+), 47 deletions(-)

-- 
2.32.0.3.g01195cf9f


