Return-Path: <cgroups+bounces-6991-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB373A5CF41
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 20:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70B5189CCFB
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827642641C4;
	Tue, 11 Mar 2025 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNWAzyBh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E0C263F46;
	Tue, 11 Mar 2025 19:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721040; cv=none; b=gqEWFRz3L1qbAA8GTLw8bCpKkXAOkky5EPay7XPNT46OQD9t64sdKMGYsWxGMIqadMJLaWThKgvRJjBtj3ELd+aRplIyquXrLOLaQ6ZmbHiVBCWiogSF9tQZXAQMxJch9mDSDMwXGJyCSbqn9vwEYNqpgXafzL5MMAkjKLyd0xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721040; c=relaxed/simple;
	bh=5mVnh8fjGF8Oy9qr15OGfcozu4fYLmyI3uszL0xmuO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A05qokKQIBI9i/4VwwG2Q7er5OYuGkIq9+kbCSdGryTenBTZ+CNHxzYN7vGVioSoOly0XVrs5dZ1PJNCYP08kNlbB2lQP9KRFQWhopdDcU5NNlFWwk69ri+EwkiWaVglwAuuQLtitOcvoIqgVqvvxzXkPo9G07/Ly09CCwTXl1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNWAzyBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E0C4CEEA;
	Tue, 11 Mar 2025 19:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721039;
	bh=5mVnh8fjGF8Oy9qr15OGfcozu4fYLmyI3uszL0xmuO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fNWAzyBhegpIESCOpfUhfzWO0+SAu6ynu9nA6DUlg8WBeqULGPcOe4cN5w1uTmc/w
	 ol4QgnmOPAPOa++rCqD0ehNxbIjO8lV3ep1BSfMPYBE6t9mzLqezDg66k68DCliV6U
	 9uhl9V8z6tuVSoCDM97UhnHozGzXn5KJ/PSlqlVhbdlQoh4K/CAFmpIfPDSpOp8Z1s
	 lXbpe3fING+9OMnDwOTIjEAhuePf9KpaC18x50wDxB4GeZ9ivHyjCDUTZZk8qk7vkO
	 OLcLWRhSddu2NRHptKZsr9V3fenrsTxkrDtg/Xyos95TkLLAPmfjf3iS8wdQQ8ipM5
	 49bBC8dpZimrw==
Date: Tue, 11 Mar 2025 09:23:58 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, Josef Bacik <josef@toxicpanda.com>,
	Waiman Long <longman@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Muchun Song <muchun.song@linux.dev>,
	Michal Hocko <mhocko@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 00/11] cgroup v1 deprecation messages
Message-ID: <Z9CNzt9VAjFrLPBT@slm.duckdns.org>
References: <20250311123640.530377-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311123640.530377-1-mkoutny@suse.com>

On Tue, Mar 11, 2025 at 01:36:17PM +0100, Michal Koutný wrote:
> Memory controller had begun to print warning messages when using some
> attributes that do no have a counterpart in its cgroup v2
> implementation. This is informative to users who run (unwittingly) on v1
> or to distros that run v1 (they can learn about such users or prepare
> for disabling v1 configs).
> 
> I consider the deprecated files in three categories:
>   - RE) replacement exists,
>   - DN) dropped as non-ideal concept (e.g. non-hierarchical resources),
>   - NE) not evaluated (yet).
> 
> For RE, I added the replacement into the warning message, DN have only a
> plain deprecation message and I marked the commits with NE as RFC.
> Also I'd be happy if you would point out some forgotten knobs that'd
> deserve similar warnings.
> 
> The level of messages is info to avoid too much noise (may be increased
> in future when there are fewer users). Some knobs from DN have warn
> level.
> 
> The net_cls and net_prio controllers that only exist on v1 hierarchies
> have no straightforward action for users (replacement would rely on net
> NS or eBPF), so messages for their usage are omitted, although it'd be
> good to eventually retire that code in favor of aforementioned.
> 
> At the end are some cleanup patches I encountered en route.

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

