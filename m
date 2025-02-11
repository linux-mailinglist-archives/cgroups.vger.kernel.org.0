Return-Path: <cgroups+bounces-6500-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A1A306CA
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 10:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8646B1889EB1
	for <lists+cgroups@lfdr.de>; Tue, 11 Feb 2025 09:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF801F130B;
	Tue, 11 Feb 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEw7g5mL"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8051F12F6
	for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 09:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739265671; cv=none; b=cDp6rxB+Cliog13yZMSx1fc6IEzqL+Yx6c3wMgjcaodcJTozxs0Xj3FMql3PcDGpNWN/nC08muZPNulWPm1nDNzR8shLaz7aGcFBFYcVjIDl4glt6O74AUM969CqjaZw70o+zOl13TIrQhhi6dNqhcs95PTNHh7QrjkUq8jTyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739265671; c=relaxed/simple;
	bh=l5I8PIu9ZxCeUj57zejedPyy2ubQT8l511+5TzKKrcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9KxgpC4Ljq+8uv2dq1ngDAluXDsD3zL0Fe8L6QmtnWAaj5MANOubSJvApdtByZUYI4CjWFL1OadejPbWUn7+nm4Yp+k3VA4MOo/VyAG1cpfwN1WwwPfgyX+3U/V6rOQ6EUzoJXWNcZY35gwmXzvSc0eR4BeI+PpgwOkgcLWALw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AEw7g5mL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739265669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OeUptTWICZS/ftsOpT45FSL/g7uRxhP6PEc8B00d2Eg=;
	b=AEw7g5mLY/bekbl1ymlnOfn/k4euH3XtEg47wgUh7C8zHaRz0nppVH1N3jiEC8bIV/kDEY
	U8kw5abJ5N8K9oaruz16kwcfWySGy4lLmdkz5MFzcgIgMXzCrut9qarLeg7Qn1uekOEcvH
	knQLfcl7bic/Xt/G7MCHmmkzqPdTm8o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-V2RLLAQSOd-vqSrL6j7DaA-1; Tue, 11 Feb 2025 04:21:07 -0500
X-MC-Unique: V2RLLAQSOd-vqSrL6j7DaA-1
X-Mimecast-MFC-AGG-ID: V2RLLAQSOd-vqSrL6j7DaA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43943bd1409so13483625e9.3
        for <cgroups@vger.kernel.org>; Tue, 11 Feb 2025 01:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739265666; x=1739870466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OeUptTWICZS/ftsOpT45FSL/g7uRxhP6PEc8B00d2Eg=;
        b=vVLabug8bVQCdwZltXOx/CHQ/W5TcRsc3IEwMxNQr0M4xCRkO32v9NFPC1Of0e63XC
         A/oezLEGH04OpBLTZ1LInT/KFhSt0+OkA7BXW7QlIKJtS854wbZM2Z3bo97z909GtLwi
         eQWzLHLC7DX620F/HL/NhPz/bciqag4r5CreiLU+icw3m5f5mf1i13I0AmADOcpv1uIW
         /5QKjiPCuVfBdGpFZbbCcKvrAl0+HZQ4cb619BVmW/1H3drDfulFUKvZ3qefnyZ+SuMX
         RoQR5lN76mVySs4ZqY6OGI7zJ6Rcc+Cyfb8Foyct8FcbhrQjLF5N8RXtwazuc/qEtMq8
         4yHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5a4vv7OEdzm0aPPBSBIwRkYJGTezBQ+f01C76tC2AwqQUw9TM4CcpDoSs+BSEUDOrGMZYnj0W@vger.kernel.org
X-Gm-Message-State: AOJu0YxcvKEtlEAkwwkbypxmlWIlDOJo4xLijlG33i3S4X0fgJsRJHxr
	/kpp8q3f/g/xECYI+pItT5rVVv1r0QeCUGbX28LKfSE9ufiii05oWKa7ASblFuljtPkX6sTdEQZ
	k1RO6cd3DTyNTN56QCiomtigUY1DQJfe1jzAR9MXLyWrJpavXZaa0t7k=
X-Gm-Gg: ASbGncsxeWdBdD28Yt5wdJd5tc2JlnK/eaLV6z4g8Txmp+TIILFuKvmD/GC7gTsagQw
	y5HrkrLAuhrythUcZo+dcth8UTsn+UW/owKPe8EIfeolGr4ZlpAS6HcPOm/IWtSzQaIPIUgPPyA
	2H2FXG7XrVDJ26CFlVLKyRC6yZS34gMlbSf8FPk8d1s+su7q5vUezIAwMoiHYxYiX/QD9ypBftV
	JxIUs+EsfQy3jkhTtLqtvERTns8LjuvYeDTbNOWTTG4BFhgSbH6k3v2Edmqbmmv9ES+e3554NEI
	Ktxl2AjZ0LYOs2zbGMUMq1My+0E7lM8Kfw==
X-Received: by 2002:a05:600c:3d89:b0:439:4bcb:9627 with SMTP id 5b1f17b1804b1-4394bcb9824mr33093755e9.19.1739265666277;
        Tue, 11 Feb 2025 01:21:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHhcii8/gMzgbjCtzPFGXWOhny+IXACWubvNjGvJdPgAWxxjeo8ItFFCONtsM15zsiDsGIpA==
X-Received: by 2002:a05:600c:3d89:b0:439:4bcb:9627 with SMTP id 5b1f17b1804b1-4394bcb9824mr33093355e9.19.1739265665809;
        Tue, 11 Feb 2025 01:21:05 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43935c4f4aasm98533225e9.22.2025.02.11.01.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 01:21:05 -0800 (PST)
Date: Tue, 11 Feb 2025 10:21:02 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Phil Auld <pauld@redhat.com>, Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Aashish Sharma <shraash@google.com>,
	Shin Kawamura <kawasin@google.com>,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2 3/2] sched/deadline: Check bandwidth overflow earlier
 for hotplug
Message-ID: <Z6sWfsAqBlGhnkN_@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
 <5a36a2e8-bd78-4875-9b9e-814468ca6692@arm.com>
 <db800694-84f7-443c-979f-3097caaa1982@nvidia.com>
 <8ff19556-a656-4f11-a10c-6f9b92ec9cea@arm.com>
 <Z6oysfyRKM_eUHlj@jlelli-thinkpadt14gen4.remote.csb>
 <80ccec94-df27-4a99-8037-17165f6c5d8f@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ccec94-df27-4a99-8037-17165f6c5d8f@arm.com>

On 11/02/25 09:36, Dietmar Eggemann wrote:
> On 10/02/2025 18:09, Juri Lelli wrote:
> > Hi Christian,
> > 
> > Thanks for taking a look as well.
> > 
> > On 07/02/25 15:55, Christian Loehle wrote:
> >> On 2/7/25 14:04, Jon Hunter wrote:
> >>>
> >>>
> >>> On 07/02/2025 13:38, Dietmar Eggemann wrote:
> >>>> On 07/02/2025 11:38, Jon Hunter wrote:
> >>>>>
> >>>>> On 06/02/2025 09:29, Juri Lelli wrote:
> >>>>>> On 05/02/25 16:56, Jon Hunter wrote:
> >>>>>>
> >>>>>> ...
> >>>>>>
> >>>>>>> Thanks! That did make it easier :-)
> >>>>>>>
> >>>>>>> Here is what I see ...
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>> Still different from what I can repro over here, so, unfortunately, I
> >>>>>> had to add additional debug printks. Pushed to the same branch/repo.
> >>>>>>
> >>>>>> Could I ask for another run with it? Please also share the complete
> >>>>>> dmesg from boot, as I would need to check debug output when CPUs are
> >>>>>> first onlined.
> >>>>
> >>>> So you have a system with 2 big and 4 LITTLE CPUs (Denver0 Denver1 A57_0
> >>>> A57_1 A57_2 A57_3) in one MC sched domain and (Denver1 and A57_0) are
> >>>> isol CPUs?
> >>>
> >>> I believe that 1-2 are the denvers (even thought they are listed as 0-1 in device-tree).
> >>
> >> Interesting, I have yet to reproduce this with equal capacities in isolcpus.
> >> Maybe I didn't try hard enough yet.
> >>
> >>>
> >>>> This should be easy to set up for me on my Juno-r0 [A53 A57 A57 A53 A53 A53]
> >>>
> >>> Yes I think it is similar to this.
> >>>
> >>> Thanks!
> >>> Jon
> >>>
> >>
> >> I could reproduce that on a different LLLLbb with isolcpus=3,4 (Lb) and
> >> the offlining order:
> >> echo 0 > /sys/devices/system/cpu/cpu5/online
> >> echo 0 > /sys/devices/system/cpu/cpu1/online
> >> echo 0 > /sys/devices/system/cpu/cpu3/online
> >> echo 0 > /sys/devices/system/cpu/cpu2/online
> >> echo 0 > /sys/devices/system/cpu/cpu4/online
> >>
> >> while the following offlining order succeeds:
> >> echo 0 > /sys/devices/system/cpu/cpu5/online
> >> echo 0 > /sys/devices/system/cpu/cpu4/online
> >> echo 0 > /sys/devices/system/cpu/cpu1/online
> >> echo 0 > /sys/devices/system/cpu/cpu2/online
> >> echo 0 > /sys/devices/system/cpu/cpu3/online
> >> (Both offline an isolcpus last, both have CPU0 online)
> >>
> 
> Could reproduce on Juno-r0:
> 
> 0 1 2 3 4 5
> 
> L b b L L L
> 
>       ^^^
>       isol = [3-4] so both L
> 
> echo 0 > /sys/devices/system/cpu/cpu1/online
> echo 0 > /sys/devices/system/cpu/cpu4/online
> echo 0 > /sys/devices/system/cpu/cpu5/online
> echo 0 > /sys/devices/system/cpu/cpu2/online - isol
> echo 0 > /sys/devices/system/cpu/cpu3/online - isol
> 
> >> The issue only triggers with sugov DL threads (I guess that's obvious, but
> >> just to mention it).
> 
> IMHO, it doesn't have to be a sugov DL task. Any DL task will do.

OK, but in this case we actually want to fail. If we have allocated
bandwidth for an actual DL task (not a dl server or a 'fake' sugov), we
don't want to inadvertently leave it w/o bandwidth by turning CPUs off.

> // on a 2. shell:
> # chrt -d -T 5000000 -D 10000000 -P 16666666 -p 0 $$
> 
> # ps -eTo comm,pid,class | grep DLN
> bash             1243 DLN
> 
> 5000000/16666666 = 0.3, 0.3 << 10 = 307 (task util, bandwidth requirement)
> 
> > It wasn't obvious to me at first :). So thanks for confirming.
> > 
> >> I'll investigate some more later but wanted to share for now.
> > 
> > So, problem actually is that I am not yet sure what we should do with
> > sugovs' bandwidth wrt root domain accounting. W/o isolation it's all
> > good, as it gets accounted for correctly on the dynamic domains sugov
> > tasks can run on. But with isolation and sugov affected_cpus that cross
> > isolation domains (e.g., one BIG one little), we can get into troubles
> > not knowing if sugov contribution should fall on the DEF or DYN domain.
> 
> # echo 0 > /sys/devices/system/cpu/cpu1/online
> [   87.402722] __dl_bw_capacity() mask=0-2,5 cap=2940
> [   87.407551] dl_bw_cpus() cpu=1 rd->span=0-2,5 cpu_active_mask=0-5 cpumask_weight(rd->span)=4
> [   87.416019] dl_bw_manage: cpu=1 cap=1916 fair_server_bw=52428 total_bw=524284 dl_bw_cpus=4 type=DYN span=0-2,5
> 
> # echo 0 > /sys/devices/system/cpu/cpu2/online
> [   95.562270] __dl_bw_capacity() mask=0,2,5 cap=1916
> [   95.567091] dl_bw_cpus() cpu=2 rd->span=0,2,5 cpu_active_mask=0,2-5 cpumask_weight(rd->span)=3
> [   95.575735] dl_bw_manage: cpu=2 cap=892 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3 type=DYN span=0,2,5
> 
> # echo 0 > /sys/devices/system/cpu/cpu5/online
> [  100.573131] __dl_bw_capacity() mask=0,5 cap=892
> [  100.577713] dl_bw_cpus() cpu=5 rd->span=0,5 cpu_active_mask=0,3-5 cpumask_weight(rd->span)=2
> [  100.586186] dl_bw_manage: cpu=5 cap=446 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2 type=DYN span=0,5
> 
> # echo 0 > /sys/devices/system/cpu/cpu3/online
> [  110.232755] __dl_bw_capacity() mask=1-5 cap=892
> [  110.237333] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,3-4 cpus=2
> [  110.244064] dl_bw_manage: cpu=3 cap=446 fair_server_bw=52428 total_bw=419428 dl_bw_cpus=2 type=DEF span=1-5
> 
> 
> # echo 0 > /sys/devices/system/cpu/cpu4/online
> [  175.870273] __dl_bw_capacity() mask=1-5 cap=446
> [  175.874850] dl_bw_cpus() cpu=6 rd->span=1-5 cpu_active_mask=0,4 cpus=1
> [  175.881407] dl_bw_manage: cpu=4 cap=0 fair_server_bw=52428 total_bw=367000 dl_bw_cpus=1 type=DEF span=1-5
>                                    ^^^^^                                                            ^^^^^^^^
>                                    w/o/ cpu4 cap is 0!                                              cpu0 is not part of it                                                                                                     
> ...
> [  175.897600] dl_bw_manage() cpu=4 cap=0 overflow=1 return=-16
>                                           ^^^^^^^^^^ -EBUSY
>                                           
> -bash: echo: write error: Device or resource busy
> 
> sched_cpu_deactivate()
> 
>   dl_bw_deactivate(cpu)
> 
>     dl_bw_manage(dl_bw_req_deactivate, cpu, 0);
> 
>       return overflow ? -EBUSY : 0;
> 
> Looks like in DEF there is no CPU capacity left but we still have 1 DLN
> task with a bandwidth requirement of 307.
> 


