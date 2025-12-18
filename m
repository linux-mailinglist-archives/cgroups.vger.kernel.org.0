Return-Path: <cgroups+bounces-12519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA1CCCDF98
	for <lists+cgroups@lfdr.de>; Fri, 19 Dec 2025 00:39:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D8430F3753
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 23:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD03330B38;
	Thu, 18 Dec 2025 23:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mZeeORnn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6926C2F6170
	for <cgroups@vger.kernel.org>; Thu, 18 Dec 2025 23:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766100749; cv=none; b=KfwbtKtSPJBnVV4R4GNxTEGoaus3jlHwmk+g5lVOB57buCinmHnuh7DXxcnn7D1Fwuda1K4aMerpfTftD3Rl2ut1CLxLyLIvhF8Dt4HuPQmMNJ+hPpbbnTtSC6DyoXmHkop+ZfL5t0Ns+jltP0FCVvDrsQV4ePLKeHFEeGJhdpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766100749; c=relaxed/simple;
	bh=Dngvy8AVj1EJdx8I9Ns4CsTSYQaMeyFSGqSMukMC/xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFTn7AUFDZZG4iHaJzR6NfUjU6EkOivjlsV56rBiemo34EvpMfcIGu/2ggaUn7W8/yvoyNXSRgnZCfhU3scEScy1MlWsp8wRgf4vg/ZdQzdXc24BzdXnPP1qcCtA1qcYGR4AhAKn5z12TacwCZ38mJvnq5fy6n6FvLqTSk3TgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mZeeORnn; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 15:32:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766100740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=znUu4iyTM1oiivtQQANinir/pn3vhmDUcWkoXmOrzCw=;
	b=mZeeORnnPCcuHw8dsEZQDI2WdN9vuBbYrrsD62m2CD0c24Z39EBB2r/1fCcuJFbd1Mf1EX
	n2sFMoPYyWcKjbzNfQpaSkKy3HbCoTXLVKPOWrlJERy2zqqRIL8imM+Hh5Zk7lthPyck5J
	XggoaZhme81XkbP88esIJNQN0Jd/EDQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Muchun Song <songmuchun@bytedance.com>, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 02/28] mm: workingset: use folio_lruvec() in
 workingset_refault()
Message-ID: <dcbaqw5q5lu4thhv23b77sswsm7xpgvaptpv7glf3geeetnx3x@uxhq3wiudypq>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <08c00b5f429b44a6df3f3798e43046ebd5825415.1765956025.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08c00b5f429b44a6df3f3798e43046ebd5825415.1765956025.git.zhengqi.arch@bytedance.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Dec 17, 2025 at 03:27:26PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Use folio_lruvec() to simplify the code.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

