Return-Path: <cgroups+bounces-15147-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HouErEAzWlNZQYAu9opvQ
	(envelope-from <cgroups+bounces-15147-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:25:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB8B379581
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F59B306A4C2
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629BF3E8695;
	Wed,  1 Apr 2026 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K32yyvLf"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259F13E1CE4;
	Wed,  1 Apr 2026 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042112; cv=none; b=Qobei/Q5PCdWaDcYd1buxCEtv/nBkvDVseprfxCSBSidmlRAGtFGVw9z/hUsFjWOMZDl6tmEGCZBUzHkLz+UszoupNZmZhDUJbV+H54LySnnEISnJ5mrWfZljNm8X8OQhjS12wLhY5CYbibL8ANUwLciRpF91sAfUJslijI9JSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042112; c=relaxed/simple;
	bh=dewT5thds98VTAImtEDNC0EfFTjUiz4qEvaiq2jKju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GW24lq3TPqHFYlT76CQHEC+5g2vdcejx5JgOZxISFSjDy5aO557UGHMMJSv1+zxZCTBhOB1D7rMg5RZMgcqk99sPkM2zq7f9KV4K3xs2HB9kMmSu+EBmXeqOqlWCRLZ0ipv1ga0TQq44sDkRNRMuPGb7o7yUMssz3S3H1OZLSRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K32yyvLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93246C4CEF7;
	Wed,  1 Apr 2026 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775042111;
	bh=dewT5thds98VTAImtEDNC0EfFTjUiz4qEvaiq2jKju4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K32yyvLfMjplva3EkWRS5sBRxaNW5h2A8wKlmF06k1twv/MTgVWjsJ2N6yJsDwD1a
	 n7q5yhqJY+3pjT3mB2tlgJkWYrzk2VOIKX4Q7RrzFCCNHmFEMM8uCyvKjmjjDS+cGi
	 NDlCoGWWo+vsO4zkGxbNjF5zPDkMW9zqBpwMx+JvyYOH9IOVa0pxnygel68fOHRVJ8
	 7BJV3MuB1GZ5vcBs7XjJibMa8uJPrd4YGaHF/Uhwcht5rMTomukjzwWoNnzERVvWyB
	 KpxZZlQN9veszefrADFZNEA1ZF2sBYwbiJQEZxfnfj4IKu7ZUSiHRR3rq+y70noYel
	 8+OWFV/nITe4w==
Date: Wed, 1 Apr 2026 12:15:04 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Petr Tesarik <ptesarik@suse.com>, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] slab: remove the SLUB_DEBUG functionality and config
 option
Message-ID: <cf2f7892-9ae0-460b-9c71-ca5b5d3697db@lucifer.local>
References: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-15147-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,cmpxchg.org,linux.dev,google.com,arm.com,oracle.com,gentwo.org,suse.de,infradead.org,suse.com,vger.kernel.org,googlegroups.com,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACB8B379581
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:59:29PM +0200, Vlastimil Babka (SUSE) wrote:
> The boot-time enabled per-cache debugging has served us well in the
> past, but it's time for it to go, for the following reasons.
>
> - It's a debugging feature. However, thanks to the advent of LLM-based
>   reviews, we are not adding bugs to the kernel anymore, so it's
>   unnecessary now.
>
> - KASAN is more powerful anyway for the classes of bugs that SLUB_DEBUG
>   can catch. But I suspect KASAN is likely to be removed soon too, see
>   above.
>
> - SLAB never had no such dynamic debugging functionality. With the
>   introduction of sheaves percpu caching, we have turned SLUB back into
>   SLAB partially, so this just follows that direction.
>
> - It's removing ~2500 lines of code and I want to keep my overal
>   diffstats negative. This adds a nice margin.

Honestly you're making me look bad because mine is so 'positive' (I SWEAR IT IS
TEST CODE AND COMMENTS) so this turns me against this patch...

>
> Since the slub kunit test depends on SLUB_DEBUG, remove it too. It's not
> a big loss, see the first point above.
>
> Singed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

...but because you're removing clearly useless and superceded debug code (I mean
hello, we have people using openclaw to automate all this unnecessary kernel dev
stuff):

Reviewed-by: claude-opus-4-6[1m]
Assisted-by: Lorenzo Stokes (as per the register) <ljs@kernel.org>

Cheers, Claude

