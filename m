Return-Path: <cgroups+bounces-3711-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED6A932F94
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 20:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608511F23B67
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 18:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555EF1A01A7;
	Tue, 16 Jul 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E4ykLDFB"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B3819E7E3
	for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 18:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721152858; cv=none; b=KTzcbSdbe1yr6QtFG4myNZ7t1pSzLdrW9ZsH6Ah9cHXf7u1qSMpbhHenxIyaBTmdnHL5GjdrjfLGch6WlN2ZrSCJGYY/77VDwZgnJaplLe/WUyQEFacrifS0Ren7w771AFYn5cFSUO9SqUYoIE7QZEe9J5De1SIvMq337y8/xxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721152858; c=relaxed/simple;
	bh=LzFpgZ6W1DI7qwIcoo3EYOkSa8/Q1zLkssdk8ZjL+98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glb2CGx0h8urUFC+UYDUhpQ2sUM437s4xRriyElRpHO/3ikbaoWCz+czXKrTY9YiKpuwKgYee2jzH55Mg+ifhSAdxfQHlgrkBRU/s5gRKaow0GXa9MFwWqXyijT+6Es2gjCnl/vM/0ctSe5y6cq1OQn5LIGMqUvEuoonP4NM83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E4ykLDFB; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52ea5dc3c66so9599928e87.3
        for <cgroups@vger.kernel.org>; Tue, 16 Jul 2024 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721152854; x=1721757654; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFsiHkT5kLKgnpnJV32ad1AY52Jam+fAuXfe9Kv9IFA=;
        b=E4ykLDFBWCLO9bLraeKrdLuNc1qCPjxiZCB8LDNpqNbTQYSaiV0JcwxlKPikCqg1m5
         4ybEAluERodv2+kxbhjhgku0DMYl6fRlyV8e32L3x+oaqFP5UIIdBGehVTRvNBb8tRTy
         4D43RDAln0Am6hp00w52OfmcqOJJac7NsQqtxUZ7pOKtrbNMqXeUUBk6XFuX7YqbLxMR
         GHbdu42MdLdYjYYi+JoDPwEdS9Gpy63OiCj7OZyqRVyRhUxYWLdxxpvEApgL/9rOTafr
         5f7DPNgt4AQ1Z3qpD3bTJjo5XbQ/k1ABdIt1QLqUA4jku3RhUizWaK1XogWU9+a/GFYx
         YIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721152854; x=1721757654;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFsiHkT5kLKgnpnJV32ad1AY52Jam+fAuXfe9Kv9IFA=;
        b=Lz/aNVw20y0cPuc0ULO9InMSzhCbNtyecvxaM0+iMqPa8BopwbswSrth1Dof6wrKL9
         vz6HznRMTMjezYMW7pZMxKbX0HsywPM2iOpqOdq9HpgDi/UywMpVIYwCiFshlgX5sBC4
         L9LenDhlqJHlYMqfBulqkkJCO2joc4sTZwysYgHacRF1aEA5NR7LKXLjkH10kTrorTw9
         YtX2B6T4dTX7CBKCjKbQWlB/KQ/tdX87em1Vzr9p8w9eYd2sUeuf9zxMJ8uBLaWrFIKH
         m/TGtFYbSKU1RjWlwDHg56Mu5CY/qaBBJMfbFHYNnjp0S8M0OULwCHn6YA7iV04J/9iC
         TbtA==
X-Forwarded-Encrypted: i=1; AJvYcCXpav3JOzYTenE1oSvFE7QcwsgJh/PpDjRPNme1Wdctg4dCUUuVrZbSJiTwp1j5hGU71LZQpaJi0YbTh3schFJLu0UQIV11tQ==
X-Gm-Message-State: AOJu0Yw1FuasjmNLlLL+lc68wqq08Sq4t8AqWv99dDMm+CupOf8pgGbj
	ZwcKsYTGPUJdYVxtZlCg/d+oqAO37hSJEV8rzHLvrCHL77UiirR2K9S3NLqpIHI=
X-Google-Smtp-Source: AGHT+IFguqmHbDZmceNZdWrl3ay3ZAoue33JScuW0GGJ/EGw5opOR8ZAK/jYib2a5sZ5B5pWLuMxEA==
X-Received: by 2002:a05:6512:6d6:b0:52e:933f:f1fa with SMTP id 2adb3069b0e04-52edf034544mr2643555e87.61.1721152853937;
        Tue, 16 Jul 2024 11:00:53 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3965sm341267566b.42.2024.07.16.11.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:00:53 -0700 (PDT)
Date: Tue, 16 Jul 2024 20:00:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeelb@google.com>, Shuah Khan <shuah@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <Zpa1VGL5Mz63FZ0Z@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpajW9BKCFcCCTr-@slm.duckdns.org>

On Tue 16-07-24 06:44:11, Tejun Heo wrote:
> Hello,
> 
> On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
> ...
> > > This behavior is particularly useful for work scheduling systems that
> > > need to track memory usage of worker processes/cgroups per-work-item.
> > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > opinions), these systems need to track the peak memory usage to compute
> > > system/container fullness when binpacking workitems.
> 
> Swap still has bad reps but there's nothing drastically worse about it than
> page cache. ie. If you're under memory pressure, you get thrashing one way
> or another. If there's no swap, the system is just memlocking anon memory
> even when they are a lot colder than page cache, so I'm skeptical that no
> swap + mostly anon + kernel OOM kills is a good strategy in general
> especially given that the system behavior is not very predictable under OOM
> conditions.

Completely agree on this!

> > As mentioned down the email thread, I consider usefulness of peak value
> > rather limited. It is misleading when memory is reclaimed. But
> > fundamentally I do not oppose to unifying the write behavior to reset
> > values.
> 
> The removal of resets was intentional. The problem was that it wasn't clear
> who owned those counters and there's no way of telling who reset what when.
> It was easy to accidentally end up with multiple entities that think they
> can get timed measurement by resetting.

yes, I understand and agree with you. Generally speaking peak value is
of a very limited value. On the other hand we already have it in v2 and
if it allows a reliable way to scale the workload (which seems to be the
case here) than reseting the value sounds like a cheaper value than
tearing down the memcg and creating it again (with all the dead cgroups
headache that might follow). The reset interface doesn't cause much from
the maintenance POV and if somebody wants to use it they surely need
find a way to coordinate.

> So, in general, I don't think this is a great idea. There are shortcomings
> to how memory.peak behaves in that its meaningfulness quickly declines over
> time. This is expected and the rationale behind adding memory.peak, IIRC,
> was that it was difficult to tell the memory usage of a short-lived cgroup.
> 
> If we want to allow peak measurement of time periods, I wonder whether we
> could do something similar to pressure triggers - ie. let users register
> watchers so that each user can define their own watch periods. This is more
> involved but more useful and less error-inducing than adding reset to a
> single counter.

I would rather not get back to that unless we have many more users that
really need that. Absolute value of the memory consumption is a long
living concept that doesn't make much sense most of the time. People
just tend to still use it because it is much simpler to compare two different
values rather than something as dynamic as PSI similar metrics.

-- 
Michal Hocko
SUSE Labs

