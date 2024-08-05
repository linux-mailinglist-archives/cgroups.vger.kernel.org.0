Return-Path: <cgroups+bounces-4083-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31F947302
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 03:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CFD11F211A1
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859BB13C906;
	Mon,  5 Aug 2024 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX5pLl34"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471013D524
	for <cgroups@vger.kernel.org>; Mon,  5 Aug 2024 01:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722821463; cv=none; b=YtSkSfror6+NN4/7FLtGJiWTAVeF7sEbxr3CDVII2TMu/0wzUdyJEOR7wks7B19E4UT/tugJKxMxK01QFPCdz5Y31M8/IKk09Fm2kpsTwFDlhlE1l92mjT/SW7uJCIs2t53Nwbt+RkWEW35X50j5lCR1ZngfpigOff4RId9JOeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722821463; c=relaxed/simple;
	bh=0OQIq6EmZJ0HmRr8b7d0sV3ZnAl1teu6B5a0IB6BF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJjs1GHTm9I0Xn1aG+m/N/NUiovNHP997+IojTxLgK7tpr4NXWS+sxzmcn5pLJsUgeTTJCy6y92PrYHPXhmUUoy2opif8m6Q2WcvwqrUPlZOR5Y8l4EX/UvFqCM2xAsJaDH667UrT+mvnQzGPyj5OWjyCrhCdEv92QaGTFRuBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EX5pLl34; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722821461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRUJt2egi+CPulZ04jC4gpWP21ZBU0lpCZ8ow9/DXIQ=;
	b=EX5pLl34ZCGUptzNEdJWybqYsaLLvKADOrT4KBKEht/lgO/gqA5ne+RWrche6wZV5S9Ezg
	9eD2pShOFpQ80dCHfKhUv8aoZECU8mKT7BDVDYEVbs9GxOs109dXYnk4e5Grt5Ofpfue3H
	1fSbXZQQmVH33wz3c48zZOplYiqzM7A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ZAfL3G4PMcCaNWwzn1ZIhw-1; Sun,
 04 Aug 2024 21:30:54 -0400
X-MC-Unique: ZAfL3G4PMcCaNWwzn1ZIhw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 893611956064;
	Mon,  5 Aug 2024 01:30:52 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 43D731955F40;
	Mon,  5 Aug 2024 01:30:50 +0000 (UTC)
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
Subject: [PATCH-cgroup 2/5] cgroup/cpuset: Clear effective_xcpus on cpus_allowed clearing only if cpus.exclusive not set
Date: Sun,  4 Aug 2024 21:30:16 -0400
Message-ID: <20240805013019.724300-3-longman@redhat.com>
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

Commit e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for
v2") adds a user writable cpuset.cpus.exclusive file for setting
exclusive CPUs to be used for the creation of partitions. Since then
effective_xcpus depends on both the cpuset.cpus and cpuset.cpus.exclusive
setting. If cpuset.cpus.exclusive is set, effective_xcpus will depend
only on cpuset.cpus.exclusive.  When it is not set, effective_xcpus
will be set according to the cpuset.cpus value when the cpuset becomes
a valid partition root.

When cpuset.cpus is being cleared by the user, effective_xcpus should
only be cleared when cpuset.cpus.exclusive is not set. However, that
is not currently the case.

  # cd /sys/fs/cgroup/
  # mkdir test
  # echo +cpuset > cgroup.subtree_control
  # cd test
  # echo 3 > cpuset.cpus.exclusive
  # cat cpuset.cpus.exclusive.effective
  3
  # echo > cpuset.cpus
  # cat cpuset.cpus.exclusive.effective // was cleared

Fix it by clearing effective_xcpus only if cpuset.cpus.exclusive is
not set.

Fixes: e2ffe502ba45 ("cgroup/cpuset: Add cpuset.cpus.exclusive for v2")
Reported-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f1846a08e245..7287cecb27d1 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2508,7 +2508,8 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	 */
 	if (!*buf) {
 		cpumask_clear(trialcs->cpus_allowed);
-		cpumask_clear(trialcs->effective_xcpus);
+		if (cpumask_empty(trialcs->exclusive_cpus))
+			cpumask_clear(trialcs->effective_xcpus);
 	} else {
 		retval = cpulist_parse(buf, trialcs->cpus_allowed);
 		if (retval < 0)
-- 
2.43.5


