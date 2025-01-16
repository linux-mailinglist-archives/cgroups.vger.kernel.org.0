Return-Path: <cgroups+bounces-6199-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAD5A13E80
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D85188772A
	for <lists+cgroups@lfdr.de>; Thu, 16 Jan 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E7D22CF30;
	Thu, 16 Jan 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9qQissB"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348022C9ED
	for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042941; cv=none; b=IZCJlHS5JBL8VGNvkRWKyDRfGnmENV24XY8VjYxZ13zHDhbVVUQUew9Ec3nvZJNZoAitU8pJ9uQuPDrzdiBMALwEcd3gF6ztuw/nxmdu9OahEAWCN7k0VMilf17hsnvfnABAu7Gwz7n+xgm9mLnlNz5YRdni0EMGdRbT89uwpn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042941; c=relaxed/simple;
	bh=M6rLbXwoKLY87vdD//6QBLSukPIfifTbilph5z1bzaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuN9ZiDLaUbD5Ap3inBBgezsoO4hJ6giuv0/TIi0VQ/kADrgiVGKCledAnNWqYXbiW3pHdQXUeQFEqBbWSZwb/d5wiHXjKw9NLhJ8NKzS9wZw8HHg+xjYhFJKUP6SkTOJPoNT/tevIjQR/OhySnV78n7HPgzXN/d1hJmboPQjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9qQissB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737042938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VXCxqR2hB1HdDwCoB2P/zuXO8pseRXLobkWHItFNoHE=;
	b=h9qQissBzksUTgWb0FmrJdMQczfV/zEdtguldxoijG7zb1lMIEnk/IDGiOU5jl074v8LgH
	ejWXXU5HgwHECIsPHiIq4XQBmLsdFnNbzUEOOC6SYfz9P/SUr37paPNeAarEw5b7DO4GlV
	0fP25GwIIrW2oFojwM9NxD6tMW2Dvmc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-6DMqMs4jP36svth407SfDw-1; Thu, 16 Jan 2025 10:55:36 -0500
X-MC-Unique: 6DMqMs4jP36svth407SfDw-1
X-Mimecast-MFC-AGG-ID: 6DMqMs4jP36svth407SfDw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46909701869so25980721cf.0
        for <cgroups@vger.kernel.org>; Thu, 16 Jan 2025 07:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737042936; x=1737647736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXCxqR2hB1HdDwCoB2P/zuXO8pseRXLobkWHItFNoHE=;
        b=W6w/y0Ks1U2EMWMMYBJJ48+Dkv64gH3qYuq58h9cbD3BtI71+pFkZf73Mg1kfaVD8D
         2DBb2NNCTQAl4IJ+EEtdMKn0ymG+VXdTiuTKH3J93X+04TiAE8pu75lnX9g/Or9DXbky
         9QnYodDw/lLT0NU973i9N2Mn9WC+yCs5JwGmlaSPYlfoLZ0gMgQel3fWz+DNT5YIgb9t
         MAQo9XeRizXsQhZPS1jTsqXX7hcSX1GZ/+PIn99on75HvU2/B3V3shRpppdLNJkqockZ
         p4WQWoD18WgX86RQ3yzPDL8IDcO3a6B0DbfQdAj99dsWeEP2T1RnsCYT0ag6o88MbJIm
         24Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWUVIqJBPq9lD7bvSmslYQCKPIKXD8xZGwuxTVffcS09Yj8Dpz+5g/T6MLnpPNWKBKUYLJsFe4x@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb8IWA8WYD9Z5XsCpAZunnP4r14SoVWgtJ88kqBs01SugcB+GD
	AyQ2YLLBMYHE+3tU/+zPpzR5SDNkZXcIKnkI3zEF8ipHto55/eojFGcxme9LlTow25rAkxE9+IK
	cjwV0lCwGEHYsULbCN8kt0HHMhnL0rx8JmHwmfxJw2s088Tw/VfBizig=
X-Gm-Gg: ASbGncs3UjLtGHJNwJdBaW04EKzUtHtcMQKNuI7YGt5yJIpQko6L0Q9UxcUe9KsNcLY
	KKkYJqP8ezJrFJDn8bqkSQTaq69Zid0SocMQKNjERYyhqXXeBlL7kp6/HXx/3NF8EyMgZLcZF7z
	vgReGRETakwJI5Ewq6CsWBRQfCuABFzXiMfdBmTuiMKkpZzojTFLe6Lky8OryZGTg6siV7Tk2xW
	S55vMP4H63PjiAp0815QN+MZwkTotoTV2LNJ89y+zcl5rXr6PZ8SFI8bTItJQ9DR6g5Y/OhdumE
	VfzWbCK3Mw==
X-Received: by 2002:a05:622a:101:b0:46d:faa2:b6d1 with SMTP id d75a77b69052e-46dfaa2b78fmr106852271cf.16.1737042935825;
        Thu, 16 Jan 2025 07:55:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG6rEQNPX3QX1cl1+CEt2jh6XECB7XmNLIK/9PkAlURmQsCMsq9QryFVTViYqSI+bAw4+QYfg==
X-Received: by 2002:a05:622a:101:b0:46d:faa2:b6d1 with SMTP id d75a77b69052e-46dfaa2b78fmr106851951cf.16.1737042935507;
        Thu, 16 Jan 2025 07:55:35 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.92.51])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e10436a37sm697891cf.79.2025.01.16.07.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 07:55:33 -0800 (PST)
Date: Thu, 16 Jan 2025 16:55:27 +0100
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
Message-ID: <Z4kr7xq7tysrKGoR@jlelli-thinkpadt14gen4.remote.csb>
References: <ZzYhyOQh3OAsrPo9@jlelli-thinkpadt14gen4.remote.csb>
 <Zzc1DfPhbvqDDIJR@jlelli-thinkpadt14gen4.remote.csb>
 <ba51a43f-796d-4b79-808a-b8185905638a@nvidia.com>
 <Z4FAhF5Nvx2N_Zu6@jlelli-thinkpadt14gen4.remote.csb>
 <5d7e5c02-00ee-4891-a8cf-09abe3e089e1@nvidia.com>
 <Z4TdofljoDdyq9Vb@jlelli-thinkpadt14gen4.remote.csb>
 <e9f527c0-4530-42ad-8cc9-cb04aa3d94b7@nvidia.com>
 <Z4ZuaeGssJ-9RQA2@jlelli-thinkpadt14gen4.remote.csb>
 <Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb>
 <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aebb2c29-2224-4d14-94e0-7a495923b401@nvidia.com>

On 16/01/25 13:14, Jon Hunter wrote:
> 
> On 15/01/2025 16:10, Juri Lelli wrote:
> > On 14/01/25 15:02, Juri Lelli wrote:
> > > On 14/01/25 13:52, Jon Hunter wrote:
> > > > 
> > > > On 13/01/2025 09:32, Juri Lelli wrote:
> > > > > On 10/01/25 18:40, Jon Hunter wrote:
> > > > > 
> > > > > ...
> > > > > 
> > > > > > With the above I see the following ...
> > > > > > 
> > > > > > [   53.919672] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> > > > > > [   53.930608] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> > > > > > [   53.941601] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> > > > > 
> > > > > So far so good.
> > > > > 
> > > > > > [   53.952186] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=2
> > > > > 
> > > > > But, this above doesn't sound right.
> > > > > 
> > > > > > [   53.962938] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=576708 dl_bw_cpus=1
> > > > > > [   53.971068] Error taking CPU1 down: -16
> > > > > > [   53.974912] Non-boot CPUs are not disabled
> > > > > 
> > > > > What is the topology of your board?
> > > > > 
> > > > > Are you using any cpuset configuration for partitioning CPUs?
> > > > 
> > > > 
> > > > I just noticed that by default we do boot this board with 'isolcpus=1-2'. I
> > > > see that this is a deprecated cmdline argument now and I must admit I don't
> > > > know the history of this for this specific board. It is quite old now.
> > > > 
> > > > Thierry, I am curious if you have this set for Tegra186 or not? Looks like
> > > > our BSP (r35 based) sets this by default.
> > > > 
> > > > I did try removing this and that does appear to fix it.
> > > 
> > > OK, good.
> > > 
> > > > Juri, let me know your thoughts.
> > > 
> > > Thanks for the additional info. I guess I could now try to repro using
> > > isolcpus at boot on systems I have access to (to possibly understand
> > > what the underlying problem is).
> > 
> > I think the problem lies in the def_root_domain accounting of dl_servers
> > (which isolated cpus remains attached to).
> > 
> > Came up with the following, of which I'm not yet fully convinced, but
> > could you please try it out on top of the debug patch and see how it
> > does with the original failing setup using isolcpus?
> 
> 
> Thanks I added the change, but suspend is still failing with this ...

Thanks!

> [  210.595431] dl_bw_manage: cpu=5 cap=3072 fair_server_bw=52428 total_bw=209712 dl_bw_cpus=4
> [  210.606269] dl_bw_manage: cpu=4 cap=2048 fair_server_bw=52428 total_bw=157284 dl_bw_cpus=3
> [  210.617281] dl_bw_manage: cpu=3 cap=1024 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=2
> [  210.627205] dl_bw_manage: cpu=2 cap=1024 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=2
> [  210.637752] dl_bw_manage: cpu=1 cap=0 fair_server_bw=52428 total_bw=262140 dl_bw_cpus=1
                                                                          ^
Different than before but still not what I expected. Looks like there
are conditions/path I currently cannot replicate on my setup, so more
thinking. Unfortunately I will be out traveling next week, so this
might required a bit of time.

Best,
Juri


