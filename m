Return-Path: <cgroups+bounces-4600-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E996556D
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 04:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6941F23AFD
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 02:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1621C136325;
	Fri, 30 Aug 2024 02:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CHoKoGvU"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A51E38DD6
	for <cgroups@vger.kernel.org>; Fri, 30 Aug 2024 02:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724986560; cv=none; b=mUlxyhazhQ+L+361RsrXxciSbCARRW+kqhSPBexbnVf2Aru5NFYeS6yzu3Z9Bi0m96mkDUCO5ifdIZ9UPww9SO2RDtJ7PIFdeeWPMhn+BSbatvBT8NWERpiCrQXmEpKBux1gE5jIup/WufkN5mUl+UTYgEd+PAuSZlkX96u1SYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724986560; c=relaxed/simple;
	bh=0EFniWYpHhsJb8FrdPLeExLhBz8HAE5CjvnzkalyGtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eeSuqREjZmR2stDtSst5dpaa9gC3aJpO1mD3HEUnI2s88tOMuogHGFoNt4YN7HVNlywJmE9GIcXEV4a24sWre+xRVJqfTvLZHT6Sj/SgYy/fPG89ftOovbxng9iIMq89DH3RoV7c6lVx4GTIp+KdiGO1C18aUyKzfkt7iSdruj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CHoKoGvU; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2025031eb60so11685665ad.3
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724986558; x=1725591358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZPZfZqC3mBdycoYdenoJPylLkOydS6FcokJngh3hNI=;
        b=CHoKoGvUYG+cqNvqgleP9sg6RhwI/0T3/8OQUvOA0OP8Mlo/OaYqu0uqF32F22tBVP
         DHZ0ZA5t7vzSg5sb1xV+SOfDJhuY4UsvGaElWME0OApcBhURlprAo4dxYtXJiWKrNBQI
         N0w8vp6FKLCUOGebTgYTvGKQTmKgeVQjoODm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724986558; x=1725591358;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZPZfZqC3mBdycoYdenoJPylLkOydS6FcokJngh3hNI=;
        b=j4ayPrzx2+hMUpnPakSly229qICMQ0+i+smJ6EHEHEwRejsCt/Hs6fYKOMYwGfPlrm
         yXApovnGGiVnk5SIwsIKeE8zZME+qE3YoWpdRZWpwK80clxd4VdiIfTic4wIJ9Oh3dvP
         eBnpKOS/GAOYb0nUDf1xb+cg5/TnDaJFLgI5gJTQum92MClXQfhbh6KSVUk41N3+d7Pe
         e9ttEEuoKNsqg6qWkU5Bom4qcAT53MMTNEipJXE2iLOX5rL/Ph2/Ei163U4wMnAwmFP4
         kwlm7RxYiFx96R47V2MUqYNrdKZ2Ksl3B16P739ibqV0T+CGZaZ+V2fusNCvmGgxZH7A
         ODGg==
X-Forwarded-Encrypted: i=1; AJvYcCUyauAs4jBaqU4pF19p1jAwEbOS5mT8kyl3WOYFwcV3p/l3zjDj7BEeA0ahT8sm6131djsuUC7F@vger.kernel.org
X-Gm-Message-State: AOJu0YxzeHXiSHov1v+uNQWWwF8HkgECm5I0VlwAZHQ9PuV5w8WvoONJ
	+GIca1frjMbij+6COBKBtZrh2IUe8OdzwB6Bag1UohpoVkoNn/3sxmkl7TPqwQ==
X-Google-Smtp-Source: AGHT+IF86Ys1NtYkMlA8W6bC13Z56ZAIJWWnVmkRBC+DeA4gimJaHXVyKNtbRuRVktDoB9Dg/oYgpQ==
X-Received: by 2002:a17:902:ec88:b0:202:883:bd6 with SMTP id d9443c01a7336-2050c4c8a3fmr67819605ad.63.1724986558232;
        Thu, 29 Aug 2024 19:55:58 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051555a29asm17871795ad.272.2024.08.29.19.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 19:55:57 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: longman@redhat.com,
	lizefan.x@bytedance.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	adityakali@google.com,
	sergeh@kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Chen Ridong <chenridong@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10-v5.15] cgroup/cpuset: Prevent UAF in proc_cpuset_show()
Date: Thu, 29 Aug 2024 19:55:45 -0700
Message-Id: <20240830025545.692351-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ridong <chenridong@huawei.com>

[ Upstream commit 1be59c97c83ccd67a519d8a49486b3a8a73ca28a ]

An UAF can happen when /proc/cpuset is read as reported in [1].

This can be reproduced by the following methods:
1.add an mdelay(1000) before acquiring the cgroup_lock In the
 cgroup_path_ns function.
2.$cat /proc/<pid>/cpuset   repeatly.
3.$mount -t cgroup -o cpuset cpuset /sys/fs/cgroup/cpuset/
$umount /sys/fs/cgroup/cpuset/   repeatly.

The race that cause this bug can be shown as below:

(umount)		|	(cat /proc/<pid>/cpuset)
css_release		|	proc_cpuset_show
css_release_work_fn	|	css = task_get_css(tsk, cpuset_cgrp_id);
css_free_rwork_fn	|	cgroup_path_ns(css->cgroup, ...);
cgroup_destroy_root	|	mutex_lock(&cgroup_mutex);
rebind_subsystems	|
cgroup_free_root	|
			|	// cgrp was freed, UAF
			|	cgroup_path_ns_locked(cgrp,..);

When the cpuset is initialized, the root node top_cpuset.css.cgrp
will point to &cgrp_dfl_root.cgrp. In cgroup v1, the mount operation will
allocate cgroup_root, and top_cpuset.css.cgrp will point to the allocated
&cgroup_root.cgrp. When the umount operation is executed,
top_cpuset.css.cgrp will be rebound to &cgrp_dfl_root.cgrp.

The problem is that when rebinding to cgrp_dfl_root, there are cases
where the cgroup_root allocated by setting up the root for cgroup v1
is cached. This could lead to a Use-After-Free (UAF) if it is
subsequently freed. The descendant cgroups of cgroup v1 can only be
freed after the css is released. However, the css of the root will never
be released, yet the cgroup_root should be freed when it is unmounted.
This means that obtaining a reference to the css of the root does
not guarantee that css.cgrp->root will not be freed.

Fix this problem by using rcu_read_lock in proc_cpuset_show().
As cgroup_root is kfree_rcu after commit d23b5c577715
("cgroup: Make operations on the cgroup root_list RCU safe"),
css->cgroup won't be freed during the critical section.
To call cgroup_path_ns_locked, css_set_lock is needed, so it is safe to
replace task_get_css with task_css.

[1] https://syzkaller.appspot.com/bug?extid=9b1ff7be974a403aa4cd

Fixes: a79a908fd2b0 ("cgroup: introduce cgroup namespaces")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 kernel/cgroup/cpuset.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 9f2a93c82..731547a0d 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -22,6 +22,7 @@
  *  distribution for more details.
  */
 
+#include "cgroup-internal.h"
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/cpuset.h>
@@ -3725,10 +3726,14 @@ int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
 	if (!buf)
 		goto out;
 
-	css = task_get_css(tsk, cpuset_cgrp_id);
-	retval = cgroup_path_ns(css->cgroup, buf, PATH_MAX,
-				current->nsproxy->cgroup_ns);
-	css_put(css);
+	rcu_read_lock();
+	spin_lock_irq(&css_set_lock);
+	css = task_css(tsk, cpuset_cgrp_id);
+	retval = cgroup_path_ns_locked(css->cgroup, buf, PATH_MAX,
+				       current->nsproxy->cgroup_ns);
+	spin_unlock_irq(&css_set_lock);
+	rcu_read_unlock();
+
 	if (retval >= PATH_MAX)
 		retval = -ENAMETOOLONG;
 	if (retval < 0)
-- 
2.39.4


