Return-Path: <cgroups+bounces-4941-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9129E985AA1
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 14:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24091C23B17
	for <lists+cgroups@lfdr.de>; Wed, 25 Sep 2024 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226301B9849;
	Wed, 25 Sep 2024 11:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA7jwV1P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5791B983E;
	Wed, 25 Sep 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264568; cv=none; b=m6Az+lN0YD5KNDbD4zS59Wtv7vPfvr1CRZ8N4kF3ZQCJM3eKrUdi6qUUGe8oDuw4VI0ubm4/EormHFU4lTFsYc0aKm8tZa+2Ra4nyCz9fA6LjPB3q3BhI5/elQsLFFhnbRvniCrU+UTzw6Lpq3uvJ1+/3ML5JW8GfxO7Fsirl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264568; c=relaxed/simple;
	bh=RHqHJ7c2Y9l9bwIgNIcZEW59qYpxVf4yfh5atNTB+Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnwJt0VgG3/ZvhcDPIvmtDoO8t9AJ8tAXKKOrPWCyD1TqDgsgwmvS18wpzZFUb5Fc1dwWrEphHGw1G7f54ERguHanTAYeDtqiYmY/WnfN8XeAoAf49BMM2m0QcV4xkgRMZY5+/1BLg8TIqn1CmYpwIqvMvCG6UWTnQ7Wj3xiUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA7jwV1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5632BC4CECD;
	Wed, 25 Sep 2024 11:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264568;
	bh=RHqHJ7c2Y9l9bwIgNIcZEW59qYpxVf4yfh5atNTB+Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BA7jwV1POB7kacmB8yf4ISy5ZipGtl5hprHlPz6OxYRBjmvpGIHw3T01tfoTZCHF8
	 2LD/dv093ILRHTNlVP2UuTD8oGI9IZQ3NO679+vD3B10le06SweHndbGh0rBMEnkpB
	 7FyLrrxJdKZWlRN45i5BPpf/Xs7UPBuqQWJ5T2ffMgyW3KR0q2Qt5YD7o2e4TssLQ4
	 cqFU4IS4QZquk03rj/9u6CP4gLoyeJGl97L4G2tK7RrWVp0egrcMqxXmESEdYULD9m
	 FNFN8mnu7o7x0oFS9szdfvsoXGlNjxKqpKkkfCBXhUvkfgU7bn8wndAX35e95HNWAt
	 y03uK3BUjx/zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 128/244] cgroup: Disallow mounting v1 hierarchies without controller implementation
Date: Wed, 25 Sep 2024 07:25:49 -0400
Message-ID: <20240925113641.1297102-128-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
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


