Return-Path: <cgroups+bounces-11633-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E9559C37E7F
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2475B4F6B53
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E958034FF74;
	Wed,  5 Nov 2025 21:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPSSO0ld"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BF34AB04;
	Wed,  5 Nov 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376826; cv=none; b=qF666jAPbsgbJ/JnX7wOT2UKop/xfRD2UU/vI47NbYxAJysbCH/ZNb5wrGvi4EZkCGkO0rTQP4EZTfae+x4+iuKjLWHTI8C2RBC9nqMhlqigqlR9VUTIISPmi9Oxc5aJWqVxiFtNVj+Zn0zQHMoSLsnU225yFcyk5SDW4iayaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376826; c=relaxed/simple;
	bh=Edp/l5R7ShU52gSdBQzYrc5ERchBT8H20BRz7+yt6ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZkxtXuQz+rJibvwij8WiGS9zIseakOVtODCWGJNJslDuOdx+5/jTqIXfl2Jzihdm5WblpEty8lApEnjhjZize8CiNUyPtHvk4PUet6DFesXQsDkOmJBtCckNnuO6NnUUsB7JGHJ0RspX7E0kG6Wvj73TWwTVCAjFbM0JTCD0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPSSO0ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8A3C116D0;
	Wed,  5 Nov 2025 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376824;
	bh=Edp/l5R7ShU52gSdBQzYrc5ERchBT8H20BRz7+yt6ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPSSO0ldnwPIBE+qLDpp1WsWWdAtLlye9zEuu09MzwKOcsHq9395lCttXRPZS6Oy2
	 QOn05QDbGG/4CbYqnqKtnWdiOdxjEzs+mK9npTMOPEuZDA9bFtQETVdHAEUjsc1pzA
	 1pTFXjXqxdXU9XG1PauidLdVW/EBkGM/kCy4qCxc4IXzIWW3k1VFeMsW2ydpAdJHBt
	 Fo8USBYiZkFbocLeiLzW5xWCg3f66bfqZH9ozdEguU4zJotEVsfyX0yDrIyfWA2rfO
	 L/ATG9JJoKL0bxr5s86A7QA3/4MQD5/SOhQwFxy1r/vPat5+JRw+rwnuJO9VjzTpvR
	 glGPUoTcVb2NQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 23/31] kthread: Include kthreadd to the managed affinity list
Date: Wed,  5 Nov 2025 22:03:39 +0100
Message-ID: <20251105210348.35256-24-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unbound kthreads affinity management performed by cpuset is going to
be imported to the kthread core code for consolidation purposes.

Treat kthreadd just like any other kthread.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index b4794241420f..86abfbc21bb0 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -820,12 +820,13 @@ int kthreadd(void *unused)
 	/* Setup a clean context for our children to inherit. */
 	set_task_comm(tsk, comm);
 	ignore_signals(tsk);
-	set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_TYPE_KTHREAD));
 	set_mems_allowed(node_states[N_MEMORY]);
 
 	current->flags |= PF_NOFREEZE;
 	cgroup_init_kthreadd();
 
+	kthread_affine_node();
+
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (list_empty(&kthread_create_list))
-- 
2.51.0


