Return-Path: <cgroups+bounces-12552-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDB8CD2D60
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 11:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE1C23016721
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40F2F746D;
	Sat, 20 Dec 2025 10:31:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DC021ABBB;
	Sat, 20 Dec 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766226660; cv=none; b=SiREP6PtktUGnVClFyK8I6GcI87x37QtRutMrD3SOEtMYBuLY6Sbr6P8fF5DvFb7HMpfpRxSAxrZgnddtd7R3WIWJPxQLt2fZ9+pinxcFJik8FppDIXt44lSsGuFzr2wLF5/ag9MFXWtDOiZBhGOJnQ403FjwdkmOtWhuTccaoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766226660; c=relaxed/simple;
	bh=lvsmAcTQuOeo+qf4SvKgakfCn8Kwd0koLbWKnmUCrIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ct/yMRQKl0vTfUZHG0PwFwiH2oaOX03Dxkf/8ifBZgUEX0a5ObLm9PyKF2lkV7+iSi9IH0Wr58KwHWR7DnaVr4lFDcnkloilWEgRCaSsk3SOIlDtvMGCI1qQ5m3d+4Ccs82xBwuAd5R3fI0DsAKVXBxUyVmvSCt3K/g9zmNksYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dYLJx5RgtzKHLtG;
	Sat, 20 Dec 2025 18:30:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 50C164056B;
	Sat, 20 Dec 2025 18:30:55 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgDHdfbRekZpWstjAw--.27423S2;
	Sat, 20 Dec 2025 18:30:53 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: longman@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	chenridong@huawei.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	dan.carpenter@linaro.org
Subject: [patch -next] cpuset: remove dead code in cpuset-v1.c
Date: Sat, 20 Dec 2025 10:15:57 +0000
Message-Id: <20251220101557.2719064-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHdfbRekZpWstjAw--.27423S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkKF1DKF18JF1rJw1fWFg_yoW8Cr4UpF
	4Dua48X3yUtr1UC3yjkFy7uryIv3ykGayUta1UXr1rXF47A3Wj9ry7X3ZxWFWjvr4DCryY
	yFZFgr42q3WqvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The commit 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1
and v2") introduced dead code that was originally added for cpuset-v2
partition domain generation. Remove the redundant root_load_balance check.

Fixes: 6e1d31ce495c ("cpuset: separate generate_sched_domains for v1 and v2")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/cgroups/9a442808-ed53-4657-988b-882cc0014c0d@huaweicloud.com/T/
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-v1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 7303315fdba7..ecfea7800f0d 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -605,7 +605,6 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
 	int ndoms = 0;		/* number of sched domains in result */
 	int nslot;		/* next empty doms[] struct cpumask slot */
 	struct cgroup_subsys_state *pos_css;
-	bool root_load_balance = is_sched_load_balance(&top_cpuset);
 	int nslot_update;
 
 	lockdep_assert_cpuset_lock_held();
@@ -615,7 +614,7 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
 	csa = NULL;
 
 	/* Special case for the 99% of systems with one, full, sched domain */
-	if (root_load_balance) {
+	if (is_sched_load_balance(&top_cpuset)) {
 		ndoms = 1;
 		doms = alloc_sched_domains(ndoms);
 		if (!doms)
@@ -638,8 +637,6 @@ int cpuset1_generate_sched_domains(cpumask_var_t **domains,
 	csn = 0;
 
 	rcu_read_lock();
-	if (root_load_balance)
-		csa[csn++] = &top_cpuset;
 	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
 		if (cp == &top_cpuset)
 			continue;
-- 
2.34.1


