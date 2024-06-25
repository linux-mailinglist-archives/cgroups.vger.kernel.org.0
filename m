Return-Path: <cgroups+bounces-3320-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5342D915AFB
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 02:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D688A283551
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876E8F6B;
	Tue, 25 Jun 2024 00:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qcg8yHOV"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618F184
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719275096; cv=none; b=kYDTJBR+Ev6ZbepIFyf5diCT8wHenUAEnb7yMUkLYIzdgGoMw2XVewecFfPUFPkMuU9LbIypu93KUz90+5PhQ9Khpj8v/YkAgj8+bN48iddjqnQsBLR9LiIx3Vj9Nyd2t/4sW70PUWzO2UcAdz6pY0lGtSVDONs/EBVZ+B3uyzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719275096; c=relaxed/simple;
	bh=V6n9UoQrqnvNOMNZzfRu9mSQ66iBYcPYlD317NrLQi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMwMfi4xfqIXepr3fPtGIwSG+ErkSsx299i/ojVnZgMVUY0hnkOWq3NuWOCpD2JnP1bS+XBG5NDpdJy5O5p8TITT85pAlSJDzv4I4wG6IMXW6pOLMTZqe+VIrtpOU1pB+QQpDICraoTYJZGKStST91uuDmluLQWz18JUETGb2EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qcg8yHOV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719275092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2moZ2Glg6y57KnBmKWYAK/r5HKxQT7IN4RKoSort1mM=;
	b=qcg8yHOVIwfj1BZuFo3XpbwpUp2gpjaSZq+Q2ZLalMZpf5u3SlYxuEemaqWgtzewiEppRv
	090np15xk9G5IIGbkxdzRxwp/9ie4v817vI70HdWpwEkT93tnv7tA3G69ynr08e/VyP8Cx
	+nfo46mZi30f9IWFZ/AFMOkLN7mRcgg=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 17:24:45 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <u3jrec5n42v35f3xiigfqabajjt4onh44eyfajewnzbfqxaekw@5x2daobkkbxh>
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
 <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
 <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tka0b52zm=SjqxO-gxc0XTib=81c7nMx9MFNttwVkCVmSg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 03:21:22PM GMT, Yosry Ahmed wrote:
> On Mon, Jun 24, 2024 at 3:17 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Mon, Jun 24, 2024 at 02:43:02PM GMT, Yosry Ahmed wrote:
> > [...]
> > > >
> > > > > There is also
> > > > > a heuristic in zswap that may writeback more (or less) pages that it
> > > > > should to the swap device if the stats are significantly stale.
> > > > >
> > > >
> > > > Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
> > > > zswap_shrinker_count()? There is already a target memcg flush in that
> > > > function and I don't expect root memcg flush from there.
> > >
> > > I was thinking of the generic approach I suggested, where we can avoid
> > > contending on the lock if the cgroup is a descendant of the cgroup
> > > being flushed, regardless of whether or not it's the root memcg. I
> > > think this would be more beneficial than just focusing on root
> > > flushes.
> >
> > Yes I agree with this but what about skipping the flush in this case?
> > Are you ok with that?
> 
> Sorry if I am confused, but IIUC this patch affects all root flushes,
> even for userspace reads, right? In this case I think it's not okay to
> skip the flush without waiting for the ongoing flush.

So, we differentiate between userspace and in-kernel users. For
userspace, we should not skip flush and for in-kernel users, we can skip
if flushing memcg is the ancestor of the given memcg. Is that what you
are saying?

