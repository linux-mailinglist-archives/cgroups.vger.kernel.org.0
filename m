Return-Path: <cgroups+bounces-6557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64FEA363E1
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 18:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF44918926A1
	for <lists+cgroups@lfdr.de>; Fri, 14 Feb 2025 17:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9534267F40;
	Fri, 14 Feb 2025 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtpWsG3n"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95250267707;
	Fri, 14 Feb 2025 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552619; cv=none; b=aTKFtk04I675M4cTOOZsN5Ckhsueu0hmwPqVtMYDfXBz5czeCuAM8CI68WxF5LhVNOBRuio2lukDigduMe8OAh9LjaGAQtb1ck8YL6+9Twx8N0oDmYGCOeJP+KvNdx1OMsZd8LOwdEpEbvZ6jINk8NWce1DAD9BeS0+aVK0NgKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552619; c=relaxed/simple;
	bh=U5JMJWrzoqdHSV4ua/wsROD8syqzejqOaNgi9KR3RnM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z7WwYJR9evcF8Y7whab1wxN3HeJ3IQGpRiv2JcOiKB4HUH4OXpKIKt1iJTQkuYBCiONxjtQeBz2L7GK3K6dZh6IkYBkCFQsW++b85ja/d5pOcvPBWbz5hWzy+TZf7E1knbbu4SwDn1Hkd1hDhYNQjGn0Lf1qqBh4Fs9iQyqd7wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtpWsG3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24F4C4CEDF;
	Fri, 14 Feb 2025 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552618;
	bh=U5JMJWrzoqdHSV4ua/wsROD8syqzejqOaNgi9KR3RnM=;
	h=Date:From:To:Cc:Subject:From;
	b=jtpWsG3nOOD2nqtuMAeJZ+8JwFuElwY2Y0oS7CJH8HSOShrOCm8a/ZXU49sxPLmvd
	 9FgvA/DW6P54CvctuaQjvxWaOctvT9ZGc0HwZ4mfOO4W/dYUffYqsP8BRO8F+CjXIu
	 l5myHXi95MneuUuq2/d2StZaDPcOrncA4mQ6UB+UuY2/GUM95I/mmpeak3wNElIKP3
	 eAKYA62X0UcdrQyAKi2+nwCyflLqSQDgEv4kN4taIYa2Q/Natv6HDWVJAPCBLHIh7S
	 3guf3RiWQv91QSEgFelVF8q4aFPXrza8TEHe1GfaA9eDNyNRZ51Snhg8+Oer7oQQdV
	 d5UP+b27l3s7g==
Date: Fri, 14 Feb 2025 07:03:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org
Subject: [GIT PULL] cgroup: Fixes for v6.14-rc2
Message-ID: <Z693aRJLusQVW9iZ@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit a86bf2283d2c9769205407e2b54777c03d012939:

  Merge tag 'pull-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2025-02-01 15:07:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.14-rc2-fixes

for you to fetch changes up to db5fd3cf8bf41b84b577b8ad5234ea95f327c9be:

  cgroup: Remove steal time from usage_usec (2025-02-07 11:02:17 -1000)

----------------------------------------------------------------
cgroup: Fixes for v6.14-rc2

- Fix a race window where a newly forked task could escape cgroup.kill.

- Remove incorrectly included steal time from cpu.stat::usage_usec.

- Minor update in selftest.

----------------------------------------------------------------
Bharadwaj Raju (1):
      selftests/cgroup: use bash in test_cpuset_v1_hp.sh

Muhammad Adeel (1):
      cgroup: Remove steal time from usage_usec

Shakeel Butt (1):
      cgroup: fix race between fork and cgroup.kill

 include/linux/cgroup-defs.h                         |  6 +++---
 include/linux/sched/task.h                          |  1 +
 kernel/cgroup/cgroup.c                              | 20 ++++++++++++--------
 kernel/cgroup/rstat.c                               |  1 -
 tools/testing/selftests/cgroup/test_cpuset_v1_hp.sh |  2 +-
 5 files changed, 17 insertions(+), 13 deletions(-)

-- 
tejun

