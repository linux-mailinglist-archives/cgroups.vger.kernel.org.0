Return-Path: <cgroups+bounces-8096-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25792AB03A1
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 21:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953F55261A8
	for <lists+cgroups@lfdr.de>; Thu,  8 May 2025 19:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF17C28A720;
	Thu,  8 May 2025 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJ+vUbzv"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0CE28A408
	for <cgroups@vger.kernel.org>; Thu,  8 May 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732293; cv=none; b=S/MPpxp1CaY9Vly3tG5KM1ftmQf56tsZuhWRm5ez8wopFnDH1ln+KmDZTrCq2+lApQ/ZOe2nAVVGs56vfM9WoID65raMqrDxVwFLYizoUr3bRnzFcYSY2AtmPD+AyC3vMMkJSDMDvX6Hr8WT/OcKtG4neNQQagO1VEifO370W+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732293; c=relaxed/simple;
	bh=kkV+F1ByaoKZGM9d+pbw2Ilzb3owLbh+EnVo+YHDRK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iiUmkxpwVde42oHao5gZa8iiLGRDcDskNAJNRVkEu0/Zt7dKC8KRxCBqDY2A7rP41QCBm0Zyl8HYTPJebuB2jtCziGfkqgUrrXz92uxYAcdlNgjHs4YUHpNHKayfxcWBUATD9C5BUYSNwv9Qw9vWgGk1P5ZeuDScXApBjQbY5Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJ+vUbzv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746732291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Jk9BcAtjAQU7ACRspfJrIgdim0aAe9DgFo93JV5TtM=;
	b=MJ+vUbzv54ToTlupDmopWtYIT82Zda135lEY/kOordEWfXFkQ2Rn9yV9lzKVDw9nYj2Tro
	bIRCwBecwn6lkH4RIOL6NW+ml9GbLE8vWTis/zVZFQg1cEMD55WIuALvkj6gTj+tqKPNvU
	v4X55CI5qVUihOK7vcGcgRc/J0ERWsw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-7h6oFesUMZyGiv2dv63_-A-1; Thu,
 08 May 2025 15:24:39 -0400
X-MC-Unique: 7h6oFesUMZyGiv2dv63_-A-1
X-Mimecast-MFC-AGG-ID: 7h6oFesUMZyGiv2dv63_-A_1746732268
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D0A21955DB9;
	Thu,  8 May 2025 19:24:28 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23D901955F24;
	Thu,  8 May 2025 19:24:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks
Date: Thu,  8 May 2025 15:24:13 -0400
Message-ID: <20250508192413.615512-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
on top_cpuset") enabled us to pull CPUs dedicated to child partitions
from tasks in top_cpuset by ignoring per cpu kthreads. However, there
can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
flag set to indicate that we shouldn't mess with their CPU affinity.
For other kthreads, their affinity will be changed to skip CPUs dedicated
to child partitions whether it is an isolating or a scheduling one.

As all the per cpu kthreads have PF_NO_SETAFFINITY set, the
PF_NO_SETAFFINITY tasks are essentially a superset of per cpu kthreads.
Fix this issue by dropping the kthread_is_per_cpu() check and checking
the PF_NO_SETAFFINITY flag instead.

Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d0143b3dce47..967603300ee3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1130,9 +1130,11 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 		if (top_cs) {
 			/*
-			 * Percpu kthreads in top_cpuset are ignored
+			 * PF_NO_SETAFFINITY tasks are ignored.
+			 * All per cpu kthreads should have PF_NO_SETAFFINITY
+			 * flag set, see kthread_set_per_cpu().
 			 */
-			if (kthread_is_per_cpu(task))
+			if (task->flags & PF_NO_SETAFFINITY)
 				continue;
 			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
 		} else {
-- 
2.49.0


