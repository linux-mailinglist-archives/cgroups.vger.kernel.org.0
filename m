Return-Path: <cgroups+bounces-3610-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E174C92DEF4
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 05:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1985B1C212FA
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 03:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BC381AD;
	Thu, 11 Jul 2024 03:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ofbF4vP6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C17E1A28B
	for <cgroups@vger.kernel.org>; Thu, 11 Jul 2024 03:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720669964; cv=none; b=BPVja43uVl4ZC4FuWmFSA3fln+M9XnivZsucBHwG9P2PJB09phvKpRjVyuzdWrfU7hlg0BhrnTuJXgoVvR+TJDV/RXfZ9mXq0IcRy7ue1q9P903hHWXlRNhUh6NtDRYKcAT2liWueAczkUDGyvH9Bw33wi/JCZY6LnPvIeW7qyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720669964; c=relaxed/simple;
	bh=w/CRzOULj8k8/ejOmbwzniOhftViOF29wdQSEI+N5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Euc8g1oMcGGr5ciF2PMb1NAKq6AbQI3K714eVwuQFSHxV+q98SwPqIPu/H0uff5aAl5CEMODzLdLo4fik6Elt+P6Rgf31tx1BXHJho97kERLSFf3Q9XeYUN6uQwqqVxkoQhT08O31mv32GoHlBddBILUueqwVXKerc+9CZeMwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ofbF4vP6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: chenridong@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720669960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOoSWA4MuzyTNUQetsPg/A3T+W7+WdTLofO63JGsjfs=;
	b=ofbF4vP6UJsG8giA+5QkqYZkVxGkAJUpVil750kXaMu56AzHKchWE/oM2IYvY9A0ScI5k0
	I9zc7zl7dGoaQDD8cGGgjXvYXgKygcs/lYUE1A56Q6tznOLlLm2lSGerz/qfM4Gpm9FpEj
	6R+yKX8DjfFls68+CJ/dD/vav9WGtik=
X-Envelope-To: tj@kernel.org
X-Envelope-To: martin.lau@linux.dev
X-Envelope-To: ast@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: andrii@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: song@kernel.org
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: sdf@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2024 03:52:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: chenridong <chenridong@huawei.com>, tj@kernel.org
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, tj@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
Message-ID: <Zo9XAmjpP6y0ZDGH@google.com>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
 <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
 <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 10, 2024 at 11:02:57AM +0800, chenridong wrote:
> 
> 
> On 2024/7/9 21:42, chenridong wrote:
> > 
> > 
> > On 2024/6/10 10:47, Roman Gushchin wrote:
> > > Hi Chen!
> > > 
> > > Was this problem found in the real life? Do you have a LOCKDEP
> > > splash available?
> > > 
> > Sorry for the late email response.
> > Yes, it was. The issue occurred after a long period of stress testing,
> > with a very low probability.
> > > > On Jun 7, 2024, at 4:09 AM, Chen Ridong <chenridong@huawei.com> wrote:
> > > > 
> > > > ﻿We found an AA deadlock problem as shown belowed:
> > > > 
> > > > cgroup_destroy_wq        TaskB                WatchDog
> > > > system_wq
> > > > 
> > > > ...
> > > > css_killed_work_fn:
> > > > P(cgroup_mutex)
> > > > ...
> > > >                                 ...
> > > >                                 __lockup_detector_reconfigure:
> > > >                                 P(cpu_hotplug_lock.read)
> > > >                                 ...
> > > >                 ...
> > > >                 percpu_down_write:
> > > >                 P(cpu_hotplug_lock.write)
> > > >                                                 ...
> > > >                                                 cgroup_bpf_release:
> > > >                                                 P(cgroup_mutex)
> > > >                                 smp_call_on_cpu:
> > > >                                 Wait system_wq
> > > > 
> > > > cpuset_css_offline:
> > > > P(cpu_hotplug_lock.read)
> > > > 
> > > > WatchDog is waiting for system_wq, who is waiting for cgroup_mutex, to
> > > > finish the jobs, but the owner of the cgroup_mutex is waiting for
> > > > cpu_hotplug_lock. This problem caused by commit 4bfc0bb2c60e ("bpf:
> > > > decouple the lifetime of cgroup_bpf from cgroup itself")
> > > > puts cgroup_bpf release work into system_wq. As cgroup_bpf is a
> > > > member of
> > > > cgroup, it is reasonable to put cgroup bpf release work into
> > > > cgroup_destroy_wq, which is only used for cgroup's release work, and the
> > > > preblem is solved.
> > > 
> > > I need to think more on this, but at first glance the fix looks a
> > > bit confusing. cgroup_bpf_release() looks quite innocent, it only
> > > takes a cgroup_mutex. It’s not obvious why it’s not ok and requires
> > > a dedicated work queue. What exactly is achieved by placing it back
> > > on the dedicated cgroup destroy queue?
> > > 
> > > I’m not trying to say your fix won’t work, but it looks like it
> > > might cover a more serious problem.
> > 
> > The issue lies in the fact that different tasks require the cgroup_mutex
> > and cpu_hotplug_lock locks, eventually forming a deadlock. Placing
> > cgroup bpf release work on cgroup destroy queue can break loop.
> > 
> The max_active of system_wq is WQ_DFL_ACTIVE(256). If all active works are
> cgroup bpf release works, it will block smp_call_on_cpu work which enque
> after cgroup bpf releases. So smp_call_on_cpu holding cpu_hotplug_lock will
> wait for completion, but it can never get a completion because cgroup bpf
> release works can not get cgroup_mutex and will never finish.
> However, Placing the cgroup bpf release works on cgroup destroy will never
> block smp_call_on_cpu work, which means loop is broken. Thus, it can solve
> the problem.

Tejun,

do you have an opinion on this?

If there are certain limitations from the cgroup side on what can be done
in a generic work context, it would be nice to document (e.g. don't grab
cgroup mutex), but I still struggle to understand what exactly is wrong
with the blamed commit.

Thanks,
Roman

