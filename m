Return-Path: <cgroups+bounces-9812-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C92B4A44A
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 09:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209611899048
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD623D7F2;
	Tue,  9 Sep 2025 07:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="D6CieceK"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1EB23D28F;
	Tue,  9 Sep 2025 07:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404538; cv=none; b=YbG+Ry0qEhCYy+qradx/jCu4itI2PRXJroDF1SEiTYt9PUD0a8KXc0+pEEvbP5QD9yawDAROEWXXAHO/E0JawjwDUCTKyJPvjOoHoY1hRlBLmcqByr+QmGprmxZDWSZ5StPWB7aAMvZ736NpBXJUPLTXZQqWF0NOk/h8lk3W5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404538; c=relaxed/simple;
	bh=bqOEKlec9T01lJukjMLP2Gkgdk7R1/bMueTi60tT4U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NxuRLmtEDU+GK5D0XHqZdL02Xs96DwNujQTUwkXAC9RahuldBf6dQ7DhTR2YuKwBg+5udPcLMyXFrlXKVwIYYDDeDJkN0X2L63s0pawuyOk/n7bW+UeBKWqLr+IhwERF3eH1+/4wHPjY22ThyokSjjBhaq2JlCujUsMcv4SAwk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=D6CieceK; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757404533; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=yDhZgbljTTmNZRax3sZ1TEqlJ1G+RfLf5czKHMYzn14=;
	b=D6CieceKRG+Yh0liEE7k5EhlucwnYXgtn1tVunxLIXcOVqEkaJkElE3fpuW9KiUefwxS2ksYJn1Zyq3U2Xm+R4antYfOBaVAAx9O7evyiEBbE+OX4ws2BuTyV21OYwczCdLB+Jx+LlR5TYU0lbHaw5ZzongUISAEi493tjxqYOg=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnd-YGW_1757404532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:55:32 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs
Date: Tue,  9 Sep 2025 15:55:27 +0800
Message-Id: <cover.1757403652.git.escape@linux.alibaba.com>
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

Changes in v4:
- Adjust commit log and comments.
- Rename take_per_threadgroup_rwsem to cgroup_enable_per_threadgroup_rwsem and
add attr __read_mostly.
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
- Fix bug causing abnormal cgroup migration due to threadgroup leader changes。

Changes in v2:
- Use favordynmods as the enabling switch.
- Determine whether to use the per-thread-group rwsem based on whether
the task is NULL.
- Fix system hang caused by acquiring cgroup_threadgroup_rwsem inside
rcu_read_lock.

Yi Tao (3):
  cgroup: replace global percpu_rwsem with per threadgroup resem when
    writing to cgroup.procs
  cgroup: retry find task if threadgroup leader changed
  cgroup: refactor the cgroup_attach_lock code to make it clearer

 include/linux/cgroup-defs.h     |  25 +++++-
 include/linux/sched/signal.h    |   4 +
 init/init_task.c                |   3 +
 kernel/cgroup/cgroup-internal.h |   8 +-
 kernel/cgroup/cgroup-v1.c       |  14 +--
 kernel/cgroup/cgroup.c          | 149 ++++++++++++++++++++++++--------
 kernel/fork.c                   |   4 +
 7 files changed, 161 insertions(+), 46 deletions(-)

-- 
2.32.0.3.g01195cf9f


