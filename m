Return-Path: <cgroups+bounces-2686-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8076B8AFD85
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 03:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B461C21F52
	for <lists+cgroups@lfdr.de>; Wed, 24 Apr 2024 01:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0299538A;
	Wed, 24 Apr 2024 01:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c+zG8jBR"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF92C4A32
	for <cgroups@vger.kernel.org>; Wed, 24 Apr 2024 01:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920457; cv=none; b=oQr8Y4vrp0Fa9ULSyzXA7Ieg0L9z/NKB7SwoeXaN8BCSz2TY6VwZmZJgLhAzhjT2vzKGvMsdAghniynPVXAJrRvFdAApodFp2EgtTlH7pIKsGmVxijic4ypSDUF7j/v8kcajhBGRNzf99jWMonoh3rNo6Zir81CMiODX8AYSaYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920457; c=relaxed/simple;
	bh=S+0/yfWEbTG33zVAf3a7JUyadtPHjguQhf9rNUpBUYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYlGErhaI7tO4xdGiXBe5+8n640Q0J0eTQJq3s4vYNMjWkvIzXJIYyEcpO3V+WwXC2YwizYQcXN4JOjrV1+LDX0uIFmJBhfxDYvW2vWKb2rUlqtJMgWwmxp9tHRX+l8jk3wgkqbJmyjGNel1/cRQofbmC35VWqefByjmvV4nIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c+zG8jBR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713920454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/a5fhFSmdofMCiLnLbJwkC2x6hk67MrQy10O1DXKAP4=;
	b=c+zG8jBR55f2vgSEMQRpRGEH+9Cxa94XcUQoUiYkfI5fbCiYoUnCEW46rHvxRiKmEkvHiI
	VJTQaUPbWfH4XRWX/6c5Muk/fb8eMo3K/Bf3RZB2DlgMaZgZCRYoFQnEED8gFzGCJICN+G
	FvTUh3p0mvtQPPfNqt+taqVxX8HpoRw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-Ou3fZRdJMUu6vLcO4XX7Uw-1; Tue,
 23 Apr 2024 21:00:49 -0400
X-MC-Unique: Ou3fZRdJMUu6vLcO4XX7Uw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E5CB385A185;
	Wed, 24 Apr 2024 01:00:49 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.184])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5757C13FA3;
	Wed, 24 Apr 2024 01:00:47 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup] cgroup/cpuset: Fix incorrect top_cpuset flags
Date: Tue, 23 Apr 2024 21:00:20 -0400
Message-Id: <20240424010020.181305-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Commit 8996f93fc388 ("cgroup/cpuset: Statically initialize more
members of top_cpuset") uses an incorrect "<" relational operator for
the CS_SCHED_LOAD_BALANCE bit when initializing the top_cpuset. This
results in load_balancing turned off by default in the top cpuset which
is bad for performance.

Fix this by using the BIT() helper macro to set the desired top_cpuset
flags and avoid similar mistake from being made in the future.

Fixes: 8996f93fc388 ("cgroup/cpuset: Statically initialize more members of top_cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e70008a1d86a..b0a97efa5f20 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -368,8 +368,8 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
 }
 
 static struct cpuset top_cpuset = {
-	.flags = ((1 << CS_ONLINE) | (1 << CS_CPU_EXCLUSIVE) |
-		  (1 << CS_MEM_EXCLUSIVE) | (1 < CS_SCHED_LOAD_BALANCE)),
+	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
+		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
 	.relax_domain_level = -1,
 	.remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
-- 
2.39.3


