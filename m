Return-Path: <cgroups+bounces-12278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B0ACA8A47
	for <lists+cgroups@lfdr.de>; Fri, 05 Dec 2025 18:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0BE5E305B653
	for <lists+cgroups@lfdr.de>; Fri,  5 Dec 2025 17:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACE62E92A6;
	Fri,  5 Dec 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJzLIK7e"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89A2D7DCE;
	Fri,  5 Dec 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764956132; cv=none; b=jx/CU6zGab9JvqjeBm1bvHYN8pk4kiPN2zyuIbvsLqiA3qaFZr2N2/DTeew3FlxScw6i0S1vsyNDxtM906WzX+MdTdXHhsdfjRfb96UrVjFAdamxh1nDlpkH21zGCQeN/hAJPZ/63HRmCUv7/PYXbDmGibFPuthDSIvgvkTAHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764956132; c=relaxed/simple;
	bh=9Jm4Oan9nsLhHItq9sLNPfsHbijlEVqpoSBh7EudzJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvziNdI/NihPHZSCP+/R8KCovlzmBScjrOv+buginABjBf7Dfm+UA5Ec3UqdZuJzTUpHBOJjQL6yhOT7RCjRPTnBsjJ54GHFYxY7FjhqzC4jmZEhn3M4Y+Cthwx22+0IHSYG5DrGSweWOqSI5enJecW4i2aatKb915gIq0Si0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJzLIK7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026E3C4CEF1;
	Fri,  5 Dec 2025 17:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764956132;
	bh=9Jm4Oan9nsLhHItq9sLNPfsHbijlEVqpoSBh7EudzJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJzLIK7eT6vXLmEG/WRda3rNsh1pJ4OHzjKkWVmB4V5ErEAojrGME2XTWIDbUiDKN
	 47i8/dZpsedoqb7iwkBEjeMK3CkdWKzbaJjIrxWULHvZBIeoaL3UW2D22Kk1cX/MqK
	 SLJH5x2I7PWSZf5nHaqlKEr5UwEnnZb60EKniwnUB+BmemMx16zyqGoo5XwA6uJj5l
	 Rl7ZCgdCToicNZWTM9zQa+zohFURWVjgpkZJGq4FRPKM1YDw/TDVh/JW/kvwjmd2Ln
	 3VeH7PScNpU31DgVbSvpc5goE6nh9W++yqZqt+W2wuOLGtaG1TTa2wXRJygYZLlXZX
	 FRcjh1NphzYFQ==
Date: Fri, 5 Dec 2025 07:35:30 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] cgroup: rstat: use LOCK CMPXCHG in css_rstat_updated
Message-ID: <aTMX4tycdzKlaqaH@slm.duckdns.org>
References: <20251205022437.1743547-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205022437.1743547-1-shakeel.butt@linux.dev>

Hello,

On Thu, Dec 04, 2025 at 06:24:37PM -0800, Shakeel Butt wrote:
...
> In Meta's fleet running the kernel with the commit 36df6e3dbd7e, we are
> observing on some machines the memcg stats are getting skewed by more
> than the actual memory on the system. On close inspection, we noticed
> that lockless node for a workload for specific CPU was in the bad state
> and thus all the updates on that CPU for that cgroup was being lost. At
> the moment, we are not sure if this CMPXCHG without LOCK is the cause of
> that but this needs to be fixed irrespective.

Is there a plausible theory of events that can explain the skew with the use
of this_cpu_cmpxchg()? lnode.next being set to self but this_cpu_cmpxchg()
returning something else? It may be useful to write a targeted repro for the
particular combination - this_cpu_cmpxchg() vs. remote NULL clearing and see
whether this_cpu_cmpxchg() can return a value that doesn't agree with what
gets written in the memory.

> @@ -113,9 +112,8 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
>  	 * successful and the winner will eventually add the per-cpu lnode to
>  	 * the llist.
>  	 */
> -	self = &rstatc->lnode;
> -	rstatc_pcpu = css->rstat_cpu;
> -	if (this_cpu_cmpxchg(rstatc_pcpu->lnode.next, self, NULL) != self)
> +	expected = &rstatc->lnode;
> +	if (!try_cmpxchg(&rstatc->lnode.next, &expected, NULL))

Given that this is a relatively cold path, I don't see a problem with using
locked op here even if this wasn't necessarily the culprit; however, can you
please update the comment right above accordingly and explain why the locked
op is used? After this patch, the commend and code disagree.

Thanks.

-- 
tejun

