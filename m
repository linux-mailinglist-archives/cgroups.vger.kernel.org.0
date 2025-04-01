Return-Path: <cgroups+bounces-7283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F826A7812A
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 19:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D23165209
	for <lists+cgroups@lfdr.de>; Tue,  1 Apr 2025 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E720D509;
	Tue,  1 Apr 2025 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VJ18IaoB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2664A2EAF7
	for <cgroups@vger.kernel.org>; Tue,  1 Apr 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743527382; cv=none; b=kaM7R18v9ogRGTwe0eRP0BUl9ZP5foICL8l4niEpCzSaiPtdgfnejWceLbYPnXsyrVUL7s9HC1tKp0DphVgaRL0V7/VYfafKRDBhOsa1OTcDJmjCpmMibZa3WitSnNp3Tvo4xy+br0kZOfP5JGvU+chrvQrnAXeOqevScsn2hrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743527382; c=relaxed/simple;
	bh=Vri8e4TPoGXUdzdKBijDhIyZkGhoJPzEHWiKCLNhT3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fb1684x8OdJQT0nQ2Y/6bQhG9XxqVUwURyYyb8GaACJtqBjtOlwBmOwl4c9FFAJmhkstlXVrIyQHKS9n/t6HOtnmCNp/7mMcRKyoqaERtVGBA8gpnxNnTzcwsPz/rdgd6EAvnLC8W0SkUhaMxBI2sk6yaZarfwXBrkysQpAVhgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VJ18IaoB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743527378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kBnwje6boVgUJxbB8QyKCSQJNJwRZTVBfAi5NgyEuuA=;
	b=VJ18IaoBTFLbEqhjH/GJqSFX0CUSbMuXtCDIkqBd9RlIgYodyDWiMcVSRWvX9/mEIMTqyU
	7qRcv7bLgfI+skHZYiqcEdbVNUjEHKMFcfkzvuV2wWmXNE5z9OInfX6RpUMJgef/FRBClH
	RGpUIO8Q8JqC+eZyfJOcA3UM72wPBF4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH] cgroup: rstat: call cgroup_rstat_updated_list with cgroup_rstat_lock
Date: Tue,  1 Apr 2025 10:09:12 -0700
Message-ID: <20250401170912.2161953-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The commit 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and
locking") during cleanup accidentally changed the code to call
cgroup_rstat_updated_list() without cgroup_rstat_lock which is required.
Fix it.

Fixes: 093c8812de2d ("cgroup: rstat: Cleanup flushing functions and locking")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Reported-by: Breno Leitao <leitao@debian.org>
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/all/6564c3d6-9372-4352-9847-1eb3aea07ca4@linux.ibm.com/
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 kernel/cgroup/rstat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 4bb587d5d34f..b2239156b7de 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -318,10 +318,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 
 	might_sleep();
 	for_each_possible_cpu(cpu) {
-		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
+		struct cgroup *pos;
 
 		/* Reacquire for each CPU to avoid disabling IRQs too long */
 		__cgroup_rstat_lock(cgrp, cpu);
+		pos = cgroup_rstat_updated_list(cgrp, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
-- 
2.47.1


