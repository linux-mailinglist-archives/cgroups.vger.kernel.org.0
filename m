Return-Path: <cgroups+bounces-6463-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFDDA2C7EB
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 16:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1015F7A51DA
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 15:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D2A23C8B7;
	Fri,  7 Feb 2025 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esiKfYof"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60723C8A6
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738943579; cv=none; b=GjTEosAT82QbFRXJWeqEt+mNWt1xm9ks3aKUCadAWdRCheQK5THKrXdmV8qyOA2NvnTrvZgnc3Fb2+GzZxiug0M+lUCnFcyb6zktt/rUQQaRaOZ58+GDrVRkPvgOFsHKeBuUN4uSOi2C6uSgXbu+hj5smPYsJsdVBqBiWWy4mzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738943579; c=relaxed/simple;
	bh=K4DxIAtwnEnivzLn2OMfUt1FulueZzMtzoNGOMdSbx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=riuhgAI2NbR6vRnDKR85ByjR1P/x2aSNHaxOv7te9eVtZ7pp6KrWeku0spzVuBngWV7WcDOppR+PVkSEUqFsEi4U14EsN5CpPnEyI9OPd7yCdqTgVvC+Mukr7NbpWu0QnDQy7DftKahELLDAkFX/zvSNCXGzUMVAYzekK6cLj2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esiKfYof; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738943576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68aZ2ZCOHACxRbV8E/XaOmkfINxuB9dhJeW+UxxpQAk=;
	b=esiKfYofCPgi1RlfkU8OpbK3t40lfCMEqI3UqUOj9/Vfz9+1SIK4LYUBgKOrXGXfw96EyH
	vI+qejtaPgYHcYLiReQyFMDsUN6CfqC3ZeJApF1p1hOwjbvpeyXEF5CtJI/MRs0PAjFXru
	och3UgDEGU9JxVER/ha632aOC+2dGf4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-74oUQybFOgyIJH9YfaoxqQ-1; Fri, 07 Feb 2025 10:52:54 -0500
X-MC-Unique: 74oUQybFOgyIJH9YfaoxqQ-1
X-Mimecast-MFC-AGG-ID: 74oUQybFOgyIJH9YfaoxqQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-38da6aa2363so990396f8f.0
        for <cgroups@vger.kernel.org>; Fri, 07 Feb 2025 07:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738943573; x=1739548373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68aZ2ZCOHACxRbV8E/XaOmkfINxuB9dhJeW+UxxpQAk=;
        b=bFgswp7TPTEJKXKaVwedmhWdu7f/hbpcH4wdezQkMA5kRv4D6pYJD3KLa+/nHKPOEU
         CagHMt2O06CvX8xc2yG2WrChv6E3s79acbFBNCLxSwedfb4OQgCJSSBOz6utmzW5anv5
         BqAqj5oZ+ZEaq2Ji9qqi90m9wjiU8GuqVf+2atQiMpLU6+RVaSWOQQit0gcTFkyiN3aU
         vADXfbwDZkaraJeoUdXzdCFE60ZSsQ/mQLX5WDyAPCSDZjDecAl9swgqakUSfGXVIf+b
         UEql/4q349157m77GjHodP+onb5NL1SWqtnxlIdXyXQJH9ZukpZhR1rhPXPOVulT7QEi
         G6Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXyZUHW6t2umYRAQtzqVAKZOEbaCV74TO74K0hT6HZ556id9OKMWp44kv63PMfruUSPXaHpJz0u@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDp9JxFQV1VO2f1YDqnH9SIghsJn+W7yDGbV2bELlJNnR12GO
	LyliLgJQ1aWpuSMM6/ntjfPWlZ3uG3nJdnJYETxXcR/qu+tD+ReGHpRV5ZjQa8nMI2YZn1AHfU+
	X300K0bXyXsaV8j0AUmke/6czd8GpFm0fpup7osyNj1R/3xYmnEeTj+c=
X-Gm-Gg: ASbGncth0ATI1S8aKrOPg9yQHDdErvAK/Bf9ooxvbO9VnffnKOZlj2oKWkjiVc5z9zP
	T9oDPUXNUWztqTUpE2rbswTgNrgfXTBo5ZipKMGg4ADFkANiP/v+X7QVVIYHbAiN0oubHGu/zvi
	QEPADVaMwXKVmB19lmclaSbG6wV2JwCoCA18dIM5oeOcHx1U/Nsg9B5AoCE7YtvpnAkv+wvbNXT
	U1GSW8+m6AftW0T/qBej4kOaHKGhsLX8s7fgO21lwKrNnI/G0MPHjggO4NH4EKFNT/tQO37M+FY
	8YCQc/Ox1+Ks2f+kGjNTL3OW6gpM+k4qTu4S
X-Received: by 2002:a05:6000:1a8d:b0:38d:b5e8:310a with SMTP id ffacd0b85a97d-38dc8fe5357mr2544485f8f.28.1738943573588;
        Fri, 07 Feb 2025 07:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7Pro7EHnBcSZcfZRfg08eDs9syyxV/vfxOLXEk+x9OmgIsbKFe8JP6Y++JMVn/LSI3tQeRQ==
X-Received: by 2002:a05:6000:1a8d:b0:38d:b5e8:310a with SMTP id ffacd0b85a97d-38dc8fe5357mr2544453f8f.28.1738943573123;
        Fri, 07 Feb 2025 07:52:53 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.128.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbdd7ea93sm4919343f8f.56.2025.02.07.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 07:52:52 -0800 (PST)
Date: Fri, 7 Feb 2025 16:52:49 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
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
Message-ID: <Z6YsUSqGSgBOF-mW@jlelli-thinkpadt14gen4.remote.csb>
References: <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
 <Z6MLAX_TKowbmdS1@jlelli-thinkpadt14gen4.remote.csb>
 <Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb>
 <8572b3bc-46ec-4180-ba55-aa6b9ab7502b@nvidia.com>
 <Z6SA-1Eyr1zDTZDZ@jlelli-thinkpadt14gen4.remote.csb>
 <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a305f53d-44d4-4d7a-8909-6a63ec18a04b@nvidia.com>

On 07/02/25 10:38, Jon Hunter wrote:
> 
> On 06/02/2025 09:29, Juri Lelli wrote:
> > On 05/02/25 16:56, Jon Hunter wrote:
> > 
> > ...
> > 
> > > Thanks! That did make it easier :-)
> > > 
> > > Here is what I see ...
> > 
> > Thanks!
> > 
> > Still different from what I can repro over here, so, unfortunately, I
> > had to add additional debug printks. Pushed to the same branch/repo.
> > 
> > Could I ask for another run with it? Please also share the complete
> > dmesg from boot, as I would need to check debug output when CPUs are
> > first onlined.
> 
> 
> Yes no problem. Attached is the complete log.

Great, thanks!

...

> [    0.000000] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.000000] rq_attach_root: cpu=1 old_span=NULL new_span=0
> [    0.000000] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
> [    0.000000] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> [    0.000000] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> [    0.000000] rq_attach_root: cpu=5 old_span=NULL new_span=0-4

...

> [    0.000000] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.000000] rq_attach_root: cpu=1 old_span=NULL new_span=0
> [    0.000000] rq_attach_root: cpu=2 old_span=NULL new_span=0-1
> [    0.000000] rq_attach_root: cpu=3 old_span=NULL new_span=0-2
> [    0.000000] rq_attach_root: cpu=4 old_span=NULL new_span=0-3
> [    0.000000] rq_attach_root: cpu=5 old_span=NULL new_span=0-4

...

> [    0.040366] smp: Bringing up secondary CPUs ...
> [    0.048932] CPU features: detected: Kernel page table isolation (KPTI)
> [    0.048969] Detected PIPT I-cache on CPU1
> [    0.048985] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU1: 0x0000009444c004
> [    0.049006] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU1: 0x00000010305116
> [    0.049037] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU1: 0x00000003001066
> [    0.049074] CPU features: Unsupported CPU feature variation detected.
> [    0.049264] CPU1: Booted secondary processor 0x0000000000 [0x4e0f0030]
> [    0.049331] __dl_add: cpus=1 tsk_bw=52428 total_bw=104856 span=0-5 type=DEF
> [    0.052684] Detected PIPT I-cache on CPU2
> [    0.052705] CPU features: SANITY CHECK: Unexpected variation in SYS_CTR_EL0. Boot CPU: 0x0000008444c004, CPU2: 0x0000009444c004
> [    0.052726] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_AA64DFR0_EL1. Boot CPU: 0x00000010305106, CPU2: 0x00000010305116
> [    0.052754] CPU features: SANITY CHECK: Unexpected variation in SYS_ID_DFR0_EL1. Boot CPU: 0x00000003010066, CPU2: 0x00000003001066
> [    0.052922] CPU2: Booted secondary processor 0x0000000001 [0x4e0f0030]
> [    0.052982] __dl_add: cpus=2 tsk_bw=52428 total_bw=157284 span=0-5 type=DEF
> [    0.060457] Detected PIPT I-cache on CPU3
> [    0.060554] CPU3: Booted secondary processor 0x0000000101 [0x411fd073]
> [    0.060579] __dl_add: cpus=3 tsk_bw=52428 total_bw=209712 span=0-5 type=DEF
> [    0.068476] Detected PIPT I-cache on CPU4
> [    0.068539] CPU4: Booted secondary processor 0x0000000102 [0x411fd073]
> [    0.068560] __dl_add: cpus=4 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [    0.069093] Detected PIPT I-cache on CPU5
> [    0.069154] CPU5: Booted secondary processor 0x0000000103 [0x411fd073]
> [    0.069177] __dl_add: cpus=5 tsk_bw=52428 total_bw=314568 span=0-5 type=DEF
> [    0.069254] smp: Brought up 1 node, 6 CPUs
> [    0.069289] SMP: Total of 6 processors activated.
> [    0.069296] CPU: All CPU(s) started at EL2
> [    0.069308] CPU features: detected: 32-bit EL0 Support
> [    0.069315] CPU features: detected: 32-bit EL1 Support
> [    0.069323] CPU features: detected: CRC32 instructions
> [    0.069432] alternatives: applying system-wide alternatives
> [    0.077906] CPU0 attaching sched-domain(s):
> [    0.077926]  domain-0: span=0,3-5 level=MC
> [    0.077940]   groups: 0:{ span=0 cap=1020 }, 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }
> [    0.077982] __dl_sub: cpus=6 tsk_bw=52428 total_bw=262140 span=0-5 type=DEF
> [    0.077988] __dl_server_detach_root: cpu=0 rd_span=0-5 total_bw=262140
> [    0.077996] rq_attach_root: cpu=0 old_span=NULL new_span=
> [    0.078000] __dl_add: cpus=1 tsk_bw=52428 total_bw=52428 span=0 type=DYN
> [    0.078004] __dl_server_attach_root: cpu=0 rd_span=0 total_bw=52428
> [    0.078009] CPU3 attaching sched-domain(s):
> [    0.078036]  domain-0: span=0,3-5 level=MC
> [    0.078046]   groups: 3:{ span=3 }, 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1020 }
> [    0.078084] __dl_sub: cpus=5 tsk_bw=52428 total_bw=209712 span=1-5 type=DEF
> [    0.078088] __dl_server_detach_root: cpu=3 rd_span=1-5 total_bw=209712
> [    0.078093] rq_attach_root: cpu=3 old_span=NULL new_span=0
> [    0.078096] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=0,3 type=DYN
> [    0.078100] __dl_server_attach_root: cpu=3 rd_span=0,3 total_bw=104856
> [    0.078104] CPU4 attaching sched-domain(s):
> [    0.078130]  domain-0: span=0,3-5 level=MC
> [    0.078140]   groups: 4:{ span=4 }, 5:{ span=5 }, 0:{ span=0 cap=1020 }, 3:{ span=3 }
> [    0.078177] __dl_sub: cpus=4 tsk_bw=52428 total_bw=157284 span=1-2,4-5 type=DEF
> [    0.078181] __dl_server_detach_root: cpu=4 rd_span=1-2,4-5 total_bw=157284
> [    0.078186] rq_attach_root: cpu=4 old_span=NULL new_span=0,3
> [    0.078189] __dl_add: cpus=3 tsk_bw=52428 total_bw=157284 span=0,3-4 type=DYN
> [    0.078193] __dl_server_attach_root: cpu=4 rd_span=0,3-4 total_bw=157284
> [    0.078197] CPU5 attaching sched-domain(s):
> [    0.078224]  domain-0: span=0,3-5 level=MC
> [    0.078234]   groups: 5:{ span=5 }, 0:{ span=0 cap=1020 }, 3:{ span=3 }, 4:{ span=4 }
> [    0.078271] __dl_sub: cpus=3 tsk_bw=52428 total_bw=104856 span=1-2,5 type=DEF
> [    0.078276] __dl_server_detach_root: cpu=5 rd_span=1-2,5 total_bw=104856
> [    0.078280] rq_attach_root: cpu=5 old_span=NULL new_span=0,3-4
> [    0.078283] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    0.078287] __dl_server_attach_root: cpu=5 rd_span=0,3-5 total_bw=209712
> [    0.078291] root domain span: 0,3-5
> [    0.078317] default domain span: 1-2

Up until here it looks alright: 1,2 are left on DEF root domain since
they are isolated; the rest on a single dynamic domain. Also dl server
bandwidth sums up correctly.

...

> [    4.694391] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 1344000 kHz, changing to: 1382400 kHz

I didn't of course have cpufreq in my virt env! :)

> [    4.705324] dl_clear_root_domain: span=0,3-5 type=DYN
> [    4.705332] __dl_add: cpus=4 tsk_bw=52428 total_bw=52428 span=0,3-5 type=DYN
> [    4.705338] __dl_add: cpus=4 tsk_bw=52428 total_bw=104856 span=0,3-5 type=DYN
> [    4.705343] __dl_add: cpus=4 tsk_bw=52428 total_bw=157284 span=0,3-5 type=DYN
> [    4.705347] __dl_add: cpus=4 tsk_bw=52428 total_bw=209712 span=0,3-5 type=DYN
> [    4.705351] rd 0,3-5: Checking EAS, CPUs do not have asymmetric capacities
> [    4.745754] dl_clear_root_domain: span=1-2 type=DEF
> [    4.745760] __dl_add: cpus=2 tsk_bw=52428 total_bw=52428 span=1-2 type=DEF
> [    4.745765] __dl_add: cpus=2 tsk_bw=52428 total_bw=104856 span=1-2 type=DEF
> [    4.745823] __dl_add: cpus=4 tsk_bw=104857 total_bw=314569 span=0,3-5 type=DYN
> [    4.745845] __dl_sub: cpus=4 tsk_bw=104857 total_bw=209712 span=0,3-5 type=DYN

This above doesn't already make much sense to me and I still need to
understand what is going on. The rest is actually also not that easy to
follow, so...

I thought maybe we could try switching to use ftrace.

Pushed yet additional debug changes to the repo (please update).

The idea would be to boot with something like "ftrace=nop
trace_buf_size=50K" added to kernel cmdline, then, right after boot
collect the trace buffer with

# cat /sys/kernel/debug/tracing/trace > trace.out

and also collect dmesg as you did already. Going over the two side by
side should hopefully provide more information on what is actually
triggering the total_bw add/sub calls (as I enabled stack traces). I
don't think it's necessary just yet to collect tracing info across
suspend events, as accounting seems already broken after boot. :/

Again, really appreciating the help with debugging this!

And Dietmar, thanks for starting to look into this as well! Of course
feel free to suggest different approaches to debugging this. :)

Best,
Juri


