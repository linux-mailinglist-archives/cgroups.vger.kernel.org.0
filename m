Return-Path: <cgroups+bounces-8710-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ADBB026D9
	for <lists+cgroups@lfdr.de>; Sat, 12 Jul 2025 00:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804731C28480
	for <lists+cgroups@lfdr.de>; Fri, 11 Jul 2025 22:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3854821ADA2;
	Fri, 11 Jul 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUVpqo7Y"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2D19995E;
	Fri, 11 Jul 2025 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752272109; cv=none; b=pgJAWT6R/l3UF1x4/t4ZodUrWltCfD0T+zaoUJaN5nVTmgxfcn438czZyNlyGxyAE91Sq+22TNmE/B0YHY5bWztgLkQska8rXeT1dzfYL0kaWKJK7lpPyaWxYETshFn/mEd5FkY8zQz6CsB5v/gNwLPZ86c7wIE90DtFlV2QaoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752272109; c=relaxed/simple;
	bh=BtEQsXN690+VRsFBfvRT/wZ3UIDsKp2OxTYosAsXnAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye9wOZY+hoi3L++pZRcqCEnGlNWxXAjKt4RnBMspbFdL4nrMG/8Kq5KALTjT0PDN+u/4BWL2hIFgAcnaxuXIpd8DDMrN6pFsS/pqAocG9jtRIMCCXWzDND+66RMd6xcRSSaoEnSiuQZfE27juLUOZluUhlByAaaiXntym1rmlFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUVpqo7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C687C4CEED;
	Fri, 11 Jul 2025 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752272108;
	bh=BtEQsXN690+VRsFBfvRT/wZ3UIDsKp2OxTYosAsXnAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YUVpqo7YIli6QJVeQfZlT5gOAr7WLxWr8FqAVyU/brJA8ScMFt8u/xKvANNh4Cuy0
	 JNs1riyORN9FuEtA/u2bZE4JpgP44IZ26wCnQxd1Iztie1foy8Wjpw54/2r4LEVrDr
	 v2A7TFHVxmp5lMPHApZrYjkObKmE0UF3E1GrzBiVJfrpE9zAsRdeeMGhzvIxtV9rQl
	 LGmKq90qLox/+bBoOeHBpJTWIRbyhgLlewnp0qweguGCMS8y2FDl38VcEcBYROmmKW
	 coJgGd0gQ+bai1Iuf8+oH/uRqZNv0P8vEEog1n/hYI8mk65rNynGizdrTVYoEVy2zX
	 SPLk5IwMELUtA==
Date: Fri, 11 Jul 2025 12:15:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Ridong <chenridong@huawei.com>, 1108294@bugs.debian.org
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
Message-ID: <aHGM6_WOTWLiUdpU@slm.duckdns.org>
References: <20240909163223.3693529-1-mkoutny@suse.com>
 <20240909163223.3693529-5-mkoutny@suse.com>
 <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
 <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bio4h3soa5a64zqca66fbtmur3bzwhggobplzg535erpfr2qxe@xsgzgxihirpa>

On Fri, Jul 11, 2025 at 03:10:44PM +0200, Michal Koutný wrote:
> Hello Ben.
> 
> On Wed, Jul 09, 2025 at 08:22:09PM +0200, Ben Hutchings <ben@decadent.org.uk> wrote:
> > Would you consider reverting this change for the sake of compatibility?
> 
> As you write, it's not fatally broken and it may be "just" an issue of
> container images that got no fresh rebuild. (And I think it should be
> generally discouraged running containers with stale deps in them.)
> 
> The original patch would mainly serve legacy userspace (host) setups on
> top of contemporary kernel (besides API purity reasons). Admittedly,
> these should be rare and eventually extinct in contrast with your
> example where it's a containerized userspace (which typically could do
> no cgroup setup) that may still have some user demand.
> 
> So, I'd be more confident with the revert if such an adjustment was
> carried downstream by some distro and proven its viability first. Do you
> know of any in the wild?

I think we still want to deprecate /proc/cgroups but given that there are
impacted users maybe we can bring it back under a boottime param w/ warning?

Thanks.

-- 
tejun

