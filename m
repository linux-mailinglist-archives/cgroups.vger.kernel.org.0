Return-Path: <cgroups+bounces-3068-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6188D8A5F
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 21:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D051F2570B
	for <lists+cgroups@lfdr.de>; Mon,  3 Jun 2024 19:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE4A13A884;
	Mon,  3 Jun 2024 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhOax4BR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2277433A4
	for <cgroups@vger.kernel.org>; Mon,  3 Jun 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443529; cv=none; b=VLlXIr1KC+oKUL1QyG0+xXwLyCZQdMVONN84TdeXXl5eWeDRITlxiJohEp/6C4X2SDUkzkO8kABIjktZQ6icOzXYVJ3ptg32oLOk+xn+1d5SKzg8+pZt/SFAUD+4UvpTw+QeuID7DX5zzKsFGwH9Wf8GsWB0mlIfITBv3yiXULw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443529; c=relaxed/simple;
	bh=rBLf380duWASA+BHiufGZGEMzz9Q+lZrGAfvletpReU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O15/Bmfg5weAVX6KyP84d1rkHMROMzECktshVkTDi18QdN9drkMDM8beiTRxWA+BoiOlKEh/0hkgI2WVAXez7Q0gXi2tt1sxaRbsjuZmC/6YYycxwRrf9zTtyp8siT7rfSK1BYDp8qKydlVaJrl5jHyPi8Ms8DaCMWBnLzaR5uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhOax4BR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717443526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZRP6XsL9a0oYCQIdSQy4MFeP5v2pU/iHsNba/xl+gzk=;
	b=YhOax4BRANrldHjW+eGG2BTw1EyDAltUYMnG1RlvyueAaoqQPBIO7QzcbvG04kvRbMfaPi
	lcCotD5A81n1LC+kZ50KOVQqtj5qDdcGMnpVV5banhjP53GZp7bYrn2vai7JeNTsfASV6r
	mvZDsnbaNR92df+a7zQQCEZK4UpRtl4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-e6GYhzR6PTecxpOJjk52Hg-1; Mon, 03 Jun 2024 15:38:42 -0400
X-MC-Unique: e6GYhzR6PTecxpOJjk52Hg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE031184882A;
	Mon,  3 Jun 2024 19:38:41 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92A211C0D105;
	Mon,  3 Jun 2024 19:38:40 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup] cgroup/cpuset: Optimize isolated partition only generate_sched_domains() calls
Date: Mon,  3 Jun 2024 15:38:22 -0400
Message-Id: <20240603193822.1209999-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

If only isolated partitions are being created underneath the cgroup root,
there will only be one sched domain with top_cpuset.effective_cpus. We can
skip the unnecessary sched domains scanning code and save some cycles.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 315f8cbd6d35..f9b97f65e204 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -964,6 +964,7 @@ static int generate_sched_domains(cpumask_var_t **domains,
 
 	/* Special case for the 99% of systems with one, full, sched domain */
 	if (root_load_balance && !top_cpuset.nr_subparts) {
+single_root_domain:
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
 		if (!doms)
@@ -1022,6 +1023,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	}
 	rcu_read_unlock();
 
+	/*
+	 * If there are only isolated partitions underneath the cgroup root,
+	 * we can optimize out unneeded sched domains scanning.
+	 */
+	if (root_load_balance && (csn == 1))
+		goto single_root_domain;
+
 	for (i = 0; i < csn; i++)
 		csa[i]->pn = i;
 	ndoms = csn;
-- 
2.39.3


