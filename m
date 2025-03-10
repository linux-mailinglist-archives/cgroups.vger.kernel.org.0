Return-Path: <cgroups+bounces-6913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D28A58EA4
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 09:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165F23AB1DD
	for <lists+cgroups@lfdr.de>; Mon, 10 Mar 2025 08:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17592224244;
	Mon, 10 Mar 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RrBu00qO"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90D622423A
	for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596909; cv=none; b=ZLFjnqYTn9oPZttR3nk11QSfsJkuF+Wdd0KZw7a+yvbiWzcpgggh6ySQw5+IPP0WzBMIyuux4EybtzjJR6FVkNJH2oGKpXeRX8ontV/jLdgZ/ZLgG+wWkoQ1wQvnisChO7tHo2qKjy00JLxv7WFeueGvBi1BJUIY8GT79+33Qw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596909; c=relaxed/simple;
	bh=Vdn0Xp45W0zY6EXvNCIpPx7m9OhRfnXKtkh1QQkRpho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKsjhh8FnCweY1AlAhkxSKrMOeKm8gA9ZacXktV6EHkwOMm7X2Kl1Uur1TuPQzTD6yviPAH3zIx5GXzwhUq235jSEk348EcBdmZ/FZ+i+HxxJ55P8cbU7PtcdNNnMTLOqpqOC2NAHd0Ggc+raTAWR1wBH9YIpCesCzzqM/sREOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RrBu00qO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741596906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdmSXoVy0aw6POMq2SYkzyggnJQqhnLgSVhB7YCFo00=;
	b=RrBu00qOZgp5gcUuyKuRaZGFAW7utPYq8Ko/7Dx2x+zQ8N+pVhhTdbSz9jBtx12oASAmta
	rh9EusELq363dyIbN1MWJUUC6/2iDPuAECX9skO4B8xOskZyFf5z0QB1g8VQgF+UHL65EG
	at0ekPjksVJMud0atmLP1PhLoja7VrM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-YPMjE8mwMrakE5Y56ptEbg-1; Mon, 10 Mar 2025 04:55:05 -0400
X-MC-Unique: YPMjE8mwMrakE5Y56ptEbg-1
X-Mimecast-MFC-AGG-ID: YPMjE8mwMrakE5Y56ptEbg_1741596904
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39131851046so1139155f8f.0
        for <cgroups@vger.kernel.org>; Mon, 10 Mar 2025 01:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596904; x=1742201704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdmSXoVy0aw6POMq2SYkzyggnJQqhnLgSVhB7YCFo00=;
        b=wVJgOn5/RDjrgKo5v4cpLyodKd3dUpCWUs6KUYF8nfcUzWgELwcQOZYEV8kMu3G6P8
         1cvD5stUUN63hDiLiEWY4nwjH+eVT/VPVG9SARP6K61esAZN31IsezKLGlSBWC0+5vfn
         RZku5GpK978BuM/p4lMZrUXZxTvdcN+PyCKUYb9fBF+0F8e4TjLOxlGBHdF8XDYr9Bw2
         a1Ypzab1zw3K/NsiX0a4yFxtThcsm+FS/4TJ165iO2cdj924j1PW4Vv/7ptqWgUA4TLd
         qInviyo6PGpnWl4FlvN1xSdnaGQb26ItGxDegAfwCKus7GOvEUiIli6DT8/wVB9ssTis
         bfFg==
X-Forwarded-Encrypted: i=1; AJvYcCXR9wa/40idmZIbjd+B0o0WgqAXfolnz34tGn1FiiSuc9HsA0fkH8sEDdDjdhB77u3dRM/0ZSdt@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYlyf2r5WgcFabdJUZ1oFQkfgjDCKt29jfxqu1ukuARkUDO1b
	Wb7Otce/3ZmOCNDSyvhmVVD94YBeYD4Pvvtgj47ITNJ2rMJD24SkulvuvYSQWzK/YyWjiix55f1
	zaQqWRWeY28MeZj1/iW/DZXN1K3gKFlF5970RnATKWcqfN1rpQqLabtc=
X-Gm-Gg: ASbGnctxbs47wng92OZUXJ16vV6aYeowjfcHwCeTL5qJ/0PeHEIePah8vagDASoRfv/
	yx5qT9Pd8U+O+qTCz/SM1+YR9d7GCqrVykteLLVmHf01mGmoHR5q/gsGGOCi3y9rz40Mxuntdsy
	bgtBU0pQ3jcRvhrWCgfZEVeFumQzr9MgEoChg0j624q6yPSF88H1Y6HSe/eIFU5zkOPhaWd88y1
	e/SWpyKDxzDwWkdvLz4+gE7iErFTLL3JIAb8qsAXG5awLHWi/voaFBW+1tOlMyFhFYwTjJh1RCm
	4aAts0glCK9S+ALBbFP/SN02P4mRdDO9hy37evllDDU=
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id ffacd0b85a97d-39132d98a1emr8359876f8f.41.1741596903777;
        Mon, 10 Mar 2025 01:55:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfdR0LZ/IejdEgtb62TmVCUDQ3vvw2ErQjEGxdgcFHhFM2pl+MvjaV81f9xdITu8Eal8mEIg==
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id ffacd0b85a97d-39132d98a1emr8359852f8f.41.1741596903437;
        Mon, 10 Mar 2025 01:55:03 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf87a82f7sm26494435e9.14.2025.03.10.01.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 01:55:02 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:55:00 +0100
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <llong@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>, luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 0/8] Fix SCHED_DEADLINE bandwidth accounting during
 suspend
Message-ID: <Z86o5MC6nXM9W5UL@jlelli-thinkpadt14gen4.remote.csb>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
 <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93c3f9ac-0225-429a-807c-d11c649c819e@redhat.com>

On 07/03/25 14:00, Waiman Long wrote:
> On 3/6/25 9:10 AM, Juri Lelli wrote:
> > Hello!
> > 
> > Jon reported [1] a suspend regression on a Tegra board configured to
> > boot with isolcpus and bisected it to commit 53916d5fd3c0
> > ("sched/deadline: Check bandwidth overflow earlier for hotplug").
> > 
> > Root cause analysis pointed out that we are currently failing to
> > correctly clear and restore bandwidth accounting on root domains after
> > changes that initiate from partition_sched_domains(), as it is the case
> > for suspend operations on that board.
> > 
> > This is v2 [2] of the proposed approach to fix the issue. With respect
> > to v1, the following implements the approach by:
> > 
> > - 01: filter out DEADLINE special tasks
> > - 02: preparatory wrappers to be able to grab sched_domains_mutex on
> >        UP (remove !SMP wrappers - Waiman)
> > - 03: generalize unique visiting of root domains so that we can
> >        re-use the mechanism elsewhere
> > - 04: the bulk of the approach, clean and rebuild after changes
> > - 05: clean up a now redundant call
> > - 06: remove partition_and_rebuild_sched_domains() (Waiman)
> > - 07: stop exposing partition_sched_domains_locked (Waiman)
> > 
> > Please test and review. The set is also available at

...

> I have run my cpuset test and it completed successfully without any issue.
> 
> Tested-by: Waiman Long <longman@redhat.com>
> 

Thanks!
Juri


