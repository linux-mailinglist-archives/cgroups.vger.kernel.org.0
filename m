Return-Path: <cgroups+bounces-9209-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F196B27CED
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 11:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81CD626376
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 09:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187526E6FF;
	Fri, 15 Aug 2025 09:15:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EDE20013A;
	Fri, 15 Aug 2025 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755249341; cv=none; b=QxOhUMKIYF5lNJsVgRoxhNRzoq8zyQMTlgSz1JpMrMqWz7clx4XnjPbPlHELX+3KajJ4kTJaInuf/c2DaL6+Gku0zo1/H/wfeTj489++8I9h7OWE2o343PXq70HJdmiSYjw5ksj3bOkOwH//EYa7BL6RsYabNEvtvQ6DcUl4r0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755249341; c=relaxed/simple;
	bh=nVIvDBy/Jm3WR2xeA1aZWmOPqonh3tIFG7Otxlac60o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cWhomrzgt0zh1qmgTR6xyfphxsGaCS/UOaZzi+F81gDq8uYzXuGn9WPwATto2J16WaytfSoHtiW7U5G0sCdI+8GABywRzTykq0+QuiYZqcQqKBP/ISmgFqRnTteXfm85KiHKxmxHowiYpp6FdBL9wiruTtUUGA6765w8vyA7ntE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: <tj@kernel.org>, <hannes@cmpxchg.org>, <mkoutny@suse.com>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] cgroup: Remove redundant rcu_read_lock() in spin_lock_irq() section
Date: Fri, 15 Aug 2025 17:14:30 +0800
Message-ID: <20250815091430.8694-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM

From: Li RongQing <lirongqing@baidu.com>

Since spin_lock_irq() already disables preemption and task_css_set()
is protected by css_set_lock, the rcu_read_lock() calls are unnecessary
within the critical section. Remove them to simplify the code.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 kernel/cgroup/cgroup.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8..db9e00a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2944,14 +2944,12 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 	/* look up all src csets */
 	spin_lock_irq(&css_set_lock);
-	rcu_read_lock();
 	task = leader;
 	do {
 		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
 		if (!threadgroup)
 			break;
 	} while_each_thread(leader, task);
-	rcu_read_unlock();
 	spin_unlock_irq(&css_set_lock);
 
 	/* prepare dst csets and commit */
-- 
2.9.4


