Return-Path: <cgroups+bounces-3765-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020EC934995
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 10:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C621F23785
	for <lists+cgroups@lfdr.de>; Thu, 18 Jul 2024 08:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4278C9D;
	Thu, 18 Jul 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzWi95UD"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED99768EE
	for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290175; cv=none; b=PpzcMZFHw+JixLdQz4BEVzEDQEuSdjj4JxazFS+bH9S2kClZtQJQ5aVkF2w8iPo9cugCwvQHjHhDFuQctL5NF3HnLv+iUVl+gURrGHeAXirqz5w81sXQD5ZT0NawTSb+Y1+d3RQq1nuGmFoIB3ttEEfXXPKzSV5AxVRjtZ6ElMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290175; c=relaxed/simple;
	bh=TDYm5PZVfZHPLUELKTZw/I1/ewmmqaWyG3B3esIwX0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIigiqJguXgBzr2ochEF7F/zZljQLJkS96wmtXFkSprOlpD9MukOxDZdJQXT8F0rSDn4HfFA3w5XDZx4SCr4/ZAmTgy37nOyCHJUjtQqvhqNILQMWBiob6gKKmLIAiZeXPykXVdVFdobJ93Jlix3zwxY2mZxUbxYu1OT85NjfZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TzWi95UD; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ea0f18500so23250e87.3
        for <cgroups@vger.kernel.org>; Thu, 18 Jul 2024 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721290171; x=1721894971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=TzWi95UDhOtfJrxTJ5O+Dqqgm7t96Pc5jM2LjfuDMEw5ZIp8ZH7WwMEf53WZX+v4jw
         18dE6qLgUDCwxrpLVrXFT5w6EZoWaAZSQIbz8SIUKLom0chLcEZ1q5xfV4auELrX/OlS
         gtWyu9mYI2+S4y0mGlPfCjScFxZlkq8rCzN/GH4pMR9RVEHvcijtDpfU8SAmAlumSNxv
         pjQANwSnQk9d8Yje15uzxtkzfISwceeIBI/mmrwUIFhgfXbTcsoYCnAkGioFvRcgxXvF
         q7SfeVyH7ZQaYzE50UxQDYBxOkWlWTC0kCpgFDhucYnBObJKUcYKGFThSZTGXeKZyp56
         Ml2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290171; x=1721894971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXMh51KVDkJmQr+NxLPzI9t9Kwi4FwG+tK/QlWBahKs=;
        b=eyt6z8wxJ5RY4bPnVzZGPZFDADIFeA+Q8yMyGJ8z2qoT45Oedg/YC0Ef4bZ46OOfRa
         fE3L4r0M/9rjNbS285F867KPbaJiWPIWHH6mKHSkXnmhTp9Q4qrPOM9OVOJ5wRZkDsgt
         b7dqN2SIPoJ56JnA3oVZnDl4SqvBCYsSSLLOTR+Zczj1MUwc6h/nxHYNn21vg/f0qf16
         vtZ3E+DJW0OCGAYgE0Z6p2QkYpNp5NlI5pv9MUjTS1fERD9uCWIKoLTPOjIh5OX2MWUZ
         Tn0g68jdF2WSun+odeMnWlDXMT9YaH9jtQ6d0acBRWlpIMzTBC4IArmUfDmIYvHi7UML
         IbLA==
X-Forwarded-Encrypted: i=1; AJvYcCU57yU+1VMUuDIwIZnwwzyQZhjJnTFLijzEh5yqjbr7JTo9aYBd4V2KA1g5pGHgIePUUSmJSE36YuC8SMNWONnH73Ag6K8Qeg==
X-Gm-Message-State: AOJu0Yxj+RVh0QN0rupL5lqMAEjF5/qs78QiJripVQm/YbtRhBgEGGHz
	VRkOmjXN6p/GYeiCJqo8HqU4jR9HmnMCe8wSbmtX5+nYYpYRUSH/ardv7SEJ3do=
X-Google-Smtp-Source: AGHT+IGegX6hhcdBy2hHYfDBsDRJkiHBdAAF1OXnxmmpbPiUGv7h+8z8jYIwpVOTdMuMRgTCMfHFxQ==
X-Received: by 2002:a05:6512:3c93:b0:52e:7f6b:5786 with SMTP id 2adb3069b0e04-52ee543f25emr2769637e87.61.1721290170831;
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff9fbsm531461866b.154.2024.07.18.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 01:09:30 -0700 (PDT)
Date: Thu, 18 Jul 2024 10:09:29 +0200
From: Michal Hocko <mhocko@suse.com>
To: Qu Wenruo <wqu@suse.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjNuWpzH9NC5ni6@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
 <ZpjDeSrZ40El5ALW@tiehlicka>
 <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <304fdaa9-81d8-40ae-adde-d1e91b47b4c0@suse.com>

On Thu 18-07-24 17:27:05, Qu Wenruo wrote:
> 
> 
> 在 2024/7/18 16:55, Michal Hocko 写道:
> > On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> > > On 7/18/24 12:38 AM, Qu Wenruo wrote:
> > [...]
> > > > Does the folio order has anything related to the problem or just a
> > > > higher order makes it more possible?
> > > 
> > > I didn't spot anything in the memcg charge path that would depend on the
> > > order directly, hm. Also what kernel version was showing these soft lockups?
> > 
> > Correct. Order just defines the number of charges to be reclaimed.
> > Unlike the page allocator path we do not have any specific requirements
> > on the memory to be released.
> 
> So I guess the higher folio order just brings more pressure to trigger the
> problem?

It increases the reclaim target (in number of pages to reclaim). That
might contribute but we are cond_resched-ing in shrink_node_memcgs and
also down the path in shrink_lruvec etc. So higher target shouldn't
cause soft lockups unless we have a bug there - e.g. not triggering any
of those paths with empty LRUs and looping somewhere. Not sure about
MGLRU state of things TBH.
 
> > > > And finally, even without the hang problem, does it make any sense to
> > > > skip all the possible memcg charge completely, either to reduce latency
> > > > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?
> > 
> > Let me just add to the pile of questions. Who does own this memory?
> 
> A special inode inside btrfs, we call it btree_inode, which is not
> accessible out of the btrfs module, and its lifespan is the same as the
> mounted btrfs filesystem.

But the memory charge is attributed to the caller unless you tell
otherwise. So if this is really an internal use and you use a shared
infrastructure which expects the current task to be owner of the charged
memory then you need to wrap the initialization into set_active_memcg
scope.

-- 
Michal Hocko
SUSE Labs

