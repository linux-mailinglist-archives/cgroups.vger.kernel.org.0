Return-Path: <cgroups+bounces-11811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D36FC4E32E
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 14:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68141188AC81
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD838342539;
	Tue, 11 Nov 2025 13:39:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246DB328277;
	Tue, 11 Nov 2025 13:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868376; cv=none; b=sm5PWBEZMrdk0uXuJWT4JbzqlaQP3Pa7rT1xRcu2+yWN/Vl/d7tFkMw1RrxvoNkKUzs/svoXdYKKUdmrVi68GQUODkfOAdKXJEg5j4L30EMv3IyTy8x5og78hOokrpTzYGAegcZ5orGDbUd1ISQ4Xz+AYFBeiizJsScoSD5sXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868376; c=relaxed/simple;
	bh=pwVxCRUPp5+Zn44tSgim/k9yo2MGA/pWe1cXTxwMLKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=co+9JBz5UEv+y6TeSjqIvZJUbnHqZpCQTYCTgnKUW+wv/GBGcuCet6GcBsfCmW60pk1+BdnK83fUnEbZs+Sn44TiV3rYnMGzdGJu0UPqwSF6YH7F+izj3WWHfzTCxpj4K9vi/H9deb83rH4Si4guTvnr0UiCh7XVQOcIGiCGz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5SLV2zLnzKHMLB;
	Tue, 11 Nov 2025 21:39:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8AC1A1A0B89;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBXgF2EPBNpML6FAQ--.14435S5;
	Tue, 11 Nov 2025 21:39:30 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next v2 3/3] cpuset: remove need_rebuild_sched_domains
Date: Tue, 11 Nov 2025 13:24:29 +0000
Message-Id: <20251111132429.950343-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111132429.950343-1-chenridong@huaweicloud.com>
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXgF2EPBNpML6FAQ--.14435S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5tryDWFWkGF4DWF4rKrg_yoW8GrWrpF
	1Duayjqayjqr1Uuw4DAay7Zr9aka9Fvr9rtas8G3sYqF17t3W2g3Wjg3W3Jr9I9rn7CF17
	AFnF9w42qF10yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwhFxUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Previously, update_cpumasks_hier() used need_rebuild_sched_domains to
decide whether to invoke rebuild_sched_domains_locked(). Now that
rebuild_sched_domains_locked() only sets force_rebuild, the flag is
redundant. Hence, remove it.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index aff3ddc67393..daf813386260 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2184,7 +2184,6 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 {
 	struct cpuset *cp;
 	struct cgroup_subsys_state *pos_css;
-	bool need_rebuild_sched_domains = false;
 	int old_prs, new_prs;
 
 	rcu_read_lock();
@@ -2348,15 +2347,12 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		if (!cpumask_empty(cp->cpus_allowed) &&
 		    is_sched_load_balance(cp) &&
 		   (!cpuset_v2() || is_partition_valid(cp)))
-			need_rebuild_sched_domains = true;
+			cpuset_force_rebuild();
 
 		rcu_read_lock();
 		css_put(&cp->css);
 	}
 	rcu_read_unlock();
-
-	if (need_rebuild_sched_domains)
-		cpuset_force_rebuild();
 }
 
 /**
-- 
2.34.1


