Return-Path: <cgroups+bounces-16727-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PZ9JOCu0JmoGbgIAu9opvQ
	(envelope-from <cgroups+bounces-16727-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:23:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED366561DB
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:23:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=N0JjK+yh;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16727-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16727-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E2F73059B0F
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D0137BE6D;
	Mon,  8 Jun 2026 12:16:18 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2B73C342B
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920977; cv=none; b=aLXs46zN1HW///l6es6QdEsfSdSex1Qa3bTZw5wgAOFUPMpI9P5+gSFMDCV1LQ6A1nMvRNLn309o0UDaim0M0X07QdwqnTqsFhPKzpeviP74xDG+F8vtnBOc180FfNq5BD2dKpDg8fLE0UidBEzUvXrSE4yziuRnzACtacyIlnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920977; c=relaxed/simple;
	bh=CqaDjjQjOkeL8yfGY4Eb5JSwo7hijLXuwcbTorJIl7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUG2xWGELKMxm12bhy5L/rD3PrI2N7+PW+VjR2qAvQs1vW0rNhWoP1PR7NdI7k9Rxs2SKwkS9B2N+yvgH/AzyddCvCM5uApUIEo610Ul3fWkLPW/xTa5w3a5fS9cRsswIrfeUtRU+3Dtdv67OXWahu8Pmr6ce4+bNZLZK0ouowU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0JjK+yh; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-46015dc517aso3407402f8f.2
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920971; x=1781525771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+Hu7j6VzNGO+KsqpoMk4Vp1tTzaI24I1m+yxcC7P6A=;
        b=N0JjK+yhCbLcXTXdml3xq4nEOYuD6mOW2X+ma1dcCbmlTyOZVOtwEehld76VOyCTXc
         usyLn/Rrz+eOFAcT2b6tdcJye/9ted8bPnLXv+3Uol8NowUGZzFcNuDSVM/Z7r1rnG/9
         GNBY3aQ1v7wShuvqnV3Rmj11FC/mhVf/QWCVFzrx4WMkwQNZe7ac8toDBbRFWx+ppr58
         WYhqfnuGUrVMdNG80YBydvRT5D+HwyJtGWgX4OgWIcBiAhAd5h7DVnlvBnys4Ztn42Xf
         ARISl0NhiF86gyP5BOJI3YWh0pCVSG9gU2l3n37zaSeomJ00Xq4+59egJwCOIsdoRl4Y
         1ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920971; x=1781525771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G+Hu7j6VzNGO+KsqpoMk4Vp1tTzaI24I1m+yxcC7P6A=;
        b=Nc0oMwqJZPhM3pfOXqeSJHXEejr7C0bq1SATFf+dJfWw7qeF8RJAXoaehdjdK6OqI3
         5TussLhGyJS1rcaZWfPjOFsMWiTvoIZbWjtchl0mgns2/gxAoD7sGjnm4nm5fLSWkMbr
         rj12QuIxCkkOpZhEdKr/oCXPnRbywZ4mb/j+CMPML5EX92PJsy0Gni5dvSg2tc5QECPU
         wLtlZmBLciQh+vJvePAXptTZ9h6FbDmFVJKt6qjjQ6l4ksMcbw6Sg1pLvuJpR5yM2w4+
         nmLM+jb2IT6srL0aIi1j1kWPmno9gnd3E7x5lXSyHDkY2/gesuGQebKy67WkabVPZjRo
         z/aw==
X-Gm-Message-State: AOJu0Yyxdj6ULDkZvxEwEJOCo11g3I+qWrFQ1ublonkXorkNy6x3pQPk
	DY/y5TY76BjeY40vDuc3SCCa6V5Du5eodv9nXgq1+2RD8u84TA+cXnuf
X-Gm-Gg: Acq92OGDd7KPdMEAONiGdrmMIMMcUPMg51zNeQphf10d+E9VvZpp/h1NrOoTqgDuFpi
	oCGslrGa3RoZ9wTOIfZtqsbqSqmNlJLl1Pyd34B6zC0wz1i01w4BBtNB/TMMHExb6IhNFq85kLY
	VElIMyLNxlxoloajSYyHPIuQXTM7SAs+jvimRZ/cOK0onZbUP6X0BshsDEhkThRumNmgVAn0u0Q
	G+d/K5nsJKmlYSnEdRltPuNphIjn7Unv4fDIGtmKnmNTsslZbSJGuAFP2nCoqqsb5ifYoW+JDS3
	ucItNTkzyo82i/WcX6xWQaa4hWj4Teoxfi2tiLyt+RLSe2DkssGHLOTwbcehmPa59DEJdwlPJIm
	5MDaYwglsJx15wE1qUc0jmJBAu2PstFg2NMFAuLOw6pJDJQhxnj41VW5HWMffROdwh6vN6xQ5tr
	unopktIM8UCnlUFG3KlDMtcGP2TjSxjfLW5ERj034v+Q==
X-Received: by 2002:a05:6000:c41:b0:455:70bc:216d with SMTP id ffacd0b85a97d-460304fc121mr18378365f8f.12.1780920971112;
        Mon, 08 Jun 2026 05:16:11 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:10 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 25/25] Documentation: Update documentation for real-time cgroups
Date: Mon,  8 Jun 2026 14:15:44 +0200
Message-ID: <20260608121546.69910-26-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-16727-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ED366561DB

Update the RT_GROUP_SCHED specific documentation. Give a brief theoretical
background for Hierarchical Constant Bandwidth Server (HCBS). Document how
the HCBS is implemented in the kernel and how the RT_GROUP_SCHED behaves
now compared to the version which this patchset replaces.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 Documentation/scheduler/sched-rt-group.rst | 470 +++++++++++++++++----
 1 file changed, 393 insertions(+), 77 deletions(-)

diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
index ab464335d320..f00bec718d67 100644
--- a/Documentation/scheduler/sched-rt-group.rst
+++ b/Documentation/scheduler/sched-rt-group.rst
@@ -53,9 +53,12 @@ CPU time is divided by means of specifying how much time can be spent running
 in a given period. We allocate this "run time" for each real-time group which
 the other real-time groups will not be permitted to use.

-Any time not allocated to a real-time group will be used to run normal priority
-tasks (SCHED_OTHER). Any allocated run time not used will also be picked up by
-SCHED_OTHER.
+Each real-time group runs at the same priority as SCHED_DEADLINE, thus they
+share and contend the SCHED_DEADLINE allowed bandwidth. Any time not allocated
+to a real-time group (and SCHED_DEADLINE tasks) will be used to run both
+SCHED_FIFO/SCHED_RR, normal priority tasks (SCHED_OTHER), and SCHED_EXT tasks,
+following the usual priorities. Any allocated run time not used will also be
+picked up by the other scheduling classes, in the same order as before.

 Let's consider an example: a frame fixed real-time renderer must deliver 25
 frames a second, which yields a period of 0.04s per frame. Now say it will also
@@ -73,10 +76,6 @@ The remaining CPU time will be used for user input and other tasks. Because
 real-time tasks have explicitly allocated the CPU time they need to perform
 their tasks, buffer underruns in the graphics or audio can be eliminated.

-NOTE: the above example is not fully implemented yet. We still
-lack an EDF scheduler to make non-uniform periods usable.
-
-
 2. The Interface
 ================

@@ -86,105 +85,422 @@ lack an EDF scheduler to make non-uniform periods usable.

 The system wide settings are configured under the /proc virtual file system:

-/proc/sys/kernel/sched_rt_period_us:
+``/proc/sys/kernel/sched_rt_period_us``:
   The scheduling period that is equivalent to 100% CPU bandwidth.

-/proc/sys/kernel/sched_rt_runtime_us:
-  A global limit on how much time real-time scheduling may use. This is always
-  less or equal to the period_us, as it denotes the time allocated from the
-  period_us for the real-time tasks. Without CONFIG_RT_GROUP_SCHED enabled,
-  this only serves for admission control of deadline tasks. With
-  CONFIG_RT_GROUP_SCHED=y it also signifies the total bandwidth available to
-  all real-time groups.
+``/proc/sys/kernel/sched_rt_runtime_us``:
+  A global limit on how much time real-time scheduling may use (SCHED_DEADLINE
+  tasks + real-time groups). This is always less or equal to the period_us, as
+  it denotes the time allocated from the period_us for the real-time tasks.
+  Without **CONFIG_RT_GROUP_SCHED** enabled, this only serves for admission
+  control of deadline tasks. With **CONFIG_RT_GROUP_SCHED=y** it also signifies
+  the total bandwidth available to both real-time groups and deadline tasks.

   * Time is specified in us because the interface is s32. This gives an
     operating range from 1us to about 35 minutes.
-  * sched_rt_period_us takes values from 1 to INT_MAX.
-  * sched_rt_runtime_us takes values from -1 to sched_rt_period_us.
-  * A run time of -1 specifies runtime == period, ie. no limit.
-  * sched_rt_runtime_us/sched_rt_period_us > 0.05 inorder to preserve
-    bandwidth for fair dl_server. For accurate value check average of
-    runtime/period in /sys/kernel/debug/sched/fair_server/cpuX/
+  * ``sched_rt_period_us`` takes values from 1 to INT_MAX.
+  * ``sched_rt_runtime_us`` takes values from -1 to ``sched_rt_period_us``.
+  * A run time of -1 specifies runtime == period, i.e., no limit, but also
+    disables admission tests for SCHED_DEADLINE.
+
+The default value for both ``sched_rt_period_us`` and ``sched_rt_runtime_us`` is
+1000000 (or 1s), while fair-servers and ext-servers have a default runtime of
+50ms and default period of 1s, giving a minimum of 0.05s to be used by
+SCHED_FIFO/SCHED_RR and non-RT tasks (SCHED_OTHER, SCHED_EXT), while 0.95s are
+the maximum to be used by SCHED_DEADLINE, and rt-cgroups if enabled.
+
+2.2 Cgroup settings
+-------------------
+
+Enabling **CONFIG_RT_GROUP_SCHED** lets you explicitly allocate real CPU
+bandwidth to task groups.
+
+ .. warning::
+  Real Time Cgroups are only available for cgroups-v2.
+ ..
+
+This uses the cgroup virtual file system and the CPU controller for cgroups.
+Enabling the controller for the hierarchy creates two files:
+
+* ``<cgroup>/cpu.rt.max``, which specifies the runtime and period of the group.
+  The file also accepts a runtime of 'max', specifying that its tasks must be
+  scheduled using the nearest configured ancestor (or the root cgroup if it is
+  the nearest non-max ancestor).
+* ``<cgroup>/cpu.rt.internal``, read-only, returns the runtime and period
+  actually allocated to the group, excluding that of its children.
+
+ .. tip::
+  For more information on working with control groups, you should read
+  *Documentation/admin-guide/cgroup-v2.rst*.
+ ..
+
+By default the root cgroup has the same period of
+``/proc/sys/kernel/sched_rt_period_us``, which is 1s, and a runtime of zero, so
+that rt-cgroup is *soft-disabled* by default, and all the runtime is available
+for SCHED_DEADLINE tasks only. New groups instead get a period of zero and
+runtime of 'max' (essentially delegating their tasks' scheduling to the nearest
+configured ancestor).
+
+3. Theoretical Background
+=========================
+
+
+ ..  BIG FAT WARNING ******************************************************
+
+ .. warning::
+
+   This section contains a (not-thorough) summary on deadline/hierarchical
+   scheduling theory, and how it applies to real-time control groups.
+   The reader can "safely" skip to Section 4 if only interested in seeing
+   how the scheduling policy can be used. Anyway, we strongly recommend
+   to come back here and continue reading (once the urge for testing is
+   satisfied :P) to be sure of fully understanding all technical details.
+
+ .. ************************************************************************
+
+The real-time cgroup scheduler is based upon the **Hierarchical Constant
+Bandwidth Server** (HCBS) [1] *Compositional Scheduling Framework* (CSF). A
+**CSF** is a framework where global (system-level) timing properties can be
+established by composing independently (specified and) analyzed local
+(component-level) timing properties [5].
+
+For HCBS (related to the Linux kernel), the compositional framework consists of
+two parts:
+
+* The *scheduling components*, which are the basic units of the scheduling. In
+  the kernel these are the single cgroups along with the tasks that must be run
+  inside.
+
+* The *scheduling resources*, which are the CPUs of the machine.
+
+HCBS is a *hierarchical scheduling framework*, where the scheduling components
+form a hierarchy and resources are allocated from parent components to its child
+components in the hierarchy.
+
+The Chapter is organized as follows: **Section 3.1** gives basic real-time
+theory definitions that are used throughout the whole section. **Section 3.2**
+talks about the HCBS framework, giving a general idea on how this is structured.
+**Section 3.3** introduces the MPR model, one of the many models which may be
+used for the analysis of the scheduling components and the computation of the
+minimum required scheduling resources for a given component. **Section 3.4**
+shows the schedulability test for MPR on the HCBS framework. **Section 3.5**
+shows how to convert a MPR interface to a HCBS compatible resource reservation
+for a component. Finally, **Section 3.6** lists other interesting models which
+could be used for the component analysis in HCBS.
+
+3.1 Basic Definitions
+---------------------

+*We borrow the same definitions given in the* ``sched_deadline`` *document, which
+are very briefly summarized here, and new ones, needed by the following content,
+are added.*
+
+A typical real-time task is composed of a repetition of computation phases (task
+instances, or jobs) which are activated on a periodic or sporadic fashion. For
+our purposes, real-time tasks are characterized by three parameters:
+
+* Worst Case Execution Time (WCET): the maximum execution time among all jobs.
+* Relative Deadline (D): the maximum time each job must be completed, relative
+  to the release time of the job.
+* Inter-Arrival Period (P): the exact/minimum (for periodic/sporadic tasks) time
+  between each consecutive job.
+
+3.2 Hierarchical Constant Bandwidth Server (HCBS) [1]
+-----------------------------------------------------
+
+As mentioned, HCBS is a *hierarchical scheduling framework*:
+
+* The framework hierarchy follows the same hierarchy of cgroups. Cgroups may
+  have two roles, either bandwidth reservation for children cgroups, or they may
+  be *live*, i.e. run tasks (but not both). The root cgroup, for the kernel's
+  implementation of HCBS, acts only as bandwidth reservation (but as written in
+  this document it has also different uses outside of the hierarchical
+  framework).
+* The cgroup tree is internally flattened, for ease of scheduling, to a
+  two-level hierarchy, since only the *live* groups are of interest and all the
+  necessary information for their scheduling lies in their interface (there is
+  no need for the reservation components).
+* The hierarchical framework, now on two levels, consists then of a first level
+  of cgroups, and a second level of tasks that are run inside these groups.
+* The scheduling of components is performed using global Earliest Deadline First
+  (gEDF), SCHED_DEADLINE in the kernel, following the bandwidth reservation of
+  each group.
+* Whenever a component is scheduled, a local scheduler picks which of the tasks
+  of the cgroup to run. The scheduling policy is global Fixed Priority (gFP),
+  SCHED_FIFO/SCHED_RR in the kernel.

-2.2 Default behaviour
----------------------
+3.3 Multiprocessor Periodic Resource (MPR) model
+------------------------------------------------
+
+A Multiprocessor Periodic Resource (MPR) model [2] **u = <Pi, Theta, m'>**
+specifies that an identical, unit-capacity multiprocessor platform collectively
+provides **Theta** units of resource every **Pi** time units, where the
+**Theta** time units are supplied with concurrency at most **m'**.
+
+This theoretical model is one of the many models that can abstract the
+interface of our real-time cgroups: let **m'** be the number of CPUs of the
+machine, let **Theta** be **m' * <cgroup>/cpu.rt_runtime_us** and **Pi** be
+**<cgroup>/cpu.rt_period_us**.
+
+Let's introduce the concept of Supply Bound Function (SBF). A SBF is a function
+which outputs a lower bound for the processor supply provided in a given time
+interval, given a resource supply model. For a completely dedicated CPU, the SBF
+function is simply the identity function, as it will always provide **t** units
+of computation for an interval of length **t**. The situation gets slightly more
+complicated for the MPR model or any of the other model listed in section 3.6.
+
+The **SBF(t)** for a MPR model **u = <Pi, Theta, m'>** is::
+
+             | 0                                       if t' < 0
+             |
+  SBF_u(t) = | floor(t' / PI) * Theta
+             |   + max(0, m' * x - (m' * Pi - Theta)   if t' >= 0 and 1 <= x <= y
+             |
+             | floor(t' / PI) * Theta
+             |   + max(0, m' * x - (m' * Pi - Theta)   else
+             |   - (m' - beta)
+
+where::
+
+  alpha = floor(Theta / m')
+  beta = Theta - m' * alpha
+  t' = t - (Pi - ceil(Theta / m'))
+  x  = t' - (Pi * floor(t' / Pi))
+  y  = Pi - floor(Theta / m')
+
+Briefly, this function models that the server's bandwidth is given as late as
+possible, so describing the worst case possible for the supplied bandwidth.
+
+3.4 Schedulability for MPR on global Fixed-Priority
+---------------------------------------------------
+
+Let's introduce the concept of Demand Bound Function (DBF). A DBF is a function
+that, given a taskset, a scheduling algorithm and an interval of time, outputs
+the worst resource demand for that interval of time.
+
+It is easy to see that, given a DBF and a SBF, we can deem a component/taskset
+schedulable if, for every time interval t >= 0, it is possible to demonstrate
+that:
+
+  DBF(t) <= SBF(t)
+
+We have the Supply Bound Function for our given MPR model, so we are missing the
+Demand Bound Function for a given taskset that is being scheduled using global
+Fixed Priority.
+
+3.4.1 Schedulability Analysis for global Fixed Priority
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Bertogna, Cirinei and Lipari [6] have derived a schedulability test for global
+Fixed Priority (gFP) on multi-processor platforms. In this test (called
+*BCL_gFP* test) we can consider all the CPUs to be dedicated to the scheduling.
+
+  A taskset **Tau** is schedulable with gFP on a multiprocessor platform
+  composed of **m'** identical processors if for each task **tau_k in Tau**:
+
+    Sum(for i < k)( min(W_i(D_k), D_k - C_k + 1) ) < m' * (D_k - C_k + 1)
+
+  where **W_i(t)** is the workload of task **tau_i** over a time interval **t**:
+
+    W_i(t) = N_i(t) * C_i + min(C_i, t + D_i - C_i - N_i(t) * P_i)

-The default values for sched_rt_period_us (1000000 or 1s) and
-sched_rt_runtime_us (950000 or 0.95s).  This gives 0.05s to be used by
-SCHED_OTHER (non-RT tasks). These defaults were chosen so that a run-away
-real-time tasks will not lock up the machine but leave a little time to recover
-it.  By setting runtime to -1 you'd get the old behaviour back.
+  and **N_i(t)** is the number of activations of task **tau_i** that complete in
+  a time interval **t**:

-By default all bandwidth is assigned to the root group and new groups get the
-period from /proc/sys/kernel/sched_rt_period_us and a run time of 0. If you
-want to assign bandwidth to another group, reduce the root group's bandwidth
-and assign some or all of the difference to another group.
+    N_i(t) = floor( (t + D_i - C_i) / P_i )

-Real-time group scheduling means you have to assign a portion of total CPU
-bandwidth to the group before it will accept real-time tasks. Therefore you will
-not be able to run real-time tasks as any user other than root until you have
-done that, even if the user has the rights to run processes with real-time
-priority!
+  while the **min** term is the contribution of the carried-out job in the
+  interval **t**, i.e. that job that does not completely fit in the interval
+  **t**, but starts inside the interval after all the jobs that complete.
+
+3.4.2 From BCL_gFP to the Demand Bound Function
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+We can then derive the DBF from this test:
+
+  DBF_gFP(tau_k) = Sum(for i < k)( min(W_i(D_k), D_k - C_k + 1) ) + m' * (C_k - 1)
+
+Briefly, the first sum component, the same in the BCL_gFP test, describes the
+maximum interference that higher priority task give to the analysed task. The
+workload is upperbounded by ``(D_k - C_K + 1)`` because we are only interested
+in the interference in the slack time, while for the ``C_k`` time we are
+requiring that all the CPUs are fully available, as the single job needs `C_k`
+(non overlapping) time units to run.
+
+The demand bound function from Bertogna et al. is only defined on a single time
+(i.e. the deadline of the task in analysis) instead of all possible times as
+this is the minimum argument to demonstrate schedulability on global Fixed
+Priority.
+
+3.4.3 Putting it all togheter
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+A component **C**, on **m'** processors, running a taskset **Tau = { tau_1 =
+(C_1, D_1, P_1), ..., tau_n = (C_n, D_n, P_n) }** of **n** sporadic tasks, is
+schedulable under gFP using an MPR model **u = <Pi, Theta, m'>**, if for all
+tasks **tau_k in Tau**:
+
+  DBF_gFP(tau_k) <= SBF_u(D_K)
+
+3.5 From MPR to deadline servers
+--------------------------------
+
+Since there exist no algorithm to schedule MPR interfaces, a tecnique was
+developed to transform MPR interfaces into periodic tasks, so that a
+number of periodic servers which respect the tasks requirements can be used for
+the scheduling of the MPR interface and associated tasks.
+
+Let **u = <Pi, Theta, m>** be a MPR interface, let **a = Theta - m * floor(Theta
+/ m)**, let **k = floor(a)**. Define a transformation from **u** to a periodic
+taskset **Tau_u = { tau_1 = (C_1, D_1, P_1), ..., tau_m' = (C_m', D_m', P_m')
+}**, where:
+
+  **tau_1 = ... = tau_k = (floor(Theta / m') + 1, Pi, Pi)**
+
+  **tau_k+1 = (floor(Theta / m') + a - k * floor(a/k), Pi, Pi)**
+
+  **tau_k+2 = ... = tau_m' = (floor(Theta / m'), Pi, Pi)**
+
+This periodic taskset of servers **Tau_u** can be scheduled on any number of
+processors with concurrency at most **m'**.
+
+For real-time control groups, it is possible to just consider a slightly more
+demanding taskset **Tau_u'**, where each task **tau_i** is defined as follows:
+
+  **tau_i = (ceil(Theta / m'), Pi, Pi)**
+
+3.6 Other models
+----------------
+
+There exist many other theoretical models in literature which are used to
+describe a hierarchical scheduling framework on multi-core architectures.
+Notable examples are the Multi Supply Function (MSF) abstraction [3], the
+Parallel Supply Function (PSF) abstraction [4] and the Bounded Delay
+Multipartition (BDM) [7].
+
+3.7 References
+--------------
+  1 - L. Abeni, A. Balsini, and T. Cucinotta, “Container-based real-time
+      scheduling in the Linux kernel,” SIGBED Rev., vol. 16, no. 3, pp. 33-38,
+      Nov. 2019, doi: 10.1145/3373400.3373405.
+  2 - A. Easwaran, I. Shin, and I. Lee, “Optimal virtual cluster-based
+      multiprocessor scheduling,” Real-Time Syst, vol. 43, no. 1, pp. 25-59,
+      Sept. 2009, doi: 10.1007/s11241-009-9073-x.
+  3 - E. Bini, G. Buttazzo, and M. Bertogna, “The Multi Supply Function
+      Abstraction for Multiprocessors,” in 2009 15th IEEE International
+      Conference on Embedded and Real-Time Computing Systems and Applications,
+      Aug. 2009, pp. 294-302. doi: 10.1109/RTCSA.2009.39.
+  4 - E. Bini, B. Marko, and S. K. Baruah, “The Parallel Supply Function
+      Abstraction for a Virtual Multiprocessor,” in Scheduling, S. Albers, S. K.
+      Baruah, R. H. Möhring, and K. Pruhs, Eds., in Dagstuhl Seminar Proceedings
+      (DagSemProc), vol. 10071. Dagstuhl, Germany: Schloss Dagstuhl -
+      Leibniz-Zentrum für Informatik, 2010, pp. 1-14. doi:
+      10.4230/DagSemProc.10071.14.
+  5 - I. Shin and I. Lee, “Compositional real-time scheduling framework,” in
+      25th IEEE International Real-Time Systems Symposium, Dec. 2004, pp. 57-67.
+      doi: 10.1109/REAL.2004.15.
+  6 - M. Bertogna, M. Cirinei, and G. Lipari, “Schedulability Analysis of Global
+      Scheduling Algorithms on Multiprocessor Platforms,” IEEE Transactions on
+      Parallel and Distributed Systems, vol. 20, no. 4, pp. 553-566, Apr. 2009,
+      doi: 10.1109/TPDS.2008.129.
+  7 - G. Lipari and E. Bini, “A Framework for Hierarchical Scheduling on
+      Multiprocessors: From Application Requirements to Run-Time Allocation,” in
+      2010 31st IEEE Real-Time Systems Symposium, Nov. 2010, pp. 249-258. doi:
+      10.1109/RTSS.2010.12.
+
+
+4. Using Real-Time cgroups
+==========================
+
+4.1 CGroup Setup
+----------------

+The following is a brief guide to the use of Real-Time Control Groups.

-2.3 Basis for grouping tasks
-----------------------------
+Of course, real-time control groups require mounting of the cgroup file system.
+We have decided to only support cgroups v2, so make sure you mount the v2
+controller for the cgroup hierarchy.

-Enabling CONFIG_RT_GROUP_SCHED lets you explicitly allocate real
-CPU bandwidth to task groups.
+Additionally the real-time cgroups require the CPU controller for the cgroups to
+be enabled::

-This uses the cgroup virtual file system and "<cgroup>/cpu.rt_runtime_us"
-to control the CPU time reserved for each control group.
+  # Assume the cgroup file system is mounted at /sys/fs/cgroup
+  > echo "+cpu" > /sys/fs/cgroup/cgroup.subtree_control

-For more information on working with control groups, you should read
-Documentation/admin-guide/cgroup-v1/cgroups.rst as well.
+The CPU controller can only be mounted if there is no SCHED_FIFO/SCHED_RR task
+scheduled in any cgroup other than the root control group.

-Group settings are checked against the following limits in order to keep the
-configuration schedulable:
+The root control group has no bandwidth allocated by default, so make sure to
+allocate some bandwidth so that it can be used by the other cgroups. More on
+that in the following section...

-   \Sum_{i} runtime_{i} / global_period <= global_runtime / global_period
+4.2 Bandwidth Allocation for groups
+-----------------------------------

-For now, this can be simplified to just the following (but see Future plans):
+Allocating bandwidth to a cgroup is a fundamental step to run real-time
+workload. The cgroup filesystem exposes two files:

-   \Sum_{i} runtime_{i} <= global_runtime
+* ``<cgroup>/cpu.rt.max``: which specifies the cgroups' runtime and period in
+  microseconds.
+* ``<cgroup>/cpu.rt.internal``: read-only, get the cgroups' actualy runtime and
+  period in microseconds, without its children's bandwidth.

+By definition, the specified runtime must be always less than or equal to the
+period. Additionally, an admission test checks if the bandwidth invariant is
+respected (i.e. sum of children's bandwidth <= parent's bandwidth).

-3. Future plans
-===============
+The root control group files instead control and reserve the SCHED_DEADLINE
+bandwidth allocated to real-time cgroups, since real-time groups compete and
+share the same bandwidth allocated to SCHED_DEADLINE tasks.

-There is work in progress to make the scheduling period for each group
-("<cgroup>/cpu.rt_period_us") configurable as well.
+4.3 Running real-time tasks in groups
+-------------------------------------

-The constraint on the period is that a subgroup must have a smaller or
-equal period to its parent. But realistically its not very useful _yet_
-as its prone to starvation without deadline scheduling.
+To run tasks in real-time groups it is just necessary to change a tasks
+scheduling policy to SCHED_FIFO/SCHED_RR and migrate it into the group. If the
+group is not allowed to run real-time tasks because of incorrect configuration,
+either migrating a SCHED_FIFO/SCHED_RR task into the group or changing
+scheduling policy to a task already inside the group will fail::

-Consider two sibling groups A and B; both have 50% bandwidth, but A's
-period is twice the length of B's.
+ # assume there is a task of PID 42 running
+ # change its scheduling policy to SCHED_FIFO, priority 99
+ > chrt -f -p 99 42

-* group A: period=100000us, runtime=50000us
+ # migrate the task to a cgroup
+ > echo 42 > /sys/fs/cgroup/<my-cgroup>/cgroup.procs

-	- this runs for 0.05s once every 0.1s
+4.4 Special case: the root control group
+----------------------------------------

-* group B: period= 50000us, runtime=25000us
+The root cgroup is special, compared to the other cgroups, as its tasks are not
+managed by the HCBS algorithm, rather they just use the original
+SCHED_FIFO/SCHED_RR policies (as if CONFIG_RT_GROUP_SCHED was disabled). As
+mentioned, its bandwidth files are just used to control how much of the
+SCHED_DEADLINE bandwidth is allocated to cgroups.

-	- this runs for 0.025s twice every 0.1s (or once every 0.05 sec).
+Any non-root cgroup configured as 'max' that has the root cgroup as its nearest
+non-max ancestor will run its tasks in the root runqueue.

-This means that currently a while (1) loop in A will run for the full period of
-B and can starve B's tasks (assuming they are of lower priority) for a whole
-period.
+4.5 Guarantees and Special Behaviours
+-------------------------------------

-The next project will be SCHED_EDF (Earliest Deadline First scheduling) to bring
-full deadline scheduling to the linux kernel. Deadline scheduling the above
-groups and treating end of the period as a deadline will ensure that they both
-get their allocated time.
+Real-time cgroups are run at the same priority level of SCHED_DEADLINE tasks.
+Since this is the highest priority scheduling policy, and since the Constant
+Bandwidth Server (CBS) enforces that the specified bandwidth requirements for
+both groups and tasks cannot be overrun, real-time groups have the same
+guarantees that SCHED_DEADLINE tasks have, i.e. they will be necessarily
+supplied by the amount of bandwidth requested (whenever the admission tests
+pass).

-Implementing SCHED_EDF might take a while to complete. Priority Inheritance is
-the biggest challenge as the current linux PI infrastructure is geared towards
-the limited static priority levels 0-99. With deadline scheduling you need to
-do deadline inheritance (since priority is inversely proportional to the
-deadline delta (deadline - now)).
+This means that, since SCHED_FIFO/SCHED_RR tasks (scheduled in the root control
+group) are not subject to bandwidth controls, they are run at a lower priority
+than the cgroups' counterparts. Nonetheless, a minimum amount of bandwidth, if
+reserved, will always be available to run SCHED_FIFO/SCHED_RR workloads in the
+root cgroup, while they will be able to use more runtime if any of the
+SCHED_DEADLINE tasks or servers use less than their specified amount of
+bandwidth. SCHED_OTHER tasks are instead scheduled as normal, at lower priority
+than real-time workloads.

-This means the whole PI machinery will have to be reworked - and that is one of
-the most complex pieces of code we have.
+The aforementioned behaviour differs from the preceding RT_GROUP_SCHED
+implementation, but this is necessary to give actual guarantees to the amount of
+bandwidth given to rt-cgroups.
\ No newline at end of file
--
2.54.0


