Return-Path: <cgroups+bounces-4084-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46917947303
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 03:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BF1B20B78
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 01:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5913D897;
	Mon,  5 Aug 2024 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FehVzQ3I"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662C13D628
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821465; cv=none; b=kbrTqS39mByYk8RmoXgD7dASzIoxao9I0cJeTvoBqcGO+nf7Py5sOmBGWrr3ijt1dWxGlQ7hLsNfuXarsmaliLL53tk/Fs6z5bTrN574jmm/sWpSdv9f5h4Y4GPSQN65otLVVIwxJsAp/1zdPrViFwxTH6TtAcU+XyLMdYiWANk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821465; c=relaxed/simple;
	bh=ylZ3A6VIvKNpzMYzDc4pdc5uWXxiHdkjd4jxukjWzt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2N6UfaHxXqWp+GUTT37ZK/Og5M82mbKaZRMGn8L6sPXjWOqjVykOM7m+RqVAF1UyoNSLTuEMmneBLUej/xuoqT16ISxX24h0VNU6VV5DI3rD5cpi/WAdjA4BSn6rlOKpwjMcjMdw9lkab+VuMoB6+Xnd2HpZf7hSeuY5EqnHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FehVzQ3I; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3MlJNHfxT1aqtDvO1F0M3+o6Fo/uaaUDc5R0lfvrDMA=;
	b=FehVzQ3I0QRuxwibUH+w5N6qYlrzVtnJOOT+XcK/2LtniA8vT58w6dOC2xeLx7pQSkOD0O
	B0v0ugEGk8Zs/hHAB43pcgR505w9ycWhVKq4hHMPX0+FxqYD5sMu/von43Sdiw1TkdF0aJ
	2cGy9VfzhLWhqkbyZxR2VKOrh0xG52o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-AChQeFaMMci5PF72oufDhA-1; Sun,
 04 Aug 2024 21:30:59 -0400
X-MC-Unique: AChQeFaMMci5PF72oufDhA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D561195608A;
	Mon,  5 Aug 2024 01:30:57 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E0FF1955F40;
	Mon,  5 Aug 2024 01:30:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Chen Ridong <chenridong@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 4/5] cgroup/cpuset: Check for partition roots with overlapping CPUs
Date: Sun,  4 Aug 2024 21:30:18 -0400
Message-ID: <20240805013019.724300-5-longman@redhat.com>
In-Reply-To: <20240805013019.724300-1-longman@redhat.com>
References: <20240805013019.724300-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With the previous commit that eliminates the overlapping partition
root corner cases in the hotplug code, the partition roots passed down
to generate_sched_domains() should not have overlapping CPUs. Enable
overlapping cpuset check for v2 and warn if that happens.

This patch also has the benefit of increasing test coverage of the new
Union-Find cpuset merging code to cgroup v2.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e070e391d7a8..e34fd6108b06 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1127,25 +1127,27 @@ static int generate_sched_domains(cpumask_var_t **domains,
 	if (root_load_balance && (csn == 1))
 		goto single_root_domain;
 
-	if (!cgrpv2) {
-		for (i = 0; i < csn; i++)
-			uf_node_init(&csa[i]->node);
-
-		/* Merge overlapping cpusets */
-		for (i = 0; i < csn; i++) {
-			for (j = i + 1; j < csn; j++) {
-				if (cpusets_overlap(csa[i], csa[j]))
-					uf_union(&csa[i]->node, &csa[j]->node);
+	for (i = 0; i < csn; i++)
+		uf_node_init(&csa[i]->node);
+
+	/* Merge overlapping cpusets */
+	for (i = 0; i < csn; i++) {
+		for (j = i + 1; j < csn; j++) {
+			if (cpusets_overlap(csa[i], csa[j])) {
+				/*
+				 * Cgroup v2 shouldn't pass down overlapping
+				 * partition root cpusets.
+				 */
+				WARN_ON_ONCE(cgrpv2);
+				uf_union(&csa[i]->node, &csa[j]->node);
 			}
 		}
+	}
 
-		/* Count the total number of domains */
-		for (i = 0; i < csn; i++) {
-			if (uf_find(&csa[i]->node) == &csa[i]->node)
-				ndoms++;
-		}
-	} else {
-		ndoms = csn;
+	/* Count the total number of domains */
+	for (i = 0; i < csn; i++) {
+		if (uf_find(&csa[i]->node) == &csa[i]->node)
+			ndoms++;
 	}
 
 	/*
-- 
2.43.5


