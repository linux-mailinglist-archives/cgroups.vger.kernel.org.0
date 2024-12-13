Return-Path: <cgroups+bounces-5882-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBAF9F03DF
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 05:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA17284296
	for <lists+cgroups@lfdr.de>; Fri, 13 Dec 2024 04:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D36185B56;
	Fri, 13 Dec 2024 04:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="GOvvxWUu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574F52F43
	for <cgroups@vger.kernel.org>; Fri, 13 Dec 2024 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734064945; cv=none; b=jeSTeiTvykmN/XGznDYwa6X78BK1QCHPFU0ZHoMfcBaxrKMuxKplau9bs66nKV8cast+aHBwjjwaif30Y0o0ebykFmT1/RnZx7gsAeIH+HAWuhJ0dL5q0nZlsXfHGFsgwrcQIfirO4//0ALLaHPwTij2jZTxg5+JzMaFQuflXig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734064945; c=relaxed/simple;
	bh=SJ1Yf1GKc/E93rWNjfnaH+hsrxUijYC4eO6y54WT8Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlKZcJFdaQA2PrdV8PQev73mGZRC/g/o1t34je9baen6SdCA4IwgL/xzwz70dVJUkAdcU8KX4Od6ayVyM470vkgkfX6qXSOFjBHdScg6ZrA4DDMUHlju3z7hIGidWkc7bWpe7FhzrxPTWTSbnl3Fo+RGYzuYY0q8Cf/noY35Qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=GOvvxWUu; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7b1601e853eso103435385a.2
        for <cgroups@vger.kernel.org>; Thu, 12 Dec 2024 20:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1734064940; x=1734669740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=doqHV7X4srCESak8AqpW6ZG84XWySTc3Joa+0PJxz44=;
        b=GOvvxWUuRAyXCi7y/pMdkviVm1lolmpztjgFzpDF+WTT6nQHzlGg0FCpN92gxBnzyS
         28NvRzXDH1D45i4LNaJR1/LL43Luuyup4h6pRMvb+Lb+1aK8kTdfADISLl8AS/1XR0tk
         AjJ3Al8C4tHl72wF8eU3B2SblDOew/DOnrUdQQa6yG7Aq9yD/9x/AvT8HlGgt/ajZUav
         ZipX4N/fYJOxpQlSSgNzz4wvAk4Htu8OM1eGeqTcDwh8mzL2O1L1+aFBkEYbT+nEFYlC
         KwiVtNDAUq3Z/DKazyM+P4sDt07Us5rqtW9GCLydg5QP+zwALy672ueIDI4Tl0V3CNht
         p1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734064940; x=1734669740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doqHV7X4srCESak8AqpW6ZG84XWySTc3Joa+0PJxz44=;
        b=SbPEiv1KIZM2R8AQjKWnk6Q8IKhrl7ZTxfUAb5EmDZJFPhtT4kTREZ9s3hhus1+BD3
         hlfd6+zEezDVpCC4behy3uSnqaE2PIXhtIrF5Gkn+guHe1OVfTjdtcfpB47y2aOEnL9v
         cUBoIHCvO6j4cGZ7OhNjD8WhGuJ8SKQsVABDVKJEAtXQvZjyQi9QERaV/XhrkBDLxHD8
         OANQ40yRPv87rJJSwnAq0tuP2Rho+z+YkIi6UZMsE75tsbTDrP9tWFW0H5tkIjb+PPvs
         e1Jyxj/ICMlBtDcZYvYCvTjV4UklD8L2qDf0hVRqUd6K+HpV1BZbPFIP4g8T7+qAUzXS
         SiUg==
X-Forwarded-Encrypted: i=1; AJvYcCVh9kD8CR2MSFbEZre/4kkazpMxNoFgJpVJqimtfqNMmK+Lo+K43Oh/2KyGuJesSTFpgVXnDAtA@vger.kernel.org
X-Gm-Message-State: AOJu0YxupkaeUnKOWf2Xm2p0yRaj5jFrHAa66vkJlOmVxrUjik0RZYFY
	rb2tyeuV7VMQBxzG/svYRLb0BZUbM/O1eXhqi7YL+lse8C/YQJ2ls2hECRj6hIZyf5H+7EiOqY7
	C
X-Gm-Gg: ASbGncvjb2p0583bMKO6Cmx3tvyxcYMTBEPzzjGiELjWIzqAlpUPsLEBBKdSzEIG6/5
	M4KaUYrHKyMWNh29e1OMHqCwM8R+3Yhz9DI20ClAPX+dA3Cs5GNSNDMaJyNcpHeDMBEw8QI1MGR
	+RdCQXTMCh7Vv5LtxzRA369Bc1UdTy8eyjhIJ5T/DTTLzG98WjmUHZ7KLtDnicqgFku4j4Ioa7h
	1gOT+L25kTDimvaZ1vUCRikpMuxFEQHui62hp68b3yfEoCSChlOX8Y=
X-Google-Smtp-Source: AGHT+IGjJJYcn75s9DDI/soD8CkuZPWEEXQITEJPoftUx+AIzZnB5mh1pETTouvPCh12CwbWHR3H9Q==
X-Received: by 2002:a05:620a:1a95:b0:7b6:d6dd:8826 with SMTP id af79cd13be357-7b6fbf43a6bmr193238285a.55.1734064939930;
        Thu, 12 Dec 2024 20:42:19 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6e5ca6c65sm300162185a.125.2024.12.12.20.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 20:42:18 -0800 (PST)
Date: Thu, 12 Dec 2024 23:42:13 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Yosry Ahmed <yosryahmed@google.com>, Rik van Riel <riel@surriel.com>,
	Balbir Singh <balbirs@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
	hakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH v2] memcg: allow exiting tasks to write back data to swap
Message-ID: <20241213044213.GA6910@cmpxchg.org>
References: <20241212115754.38f798b3@fangorn>
 <CAJD7tkY=bHv0obOpRiOg4aLMYNkbEjfOtpVSSzNJgVSwkzaNpA@mail.gmail.com>
 <20241212183012.GB1026@cmpxchg.org>
 <Z1uAi0syiPY7h6wt@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1uAi0syiPY7h6wt@google.com>

On Fri, Dec 13, 2024 at 12:32:11AM +0000, Roman Gushchin wrote:
> On Thu, Dec 12, 2024 at 01:30:12PM -0500, Johannes Weiner wrote:
> > On Thu, Dec 12, 2024 at 09:06:25AM -0800, Yosry Ahmed wrote:
> > > On Thu, Dec 12, 2024 at 8:58 AM Rik van Riel <riel@surriel.com> wrote:
> > > >
> > > > A task already in exit can get stuck trying to allocate pages, if its
> > > > cgroup is at the memory.max limit, the cgroup is using zswap, but
> > > > zswap writeback is enabled, and the remaining memory in the cgroup is
> > > > not compressible.
> > > >
> > > > This seems like an unlikely confluence of events, but it can happen
> > > > quite easily if a cgroup is OOM killed due to exceeding its memory.max
> > > > limit, and all the tasks in the cgroup are trying to exit simultaneously.
> > > >
> > > > When this happens, it can sometimes take hours for tasks to exit,
> > > > as they are all trying to squeeze things into zswap to bring the group's
> > > > memory consumption below memory.max.
> > > >
> > > > Allowing these exiting programs to push some memory from their own
> > > > cgroup into swap allows them to quickly bring the cgroup's memory
> > > > consumption below memory.max, and exit in seconds rather than hours.
> > > >
> > > > Signed-off-by: Rik van Riel <riel@surriel.com>
> > > 
> > > Thanks for sending a v2.
> > > 
> > > I still think maybe this needs to be fixed on the memcg side, at least
> > > by not making exiting tasks try really hard to reclaim memory to the
> > > point where this becomes a problem. IIUC there could be other reasons
> > > why reclaim may take too long, but maybe not as pathological as this
> > > case to be fair. I will let the memcg maintainers chime in for this.
> > > 
> > > If there's a fundamental reason why this cannot be fixed on the memcg
> > > side, I don't object to this change.
> > > 
> > > Nhat, any objections on your end? I think your fleet workloads were
> > > the first users of this interface. Does this break their expectations?
> > 
> > Yes, I don't think we can do this, unfortunately :( There can be a
> > variety of reasons for why a user might want to prohibit disk swap for
> > a certain cgroup, and we can't assume it's okay to make exceptions.
> > 
> > There might also not *be* any disk swap to overflow into after Nhat's
> > virtual swap patches. Presumably zram would still have the issue too.
> > 
> > So I'm also inclined to think this needs a reclaim/memcg-side fix. We
> > have a somewhat tumultous history of policy in that space:
> > 
> > commit 7775face207922ea62a4e96b9cd45abfdc7b9840
> > Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Date:   Tue Mar 5 15:46:47 2019 -0800
> > 
> >     memcg: killed threads should not invoke memcg OOM killer
> > 
> > allowed dying tasks to simply force all charges and move on. This
> > turned out to be too aggressive; there were instances of exiting,
> > uncontained memcg tasks causing global OOMs. This lead to that:
> > 
> > commit a4ebf1b6ca1e011289677239a2a361fde4a88076
> > Author: Vasily Averin <vasily.averin@linux.dev>
> > Date:   Fri Nov 5 13:38:09 2021 -0700
> > 
> >     memcg: prohibit unconditional exceeding the limit of dying tasks
> > 
> > which reverted the bypass rather thoroughly. Now NO dying tasks, *not
> > even OOM victims*, can force charges. I am not sure this is correct,
> > either:
> > 
> > If we return -ENOMEM to an OOM victim in a fault, the fault handler
> > will re-trigger OOM, which will find the existing OOM victim and do
> > nothing, then restart the fault. This is a memory deadlock. The page
> > allocator gives OOM victims access to reserves for that reason.
> > 
> > Actually, it looks even worse. For some reason we're not triggering
> > OOM from dying tasks:
> > 
> >         ret = task_is_dying() || out_of_memory(&oc);
> > 
> > Even though dying tasks are in no way privileged or allowed to exit
> > expediently. Why shouldn't they trigger the OOM killer like anybody
> > else trying to allocate memory?
> > 
> > As it stands, it seems we have dying tasks getting trapped in an
> > endless fault->reclaim cycle; with no access to the OOM killer and no
> > access to reserves. Presumably this is what's going on here?
> > 
> > I think we want something like this:
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 53db98d2c4a1..be6b6e72bde5 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1596,11 +1596,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	if (mem_cgroup_margin(memcg) >= (1 << order))
> >  		goto unlock;
> >  
> > -	/*
> > -	 * A few threads which were not waiting at mutex_lock_killable() can
> > -	 * fail to bail out. Therefore, check again after holding oom_lock.
> > -	 */
> > -	ret = task_is_dying() || out_of_memory(&oc);
> > +	ret = out_of_memory(&oc);
> 
> I like the idea, but at first glance it might reintroduce the problem
> fixed by 7775face2079 ("memcg: killed threads should not invoke memcg OOM killer").

The race and warning pointed out in the changelog might have been
sufficiently mitigated by this more recent commit:

commit 1378b37d03e8147c67fde60caf0474ea879163d8
Author: Yafang Shao <laoar.shao@gmail.com>
Date:   Thu Aug 6 23:22:08 2020 -0700

    memcg, oom: check memcg margin for parallel oom

If not, another possibility would be this:

	ret = tsk_is_oom_victim(task) || out_of_memory(&oc);

But we should probably first restore reliable forward progress on
dying tasks, then worry about the spurious printk later.

