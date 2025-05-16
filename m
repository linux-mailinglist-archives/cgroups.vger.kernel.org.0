Return-Path: <cgroups+bounces-8237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EF7ABA0E3
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68363B6B1B
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62AB1D5CD9;
	Fri, 16 May 2025 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="vVeTq6GL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17148224F6
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747413719; cv=none; b=RFAV8Z8vZdvJp40hqG2GlNrl1IciO9A/vHxp5lC2HV5Bj8CdUfvJ2szhG7mV9SmlcaJCLWzrpR0tKqDFJQ5Gxee7uSXJMQJUlWHXK0vj1vab4ISKmMcBFhY/f98m+7Whm9eniY0ZLIjHkd9rPWBExWJhl2M3V77F4tQhyZWOaxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747413719; c=relaxed/simple;
	bh=YR1iBB/iZX5WiMMW1o9TTIaCyyWT+HI0/WlMWNyQyvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olTGHrO4pN1IHFE8jfhdkDHSWBQDXTP1EoQ/f/T4M1c/L9N2ghIpA1EJMlyBKKkkIa9IubXkz5AAA2bjZ+kFdThGSHQKZcay+kpC8UBwomVS8w3yAHZUj1Y94hMff6M/z2HVdCqYQkRz1Vn6CbOnZ96nnHkKgG3pc2Tul6UY7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=vVeTq6GL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c9376c4bddso266710885a.3
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747413716; x=1748018516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5J2wC9tTnCntXNvDVkFSqpJ+5OZHuJw2jDGcRFbaOU0=;
        b=vVeTq6GLYrvlXl+AzhMzomhVvkjrNmZ8heXT5MfiEP3bZ/HwVAdQwazZMORg/y5el0
         Ed4mXEYoakELbLWnTzJrTiaRNhhcZeCAk09kBV0OLQ2Npw2r6HrZP6JZQEuWBb0nh0ze
         iobvBt9gvLbnuCWHNxUYk++O4AurnqKNQ+fE0PiOHDEMg9dW6vTWrNF+1OYv5DAwsvdM
         08LMGhanj4YgD2P5skOOen2PZpWWAWwDaIYxtlFgRr4Js6o+J0mykJh637vIFRHrkso2
         lSQ5BpgGClrBh67PeAjgrSo0y8zsqZY2HOFsypH5LtIa+4nr/5s4fbbZbIOYVJXlWO3k
         7HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747413716; x=1748018516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5J2wC9tTnCntXNvDVkFSqpJ+5OZHuJw2jDGcRFbaOU0=;
        b=LSMcxDBE8PKhI2iLZIAAEC6dmgV2rblGfnkjVBjPnKhmupC+5SpjpiAwNr0dBO/uxV
         DDQtvXswM9VA40a4a83KRcsZo0zbNN5bnaW5R6DpGN/9TCkFB3VHI2Tom7bj6lJ44aEd
         EkmkRMupH7tKPa085szup2j3lSpSPytUbW6zp3xmf6j4dXU8Ci29uwljqadelclYKKVf
         mpZjvhfvoNv53LESunUL79JBSm0eMq9UjHOO+IMKdaCJH71EnybDVQlyqYf00qoBdHd5
         pUydI7AhammsWNcXUWMwdeE0jUAvBowr4JRa89tglQE+5W7SEG3l01viSsTatd7ATXTv
         7KMA==
X-Forwarded-Encrypted: i=1; AJvYcCUmO5m2wq6ASe00PoheP07fjgGnQ1oLN40ud59xPri63ibTvpZ/Xiro2eGmvBA2Ga0FChP3mvjn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf6Sf3z0pJ2p6QiyM5vAeFZ6tvMyP58msXkxwmblS8NzJS4rvU
	/G1tWY1Xo1pOb9Wu7G7czWixgPIfYFOTV78k4aePA44cAqkjwtc1Zc487uet2G6R0SU=
X-Gm-Gg: ASbGncuOomFzIId/LAga8uMW4X7vM7J+n2dcXOjLRN4Z6+apkJ7ycQ+Pe5lw75jpDF7
	uaxchFJ48GPN8f6EPe8PsRxb/kqeBli2JATFBDcplkGW0EqF+VrQmRL8BOKigryzIuCSRI2s9qP
	/1b4UN9of1FCk/ACjfeyRXowxxkTckOm+viHnxAjK9me7qgw9iZj5nPiG1kleXul1IzWZzPeHiq
	hB40gR0WCSPBrEmB7vbJ+wbmwMiPlrIRxn+idqn+RRR73phdy47fkJnzx/H+hhXIb3o0k5hMzPn
	kYZR+gOgXmBd/e9ocUFMBOgeNVOfQwccmfUqf2+GVvcQncLa4g==
X-Google-Smtp-Source: AGHT+IEtBMFIFAv7ssiv8r9xyjjpS4y6HGWSwusporLTNbSdncvwuVbb9EkCbAuPsKwJEg/pHlYsqQ==
X-Received: by 2002:a05:620a:4015:b0:7c7:c772:7442 with SMTP id af79cd13be357-7cd4672dbd2mr523716785a.20.1747413715739;
        Fri, 16 May 2025 09:41:55 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f8b0966098sm13924376d6.82.2025.05.16.09.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:41:54 -0700 (PDT)
Date: Fri, 16 May 2025 12:41:50 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Dave Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	tj@kernel.org, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250516164150.GD720744@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
 <20250515160842.GA720744@cmpxchg.org>
 <bba93237-9266-4e25-a543-e309eb7bb4ec@amd.com>
 <20250516145318.GB720744@cmpxchg.org>
 <5000d284-162c-4e63-9883-7e6957209b95@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5000d284-162c-4e63-9883-7e6957209b95@amd.com>

On Fri, May 16, 2025 at 05:35:12PM +0200, Christian König wrote:
> On 5/16/25 16:53, Johannes Weiner wrote:
> > On Fri, May 16, 2025 at 08:53:07AM +0200, Christian König wrote:
> >> The cgroup who originally allocated it has no reference to the
> >> memory any more and also no way of giving it back to the core
> >> system.
> > 
> > Of course it does, the shrinker LRU.
> 
> No it doesn't. The LRU handling here is global and not per cgroup.

Well, the discussion at hand is that it should be.

> > Listen, none of this is even remotely new. This isn't the first cache
> > we're tracking, and it's not the first consumer that can outlive the
> > controlling cgroup.
> 
> Yes, I knew about all of that and I find that extremely questionable
> on existing handling as well.

This code handles billions of containers every day, but we'll be sure
to consult you on the next redesign.

> Memory pools which are only used to improve allocation performance
> are something the kernel handles transparently and are completely
> outside of any cgroup tracking whatsoever.

You're describing a cache. It doesn't matter whether it's caching CPU
work, IO work or network packets.

What matters is what it takes to recycle those pages for other
purposes - especially non-GPU purposes.

And more importantly, *what other memory in other cgroups they
displace in the meantime*.

It's really not that difficult to see an isolation issue here.

Anyway, it doesn't look like there is a lot of value in continuing
this conversation, so I'm going to check out of this subthread.

