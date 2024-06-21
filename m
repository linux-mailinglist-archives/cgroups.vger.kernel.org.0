Return-Path: <cgroups+bounces-3262-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE7911CEF
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A51C21083
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2024 07:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E9C13B59E;
	Fri, 21 Jun 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVcPkD5M"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997273AC1F
	for <cgroups@vger.kernel.org>; Fri, 21 Jun 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955336; cv=none; b=fQ2J64F1dY0RDhv2x/9IUg7QszkV9/GWef8dMXePnft8F4pvd3FRsVQPEowCtozMeRElynpFPlgOijYwpiRqeR5njU4WOTUvwef5dVlHyp7mtXHfSX98KlDraRIKTWMA/AscFiTbC2+6yeO1Ikt3I2idh9R26+9i45x/c0uHgIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955336; c=relaxed/simple;
	bh=6nWKfd9njzUJuwL/S+Z4UTu+ZlA0JRTziO0WkrYoQaQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=grOCEzfvXeEtecjv8JpNBel6rP4B/YKq/4OgBGRjKIlhDR9NV7FCqi8TW/I9lqu/7ZWlep7AtxFYLD54EBMlnhRFqCnV4FrFzlJmXc0aLa5FAjzJt5H4VAg/DeZUGXeL/XoEJ1rxhEKNtZ4OAOnODsgdUcr6tJ92H9Yo5SsdkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVcPkD5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6FEC2BBFC;
	Fri, 21 Jun 2024 07:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718955336;
	bh=6nWKfd9njzUJuwL/S+Z4UTu+ZlA0JRTziO0WkrYoQaQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VVcPkD5MguWMmWjoGNRk2AiKGsiWdFnk2yJwKyj34mfrxWfP2Bcnf2QpSYRVpfGTJ
	 iFlsVgJpM+RHqaWuSYCr/9+H4vZR7RJihKTnafQqikD3+ZCH/4LO+UEpDmExHXcpt5
	 ONxMY2NBw3kBlQYrJbwebKZO80IOB8Zp3XnkNTT9xd7SpK08XeHxFG/yzA5udZzLAt
	 SdWJo9juVUy++nVlCMsigJI3fxwPG48AWX3C7QW6RoB9hl6rhC3ccwxOHDgAi7uumA
	 MAjJszpmVuC4qF5TOx8s8RjbU7e29FfnO3XQXuDGnlP89kM8vkrGUuI1/+JAYnnMqD
	 Ve72eTTcXEy6Q==
Subject: [PATCH RFC] cgroup/rstat: avoid thundering herd problem on root cgrp
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com
Date: Fri, 21 Jun 2024 09:35:31 +0200
Message-ID: <171895533185.1084853.3033751561302228252.stgit@firesoul>
In-Reply-To: <c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org>
References: <c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

RFC followup to "looking into coding this up"
 - https://lore.kernel.org/all/c0fb8c2d-433d-4f8a-a06d-e6ca578ebbf0@kernel.org/

If there are better way to if cgroup_is_root of rstat tree?

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
 include/linux/cgroup.h |    5 +++++
 kernel/cgroup/rstat.c  |   21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..ad41cca5c3b6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -499,6 +499,11 @@ static inline struct cgroup *cgroup_parent(struct cgroup *cgrp)
 	return NULL;
 }
 
+static inline bool cgroup_is_root(struct cgroup *cgrp)
+{
+	return cgroup_parent(cgrp) == NULL;
+}
+
 /**
  * cgroup_is_descendant - test ancestry
  * @cgrp: the cgroup to be tested
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index fb8b49437573..5979f3dc2069 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,7 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static atomic_t root_rstat_flush_ongoing = ATOMIC_INIT(0);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -350,8 +351,20 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	might_sleep();
 
+	if (atomic_read(&root_rstat_flush_ongoing))
+		return;
+
+	if (cgroup_is_root(cgrp) &&
+	    atomic_xchg(&root_rstat_flush_ongoing, 1))
+		return;
+
 	__cgroup_rstat_lock(cgrp, -1);
+
 	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_is_root(cgrp))
+		atomic_set(&root_rstat_flush_ongoing, 0);
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 
@@ -368,7 +381,12 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
+
 	__cgroup_rstat_lock(cgrp, -1);
+
+	if (atomic_read(&root_rstat_flush_ongoing))
+		return;
+
 	cgroup_rstat_flush_locked(cgrp);
 }
 
@@ -379,6 +397,9 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
+	if (cgroup_is_root(cgrp))
+		atomic_set(&root_rstat_flush_ongoing, 0);
+
 	__cgroup_rstat_unlock(cgrp, -1);
 }
 



