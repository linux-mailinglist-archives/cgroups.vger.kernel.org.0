Return-Path: <cgroups+bounces-9541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5239FB3D974
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 08:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C2416CDDB
	for <lists+cgroups@lfdr.de>; Mon,  1 Sep 2025 06:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E881E9B3F;
	Mon,  1 Sep 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULSvrrpJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B2E442C;
	Mon,  1 Sep 2025 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756706790; cv=none; b=RqkBphyYaTZwJxAROYlkEnrUk4BLqcCu/2UhdVp8r/WSlyVcuXsXHzfks8LRMHGvCIGlNlb7DnCURXpLsIeOFTRL9sIAcp2W3JL/aUca5wvuzdY0xJYqhEngFcIKhG5oTg0Q0vq6gvZZFSGIXwgKx1CjCKvoeiBLOA4443rMPWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756706790; c=relaxed/simple;
	bh=ThgXBJ7t/gOvaZIzSXHb1QOTtw1F6BppwwSYBkrCJBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQIJPA83wKsp9PiHRFZ21AwOjxAa5LARjt9AfD1TiuSiW84hpaSNMAAOvZc46aAgUxh2qSP2j5mUUlgTHylGEI4GIFcZlk7DWgj7a6Xqdi4YkCVO3zZRDtzUFg9N5W6equpZV5Kxej4ks7M6CZasspO64GWe11MmE9z9OytrUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULSvrrpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9902C4CEF0;
	Mon,  1 Sep 2025 06:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756706790;
	bh=ThgXBJ7t/gOvaZIzSXHb1QOTtw1F6BppwwSYBkrCJBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULSvrrpJdYHxtxcLuyHyhDLAIKg1BhxossjavwfqE6a8YP3W+0+5m5X2+nbkHW0Kz
	 d8z1qeQJj/7X2m6Bg214taQCgWWJhTTaorGV/n7dGy3y9DeBJOS3Cdvwz2gyvQAIxi
	 ImK9mAuLjQeq2a6wLRi45hxDuYSTGo8HRv0LY8cE=
Date: Mon, 1 Sep 2025 08:06:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, hannes@cmpxchg.org, mkoutny@suse.com,
	peterz@infradead.org, zhouchengming@bytedance.com,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 2/2] cgroup/psi: Set of->priv to NULL upon file release
Message-ID: <2025090113-matcher-scoured-ab39@gregkh>
References: <20250822070715.1565236-1-chenridong@huaweicloud.com>
 <20250822070715.1565236-3-chenridong@huaweicloud.com>
 <aKitWH39wpfTF5st@slm.duckdns.org>
 <2025082322-canopener-snugness-14e3@gregkh>
 <aKyeEIArL3gs0jNF@slm.duckdns.org>
 <afc56d3b-1fc7-48b8-a724-7abc59e06cdd@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afc56d3b-1fc7-48b8-a724-7abc59e06cdd@huaweicloud.com>

On Mon, Sep 01, 2025 at 09:38:49AM +0800, Chen Ridong wrote:
> 
> 
> On 2025/8/26 1:32, Tejun Heo wrote:
> > Hello, Greg.
> > 
> > On Sat, Aug 23, 2025 at 08:43:48AM +0200, Greg KH wrote:
> >>> Applied to cgroup/for-6.17-fixes.
> >>
> >> Both or just this second patch?  Should I take the first through the
> >> driver-core tree, or do you want to take it through the cgroup tree?  No
> >> objection from me for you to take both :)
> > 
> > Sorry about the lack of clarity. Just the second one. The first one looks
> > fine to me but it would probably be more appropriate if you take it.
> > 
> > Thanks!
> > 
> 
> Hello all,
> 
> Any other opinions? Can this patch be applied?

Please give us a chance to catch up with patch reviews :)

