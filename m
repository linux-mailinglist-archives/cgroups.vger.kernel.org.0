Return-Path: <cgroups+bounces-8642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D89EAEBDD4
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 18:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886D816E286
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A616B2E9EBE;
	Fri, 27 Jun 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9K7gUdn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB82E973C;
	Fri, 27 Jun 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751043060; cv=none; b=P7PEoPyG0J2wAfGwNBViWD1I9Ke40rXrHRgoT86rOB/XpIZTAUewr28i/zWQV1V39DCI4pTztf5eQfDP5CWzsHREsmlPVJpvOLmGvv9EPxjn7LNPRsBQ+IN9OOAqaQqA22iK2AYrN6euP0MOMyvxzWtVdM4IaFi/D+UNd0m2tDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751043060; c=relaxed/simple;
	bh=aJ07hUJYwbrLew9sRNGrGzo4e2otJNCPPs8hRpvB6NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRWUdK+g1HYlLOjUWYeFeuxXUjm7TlvBg6cQYFrJ9Tl4U28SHd+XCznXMP7xrniqWNMsHWCDxOQDHjGWXjO6xAqim/F1WN4cU2qRUsEw/+V2yD1W5WXWBgoZD7o0vCodB4mt3+Ds9Mu821dFKkq3pa23qcGpeUZ2Ij88spJXZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9K7gUdn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D0EC4CEEF;
	Fri, 27 Jun 2025 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751043059;
	bh=aJ07hUJYwbrLew9sRNGrGzo4e2otJNCPPs8hRpvB6NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9K7gUdnIqiY5zPsSl1E7pUaIlL4K90dW6IcNc+cEcGIQes8wPgu30tHrJbYTenpN
	 mjvNA/KAJkVHtilaLD5WIoMfmLutwndUyjFw0yZ6EqywoDw575H20G/fS+PwfIg1AE
	 poxcGCDVmfHdsdBIWr82zj/Mw3iBqhPNPc2w34f7JOpe0GS8pXGeV9Qa/0letnq0R5
	 ppck3qdjm1JTx+gEaW4WKnA0jAP7hRQB2XcW4zF+STN4MIWaAp9RzElbkUbA3yu9hg
	 105vddSxk/C5MqPnyiyAY4/2JWXxdxCkuK2356AWbxIJ55LGb2UnOf7y1ROKLSPOYI
	 pwM6rzB8H/APw==
Date: Fri, 27 Jun 2025 06:50:58 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: "Wlodarczyk, Bertrand" <bertrand.wlodarczyk@intel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	"mkoutny@suse.com" <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"inwardvessel@gmail.com" <inwardvessel@gmail.com>
Subject: Re: [PATCH v2] cgroup/rstat: change cgroup_base_stat to atomic
Message-ID: <aF7L8jRkWm1TrwSu@slm.duckdns.org>
References: <20250624144558.2291253-1-bertrand.wlodarczyk@intel.com>
 <ykbwsq7xckhjaeoe6ba7tqm55vxrth74tmep4ey7feui3lblcf@vt43elwkqqf7>
 <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR11MB7894DDEE6C630D5A3A4D23A1F145A@CH3PR11MB7894.namprd11.prod.outlook.com>

Hello,

On Fri, Jun 27, 2025 at 01:15:31PM +0000, Wlodarczyk, Bertrand wrote:
...
>  > Also the response to the tearing issue explained by JP is not satisfying.
> 
> In other words, the claim is: "it's better to stall other cpus in spinlock plus disable IRQ every time in order to 
> serve outdated snapshot instead of providing user to the freshest statistics much, much faster".
> In term of statistics, freshest data served fast to the user is, in my opinion, better behavior.

This is a false choice, I think. e.g. We can easily use seqlock to remove
strict synchronization only from user side, right?

> I wouldn't be addressing this issue if there were no customers affected by rstat latency in multi-container
> multi-cpu scenarios.

Out of curiosity, can you explain the case that you observed in more detail?
What were the customer doing?

Thanks.

-- 
tejun

