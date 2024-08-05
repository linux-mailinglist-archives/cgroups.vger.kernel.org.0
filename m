Return-Path: <cgroups+bounces-4079-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864B94729F
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 02:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4EC1C20C92
	for <lists+cgroups@lfdr.de>; Mon,  5 Aug 2024 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3BD26AD0;
	Mon,  5 Aug 2024 00:52:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFAEDC;
	Mon,  5 Aug 2024 00:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722819148; cv=none; b=UsWu/typokbjK6bH1nqpWDOYPVPIDs7DprUdFZhXYxAcFUzI4YVbohDBNrJ2oaDkzdZWLQNB8qUqxVNqI9tFCsnBAzUnGnTTAGls/Ogx1XrYOBD5U3/kgKsae9ICGzomDx1elLxxtoESyHKPi9xvdMHONZ2+INld2FIOy9jOORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722819148; c=relaxed/simple;
	bh=ppJbhXo9jwJEL5d5V+c62H0Sud7V+ycncVTmWhodza8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p5cT1TPNsQAvhI8MLmaRvEPZ9ZCTMErRi4d2vuq4xKFp700epESV9BiNeGJ9gM1RFOObgbLWdsgGI2g9OLRiEg6kT369HpEoJFK5253PADuXPKcojRo7yeCnBgrNT1YuSXforO7PGgFKZaTTPEo3S7MGh/Jb9np77g6Sz31I5hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WcdDy1G7Cz4f3l1b;
	Mon,  5 Aug 2024 08:52:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5ECB91A018D;
	Mon,  5 Aug 2024 08:52:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgCnGoE_IrBmj98uAw--.61560S2;
	Mon, 05 Aug 2024 08:52:16 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiujianfeng@huawei.com
Subject: [PATCH v2 -next] cgroup/pids: Remove unreachable paths of pids_{can,cancel}_fork
Date: Mon,  5 Aug 2024 00:43:04 +0000
Message-Id: <20240805004304.57314-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnGoE_IrBmj98uAw--.61560S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur1DXr18Xw1UAw17Aw15CFg_yoW8Ary5pF
	nxG3s7KFW5Jas093W5XrZ7ZryfGan7W34UuF4kJ34Syw12yw13GF1qyw40vry5XrW2gw17
	JF4Yka13Kw1jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

According to the implementation of cgroup_css_set_fork(), it will fail
if cset cannot be found and the can_fork/cancel_fork methods will not
be called in this case, which means that the argument 'cset' for these
methods must not be NULL, so remove the unrechable paths in them.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
v2: reword the commit message
---
 kernel/cgroup/pids.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 34aa63d7c9c6..8f61114c36dd 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -272,15 +272,10 @@ static void pids_event(struct pids_cgroup *pids_forking,
  */
 static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
-	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids, *pids_over_limit;
 	int err;
 
-	if (cset)
-		css = cset->subsys[pids_cgrp_id];
-	else
-		css = task_css_check(current, pids_cgrp_id, true);
-	pids = css_pids(css);
+	pids = css_pids(cset->subsys[pids_cgrp_id]);
 	err = pids_try_charge(pids, 1, &pids_over_limit);
 	if (err)
 		pids_event(pids, pids_over_limit);
@@ -290,14 +285,9 @@ static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 
 static void pids_cancel_fork(struct task_struct *task, struct css_set *cset)
 {
-	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 
-	if (cset)
-		css = cset->subsys[pids_cgrp_id];
-	else
-		css = task_css_check(current, pids_cgrp_id, true);
-	pids = css_pids(css);
+	pids = css_pids(cset->subsys[pids_cgrp_id]);
 	pids_uncharge(pids, 1);
 }
 
-- 
2.34.1


