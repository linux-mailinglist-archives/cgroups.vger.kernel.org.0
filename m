Return-Path: <cgroups+bounces-4596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B83CB965363
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 01:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7612C284523
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2024 23:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9445118E745;
	Thu, 29 Aug 2024 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="k+YqNVx4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528AC18C004
	for <cgroups@vger.kernel.org>; Thu, 29 Aug 2024 23:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973853; cv=none; b=eLXTzTxstV7oevSQYyBltewH6m85ZaQwu3ZJGOUnZzmrtSwtcDxM86glbtNLTn+DhpcHpSpHHXz/xKMDQGSHF2V9tGmKxcXsCe+J2zlXMeHGc8mowA5KJwldEiqHYysk4ncRUK/ehclecqy0ONYwIblYXRCtDuPuxAzdKyfZOF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973853; c=relaxed/simple;
	bh=jKPDWeiMHKgVnYkY6yCN53N1ZWijhwk0Dn7fBxJTQRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9Pb4/OPlTAj5OgyrHZL75qT8hwUmMgCHKGW9ByFL/sHudEvnG60nvcb5O6sWvh2gqrPxFYby1BVFLBbZyTceRs5yxIqji4pzgVbpV4sE+2Zjk/x/ujs9dZz2GiJSdCjCxsgceTV1oKecaH9+RbxQuvvRIjRawJ3671Zzg94d4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=k+YqNVx4; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Aug 2024 23:24:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724973848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jz8aSj9+dgbv2VArjp9TF1rZbfkiiiWz3UWEm0k+qwY=;
	b=k+YqNVx4Y9uwvaC+F9+Rfpdqycl+3CxlDLIUqmig643TyTRNicNIpmUcKoKOpZ7bz6O585
	RoSTghhDwseKVS2xJc+uweIvze1TT1UzPCjtK6ldGUcvw6W4Mi3qbJzwhlCSlu8TGMagVg
	RtG/f1K7smpmIl4gAiuU3v48iUVrEm8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Xingyu Li <xli399@ucr.edu>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, shakeel.butt@linux.dev,
	muchun.song@linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>,
	Juefei Pu <jpu007@ucr.edu>
Subject: Re: BUG: general protection fault in get_mem_cgroup_from_objcg
Message-ID: <ZtEDEoL-fT2YKeGA@google.com>
References: <CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4+Ahg@mail.gmail.com>
 <Zs_gT7g9Dv-QAxfj@google.com>
 <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAgD-5-8YjG=uOk_yAy_U8Dy9myRvC+pAiVe0R+Yt+xmEuCxQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 28, 2024 at 10:20:04PM -0700, Xingyu Li wrote:
> Hi,
> 
> Here is the kernel config file:
> https://gist.github.com/TomAPU/64f5db0fe976a3e94a6dd2b621887cdd
> 
> how long does it take to reproduce?
> Juefei will follow on this, and I just CC'ed him.

I ran the reproducer for several hours in a vm without much success.
So in order to make any progress I'd really need a help from your side.
If you can reproduce it consistently, can you, please, try to bisect it?

Thanks!

