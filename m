Return-Path: <cgroups+bounces-9787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C8BB489F7
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 12:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43571B257DE
	for <lists+cgroups@lfdr.de>; Mon,  8 Sep 2025 10:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB482F6193;
	Mon,  8 Sep 2025 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E067wYk+"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8D2EB848;
	Mon,  8 Sep 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326836; cv=none; b=H60JAq6WBGPIjm3Ws98P7UQgzR7mrPl/yVUbSoriQUssfj1GjQxby4SlgpPNjnkQm+ILVZRCzDHP3eb4m0Ln9UzzToI/l007Wzo2KVaRfd53ImEBx/0Dn9kjeW3FuBp2Lwvn950T+YGUBG/iYLQyGGfNH2LQBOE+kPYBdYLN2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326836; c=relaxed/simple;
	bh=bJRuXWHsHLC8sMQ9vy8yQKCmIRVyjpUGhUWJCTifiyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbjZhsesM50nWlLv/xUHBavEcc6Zilsg9g5xfnqbhcYe8gomAjZw0sw4lZgvE87Dl1My3HrjPTX4QvyfLGgo2w/+Oeti81XethzcdwB4MebRk5RPTDmZhCqhJBclQjLBFVHKNoEkST1riNS/Ug7gjzQFFf4TQC8ncp87EGrW510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E067wYk+; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757326829; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=G6qOydr5ilLKHgbw25Nfkyyz6dUk4uUkblGDd3vS5bo=;
	b=E067wYk+meUVZBflvA0dv4wwmspTKQvh7NHKhdKn2FosuZ+lFI8YUYGgl5B9GoXvgZehnYJiHjJg38bLh+HZkM4XRYhmbP2cbXTl18Kn14yNI/AxgJpZyIo8QATlV5Zv66IMCBo3u70qMrwdMYBhy6+XekmV8hukAn/Zc7zsnYI=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnVUpR3_1757326828 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 08 Sep 2025 18:20:29 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs
Date: Mon,  8 Sep 2025 18:20:26 +0800
Message-Id: <cover.1757326641.git.escape@linux.alibaba.com>
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

Yi Tao (1):
  cgroup: replace global percpu_rwsem with per threadgroup resem when
    writing to cgroup.procs

 include/linux/cgroup-defs.h     |  12 +++-
 include/linux/sched/signal.h    |   4 ++
 init/init_task.c                |   3 +
 kernel/cgroup/cgroup-internal.h |   4 +-
 kernel/cgroup/cgroup-v1.c       |   8 +--
 kernel/cgroup/cgroup.c          | 105 ++++++++++++++++++++++----------
 kernel/fork.c                   |   4 ++
 7 files changed, 101 insertions(+), 39 deletions(-)

-- 
2.32.0.3.g01195cf9f


