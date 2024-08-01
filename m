Return-Path: <cgroups+bounces-4056-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AFB943FB2
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 03:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EDE1F22C56
	for <lists+cgroups@lfdr.de>; Thu,  1 Aug 2024 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A351EA0B6;
	Thu,  1 Aug 2024 00:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrh3kdfc"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB181EA0A9;
	Thu,  1 Aug 2024 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722472857; cv=none; b=DwbMYh2VOBXo0Gc+W+Jtxygf5zlgWyWd9nYZnY6tCByLx7vRnXq5SlXKTP0WmE3Lb/SMsLxp5kpntntb0PD4jFbb6+7X3AnFDyVSfLl1UZ2IYtj1EHLvz2h9ynXG7ZJRuM8W9XjHa55nMTOUqDc7Ww8dkizZNlq0yE9vRK9A+Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722472857; c=relaxed/simple;
	bh=UpIg0zSRrr8XrwEmCo8ZoxYT9yN7Ah1lm+XAwX9XGg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MP8e5RDDh1CbD9QuJDWC4yC78zENn/2wRTDQZ1fXwdsMV/4vpw2neHAolV7wcHONvZnCKi0LI434JTc+0rDoqBHRST3WisJ678sAeyiRJCb5a/reOSCZ5B8n5zf8Hm+biC4KR6Kvo1hYnN30LAU5Ca88efzKbQ2oRE7fbtj0HJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrh3kdfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A974FC116B1;
	Thu,  1 Aug 2024 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722472856;
	bh=UpIg0zSRrr8XrwEmCo8ZoxYT9yN7Ah1lm+XAwX9XGg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qrh3kdfcqCuTCOeaIvNXyVebsxjZKF2pywamazI7KjmzynzN/7WcHnjwu/W74vKel
	 xkYllf9IX8WtRgnvXMStM02pqztMaQK/tXVtMkXYp3ciWw2fXeGVuz3b9QSjiZh4ln
	 2b/5o5NC2eqRa03xJak36ViYnfoSYzty0t7xtFLa+E2E8hpydVK3qvZcwyG5ayLlmU
	 gKM+QhdcTjDzA1OJn5ooEXdXaHdNnas7QlitxVAwKbGw1Fboj8/jiGFBGWd+VAMlKO
	 UrzlsivVYUTzpT6BPlFhUj01ZMZtQB+uRE18NbXcwJ7C8FVXPkVdYkTjTJe78JxYHU
	 p+BQDAgoC/lOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/14] cgroup: Protect css->cgroup write under css_set_lock
Date: Wed, 31 Jul 2024 20:40:16 -0400
Message-ID: <20240801004037.3939932-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801004037.3939932-1-sashal@kernel.org>
References: <20240801004037.3939932-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.319
Content-Transfer-Encoding: 8bit

From: Waiman Long <longman@redhat.com>

[ Upstream commit 57b56d16800e8961278ecff0dc755d46c4575092 ]

The writing of css->cgroup associated with the cgroup root in
rebind_subsystems() is currently protected only by cgroup_mutex.
However, the reading of css->cgroup in both proc_cpuset_show() and
proc_cgroup_show() is protected just by css_set_lock. That makes the
readers susceptible to racing problems like data tearing or caching.
It is also a problem that can be reported by KCSAN.

This can be fixed by using READ_ONCE() and WRITE_ONCE() to access
css->cgroup. Alternatively, the writing of css->cgroup can be moved
under css_set_lock as well which is done by this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6322b56529e91..30c0588067029 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1712,9 +1712,9 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		RCU_INIT_POINTER(scgrp->subsys[ssid], NULL);
 		rcu_assign_pointer(dcgrp->subsys[ssid], css);
 		ss->root = dst_root;
-		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
+		css->cgroup = dcgrp;
 		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
 		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
 					 e_cset_node[ss->id]) {
-- 
2.43.0


