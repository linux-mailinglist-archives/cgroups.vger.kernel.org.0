Return-Path: <cgroups+bounces-7854-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40727A9E6A4
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 05:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD623B5AE5
	for <lists+cgroups@lfdr.de>; Mon, 28 Apr 2025 03:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFC1D07BA;
	Mon, 28 Apr 2025 03:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MV+ZBc7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48461C84BF;
	Mon, 28 Apr 2025 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745811408; cv=none; b=DlHHecYvwUhjDnfBk/A5+WRA/VLLKtmxKBcmqwqIpwDtfZ63gabFUKXDL2Ra4L1D4gLxQPnw14W+fo/ta3OJ9B43BS5YDktUXMIYXFfhyZimI9aRKasIYATQo7OgTgdl2LgqTdj3gVefeVNDLjedBDZ0kBOt7Tnnbvy7zWq5i6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745811408; c=relaxed/simple;
	bh=nnI0SEo0cc59qBaxo7ivnHDqA/l1fQ+Yk4RuYsretf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdjlMyEfZtxM/nH8Ks2CtHgnKLd9TEW+8+djrZ3myQuYwgwHGipOR/p46dbO07diyBXBbIg8Q/W1REf2VXn4FtV75E7PkJBq8cEezDL4aRPZzuLfkdpATVVuBEeqQId3y1W0NRfNWy79eIOfgifhFU59bMxN+yzPXbN1nSp1jo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MV+ZBc7Y; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745811404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5UgujTTC+M44uRBA0W/V1VZG3lLjwg8UiEHcHCfP0z0=;
	b=MV+ZBc7Yde26EYnylyMbUZ4BNiFwo3uT9N1TpI8VmbA/Ah8V8Fhi2wG/cC+Q08x/MxWW0A
	woaT+KT1s0n4iTFKfJkQlQ+8pS7YpRR9DPLXhD/olJGa6ANeaafug3Do0+6zCTJcGxgaHv
	OSNyU6xp9Da+pSYHz2mbSZx1NDX37zc=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	David Rientjes <rientjes@google.com>,
	Josh Don <joshdon@google.com>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH rfc 04/12] mm: introduce bpf_oom_kill_process() bpf kfunc
Date: Mon, 28 Apr 2025 03:36:09 +0000
Message-ID: <20250428033617.3797686-5-roman.gushchin@linux.dev>
In-Reply-To: <20250428033617.3797686-1-roman.gushchin@linux.dev>
References: <20250428033617.3797686-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Introduce bpf_oom_kill_process() bpf kfunc, which is supposed
to be used by bpf OOM programs. It allows to kill a process
in exactly the same way the OOM killer does: using the OOM reaper,
bumping corresponding memcg and global statistics, respecting
memory.oom.group etc.

On success, it sets om_control's bpf_memory_freed field to true,
enabling the bpf program to bypass the kernel OOM killer.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/oom_kill.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index d00776b63c0a..2e922e75a9df 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -1299,6 +1299,42 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
 
 #ifdef CONFIG_BPF_SYSCALL
 
+__bpf_kfunc_start_defs();
+/*
+ * Kill a process in a way similar to the kernel OOM killer.
+ * This means dump the necessary information to dmesg, adjust memcg
+ * statistics, leverage the oom reaper, respect memory.oom.group etc.
+ *
+ * bpf_oom_kill_process() marks the forward progress by setting
+ * oc->bpf_memory_freed. If the progress was made, the bpf program
+ * is free to decide if the kernel oom killer should be invoked.
+ * Otherwise it's enforced, so that a bad bpf program can't
+ * deadlock the machine on memory.
+ */
+__bpf_kfunc int bpf_oom_kill_process(struct oom_control *oc,
+				     struct task_struct *task,
+				     const char *message__str)
+{
+	if (oom_unkillable_task(task))
+		return -EPERM;
+
+	/* paired with put_task_struct() in oom_kill_process() */
+	task = tryget_task_struct(task);
+	if (!task)
+		return -EINVAL;
+
+	oc->chosen = task;
+
+	oom_kill_process(oc, message__str);
+
+	oc->chosen = NULL;
+	oc->bpf_memory_freed = true;
+
+	return 0;
+}
+
+__bpf_kfunc_end_defs();
+
 __bpf_hook_start();
 
 /*
@@ -1319,6 +1355,16 @@ static const struct btf_kfunc_id_set bpf_oom_hook_set = {
 	.owner = THIS_MODULE,
 	.set   = &bpf_oom_hooks,
 };
+
+BTF_KFUNCS_START(bpf_oom_kfuncs)
+BTF_ID_FLAGS(func, bpf_oom_kill_process, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(bpf_oom_kfuncs)
+
+static const struct btf_kfunc_id_set bpf_oom_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_kfuncs,
+};
+
 static int __init bpf_oom_init(void)
 {
 	int err;
@@ -1326,6 +1372,10 @@ static int __init bpf_oom_init(void)
 	err = register_btf_fmodret_id_set(&bpf_oom_hook_set);
 	if (err)
 		pr_warn("error while registering bpf oom hooks: %d", err);
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_oom_kfunc_set);
+	if (err)
+		pr_warn("error while registering bpf oom kfuncs: %d", err);
 
 	return err;
 }
-- 
2.49.0.901.g37484f566f-goog


