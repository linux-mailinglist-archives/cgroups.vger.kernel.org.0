Return-Path: <cgroups+bounces-3316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 457D19159B9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 00:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001E42814B1
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 22:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EB01A0B09;
	Mon, 24 Jun 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I+TG4H9c"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB771311A3
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267442; cv=none; b=OMnkDYVshD6DrfMSA+O+VFG3zipySxQQyETqfsiboYN3QNqBZzF5lEfwJFu3J1Fp4TeMMiG1sPGvilgUAvCyc/3XupAweiZbw43dw5D+01VsquIOKLWBMhksMJNQ7vbr+RWCP/U8J/XqUKMXa1NffxMT9K+Ta2ilCZeqQxIl4aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267442; c=relaxed/simple;
	bh=NT6cA6KjDCugKtO3qeTO6zfB8GvL66RPLKx07LsFz6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=autQJEPI39pMo969iyLsXbV0I3fwsPCD/eFD7MksPVfVfVPR/QwV7CQGqyifrFlonn+qrCRfS40eZZWUtW7I6rs1CM9nrbQAhZLD58TNM6Gpg8sY7CA5jjzHCeBm+M+LBrDBmiWY/TM4tsa6d7xwuci3UC9kB7GHGkbazz7oO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I+TG4H9c; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: yosryahmed@google.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719267436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cF2ZF/Oju8r/xjBGSIAsA4bK/JaHp2+f3Krx+7dOL9A=;
	b=I+TG4H9cP84dLOB+nQt/m9EfTS/6rGt7MSyyjzjJW0Lwc2VoHjA9Et/I17MtjPxDJetgWK
	o+vslW3n7U/+aciu+1h53iqrxWxn0tpMMlQDvOYnzxdct5gXwyI0Ag5p++2Bq77FKUeQ2f
	PXe9amVkTX/qt+zzl8wofD/kLCDJUkI=
X-Envelope-To: hawk@kernel.org
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 24 Jun 2024 15:17:11 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
Message-ID: <qolg56e7mjloynou6j7ar7xzefqojp4cagzkb3r6duoj5i54vu@jqhi2chs4ecj>
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com>
 <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
 <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
 <a45ggqu6jcve44y7ha6m6cr3pcjc3xgyomu4ml6jbsq3zv7tte@oeovgtwh6ytg>
 <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZT_2tyOFq5koK0djMXj4tY8BO3CtSamPb85p=iiXCgXQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 24, 2024 at 02:43:02PM GMT, Yosry Ahmed wrote:
[...]
> >
> > > There is also
> > > a heuristic in zswap that may writeback more (or less) pages that it
> > > should to the swap device if the stats are significantly stale.
> > >
> >
> > Is this the ratio of MEMCG_ZSWAP_B and MEMCG_ZSWAPPED in
> > zswap_shrinker_count()? There is already a target memcg flush in that
> > function and I don't expect root memcg flush from there.
> 
> I was thinking of the generic approach I suggested, where we can avoid
> contending on the lock if the cgroup is a descendant of the cgroup
> being flushed, regardless of whether or not it's the root memcg. I
> think this would be more beneficial than just focusing on root
> flushes.

Yes I agree with this but what about skipping the flush in this case?
Are you ok with that?

