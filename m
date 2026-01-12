Return-Path: <cgroups+bounces-13108-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1ABD15D11
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 00:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BB1F30217B7
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 23:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5283D2BD5B4;
	Mon, 12 Jan 2026 23:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="nKYxL5EI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37FA238178
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768260835; cv=none; b=Yu3ZIMnGidCIiJzMglzenZw3wCqA6yFt5OwWMMhg7fK50Jo11q/rCT68yvwIUXx2zMe1/jQ5hedQp2UEOT0eLw3uGT7cK9njQJk/J2FfGi65tvH5OhyTDBTRq1RdmcSo0OKUfhbnXGxWVkhOzpNczgt0FkvJdkiYyqxqEaGCy7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768260835; c=relaxed/simple;
	bh=qpnYu3RZu0npDqni/vDmcAtbszwl3elDVt5O1kmcSag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IiYp+GX/CP/Qt2kV0l76iCaaVYu8fQzsYO7XhBeby09epNL/FmB5uWqR6yl2Kbs5VG7KU+Qx6NMiWrWWIZ15elr4o9W5S5Pbr0MknuWtjFZaLZzJGFbTJUENbS/QNfnSynABxo0RJJNfWhqvzCnfoJ+2/4NelJTbgdjBjNbdIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=nKYxL5EI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b25dd7ab33so529264785a.1
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 15:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1768260832; x=1768865632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVpfFj6hka/DJY/5ODmGKfI4Kx1XNOYSlSR7awzDNx4=;
        b=nKYxL5EIxU2v+iCB19kwQQnOy+vW24/Xw/AzrtkM7mHG4L951O3bqaGLbTCqUFDoCh
         YH1IZBV0wXrTOSAL94et7/ozyxHm2eqzKB2Srl3801JeNeZH1ymx86ZNbGa5mSZxITIS
         vwQiuefAmVfzXF6i4RD0ieE1UQiBUE2rV4S64786DvejfgJDvhKqu+ZfkUK6iUYuOIQ/
         af5nlTC1rXSxZrYVjpsKxr+yJKpo8Zogc7u+CdBgVHeNV1tCV7oAgFvemLFUKWXiZmGq
         Wz6CgOX8n933hCxmuiqRQlBgSGtMjgqq+vbvUVwv1ghjpbUjJnJrxdousHrE+pbQcdJc
         JpEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768260832; x=1768865632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVpfFj6hka/DJY/5ODmGKfI4Kx1XNOYSlSR7awzDNx4=;
        b=gkf3g2CQPhKbqk5Mmsw79t2tLueUYa4hgqqm/96x/K8CpjVwCxBj9GXVTW+2jsv+ih
         foaudomVKtWegHHNhJzC5ac4uwIaJ2wV311phx6E+WcyWgPU1g3zx7uogU57PQrI1Wdf
         znMP0FmpmHFuBqOBusUTKzTyQfUNfXfxFRqrTCNfbIvPSAovHj7a4a1UcHvBfrGu/sXo
         PGyYZP89FAYs9ITuva38OvsNDkTnvpSM5TB/oCPHTgL+Wf795wlbZo18WDsJ9zqJOLyp
         4gxWu5ZQQIulN422Q22IZAMaIznu4PCK26KvqhKsyex5NZHMapSpBH4thtosO4q33la3
         3+Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXd6rMEGakRvhhedQy3Vh1vWiHqQ+u2uFvNnd0Nax98GKQ2sbeRoIC9l5YmqbUiae6nCQY1ilQc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/RzUFIkbX195I3/c04SDKvDEOGBn8bkQou5eX2J3JP0qigFmi
	ezeDJHYcVMPSl7W8JkEgfNyztEVSqXZNeVboZN6v6EvGlT1MxE2aTquJKMvNw7t6GRA=
X-Gm-Gg: AY/fxX7WzJbfnfzcOUJbDnuQXCRtDvnF4u3Z+WrPTvb+FLlRIyXJi5RCRv9fJq5nkvM
	FU/aDZ94nU6VQddZ2EWB9KqAduBPh4xl1sKQH2XzjJ7OnQRSvNOxBR7tzghE0WCQdg1AyZB8O09
	TmE/KKP/xVtGDkXPyu2CaHKHbm+yKAhk8AU2Ba2w+r4Nj2VkWGnYcBJfLX8wSQx/lYqLbASAwd1
	6jChR4EwouZR7u1RSu6TXmoEdtWgWgEcNA+G3aVV4RX4SE7xuEL5IdW9Axq8GfHaX/pX3a/HsTy
	hkTAcuEnjtbglfG2l1dK7mkG5XVYnIAhDDs9FA/zx0JR4u9DzK1dULUrgWTul6PWsgicTzeXF6q
	4jlRKOtT3Dy4cT3sE+0lD8ZIVUS8rJmDvJd6W71wODaOS8AYwKBeRPXtUGboj0uYK+kXrA0IkXv
	jtTroZ1ucST11PLerZ1drOyitk/VjE3PTWGQa6+cRJdcoMzdxh5gt2SimXXHQKEFjJIxz8VA==
X-Google-Smtp-Source: AGHT+IHMBCCAecFcwqDPXZCmjtmCZLckRO4RmA0iVdHt93P2StieqUO9Nzjvt39n7Nz2NJh9b9wqbQ==
X-Received: by 2002:a05:620a:690d:b0:8b3:83b:6e9c with SMTP id af79cd13be357-8c38940e5efmr2586340785a.90.1768260831556;
        Mon, 12 Jan 2026 15:33:51 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4b92a0sm1574077885a.13.2026.01.12.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 15:33:50 -0800 (PST)
Date: Mon, 12 Jan 2026 18:33:16 -0500
From: Gregory Price <gourry@gourry.net>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org,
	mkoutny@suse.com, corbet@lwn.net, gregkh@linuxfoundation.org,
	rafael@kernel.org, dakr@kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com,
	david@kernel.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, rppt@kernel.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, yury.norov@gmail.com,
	linux@rasmusvillemoes.dk, rientjes@google.com,
	shakeel.butt@linux.dev, chrisl@kernel.org, kasong@tencent.com,
	shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com,
	baohua@kernel.org, chengming.zhou@linux.dev,
	roman.gushchin@linux.dev, muchun.song@linux.dev, osalvador@suse.de,
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	cl@gentwo.org, harry.yoo@oracle.com, zhengqi.arch@bytedance.com
Subject: Re: [RFC PATCH v3 7/8] mm/zswap: compressed ram direct integration
Message-ID: <aWWEvAaUmpA_0ERP@gourry-fedora-PF4VCD3F>
References: <20260108203755.1163107-1-gourry@gourry.net>
 <20260108203755.1163107-8-gourry@gourry.net>
 <i6o5k4xumd5i3ehl6ifk3554sowd2qe7yul7vhaqlh2zo6y7is@z2ky4m432wd6>
 <aWF1uDdP75gOCGLm@gourry-fedora-PF4VCD3F>
 <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ftthovin57fi4blr2mardw4elwfsiv6vrkhrjqjsfvvuuugjj@uivjc5uzj5ys>

On Mon, Jan 12, 2026 at 09:13:26PM +0000, Yosry Ahmed wrote:
> On Fri, Jan 09, 2026 at 04:40:08PM -0500, Gregory Price wrote:
> > On Fri, Jan 09, 2026 at 04:00:00PM +0000, Yosry Ahmed wrote:
> > > On Thu, Jan 08, 2026 at 03:37:54PM -0500, Gregory Price wrote:
> > 
> > Hardware Says : 8GB
> > Hardware Has  : 1GB
> > Node Capacity : 8GB
> > 
> > The capacity numbers are static.  Even with hotplug, they must be
> > considered static - because the runtime compression ratio can change.
> > 
> > If the device fails to achieve a 4:1 compression ratio, and real usage
> > starts to exceed real capacity - the system will fail.
> > (dropped writes, poisons, machine checks, etc).
> > 
> > We can mitigate this with strong write-controls and querying the device
> > for compression ratio data prior to actually migrating a page. 
> 
> I am a little bit confused about this. Why do we only need to query the
> device before migrating the page?
>

Because there is no other interposition point at which we could.
Everything is memory semantic - it reduces to memcpy().

The actual question you're asking is "What happens if we write the page
and we're out of memory?"

The answer is:  The page gets poisoned and the write gets dropped.

That's it.  The writer does not get notified.  The next reader of that
memory will hit POISON and the failure process will happen (MCE or
SIGBUS, essentially).

> Are we checking if the device has enough memory for the worst case
> scenario (i.e. PAGE_SIZE)?
> 
> Or are we checking if the device can compress this specific page and
> checking if it can compress it and store it? This seems like it could be
> racy and there might be some throwaway work.
> 

We essentially need to capture the current compression ratio and
real-usage to determine whether there's another page available.

It is definitely racey, and the best we can do is set reasonable
real-memory-usage limits to prevent ever finding ourselves in that
scenario.  That most likely means requiring the hardware send an
interrupt when usage and/or ratio hit some threshhold and setting a
"NO ALLOCATION ALLOWED" bit.

But in software we can also try to query/track this as well, but we may
not be able to query the device at allocation time (or at least that
would be horribly non-performant).

So yeah, it's racy.

> I guess my question is: why not just give the page to the device and get
> either: successfully compressed and stored OR failed?
> 

Yeah this is what I meant by this whole thing being sunk into the
callback.  I think that's reasonable.

> Another question, can the device or driver be configured such that we
> reject pages that compress poorly to avoid wasting memory and BW on the
> device for little savings?
> 

Memory semantics :]

memcpy(dst, src) -> no indication of compression ratio

> > on *write* access:
> > - promote to real page
> > - clean up the compressed page
> 
> This makes sense. I am assuming the main benefit of zswap.c over cram.c
> in this scenario is limiting read accesses as well.
>

For the first go, yeah.  A cram.c would need special page table handling
bits that will take a while to get right.  We can make use of the
hardware differently in the meantime.

> > --- assuming there isn't a way and we have to deal with fuzzy math ---
> > 
> > The goal should definitely be to leave the charging statistics the same
> > from the perspective of services - i.e zswap should charge a whole page,
> > because according to the OS it just used a whole page.
> > 
> > What this would mean is memcg would have to work with fuzzy data.
> > If 1GB is charged and the compression ratio is 4:1, reclaim should
> > operate (by way of callback) like it has used 256MB.
> > 
> > I think this is the best you can do without tracking individual pages.
> 
> This part needs more thought. Zswap cannot charge a full page because
> then from the memcg perspective reclaim is not making any progress.
> OTOH, as you mention, from the system perspective we just consumed a
> full page, so not charging that would be inconsistent.
> 
> This is not a zswap-specific thing though, even with cram.c we have to
> figure out how to charge memory on the compressed node to the memcg.
> It's perhaps not as much of a problem as with zswap because we are not
> dealing with reclaim not making progress.
>
> Maybe the memcg limits need to be "enlightened" about different tiers?
> We did have such discussions in the past outside the context of
> compressed memory, for memory tiering in general.
> 
> Not sure if this is the right place to discuss this, but I see the memcg
> folks CC'd so maybe it is :)
>

I will probably need some help to get the accounting right if I'm being
honest.  I can't say I fully understanding the implications here, but
what you describe makes sense.

One of the assumptions you have in zswap is that there's some known
REAL chunk of memory X-GB, and the compression ratio dictates that you
get to cram more than X-GB of data in there.

This device flips that on its head.  It lies to the system and says
there's X-GB, and you can only actually use a fraction of it in the
worst case - and in the best case you use all of it.

So in that sense, zswap has "infinite upside" (if you're infinitely
compressible), whereas this device has "limited upside" (node capacity).

That changes how you account for things entirely, and that's why
entry->length always has to be PAGE_SIZE.  Even if the device can tell
us the real size, i'm not sure how useful that is - you still have to
charge for an entire `struct page`.

Time for a good long :think:

> > 
> > This is ignorance of zswap on my part, and yeah good point.  Will look
> > into this accounting a little more.
> 
> This is similar-ish to the memcg charging problem, how do we count the
> compressed memory usage toward the global zswap limit? Do we keep this
> limit for the top-tier? If not, do we charge full size for pages in
> c.zswap or compressed size?
> 
> Do we need a separate limit for c.zswap? Probably not if the whole node
> is dedicated for zswap usage.
>

Since we're accounting for entire `struct page` usage vs the hard cap of
(device_capcity / PAGE_SIZE) - then this might actually be the answer.

> > 
> > Thank you again for taking a look, this has been enlightening.  Good
> > takeaways for the rest of the N_PRIVATE design.
> 
> Thanks for kicking off the discussion here, an interesting problem to
> solve for sure :)
> 

One of the more interesting ones i've had in a few years :]

Cheers,
~Gregory

