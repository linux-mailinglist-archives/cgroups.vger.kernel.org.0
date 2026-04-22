Return-Path: <cgroups+bounces-15447-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HjfLMAV6GmaEwIAu9opvQ
	(envelope-from <cgroups+bounces-15447-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 02:26:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B772440DA2
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 02:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 786CB301DC16
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 00:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A2C19AD5C;
	Wed, 22 Apr 2026 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfWfAYVV"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658F3137750;
	Wed, 22 Apr 2026 00:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776817583; cv=none; b=lkZwGe2YOj8AUpzk95wm5doE/W2OeqNKHg3ufc2p1xNCMNyp8vzN4DlyD1P9QQ3niySHuzMQTSbnXk5/7DxZZDYCaPyWJVS1eiZ6dUNEMy32ugDLr6wByzGYxhewl156CKJ4fLx7r/K0uy5gyRXqekIoLsoCx2S+oe2Czcp8MCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776817583; c=relaxed/simple;
	bh=jqBAEzAIAkAs5KK0c26HBfL5HhvElj7G2+7Aq7pEawY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISRV/nKLlqarcInYLrEe6Jvly+Rett1/uzvBOE0ceaOtqKZjxFxDR2RQoBb+6UPaaylYTkdi6jdfbAazkU5GrZb98Ptj5gWJJs3ZMKNDnNEv2TcCBkIwqQq2eejOkx+oiP9dZzVZLEOsgebJy2h36OY9L4ZHLwB1i6gReZw9UG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfWfAYVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DE9C2BCB0;
	Wed, 22 Apr 2026 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776817583;
	bh=jqBAEzAIAkAs5KK0c26HBfL5HhvElj7G2+7Aq7pEawY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AfWfAYVV308wNpkitQfHp/i3Vv5ItGGWY2XqHA/y9idxCYm3dPzbSK+1q5SSNH6QK
	 DsOwfy745VLjMiMxHcKCq6uTftlyufiRX44wgFujFSOigdKnuHKMyIYbWJW0dnCZry
	 gJJe6OSYz8y79D39pR0T8X0/y2Zqr0TkD8jmzC2m9WHa2+j0bD/tngildZbAJ4zUlK
	 eM2Hg0B3R5Uch2WC4xDPUI0ZVJS+OwSVimBYSur8g0v7HEu7AFTJMa8N7db6oAY7EC
	 0T/KpkGxdNkaUTu2q/8Lam6bV19HUx2qf8ZYxfd1xFvzAcrzqClGURW5mWc/w1v7Oq
	 DJ/3mdtpqSKhw==
Date: Wed, 22 Apr 2026 00:26:19 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: kasong@tencent.com, Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	apopple@nvidia.com, axelrasmussen@google.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, lenb@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, matthew.brost@intel.com, 
	mhocko@suse.com, muchun.song@linux.dev, npache@redhat.com, pavel@kernel.org, 
	peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de, rafael@kernel.org, 
	rakie.kim@sk.com, roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, tglx@kernel.org, 
	vbabka@suse.cz, weixugc@google.com, ying.huang@linux.alibaba.com, 
	yosry.ahmed@linux.dev, yuanchu@google.com, zhengqi.arch@bytedance.com, ziy@nvidia.com, 
	kernel-team@meta.com, riel@surriel.com
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
Message-ID: <aegUoOiUbjUAH5aT@google.com>
References: <20260320192735.748051-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320192735.748051-1-nphamcs@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15447-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[tencent.com,oracle.com,linux-foundation.org,nvidia.com,google.com,kernel.org,linux.alibaba.com,redhat.com,sk.com,vger.kernel.org,linux.dev,lwn.net,arm.com,gourry.net,cmpxchg.org,gmail.com,kvack.org,intel.com,suse.com,infradead.org,suse.de,huaweicloud.com,suse.cz,bytedance.com,meta.com,surriel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[54];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yosry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B772440DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:27:14PM -0700, Nhat Pham wrote:
> 
> This patch series is based on 6.19. There are a couple more
> swap-related changes in mainline that I would need to coordinate
> with, but I still want to send this out as an update for the
> regressions reported by Kairui Song in [15]. It's probably easier
> to just build this thing rather than dig through that series of
> emails to get the fix patch :)
> 
> Changelog:
> * v4 -> v5:
>     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
>     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(),
>       and use guard(rcu) in vswap_cpu_dead
>       (reported by Peter Zijlstra [17]).
> * v3 -> v4:
>     * Fix poor swap free batching behavior to alleviate a regression
>       (reported by Kairui Song).
>     * Fix assorted kernel build errors reported by kernel test robots
>       in the case of CONFIG_SWAP=n.
> * RFC v2 -> v3:
>     * Implement a cluster-based allocation algorithm for virtual swap
>       slots, inspired by Kairui Song and Chris Li's implementation, as
>       well as Johannes Weiner's suggestions. This eliminates the lock
> 	  contention issues on the virtual swap layer.
>     * Re-use swap table for the reverse mapping.
>     * Remove CONFIG_VIRTUAL_SWAP.
>     * Reducing the size of the swap descriptor from 48 bytes to 24
>       bytes, i.e another 50% reduction in memory overhead from v2.
>     * Remove swap cache and zswap tree and use the swap descriptor
>       for this.
>     * Remove zeromap, and replace the swap_map bytemap with 2 bitmaps
>       (one for allocated slots, and one for bad slots).
>     * Rebase on top of 6.19 (7d0a66e4bb9081d75c82ec4957c50034cb0ea449)
> 	* Update cover letter to include new benchmark results and discussion
> 	  on overhead in various cases.
> * RFC v1 -> RFC v2:
>     * Use a single atomic type (swap_refs) for reference counting
>       purpose. This brings the size of the swap descriptor from 64 B
>       down to 48 B (25% reduction). Suggested by Yosry Ahmed.
>     * Zeromap bitmap is removed in the virtual swap implementation.
>       This saves one bit per physical swapfile slot.
>     * Rearrange the patches and the code change to make things more
>       reviewable. Suggested by Johannes Weiner.
>     * Update the cover letter a bit.
> 
> This patch series implements the virtual swap space idea, based on Yosry's
> proposals at LSFMMBPF 2023 (see [1], [2], [3]), as well as valuable
> inputs from Johannes Weiner. The same idea (with different
> implementation details) has been floated by Rik van Riel since at least
> 2011 (see [8]).

Unfortuantely, I haven't been able to keep up with virtual swap and swap
table development, as my time is mostly being spent elsewhere these
days. I do have a question tho, which might have already been answered
or is too naive/stupid -- so apologies in advance.

Given the recent advancements in the swap table and that most metadata
and the swap cache are already being pulled into it, is it possible to
use the swap table in the virtual swap layer instead of the xarray?

Basically pull the swap table one layer higher, and have it point to
either a zswap entry or a physical swap slot (or others in the future)?
If my understanding is correct, we kinda get the best of both worlds and
reuse the integration already done by the swap table with the swap
cache, as well as the lock paritioning.

In this world, the clusters would be in the virtual swap space, and we'd
create the clusters on-demand as needed.

Does this even work or make the least amount of sense (I guess the
question is for both Nhat and Kairui)?

