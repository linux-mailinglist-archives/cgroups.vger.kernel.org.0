Return-Path: <cgroups+bounces-8075-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006BAAE913
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 20:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06254E545D
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 18:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CBD28E590;
	Wed,  7 May 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwDVncHX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE428DF50
	for <cgroups@vger.kernel.org>; Wed,  7 May 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642639; cv=none; b=ko2+7KWOK3tebuZfkiDg6BBznrWp+JU5AOQxYlQHKzEvB7qsU0MGHD+K0ZDGtAGHG11APvLxyNVGB6tADhNeVK/A7Hldb06o/SlPalM8sSbgZLqYkMBxt5xz8l3JYKl3NtYSW+Jfrxv+60+UazPf+rxM565s8R/ZmhbWLosyLdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642639; c=relaxed/simple;
	bh=N2sGjyf0ew84NvwqalybuidwPrX4ySiWi0Sblpa+XV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o8MyyUpTecW2/syLbPKayCkLxD2sGIx52sjEQ6Q7fSPKybQi1gjsj8wEEsFWqsGrm1MbgRp5xjHJQMLvkhvWjV/8lEZaAZbaadsogmtQcPmwJHcAQWIGVkCqyuwtKAHWw7Eon4Yg+9/tE55RB7phPUBTPXouYeIt/Z6WkSp39Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TwDVncHX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746642636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H7D8p2kvyzYhC1aQiNjgJ3Kur9pgjMPJPiAXQiYVvL4=;
	b=TwDVncHXSbbLMWkczm4Ye6aUbDgGKMLAQl/vueMQBYt9WOSlB7/wi13m7mMF1wBg4Fx8ri
	45+SXztJiBZePKTVu54oSTcgiGSUYZScMLgdr5u3lJ+oUcxAnM0v/sEg3KsT8mTS572DCZ
	jhGQDeGzM+V5xcECEN5INuw/PjVOdCc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-lBb3vKCgNcqPJx8hribFQw-1; Wed,
 07 May 2025 14:30:31 -0400
X-MC-Unique: lBb3vKCgNcqPJx8hribFQw-1
X-Mimecast-MFC-AGG-ID: lBb3vKCgNcqPJx8hribFQw_1746642630
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19E011955DC5;
	Wed,  7 May 2025 18:30:30 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.66.1])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5183619560A7;
	Wed,  7 May 2025 18:30:28 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks
Date: Wed,  7 May 2025 14:30:11 -0400
Message-ID: <20250507183011.550307-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
on top_cpuset") enabled us to pull CPUs dedicated to child partitions
from tasks in top_cpuset by ignoring per cpu kthreads. However, there
can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
flag set to indicate that we shouldn't mess with their CPU affinity.

As all the per cpu kthreads have PF_NO_SETAFFINITY set, fix this
issue by dropping the kthread_is_per_cpu() check and checking the
PF_NO_SETAFFINITY flag instead.

Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d0143b3dce47..581032d73e4b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1130,9 +1130,9 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 		if (top_cs) {
 			/*
-			 * Percpu kthreads in top_cpuset are ignored
+			 * PF_NO_SETAFFINITY tasks are ignored
 			 */
-			if (kthread_is_per_cpu(task))
+			if (task->flags & PF_NO_SETAFFINITY)
 				continue;
 			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
 		} else {
-- 
2.49.0


