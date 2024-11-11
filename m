Return-Path: <cgroups+bounces-5507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E529C3867
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 07:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD222822B9
	for <lists+cgroups@lfdr.de>; Mon, 11 Nov 2024 06:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706D155382;
	Mon, 11 Nov 2024 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lqtL6g/7"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2715533B
	for <cgroups@vger.kernel.org>; Mon, 11 Nov 2024 06:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731306821; cv=none; b=BzfW9l2HPiFeRmX3DrnAwz855wdolhjE9MbkBM41NBY07n7ceTQrBX6IoznTFsUtRrqyKV9UrujwtlgB/qxqGpfyBYP13gsLnBoKIboT+c2n4zn5uaWX5l8CjFrX741wbpC5gpr+vQ7G74dFzTnrwRUN3LnJeS0mcKwnfI2LyBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731306821; c=relaxed/simple;
	bh=kg4wl0nXIq8UecxKELEvzyC/I4i08MWy8Wb3vXbfB0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NARAI7D78d0KSkOg24aLVHywzcm8QC6jywzyAu8SWEZha4VYppdFcfbxbAJCLqSfqzVCE4MEZKBZejkmj4GiJgD4g7hfa/u2jcMHRJZ4UExZJE1g702kBGJ4WyWzMfbIlajLs9s9NzLiH/x3YYgMLO6U+njWt3oH1GVEywXD2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lqtL6g/7; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 10 Nov 2024 22:33:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731306816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X/MVBgEHJ44Ez5PPP0jKD7akI1JfToDyS0gIR7NVZiU=;
	b=lqtL6g/7LKpANkQ22HN8NMcNyIyxrkUBsHIOtBAkoLfYHxjoMT1TuCCV6mDpMe132sO9rB
	8eP8A1RhzbqI1jlPCcceRMomea+mTsXtuPWCBzNU+FdlxHaqsIiVd7pOSea0N0ge4bo9FV
	IeJDshKG0gomRma/l63v30/N4CrjD8I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	muchun.song@linux.dev, akpm@linux-foundation.org, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 2/3] memcg/hugetlb: Introduce mem_cgroup_charge_hugetlb
Message-ID: <ixzlkkcvyrve3huslaqawvtxypih42673pa33b6cxflbqi6j7h@n4c76k4xmsg5>
References: <20241108212946.2642085-1-joshua.hahnjy@gmail.com>
 <20241108212946.2642085-3-joshua.hahnjy@gmail.com>
 <kpxl646zwhqcyrq23kfnslqdjgqy5s72vlq2uoc6vhfvwza2ld@yjyj3j6rnlag>
 <CAN+CAwN34zQdjuOhH0Vm0k6=im9=vVvwH_yCh_z4zvuMzPSjTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN+CAwN34zQdjuOhH0Vm0k6=im9=vVvwH_yCh_z4zvuMzPSjTg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Nov 09, 2024 at 01:58:46PM -0500, Joshua Hahn wrote:
[...]
> 
> > > +             free_huge_folio(folio);
> >
> > free_huge_folio() will call lruvec_stat_mod_folio() unconditionally but
> > you are only calling it on success. This may underflow the metric.
> 
> I was actually thinking about this too. I was wondering what would
> make sense -- in the original draft of this patch, I had the charge
> increment be called unconditionally as well. The idea was that
> even though it would not make sense to have the stat incremented
> when there is an error, it would eventually be corrected by
> free_huge_folio's decrement. However, because there is nothing
> stopping the user from checking the stat in this period, they may
> temporarily see that the value is incremented in memory.stat,
> even though they were not able to obtain this page.
> 

On the alloc path, unconditionally calling lruvec_stat_mod_folio() after
mem_cgroup_charge_hugetlb() but before free_huge_folio() is fine. Please
note that if mem_cgroup_charge_hugetlb() has failed,
lruvec_stat_mod_folio() will not be incrementing the memcg stat. The
system level stats may get elevated for small time window but that is
fine.

> With that said, maybe it makes sense to increment unconditionally,
> if free also decrements unconditionally. This race condition is
> not something that will cause a huge problem for the user,
> although users relying on userspace monitors for memory.stat
> to handle memory management may see some problems.
> 
> Maybe what would make the most sense is to do both
> incrementing & decrementing conditionally as well.
> Thank you for your feedback, I will iterate on this for the next version!
> 
> > > +int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
> > > +{
> > > +     struct mem_cgroup *memcg = get_mem_cgroup_from_current();
> > > +     int ret = 0;
> > > +
> > > +     if (mem_cgroup_disabled() || !memcg_accounts_hugetlb() ||
> > > +             !memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys)) {
> > > +             ret = -EOPNOTSUPP;
> >
> > why EOPNOTSUPP? You need to return 0 here. We do want
> > lruvec_stat_mod_folio() to be called.
> 
> In this case, I was just preserving the original code's return statements.
> That is, in mem_cgroup_hugetlb_try_charge, the intended behavior
> was to return -EOPNOTSUPP if any of these conditions were met.
> If I understand the code correctly, calling lruvec_stat_mod_folio()
> on this failure will be a noop, since either memcg doesn't account
> hugetlb folios / there is no memcg / memcg is disabled.
> 

lruvec_stat_mod_folio() does manipulate system level stats, so even if
memcg accounting of hugetlb is not enabled we do want system level stats
get updated.


