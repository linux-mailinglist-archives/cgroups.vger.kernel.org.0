Return-Path: <cgroups+bounces-13369-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kATDOX87cmlMfAAAu9opvQ
	(envelope-from <cgroups+bounces-13369-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:00:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23791683B4
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 16:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79279945BF0
	for <lists+cgroups@lfdr.de>; Thu, 22 Jan 2026 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0234E777;
	Thu, 22 Jan 2026 14:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgksenNL"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46F926D4EF;
	Thu, 22 Jan 2026 14:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769091954; cv=none; b=XNNechYRG55Ggd7uaFvco5uVDlHXpv/wxZ40FR4x7pWLriIHajwc5bAxGiE/xX2OIaJB2zEH3QovXgG0mQP9e56JRRSzbtVkoYTW0QFnmHgD1CcuYlTiq78eXvvLxjPBEV4MR+KTlR8ufATe8AIpCe3cT2Sq9j9gJejmCy+qYhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769091954; c=relaxed/simple;
	bh=Yl2qHTWE9Fz/7zZDgzhuQhCUpz24c+UW8s5oFbDoqv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/w9kR0YH2ueJ7Rylrql9TFAWEIAmNiXXu7/ODCFx+/v6igMliu+V/I4kSCxSiicgRU2NH4uLu94JD9gF+ek+WnQ/7YEjvb+XIwX2bc16x1ijd6N5abNgcwqpjiVllTBSaqAj1C8cPpOvW8bk6hHP9kpXJ2EnjZUFaAwo2M/ar4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgksenNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3070C116C6;
	Thu, 22 Jan 2026 14:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769091953;
	bh=Yl2qHTWE9Fz/7zZDgzhuQhCUpz24c+UW8s5oFbDoqv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dgksenNLm8vVcFnylVsW42Tv+ZdtC5W29o1qOctfuLKEDknRSTgAq8uzfYssEItmI
	 1/wOROGwmmKK4A6J0Uf0YffnAOAuPW+Z6RN9LrRJxi0cMAMDPJW+sHCCBqhwnraKRy
	 kJJ07EzgsYxVOO45tD2+zF7iBGbuIZkGKgSP05MJZvD+tcbKYbrvLKNW11VeHgFWi+
	 VU9GuE9ZZl3qbAvIeLSbzdH7Yue/O7ulWuBcayymCEG/yFqi3DTV/nqppK2pyvu/Jm
	 wh4/199cda1IpN1SL0mJt6msWh7JYksIQOb9a5HPcwS51wHfuEWcY3g1/EH2SLxa1V
	 CSmkUrJoC7XpQ==
Date: Thu, 22 Jan 2026 15:25:50 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>, Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 29/33] sched/arm64: Move fallback task cpumask to
 HK_TYPE_DOMAIN
Message-ID: <aXIzbmitdoJIMFCP@localhost.localdomain>
References: <20260101221359.22298-1-frederic@kernel.org>
 <20260101221359.22298-30-frederic@kernel.org>
 <aW-cAlJCtI5Qtify@willie-the-truck>
 <aXEHf5nbZMI8LT4b@localhost.localdomain>
 <aXH0TZU7UNowTmwc@willie-the-truck>
 <aXIKDduX5qUXvOUX@localhost.localdomain>
 <aXILtazyRtpb3Yjy@willie-the-truck>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXILtazyRtpb3Yjy@willie-the-truck>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,kernel.org,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,lists.infradead.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-13369-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,localhost.localdomain:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,suse.com:email,infradead.org:email]
X-Rspamd-Queue-Id: 23791683B4
X-Rspamd-Action: no action

Le Thu, Jan 22, 2026 at 11:36:21AM +0000, Will Deacon a écrit :
> On Thu, Jan 22, 2026 at 12:29:17PM +0100, Frederic Weisbecker wrote:
> > Le Thu, Jan 22, 2026 at 09:56:29AM +0000, Will Deacon a écrit :
> > > On Wed, Jan 21, 2026 at 06:06:07PM +0100, Frederic Weisbecker wrote:
> > > > Le Tue, Jan 20, 2026 at 03:15:14PM +0000, Will Deacon a écrit :
> > > > > Hi Frederic,
> > > > > 
> > > > > On Thu, Jan 01, 2026 at 11:13:54PM +0100, Frederic Weisbecker wrote:
> > > > > > When none of the allowed CPUs of a task are online, it gets migrated
> > > > > > to the fallback cpumask which is all the non nohz_full CPUs.
> > > > > > 
> > > > > > However just like nohz_full CPUs, domain isolated CPUs don't want to be
> > > > > > disturbed by tasks that have lost their CPU affinities.
> > > > > > 
> > > > > > And since nohz_full rely on domain isolation to work correctly, the
> > > > > > housekeeping mask of domain isolated CPUs should always be a superset of
> > > > > > the housekeeping mask of nohz_full CPUs (there can be CPUs that are
> > > > > > domain isolated but not nohz_full, OTOH there shouldn't be nohz_full
> > > > > > CPUs that are not domain isolated):
> > > > > > 
> > > > > > 	HK_TYPE_DOMAIN | HK_TYPE_KERNEL_NOISE == HK_TYPE_DOMAIN
> > > > > > 
> > > > > > Therefore use HK_TYPE_DOMAIN as the appropriate fallback target for
> > > > > > tasks and since this cpumask can be modified at runtime, make sure
> > > > > > that 32 bits support CPUs on ARM64 mismatched systems are not isolated
> > > > > > by cpusets.
> > > > > > 
> > > > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > > > Reviewed-by: Waiman Long <longman@redhat.com>
> > > > > > ---
> > > > > >  arch/arm64/kernel/cpufeature.c | 18 +++++++++++++++---
> > > > > >  include/linux/cpu.h            |  4 ++++
> > > > > >  kernel/cgroup/cpuset.c         | 17 ++++++++++++++---
> > > > > >  3 files changed, 33 insertions(+), 6 deletions(-)
> > > > > 
> > > > > tbh, I'd also be fine just saying that isolation isn't reliable on these
> > > > > systems and then you don't need to add the extra arch hook.
> > > > 
> > > > Hmm, I think I heard about nohz_full usage on arm64 but I'm not sure.
> > > > And I usually expect isolcpus or cpuset isolated partitions to be even
> > > > more broadly used, it's lighter isolation with less constraints.
> > > > 
> > > > Anyway you're probably right that we could remove isolation support here
> > > > but I don't want to break any existing user.
> > > 
> > > fwiw, I think it's only some Android markets using the mismatched 32-bit
> > > support and we're definitely not using nohz_full there.
> > 
> > Now that removal becomes appealing. And what about isolcpus= / isolated cpuset
> > which only consist in scheduler domain isolation? Probably not used by android
> > either.
> > 
> > Ok but is there a way to detect on early boot that the system has mismatched
> > 32 bits support? Because I need to fail nohz_full= and isolcpus= boot parameters
> > early on top of this information without waiting for secondary CPUs boot.
> 
> Honestly, I'm not sure I'd bother trying to be smart here. Even if the
> system has enabled support for mismatched 32-bit CPUs, things should
> still work properly with nohz_full/isolcpus if all the tasks are 64-bit,
> right?
> 
> In which case, I'd just document whatever weird behaviour you get if
> somebody throws 32-bit tasks into the mix. Adding hooks to the generic
> code for this use-case just seems like a waste, as they're not going to
> be used in practice and it increases the maintenance burden.

Ok, how does this updated version look now?

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Thu, 24 Jul 2025 23:38:48 +0200
Subject: [PATCH] sched/arm64: Move fallback task cpumask to HK_TYPE_DOMAIN

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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
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


