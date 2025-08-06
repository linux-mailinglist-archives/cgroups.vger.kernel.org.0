Return-Path: <cgroups+bounces-9001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01775B1CAA0
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 19:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33614560E9D
	for <lists+cgroups@lfdr.de>; Wed,  6 Aug 2025 17:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D066029CB2B;
	Wed,  6 Aug 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLeUeG3x"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218D429C323
	for <cgroups@vger.kernel.org>; Wed,  6 Aug 2025 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501095; cv=none; b=LV94BjgT8UYNXSQfavCeBbdCF+sk0xxurFLR8P8hjZi9VWUnXiKAO7FKLPMbuOumeGz8JSLYUEvANWVD0SGAbv1tdKatJIaYmxV7DNO1n0Nc/8B4gQBV49wF5LY+HOOm/o19HCrLfX5cth9cGLLbDklWnjRg8/aQt/lPasdaPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501095; c=relaxed/simple;
	bh=0C84Fhrf9HSphlR61yFsq5jnmsi1bukdWhhvd37/udQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CIHHe+raOINrApDs/cswTHqH6qAS9YRxjNCYDsWaxeAkSASksnF/jn6WiWPd4eVa/mTPrgi7k8vxbWsbSYyDnEKXFTccRNAPsttMo6Alyxd6CbUrWN0OVNozdSyzWXRA3dtJuTRQRcyEZKliRNn8dfz+7aT35edjKcYiLJemq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLeUeG3x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754501093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jy2+ThM5nEhHxxw4zaH5Ul3BDQX387i/DjD7CdpaNJo=;
	b=aLeUeG3xof2R+B8zjwUNwsf5Z18O/nwx9Ytb3BEUl7btBuGC21Y6WXdBJGXiRAVLZCWMrR
	AvZoRxYApI56jBc7Ozac1/fOY7euhIYPk1mwKeQ+m6JE1oRX7I7p4zUyGsb4QUot7aiFfe
	JR8DqCznnhzM1s4XyiO7gSAmlU6Npv4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-Xm6DUZZYNTKiJHVjAQydYQ-1; Wed,
 06 Aug 2025 13:24:50 -0400
X-MC-Unique: Xm6DUZZYNTKiJHVjAQydYQ-1
X-Mimecast-MFC-AGG-ID: Xm6DUZZYNTKiJHVjAQydYQ_1754501088
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6139519560AD;
	Wed,  6 Aug 2025 17:24:48 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.125])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 524AF30001A1;
	Wed,  6 Aug 2025 17:24:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] cgroup/cpuset: Use static_branch_enable_cpuslocked() on cpusets_insane_config_key
Date: Wed,  6 Aug 2025 13:24:28 -0400
Message-ID: <20250806172430.1155133-2-longman@redhat.com>
In-Reply-To: <20250806172430.1155133-1-longman@redhat.com>
References: <20250806172430.1155133-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The following lockdep splat was observed.

[  812.359086] ============================================
[  812.359089] WARNING: possible recursive locking detected
[  812.359097] --------------------------------------------
[  812.359100] runtest.sh/30042 is trying to acquire lock:
[  812.359105] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0xe/0x20
[  812.359131]
[  812.359131] but task is already holding lock:
[  812.359134] ffffffffa7f27420 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_write_resmask+0x98/0xa70
     :
[  812.359267] Call Trace:
[  812.359272]  <TASK>
[  812.359367]  cpus_read_lock+0x3c/0xe0
[  812.359382]  static_key_enable+0xe/0x20
[  812.359389]  check_insane_mems_config.part.0+0x11/0x30
[  812.359398]  cpuset_write_resmask+0x9f2/0xa70
[  812.359411]  cgroup_file_write+0x1c7/0x660
[  812.359467]  kernfs_fop_write_iter+0x358/0x530
[  812.359479]  vfs_write+0xabe/0x1250
[  812.359529]  ksys_write+0xf9/0x1d0
[  812.359558]  do_syscall_64+0x5f/0xe0

Since commit d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem
and hotplug lock order"), the ordering of cpu hotplug lock
and cpuset_mutex had been reversed. That patch correctly
used the cpuslocked version of the static branch API to enable
cpusets_pre_enable_key and cpusets_enabled_key, but it didn't do the
same for cpusets_insane_config_key.

The cpusets_insane_config_key can be enabled in the
check_insane_mems_config() which is called from update_nodemask()
or cpuset_hotplug_update_tasks() with both cpu hotplug lock and
cpuset_mutex held. Deadlock can happen with a pending hotplug event that
tries to acquire the cpu hotplug write lock which will block further
cpus_read_lock() attempt from check_insane_mems_config(). Fix that by
switching to use static_branch_enable_cpuslocked().

Fixes: d74b27d63a8b ("cgroup/cpuset: Change cpuset_rwsem and hotplug lock order")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f74d04429a29..bf149246e001 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -280,7 +280,7 @@ static inline void check_insane_mems_config(nodemask_t *nodes)
 {
 	if (!cpusets_insane_config() &&
 		movable_only_nodes(nodes)) {
-		static_branch_enable(&cpusets_insane_config_key);
+		static_branch_enable_cpuslocked(&cpusets_insane_config_key);
 		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)!\n"
 			"Cpuset allocations might fail even with a lot of memory available.\n",
 			nodemask_pr_args(nodes));
-- 
2.50.0


