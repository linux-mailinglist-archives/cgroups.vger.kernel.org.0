Return-Path: <cgroups+bounces-12815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 374DCCE8B06
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 05:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D434430133B1
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 04:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BB126CE1E;
	Tue, 30 Dec 2025 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ovyyabce"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E647242D70
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 04:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767070160; cv=none; b=mHNccCL+8Z+EVL8kYW6gUbMoVJsTwhRmev1S0Iiwp6iduxi4LQWMZ+5EaocKv/I816KUKiCOagZc8L3sWRzx2QJECNTizjHAsFlhHO5XK+pDnkRFKiRt26VqmvYVxtgVeYvAYqyvkJ/xfIVhs7UdKWk7Y7tALR9UkRPomdNEz8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767070160; c=relaxed/simple;
	bh=xqkBWmJt56/S7eObki6Dz7RGy4FjQAhDBwvDoOSe/L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjfASbVFymFWnIsjloLm2Udivp0hPZ31Aj1j0gRu4hNnsac+YHXemnmowIDrZbsYV3y+rGMMtrlxoORqdxKSUdFD2pzJT6BTrkcAWIjH2pvOO1KNQ/4qoCdXIwfH0L0lc4A7z1XmExjfbAAq446Y/FEg5jyf3GqB7pVORzFO6t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ovyyabce; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Dec 2025 20:48:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767070142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hZeno5oIt6J6Bc6V0PL7wUGOP1/2GdnYexT8Hupqww=;
	b=ovyyabce7Jt1awm1nqzdjwTZoNxtEAY5Hh/oEZ2fpFEev2gAhRvJ0M0ONabqtbUzmNpSK1
	8pTWncgHE2uOR0vE8y24K+SnHSgKcqd7g3oJB1m9ch4gsZmnVL8dXpMMAOKpn1Hdwud6WV
	aQpnfKqsLRgmiVJbXb8pXzwyyQ0I8qU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, hannes@cmpxchg.org, 
	hughd@google.com, mhocko@suse.com, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <krpcb6uc5yu75eje7ypq46oamkobmd5maqfbn266vbroyltika@td6kecoz4lzu>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
 <1fe35038-abe1-4103-b5de-81e2b422bd21@linux.dev>
 <87tsx861o5.fsf@linux.dev>
 <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3ee4091-b50c-449e-bc93-9b7893094082@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 30, 2025 at 12:25:31PM +0800, Qi Zheng wrote:
> 
> 
[...]
> > > 
> > > Thank you for running the AI review for this patchset, but please do not
> > > directly send the raw data from the AI review to the community, as this
> > > is no different from automated review by a robot.
> > 
> > Hi Qi,
> > 
> > I don't know why you're so negative towards it. It's been great at
> 
> No, I don't object to having a dedicated robot to do this.
> 
> > finding pretty tricky bugs often missed by human reviewers. In no way
> > it's a replacement for human reviews, but if a robot can find real
> > issues and make the kernel more reliable and safe, I'm in.
> 
> I just think you should do a preliminary review of the AI ​​review results
> instead of sending them out directly. Otherwise, if everyone does this,
> the community will be full of bots.
> 
> No?
> 

We don't want too many bots but we definitely want at least one AI
review bot. Now we have precedence of BPF and networking subsystem and
the results I have seen are really good. I think the MM community needs
to come together and decide on the formalities of AI review process and
I see Roman is doing some early experimentation and result looks great.

Shakeel

