Return-Path: <cgroups+bounces-11483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D97C29EF3
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B6F3ADBC7
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD53D221275;
	Mon,  3 Nov 2025 03:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUP1FSpX"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5122F74D
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 03:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762139873; cv=none; b=rrXw+6lwDetNP/t4QwfDPwndqj8xL7uGbe2SETt6PL2OOhMJW93eRJP/OWcF8P4OStrqvYrxmAwX6jfWMRp7qzwhtkI6UdmcpHnVwVrC/m3V/v5R4mb3/CXEl7zsluKpiptFIF6sDam0EzZQbnUTNdw3GezcTHBgsNEYe2LC+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762139873; c=relaxed/simple;
	bh=Qlf0NE/gpeGR10ptH0mjbCnXJKEHBCLG36L5sy1Vg38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNTRzu5Xnae+n6RaSQZfrIba5vPL0arY2N1VeZKAz78zSDOE1V11UQlFqiyJujFWyCOpA399GauPrQzQLgm+onNERsVNfVrvyuFFcCCYA2A30/rVg4EN3fYRAXYp4KCZtwNVdjqSnsgYv66H3SyUOzQK4OyYhc7cTW81SAnl3Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUP1FSpX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762139870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5DU21dFbkfQss6XV7ENAx7XKS9XLFCmBUIaq0YUh++A=;
	b=FUP1FSpXEHiF1yvuoAK5zj/28eoKbfe7kjAePWBP+gLlgoPICAc22Bqy//FyyjRzIJTQmn
	dXqk7lQegdbCtgSUNCCXEQNiioB8hh3/qDiie0gra41ZSi7G29ZVlqBzToCImWRVTflqfF
	t5aM6S4axmj2Kv+h1Bv15HPcON2GwSc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-P1fMKWg_Nv-YBURa__jcBw-1; Sun,
 02 Nov 2025 22:17:47 -0500
X-MC-Unique: P1fMKWg_Nv-YBURa__jcBw-1
X-Mimecast-MFC-AGG-ID: P1fMKWg_Nv-YBURa__jcBw_1762139865
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22CCB18001DD;
	Mon,  3 Nov 2025 03:17:45 +0000 (UTC)
Received: from localhost (unknown [10.72.112.93])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8F5EE1956056;
	Mon,  3 Nov 2025 03:17:41 +0000 (UTC)
Date: Mon, 3 Nov 2025 11:17:39 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: Re: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide
 root domain when hot-unplug
Message-ID: <aQge00u94JKGF9Tb@fedora>
References: <20251028034357.11055-1-piliu@redhat.com>
 <20251028034357.11055-2-piliu@redhat.com>
 <73663a65-8028-4294-8eaf-9c94dc4451ff@huaweicloud.com>
 <aQH3-_YmqAq9aE67@fedora>
 <44130515-725a-4f44-b064-3b396ed26159@huaweicloud.com>
 <aQNBydr4geMWXebC@fedora>
 <a35dbd76-9f85-4ac2-aa57-1f0f78ff9fc0@huaweicloud.com>
 <aQTF1kLXNHncCCDB@fedora>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQTF1kLXNHncCCDB@fedora>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Ridong,

I have some further findings. Your thoughts would be really
helpful!

On Fri, Oct 31, 2025 at 10:21:10PM +0800, Pingfan Liu wrote:
> On Fri, Oct 31, 2025 at 08:47:14AM +0800, Chen Ridong wrote:
> > 
> > 
> > On 2025/10/30 18:45, Pingfan Liu wrote:
> > > On Thu, Oct 30, 2025 at 02:44:43PM +0800, Chen Ridong wrote:
> > >>
> > >>
> > >> On 2025/10/29 19:18, Pingfan Liu wrote:
> > >>> Hi Ridong,
> > >>>
> > >>> Thank you for your review, please see the comment below.
> > >>>
> > >>> On Wed, Oct 29, 2025 at 10:37:47AM +0800, Chen Ridong wrote:
> > >>>>
> > >>>>
> > >>>> On 2025/10/28 11:43, Pingfan Liu wrote:
> > >>>>> *** Bug description ***
> > >>>>> When testing kexec-reboot on a 144 cpus machine with
> > >>>>> isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
> > >>>>> encounter the following bug:
> > >>>>>
> > >>>>> [   97.114759] psci: CPU142 killed (polled 0 ms)
> > >>>>> [   97.333236] Failed to offline CPU143 - error=-16
> > >>>>> [   97.333246] ------------[ cut here ]------------
> > >>>>> [   97.342682] kernel BUG at kernel/cpu.c:1569!
> > >>>>> [   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
> > >>>>> [...]
> > >>>>>
> > >>>>> In essence, the issue originates from the CPU hot-removal process, not
> > >>>>> limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
> > >>>>> program that waits indefinitely on a semaphore, spawning multiple
> > >>>>> instances to ensure some run on CPU 72, and then offlining CPUs 1–143
> > >>>>> one by one. When attempting this, CPU 143 failed to go offline.
> > >>>>>   bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'
> > >>>>>
> > >>>>> `
> > >>>>> *** Issue ***
> > >>>>> Tracking down this issue, I found that dl_bw_deactivate() returned
> > >>>>> -EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
> > >>>>> But that is not the fact, and contributed by the following factors:
> > >>>>> When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
> > >>>>> blocked-state deadline task (in this case, "cppc_fie"), it was not
> > >>>>> migrated to CPU0, and its task_rq() information is stale. So its rq->rd
> > >>>>> points to def_root_domain instead of the one shared with CPU0.  As a
> > >>>>> result, its bandwidth is wrongly accounted into a wrong root domain
> > >>>>> during domain rebuild.
> > >>>>>
> > >>>>> The key point is that root_domain is only tracked through active rq->rd.
> > >>>>> To avoid using a global data structure to track all root_domains in the
> > >>>>> system, there should be a method to locate an active CPU within the
> > >>>>> corresponding root_domain.
> > >>>>>
> > >>>>> *** Solution ***
> > >>>>> To locate the active cpu, the following rules for deadline
> > >>>>> sub-system is useful
> > >>>>>   -1.any cpu belongs to a unique root domain at a given time
> > >>>>>   -2.DL bandwidth checker ensures that the root domain has active cpus.
> > >>>>>
> > >>>>> Now, let's examine the blocked-state task P.
> > >>>>> If P is attached to a cpuset that is a partition root, it is
> > >>>>> straightforward to find an active CPU.
> > >>>>> If P is attached to a cpuset that has changed from 'root' to 'member',
> > >>>>> the active CPUs are grouped into the parent root domain. Naturally, the
> > >>>>> CPUs' capacity and reserved DL bandwidth are taken into account in the
> > >>>>> ancestor root domain. (In practice, it may be unsafe to attach P to an
> > >>>>> arbitrary root domain, since that domain may lack sufficient DL
> > >>>>> bandwidth for P.) Again, it is straightforward to find an active CPU in
> > >>>>> the ancestor root domain.
> > >>>>>
> > >>>>> This patch groups CPUs into isolated and housekeeping sets. For the
> > >>>>> housekeeping group, it walks up the cpuset hierarchy to find active CPUs
> > >>>>> in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.
> > >>>>>
> > >>>>> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > >>>>> Cc: Waiman Long <longman@redhat.com>
> > >>>>> Cc: Tejun Heo <tj@kernel.org>
> > >>>>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> > >>>>> Cc: "Michal Koutný" <mkoutny@suse.com>
> > >>>>> Cc: Ingo Molnar <mingo@redhat.com>
> > >>>>> Cc: Peter Zijlstra <peterz@infradead.org>
> > >>>>> Cc: Juri Lelli <juri.lelli@redhat.com>
> > >>>>> Cc: Pierre Gondois <pierre.gondois@arm.com>
> > >>>>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > >>>>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > >>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
> > >>>>> Cc: Ben Segall <bsegall@google.com>
> > >>>>> Cc: Mel Gorman <mgorman@suse.de>
> > >>>>> Cc: Valentin Schneider <vschneid@redhat.com>
> > >>>>> To: cgroups@vger.kernel.org
> > >>>>> To: linux-kernel@vger.kernel.org
> > >>>>> ---
> > >>>>> v3 -> v4:
> > >>>>> rename function with cpuset_ prefix
> > >>>>> improve commit log
> > >>>>>
> > >>>>>  include/linux/cpuset.h  | 18 ++++++++++++++++++
> > >>>>>  kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
> > >>>>>  kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
> > >>>>>  3 files changed, 68 insertions(+), 6 deletions(-)
> > >>>>>
> > >>>>> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > >>>>> index 2ddb256187b51..d4da93e51b37b 100644
> > >>>>> --- a/include/linux/cpuset.h
> > >>>>> +++ b/include/linux/cpuset.h
> > >>>>> @@ -12,6 +12,7 @@
> > >>>>>  #include <linux/sched.h>
> > >>>>>  #include <linux/sched/topology.h>
> > >>>>>  #include <linux/sched/task.h>
> > >>>>> +#include <linux/sched/housekeeping.h>
> > >>>>>  #include <linux/cpumask.h>
> > >>>>>  #include <linux/nodemask.h>
> > >>>>>  #include <linux/mm.h>
> > >>>>> @@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
> > >>>>>  
> > >>>>>  extern void cpuset_print_current_mems_allowed(void);
> > >>>>>  extern void cpuset_reset_sched_domains(void);
> > >>>>> +extern void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus);
> > >>>>>  
> > >>>>>  /*
> > >>>>>   * read_mems_allowed_begin is required when making decisions involving
> > >>>>> @@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void)
> > >>>>>  	partition_sched_domains(1, NULL, NULL);
> > >>>>>  }
> > >>>>>  
> > >>>>> +static inline void cpuset_get_task_effective_cpus(struct task_struct *p,
> > >>>>> +		struct cpumask *cpus)
> > >>>>> +{
> > >>>>> +	const struct cpumask *hk_msk;
> > >>>>> +
> > >>>>> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > >>>>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > >>>>> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > >>>>> +			/* isolated cpus belong to a root domain */
> > >>>>> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > >>>>> +			return;
> > >>>>> +		}
> > >>>>> +	}
> > >>>>> +	cpumask_and(cpus, cpu_active_mask, hk_msk);
> > >>>>> +}
> > >>>>> +
> > >>>>>  static inline void cpuset_print_current_mems_allowed(void)
> > >>>>>  {
> > >>>>>  }
> > >>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > >>>>> index 27adb04df675d..6ad88018f1a4e 100644
> > >>>>> --- a/kernel/cgroup/cpuset.c
> > >>>>> +++ b/kernel/cgroup/cpuset.c
> > >>>>> @@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
> > >>>>>  	mutex_unlock(&cpuset_mutex);
> > >>>>>  }
> > >>>>>  
> > >>>>> +/* caller hold RCU read lock */
> > >>>>> +void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
> > >>>>> +{
> > >>>>> +	const struct cpumask *hk_msk;
> > >>>>> +	struct cpuset *cs;
> > >>>>> +
> > >>>>> +	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
> > >>>>> +	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
> > >>>>> +		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
> > >>>>> +			/* isolated cpus belong to a root domain */
> > >>>>> +			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
> > >>>>> +			return;
> > >>>>> +		}
> > >>>>> +	}
> > >>>>> +	/* In HK_TYPE_DOMAIN, cpuset can be applied */
> > >>>>> +	cs = task_cs(p);
> > >>>>> +	while (cs != &top_cpuset) {
> > >>>>> +		if (is_sched_load_balance(cs))
> > >>>>> +			break;
> > >>>>> +		cs = parent_cs(cs);
> > >>>>> +	}
> > >>>>> +
> > >>>>> +	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
> > >>>>> +	cpumask_and(cpus, cs->effective_cpus, hk_msk);
> > >>>>> +}
> > >>>>> +
> > >>>>
> > >>>> It seems you may have misunderstood what Longman intended to convey.
> > >>>>
> > >>>
> > >>> Thanks for pointing that out. That is possible and please let me address
> > >>> your concern.
> > >>>
> > >>>> First, you should add comments to this function because its purpose is not clear. When I first saw
> > >>>
> > >>> OK, I will.
> > >>>
> > >>>> this function, I thought it was supposed to retrieve p->cpus_ptr excluding the offline CPU mask.
> > >>>> However, I'm genuinely confused about the function's actual purpose.
> > >>>>
> > >>>
> > >>> This function retrieves the active CPUs within the root domain where a specified task resides.
> > >>>
> > >>
> > >> Thank you for the further clarification.
> > >>
> > >> 	+	/*
> > >> 	+	 * If @p is in blocked state, task_cpu() may be not active. In that
> > >> 	+	 * case, rq->rd does not trace a correct root_domain. On the other hand,
> > >> 	+	 * @p must belong to an root_domain at any given time, which must have
> > >> 	+	 * active rq, whose rq->rd traces the valid root domain.
> > >> 	+	 */
> > >>
> > >> Is it necessary to walk up to the root partition (is_sched_load_balance(cs))?
> > >>
> > >> The effective_cpus of the cpuset where @p resides should contain active CPUs.
> > >> If all CPUs in cpuset.cpus are offline, it would inherit the parent's effective_cpus for v2, and it
> > >> would move the task to the parent for v1.
> > >>
> 
> I located the code which implemented your comment. And I think for v2,
> you are right. But for v1, there is an async nuance about
> remove_tasks_in_empty_cpuset(). It is scheduled with a work_struct, so
> there is no gurantee that task has been moved to ancestor cpuset before
> rebuild_sched_domains_cpuslocked() is called in cpuset_handle_hotplug(),
> which means that in dl_update_tasks_root_domain(), maybe task's cpuset
> has not been updated yet.
> 

This behavior requires two set of implements for the new introduced
function, one for cpuset V1 due to async, one for v2 which can fetch the
active cpus from p->cpus_ptr directly.

Apart from this drawback, the call sequence of functions matters when
the logic enters the scheduler code for the hot-removal path. The newly
introduced function should be called after cpuset propagation.


Best Regards,

Pingfan


