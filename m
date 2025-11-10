Return-Path: <cgroups+bounces-11701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C5DC44C0B
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 03:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 13D174E121F
	for <lists+cgroups@lfdr.de>; Mon, 10 Nov 2025 02:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E722B5AD;
	Mon, 10 Nov 2025 02:07:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD02747B;
	Mon, 10 Nov 2025 02:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762740463; cv=none; b=jZwfWyZvd0mAmDRRMqwKYwIQtP3/y13UNDX/ZISkx/2lAs6o01UklhtY87nhVcrYctcBPf0HjpKT51yHboNPRdiLdpFErpgUihRYDXWKdF1MwfHM/frM99F1MA+Vt4rRkwLqf8tXwtQ6JxbDNmn54TbfuSM/ji6J22HIcxklYmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762740463; c=relaxed/simple;
	bh=X2I1F/yDa7DktzrVXLN/G9326ra+lTHr8o2fcN0+B6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pkoVKAfgtFxNPptRLMKsn3SRs/g0symxZoir6b8mkW7+hLl7jJwhygpAGK+l7ccrpENM1+dtGWGI25IntovyqdLKvYM2sJMNJbOBymlTt2zd3oCnJiOqPdEL0D4KQZRZ5EDdO+XYPswZ7fjnB3j3gj6gxqkB7F6DHVB6GBmHcCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d4Y2Z4K56zKHMWF;
	Mon, 10 Nov 2025 10:07:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8E22C1A084D;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP1 (Coremail) with SMTP id cCh0CgBXkUrUSBFpPBDaAA--.6382S5;
	Mon, 10 Nov 2025 10:07:32 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 3/3] cpuset: remove need_rebuild_sched_domains
Date: Mon, 10 Nov 2025 01:52:28 +0000
Message-Id: <20251110015228.897736-4-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110015228.897736-1-chenridong@huaweicloud.com>
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXkUrUSBFpPBDaAA--.6382S5
X-Coremail-Antispam: 1UD129KBjvJXoW7KrW5tryDGw47ZF4xWF4fAFb_yoW8Jw48pF
	1kua1jq3yjqr1Uuw4DAa9rur93Ka9Fvasrt3s8G3s2qF17K3W2g3Wjg3W3Jr9a9rn7uF13
	AFsFk3y2qF1jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrbyCDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Previously, update_cpumasks_hier() used need_rebuild_sched_domains to
decide whether to invoke rebuild_sched_domains_locked(). Now that
rebuild_sched_domains_locked() only sets force_rebuild, the flag is
redundant. Hence, remove it.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index c357bfb69fe2..22084d8bdc3f 100644
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


