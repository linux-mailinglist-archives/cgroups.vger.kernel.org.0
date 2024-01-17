Return-Path: <cgroups+bounces-1148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96BB830ABE
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 17:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37DA228CA27
	for <lists+cgroups@lfdr.de>; Wed, 17 Jan 2024 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E906322326;
	Wed, 17 Jan 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQ9qpc6W"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05C12231F;
	Wed, 17 Jan 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508107; cv=none; b=Yd++5qpHK0q12SmsAN2lomX0G/VjtxpNJZbUs5AThwZpecMwKuTwgMFtspsG6jsoCCq5frhLXz/C6Zm0EEgJpJfanYJJjjYzHADemydsvTbuOyLuoXJqWEMtUUqVtAfANyjMjregRzaRl270m3ts4d0KvQWg0uUT9+Qc/Ijjiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508107; c=relaxed/simple;
	bh=BZYkK+VlcfDaqw7thRWlJNvcpJwXTCI1POX/7V/Pkpc=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=EszeT1FjLol8KvF+MGxl/c8MuoYYRAXq88tsmTwsK0kfDSXPTzz67fF8UMT7KC2jpZxaNMLeioSgvDd46I8T7JN+UXPri7EyWZhZW6PXhazqICNo7TiIdXTgqdgz2RpSTZYfwUn5/Ph1s8ud3ZadnvBN1+Qe653w3W13se05d28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQ9qpc6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E78FC433C7;
	Wed, 17 Jan 2024 16:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705508107;
	bh=BZYkK+VlcfDaqw7thRWlJNvcpJwXTCI1POX/7V/Pkpc=;
	h=From:To:Cc:Subject:Date:From;
	b=mQ9qpc6Wfjcm6fMCU0JAECDMfOUrKCVUhADf0b8TUj4xnhb1bSwEzxo4YG7DyELkM
	 rmzD85Oblm6riC0xqfFVZiMlo8Z/CIY0NGDcVHsMny7AHwoCeOmBG6ROUDa3T76Z/0
	 Gc18XY1Sxmzs87DqwgV2okqgnjPD19KNHkUwN6xezCAwOGeOMJ6q+HcPmkHEu4Elqs
	 hsC8/V6yfuErskJ/eSmOG9WCSaDzYqm3esH7z8uWGwgPiKe4BDlMf9oyjPLtreFeE9
	 gBqWqQZgDf6vIKfO1fOtYiAnFvPLcXMMh9QB2Hwpp9d3AqcQsG5jFuZ1FY6Chm3Q4h
	 d7mGJ8JqSRLbQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Shakeel Butt <shakeelb@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>,
	Vasily Averin <vasily.averin@linux.dev>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Jiri Kosina <jikos@kernel.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH RFC 0/4] Fix file lock cache accounting, again
Date: Wed, 17 Jan 2024 08:14:42 -0800
Message-ID: <cover.1705507931.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an attempt to fix file lock cache accounting (again).  The bug
was originally reported 2+ years ago [1] but was quickly reverted [2]
for performance reasons.

A few years ago some ideas [3] were floated about how to improve the
performance.  Did any of those ever get implemented?

Testing shows "mm: improve performance of accounted kernel memory
allocations" [4] helping some.  But even with those patches, much of the
original performance regression still remains, at least according to
microbenchmarks.

Despite that regression, this being a security and correctness issue, it
really needs to be fixed by default.  Those who want to live on the edge
(or have trusted user space) can disable it.

Patch 1 enables the fix by default, but allows disabling it at boot
time.

Patch 2 allows disabling it at build time.

Patches 3 and 4 allow disabling it (along with all the CPU mitigations)
using mitigations=off.

[1] 0f12156dff28 ("memcg: enable accounting for file lock caches")
[2] 3754707bcc3e ("Revert "memcg: enable accounting for file lock caches"")
[3] https://lore.kernel.org/lkml/dbc9955d-6c28-1dd5-b842-ef39a762aa3b@kernel.dk/
[4] https://lore.kernel.org/lkml/20231019225346.1822282-1-roman.gushchin@linux.dev/

Josh Poimboeuf (4):
  fs/locks: Fix file lock cache accounting, again
  fs/locks: Add CONFIG_FLOCK_ACCOUNTING
  mitigations: Expand 'mitigations=off' to include optional software
    mitigations
  mitigations: Add flock cache accounting to 'mitigations=off'

 .../admin-guide/kernel-parameters.txt         | 48 ++++++++++++++----
 arch/arm64/kernel/cpufeature.c                |  2 +-
 arch/arm64/kernel/proton-pack.c               |  6 +--
 arch/powerpc/kernel/security.c                | 14 +++---
 arch/s390/kernel/nospec-branch.c              |  2 +-
 arch/x86/kernel/cpu/bugs.c                    | 35 ++++++-------
 arch/x86/kvm/mmu/mmu.c                        |  2 +-
 arch/x86/mm/pti.c                             |  3 +-
 fs/Kconfig                                    | 15 ++++++
 fs/locks.c                                    | 31 +++++++++++-
 include/linux/bpf.h                           |  5 +-
 include/linux/cpu.h                           |  3 --
 include/linux/mitigations.h                   |  4 ++
 kernel/Makefile                               |  3 +-
 kernel/cpu.c                                  | 43 ----------------
 kernel/mitigations.c                          | 50 +++++++++++++++++++
 16 files changed, 174 insertions(+), 92 deletions(-)
 create mode 100644 include/linux/mitigations.h
 create mode 100644 kernel/mitigations.c

-- 
2.43.0


