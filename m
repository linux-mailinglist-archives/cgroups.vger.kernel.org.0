Return-Path: <cgroups+bounces-7400-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44416A7EFBF
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 23:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA19F17C626
	for <lists+cgroups@lfdr.de>; Mon,  7 Apr 2025 21:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB0722422D;
	Mon,  7 Apr 2025 21:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQ3hUieP"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757F21C9F8
	for <cgroups@vger.kernel.org>; Mon,  7 Apr 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744060932; cv=none; b=EROHbHp9Q4KcoVrEgGXWs9YbjpzzkG/AA3flsM9zVqt1JIowahPh80LtxJUTdJkB9oKjGeFu1P+M3P6Ya75MIctVFwRcewk2qbKkPmDfJo8wYJXVzSLaAhHbACzb3iNWmJCIGLpuKrZPTDNubCEeRJOA2orSFKsOiuhu+WSKLLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744060932; c=relaxed/simple;
	bh=EfF4dAbUv6xiHbKdAZn9zu83Y5I8dMHD1u4TY/zaCGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lU0LM3o9i96feqTWRNfV4xRwKSghk8uJUcus7AQNPDDsja24ihslQWSdz39bpe20buWRdUX87x52USYZ/ukmaMgU7rHZyylrIzOF5/E8SNJjGVrmFEPYsmb4pdg8fmJNwxYsInWMECdVGm5Ym6U7zjhlIxJZq1cC0LPmbRx99z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQ3hUieP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744060929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHK0+caqHkWkmDYmUREBSe8ATHgicW3LTgCek9DEivA=;
	b=EQ3hUiePWcLV2UqkdB2GAoRrYVzYAahrOw6KmIzzCGXcNju2ofOL1Nw82r4swoQQQWgP1c
	lSBbhd0xmxFtgJwEE4h/ANpaMs+IQttoZq+2ld/bC/JlbSQkep/DzlnGOkGoXqjYED0czW
	P8Hq7ZlXdlMCiuO9yVvL3IuJfK4ATOQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-R2lktt8sP8uNOuFnpPEyLg-1; Mon,
 07 Apr 2025 17:22:08 -0400
X-MC-Unique: R2lktt8sP8uNOuFnpPEyLg-1
X-Mimecast-MFC-AGG-ID: R2lktt8sP8uNOuFnpPEyLg_1744060927
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B685819560BB;
	Mon,  7 Apr 2025 21:22:06 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.98])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B040180A803;
	Mon,  7 Apr 2025 21:22:05 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/3] cgroup/cpuset: Fix obsolete comment in cpuset_css_offline()
Date: Mon,  7 Apr 2025 17:21:04 -0400
Message-ID: <20250407212127.1534285-3-longman@redhat.com>
In-Reply-To: <20250407212127.1534285-1-longman@redhat.com>
References: <20250407212127.1534285-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Move the partition disablement comment from cpuset_css_offline()
to cpuset_css_killed() and reword it to remove the remnant of
sched.partition.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 583f20942802..1497a2a4b2a3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3538,11 +3538,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
  * will call rebuild_sched_domains_locked(). That is not needed
  * in the default hierarchy where only changes in partition
  * will cause repartitioning.
- *
- * If the cpuset has the 'sched.partition' flag enabled, simulate
- * turning 'sched.partition" off.
  */
-
 static void cpuset_css_offline(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
@@ -3560,6 +3556,11 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpus_read_unlock();
 }
 
+/*
+ * If a dying cpuset has the 'cpus.partition' enabled, turn it off by
+ * changing it back to member to free its exclusive CPUs back to the pool to
+ * be used by other online cpusets.
+ */
 static void cpuset_css_killed(struct cgroup_subsys_state *css)
 {
 	struct cpuset *cs = css_cs(css);
-- 
2.48.1


