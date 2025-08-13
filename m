Return-Path: <cgroups+bounces-9125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A0AB2449F
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D0A63BAD49
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 08:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED972F0C76;
	Wed, 13 Aug 2025 08:43:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B492EFDB5;
	Wed, 13 Aug 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074614; cv=none; b=Tu3pXPStnXtbUGp4OCh4CsZwiStQqkTpm5H3Xh2eM5SGxo1OZGD7+U4fmmZZK5bhRErkmC3KtBG0OnwNIbpHHVS9/KOB2QhovGhyZF7JjxbPzXknzMmNf2JavNL7ycx1WUQlX3rRUbMb5W8yIRKxuruM3HxeCoo8aD4Su35iAf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074614; c=relaxed/simple;
	bh=RGt1tIYft6crFMNv5et40pBjMR6KEN1WAn93iGLySJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FL5e3YUW5ImcWQqdvOEWt2QqojdPJzHAUcd+PIKOXjumMr0tfbIKtI0oB8JdWwMO+ICFuX5L4QX+IVsCh/GFFQ4UsODMcm7128j6gpjLhzD2VVXUp49SpKCCH7kfmbs3bP36vFvGoPlfBBixsi2JaDY+KZS3x+OYjzczhNiEIwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c222n5p22zYQvJF;
	Wed, 13 Aug 2025 16:43:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 671831A0EFC;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgBHDg8qUJxoaYwdDg--.28644S3;
	Wed, 13 Aug 2025 16:43:28 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com,
	christophe.jaillet@wanadoo.fr
Subject: [-next v2 1/4] cpuset: remove redundant CS_ONLINE flag
Date: Wed, 13 Aug 2025 08:29:01 +0000
Message-Id: <20250813082904.1091651-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250813082904.1091651-1-chenridong@huaweicloud.com>
References: <20250813082904.1091651-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHDg8qUJxoaYwdDg--.28644S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1xGFyxtFyxAw4DAr48Crg_yoW5tw1kpF
	1DCFyUKw45GF17CaykG34qq34fKw4fZa4UKF1rK3s5AFyayFya9F1kZ345JFyUAFWkCrWU
	AF4SvrWY93W8trJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFID7UUUUU
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
Acked-by: Waiman Long <longman@redhat.com>
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
index 27adb04df675..3466ebbf1016 100644
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
@@ -3496,7 +3496,6 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 
-	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
@@ -3571,7 +3570,6 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
-	clear_bit(CS_ONLINE, &cs->flags);
 
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
-- 
2.34.1


