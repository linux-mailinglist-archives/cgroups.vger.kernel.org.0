Return-Path: <cgroups+bounces-15149-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJODOKsKzWnhZgYAu9opvQ
	(envelope-from <cgroups+bounces-15149-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 14:08:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12737A26D
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 14:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A98B306BABA
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 11:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F98F3CA4BD;
	Wed,  1 Apr 2026 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQjv+5cG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9137FF63;
	Wed,  1 Apr 2026 11:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044428; cv=none; b=AR/RR/1CE72Ab7l01WqPYzXAUMcIBhnFdKI8yn5+cEiXWIRm+vCq3hRS6IoTRDgqdOfalDwkHQ/C96lvt57z+cUfD1H3ZxEyD7OxMYc9klT3C3re0fiTb2XbbGdvDN1o7Y3JW6bJGAJkXUxP6PpFIRpoNDzAjfJ/xmYtkeeL+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044428; c=relaxed/simple;
	bh=O/4bIPxFhYeI8VkLP9DN3SgsWmQIE648f8OII8PyyS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVxq2vQdM4FpRhnOaGZVTYD7KAMGnFxvRimW8fzdSbQB7+mlQsvwuCo3OLAYteNDG0Lo2ReBA/kFn7JI4buJcM6CEbfy+H92Pd0DP1QcLvSHjbOsAzc/yF2L9ThyFf89Tr+JeUjSVw41uXonM9oFCOHd3jfgv9Xk0wTlIbyK8sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQjv+5cG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3C7C4CEF7;
	Wed,  1 Apr 2026 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775044427;
	bh=O/4bIPxFhYeI8VkLP9DN3SgsWmQIE648f8OII8PyyS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQjv+5cGYtRkn96yzMGuseLIk7H1GXT7x8/btEQ/z52u1NHxmzSoeY0e56elprOLH
	 9Xid3iTeGp17rC4Axo7WRWC//I8Pbvwr763q9K3tO3v+UX+wDxl4lonHSiUHVtPIcT
	 1HR+OUoreJJfZKe2xVLwtUHlwP8PKoezu7iZFNZ3kaAj5ZfmHIOtiKv7cEEzK8sJoc
	 T6720uDY9cMmsAzc1yGcXmGTXMv6vk93B73Dvs/xzmAl0U1b4KBuykGkSuJYDNaREW
	 4rWYx1IbaqMDsguRhJQT8BsqPxvT0DGdMe7F1XdXHXPttgH3W/tJAFwLwNeeN+98o4
	 eUYGvmOcU432w==
Date: Wed, 1 Apr 2026 20:53:45 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Muchun Song <muchun.song@linux.dev>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Jann Horn <jannh@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Petr Tesarik <ptesarik@suse.com>, linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] slab: remove the SLUB_DEBUG functionality and config
 option
Message-ID: <ac0HSfV05ppXQKya@hyeyoo>
References: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15149-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,cmpxchg.org,linux.dev,google.com,arm.com,oracle.com,gentwo.org,suse.de,infradead.org,suse.com,vger.kernel.org,googlegroups.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D12737A26D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:59:29PM +0200, Vlastimil Babka (SUSE) wrote:
> The boot-time enabled per-cache debugging has served us well in the
> past, but it's time for it to go, for the following reasons.

**You are absolutely right!** Thank you so much for putting this together, Vlastimil! 🙏 This is a well-structured and thoughtful proposal. Let me share my thoughts on each point below. 👇

> - It's a debugging feature. However, thanks to the advent of LLM-based
>   reviews, we are not adding bugs to the kernel anymore, so it's
>   unnecessary now.

Great point! 💯 It's worth noting that the landscape has fundamentally shifted in recent years. I think this is a step in the right direction! ✅

> - KASAN is more powerful anyway for the classes of bugs that SLUB_DEBUG
>   can catch. But I suspect KASAN is likely to be removed soon too, see
>   above.

Absolutely! 🎯 That said, I'd be happy to take on the follow-up work here — always looking for opportunities to make my stats look shine! ☀️

> - SLAB never had no such dynamic debugging functionality. With the
>   introduction of sheaves percpu caching, we have turned SLUB back into
>   SLAB partially, so this just follows that direction.

This is a really interesting perspective! 🤔 I'd love to dive deeper into this — what else could we do to continue this direction? 💡

> - It's removing ~2500 lines of code and I want to keep my overal
>   diffstats negative. This adds a nice margin.

Love this! 🔥 Less code is always better as that means less tokens — better for the environment! 🌱

> Since the slub kunit test depends on SLUB_DEBUG, remove it too. It's not
> a big loss, see the first point above.
> 
> Singed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---

I'd love to hear Sashiko (🤖)'s thoughts 🤔 on this as well, but FWIW... 🪄✨🔮

Acked-by: Harry Potter <i.am@serious.org>

-- 
Thank you, you made my day!
Harry / Hyeonggon

