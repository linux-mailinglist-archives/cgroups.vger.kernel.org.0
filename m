Return-Path: <cgroups+bounces-4842-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396B97509B
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 13:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87DA28EDF6
	for <lists+cgroups@lfdr.de>; Wed, 11 Sep 2024 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E0D1885BA;
	Wed, 11 Sep 2024 11:16:10 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail115-79.sinamail.sina.com.cn (mail115-79.sinamail.sina.com.cn [218.30.115.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E9B187343
	for <cgroups@vger.kernel.org>; Wed, 11 Sep 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726053370; cv=none; b=WhOk+3SqAWBR/Ej4XO8zG1TI4Zz7x43rmN8WYoU3fWTCXK56Fuamz0mAMam1smQIY0b51TCcTTDvqgOkiAEW9NTije/ifajckqWMAh/tE1/bYPW9TU3bmCO/8XwuPTGa9xlzDTdDlCzsfiRukhCdzn7cNEAkMoPSJzryzZ6vM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726053370; c=relaxed/simple;
	bh=6bkGPTgASUz7T7BijlfbTQLd05M+Z8oXh12xRDX2ozI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lcbVp2p/ILpfD5HJKma+ebN0kLxqairYtXgAHJOjXnCgYRJRsGN4wiuGYQn2cKrkfT3ML3CoQ3FoubXpo8NE7UvP4C2iyUeVWjJPtzYkbpHs2ufQeCL4rCepViDZSIpe95shq+eyHqyfhCCG9ogSOyWSWN14OdyT4eK+DwkRwGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.131])
	by sina.com (10.185.250.22) with ESMTP
	id 66E17BE700003615; Wed, 11 Sep 2024 19:15:54 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 5570657602697
X-SMAIL-UIID: ACB3667F41DC4FBA825760F89E1A6320-20240911-191554-1
From: Hillf Danton <hdanton@sina.com>
To: Michal Koutny <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>,
	tj@kernel.org,
	cgroups@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Wed, 11 Sep 2024 19:15:42 +0800
Message-Id: <20240911111542.2781-1-hdanton@sina.com>
In-Reply-To: <kz6e3oadkmrl7elk6z765t2hgbcqbd2fxvb2673vbjflbjxqck@suy4p2mm7dvw>
References: <20240817093334.6062-1-chenridong@huawei.com> <20240817093334.6062-2-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 9 Sep 2024 16:19:38 +0200 Michal Koutny <mkoutny@suse.com>
> On Sat, Aug 17, 2024 at 09:33:34AM GMT, Chen Ridong <chenridong@huawei.com> wrote:
> > The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
> > acquired in different tasks, which may lead to deadlock.
> > It can lead to a deadlock through the following steps:
> > 1. A large number of cpusets are deleted asynchronously, which puts a
> >    large number of cgroup_bpf_release works into system_wq. The max_active
> >    of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
> >    cgroup_bpf_release works, and many cgroup_bpf_release works will be put
> >    into inactive queue. As illustrated in the diagram, there are 256 (in
> >    the acvtive queue) + n (in the inactive queue) works.
> > 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
> >    smp_call_on_cpu work into system_wq. However step 1 has already filled
> >    system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
> >    to wait until the works that were put into the inacvtive queue earlier
> >    have executed (n cgroup_bpf_release), so it will be blocked for a while.
> > 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
> > 4. Cpusets that were deleted at step 1 put cgroup_release works into
> >    cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
> >    When cgroup_metux is acqured by work at css_killed_work_fn, it will
> >    call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
> >    However, cpuset_css_offline will be blocked for step 3.
> > 5. At this moment, there are 256 works in active queue that are
> >    cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
> >    a result, all of them are blocked. Consequently, sscs.work can not be
> >    executed. Ultimately, this situation leads to four processes being
> >    blocked, forming a deadlock.
> >
> > system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
> > ...
> > 2000+ cgroups deleted asyn
> > 256 actives + n inactives
> > 				__lockup_detector_reconfigure
> > 				P(cpu_hotplug_lock.read)
> > 				put sscs.work into system_wq
> > 256 + n + 1(sscs.work)
> > sscs.work wait to be executed
> > 				warting sscs.work finish
> > 								percpu_down_write
> > 								P(cpu_hotplug_lock.write)
> > 								...blocking...
> > 											css_killed_work_fn
> > 											P(cgroup_mutex)
> > 											cpuset_css_offline
> > 											P(cpu_hotplug_lock.read)
> > 											...blocking...
> > 256 cgroup_bpf_release
> > mutex_lock(&cgroup_mutex);
> > ..blocking...
> 
> Thanks, Ridong, for laying this out.
> Let me try to extract the core of the deps above.
> 
> The correct lock ordering is: cgroup_mutex then cpu_hotplug_lock.
> However, the smp_call_on_cpu() under cpus_read_lock may lead to
> a deadlock (ABBA over those two locks).
> 
> This is OK
> 	thread T					system_wq worker
> 
> 	  						lock(cgroup_mutex) (II)
> 							...
> 							unlock(cgroup_mutex)
> 	down(cpu_hotplug_lock.read)
> 	smp_call_on_cpu
> 	  queue_work_on(cpu, system_wq, scss) (I)
> 							scss.func
> 	  wait_for_completion(scss)
> 	up(cpu_hotplug_lock.read)
> 
> However, there is no ordering between (I) and (II) so they can also happen
> in opposite
> 
> 	thread T					system_wq worker
> 
> 	down(cpu_hotplug_lock.read)
> 	smp_call_on_cpu
> 	  queue_work_on(cpu, system_wq, scss) (I)
> 	  						lock(cgroup_mutex)  (II)
> 							...
> 							unlock(cgroup_mutex)
> 							scss.func
> 	  wait_for_completion(scss)
> 	up(cpu_hotplug_lock.read)
> 
> And here the thread T + system_wq worker effectively call
> cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> two threads, it won't be caught by lockdep.)
> 
Given no workqueue work executed without being dequeued, any queued work,
regardless if they are more than 2048, that acquires cgroup_mutex could not
prevent the work queued by thread-T from being executed, so thread-T can
make safe forward progress, therefore with no chance left for the ABBA 
deadlock you spotted where lockdep fails to work.

