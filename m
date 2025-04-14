Return-Path: <cgroups+bounces-7513-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A8EA88274
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 15:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4CB7AA2B0
	for <lists+cgroups@lfdr.de>; Mon, 14 Apr 2025 13:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FEF28B4EE;
	Mon, 14 Apr 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7mPHtH/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD128B4E4;
	Mon, 14 Apr 2025 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637259; cv=none; b=dQSbRra0AQsBzbUN8GcSo75s37CszinAg9sd2PKrL0MORZV3J1hOOf1eL+d+IdvhcXQBd4jYi449OObz2hixBmJd3Yzupxp+5GKuiHPJfGf1lEvE5UqjEKSQoHf71fUB9NQu1j8s9t0SXPVajqPdtSM6dhVTGSiyNVl9trA7LMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637259; c=relaxed/simple;
	bh=/2zqRkxAlAw/uJ1J6jZx9l7WcbB1OHfrAqcIyUXNnTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLSa4ropNuKbiusjfjh4mhFYQTEOXbM+bu25YbrDu9AAM3tNY3UHj/Ap8k0ggihuoS4GV0V+A9kwScSsqLhOT7WoJqc7QZ5LL+MoCn74h71g92eBfYlpQRKBYSfstdISQ1RAv8fQbN365cElPw3SSJ1ORObUHgR+rk5jQ6vPxAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7mPHtH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E6C4CEEB;
	Mon, 14 Apr 2025 13:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637259;
	bh=/2zqRkxAlAw/uJ1J6jZx9l7WcbB1OHfrAqcIyUXNnTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T7mPHtH/9P3WxyLADwtb64qlL8TqrfUOYdWXFCn/dyI0pj70sLmy1Xg+mL7ppjR34
	 Z5X5FEcFMOGrL0iAZdqup602Y2hvO7U31fkHXIdA9D5ofTdsy7Fxqg6u1ETW7DEBCJ
	 m7fEGjx37IlI2IMW7yUgQT355TXqLPoDbViPf0B60JxrvR+NtNqTugxvxuCouDzuzC
	 IWedsYYdCsadDbsl2HMtB7I7zngB4POgToODWIUQnRXocLDn5o7eA8xclUPLqLXpdD
	 in50MUnF4ZSgM25xom+42Ld1j6FSqNVNnQi3SRX5xWv1Z4q8UZmyGn5UC//9fX6Xxl
	 Q1Nbxk/UOCSHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 04/34] cgroup/cpuset: Don't allow creation of local partition over a remote one
Date: Mon, 14 Apr 2025 09:26:58 -0400
Message-Id: <20250414132729.679254-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132729.679254-1-sashal@kernel.org>
References: <20250414132729.679254-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.11
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 6da580ec656a5ed135db2cdf574b47635611a4d7 ]

Currently, we don't allow the creation of a remote partition underneath
another local or remote partition. However, it is currently possible to
create a new local partition with an existing remote partition underneath
it if top_cpuset is the parent. However, the current cpuset code does
not set the effective exclusive CPUs correctly to account for those
that are taken by the remote partition.

Changing the code to properly account for those remote partition CPUs
under all possible circumstances can be complex. It is much easier to
not allow such a configuration which is not that useful. So forbid
that by making sure that exclusive_cpus mask doesn't overlap with
subpartitions_cpus and invalidate the partition if that happens.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cpuset-internal.h |  1 +
 kernel/cgroup/cpuset.c          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 976a8bc3ff603..383963e28ac69 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -33,6 +33,7 @@ enum prs_errcode {
 	PERR_CPUSEMPTY,
 	PERR_HKEEPING,
 	PERR_ACCESS,
+	PERR_REMOTE,
 };
 
 /* bits in struct cpuset flags field */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0f910c828973a..01e1745957534 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -62,6 +62,7 @@ static const char * const perr_strings[] = {
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
+	[PERR_REMOTE]    = "Have remote partition underneath",
 };
 
 /*
@@ -2821,6 +2822,19 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 			goto out;
 		}
 
+		/*
+		 * We don't support the creation of a new local partition with
+		 * a remote partition underneath it. This unsupported
+		 * setting can happen only if parent is the top_cpuset because
+		 * a remote partition cannot be created underneath an existing
+		 * local or remote partition.
+		 */
+		if ((parent == &top_cpuset) &&
+		    cpumask_intersects(cs->exclusive_cpus, subpartitions_cpus)) {
+			err = PERR_REMOTE;
+			goto out;
+		}
+
 		/*
 		 * If parent is valid partition, enable local partiion.
 		 * Otherwise, enable a remote partition.
-- 
2.39.5


