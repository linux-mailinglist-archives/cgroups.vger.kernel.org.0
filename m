Return-Path: <cgroups+bounces-3919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D587493D987
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F976B21C35
	for <lists+cgroups@lfdr.de>; Fri, 26 Jul 2024 20:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086BA4D8B6;
	Fri, 26 Jul 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e976p+he"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D481F5E6;
	Fri, 26 Jul 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024301; cv=none; b=Kq/H0O/SSijiooJVkom0Dww2i7aPnYIYLM88smAlq9S/i4maNh5zAvk1b1/M0PfxL4ev0Ruy7P9VUpG5/yn7lPIEq9Ti0FR3TlKNdTSVpvYYWflnk+35P3S1MYmLhIqS7VcewoQ/210ZEQ6WdC4g7EWZLwMkbEFUCo7Qz/WpmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024301; c=relaxed/simple;
	bh=sHIyIkVFEupEjWxKl+pASpe17z/wLOaJYpi0rVW6CZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPKwzaKQI5naBf0qydjcje5uTcUVEw4uO0JerLSih5FNLVOj2tg+e3M/oUSCyAlSmJ/GkU7f/+UDankJskoT4ITMfnH2lo7G9/+XeD1U+cFELh8wB/LpGtP4V2jLvcUtiOVYymx/Zt+oAsMTfPrTL2LMQeo+BMvXWpG8TwqS91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e976p+he; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d150e8153so854984b3a.0;
        Fri, 26 Jul 2024 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722024300; x=1722629100; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDR2eZY5MHlmYwIoRqIyPiGp3vg1WqH7CWNgUfzBoP0=;
        b=e976p+heVHzNR34LrC3APHljUDI3BF7bniJxwtCQsPP1BRiqWcJbGo6XkbPluo8Eia
         Koglt90OFdvh1kI/2MqbrNYv67nwnJsH1c3+tZwFBpEoVG8cEoydhKUrvuXib9HypoP6
         wWyMSYRMaWWmzasOTA4syL2A64vTa/65RpPt9LhWmZKK0+m1L2ujMKQXAE0mwUl1kyWD
         l64eTIN78fnECCscZ7ngJrdl4xloV/64c2e9H6KjdYGmkus33xoZTSGBaMxE7xl4L910
         gI/AnTUTjvScH6IzwYT/bYqT2nh7nwdTU6VQx4VGKtMZ/06M/sw/rSLTKc3QLgS/i9GJ
         G/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722024300; x=1722629100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VDR2eZY5MHlmYwIoRqIyPiGp3vg1WqH7CWNgUfzBoP0=;
        b=nW+78nGHEXTaflaaO5y4wd4BPudaCM74elGdNqAAzSHZ+6h7Mvp5OYXkDw+SGz4BP8
         9/IxcggmLziRuV3/gfC+IwZUJLtahXsLURbIwJa5az5XcLaX/E+YFkl4Rx1wMb9T/cOB
         UKOnqLKwJee2BNxS8FC9lhSlgd8yh5DeWGBPS9OQ4uM6qTwk9R2mA2H6dz8O92P2BXd3
         zafj2NEG9c1TBVV/elcRAkuqX9+CvwfA3GGQGkXG/9yiDjre8laSw66hxU43Eg3jmzIc
         Yx46lQHonXT8JI3bsIrM5UMIOvkky3jUwxTwTokGYf+/4vHjHTVYqHJJPZs7U0rF6skp
         fOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4sdX6ediUJ2vvLdu7tVqZwYM8lCfI15M9Frfcke+IzsFvNUfQH6HJW9xxjaSZd46WBtAw44tYAg5kzBwpr3fRbx+bdtKep88mpiNTlZjaUnPjpmSsXxmE17QQGjRZaVDOnpuEy9ziIs8IzEG8h9FLHjwzMv/dxf5I6ESOcnqzQw==
X-Gm-Message-State: AOJu0Yz2kMoF41NHpNfhbVYIZbbLtIrqhuLMLVmLTQq0DVwmCU0gcOOY
	yBYAB8vPF2Om/1yCaYEZkcxhRJIAQEHCxXAQKOaJHjnVnGhEHzX4
X-Google-Smtp-Source: AGHT+IHNyKobZSB2Z0LwzzaaLZhrE0kcunwzzLJqK8cqABikL3rpajppk8xBArSL5bPdOIjnRqDXSg==
X-Received: by 2002:a05:6a00:a89:b0:70b:5368:a212 with SMTP id d2e1a72fcca58-70ece822e52mr677217b3a.15.1722024299459;
        Fri, 26 Jul 2024 13:04:59 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f7c744c4sm3179803a12.14.2024.07.26.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 13:04:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 26 Jul 2024 10:04:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH-cgroup v4] cgroup: Show # of subsystem CSSes in
 cgroup.stat
Message-ID: <ZqQBaeAH_IfpRTnv@slm.duckdns.org>
References: <20240711025153.2356213-1-longman@redhat.com>
 <23hhazcy34yercbmsogrljvxatfmy6b7avtqrurcze3354defk@zpekfjpgyp6h>
 <0efbedff-3456-4e6a-8d2d-79b89a18864d@redhat.com>
 <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qozzqah5blnsvc73jrhfuldsaxwsoluuewvgpukzgcuud4nqgc@xnctlkgk5yjv>

Hello,

On Fri, Jul 26, 2024 at 10:19:05AM +0200, Michal Koutný wrote:
> On Thu, Jul 25, 2024 at 04:05:42PM GMT, Waiman Long <longman@redhat.com> wrote:
> > > There's also 'debug' subsys. Have you looked at (extending) that wrt
> > > dying csses troubleshooting?
> > > It'd be good to document here why you decided against it.
> > The config that I used for testing doesn't include CONFIG_CGROUP_DEBUG.
> 
> I mean if you enable CONFIG_CGROUP_DEBUG, there is 'debug' controller
> that exposes files like debug.csses et al.
> 
> > That is why "debug" doesn't show up in the sample outputs. The CSS #
> > for the debug subsystem should show up if it is enabled.
> 
> So these "debugging" numbers could be implemented via debug subsys. So I
> wondered why it's not done this way. That reasoning is missing in the
> commit message.

While this is a bit of implementation detail, it's also something which can
be pretty relevant in production, so my preference is to show them in
cgroup.stat. The recursive stats is something not particularly easy to
collect from the debug controller proper anyway.

One problem with debug subsys is that it's unclear whether they are safe to
use and can be depended upon in production. Not that anything it shows
currently is particularly risky but the contract around the debug controller
is that it's debug stuff and developers may do silly things with it (e.g.
doing high complexity iterations and what not).

The debug controller, in general, I'm not sure how useful it is. It does
nothing that drgn scripts can't do and doesn't really have enough extra
benefits that make it better. We didn't have drgn back when it was added, so
it's there for historical reasons, but I don't think it's a good idea to
expand on it.

Thanks.

-- 
tejun

