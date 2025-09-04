Return-Path: <cgroups+bounces-9704-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FA2B43A5C
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 13:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59452561B5A
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 11:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF32F28EE;
	Thu,  4 Sep 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LWQRtqC3"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F122C21C5;
	Thu,  4 Sep 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985983; cv=none; b=DgfsutbszrQR4KGvaBSIuynvh4sRdTHtitQ/I9fPIREcSx6PL+CjH86zABf6fs1ZUa7GDDRt8hQ7o71rzUPkrEYBDuPC1RkOQTtPLwzXFIUXB+tf0yxnTt+Kb5cHadGxoCMtmKKp/MySbple8F5IZCLyQLWW6/psvDTttA4Iw9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985983; c=relaxed/simple;
	bh=naQ3G7ApW2lLTQaMO8/EY9LR1EHLGorkTSot0vEdR4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DJAAUSXREmQc/rcCQ28nv7sP0HBWR9uzpmnz0h+aLwjdmBXTSJ8+V2Oyq4++QRxlt2zk/nDynULd3DK8bBC+tLrz3H/J8tLSL224naO1GBFC1ESCg26Rp9Tu9llVtdQjjGSsdEE4J9HCyqnZjFnB64yf1izjpO9X02A+DJ1RqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LWQRtqC3; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756985976; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UpvuTRS22BOuUhx+uJCw7d+5uPbl8qXTCrYiA6Jk/98=;
	b=LWQRtqC3eQH1z4Yueo0FqN0s35JSBOVBxPgbIIkHqClKGH+KvGeePB3OUpqkRf8vmNmGTHvCCjG7DwQawCt/v2k5TKV/Ghg1kEvZTYl2gF616ItA2j8Ey12OUWS28vTVqZWd8G8tLlggGILm2QxJBFr95fGeJOFyIa6ntzhJ8Q8=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnFvs8L_1756985975 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 19:39:36 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] cgroup: replace global percpu_rwsem with signal_struct->group_rwsem when writing cgroup.procs/threads
Date: Thu,  4 Sep 2025 19:39:31 +0800
Message-Id: <cover.1756985260.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
- Use favordynmods as the enabling switch.
- Determine whether to use the per-thread-group rwsem based on whether
the task is NULL.
- Fix system hang caused by acquiring cgroup_threadgroup_rwsem inside
rcu_read_lock.

Yi Tao (1):
  cgroup: replace global percpu_rwsem with signal_struct->group_rwsem
    when writing cgroup.procs/threads

 include/linux/cgroup-defs.h     |  6 +++
 include/linux/sched/signal.h    |  4 ++
 init/init_task.c                |  3 ++
 kernel/cgroup/cgroup-internal.h |  4 +-
 kernel/cgroup/cgroup-v1.c       |  8 ++--
 kernel/cgroup/cgroup.c          | 72 +++++++++++++++++++--------------
 kernel/fork.c                   |  4 ++
 7 files changed, 64 insertions(+), 37 deletions(-)

-- 
2.32.0.3.g01195cf9f


