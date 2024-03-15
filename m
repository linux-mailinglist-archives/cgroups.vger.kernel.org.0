Return-Path: <cgroups+bounces-2062-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DAA87CECC
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 15:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A4BBB21DE9
	for <lists+cgroups@lfdr.de>; Fri, 15 Mar 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AC2376FA;
	Fri, 15 Mar 2024 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uHvkxrE8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3123C063
	for <cgroups@vger.kernel.org>; Fri, 15 Mar 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512841; cv=none; b=kdLPzakv5tQkzw9i1X7CXiyTQqQ2mwSZ3/BYaZ+rCKH/g8DMYWn+ZndItYuDzOCC2jzIzYlUgPtyH0bk8fcAcqKAqv7n5Wx5U2LhYMSXdo4Nrzt6KKm3FJnJnVfboheG+o2FbBDvSGlzX4rY7I4ftmwazmfG7zoEpoWEL5KovIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512841; c=relaxed/simple;
	bh=4yYoQ+p2XdG3//QlKsC770WX+ODswAE2mo70DOdaEWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmDk3wr9GX7VUxxY/R/dwlMU8nD+N0AEJ4cac3e8GTp/QgbOSAVx1b7qa/nDun4IJpDSn/ACx18WRwyN78HLKQ3msw5dFPe/Sxkhc6W/qWj9fxHxowJ8BiA8satPrJdVFtIEW5jQCL8i63HaoB8iA+gDtjeyHqz+TqcGMKDEX1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uHvkxrE8; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c19b7d9de7so1344630b6e.2
        for <cgroups@vger.kernel.org>; Fri, 15 Mar 2024 07:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710512837; x=1711117637; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xwkAMr6+cQJK8ThEFiQkRDq3ghKmxUX0GQoedK4u/n4=;
        b=uHvkxrE8oNHj7Fb8xLC2Ez3VGAkVnr4Y7P90P+KjqbR7jC+kxpSCUwyD4G9cyPGAXy
         wY8R9uDTZ4lvGXRlIUclQ1aVGQSRbvxATKxNi4B6IZQBCBpChZfcMJGYNSse892GYAAp
         rKKhkJnQTZecNaC3u4s5KKMhxI9olq/ZDoUr/Tbre8HTHbAzuO0f97t1ghcXqPxk9qik
         oGdc7ys4J7QcqF2EunOowOKqpUodZHvHDb71Op6q/bUY5Uo3RpELtTRrZiiWQu6zRoEE
         2AZFvNDvFAyQfCWAhnPXQDj0eMrA0hFuWTkLa6MiqUCH74Fq5Fvuz1h38Hf5lx89F2Ys
         GO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710512837; x=1711117637;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwkAMr6+cQJK8ThEFiQkRDq3ghKmxUX0GQoedK4u/n4=;
        b=dcyUUAKfVWnrRxZ3hb+rq/La0ZuCVXnN/Spx8T8tbPMNTApKoA9bTYNmJuPQX16KDz
         u8xfYdTMAOKdWAmAZ7Q3g7j6wom3VmGjM943j9Xuk1/IPvXSFcI7Rvco3p9S+eyz0lIM
         dShlXlInGF1Jnsoe9oslCYCJi47HoP4n+bkggM+/1iHZEanPDJTDJ4/QAu1fgwPzdUtr
         6/wTQiSn2bBNsg6w0GsrGVejVO1lnKzc4dfME6hYoS0OeLpkBoI6t+p+Zrv4H350f0Sa
         mMw4ccSiz8FG/IAmN6CgqJu5iIbxazEdWtJp2AC7FBHQzUkEdIK7EoPMEL2A6tsAGvEO
         86cg==
X-Forwarded-Encrypted: i=1; AJvYcCUuuF3GrJjBa06Us+AKS8vu2LtAoSbtT6BIp2DIfUGGqk50s/R1bUKODx9YnsktUonnh0nipHof/7i8ji32Pt52JlOI/A89mQ==
X-Gm-Message-State: AOJu0YzvaKlVstqL5OkUxnKtd8lbrEUX+/OhF5EHrrrTeS4Nb5WVYZSM
	x3/FS5NS6C11RYVNaCyTnuSdrn3dOwSFFBck03tDpcmenvimtvbnRnWajxZr7vQ=
X-Google-Smtp-Source: AGHT+IHnptoHCC+MDC9mnh/7l2dVwudJAGg+udmfkU9DcS8DPIdkUL2Mwkmv8TJg1+zgnKmQXLuIoA==
X-Received: by 2002:a05:6808:4484:b0:3c2:3150:398 with SMTP id eq4-20020a056808448400b003c231500398mr6507540oib.19.1710512837436;
        Fri, 15 Mar 2024 07:27:17 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id r12-20020a056214124c00b00690d45bb18asm2070362qvv.34.2024.03.15.07.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:27:16 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:27:11 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Yu Zhao <yuzhao@google.com>, Axel Rasmussen <axelrasmussen@google.com>,
	Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
	kernel-team@fb.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: MGLRU premature memcg OOM on slow writes
Message-ID: <20240315142711.GA1944@cmpxchg.org>
References: <20240229235134.2447718-1-axelrasmussen@google.com>
 <ZeEhvV15IWllPKvM@chrisdown.name>
 <CAJHvVch2qVUDTJjNeSMqLBx0yoEm4zzb=ZXmABbd_5dWGQTpNg@mail.gmail.com>
 <CALOAHbBupMYBMWEzMK2xdhnqwR1C1+mJSrrZC1L0CKE2BMSC+g@mail.gmail.com>
 <CAJHvVcjhUNx8UP9mao4TdvU6xK7isRzazoSU53a4NCcFiYuM-g@mail.gmail.com>
 <ZfC16BikjhupKnVG@google.com>
 <ZfC2612ZYwwxpOmR@google.com>
 <CALOAHbAAnGjt2yd8avcSSkMA2MeUWN1-CTkN81GJF+udwE6+DQ@mail.gmail.com>
 <ZfN41Bm2UA7qDPEA@google.com>
 <CALOAHbDn0Dbxfhd72d=7-Z_9PjpP_1pXSm3r9daG_XC_f7vFDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDn0Dbxfhd72d=7-Z_9PjpP_1pXSm3r9daG_XC_f7vFDQ@mail.gmail.com>

On Fri, Mar 15, 2024 at 10:38:31AM +0800, Yafang Shao wrote:
> On Fri, Mar 15, 2024 at 6:23 AM Yu Zhao <yuzhao@google.com> wrote:
> > I'm surprised to see there was 0 pages under writeback:
> >   [Wed Mar 13 11:16:48 2024] total_writeback 0
> > What's your dirty limit?
> 
> The background dirty threshold is 2G, and the dirty threshold is 4G.
> 
>     sysctl -w vm.dirty_background_bytes=$((1024 * 1024 * 1024 * 2))
>     sysctl -w vm.dirty_bytes=$((1024 * 1024 * 1024 * 4))
> 
> >
> > It's unfortunate that the mainline has no per-memcg dirty limit. (We
> > do at Google.)
> 
> Per-memcg dirty limit is a useful feature. We also support it in our
> local kernel, but we didn't enable it for this test case.
> It is unclear why the memcg maintainers insist on rejecting the
> per-memcg dirty limit :(

I don't think that assessment is fair. It's just that nobody has
seriously proposed it (at least not that I remember) since the
cgroup-aware writeback was merged in 2015.

We run millions of machines with different workloads, memory sizes,
and IO devices, and don't feel the need to tune the settings for the
global dirty limits away from the defaults.

Cgroups allot those allowances in proportion to observed writeback
speed and available memory in the container. We set IO rate and memory
limits per container, and it adapts as necessary.

If you have an actual usecase, I'm more than willing to hear you
out. I'm sure that the other maintainers feel the same.

If you're proposing it as a workaround for cgroup1 being
architecturally unable to implement proper writeback cache management,
then it's a more difficult argument. That's one of the big reasons why
cgroup2 exists after all.

> > > As of now, it appears that the most effective solution to address this
> > > issue is to revert the commit 14aa8b2d5c2e. Regarding this commit
> > > 14aa8b2d5c2e,  its original intention was to eliminate potential SSD
> > > wearout, although there's no concrete data available on how it might
> > > impact SSD longevity. If the concern about SSD wearout is purely
> > > theoretical, it might be reasonable to consider reverting this commit.
> >
> > The SSD wearout problem was real -- it wasn't really due to
> > wakeup_flusher_threads() itself; rather, the original MGLRU code call
> > the function improperly. It needs to be called under more restricted
> > conditions so that it doesn't cause the SDD wearout problem again.
> > However, IMO, wakeup_flusher_threads() is just another bandaid trying
> > to work around a more fundamental problem. There is no guarantee that
> > the flusher will target the dirty pages in the memcg under reclaim,
> > right?
> 
> Right, it is a system-wide fluser.

Is it possible it was woken up just too frequently?

Conventional reclaim wakes it based on actually observed dirty pages
off the LRU. I'm not super familiar with MGLRU, but it looks like it
woke it on every generational bump? That might indeed be too frequent,
and doesn't seem related to the writeback cache state.

We're monitoring write rates quite closely due to wearout concern as
well, especially because we use disk swap too. This is the first time
I'm hearing about reclaim-driven wakeups being a concern. (The direct
writepage calls were a huge problem. But not waking the flushers.)

Frankly, I don't think the issue is fixable without bringing the
wakeup back in some form. Even if you had per-cgroup dirty limits. As
soon as you have non-zero dirty pages, you can produce allocation
patterns that drive reclaim into them before background writeback
kicks in.

If reclaim doesn't wake the flushers and waits for writeback, the
premature OOM margin is the size of the background limit - 1.

Yes, cgroup1 and cgroup2 react differently to seeing pages under
writeback: cgroup1 does wait_on_page_writeback(); cgroup2 samples
batches of pages and throttles at a higher level. But both of them
need the flushers woken, or there is nothing to wait for.

Unless you want to wait for dirty expiration :)

