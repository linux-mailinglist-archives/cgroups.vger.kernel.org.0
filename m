Return-Path: <cgroups+bounces-764-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30F78010B7
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 18:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8A7281B8D
	for <lists+cgroups@lfdr.de>; Fri,  1 Dec 2023 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77084D58C;
	Fri,  1 Dec 2023 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtW0mh6e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB469106;
	Fri,  1 Dec 2023 09:06:55 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2864d8c8743so1472640a91.1;
        Fri, 01 Dec 2023 09:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701450415; x=1702055215; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ApfEIiuG4L/aqQ9kotcie87+m7wxOXlew1ELlzFCgs=;
        b=BtW0mh6eont2J+wDbOVoc0pUq1VMW1l4K1wVfYgUj3Mi/hD+oC8hsfYOwn7uHBWfof
         Ihz+JSdfIarGvE9wnuNMQ/GbZXL2dDOGqW9rRSAEv7kHb5a7ujgtjWv/KkEwHB6+SjUf
         Kw0WOtKpow6VeuMg0zkb3j2Xx16vqExXgRNLijiqx2wjXh5A8hK05pyDtYxoT1NoRqg+
         NYbdpIkU1cjU5wM71HwDzl1Fu+isXxR/KRlCDbOiBzFnhNKbtOg9DuGel2bIovRNu2W7
         tWJWRO4sRQXePBUNwzRpZ2tgJp0p4lj/BzikfmcqAs85y6rNKrektFPm4Q8t4tDkA5aM
         JREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701450415; x=1702055215;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ApfEIiuG4L/aqQ9kotcie87+m7wxOXlew1ELlzFCgs=;
        b=xEOsUb6orv5Wezkr+UfMirElSQ29Uv/49OyxCPsdk357tTqbo9LN+WIPqSPBRBH7cQ
         01XjjrBzVRX3IfJWv3cqDWhL8bLKqWT6OU0M8gZYJI9eiamS+QPCCRHi6Ycpa0nFdSTf
         atFWxghxOv4ymsj506EzP5fWDJqKW0x17ugSxGYw/Zu1WLj0VSaJPW4fSw019uawU5jr
         BdfUknzw+KZGwBiJuraQzocgxLLpAcLi9JeZegdjXSF/1pEIOSDK6EjZlE95e/FV0tzJ
         zB7xwc+BxYaV7Yo15XkACR8oazKdzuk74CQsPM51ufYPJEUD1NmmoPtz4aHlPek5FzcQ
         Dzxg==
X-Gm-Message-State: AOJu0YypKoDkpPFiPX9Vv+Zgh3Z3TOfQ5EzB3tleOx2qmpHblrGiYzJL
	FQCF9cSkvSIFzDoU6ONks/M=
X-Google-Smtp-Source: AGHT+IFomvySDqYobPhm7POsmRtauV+NVOBDCMgX0NdW/64JtiNsPTo0azcw/rzpSFaErTWak93xmw==
X-Received: by 2002:a17:90b:4f85:b0:286:295a:b33a with SMTP id qe5-20020a17090b4f8500b00286295ab33amr8393253pjb.8.1701450415016;
        Fri, 01 Dec 2023 09:06:55 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id a5-20020a170902ee8500b001cf594f71f3sm1892920pld.157.2023.12.01.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:06:54 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 1 Dec 2023 07:06:53 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>
Subject: Re: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs
 in cpu_is_isolated() check
Message-ID: <ZWoSrfztmprcdkpO@slm.duckdns.org>
References: <20231127041956.266026-1-longman@redhat.com>
 <20231127041956.266026-3-longman@redhat.com>
 <ZWYbqNnnt6gQOssK@slm.duckdns.org>
 <8de482b5-1942-4312-8de4-6f54565ab517@redhat.com>
 <ZWZl0uvqeZ-fR1O9@slm.duckdns.org>
 <b6f88157-cf5e-4c7b-99f3-1944b4e7ebde@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f88157-cf5e-4c7b-99f3-1944b4e7ebde@redhat.com>

Hello,

On Wed, Nov 29, 2023 at 11:01:04AM -0500, Waiman Long wrote:
...
> > > Depending on how the cpumask operators are implemented, we may not have a
> > > guarantee that testing CPU 2, for instance, will always return true. That is
> > Can you please elaborate this part a bit? I'm having a difficult time
> > imagining the sequence of operations where this would matter but that could
> > easily be me not being familiar with the details.
> 
> I may be a bit paranoid about incorrect result due to racing as I had been
> burned before. Just testing a bit in the bitmask may probably be OK. I don't

Setting and clearing a bit is as atomic as it gets, right?

> think it will be a problem for x86, but I am less certain about other more
> exotic architectures like arm64 or PPC which I am less familiar about. I add
> a seqcount for synchronization just for the peace of mind. I can take the
> seqcount out if you don't it is necessary.

I just can't think of a case where this would be broken. The data being read
and written is atomic. There's no way to break a bit operation into multiple
pieces. It is possible to write a really bone-headed bitmask operations
(like, if you shift the bits into place or sth) to make the bits go through
unintended changes but that'd just be a flat-out broken implementation. Even
for a bitmask where write accesses are synchronized through a spinlock, we
should still be able to use test_bit() without holding the lock. This seems
like a pretty basic assumption.

Adding unnecessary synchronization confuses the readers. If we don't need
it, we shouldn't have it.

Thanks.

-- 
tejun

