Return-Path: <cgroups+bounces-6835-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C5A4F5FA
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 05:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A689816C089
	for <lists+cgroups@lfdr.de>; Wed,  5 Mar 2025 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC561A4F09;
	Wed,  5 Mar 2025 04:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VkO5uIw7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429411A0BED;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741147989; cv=none; b=gG3zlYZRxP5JuA7sIKjbJV7tFZC8tVkfy3XuqrizHspYcpfn8hNOtwQuLII47IBz8TJQkQFlC0/t0dFF4NFn5I6eFCL/aogZoX73z1KyXCUMMaBH1pYE0J1keY+6zC8VV++5dgPT440dayA4b7biFdwUz3+UEiaSC9OMezbA3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741147989; c=relaxed/simple;
	bh=GG/SZGLYIJOwryBChnG1M6utn7gxrLvcU3NJELfUlj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPIOGVbviw+PoNVjGjPyhvwAoekiqUZNj2rtUuq4MSK4yjKCnzPu3CoLdM6z8w4hxKV8tF4gUPo17YCWn0x1/KNmdGwsId/8I5froRjU/9LPQ+AHp07VmG5nZ21GNePR8Flt7EB7EoPfpyJt73PhP3UQ0qc3L8G5/y4Q5rB23oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VkO5uIw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACA69C4CEE7;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741147988;
	bh=GG/SZGLYIJOwryBChnG1M6utn7gxrLvcU3NJELfUlj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VkO5uIw7ae1NVXr8S9pkURRPuvprT9UqyLAWw7fM1fOU8qNd1HFATL/lSaLpgrAEk
	 E3mLTQxzsX/d/1tB9EvGPwYk15k8D8yLEBZHhArZyaHalXc2LjVagBAYAy6BHkETen
	 hvkwDvpuMQ+q8h3UTh29Q1sfefXvMq2TaWRRGG87P582kRe8xVLefL28cM9DyuY8Jd
	 4dy8ZAliy+ntXAScfLYObKI7FDsk4sSQFb/cMCbnMfSZdrSAYj6MxWJlbGAQh8kqW7
	 zJeWz5uvivZcgXc27dSykQTXz2B88VMcj11LiyCEEjKfoFcHsnvSC/mDZDSGFVoAIK
	 FurPXGEkaVIHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F16C282D3;
	Wed,  5 Mar 2025 04:13:08 +0000 (UTC)
From: Shashank Balaji via B4 Relay <devnull+shashank.mahadasyam.sony.com@kernel.org>
Date: Wed, 05 Mar 2025 13:12:43 +0900
Subject: [PATCH 1/2] cgroup, docs: Be explicit about independence of
 RT_GROUP_SCHED and non-cpu controllers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-rt-and-cpu-controller-doc-v1-1-7b6a6f5ff43d@sony.com>
References: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
In-Reply-To: <20250305-rt-and-cpu-controller-doc-v1-0-7b6a6f5ff43d@sony.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shinya Takumi <shinya.takumi@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=/4pX+lji8gdMF5fk81/FrjcxVt66tCgC2wZaTKjforA=;
 b=owGbwMvMwCV2mPH4Ij++H1mMp9WSGNKPnw++Yi2xcdGkB1eEW7keJWp+K955fdK19u37b2ZkF
 zdGHKpz7ihlYRDjYpAVU2R5J7PuwkEry6avxxm+wcxhZQIZwsDFKQATiVJgZOgJ6J4Re2LRn01V
 Uv+SpCwslALOXahLLOroElESzPJ6vZCR4VZ7kMi96EjTksmp9gr/uDSb1z0RNHhZKngo+3xT0/f
 rbAA=
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=EE1CAED0C13A3982F5C700F6C301C7A24E0EF86A
X-Endpoint-Received: by B4 Relay for shashank.mahadasyam@sony.com/default
 with auth_id=354
X-Original-From: Shashank Balaji <shashank.mahadasyam@sony.com>
Reply-To: shashank.mahadasyam@sony.com

From: Shashank Balaji <shashank.mahadasyam@sony.com>

The cgroup v2 cpu controller has a limitation that if
CONFIG_RT_GROUP_SCHED is enabled, the cpu controller can be enabled only
if all the realtime processes are in the root cgroup. The other
controllers have no such restriction. They can be used for the resource
control of realtime processes irrespective of whether
CONFIG_RT_GROUP_SCHED is enabled or not.

Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e267c24d7f4f69564c16fb29c4d89..f293a13b42ed69e7c6bf5e974cb86e228411af4e 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1076,15 +1076,20 @@ cpufreq governor about the minimum desired frequency which should always be
 provided by a CPU, as well as the maximum desired frequency, which should not
 be exceeded by a CPU.
 
-WARNING: cgroup2 doesn't yet support control of realtime processes. For
-a kernel built with the CONFIG_RT_GROUP_SCHED option enabled for group
-scheduling of realtime processes, the cpu controller can only be enabled
-when all RT processes are in the root cgroup.  This limitation does
-not apply if CONFIG_RT_GROUP_SCHED is disabled.  Be aware that system
-management software may already have placed RT processes into nonroot
-cgroups during the system boot process, and these processes may need
-to be moved to the root cgroup before the cpu controller can be enabled
-with a CONFIG_RT_GROUP_SCHED enabled kernel.
+WARNING: cgroup2 cpu controller doesn't yet fully support the control of
+realtime processes. For a kernel built with the CONFIG_RT_GROUP_SCHED option
+enabled for group scheduling of realtime processes, the cpu controller can only
+be enabled when all RT processes are in the root cgroup. Be aware that system
+management software may already have placed RT processes into non-root cgroups
+during the system boot process, and these processes may need to be moved to the
+root cgroup before the cpu controller can be enabled with a
+CONFIG_RT_GROUP_SCHED enabled kernel.
+
+With CONFIG_RT_GROUP_SCHED disabled, this limitation does not apply and some of
+the interface files either affect realtime processes or account for them. See
+the following section for details. Only the cpu controller is affected by
+CONFIG_RT_GROUP_SCHED. Other controllers can be used for the resource control of
+realtime processes irrespective of CONFIG_RT_GROUP_SCHED.
 
 
 CPU Interface Files

-- 
2.43.0



