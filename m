Return-Path: <cgroups+bounces-4968-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81CF988348
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 13:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEFCB256FF
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 11:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8131898E4;
	Fri, 27 Sep 2024 11:26:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E597189B88
	for <cgroups@vger.kernel.org>; Fri, 27 Sep 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436376; cv=none; b=dg/VtoZCvn9xqfPMG6t3/mFHUDIOqUwXMr5jlNNKkvJGFWSRr67A8/nyZfjexGF3p90wVTKp3glIQI7LNknyuPWh1cbNNnpc0ozAlrK7sB+qe8kpOzMdp804YO7qlq/Vq0wYVaxhjRJyslnya3/OXp2PRWUQO4DEN1ZoYtr1A2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436376; c=relaxed/simple;
	bh=3Nlggbn+a3sWcQx3giHR3u+G1LcMdJHSqsAd74CVCOs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EQ8ldtAkj0r3PlmqGUPoDNzw2f/ZmeDGykoojh9o0e7c6lCqf3WVAWxXa1F25/6nGM3MDYHu6Bpdu1Cx+ObWKmHoTyYen+sbT1x+UBX0qJQhL57C29aIYx/Gy7Q06paXxgR0fH00ga45TNr0blrWrtm+ppqXK1fNxpbPPIPB72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.71.54])
	by sina.com (10.185.250.22) with ESMTP
	id 66F6962300005DF6; Fri, 27 Sep 2024 19:25:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1556157602641
X-SMAIL-UIID: E6BEB0D0A78B4CD2BAA73B20F7122752-20240927-192526-1
From: Hillf Danton <hdanton@sina.com>
To: Michal Koutny <mkoutny@suse.com>
Cc: Chen Ridong <chenridong@huawei.com>,
	tj@kernel.org,
	cgroups@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and cpu_hotplug_lock
Date: Fri, 27 Sep 2024 19:25:16 +0800
Message-Id: <20240927112516.1136-1-hdanton@sina.com>
In-Reply-To: <4fee4fydxuxzee5cb5ehiil7g7bnhxp5cmxxgg3zszc4vx4qyc@6t2qmltutcrh>
References: <20240817093334.6062-1-chenridong@huawei.com> <20240817093334.6062-2-chenridong@huawei.com> <20240911111542.2781-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Sep 2024 14:53:46 +0200 Michal Koutny <mkoutny@suse.com>
> On Wed, Sep 11, 2024 at 07:15:42PM GMT, Hillf Danton <hdanton@sina.com> wrote:
> > > However, there is no ordering between (I) and (II) so they can also happen
> > > in opposite
> > > 
> > > 	thread T					system_wq worker
> > > 
> > > 	down(cpu_hotplug_lock.read)
> > > 	smp_call_on_cpu
> > > 	  queue_work_on(cpu, system_wq, scss) (I)
> > > 	  						lock(cgroup_mutex)  (II)
> > > 							...
> > > 							unlock(cgroup_mutex)
> > > 							scss.func
> > > 	  wait_for_completion(scss)
> > > 	up(cpu_hotplug_lock.read)
> > > 
> > > And here the thread T + system_wq worker effectively call
> > > cpu_hotplug_lock and cgroup_mutex in the wrong order. (And since they're
> > > two threads, it won't be caught by lockdep.)
> > > 
> > Given no workqueue work executed without being dequeued, any queued work,
> > regardless if they are more than 2048, that acquires cgroup_mutex could not
> > prevent the work queued by thread-T from being executed, so thread-T can
> > make safe forward progress, therefore with no chance left for the ABBA 
> > deadlock you spotted where lockdep fails to work.
> 
> Is there a forgotten negation and did you intend to write: "any queued
> work ... that acquired cgroup_mutex could prevent"?
> 
No I did not.

> Or if the negation is correct, why do you mean that processed work item
> is _not_ preventing thread T from running (in the case I left quoted
> above)?
>
If N (N > 1) cgroup work items are queued before one cpu hotplug work, then
1) workqueue worker1 dequeues cgroup work1 and executes it,
2) worker1 goes off cpu and falls in nap because of failure of acquiring
cgroup_mutex,
3) worker2 starts processing cgroup work2 and repeats 1) and 2),
4) after N sleepers, workerN+1 dequeus the hotplug work and executes it
and completes finally.

Clear lad?

