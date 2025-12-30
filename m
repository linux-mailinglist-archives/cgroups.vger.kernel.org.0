Return-Path: <cgroups+bounces-12823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC2CCEA7B6
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 19:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D43C302106F
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482632D42F;
	Tue, 30 Dec 2025 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="exi8BjG6"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758E280018
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 18:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767119837; cv=none; b=Am6BFx0YmVqvwXuPFKBDPLkbVRmjFscV5EXDbSWHrSKtvxbCQ33fVkZdObYk4oizzGCy3YhaXpiageygrELyUqbjobOK3q9qzonRZOS+ziERgvkfR2PZcGTF0q0PZq50MkACqJal5R13DhASzXSGHjPzjQjm9kvjbKrrokRKOEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767119837; c=relaxed/simple;
	bh=QOJhMF4lzAapHdropIS7nrDjbe1/XWhek1LeyLB/p1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFna3LU59TuoFOzgWH0dC5D0cej40EaE8uIcEj5cQJE4T6wD1EjXavruW92mqUT8JGBmsLPDrqneQAokXlriSyPk6xZxjPtV+O3RakPT8zfMGM5HGVJ8L31fl44NrTH0pwc8TocrzLjDlfsXzBRdODcIZuk83T6WCZAPDQl96Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=exi8BjG6; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 30 Dec 2025 10:36:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767119833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WjKuCchTH1xnyesy5Y7W++gREJWVmWR7Q8qqs0R1xXM=;
	b=exi8BjG6MQu3+rZ3ssu9K/wV7Ggm35Z/xgkj/Ygcat2a6gCtsQ4+VMYdr0NdcCzhdQLQk5
	VSdEnqTY1Z027iP3CE735hgw+CeARkDFIGpikjMGWkdwdDVoQkv1CB/89ox7eKdp/xfonT
	JdZHVLrvReNj0iuAykK300dAhwXTrEA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <6o2gnpjd7z7hxl2lu2lyevawtkcas6xar6z4zip4zc3unq27cf@k4bhpnfclnkj>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <423puqc6tesx7y6l4oqmslbby2rfjenfnw5pn5mgi63aq74jwj@jwgorel2uj3m>
 <87ecoc7gnp.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecoc7gnp.fsf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 29, 2025 at 08:11:22PM -0800, Roman Gushchin wrote:
> Shakeel Butt <shakeel.butt@linux.dev> writes:
> 
> > On Tue, Dec 30, 2025 at 01:36:12AM +0000, Roman Gushchin wrote:
> >> Qi Zheng <qi.zheng@linux.dev> writes:
> >> 
> >> Hey!
> >> 
> >> I ran this patchset through AI review and it found few regression (which
> >> can of course be false positives). When you'll have time, can you,
> >> please, take a look and comment on which are real and which are not?
> >> 
> >> Thank you!
> >
> > Hi Roman, this is really good. I assume this is Gemini model. I see BPF
> > and networking folks have automated the AI review process which is
> > really good. I think MM should also adopt that model. Are you looking
> > into automating MM review bot?
> 
> Yes, absolutely. We're working on it, hopefully in January/February we
> can have something reasonably solid.

Can you share a bit more about the plan? Are you working more on the
infra side of things or also iterating on the prompts? (I assume you are
using Chris Mason's review prompts)

On the infra side, one thing I would love to have is to get early
feedback/review on my patches before posting on the list. Will it be
possible to support such a scenario?

On the prompt side, what kind of experiments are you doing to reduce the
false positives? I wonder if we can comeup with some recommendations
which help maintainers to describe relevant prompts for their sub-area
and be helpful for AI reviews.

On the automation side, I assume we will start with some manual process.
I definitely see back-and-forth to improve prompts for MM and someone
needs to manually review the results generated by AI and may have to
update prompts for better results. Also we can start with opt-in
approach i.e. someone adds a tag to the subject for AI to review the
series.

Anyways a good topic to start a separete email for discussion.

