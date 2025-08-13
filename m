Return-Path: <cgroups+bounces-9138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57DAB252BD
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 20:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748481BC38C5
	for <lists+cgroups@lfdr.de>; Wed, 13 Aug 2025 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9406B2BE7DF;
	Wed, 13 Aug 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgZqVbaP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50858B640;
	Wed, 13 Aug 2025 18:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755108221; cv=none; b=mgaPhj8VAPU7KKU8THRMhX2p8+Yr+kV1uyXkAQl3Ycf1SOGM48M+kTurlP2rM3Up4UIhDEQH/uXxOMGzt4WtHRbf/rgaDbPHKwVSuPZszcsnyHN+7SeRhDJodFFcCS+hVfao7+0zKKJXlIsJDqVwDBgJW0XOwiXDDfgTbs9Sukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755108221; c=relaxed/simple;
	bh=mxBe9IZW17EWG3soqFkqLWOPvQ9A5xBcmo8kGlCtxDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2052YdqRfu5VrNPsOprD5MOM2pept2E8RYt3PjHOauNMAq0pL5g28Rb4d4EKqZJSYVRH1rQmYHeBvjE6hVlhCvbj6ldZdtF9STzSxKaA/gu9BgfCdpH+J+gXJjaxFIU14Bo+3rqR16mohvhGgiDUU0LrZ9cofoxGYt5a/SMmQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgZqVbaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED5DC4CEEB;
	Wed, 13 Aug 2025 18:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755108221;
	bh=mxBe9IZW17EWG3soqFkqLWOPvQ9A5xBcmo8kGlCtxDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgZqVbaPkJd4dniV6okJBx5xLrjRW6Nf9S1FYJbycm9dTQd1ycvHK6+kmO2rIKnIG
	 fL/p5pq3Aqc5QRf470boWhZV7uBym8vwGg4KotZ8tYK7BA56V3dwVxFU3sczONp9C7
	 jsP5GYyzrdiLfxfQeUQ9d7Svs68k26O0g8FdQowl8LaxiXSHhEfWnlI+D9dcFM2VLX
	 rdmTPJjyI+O30X9nNvHn/ysdaFa9eBaPwn94dLJNyBSiH0OOYv0Bd1l2NIJiwOZGob
	 NK8knKosCgCZcpHMwvHgVwqVqxAcOEEh2AXA2dIgSKnpBLGlL/4XfC+7/xWoV8as8e
	 zjgHNra0uuvMg==
Date: Wed, 13 Aug 2025 08:03:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Daniel Sedlak <daniel.sedlak@cdn77.com>,
	"David S. Miller" <davem@davemloft.net>,
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
	Matyas Hurtik <matyas.hurtik@cdn77.com>
Subject: Re: [PATCH v4] memcg: expose socket memory pressure in a cgroup
Message-ID: <aJzTeyRTu_sfm-9R@slm.duckdns.org>
References: <20250805064429.77876-1-daniel.sedlak@cdn77.com>
 <aJeUNqwzRuc8N08y@slm.duckdns.org>
 <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <gqeq3trayjsylgylrl5wdcrrp7r5yorvfxc6puzuplzfvrqwjg@j4rr5vl5dnak>

Hello,

On Wed, Aug 13, 2025 at 02:03:28PM +0200, Michal Koutný wrote:
...
> One more point to clarify -- should the value include throttling from
> ancestors or not. (I think both are fine but) this semantic should also
> be described in the docs. I.e. current proposal is
> 	value = sum_children + self
> and if you're see that C's value is 0, it doesn't mean its sockets
> weren't subject of throttling. It just means you need to check also
> values in C ancestors. Does that work?

I was more thinking that it would account for all throttled durations, but
it's true that we only count locally originating events for e.g.
memory.events::low or pids.events::max. Hmm... I'm unsure. So, for events, I
think local sources make sense as it's tracking what limits are triggering
where. However, I'm not sure that translates well to throttle duration which
is closer to pressure metrics than event counters. We don't distinguish the
sources of contention when presenting pressure metrics after all.

Thanks.

-- 
tejun

