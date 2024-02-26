Return-Path: <cgroups+bounces-1829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD16866863
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 03:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C390B2105A
	for <lists+cgroups@lfdr.de>; Mon, 26 Feb 2024 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB772101C3;
	Mon, 26 Feb 2024 02:55:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530C8F9C3;
	Mon, 26 Feb 2024 02:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916149; cv=none; b=a6BahDLLzql8tUAlxRYkf3J5xz2iVXtsVSeTDUHujYXwwtew5v1aW2H6WOi0cthGi5zIzgrzWra1oDm8pSUx8/XdxH0XczyHJK9JzeX5eTo/0t40kImCXDvOrxnoVJ4rrEfWdrTTAVQMvg+dxeyMr90YqAK88I9vWjiKQkkQCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916149; c=relaxed/simple;
	bh=Ee5eROUXAl/pnz8Aoe3WfkGAh78ysaydeXO3dbLLwm8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KBe5UwUZIASDCIgWg+VvHk5yV4XWxzOouSCEbJATSuBWo5ZKYpR0pk8CkSE+Q+dKuRO6qweL+qEUlj2kxzi/nWl9P5C4p5JHbTnXoxwCGxrSS3IzlnYHuGahNPAU60CygNEeb3L67B6Cymor9dL7SzRJ/ZhKOUMRI9WKLZF41ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TjlVH01YSz1S5HP;
	Mon, 26 Feb 2024 10:50:46 +0800 (CST)
Received: from dggpemd100002.china.huawei.com (unknown [7.185.36.164])
	by mail.maildlp.com (Postfix) with ESMTPS id BE15A1400D4;
	Mon, 26 Feb 2024 10:55:43 +0800 (CST)
Received: from huawei.com (10.67.174.33) by dggpemd100002.china.huawei.com
 (7.185.36.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Mon, 26 Feb
 2024 10:55:43 +0800
From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Johannes Weiner
	<hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
	<roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, Muchun Song
	<muchun.song@linux.dev>, Greg KH <gregkh@linuxfoundation.org>
CC: <cgroups@vger.kernel.org>, <linux-mm@kvack.org>, Wang Weiyang
	<wangweiyang2@huawei.com>, Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH stable 4.19] mm: memcontrol: switch to rcu protection in drain_all_stock()
Date: Mon, 26 Feb 2024 11:01:40 +0800
Message-ID: <20240226030140.129822-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemd100002.china.huawei.com (7.185.36.164)

From: Roman Gushchin <guro@fb.com>

commit e1a366be5cb4f849ec4de170d50eebc08bb0af20 upstream.

Commit 72f0184c8a00 ("mm, memcg: remove hotplug locking from try_charge")
introduced css_tryget()/css_put() calls in drain_all_stock(), which are
supposed to protect the target memory cgroup from being released during
the mem_cgroup_is_descendant() call.

However, it's not completely safe.  In theory, memcg can go away between
reading stock->cached pointer and calling css_tryget().

This can happen if drain_all_stock() races with drain_local_stock()
performed on the remote cpu as a result of a work, scheduled by the
previous invocation of drain_all_stock().

The race is a bit theoretical and there are few chances to trigger it, but
the current code looks a bit confusing, so it makes sense to fix it
anyway.  The code looks like as if css_tryget() and css_put() are used to
protect stocks drainage.  It's not necessary because stocked pages are
holding references to the cached cgroup.  And it obviously won't work for
works, scheduled on other cpus.

So, let's read the stock->cached pointer and evaluate the memory cgroup
inside a rcu read section, and get rid of css_tryget()/css_put() calls.

Link: http://lkml.kernel.org/r/20190802192241.3253165-1-guro@fb.com
Signed-off-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org  # 4.19
Fixes: cdec2e4265df ("memcg: coalesce charging via percpu storage")
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---

This patch [1] fixed a UAF problem in drain_all_stock() existed prior to
5.9, and following discussions [2] mentioned that the fix depends on an
RCU read protection to stock->cached (introduced in 5.4), which doesn't
existed in 4.19. So backport this part to 4.19 as well.

[1]: https://lore.kernel.org/all/20240221081801.69764-1-gongruiqi1@huawei.com/
[2]: https://lore.kernel.org/all/ZdXLgjpUfpwEwAe0@tiehlicka/

 mm/memcontrol.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8c04296df1c7..d187bfb43b1f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2094,21 +2094,22 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
+		bool flush = false;
 
+		rcu_read_lock();
 		memcg = stock->cached;
-		if (!memcg || !stock->nr_pages || !css_tryget(&memcg->css))
-			continue;
-		if (!mem_cgroup_is_descendant(memcg, root_memcg)) {
-			css_put(&memcg->css);
-			continue;
-		}
-		if (!test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
+		if (memcg && stock->nr_pages &&
+		    mem_cgroup_is_descendant(memcg, root_memcg))
+			flush = true;
+		rcu_read_unlock();
+
+		if (flush &&
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
 			if (cpu == curcpu)
 				drain_local_stock(&stock->work);
 			else
 				schedule_work_on(cpu, &stock->work);
 		}
-		css_put(&memcg->css);
 	}
 	put_cpu();
 	mutex_unlock(&percpu_charge_mutex);
-- 
2.25.1


