Return-Path: <cgroups+bounces-6424-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4705FA27852
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 18:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF7F18870A8
	for <lists+cgroups@lfdr.de>; Tue,  4 Feb 2025 17:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4707C216385;
	Tue,  4 Feb 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7jG49jK"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD31215F70
	for <cgroups@vger.kernel.org>; Tue,  4 Feb 2025 17:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738689998; cv=none; b=OL29q9Vflz81FZ7Yz00JYVlP9XVhwm2onurVuUhgmNQUzwBmklA7NWMiWgXx/gPafFywnTX6cTFMF0KsH4ZOibPIVc14Am/3OylFTwS7gf1+bEp5Y2/mgCDKjinD5MKZffIu4q/iz+Xo5kkidac3xN2ZHxv9Na/koQPkrtOSau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738689998; c=relaxed/simple;
	bh=jo9s4dPfmEh1UEHVJ50SN5q/Rpg7UveVw/RHXf3QBsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CULpdw8S05exHjQ8heGNyLznbxS+RoElBSpoUo2DOHkN/XMHIX8DjHp94CPtxOmIbY9UWDJMXhvc0XS9FeoteaX7QgEX4LC88l8w/A9enm+94lg//FJDGjoMUMyg/pwjwFrkQO7mBxrdwVOpTVDSUFNuvO04MYAI+r4kZn2cWUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7jG49jK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738689995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WVogKbewYjMvHSQkRZSoFRhJNaP8hk7j/RDWKx3KnXk=;
	b=a7jG49jKm6UL2BmDlVzJJ7gTJ67osnqQRoRgLoHLtRDMUhVw1+rFQaHj2HzpFxlYCjuvcI
	vqfsSjYXsWbNUowaNQlYqSgQkOdwwdUy3aIpKV/o80Mt7coIcFOzH1Db6PZ1dmQG++Ny86
	TzOY1E5rJ4TXESG2qbMfE8xovPyhORA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-r_0cGeZVNUqLmYOENm9Caw-1; Tue, 04 Feb 2025 12:26:33 -0500
X-MC-Unique: r_0cGeZVNUqLmYOENm9Caw-1
X-Mimecast-MFC-AGG-ID: r_0cGeZVNUqLmYOENm9Caw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436289a570eso50256495e9.0
        for <cgroups@vger.kernel.org>; Tue, 04 Feb 2025 09:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738689992; x=1739294792;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVogKbewYjMvHSQkRZSoFRhJNaP8hk7j/RDWKx3KnXk=;
        b=v6XXpr13dnIDrzUS/LVrfnJ/OG7FQY6yHS2KICusdImvzfmwQDhR/qJ5cq7+6aQGkV
         7spQ6utokzbADfLI3MxgJZGsdAA38YKsc87JX4xlrAt3g48+CTTbZaVP6MxndePFOnLb
         lbaxPQNpkb1do1rK0sx1lhNfSnzF5TEt9ITJHwePy/q+KcoPP6BG/Gv0FezfVQ0CrCdC
         JIEMQzarSsBr9IkEmdE4V2ctePVtY2i4d3p9mI4f+tprhVF5nLAd+0VFo0OEF3O80cA9
         tXdbxtYKQ+hc8FrAKIEhoAeT8AxMwuCn8SlKLygqZElJsgmgdjMZBppQpJYP/GPEijis
         OBcw==
X-Forwarded-Encrypted: i=1; AJvYcCUZHTYTIKsn03PJRR9uRknMuChfrcGZW2OyErdos/hjYhE1S3dEXKjbBHgYEfmT/2bsuSt3Hdik@vger.kernel.org
X-Gm-Message-State: AOJu0YzYj9BrWKrGcF+vtpoJ2RQM8ZrZ1qDUHmiW3GwlhwzkoG1HDE0l
	JTlFqC2DTiG4kKYSUhjK+q4xE9U1jMtNaiDzSrC55WM6+N9sYnZtc8eXoshhC1CPSCXtbsQodSm
	HSE/7RU6v5YhalI+jk8JvGixXXXU40KpdtwxPw9wXq0du8xCabVzQubY=
X-Gm-Gg: ASbGnctUnvR9sr8QePCNJIyB5G+CNsqgwcJF19b//vNfxVhJxbQkGHRR+NfYFrzGD26
	Eo87zVqxKp56k9RfgNadyc+YbH/PaKE4q4gFrWLhqRuekdBNBHjlOyi5UGAZKHKmzAjZSFxMeYC
	qZmO4GQOzuN4B6cZUVxItplPGe0JEFxhH/K1gf13hp0ccWcA/ERh63MgNYfUr5SkKPIKJCng5hm
	WHUXwpzkCu0NYCKJnbBodl6XG8GgZQVOStr18R7zwxeJgRReuAulIXu6kMdMqe9BNWivF42mn5m
	10QHdNuOWOJDHbrVU1jyYH4/GW6tR9brQIIp
X-Received: by 2002:a05:600c:28f:b0:436:6460:e67a with SMTP id 5b1f17b1804b1-438e0cc040dmr219123695e9.25.1738689992465;
        Tue, 04 Feb 2025 09:26:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvabuIQF4OfK967ju9TEg//uSG0zchIovSt7Zu7H1ZKyMQPh1RGVvpPzm36OjgNZk+BycJTg==
X-Received: by 2002:a05:600c:28f:b0:436:6460:e67a with SMTP id 5b1f17b1804b1-438e0cc040dmr219123395e9.25.1738689992067;
        Tue, 04 Feb 2025 09:26:32 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.128.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43907f19247sm17218635e9.1.2025.02.04.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 09:26:31 -0800 (PST)
Date: Tue, 4 Feb 2025 18:26:29 +0100
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
Message-ID: <Z6JNxUYJUX1fGew4@jlelli-thinkpadt14gen4.remote.csb>
References: <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
 <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
 <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfcea236-5b4c-4037-a6f5-267c4c04ad3c@nvidia.com>

Hi Jon,

On 03/02/25 11:01, Jon Hunter wrote:
> Hi Juri,
> 
> On 16/01/2025 15:55, Juri Lelli wrote:
> > On 16/01/25 13:14, Jon Hunter wrote:
> > > 
> > > On 15/01/2025 16:10, Juri Lelli wrote:
> > > > On 14/01/25 15:02, Juri Lelli wrote:
> > > > > On 14/01/25 13:52, Jon Hunter wrote:
> > > > > > 
> > > > > > On 13/01/2025 09:32, Juri Lelli wrote:
> > > > > > > On 10/01/25 18:40, Jon Hunter wrote:
> > > > > > > 
> > > > > > > ...
> > > > > > > 
> > > > > > > > With the above I see the following ...
> > > > > > > > 
> > > > > > > > [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> > > > > > > > [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> > > > > > > > [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> > > > > > > 
> > > > > > > So far so good.
> > > > > > > 
> > > > > > > > [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
> > > > > > > 
> > > > > > > But, this above doesn't sound right.
> > > > > > > 
> > > > > > > > [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
> > > > > > > > [   53.971068] Error taking CPU1 down: -16
> > > > > > > > [   53.974912] Non-boot CPUs are not disabled
> > > > > > > 
> > > > > > > What is the topology of your board?
> > > > > > > 
> > > > > > > Are you using any cpuset configuration for partitioning CPUs?
> > > > > > 
> > > > > > 
> > > > > > I just noticed that by default we do boot this board with 'isolcpus=1-2'. I
> > > > > > see that this is a deprecated cmdline argument now and I must admit I don't
> > > > > > know the history of this for this specific board. It is quite old now.
> > > > > > 
> > > > > > Thierry, I am curious if you have this set for Tegra186 or not? Looks like
> > > > > > our BSP (r35 based) sets this by default.
> > > > > > 
> > > > > > I did try removing this and that does appear to fix it.
> > > > > 
> > > > > OK, good.
> > > > > 
> > > > > > Juri, let me know your thoughts.
> > > > > 
> > > > > Thanks for the additional info. I guess I could now try to repro using
> > > > > isolcpus at boot on systems I have access to (to possibly understand
> > > > > what the underlying problem is).
> > > > 
> > > > I think the problem lies in the def_root_domain accounting of dl_servers
> > > > (which isolated cpus remains attached to).
> > > > 
> > > > Came up with the following, of which I'm not yet fully convinced, but
> > > > could you please try it out on top of the debug patch and see how it
> > > > does with the original failing setup using isolcpus?
> > > 
> > > 
> > > Thanks I added the change, but suspend is still failing with this ...
> > 
> > Thanks!
> > 
> > > [  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> > > [  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> > > [  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> > > [  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
> > > [  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
> >                                                                            ^
> > Different than before but still not what I expected. Looks like there
> > are conditions/path I currently cannot replicate on my setup, so more
> > thinking. Unfortunately I will be out traveling next week, so this
> > might required a bit of time.
> 
> 
> I see that this is now in the mainline and our board is still failing to
> suspend. Let me know if there is anything else you need me to test.

I've been trying to repro on my side. Since I don't have access to
boards like yours, I tried to come up with something based on qemu/kvm,
essentially a 6 CPUs virtualized environment with isolcpus=1,2. But,
offlining of CPU 1 and 2 works as expected with my proposed fix, so I am
back at wondering what might be different in your case.


