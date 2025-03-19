Return-Path: <cgroups+bounces-7161-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55950A69662
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1C2B17B6BB
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 17:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9041EF391;
	Wed, 19 Mar 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzQIJgz6"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1CD1DE3BF;
	Wed, 19 Mar 2025 17:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405220; cv=none; b=W/DsykhJocMzRO6uwK5/6ubCRdRP6/Rt9spxvQlyStl3pbQFviwxk1madJQbV/heq8opdMMzQIfBIRCYX1ScFV8Xws8o1RvpUxsPhiWKAUNoG60uZjgOGnDp750WAosLNtIIGcgxRf4Mv0imKjWdFXT1w9Y80PWSjTQ+Tsgl8zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405220; c=relaxed/simple;
	bh=2v3SP6x8lx7Xz2LNEBSiUVEb/WndL/P9u9lzG3ZiSBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEnQ3RRHYKkzmZ/DtHwhOaFky9xMdT3hikK9VJTAeZkNnwAFPRJOprtDDwhZmQbmh1wdeCiw8cgQdDTedEZAwLkeWak7+JmDcp6XcAo4/nTW0KdOgRHtcN3mj7ssBhJiwFZCzjjEeXIhkl+khATXj7Z15ZbxNsEZRVyhGw1BPtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzQIJgz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458EEC4CEE4;
	Wed, 19 Mar 2025 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405218;
	bh=2v3SP6x8lx7Xz2LNEBSiUVEb/WndL/P9u9lzG3ZiSBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzQIJgz6qwwMrNEgE2Vhlegj8TRaj5Urd1TV2M0cWusrt8kj1h6eUM7wqP3jxrq4Q
	 TlP1+4hcS5DYeCDatHaj94lGjcyIeMEA5vTmilWisLftlfGmlu872l/7cZ51gZOJyo
	 byDEVbcyIrEnpuIQJPrbdoG3DTrwZZGaZarGpnJdYe10VqJ0hOKHW1uPaxUak6p8Tz
	 6gp0SKFV2zUvlWn7RmylxzHc08M16K3edHAEwRogz6FwVA6IsY4e3kXiv4QqSX4up9
	 2nj9+e/2xRQeNdMUL26Zbc02CbhYblmKZHevFesrOdCIvp1E6j25PnHEkJYhowzdWg
	 aux47erEG9FKQ==
Date: Wed, 19 Mar 2025 07:26:57 -1000
From: Tejun Heo <tj@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Greg Thelen <gthelen@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>,
	Yosry Ahmed <yosryahmed@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9r-YQDAXIur81i0@slm.duckdns.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u5kcjffhyrjsxagpdzas7q463ldgqtptaafozea3bv64odn2xt@agx42ih5m76l>

On Wed, Mar 19, 2025 at 11:47:32AM +0100, Mateusz Guzik wrote:
...
> Is not this going a little too far?
> 
> the lock + irq trip is quite expensive in its own right and now is
> going to be paid for each cpu, as in the total time spent executing
> cgroup_rstat_flush_locked is going to go up.

Lock/unlock when the cacheline is already on the cpu is pretty cheap and on
modern x86 cpus at least irq on/off are also only a few cycles, so you
probably wouldn't be able to tell the difference.

Thanks.

-- 
tejun

