Return-Path: <cgroups+bounces-2383-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1289D79E
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 13:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5355B1F212BF
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 11:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2485954;
	Tue,  9 Apr 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNpCvWSq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C955E55;
	Tue,  9 Apr 2024 11:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660925; cv=none; b=kSy6wnyTscxHZbK1rAX5mkAoXmimISvZnNwbZxhSLL1qNT72JIIPGVnMlo2cXflQc7OPy/eymJ3VzWjNhFRe7nUhJ40O03rThaBwNzJ4OiGXcpx91K+e3XrsCx/Tt9Lg7s9YrEFbe+82bDnd2ZPq4AR10Exbf3lQkRPnVg8E/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660925; c=relaxed/simple;
	bh=/sm4kX1swFuH3/fk4VBbgStTVFZvjDNK4GzFuMcXv3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n93cGPWMDskf1bqu4VCsNYQ7fHhhwh9wUCDGKNx1iHI0M0RLKNJ22TGYLFy8I0e2tms2NRW/UrrEuqmrGxujr5VMKy5bq8MBisIRS+UOxYcx3qODp5yvOG8OtEspy86CMziZIe5s639DjZrgNXtjo4YtzF2xm+Tiaj8nESQxoBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNpCvWSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC50C43390;
	Tue,  9 Apr 2024 11:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712660925;
	bh=/sm4kX1swFuH3/fk4VBbgStTVFZvjDNK4GzFuMcXv3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNpCvWSqkWul/egx7NVJwm4jafVgkx3tZNQaStdbFp+7boVk89vj/6Qsk5rsyGLJs
	 BUVVvm1cKemPxUKTkNHkVLsI7xmV66rIZR+F+UYafCHFnxvt8xA756tPkDwkHzyOxh
	 vUJeeTRE1QGtp/ok386aXtJ3HVxnHzXtluRnXCCtZVr8X9BT6AQp929myMb8l1nHTJ
	 xgPS0T/0L/Bz+70Q9rPs5wRWSqu0AnuFQLR8BCXvKqBaPGcYMlJ9mZ8n3Y4coFsh82
	 F/PxsOvpECTCMDz3CC/FebcsKxPX+L7+TNxXXvcWIbgGt6pV0KSEscrQz/qPZaa2US
	 mI0yKEZxUhlzg==
Message-ID: <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
Date: Tue, 9 Apr 2024 13:08:40 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advice on cgroup rstat lock
To: Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Jesper Dangaard Brouer
 <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <longman@redhat.com>, Shakeel Butt <shakeelb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org,
 Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Ivan Babrou <ivan@cloudflare.com>
References: <7cd05fac-9d93-45ca-aa15-afd1a34329c6@kernel.org>
 <20240319154437.GA144716@cmpxchg.org>
 <56556042-5269-4c7e-99ed-1a1ab21ac27f@kernel.org>
 <CAJD7tkYbO7MdKUBsaOiSp6-qnDesdmVsTCiZApN_ncS3YkDqGQ@mail.gmail.com>
 <bf94f850-fab4-4171-8dfe-b19ada22f3be@kernel.org>
 <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Let move this discussion upstream.

On 22/03/2024 19.32, Yosry Ahmed wrote:
> [..]
>>> There was a couple of series that made all calls to
>>> cgroup_rstat_flush() sleepable, which allows the lock to be dropped
>>> (and IRQs enabled) in between CPU iterations. This fixed a similar
>>> problem that we used to face (except in our case, we saw hard lockups
>>> in extreme scenarios):
>>> https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@google.com/
>>> https://lore.kernel.org/lkml/20230421174020.2994750-1-yosryahmed@google.com/
>>
>> I've only done the 6.6 backport, and these were in 6.5/6.6.

Given I have these in my 6.6 kernel. You are basically saying I should
be able to avoid IRQ-disable for the lock, right?

My main problem with the global cgroup_rstat_lock[3] is it disables IRQs
and (thereby also) BH/softirq (spin_lock_irq).  This cause production
issues elsewhere, e.g. we are seeing network softirq "not-able-to-run"
latency issues (debug via softirq_net_latency.bt [5]).

   [3] 
https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L10
   [5] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/softirq_net_latency.bt 


>> And between 6.1 to 6.6 we did observe an improvement in this area.
>> (Maybe I don't have to do the 6.1 backport if the 6.6 release plan progress)
>>
>> I've had a chance to get running in prod for 6.6 backport.
>> As you can see in attached grafana heatmap pictures, we do observe an
>> improved/reduced softirq wait time.
>> These softirq "not-able-to-run" outliers is *one* of the prod issues we
>> observed.  As you can see, I still have other areas to improve/fix.
> 
> I am not very familiar with such heatmaps, but I am glad there is an
> improvement with 6.6 and the backports. Let me know if there is
> anything I could do to help with your effort.

The heatmaps give me an overview, but I needed a debugging tool, so I
developed some bpftrace scripts [1][2] I'm running on production.
To measure how long time we hold the cgroup rstat lock (results below).
Adding ACME and Daniel as I hope there is an easier way to measure lock
hold time and congestion. Notice tricky release/yield in
cgroup_rstat_flush_locked[4].

My production results on 6.6 with backported patches (below signature)
vs a our normal 6.6 kernel, with script [2]. The `@lock_time_hist_ns`
shows how long time the lock+IRQs were disabled (taking into account it
can be released in the loop [4]).

Patched kernel:

21:49:02  time elapsed: 43200 sec
@lock_time_hist_ns:
[2K, 4K)              61 | 
      |
[4K, 8K)             734 | 
      |
[8K, 16K)         121500 |@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)        385714 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)        145600 |@@@@@@@@@@@@@@@@@@@ 
      |
[64K, 128K)       156873 |@@@@@@@@@@@@@@@@@@@@@ 
      |
[128K, 256K)      261027 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[256K, 512K)      291986 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[512K, 1M)        101859 |@@@@@@@@@@@@@ 
      |
[1M, 2M)           19866 |@@ 
      |
[2M, 4M)           10146 |@ 
      |
[4M, 8M)           30633 |@@@@ 
      |
[8M, 16M)          40365 |@@@@@ 
      |
[16M, 32M)         21650 |@@ 
      |
[32M, 64M)          5842 | 
      |
[64M, 128M)            8 | 
      |

And normal 6.6 kernel:

21:48:32  time elapsed: 43200 sec
@lock_time_hist_ns:
[1K, 2K)              25 | 
      |
[2K, 4K)            1146 | 
      |
[4K, 8K)           59397 |@@@@ 
      |
[8K, 16K)         571528 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)        542648 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)        202810 |@@@@@@@@@@@@@ 
      |
[64K, 128K)       134564 |@@@@@@@@@ 
      |
[128K, 256K)       72870 |@@@@@ 
      |
[256K, 512K)       56914 |@@@ 
      |
[512K, 1M)         83140 |@@@@@ 
      |
[1M, 2M)          170514 |@@@@@@@@@@@ 
      |
[2M, 4M)          396304 |@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[4M, 8M)          755537 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[8M, 16M)         231222 |@@@@@@@@@@@@@@@ 
      |
[16M, 32M)         76370 |@@@@@ 
      |
[32M, 64M)          1043 | 
      |
[64M, 128M)           12 | 
      |


For the unpatched kernel we see more events in 4ms to 8ms bucket than
any other bucket.
For patched kernel, we clearly see a significant reduction of events in
the 4 ms to 64 ms area, but we still have some events in this area.  I'm
very happy to see these patches improves the situation.  But for network
processing I'm not happy to see events in area 16ms to 128ms area.  If
we can just avoid disabling IRQs/softirq for the lock, I would be happy.

How far can we go... could cgroup_rstat_lock be converted to a mutex?

--Jesper

  [1] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency.bt
  [2] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency_steroids.bt
  [3] 
https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L10
  [4] 
https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L226 
cgroup_rstat_flush_locked
  [5] 
https://github.com/xdp-project/xdp-project/blob/master/areas/latency/softirq_net_latency.bt 



Backported to 6.6

List of **main** patches address issue - to backport for 6.6:
  - 508bed884767 mm: memcg: change flush_next_time to flush_last_time
    - v6.8-rc1~180^2~205
  - e0bf1dc859fd mm: memcg: move vmstats structs definition above 
flushing code
    - v6.8-rc1~180^2~204
  - 8d59d2214c23 mm: memcg: make stats flushing threshold per-memcg
    - v6.8-rc1~180^2~203
  - b00684722262 mm: workingset: move the stats flush into 
workingset_test_recent()
    - v6.8-rc1~180^2~202
  - 7d7ef0a4686a mm: memcg: restore subtree stats flushing
    - v6.8-rc1~180^2~201

And extra (thanks Longman)

  - e76d28bdf9ba ("cgroup/rstat: Reduce cpu_lock hold time in 
cgroup_rstat_flush_locked()")
   - v6.8-rc1~182^2~8

And list of patches that contain **fixes** for backports above:
  - 9cee7e8ef3e3 mm: memcg: optimize parent iteration in 
memcg_rstat_updated()
    - v6.8-rc4~3^2~12
  - 13ef7424577f mm: memcg: don't periodically flush stats when memcg is 
disabled
    - v6.8-rc5-69-g13ef7424577f



