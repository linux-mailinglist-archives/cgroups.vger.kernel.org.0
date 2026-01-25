Return-Path: <cgroups+bounces-13436-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DIOHtufdmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13436-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:57:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8582FB6
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEF7230B2080
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132D315D30;
	Sun, 25 Jan 2026 22:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh9qasXM"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1F30FF1C;
	Sun, 25 Jan 2026 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381389; cv=none; b=qeCf9MpnqpTUBDzWMDWkJBkrFePVwyFdwPbWQ75aRPKNtipNMCwBYxa/Sxyd7EDyRDAsi886Xf/Sln/MQDgYqq6gpCohawPWq9k5xVzBBWGU6oFiwlb01j2INqmLwTBFCZJRxcs6yVNhzU7B8Fp6RIRiAphn8tCJ1VyjphYorZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381389; c=relaxed/simple;
	bh=8YH3jJJ1l+zWkUBN7W5HQtnoatv1adfZkeKPi8o8s7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRRnVGD8/s8oE4Z7PkRsV1wEXq72CWVMFD9NPsQthJCotl1EqWPsn73ZNkC5HSZF2hELUK7vnQAk5QVHYBd9cLjjr3QpQW66uJQLPR0ep5N7swnkJWxFBqnJ7wLLvrNGlb3y1f8mbDfyaUpakjF1WTiDt4kniqyYkr8YYAnSXFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh9qasXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F034C19425;
	Sun, 25 Jan 2026 22:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381388;
	bh=8YH3jJJ1l+zWkUBN7W5HQtnoatv1adfZkeKPi8o8s7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xh9qasXMZUMlZAvDOzubOT1QTX8nu9zdOSq/aG5SytkYO8dDUbUHJYFhPOhMIbOoc
	 shv9P8Bht3wB1y2r2jVGvZJv0HRG80ck2wtcmqKvSpyaFC/xFWa1YeBCz4KK/9ivCR
	 hYkK+Dyczy4RyH0t8DqAhfix9gdqot+5+jz0nhKl5oWWR6gbyqD0RRWpWeslUSffQg
	 5ffYgiOyzrLcj7I2oZeUcUBGC28h6CqUynsHVapP6lqi9yhKrLlwD6ZJaiFeb/Dw6q
	 li4SD3zXYvOkkw7bhKz4ZGmz1nuunbm6XlRzlwkUldb6lKhtWEGk/kgzKSmleS680L
	 XVtpddRKIJWYQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
Subject: [PATCH 29/33] sched/arm64: Move fallback task cpumask to HK_TYPE_DOMAIN
Date: Sun, 25 Jan 2026 23:45:36 +0100
Message-ID: <20260125224541.50226-30-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260125224541.50226-1-frederic@kernel.org>
References: <20260125224541.50226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13436-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.958];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1AD8582FB6
X-Rspamd-Action: no action

When none of the allowed CPUs of a task are online, it gets migrated
to the fallback cpumask which is all the non nohz_full CPUs.

However just like nohz_full CPUs, domain isolated CPUs don't want to be
disturbed by tasks that have lost their CPU affinities.

And since nohz_full rely on domain isolation to work correctly, the
housekeeping mask of domain isolated CPUs should always be a subset of
the housekeeping mask of nohz_full CPUs (there can be CPUs that are
domain isolated but not nohz_full, OTOH there shouldn't be nohz_full
CPUs that are not domain isolated):

	HK_TYPE_DOMAIN & HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN

Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
tasks. Note that cpuset isolated partitions are not supported on those
systems and may result in undefined behaviour.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
---
 Documentation/arch/arm64/asymmetric-32bit.rst | 12 ++++++++----
 arch/arm64/kernel/cpufeature.c                |  6 +++---
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/arm64/asymmetric-32bit.rst b/Documentation/arch/arm64/asymmetric-32bit.rst
index 57b8d7476f71..fc0c350c5e00 100644
--- a/Documentation/arch/arm64/asymmetric-32bit.rst
+++ b/Documentation/arch/arm64/asymmetric-32bit.rst
@@ -154,10 +154,14 @@ mode will return to host userspace with an ``exit_reason`` of
 ``KVM_EXIT_FAIL_ENTRY`` and will remain non-runnable until successfully
 re-initialised by a subsequent ``KVM_ARM_VCPU_INIT`` operation.
 
-NOHZ FULL
----------
+SCHEDULER DOMAIN ISOLATION
+--------------------------
 
-To avoid perturbing an adaptive-ticks CPU (specified using
-``nohz_full=``) when a 32-bit task is forcefully migrated, these CPUs
+To avoid perturbing a boot-defined domain isolated CPU (specified using
+``isolcpus=[domain]``) when a 32-bit task is forcefully migrated, these CPUs
 are treated as 64-bit-only when support for asymmetric 32-bit systems
 is enabled.
+
+However as opposed to boot-defined domain isolation, runtime-defined domain
+isolation using cpuset isolated partition is not advised on asymmetric
+32-bit systems and will result in undefined behaviour.
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c840a93b9ef9..f0e66cb27d17 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1669,7 +1669,7 @@ const struct cpumask *system_32bit_el0_cpumask(void)
 
 const struct cpumask *task_cpu_fallback_mask(struct task_struct *p)
 {
-	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_TICK));
+	return __task_cpu_possible_mask(p, housekeeping_cpumask(HK_TYPE_DOMAIN));
 }
 
 static int __init parse_32bit_el0_param(char *str)
@@ -3987,8 +3987,8 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 	bool cpu_32bit = false;
 
 	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
-		if (!housekeeping_cpu(cpu, HK_TYPE_TICK))
-			pr_info("Treating adaptive-ticks CPU %u as 64-bit only\n", cpu);
+		if (!housekeeping_cpu(cpu, HK_TYPE_DOMAIN))
+			pr_info("Treating domain isolated CPU %u as 64-bit only\n", cpu);
 		else
 			cpu_32bit = true;
 	}
-- 
2.51.1


