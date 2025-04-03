Return-Path: <cgroups+bounces-7314-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91FEA79B47
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 07:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56BE5189625C
	for <lists+cgroups@lfdr.de>; Thu,  3 Apr 2025 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F5719CD1B;
	Thu,  3 Apr 2025 05:30:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0C11712;
	Thu,  3 Apr 2025 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658218; cv=none; b=oKmVGGmhwK6NdvZnUnPEFhpnpONDOr3YZsbnCVdsTkJgW3fo05A4I6jgOndMGHhInMuARcmf87yW3teZazK7VYbexnCo/F2bVrH/Nv1YCdYRM6Qx4eXBkpDeGGh0AFeOdq7WMh9JAWmnfHp+F9G9x78KmElfzMKz/vh66PdpMLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658218; c=relaxed/simple;
	bh=BM2a4g1TbHQGRp0LZlYp70MEjNeMliYqZpPQB2oBxvc=;
	h=Date:Message-ID:In-Reply-To:References:Mime-Version:From:To:Cc:
	 Subject:Content-Type; b=Da2WL9rpOH4AHyOiNwDMVPAwsLtC0dC11cer+WZE8KtpTvZ/ivIjBk0oTXefYFJ2ng1OzN7FyHErPo4Shb7qv4DCoUXISOiqbGgriqbYqus08DJFSN7AWvYmfiFyCJ2tUvNplW3dQhsHgfjszfIiQJZ6Kni+0CfZC+LgCty8WIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZSr0f6xBDz8R042;
	Thu,  3 Apr 2025 13:30:10 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 5335U7at043271;
	Thu, 3 Apr 2025 13:30:07 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 3 Apr 2025 13:30:09 +0800 (CST)
Date: Thu, 3 Apr 2025 13:30:09 +0800 (CST)
X-Zmail-TransId: 2afa67ee1ce1ffffffffd79-6c227
X-Mailer: Zmail v1.0
Message-ID: <20250403133009359JE5AjQxfNH7B3DWUgFHXi@zte.com.cn>
In-Reply-To: <20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn>
References: 20250403132534636XLwK7CWiCj1J4-FENz0vk@zte.com.cn
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <mhocko@kernel.org>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>,
        <muchun.song@linux.dev>, <shakeel.butt@linux.dev>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yang.yang29@zte.com.cn>,
        <chen.haonan2@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgMi82XSBtZW1jb250cm9sOiBpbnRyb2R1Y2UgdGhlIG5ldwoKIG1lbV9jZ3JvdXBfc2Nhbl90YXNrcygp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 5335U7at043271
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EE1CE2.00B/4ZSr0f6xBDz8R042

From: xu xin <xu.xin16@zte.com.cn>

Introduce a new mem_cgroup_scan_tasks function that strictly iterates
processes only within the current memcgroup, aligning its behavior with
its name.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 include/linux/memcontrol.h |  7 +++++++
 mm/memcontrol.c            | 24 ++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 232cea80e71f..3af34e124ce6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -795,6 +795,8 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *,
 				   struct mem_cgroup *,
 				   struct mem_cgroup_reclaim_cookie *);
 void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
+void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+			   int (*)(struct task_struct *, void *), void *arg);
 void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 			   int (*)(struct task_struct *, void *), void *arg);

@@ -1289,6 +1291,11 @@ static inline void mem_cgroup_iter_break(struct mem_cgroup *root,
 {
 }

+static inline void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+		int (*fn)(struct task_struct *, void *), void *arg)
+{
+}
+
 static inline void mem_cgroup_tree_scan_tasks(struct mem_cgroup *memcg,
 		int (*fn)(struct task_struct *, void *), void *arg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9af30fbfe819..aff5a095b9e4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1150,6 +1150,30 @@ static void invalidate_reclaim_iterators(struct mem_cgroup *dead_memcg)
 						dead_memcg);
 }

+/* *
+ * mem_cgroup_scan_tasks - iterate over tasks of only this memory cgroup.
+ * @memcg: the specified memory cgroup.
+ * @fn: function to call for each task
+ * @arg: argument passed to @fn
+ *
+ * Unlike mem_cgroup_tree_scan_tasks(), this function only iterate over
+ * these tasks attached to @memcg, not including any of its descendants
+ * memcg. And this could be called for the root memory cgroup.
+ */
+void mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
+			  int (*fn)(struct task_struct *, void *), void *arg)
+{
+	int ret = 0;
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&memcg->css, CSS_TASK_ITER_PROCS, &it);
+	while (!ret && (task = css_task_iter_next(&it)))
+		ret = fn(task, arg);
+
+	css_task_iter_end(&it);
+}
+
 /**
  * mem_cgroup_tree_scan_tasks - iterate over tasks of a memory cgroup hierarchy
  * @memcg: hierarchy root
-- 
2.15.

