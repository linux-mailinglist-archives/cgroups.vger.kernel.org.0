Return-Path: <cgroups+bounces-3125-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEE59001A3
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 13:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08E71C21290
	for <lists+cgroups@lfdr.de>; Fri,  7 Jun 2024 11:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2ED186E55;
	Fri,  7 Jun 2024 11:09:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E212FB01;
	Fri,  7 Jun 2024 11:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758579; cv=none; b=Yja0Hk107VCT53/LDSIauIeDrk546AjQ3HTnWHZ9pu0FhUEjcqpwaWdZvSPlOGrwN3TaTQCIQaOy982TnAR8Cx98DRCsIJBzpjsQQw9IcZJ4G7RdnG5r2aYPQsCT7b2VUDygTOc9LXWyqkPECeTyXTOC+lpO8ysZ249F6SQuvNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758579; c=relaxed/simple;
	bh=kc8Z5wRPGLoi9gFViVuYCBwyahPZY0fAZxf1vj1H6xA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cR5z8ravLtwFPbFs2670FaGjjt7SyzIzpxn46ORGloQiHgXbFXs7rWrrYUNZtXgnHVzp68y75iPJKMkljavlz881Mv03Kbj5kM1oZ+7xT1PATILpexOy61Pv6Vp4FPhI1cFND4pYMAI9ZttVLBlIGlUcPW5erLrHY/r/CQXSi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vwdfs3zlzzPpbd;
	Fri,  7 Jun 2024 19:06:13 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 273F018007E;
	Fri,  7 Jun 2024 19:09:33 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 7 Jun
 2024 19:09:32 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <roman.gushchin@linux.dev>
CC: <bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] cgroup: Fix AA deadlock caused by cgroup_bpf_release
Date: Fri, 7 Jun 2024 11:03:13 +0000
Message-ID: <20240607110313.2230669-1-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)

We found an AA deadlock problem as shown belowed:

cgroup_destroy_wq		TaskB				WatchDog			system_wq

...
css_killed_work_fn:
P(cgroup_mutex)
...
								...
								__lockup_detector_reconfigure:
								P(cpu_hotplug_lock.read)
								...
				...
				percpu_down_write:
				P(cpu_hotplug_lock.write)
												...
												cgroup_bpf_release:
												P(cgroup_mutex)
								smp_call_on_cpu:
								Wait system_wq

cpuset_css_offline:
P(cpu_hotplug_lock.read)

WatchDog is waiting for system_wq, who is waiting for cgroup_mutex, to
finish the jobs, but the owner of the cgroup_mutex is waiting for
cpu_hotplug_lock. This problem caused by commit 4bfc0bb2c60e ("bpf:
decouple the lifetime of cgroup_bpf from cgroup itself")
puts cgroup_bpf release work into system_wq. As cgroup_bpf is a member of
cgroup, it is reasonable to put cgroup bpf release work into
cgroup_destroy_wq, which is only used for cgroup's release work, and the
preblem is solved.

Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/bpf/cgroup.c             | 2 +-
 kernel/cgroup/cgroup-internal.h | 1 +
 kernel/cgroup/cgroup.c          | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 8ba73042a239..a611a1274788 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -334,7 +334,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
 	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
 
 	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
-	queue_work(system_wq, &cgrp->bpf.release_work);
+	queue_work(cgroup_destroy_wq, &cgrp->bpf.release_work);
 }
 
 /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 520b90dd97ec..9e57f3e9316e 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -13,6 +13,7 @@
 extern spinlock_t trace_cgroup_path_lock;
 extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
 extern void __init enable_debug_cgroup(void);
+extern struct workqueue_struct *cgroup_destroy_wq;
 
 /*
  * cgroup_path() takes a spin lock. It is good practice not to take
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e32b6972c478..3317e03fe2fb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -124,7 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
  * destruction work items don't end up filling up max_active of system_wq
  * which may lead to deadlock.
  */
-static struct workqueue_struct *cgroup_destroy_wq;
+struct workqueue_struct *cgroup_destroy_wq;
 
 /* generate an array of cgroup subsystem pointers */
 #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,
-- 
2.34.1


