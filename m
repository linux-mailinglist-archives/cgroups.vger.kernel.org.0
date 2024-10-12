Return-Path: <cgroups+bounces-5104-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D351199B192
	for <lists+cgroups@lfdr.de>; Sat, 12 Oct 2024 09:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DE1F22CC1
	for <lists+cgroups@lfdr.de>; Sat, 12 Oct 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352DC13C9C0;
	Sat, 12 Oct 2024 07:33:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECD12C54D;
	Sat, 12 Oct 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728718431; cv=none; b=tQzjU79FfqdRwR7FeEcodOy9yv4lDfPiSOtpqE1Uqmm58qpGlUDgVxgUqkZUe2G2hqSPtUjGZA++jy0VNCEzCv2+77wlQFsyrPINiRM/WODL362o+s2YlbnbZa65gDJ1OV/5T8srvGmyS0RxU1ic/Zvjhwm43h0I1DGzBwP+2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728718431; c=relaxed/simple;
	bh=w+0T2IGafcUh9CVlp0OaufZqBPLEgPoMmmNkKvHgSU8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlAZzM/KhKoLHv8KMHKIBwWbhHEF8oVeDXPc8rXeRx0IjEYYst9qzhpGn3rlyRJmy9zA8NNEHd1SW7Hr7Jo3V3zmvT85tUiqR7u1AvWCR5vV+oARicb4mfItItouLkZhlbskI6v5GwL/OOPW6GO6D0zqBPKRqZGI2r5w9EhtusA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XQZwf3QSCz4f3lCm;
	Sat, 12 Oct 2024 15:33:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 31CAD1A058E;
	Sat, 12 Oct 2024 15:33:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgBXjMhSJgpnHCx7Dw--.42768S2;
	Sat, 12 Oct 2024 15:33:40 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	roman.gushchin@linux.dev
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wangweiyang2@huawei.com
Subject: [PATCH] cgroup: Fix potential overflow issue when checking max_depth
Date: Sat, 12 Oct 2024 07:22:46 +0000
Message-Id: <20241012072246.158766-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXjMhSJgpnHCx7Dw--.42768S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xCr1kuF18AF4DuF45Jrb_yoW8XFWfpF
	s8Jry5J395GFZrKw4jyasFvFySg395JrW5C3Z0yw1rAr13Gw17XF9YyF1jqFyxXFWIgw42
	qF4ay34akw4UKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

cgroup.max.depth is the maximum allowed descent depth below the current
cgroup. If the actual descent depth is equal or larger, an attempt to
create a new child cgroup will fail. However due to the cgroup->max_depth
is of int type and having the default value INT_MAX, the condition
'level > cgroup->max_depth' will never be satisfied, and it will cause
an overflow of the level after it reaches to INT_MAX.

Fix it by starting the level from 0 and using '>=' instead.

It's worth mentioning that this issue is unlikely to occur in reality,
as it's impossible to have a depth of INT_MAX hierarchy, but should be
be avoided logically.

Fixes: 1a926e0bbab8 ("cgroup: implement hierarchy limits")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5886b95c6eae..044c7ba1cc48 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5789,7 +5789,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 {
 	struct cgroup *cgroup;
 	int ret = false;
-	int level = 1;
+	int level = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
 
@@ -5797,7 +5797,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
 
-		if (level > cgroup->max_depth)
+		if (level >= cgroup->max_depth)
 			goto fail;
 
 		level++;
-- 
2.34.1


