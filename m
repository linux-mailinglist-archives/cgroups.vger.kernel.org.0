Return-Path: <cgroups+bounces-8236-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D68ABA0A5
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66F149E5C6E
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 16:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0891946DF;
	Fri, 16 May 2025 16:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="aQCzpUGO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C42323D
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 16:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747411935; cv=none; b=TAiGj2kQzRVlf/wZOrpWZHS+YPP5QFpqVxv6M4HYqHyB1pgDtknQKar5WouSXAWUkBGSWw1IKFjKBRPxsZ+XEiDqfXDO684n7V12qI2HDYNC6kzyZah3hDTWOVN6+Xw9r1lholhJmbfkuVhz3nXcRAyUhPJ4SPIzfnClYzG4iww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747411935; c=relaxed/simple;
	bh=fXJJ7UWqEQqitlyLhqTeuJMEpKxA+YY0pWSdfX9CNtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUmVpVWpEbD6iQPADznxgGdLVaUW9ooriZiMlOGmER52JQGatGXzGMNsYyjyYBZ+Y6jQXqKt5Xcp+/2Q6rQxagjHELcH3d6nAB1QrcOaQopqtxnjmvnvKgppVozuxuKS05yUlbqqxdmoimVTGG3/cC2fX6EI/SEfrp/D27T29RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=aQCzpUGO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c9376c4bddso262825485a.3
        for <cgroups@vger.kernel.org>; Fri, 16 May 2025 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1747411932; x=1748016732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6/foCbE5Wq0Xso6tyeNxk9D4GjTI97oBs1Ze76bf/1c=;
        b=aQCzpUGOd+T56w9lyD625mc7dy1W/0ceTp+YEw6l2f0JKmJkZ2R4Ml2vI4+yZCmuTY
         i5feY+L9Mdiy4ncasJkp7n98AYMQnv1NWnH8tBI94vqFEiBc+VYl8TGukbHxw2t0ZRCQ
         jeI2MQZvT/s4iL8NJXxCL4a4LixdL7+/nDYDFj9AQTNhhA1uTjJMn6Lkv/ofjFB6eoNr
         yWVPkbH4tSHZiHVHgACBUQpy7IQOB8Qu19FrPeJCJR7D8IcEUpHD723/5ntBrsok6Z2h
         q2D4wJ7iYJLsFkuV2CR3Poy9LzSr60QsU/i10cQDufr3nfQTIp5FAlFV2KP4tFKGW/Wp
         7hMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747411932; x=1748016732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/foCbE5Wq0Xso6tyeNxk9D4GjTI97oBs1Ze76bf/1c=;
        b=cpoZNY5aSDxI7KNE2ntQLjVIEWvm9mX1KJhskfUjNBeSYczYgHFxiTMZB2/sG8EV1z
         2P/EwpUlm/ZhJAvpBbPasSa6Rd2deuEy1cEzWFSTz9gSQiiRi43QFRE6T7qigxPYSmjh
         b0J+jzny+/B74oTOJvMw8KxY4xWSkdJG1WHUIs97hggfCbzulX4tNJEu62QXQoviDYze
         JprvUNIsx4rCbnasuRqSn0SfZuerZ+iUdeDYmeUDK04aIBO3kl7rCjO0r0GZ2jQHze7D
         P7chjxn3ckDM61jRNCPqad15xTtJyUFf/R8dMNMAZCT90DQ0VZyVXNiWFl4IgdQ5UtXf
         RYdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuI9XffhhoX1dbx7PucuYlRjLekyT0XlBvDdfPV6Pi0P+NZmqU27oTjxzgeImx+j82C7PVMymJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyV+BTrVy7RiiXNoO42KqMmFGFP6xA/VE15bOtofSLxuUt/LDqu
	MB3ga4JTeo7pjxRVqyLi1TS6/FqxcIhlYEGopl5nqvYgAiECjBEVjwbb7hMH89K/imdreNw6SpK
	MFT1zr2w=
X-Gm-Gg: ASbGncux0xqaxDtn3lUszzd8bkQZ6WcNMVgoYQP4kL4j1OM1cCQUMPulsZ3HeSxwmRW
	c6qTbqb4/gS8ndOO6OV36G843G7p4e7As098pbIw4REVAZ695kern7T0GFJcMCGb30zH9d3qMZO
	AmMxyY9RvPya5bMcS3DhYHAR1qkQsYOUtlpZZk7rPBZOJ/iDG+HQBQdRpvE7l8J/Uzw9u7HZNe3
	+GOx7wk0pXy53m4fpK+o6GMJiY+JE92AOZY1b9sFcSGkg5qOQhfAsHZYpyxJUCMxDBxUxU3GmVl
	jtjhyHUjA0bTK2xz0D6mU8YrwKaxpqjr1RQcm4DnAMzIl/i/2g==
X-Google-Smtp-Source: AGHT+IGSDDRQvoq5/KhBOed6CNzLZKnlfPZ3M2DWoplggEBng95wnrmjGCjJplI6E4lOaxAeG6aTgw==
X-Received: by 2002:a05:620a:3948:b0:7cd:145:d652 with SMTP id af79cd13be357-7cd46718966mr493753385a.12.1747411931648;
        Fri, 16 May 2025 09:12:11 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468ccd94sm132108585a.109.2025.05.16.09.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 09:12:10 -0700 (PDT)
Date: Fri, 16 May 2025 12:12:06 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Dave Airlie <airlied@gmail.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
	christian.koenig@amd.com, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>, simona@ffwll.ch
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
Message-ID: <20250516161206.GC720744@cmpxchg.org>
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>

On Thu, May 15, 2025 at 01:02:07PM +1000, Dave Airlie wrote:
> > I have to admit I'm pretty clueless about the gpu driver internals and
> > can't really judge how feasible this is. But from a cgroup POV, if you
> > want proper memory isolation between groups, it seems to me that's the
> > direction you'd have to take this in.
> 
> Thanks for this insight, I think you have definitely shown me where
> things need to go here, and I agree that the goal should be to make
> the pools and the shrinker memcg aware is the proper answer,
> unfortunately I think we are long way from that at the moment, but
> I'll need to do a bit more research.

Per-cgroup LRUs are quite common, so we have a lib to make this easy.

Take a look at <linux/list_lru.h>.

It provides a list type as a replacement for the bare struct
list_head, along with list_lru_add(), list_lru_del() helpers.

Call memcg_list_lru_alloc() before adding objects, this makes sure the
internal per-cgroup data structures are all set up.

list_lru_add()/del() take a memcg argument, so you have to work out
how you want to plumb that down. page->memcg still sounds easiest to
me. That doesn't mean you have to use __GFP_ACCOUNT, considering the
dma allocation path; You can always memcg_kmem_charge_page() them by
hand after the allocation is done, which will set up the backptr.

For the shrinker itself, there are list_lru_shrink_count() and
list_lru_shrink_walk() helpers which are designed to slot right into
the shrinker callbacks. You only have to implement the callback to
isolate an item - this is where the LRU specific locking and reclaim
rules live, but that should be straight forward in your case.

