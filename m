Return-Path: <cgroups+bounces-8647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EEAAEBF81
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 21:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63A1F56534B
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3155B202C48;
	Fri, 27 Jun 2025 19:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TVlierNB"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA18209F45
	for <cgroups@vger.kernel.org>; Fri, 27 Jun 2025 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751051668; cv=none; b=dJ/7wa6xelUcelcZI9LMZay0h4FVW5BYj8WswZk0Uaivcahi4tcTFR+cnjRwp1WeBJAc1KFbsst/g52MfGIa0TtHZ6qaahDQE3PgFDkwGVaqyYTu9qc3IiDeivdOYpLWlL6F12/i7X7jsdGICXgb4e3CakqTwBYEW98+pFKn+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751051668; c=relaxed/simple;
	bh=aMXiCGYatSYu8LabWvU1Yv+2gjTp+V8QRzixzcFBnVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7T2TSud63t4+UACYrXK2Mva7COXqLP2LgiPk6cEOucpUiu1J+3Z9b1ZwlxxaiHw61d3lWgduF8PUH0NAVX2fNZ5lxsloRrerHsDuP3xKPKhrld8BtMu2PoKGb5KIv9syFpa7MDskHgtfCAPhIhnTXiD8rEtG9Nzoo1uFJvZM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TVlierNB; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Jun 2025 12:14:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751051653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ4E07hhGNy4W9XkbKFt8clyjUYqy4CKRl6nAq2dZWw=;
	b=TVlierNBVW0hk2uG4e4Hfd2RJEOyJ1xHNvKYwESP/Z3WLhH4ziqomfaXtukklglcCLtBVG
	mGOAL9R2nU0qDRaH71npFYP36DufqumXe/5KuAZcDz3cszljWBSxVl0RHAW2mOtn2K5HlR
	85eYSCG6B2JhnQ8CCFnxdz+XRscwgqA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org, mhocko@kernel.org, akpm@linux-foundation.org, 
	david@fromorbit.com, zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com, 
	apais@linux.microsoft.com, yuzhao@google.com
Subject: Re: [PATCH RFC 00/28] Eliminate Dying Memory Cgroup
Message-ID: <lnrtyl66sz6iiw74mf6nurcm5tqmsyecnbmhrlouswp6kgfyqi@umvk6uxb3y7h>
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <CAMgjq7BAfh-op06++LEgXf4UM47Pp1=ER+1WvdOn3-6YYQHYmw@mail.gmail.com>
 <F9BDE357-C7DA-4860-A167-201B01A274FC@linux.dev>
 <CAMgjq7D+GXce=nTzxPyR+t6YZSLWf-8eByo+0NpprQf61gXjPA@mail.gmail.com>
 <aAF2eUG26_xDYIDU@google.com>
 <CAMgjq7BNUMFzsFCOt--mvTqSmgdA65PWcn57G_6-gEj0ps-jCg@mail.gmail.com>
 <5f622eec-a039-4e82-9f37-3cad1692f268@huaweicloud.com>
 <CAMgjq7ASpGjJme4OwHu+=ys95W4jNZaJd3Yn9t2cL-qeCs4W-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7ASpGjJme4OwHu+=ys95W4jNZaJd3Yn9t2cL-qeCs4W-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jun 28, 2025 at 02:54:10AM +0800, Kairui Song wrote:
> On Fri, Jun 27, 2025 at 5:02 PM Chen Ridong <chenridong@huaweicloud.com> wrote:
> > On 2025/4/28 11:43, Kairui Song wrote:
> > > On Fri, Apr 18, 2025 at 5:45 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >>
> > >> On Fri, Apr 18, 2025 at 02:22:12AM +0800, Kairui Song wrote:
> > >>>
> > >>> We currently have some workloads running with `nokmem` due to objcg
> > >>> performance issues. I know there are efforts to improve them, but so
> > >>> far it's still not painless to have. So I'm a bit worried about
> > >>> this...
> > >>
> > >> Do you mind sharing more details here?
> > >>
> > >> Thanks!
> > >
> > > Hi,
> > >
> > > Sorry for the late response, I was busy with another series and other works.
> > >
> > > It's not hard to observe such slow down, for example a simple redis
> > > test can expose it:
> > >
> > > Without nokmem:
> > > redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> > > SET: 16393.44 requests per second, p50=0.055 msec
> > > GET: 16956.34 requests per second, p50=0.055 msec
> > >
> > > With nokmem:
> > > redis-benchmark -h 127.0.0.1 -q -t set,get -n 80000 -c 1
> > > SET: 17263.70 requests per second, p50=0.055 msec
> > > GET: 17410.23 requests per second, p50=0.055 msec
> > >
> > > And I'm testing with latest kernel:
> > > uname -a
> > > Linux localhost 6.15.0-rc2+ #1594 SMP PREEMPT_DYNAMIC Sun Apr 27
> > > 15:13:27 CST 2025 x86_64 GNU/Linux
> > >
> > > This is just an example. For redis, it can be a workaround by using
> > > things like redis pipeline, but not all workloads can be adjusted
> > > that flexibly.
> > >
> > > And the slowdown could be amplified in some cases.
> >
> > Hi Kairui,
> >
> > We've also encountered this issue in our Redis scenario. May I confirm
> > whether your testing is based on cgroup v1 or v2?
> >
> > In our environment using cgroup v1, we've identified memcg_account_kmem
> > as the critical performance bottleneck function - which, as you know, is
> > specific to the v1 implementation.
> >
> > Best regards,
> > Ridong
> 
> Hi Ridong
> 
> I can confirm I was testing using Cgroup V2, and I can still reproduce
> it, it seems the performance gap is smaller with the latest upstream
> though, but still easily observable.
> 
> My previous observation is that the performance drain behaves
> differently with different CPUs, my current test machine is an Intel
> 8255C. I'll do a more detailed performance analysis of this when I
> have time to work on this. Thanks for the tips!

Please try with the latest upstream kernel i.e. 6.16 as the charging
code has changed a lot.

