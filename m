Return-Path: <cgroups+bounces-9029-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95486B1E5BC
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 11:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716831AA3F6B
	for <lists+cgroups@lfdr.de>; Fri,  8 Aug 2025 09:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908B270EA8;
	Fri,  8 Aug 2025 09:39:46 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23226A1A8;
	Fri,  8 Aug 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645986; cv=none; b=eFRNlG70v7x+vtUsqgK1EGg6imFswOR3/Fp5Y5VkK4fbF/P1qd1aovjhsf3XHrycyoHfyn9YX/WmyCVuXSCvj3OGdXYuBC/n4SYn0AUXTVpQXkwWhAt+bKxVtxKbnPmJTAX3GfShWKiwBEo+dmPjGYQKiqz/7GQ7YVY39pN4GWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645986; c=relaxed/simple;
	bh=pgxmGpjnHnFyN7uX4DglrytT1ogOQKsOseVKGgGQJqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PmqXsM9nHc/tpDAeH61XZu3r6xB69mgDBNoBrz9K05rjfVjHSvFBEwO134BxEDbc/U3+UpMIKoPqjsxBgpOlEwjEclA/uPLt2pWYOGc+zHP7gx13Q3buz9AK2tQbPPULuRmGi7NUA9BykJSYdLQaHv4NJnCni5fJtBUYVIiOkyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4byzWx6dXdzKHMsQ;
	Fri,  8 Aug 2025 17:39:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 0DF941A1C1C;
	Fri,  8 Aug 2025 17:39:41 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgCXo7XPxZVooOS_Cw--.51716S3;
	Fri, 08 Aug 2025 17:39:40 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH -next 1/4] cpuset: remove redundant CS_ONLINE flag
Date: Fri,  8 Aug 2025 09:25:12 +0000
Message-Id: <20250808092515.764820-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250808092515.764820-1-chenridong@huaweicloud.com>
References: <20250808092515.764820-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCXo7XPxZVooOS_Cw--.51716S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1xGFyxtFyxAw4DAr48Crg_yoW5tF4UpF
	1DCFyUKw45G3W7CaykG3yqq34fKws3Z3WUKFyrK3s5AF1ayFya9F1kZ345JFyYyFWkCrWU
	AF4SvrWY9a48trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUV89N
	UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The CS_ONLINE flag was introduced prior to the CSS_ONLINE flag in the
cpuset subsystem. Currently, the flag setting sequence is as follows:

1. cpuset_css_online() sets CS_ONLINE
2. css->flags gets CSS_ONLINE set
...
3. cgroup->kill_css sets CSS_DYING
4. cpuset_css_offline() clears CS_ONLINE
5. css->flags clears CSS_ONLINE

The is_cpuset_online() check currently occurs between steps 1 and 3.
However, it would be equally safe to perform this check between steps 2
and 3, as CSS_ONLINE provides the same synchronization guarantee as
CS_ONLINE.

Since CS_ONLINE is redundant with CSS_ONLINE and provides no additional
synchronization benefits, we can safely remove it to simplify the code.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/cgroup.h          | 5 +++++
 kernel/cgroup/cpuset-internal.h | 3 +--
 kernel/cgroup/cpuset.c          | 4 +---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b18fb5fcb38e..ae73dbb19165 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -354,6 +354,11 @@ static inline bool css_is_dying(struct cgroup_subsys_state *css)
 	return css->flags & CSS_DYING;
 }
 
+static inline bool css_is_online(struct cgroup_subsys_state *css)
+{
+	return css->flags & CSS_ONLINE;
+}
+
 static inline bool css_is_self(struct cgroup_subsys_state *css)
 {
 	if (css == &css->cgroup->self) {
diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 383963e28ac6..75b3aef39231 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -38,7 +38,6 @@ enum prs_errcode {
 
 /* bits in struct cpuset flags field */
 typedef enum {
-	CS_ONLINE,
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
 	CS_MEM_HARDWALL,
@@ -202,7 +201,7 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 /* convenient tests for these bits */
 static inline bool is_cpuset_online(struct cpuset *cs)
 {
-	return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
+	return css_is_online(&cs->css) && !css_is_dying(&cs->css);
 }
 
 static inline int is_cpu_exclusive(const struct cpuset *cs)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f74d04429a29..cf7cd2255265 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -207,7 +207,7 @@ static inline void notify_partition_change(struct cpuset *cs, int old_prs)
  * parallel, we may leave an offline CPU in cpu_allowed or some other masks.
  */
 static struct cpuset top_cpuset = {
-	.flags = BIT(CS_ONLINE) | BIT(CS_CPU_EXCLUSIVE) |
+	.flags = BIT(CS_CPU_EXCLUSIVE) |
 		 BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
 	.partition_root_state = PRS_ROOT,
 	.relax_domain_level = -1,
@@ -3498,7 +3498,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 
-	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
@@ -3573,7 +3572,6 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-	clear_bit(CS_ONLINE, &cs->flags);
 
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-- 
2.34.1


