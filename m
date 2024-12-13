Return-Path: <cgroups+bounces-5883-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68EB9F0A90
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 12:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D36B6163FBB
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 11:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F761D9592;
	Fri, 13 Dec 2024 11:13:34 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2311CEEAB;
	Fri, 13 Dec 2024 11:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088414; cv=none; b=BDoy+lJMcMYczHnAdihw2/UkZOFA0urdcOiwzMb/QZkD9Pm8JM6Wqkq7em/6psJoMY3ha3f55wFuSpUY0bUNSUOAJ74FNpWdYD3yAvjApzDMQQ3xseM30Zkgph4nQ0HAzmT+KXuitatyDvfhH5lifWJRfnugrXxICy6mbvzHSw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088414; c=relaxed/simple;
	bh=XSRw7MTv2+fiEhaS2zLrpA3fW4ALi9WgNTf/e9sl/28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LHl4FaoPE+Q8dpQzrDbd849lRXyaOI8OThferV7SWVvRNo4rrENRYHJhme6sAvLyOBCv7lVkla5f7GMPFh2cPzK6/o5+QlOz4eBnTsnViuAT0fC8AgBz1JnXWQrWh2RcQeUaq3RbfM+GsV74sV1ryfkgzjwcWMqQF/2khusZHkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Y8msY2Zc3z4f3l24;
	Fri, 13 Dec 2024 19:13:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B12901A0568;
	Fri, 13 Dec 2024 19:13:25 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCng4fIFlxnia3pEQ--.50048S2;
	Fri, 13 Dec 2024 19:13:25 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	mkoutny@suse.com,
	roman.gushchin@linux.dev
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: [PATCH v2] freezer, sched: report the frozen task stat as 'D'
Date: Fri, 13 Dec 2024 11:03:32 +0000
Message-Id: <20241213110332.3105932-1-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCng4fIFlxnia3pEQ--.50048S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy7Zw4UKFy3Zry8ur4rKrg_yoW8WF1Dpa
	9xur47Ga4IkFyUCrnFy3W7Wa48Wanrtr12kFZ0gF47JFy5X3WY9rn2vr98Kr45ArWFyFWU
	AFs8Kr97CayDA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8
	ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Before the commit f5d39b020809 ("freezer,sched: Rewrite core freezer
logic"), the frozen task stat was reported as 'D' in cgroup v1.
However, after rewriting core freezer logic, the frozen task stat is
reported as 'R'. This is confusing, especially when a task with stat of
'S' is frozen.

This can be reproduced as bellow step:
cd /sys/fs/cgroup/freezer/
mkdir test
sleep 1000 &
[1] 739         // task whose stat is 'S'
echo 739 > test/cgroup.procs
echo FROZEN > test/freezer.state
ps -aux | grep 739
root     739  0.1  0.0   8376  1812 pts/0    R    10:56   0:00 sleep 1000

As shown above, a task whose stat is 'S' was changed to 'R' when it was
frozen. To solve this issue, simply maintain the same reported state as
before the rewrite.

Fixes: f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/sched.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bffee2ef..dbe0cb97461f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1630,8 +1630,9 @@ static inline unsigned int __task_state_index(unsigned int tsk_state,
 	 * We're lying here, but rather than expose a completely new task state
 	 * to userspace, we can make this appear as if the task has gone through
 	 * a regular rt_mutex_lock() call.
+	 * Report the frozen task uninterruptible.
 	 */
-	if (tsk_state & TASK_RTLOCK_WAIT)
+	if (tsk_state & TASK_RTLOCK_WAIT || tsk_state & TASK_FROZEN)
 		state = TASK_UNINTERRUPTIBLE;
 
 	return fls(state);
-- 
2.34.1


