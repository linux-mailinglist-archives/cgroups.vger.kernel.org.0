Return-Path: <cgroups+bounces-9057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E177DB1F5CE
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 20:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EB8E5611AB
	for <lists+cgroups@lfdr.de>; Sat,  9 Aug 2025 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B63429B8E2;
	Sat,  9 Aug 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFbFXvxg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA825288CC;
	Sat,  9 Aug 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754764343; cv=none; b=upX7+5y42YTqxWekkpRxP6bDaOs55ZPbmTn/b0dw6pdSj+iMALtvh4LjPWLgOwXoVZKpM8JW6pnpAKBldepZnLL7Oq4PvwcqUetrvBUNHb0Y0uiSiH4J+gEYAXkKk9Xq3DSsxP64KX64deZXTzuJgjy8sbsYUts5Y/8X+zMxZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754764343; c=relaxed/simple;
	bh=17cj85UdavT53nLzrHXasrniy7Ghl4dWzlwAnf7kfeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgEMishPIh0gfumXrz4I2R7TShLXqo3CTQUE7fRsd5ZBowYtdbZ0klLw7rdgfyI4X6yP1bWTSDTUXwsAtJr56b0xpRhmGX2CuTyPFPkG020Jouptiw1IgCqi5Jz/XmFEpfuiNgQnQQoPJOVCBybJCOqlor5pGIDA5d4RzjGKKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFbFXvxg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 131AEC4CEE7;
	Sat,  9 Aug 2025 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754764343;
	bh=17cj85UdavT53nLzrHXasrniy7Ghl4dWzlwAnf7kfeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFbFXvxgend+sAk55A+p+MqT4U8ca8v3hHJ97OFvQLrSJgmlQALZjnhzjfsQ1O4GE
	 o5sIHr483/YCoKeFiqMn/koKEog2V97LFzZNs9o8SpRoy7iNkwJHNbUWddlqEU6SVD
	 kploU/2KbwgkDpUH0IH9f7BbcYUVNZqVlRA4ZIgXW+sdaga7/QnlaL105oDPYVDGGq
	 w8j9kbLwkwwLr0H0kzzejWGIzpbvVN/KFnib5LPZjwdo6d3snArbJrG5EEq6GeJtn/
	 DBoFCLHStQ7pD1LCDoBfMK/Al/4wF1dk50oLG2BhApEXkKIeyfRqdWajeWWn3OnoIA
	 qSVy7PMU3WfcA==
Date: Sat, 9 Aug 2025 08:32:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Daniel Sedlak <daniel.sedlak@cdn77.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	netdev@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <aJeUNqwzRuc8N08y@slm.duckdns.org>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805064429.77876-1-daniel.sedlak@cdn77.com>

Hello,

On Tue, Aug 05, 2025 at 08:44:29AM +0200, Daniel Sedlak wrote:
> This patch exposes a new file for each cgroup in sysfs which signals
> the cgroup socket memory pressure. The file is accessible in
> the following path.
> 
>   /sys/fs/cgroup/**/<cgroup name>/memory.net.socket_pressure
> 
> The output value is a cumulative sum of microseconds spent
> under pressure for that particular cgroup.

I'm not sure the pressure name fits the best when the content is the
duration. Note that in the memory.pressure file, the main content is
time-averaged percentages which are the "pressure" numbers. Can this be an
entry in memory.stat which signifies that it's a duration? net_throttle_us
or something like that?

Also, as Shakeel already pointed out, this would need to be accumulated
hierarchically. The tricky thing is determining how the accumulation should
work. Hierarchical summing up is simple and we can use the usual rstat
propagation; however, that would deviate from how pressure durations are
propagated for .pressure metrics, where each cgroup tracks all / some
contention states in its descendants. For simplicity's sake and if the
number ends up in memory.stat, I think simple summing up should be fine as
long as it's so noted in the documentation. Note that this semantical
difference would be another reason to avoid the "pressure" name.

Thanks.

-- 
tejun

