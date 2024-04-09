Return-Path: <cgroups+bounces-2387-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8540189DF6C
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 17:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAE21C2251F
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 15:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6DA13DB9F;
	Tue,  9 Apr 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JUdyfeNU"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C2013B5BA
	for <cgroups@vger.kernel.org>; Tue,  9 Apr 2024 15:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677062; cv=none; b=b8Sw2BCgnKiYp8hCTyBuSzuQLpcp3g25gcMyrVEUUxM06h+Mix7RYYV2ZM5de3paRudhAF46a9K86/GLD65ZTe/malHowwIXKTtLPvvEg6eDkzUqiaDMy4hJ629WnEnNL8TZ1CO2oANu12jAisI28FbapyuHZL/Mqat5G4xxn6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677062; c=relaxed/simple;
	bh=FiYua9qt5cyPKbD5gkueRzUtbADCS1A0G5W11GlLtqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HOghCf1ifFRM8wFwXowgc2RJ3LLNZygTjiMRNO9dNYbuFkgVdFyqtcwOkeo5q9geW6la30B5k67O/9NjxHhhH5wQg7GcRjcawdUjMwfBRSeUChLHFxu9sq3delGN+umI4qV97/dzwtuCQp0uN0Nq+3lKwz4nMG7/zldHuW7vOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JUdyfeNU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712677059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3Hwu2ip+GHzxQ0LRYtJWTGCmx4DOpmKRqbnqLq7zeM=;
	b=JUdyfeNUjQytsOYXcbeOYFBM8KI6qFW51i8wBVMSFer1qF+GaYYTXNSCJOTuJp1fje6L/R
	JtcrdG2nm75PC+lfQ1tqijEgnl9Fo9rCn0uW/npnhOqobs7qF6OZGpeanLwlwC+KEea/Il
	qunw82mRP+oXUh7fEwRU+DoUn2gqNLc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-J_fxg3y_Mgi_b_A_o-ulDA-1; Tue, 09 Apr 2024 11:37:35 -0400
X-MC-Unique: J_fxg3y_Mgi_b_A_o-ulDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C11061807ACD;
	Tue,  9 Apr 2024 15:37:34 +0000 (UTC)
Received: from [10.22.10.13] (unknown [10.22.10.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8AE001C06666;
	Tue,  9 Apr 2024 15:37:33 +0000 (UTC)
Message-ID: <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
Date: Tue, 9 Apr 2024 11:37:31 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Advice on cgroup rstat lock
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>,
 Yosry Ahmed <yosryahmed@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Jesper Dangaard Brouer
 <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shakeel Butt <shakeelb@google.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
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
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

On 4/9/24 07:08, Jesper Dangaard Brouer wrote:
> Let move this discussion upstream.
>
> On 22/03/2024 19.32, Yosry Ahmed wrote:
>> [..]
>>>> There was a couple of series that made all calls to
>>>> cgroup_rstat_flush() sleepable, which allows the lock to be dropped
>>>> (and IRQs enabled) in between CPU iterations. This fixed a similar
>>>> problem that we used to face (except in our case, we saw hard lockups
>>>> in extreme scenarios):
>>>> https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed@google.com/ 
>>>>
>>>> https://lore.kernel.org/lkml/20230421174020.2994750-1-yosryahmed@google.com/ 
>>>>
>>>
>>> I've only done the 6.6 backport, and these were in 6.5/6.6.
>
> Given I have these in my 6.6 kernel. You are basically saying I should
> be able to avoid IRQ-disable for the lock, right?
>
> My main problem with the global cgroup_rstat_lock[3] is it disables IRQs
> and (thereby also) BH/softirq (spin_lock_irq).  This cause production
> issues elsewhere, e.g. we are seeing network softirq "not-able-to-run"
> latency issues (debug via softirq_net_latency.bt [5]).
>
>   [3] 
> https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#L10
>   [5] 
> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/softirq_net_latency.bt 
>
>
>>> And between 6.1 to 6.6 we did observe an improvement in this area.
>>> (Maybe I don't have to do the 6.1 backport if the 6.6 release plan 
>>> progress)
>>>
>>> I've had a chance to get running in prod for 6.6 backport.
>>> As you can see in attached grafana heatmap pictures, we do observe an
>>> improved/reduced softirq wait time.
>>> These softirq "not-able-to-run" outliers is *one* of the prod issues we
>>> observed.  As you can see, I still have other areas to improve/fix.
>>
>> I am not very familiar with such heatmaps, but I am glad there is an
>> improvement with 6.6 and the backports. Let me know if there is
>> anything I could do to help with your effort.
>
> The heatmaps give me an overview, but I needed a debugging tool, so I
> developed some bpftrace scripts [1][2] I'm running on production.
> To measure how long time we hold the cgroup rstat lock (results below).
> Adding ACME and Daniel as I hope there is an easier way to measure lock
> hold time and congestion. Notice tricky release/yield in
> cgroup_rstat_flush_locked[4].
>
> My production results on 6.6 with backported patches (below signature)
> vs a our normal 6.6 kernel, with script [2]. The `@lock_time_hist_ns`
> shows how long time the lock+IRQs were disabled (taking into account it
> can be released in the loop [4]).
>
> Patched kernel:
>
> 21:49:02  time elapsed: 43200 sec
> @lock_time_hist_ns:
> [2K, 4K)              61 |      |
> [4K, 8K)             734 |      |
> [8K, 16K)         121500 |@@@@@@@@@@@@@@@@      |
> [16K, 32K)        385714 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32K, 64K)        145600 |@@@@@@@@@@@@@@@@@@@      |
> [64K, 128K)       156873 |@@@@@@@@@@@@@@@@@@@@@      |
> [128K, 256K)      261027 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
> [256K, 512K)      291986 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [512K, 1M)        101859 |@@@@@@@@@@@@@      |
> [1M, 2M)           19866 |@@      |
> [2M, 4M)           10146 |@      |
> [4M, 8M)           30633 |@@@@      |
> [8M, 16M)          40365 |@@@@@      |
> [16M, 32M)         21650 |@@      |
> [32M, 64M)          5842 |      |
> [64M, 128M)            8 |      |
>
> And normal 6.6 kernel:
>
> 21:48:32  time elapsed: 43200 sec
> @lock_time_hist_ns:
> [1K, 2K)              25 |      |
> [2K, 4K)            1146 |      |
> [4K, 8K)           59397 |@@@@      |
> [8K, 16K)         571528 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [16K, 32K)        542648 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [32K, 64K)        202810 |@@@@@@@@@@@@@      |
> [64K, 128K)       134564 |@@@@@@@@@      |
> [128K, 256K)       72870 |@@@@@      |
> [256K, 512K)       56914 |@@@      |
> [512K, 1M)         83140 |@@@@@      |
> [1M, 2M)          170514 |@@@@@@@@@@@      |
> [2M, 4M)          396304 |@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> [4M, 8M)          755537 
> |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [8M, 16M)         231222 |@@@@@@@@@@@@@@@      |
> [16M, 32M)         76370 |@@@@@      |
> [32M, 64M)          1043 |      |
> [64M, 128M)           12 |      |
>
>
> For the unpatched kernel we see more events in 4ms to 8ms bucket than
> any other bucket.
> For patched kernel, we clearly see a significant reduction of events in
> the 4 ms to 64 ms area, but we still have some events in this area.  I'm
> very happy to see these patches improves the situation.  But for network
> processing I'm not happy to see events in area 16ms to 128ms area.  If
> we can just avoid disabling IRQs/softirq for the lock, I would be happy.
>
> How far can we go... could cgroup_rstat_lock be converted to a mutex?

The cgroup_rstat_lock was originally a mutex. It was converted to a 
spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex with 
a spinlock"). Irq was disabled to enable calling from atomic context. 
Since commit 0a2dc6ac3329 ("cgroup: remove 
cgroup_rstat_flush_atomic()"), the rstat API hadn't been called from 
atomic context anymore. Theoretically, we could change it back to a 
mutex or not disabling interrupt. That will require that the API cannot 
be called from atomic context going forward.

Cheers,
Longman



