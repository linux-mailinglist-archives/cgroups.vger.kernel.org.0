Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1E11919E5
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 20:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgCXTat (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 15:30:49 -0400
Received: from mail.efficios.com ([167.114.26.124]:56650 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgCXTas (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 15:30:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4F1DF26C9CD;
        Tue, 24 Mar 2020 15:30:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qDtp_e0PHl9e; Tue, 24 Mar 2020 15:30:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E226526C9CC;
        Tue, 24 Mar 2020 15:30:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E226526C9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1585078246;
        bh=guATgDsIjgBkAOI1TeelZchDx1bD338mzh2lBLsge68=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=SAGfbP5tFl3Sr92fVmTeVcXupjW9hY3xp9R97UaTaj1Q1kPHBaCPsj6xWQcQ0HwAk
         KBCrj6BReJMJx1QG1igNB+jnpvH79NsSVZdZqZeodKLRlg34CIv4X6dcTmuoCuKgX0
         nti72AShqW3z60joPj+3r8ty5Gbc+bEFZ7sq0GOTXEWTfDtZ9Lj6q0TllNhS3vopv4
         MZ1x9b5FpnknlPE1NCPwbkmfYAERafYq36MMLeFNy1bHM9JQDRAwQ3xan996fqYhBe
         upHJ3FpBrr2kXFfr+P/XJHn8I82L5yBDLbmZs3O5iYN86z56T1c6Q0K3m087fSwqVO
         rWquuC1NBczuw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V7tG0TuyZGeC; Tue, 24 Mar 2020 15:30:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D4EA026CE00;
        Tue, 24 Mar 2020 15:30:46 -0400 (EDT)
Date:   Tue, 24 Mar 2020 15:30:46 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Message-ID: <195391080.10219.1585078246788.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200324180139.GB162390@mtj.duckdns.org>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com> <20200219155202.GE698990@mtj.thefacebook.com> <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com> <20200219161222.GF698990@mtj.thefacebook.com> <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com> <20200312182618.GE79873@mtj.duckdns.org> <1289608777.27165.1584042470528.JavaMail.zimbra@efficios.com> <20200324180139.GB162390@mtj.duckdns.org>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Topic: cpuset: offlined CPUs removed from affinity masks
Thread-Index: +1BxSgW2D8wtgSc9ZwTWM+7saWQ/2w==
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

----- On Mar 24, 2020, at 2:01 PM, Tejun Heo tj@kernel.org wrote:

> On Thu, Mar 12, 2020 at 03:47:50PM -0400, Mathieu Desnoyers wrote:
>> The basic idea is to allow applications to pin to every possible cpu, but
>> not allow them to use this to consume a lot of cpu time on CPUs they
>> are not allowed to run.
>> 
>> Thoughts ?
> 
> One thing that we learned is that priority alone isn't enough in isolating cpu
> consumptions no matter how low the priority may be if the workload is latency
> sensitive. The actual computation capacity of cpus gets saturated way before cpu
> time is saturated and latency impact from lowered mips becomes noticeable. So,
> depending on workloads, allowing threads to run at the lowest priority on
> disallowed cpus might not lead to behaviors that users expect but I have no idea
> what kind of usage models you have on mind for the new system call.

Let me take a step back and focus on the requirements for the moment. It should
help us navigate more easily through the various solutions available to us.

Two goals are to enable use-cases such as user-space memory allocator migration of
free memory (typically single-process), and issue operations on each per-CPU data
from the consumer of a user-space per-CPU ring buffer (multi-process over shared
memory).

For the memory allocator use-case, one scenario which illustrates the situation well
is related to CPU hotplug: with per-CPU memory pools, what should the application do
when a CPU goes offline ? Ideally, it should have a manager thread able to detect
that a CPU is offline, and be able to reclaim free memory or move it into other
CPU's pools. However, considering that user-space has no mean to synchronously
do this wrt CPU hotplug, the CPU may very well come back online and start using
those data structures once more, so we cannot presume mutual exclusion from an
offline CPU.

One way to achieve this is by allowing user-space to run rseq critical sections
targeting the per-CPU (user-space) data of any possible CPU.

However, when considering allowing threads to pin themselves on any of the possible
CPUs, three concerns arise:

- CPU hotplug (offline CPUs),
- sched_setaffinity affinity mask, which can be set either internally by the process
  or externally by a manager process,
- cgroup cpuset allowed mask, which can be set either internally or by manager process,

For offline CPUs, the pin_on_cpu system call ensures that a task can run on
a "backup runqueue" when it pins itself onto an offline CPU. The current algorithm
is to choose the first online CPU's runqueue for this. As soon as the offline CPU
is brought back online, all tasks pinned to that CPU are moved to their rightful
runqueue.

For sched_setaffinity's affinity mask, I don't think it is such an issue, because
pinning onto specific CPUs does not provide more rights than what could have been
done by setting the affinity mask to a single CPU. The main difference between
sched_setaffinity to a single cpu and pin_on_cpu is the behavior when the target
CPU goes offline: sched_setaffinity then allows the thread to move to any runqueue
(which is really bad for rseq purposes), whereas pin_on_cpu moves the thread to a
runqueue which is guaranteed to be the same for all threads which want to be pinned
on that CPU.

Then there is the issue of cgroup cpuset: AFAIU, cgroup v1's integration with CPU
hotplug removes the offlined CPUs from the cgroup's allowed mask, which basically
breaks the memory allocator free memory migration/reclaim use-case, because there is
then no way to target an offline CPU if we apply the cgroup's allowed mask.

For cgroup v2, AFAIU it allows creation of groups which target specific threads within
a process. Therefore, some threads could have allowed mask which differ from others.
In this kind of scenario, it's not possible to have a manager thread allowed to
pin itself onto each CPUs which can be accessed by other threads in the same process.

Also, for the multi-process shared memory use-case (ring buffer), if the various
processes which interact with the same shared memory end up in different cgroups
allowed to run on a different subset of the possible CPUs, it becomes impossible to
have a consumer allowed to pin itself on all the CPUs it needs.

Ideally, I would like to come up with an approach that is not fragile when
combined with cgroups or cpu hotplug.

One approach I have envisioned is to allow pin_on_cpu to target CPUs which are
not part of the cpuset's allowed mask, but lower the priority of the threads to
the lowest possible priority while doing so. That approach would allow threads
to pin themselves on basically any CPU part of the possible cpu mask. But as
you point out, maybe this is an issue in terms of workload isolation.

I am welcoming ideas on how to solve this.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
