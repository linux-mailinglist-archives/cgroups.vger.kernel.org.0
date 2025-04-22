Return-Path: <cgroups+bounces-7722-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EE3A96F2E
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 16:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4365616F1B9
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE57D28C5CA;
	Tue, 22 Apr 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m8wyn1wl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502855FB95;
	Tue, 22 Apr 2025 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333038; cv=none; b=OS81gdXBwVL3G9+g8O8i5EQ51EimdW1b3VqvrLAeU8mRlTa/C0R9fnMIkbe5JFKSTLXOilOG5lf22b2BTfZwg5eoDJwhIKc06X8qEI1ezxDIqB3tghLtLJoC7iMyLxQob+uTUU+5qvSaLKVBOa66RsZMQ5sI1oo04YpPKVRU52U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333038; c=relaxed/simple;
	bh=Cu0o5lEd9h4Wn/ZUEUPVlDg8GzdHiw+Q6L11D/K3XRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCV+6nccBw9WO3vdx2c+7TetsNbmr9waNN61Qg6Rzl1YwMCiS493x3vwn8oHpZv9FKEeryeW7//3KaKhjNlKxlA7iTMQlN660Ef8KoWZfw4H/EX6kzsQdvqJpAP3f7pJE81mMsqpT4w9tcyhkki6kHHlyfHceyG/XVyEfWhLy0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m8wyn1wl; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 07:43:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745333024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eGqWvARWPbzlJGTq79GPwsMrSwFqx/NHQqtKgiIKvSM=;
	b=m8wyn1wlQGqXXwq/vo89jTgaUiWlR+8kWRJf6auVIYA5RKwT5xpx3fcS7ggvw/01cD/xS6
	GR3o024+UL948xQMC/o26bfT1yU8NgmULUOShTAvVdsdkcWYAX6fnrAZCm9MgV4lIbgn5O
	wDofZVNbVeu4BnjNVq8svdEuy+RQr4c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org,
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, len.brown@intel.com,
	chengming.zhou@linux.dev, chrisl@kernel.org,
	huang.ying.caritas@gmail.com, ryan.roberts@arm.com,
	viro@zeniv.linux.org.uk, baohua@kernel.org, osalvador@suse.de,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu,
	pavel@kernel.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
Message-ID: <aAerGq2nW3D0jDaV@Asmaa.>
References: <20250407234223.1059191-1-nphamcs@gmail.com>
 <CAMgjq7CdARdTEZB3ik4X9cAzNUFa6GRqjT61brygihGUYFBAeQ@mail.gmail.com>
 <CAKEwX=M5y4yoW62U5GkHTxaDaD7UOJu_sgkkwNXJ5Hn4Gvot9g@mail.gmail.com>
 <CAMgjq7D9Z=u2J18DExmzeU8fRbvqNwyC3tem2aykAsm79=QGEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7D9Z=u2J18DExmzeU8fRbvqNwyC3tem2aykAsm79=QGEA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 09, 2025 at 12:59:24AM +0800, Kairui Song wrote:
> On Wed, Apr 9, 2025 at 12:48 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Tue, Apr 8, 2025 at 9:23 AM Kairui Song <ryncsn@gmail.com> wrote:
> > >
> > >
> > > Thanks for sharing the code, my initial idea after the discussion at
> > > LSFMM is that there is a simple way to combine this with the "swap
> > > table" [1] design of mine to solve the performance issue of this
> > > series: just store the pointer of this struct in the swap table. It's
> > > a bruteforce and glue like solution but the contention issue will be
> > > gone.
> >
> > Was waiting for your submission, but I figured I should send what I
> > had out first for immediate feedback :)
> >
> > Johannes actually proposed something similar to your physical swap
> > allocator for the virtual swap slots allocation logic, to solve our
> > lock contention problem. My apologies - I should have name-dropped you
> > in the RFC cover as well (the cover was a bit outdated, and I haven't
> > updated the newest developments that came from the LSFMMBPF
> > conversation in the cover letter).
> >
> > >
> > > Of course it's not a good approach, ideally the data structure can be
> > > simplified to an entry type in the swap table. The swap table series
> > > handles locking and synchronizations using either cluster lock
> > > (reusing swap allocator and existing swap logics) or folio lock (kind
> > > of like page cache). So many parts can be much simplified, I think it
> > > will be at most ~32 bytes per page with a virtual device (including
> > > the intermediate pointers).Will require quite some work though.
> > >
> > > The good side with that approach is we will have a much lower memory
> > > overhead and even better performance. And the virtual space part will
> > > be optional, for non virtual setup the memory consumption will be only
> > > 8 bytes per page and also dynamically allocated, as discussed at
> > > LSFMM.
> >
> > I think one problem with your design, which I alluded to at the
> > conference, is that it doesn't quite work for our requirements -
> > namely the separation of zswap from its underlying backend.
> >
> > All the metadata HAVE to live at the virtual layer. For once, we are
> > duplicating the logic if we push this to the backend.
> >
> > But more than that, there are lifetime operations that HAVE to be
> > backend-agnostic. For instance, on the swap out path, when we unmap
> > the page from the page table, we do swap_duplicate() (i.,e increasing
> > the swap count/reference count of the swap entries). At that point, we
> > have not (and cannot) make a decision regarding the backend storage
> > yet, and thus does not have any backend-specific places to hold this
> > piece of information. If we couple all the backends then yeah sure we
> > can store it at the physical swapfile level, but that defeats the
> > purpose of swap virtualization :)
> 
> Ah, now I get why you have to store the data in the virtual layer.
> 
> I was thinking that doing it in the physical layer will make it easier
> to reuse what swap already has. But if you need to be completely
> backend-agnostic, then just keep it in the virtual layer. Seems not a
> foundunmentail issue, it could be worked out in some way I think. eg.
> using another table type. I'll check if that would work after I've
> done the initial parts.

Watching from the sidelines, I am happy to see Nhat's proposal
materializing, and think there is definitely room for collaboration here
with Kairui's. Overall, both proposals seem to be complimentary
concepts, and we just need to figure out the right way to combine them
:)

