Return-Path: <cgroups+bounces-2616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57488AAF22
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 15:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D331C21D8A
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ADC86278;
	Fri, 19 Apr 2024 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSBgerpI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B38F8565E;
	Fri, 19 Apr 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713532506; cv=none; b=ifgavqlOw2t/jGA9AwAMGxDTh/vpARFFerzsR8f68PTj/wTZHAiv2nKz/CLFqUx0RDLWtjX5E0ySO+AQ+YmLMVEx024dWzC6nFMTS+9ce5ZDbz2b84rxiDdb5uy5k/JTi6O1Gr3mi+TC/rZn+9Ds9BJyfc1DGctGM/TUL+pmWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713532506; c=relaxed/simple;
	bh=t9WcwAaV4kPJmySpAAWoMhXInAezpGmxVKsxQMuJjYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPC/ew/WsGDNMO3KRdPW3RdNuQAnC1rCntKeFLxn8h3EpmaqPrnE4LFM6KHdWyQy73X6VaWHP7MHjlGkNDtvs8ZTIBGYW72UYBwCPylSwFNaFEfUXpkOXWlg+zKimHqeXstCdbHk8U6pZTUQp9tz/UVE5m/77nvBkznpWXIXTFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSBgerpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469ACC072AA;
	Fri, 19 Apr 2024 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713532505;
	bh=t9WcwAaV4kPJmySpAAWoMhXInAezpGmxVKsxQMuJjYo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QSBgerpIj8TeFS3NY4mN5Ig1k5xpEmiGHvhpHEUyW4FLs5rjK5xn6cubu5TXhAI9M
	 e5a0mNnqSPlzP+wYNxUzLae0E9sWPC9/JC92I56naUDCSjrvOpAsMx3OorqHip+jmW
	 COfTa5yCrPTxGWduszOM8WDrdOLefxBinc3VapKh8TlLbGgRdn6beiVH+R/RDpPyD5
	 dn4Wu+TGuHkwh0PVBOA39aIHrrAbzGbDA6Tdd+Ny0Tz2vXphlpPuzGutJGlEkgBTve
	 V+rQMbULFii+BBakZdR5ZOELSUqD9fLtkbjTInPKPS1aqOGSHeUbqd/xxCDfZQTlgX
	 p2IdxONIexR2A==
Message-ID: <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org>
Date: Fri, 19 Apr 2024 15:15:01 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to
 mutex
To: Yosry Ahmed <yosryahmed@google.com>, Shakeel Butt <shakeel.butt@linux.dev>
Cc: tj@kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com,
 cgroups@vger.kernel.org, longman@redhat.com, netdev@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul>
 <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org>
 <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
 <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/04/2024 22.39, Yosry Ahmed wrote:
> On Thu, Apr 18, 2024 at 7:49 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>> On Thu, Apr 18, 2024 at 11:02:06AM +0200, Jesper Dangaard Brouer wrote:
>>>
>>>
>>> On 18/04/2024 04.19, Yosry Ahmed wrote:
>> [...]
>>>>
>>>> I will keep the high-level conversation about using the mutex here in
>>>> the cover letter thread, but I am wondering why we are keeping the
>>>> lock dropping logic here with the mutex?
>>>>
>>>
>>> I agree that yielding the mutex in the loop makes less sense.
>>> Especially since the raw_spin_unlock_irqrestore(cpu_lock, flags) call
>>> will be a preemption point for my softirq.   But I kept it because, we
>>> are running a CONFIG_PREEMPT_VOLUNTARY kernel, so I still worried that
>>> there was no sched point for other userspace processes while holding the
>>> mutex, but I don't fully know the sched implication when holding a mutex.
>>>
>>
>> Are the softirqs you are interested in, raised from the same cpu or
>> remote cpu? What about local_softirq_pending() check in addition to
>> need_resched() and spin_needbreak() checks? If softirq can only be
>> raised on local cpu then convert the spin_lock to non-irq one (Please
>> correct me if I am wrong but on return from hard irq and not within bh
>> or irq disabled spin_lock, the kernel will run the pending softirqs,
>> right?). Did you get the chance to test these two changes or something
>> similar in your prod environment?
> 
> I tried making the spinlock a non-irq lock before, but Tejun objected [1].
> [1] https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/
> 

After reading [1], I think using a mutex is a better approach (than 
non-irq spinlock).


> Perhaps we could experiment with always dropping the lock at CPU
> boundaries instead?
> 

I don't think this will be enough (always dropping the lock at CPU
boundaries).  My measured "lock-hold" times that is blocking IRQ (and
softirq) for too long.  When looking at prod with my new cgroup
tracepoint script[2]. When contention occurs, I see many Yields
happening and with same magnitude as Contended. But still see events
with long "lock-hold" times, even-though yields are high.

  [2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt

Example output:

  12:46:56 High Lock-contention: wait: 739 usec (0 ms) on CPU:56 
comm:kswapd7
  12:46:56 Long lock-hold time: 6381 usec (6 ms) on CPU:27 comm:kswapd3
  12:46:56 Long lock-hold time: 18905 usec (18 ms) on CPU:100 
comm:kworker/u261:12

  12:46:56  time elapsed: 36 sec (interval = 1 sec)
   Flushes(2051) 15/interval (avg 56/sec)
   Locks(44464) 1340/interval (avg 1235/sec)
   Yields(42413) 1325/interval (avg 1178/sec)
   Contended(42112) 1322/interval (avg 1169/sec)

There is reported 15 flushes/sec, but locks are yielded quickly.

More problematically (for softirq latency) we see a Long lock-hold time
reaching 18 ms.  For network RX softirq I need lower than 0.5ms latency,
to avoid RX-ring HW queue overflows.


--Jesper
p.s. I'm seeing a pattern with kswapdN contending on this lock.

@stack[697, kswapd3]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27

@stack[698, kswapd4]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27

@stack[699, kswapd5]:
         __cgroup_rstat_lock+107
         __cgroup_rstat_lock+107
         cgroup_rstat_flush_locked+851
         cgroup_rstat_flush+35
         shrink_node+226
         balance_pgdat+807
         kswapd+521
         kthread+228
         ret_from_fork+48
         ret_from_fork_asm+27


