Return-Path: <cgroups+bounces-6605-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482D1A3BB37
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 11:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE73B0C5B
	for <lists+cgroups@lfdr.de>; Wed, 19 Feb 2025 10:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B931DE2A6;
	Wed, 19 Feb 2025 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKtWicPO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A51D88DB
	for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 10:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959375; cv=none; b=l+KILwtxgp+Fb1UZrAtwq3+7p0Rluhjc1xv1dmY69kqZVGNOIVMEuTUUo5hHbM3k2DRZtd2psBQlxc+77Mq6tb0e1U+Ybl0IH8Sf6cNhzyKXF4GBIWL4FV3RtAboFYRUB5qqnVIPTddVe701K/k0FbEadRKCFPUK4XEL5iWzpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959375; c=relaxed/simple;
	bh=pG3ehQ8ELvoaHuUfcRGNZ+bIa/1pT9JXhzOPZ5ksmPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JR9Rq6E/CBKnqpsYMCEbYKLiC65Sfic8zagl4iO0GEnaEq/QgCB/Tyvnh9d5cKpj31DRCmzj0Ms7Gj9tBecJ7+0LpetDzRwchX5Xqzl+mlbBYwQqZGZ+bprX1Eto/B3MUridd22FMYFJRJCQp9kfBpPy7NPqifRkUF7DBnAeIpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XKtWicPO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739959372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6zefS7lKlcewOYQ7mQ6LJ7/0/Vzj6dzTA0TGrsliN8=;
	b=XKtWicPO7NGFaC4+0DdUuYF/1Ga0f9O/beTDmS4TieQpjh74pdxaqKblJr3Wv2QpNrc97V
	8lqe/pxBoS5JM8OP3nvtOll4OVVX1qnDQTfhXFJBIE/AwnIEdCfEHySKXuOa9a29eLzVnW
	8F6WgoKd58ozBz9AFl2N1hoM1hX2oU4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-oCYN6KS1M3mjgB0E2dnReA-1; Wed, 19 Feb 2025 05:02:51 -0500
X-MC-Unique: oCYN6KS1M3mjgB0E2dnReA-1
X-Mimecast-MFC-AGG-ID: oCYN6KS1M3mjgB0E2dnReA_1739959370
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f455a8fcaso2868988f8f.2
        for <cgroups@vger.kernel.org>; Wed, 19 Feb 2025 02:02:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739959370; x=1740564170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6zefS7lKlcewOYQ7mQ6LJ7/0/Vzj6dzTA0TGrsliN8=;
        b=shCShmAZoVZDbuodAHziTYmjk6SleZXLEgPxFOcBPxx4x77I3O6bL4ebm7ezzpFqGb
         z6f4zsG/8aH32MeTzfBT62yJtTqHpAZJnvMf/k5Pp1NAw83eO36Gge7lnd8WZwElvmsi
         OqzWOAxBHTI7mJsvYSGU6AM/0wkJFhhbMPo+On89eWEcYW1Lfv0E/FhQOf2Weyg6d+MM
         +3h/kBsht/ZYBbhUcIWN7Mv21E67VR4VwzkO8kcAcfqnXW7naASgThpc3M6VBDx9Ew0n
         QjJf2uelT6EFTVxZ8gekqHWiZ77C0w0aoq4PLP0OpNPU7EgMuXi4D72sSxaMoMPsdYbj
         moOA==
X-Forwarded-Encrypted: i=1; AJvYcCXJXKen19s1zDsq3usL9Ryui0Y8MI4e5XsIxZsKWpsaMe/uX5OL3yUSMyYawFM3tYUYe1v/BE+0@vger.kernel.org
X-Gm-Message-State: AOJu0YyT1BXp8C482LmAfOeRpZAl/Y2U6fkHk2g6/6OK541UCeXVEKtG
	tGY+cUYxfz7oL2qw9F6idUy3a0r7ZW8W/Lo+v9xv2jAHh16iVm2dDB3NQhqEYCQfQyYJhPCs6CO
	W6Ym2Eg24vQvs7yq/R0N9c0j73Y0r8vfqn7wYsRBPnyYHvVIRBxHPTIE=
X-Gm-Gg: ASbGncslgsbAokJpU8O6b2ZEf5gBrBGdCKORMKZ7/PzAsCNbmO8CYDiHoZk6igGd/Fv
	NufHI6Gf3DQ70advcJJ58sk6edpHqsdfPHgsU4urBswp0tv8PCp5bwYP4Q1+7JFANV6OR9AGW9h
	ig9OLOI8eeKbtt/bCvsLD4V0gj28jDvHigQefqgchTRDScQjY9UTpRZtHoLgqL7Dbob9M2rus8C
	cHeBevO47ZxlZzJCTINY4k3KjUNVbHyOpM+VjvoEm7/bSEK1wW1xiMfB6sPv+8iVLFz8vtvd/Od
	SaOQLA+Lw6G0r2awk1TpnEUBnVByL2tbQQ==
X-Received: by 2002:a5d:6a0e:0:b0:38d:e190:b713 with SMTP id ffacd0b85a97d-38f587ca520mr2058210f8f.37.1739959370116;
        Wed, 19 Feb 2025 02:02:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3CX/A5GZaT4XTXRfc/4HEl7SxwEen11NbYXLZ9oXbaY+XlUUSf56BBdLr7G7NBNgkHckUng==
X-Received: by 2002:a5d:6a0e:0:b0:38d:e190:b713 with SMTP id ffacd0b85a97d-38f587ca520mr2058177f8f.37.1739959369680;
        Wed, 19 Feb 2025 02:02:49 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.34.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439872b59e9sm76030525e9.31.2025.02.19.02.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:02:48 -0800 (PST)
Date: Wed, 19 Feb 2025 11:02:46 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
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
Message-ID: <Z7WsRvsVCWu_By1c@jlelli-thinkpadt14gen4.remote.csb>
References: <Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb>
 <78f627fe-dd1e-4816-bbf3-58137fdceda6@nvidia.com>
 <Z62ONLX4OLisCLKw@jlelli-thinkpadt14gen4.remote.csb>
 <30a8cda5-0fd0-4e47-bafe-5deefc561f0c@nvidia.com>
 <151884eb-ad6d-458e-a325-92cbe5b8b33f@nvidia.com>
 <Z7Ne49MSXS2I06jW@jlelli-thinkpadt14gen4.remote.csb>
 <Z7RZ4141H-FnoQPW@jlelli-thinkpadt14gen4.remote.csb>
 <d7cc3a3c-155e-4872-a426-cbd239d79cac@arm.com>
 <Z7SWvr86RXlBbJlw@jlelli-thinkpadt14gen4.remote.csb>
 <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f03e3e-bced-4be7-8589-1e65042b39aa@arm.com>

On 19/02/25 10:29, Dietmar Eggemann wrote:

...

> I did now. 

Thanks!

> Patch-wise I have:
> 
> (1) Putting 'fair_server's __dl_server_[de|at]tach_root() under if  
>     '(cpumask_test_cpu(rq->cpu, [old_rd->online|cpu_active_mask))' in 
>     rq_attach_root()
> 
>     https://lkml.kernel.org/r/Z7RhNmLpOb7SLImW@jlelli-thinkpadt14gen4.remote.csb
> 
> (2) Create __dl_server_detach_root() and call it in rq_attach_root()
> 
>     https://lkml.kernel.org/r/Z4fd_6M2vhSMSR0i@jlelli-thinkpadt14gen4.remote.csb
> 
> plus debug patch:
> 
>     https://lkml.kernel.org/r/Z6M5fQB9P1_bDF7A@jlelli-thinkpadt14gen4.remote.csb
> 
> plus additional debug.

So you don't have the one with which we ignore special tasks while
rebuilding domains?

https://lore.kernel.org/all/Z6spnwykg6YSXBX_@jlelli-thinkpadt14gen4.remote.csb/

Could you please double check again against

git@github.com:jlelli/linux.git experimental/dl-debug

> The suspend issue still persists.
> 
> My hunch is that it's rather an issue with having 0 CPUs left in DEF
> while deactivating the last isol CPU (CPU3) so we set overflow = 1 w/o
> calling __dl_overflow(). We want to account fair_server_bw=52428
> against 0 CPUs. 
> 
> l B B l l l
> 
>       ^^^
>       isolcpus=[3,4]
> 
> 
> cpumask_and(mask, rd->span, cpu_active_mask)
> 
> mask = [3-5] & [0-3] = [3] -> dl_bw_cpus(3) = 1
> 
> ---
> 
> dl_bw_deactivate() called cpu=5
> 
> dl_bw_deactivate() called cpu=4
> 
> dl_bw_deactivate() called cpu=3
> 
> dl_bw_cpus() cpu=6 rd->span=3-5 cpu_active_mask=0-3 cpus=1 type=DEF
>                    ^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^
>   cpumask_subset(rd->span, cpu_active_mask) is false
> 
>   for_each_cpu_and(i, rd->span, cpu_active_mask)
>     cpus++                                       <-- cpus is 1 !!!
> 
> dl_bw_manage: cpu=3 cap=0 fair_server_bw=52428 total_bw=104856 dl_bw_cpus=1 type=DEF span=3-5
                                                          ^^^^^^
This still looks wrong: with a single cpu remaining we should only have
the corresponding dl server bandwidth present (unless there is some
other DL task running.

If you already had the patch ignoring sugovs bandwidth in your set, could
you please share the full dmesg?

Thanks!


