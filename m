Return-Path: <cgroups+bounces-7359-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E15A7C22B
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 19:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF3A17B9A3
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 17:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8632101AE;
	Fri,  4 Apr 2025 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf1nHGS0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F01F4C9F;
	Fri,  4 Apr 2025 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786755; cv=none; b=lsdE52KvkW2MfR3iS6YTPzO3kr3m3lSbxzcIDP0/kK4UDsYAXNpQg9SYg50dmgb8nKIc97EXPHMG0ferwZhqOnYOq92WbrYW5XhDIXRTjGLuIgnz1WTeHDpgFgiEsRK6bNQ7qw/IuyJkLwg9lHNHbjwWT9MYRyTKegzWCLGia90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786755; c=relaxed/simple;
	bh=ORCLl6N1YVZ27ya63jZI4ynRwB7ykB32+2AH1oNeqQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmQJ1cD3eMYUAmfczQtUmVfaydD+UJEQyq05nNUs+os6t9t/s3TNC6YGi6uPsRdonHEAWywRi6p7obbY0jjOeqPWW/026wLXOZqhEUD9fnLEGsuktjz65kcrTU8F9cH2zF2g/p1hjq1K3on2sqXITPqH0vdPYtD/GwaeRsVMil4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf1nHGS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FA2C4CEE8;
	Fri,  4 Apr 2025 17:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743786755;
	bh=ORCLl6N1YVZ27ya63jZI4ynRwB7ykB32+2AH1oNeqQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf1nHGS015wz+9164yfmKeRrVusoTrmZ+YPYFFpD+AlLfJy9ePo1O1eqviCc8Ril9
	 4/pA+B4zm+rOEi0YrP8iuNmJ4mIB7n1aLIux7rvVIYtYSts2t0lC4goBbBX3Bcti8d
	 xi91t1atYsPsZW+8SF1qPJO9YdXN4Zwl4CAxUBvYFlM7JEl8kENQ/o2iaFrDuU5U8n
	 uwkKZwyOCk+x2tX2BLaAved6Ejj6kzcCgQnU+fMcsLSmzT1V3fmbimoZ2zA7DjFATv
	 eANDjaab8sOZ8IG6LqQ15j5cdGgs2m16D8ZyZhSakLKO43yk6e/Wz5PPlMpGLckhvZ
	 JyDf1eFH3ZDHQ==
Date: Fri, 4 Apr 2025 07:12:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/2] memcg: Don't generate low/min events if either
 low/min or elow/emin is 0
Message-ID: <Z_ATAq-cwtv-9Atx@slm.duckdns.org>
References: <20250404012435.656045-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404012435.656045-1-longman@redhat.com>

Hello,

On Thu, Apr 03, 2025 at 09:24:34PM -0400, Waiman Long wrote:
...
> The simple and naive fix of changing the operator to ">", however,
> changes the memory reclaim behavior which can lead to other failures
> as low events are needed to facilitate memory reclaim.  So we can't do
> that without some relatively riskier changes in memory reclaim.

I'm doubtful using ">" would change reclaim behavior in a meaningful way and
that'd be more straightforward. What do mm people think?

Thanks.

-- 
tejun

