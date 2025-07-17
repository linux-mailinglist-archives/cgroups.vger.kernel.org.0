Return-Path: <cgroups+bounces-8747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C6B088FB
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 11:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC9D4E4C56
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 09:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E6288C96;
	Thu, 17 Jul 2025 09:09:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE771E2312;
	Thu, 17 Jul 2025 09:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743398; cv=none; b=o9gGzI8DFZ3tntWyCGMfsiNG88tiFWcqBA6g95DM8aejnnKRe6bb+HM1cZJ/4x2XzGTf2UiCBvk11/y0M6jqU3XqSjGQXGl754RwNKKLrV7DX9R8cwUf0967mwV+g//1o5e4upx9pvzaxAbcMQzDXfXkISs15hKMJLPyMDygOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743398; c=relaxed/simple;
	bh=Tz1X3rKDGGmdkfb/lujQSuj2LWCWnoB0eFMaPnmhEEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ND47INELsUAlcExCDuXk8JDDDN6XnrrkqF29QbnrHdTO+43mKxsXF/m9JxIeSCwNJjADuKbhcvwbm7NAriQqUX/6fOBc0Szsd2sXWNMkZ/77QsWLjt7jlei7B7+bmHySd7JR6SJf2HpKNzPQiKsA2v925LU/N5tL5IoAzzRVIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bjRvf2yktzYR0hf;
	Thu, 17 Jul 2025 17:09:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2BD7E1A45FC;
	Thu, 17 Jul 2025 17:09:49 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnIhPNvXhosUc4Ag--.62465S4;
	Thu, 17 Jul 2025 17:09:49 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	rafael@kernel.org,
	pavel@kernel.org,
	timvp@google.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huawei.com
Subject: [PATCH v2 -next 2/2] Revert "cgroup_freezer: cgroup_freezing: Check if not frozen"
Date: Thu, 17 Jul 2025 08:55:50 +0000
Message-Id: <20250717085550.3828781-3-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717085550.3828781-1-chenridong@huaweicloud.com>
References: <20250717085550.3828781-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnIhPNvXhosUc4Ag--.62465S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXF18ZF4xGF1kZFy5Jw4UXFb_yoW5Gr4Upa
	n5Gw1UGws5KF17ArZrAws2qr95KrZ7Xa1UGrykur18XF43Xas7Ars7Aw15G34UAF97KryU
	Xas8KrWIk34qv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmmb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
	JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r
	1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1U
	YxBIdaVFxhVjvjDU0xZFpf9x07UCZXrUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This reverts commit cff5f49d433fcd0063c8be7dd08fa5bf190c6c37.

Commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
frozen") modified the cgroup_freezing() logic to verify that the FROZEN
flag is not set, affecting the return value of the freezing() function,
in order to address a warning in __thaw_task.

A race condition exists that may allow tasks to escape being frozen. The
following scenario demonstrates this issue:

CPU 0 (get_signal path)		CPU 1 (freezer.state reader)
try_to_freeze			read freezer.state
__refrigerator			freezer_read
				update_if_frozen
WRITE_ONCE(current->__state, TASK_FROZEN);
				...
				/* Task is now marked frozen */
				/* frozen(task) == true */
				/* Assuming other tasks are frozen */
				freezer->state |= CGROUP_FROZEN;
/* freezing(current) returns false */
/* because cgroup is frozen (not freezing) */
break out
__set_current_state(TASK_RUNNING);
/* Bug: Task resumes running when it should remain frozen */

The existing !frozen(p) check in __thaw_task makes the
WARN_ON_ONCE(freezing(p)) warning redundant. Removing this warning enables
reverting the commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check
if not frozen") to resolve the issue.

The warning has been removed in the previous patch. This patch revert the
commit cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not
frozen") to complete the fix.

Fixes: cff5f49d433f ("cgroup_freezer: cgroup_freezing: Check if not frozen")
Reported-by: Zhong Jiawei<zhongjiawei1@huawei.com>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/legacy_freezer.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 507b8f19a262..dd9417425d92 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -66,15 +66,9 @@ static struct freezer *parent_freezer(struct freezer *freezer)
 bool cgroup_freezing(struct task_struct *task)
 {
 	bool ret;
-	unsigned int state;
 
 	rcu_read_lock();
-	/* Check if the cgroup is still FREEZING, but not FROZEN. The extra
-	 * !FROZEN check is required, because the FREEZING bit is not cleared
-	 * when the state FROZEN is reached.
-	 */
-	state = task_freezer(task)->state;
-	ret = (state & CGROUP_FREEZING) && !(state & CGROUP_FROZEN);
+	ret = task_freezer(task)->state & CGROUP_FREEZING;
 	rcu_read_unlock();
 
 	return ret;
-- 
2.34.1


