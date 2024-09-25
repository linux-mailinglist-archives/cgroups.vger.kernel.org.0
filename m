Return-Path: <cgroups+bounces-4943-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5B9985D77
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 15:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D0291C24EF6
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 13:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5D11E6321;
	Wed, 25 Sep 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kz5PpO87"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC131E630C;
	Wed, 25 Sep 2024 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265825; cv=none; b=msydZQ1AUvCU5T2gGMSpuOiuoyZSiqewA324u/tcDZIIdnwLZcRmS9TT1yruzRMpfcSakUuRSuEW+lXrBgJHjx7/4Dhcxjd/tH1B79Wk27jmB7mkxA+ASS5pZTSD0DHTJb4Xs9+QDy971CSy2ZWnLy9hOCi5MFu3odwRtsnrJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265825; c=relaxed/simple;
	bh=RHqHJ7c2Y9l9bwIgNIcZEW59qYpxVf4yfh5atNTB+Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHuCwuf58wdd8UYhVV6BrNZJLo9pxTb2tm0T+l4q0KwvVkkfGTlsJwhcYF1Qqu+f54nFF0bwoM+dp1Zzw/RKzk6H6H4aPxm4H+gC1XktgrJizzjGyif/huCEN+c6myKlDt6UQLUY+ndK+uMD3tHCegIH9UB+ALMvHZd402TLHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kz5PpO87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F82C4CED3;
	Wed, 25 Sep 2024 12:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265825;
	bh=RHqHJ7c2Y9l9bwIgNIcZEW59qYpxVf4yfh5atNTB+Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kz5PpO875e5WE9O7fOTb3gmHJnqjJIdDYQeHrJM9fSIHIDBLxGyHzIjSZ+ZpY4rgH
	 65MTmE/hXF5r8MPpT7JyqyszZuh7F349bAfWhidz421rxA260UiWbY/i51lT4z4xev
	 1B5f3YpwUww/ymrqusxOUhkXo6WGmD6VS34IOz63AKN2ZspBe82mpwHyUM4JDGtZg9
	 bW5QFI+qlChBRjhSR12vSBVvX06QoWPJxIepYURpDcVzdMk8NyG8ebG8N2AFITuzR7
	 3P2YXezzH1poLDBFpXQhbow17Sv8Xb1OKuL4Fpt0f5iyFP2j4w490iaNLKgnfZl3iL
	 ZTr07GFYpfgGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 111/197] cgroup: Disallow mounting v1 hierarchies without controller implementation
Date: Wed, 25 Sep 2024 07:52:10 -0400
Message-ID: <20240925115823.1303019-111-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

From: Michal Koutný <mkoutny@suse.com>

[ Upstream commit 3c41382e920f1dd5c9f432948fe799c07af1cced ]

The configs that disable some v1 controllers would still allow mounting
them but with no controller-specific files. (Making such hierarchies
equivalent to named v1 hierarchies.) To achieve behavior consistent with
actual out-compilation of a whole controller, the mounts should treat
respective controllers as non-existent.

Wrap implementation into a helper function, leverage legacy_files to
detect compiled out controllers. The effect is that mounts on v1 would
fail and produce a message like:
  [ 1543.999081] cgroup: Unknown subsys name 'memory'

Signed-off-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup-v1.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index b9dbf6bf2779d..784337694a4be 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -46,6 +46,12 @@ bool cgroup1_ssid_disabled(int ssid)
 	return cgroup_no_v1_mask & (1 << ssid);
 }
 
+static bool cgroup1_subsys_absent(struct cgroup_subsys *ss)
+{
+	/* Check also dfl_cftypes for file-less controllers, i.e. perf_event */
+	return ss->legacy_cftypes == NULL && ss->dfl_cftypes;
+}
+
 /**
  * cgroup_attach_task_all - attach task 'tsk' to all cgroups of task 'from'
  * @from: attach to all cgroups of a given task
@@ -932,7 +938,8 @@ int cgroup1_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		if (ret != -ENOPARAM)
 			return ret;
 		for_each_subsys(ss, i) {
-			if (strcmp(param->key, ss->legacy_name))
+			if (strcmp(param->key, ss->legacy_name) ||
+			    cgroup1_subsys_absent(ss))
 				continue;
 			if (!cgroup_ssid_enabled(i) || cgroup1_ssid_disabled(i))
 				return invalfc(fc, "Disabled controller '%s'",
@@ -1024,7 +1031,8 @@ static int check_cgroupfs_options(struct fs_context *fc)
 	mask = ~((u16)1 << cpuset_cgrp_id);
 #endif
 	for_each_subsys(ss, i)
-		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i))
+		if (cgroup_ssid_enabled(i) && !cgroup1_ssid_disabled(i) &&
+		    !cgroup1_subsys_absent(ss))
 			enabled |= 1 << i;
 
 	ctx->subsys_mask &= enabled;
-- 
2.43.0


