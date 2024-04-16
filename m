Return-Path: <cgroups+bounces-2536-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BEF8A72A1
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 19:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38FE1B213EE
	for <lists+cgroups@lfdr.de>; Tue, 16 Apr 2024 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F397E134405;
	Tue, 16 Apr 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAmSAcR6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CF512EBF0;
	Tue, 16 Apr 2024 17:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713289885; cv=none; b=l+iMg7fUoocKxFUBEfiy8MeAl+tq7ZsrjJzideV+G42B/NzPBNxkRcoEfhg1G7i1/+FihHYBwE4Zl4K2gLBEd1KSUt4irsNVHLnPVSoGjrcxmlrpfureKBUYqGc+Icw5WS2Cuh4yu0m4hEq4lABkAedfioN8wt2EW1R0GgQ39TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713289885; c=relaxed/simple;
	bh=bM4xJrevzHisjJsEBCKMA21c1+HdvIZqUoYp2jCPlJw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=aZUS60I1x8OWj9ek0ewslWoqSa0bQhGCxTzZU5VLJmuNdi+OopaCZMVMJv/vy4/8cjVQuLkXrOELSb2/vN70jY5xPWuAbdLVNt9ZkOz1da5KBe88/0T2178S+ltRip/3HoWTsrDdoaCE9HwWwZFtuQwxZgeRSEbQir2VcRsnNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAmSAcR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEECFC113CE;
	Tue, 16 Apr 2024 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713289885;
	bh=bM4xJrevzHisjJsEBCKMA21c1+HdvIZqUoYp2jCPlJw=;
	h=Subject:From:To:Cc:Date:From;
	b=FAmSAcR6ed3Fi+OIR5DzruE8DSs+YfuciiT/vPtdTIR08H4t8Vx9gAqgaWFWagxOQ
	 gJW4+sL1iz+m0xWQtVZpMl7RIW5S0ufVGcXMGJZOdU7dmCzn0X21tdcFljjJ6XrRlM
	 xjmXTs6bUj9Tvrz2bo5yUPQjnruWastd0fcH97gH/DgUEGy2NoEtP6IIos+FZp7++4
	 ccmzDFNPzkTRYfPIs3D9h5LIvUZPKsz33aMHRSD1DfGVNNucW9AAuMClftZvfPEYYA
	 rF3SqZSlqtRhExXS6EUYr3IfizqJ5W5nND9fgkb48e74MFsdtYEFE80+yd4x9d9sZL
	 DRkygFoJbUvog==
Subject: [PATCH v1 0/3] cgroup/rstat: global cgroup_rstat_lock changes
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, yosryahmed@google.com, longman@redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, shakeel.butt@linux.dev,
 kernel-team@cloudflare.com, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Date: Tue, 16 Apr 2024 19:51:19 +0200
Message-ID: <171328983017.3930751.9484082608778623495.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patchset is focused on the global cgroup_rstat_lock.

 Patch-1: Adds tracepoints to improve measuring lock behavior.
 Patch-2: Converts the global lock into a mutex.
 Patch-3: Limits userspace triggered pressure on the lock.

Background in discussion thread [1].
 [1] https://lore.kernel.org/all/ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org/

---

Jesper Dangaard Brouer (3):
      cgroup/rstat: add cgroup_rstat_lock helpers and tracepoints
      cgroup/rstat: convert cgroup_rstat_lock back to mutex
      cgroup/rstat: introduce ratelimited rstat flushing


 block/blk-cgroup.c            |   2 +-
 include/linux/cgroup-defs.h   |   1 +
 include/linux/cgroup.h        |   5 +-
 include/trace/events/cgroup.h |  48 +++++++++++++++
 kernel/cgroup/rstat.c         | 111 ++++++++++++++++++++++++++++++----
 mm/memcontrol.c               |   1 +
 6 files changed, 153 insertions(+), 15 deletions(-)

--



