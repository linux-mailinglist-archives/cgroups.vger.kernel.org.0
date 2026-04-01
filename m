Return-Path: <cgroups+bounces-15148-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIF3HPQAzWl/ZQYAu9opvQ
	(envelope-from <cgroups+bounces-15148-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:26:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F14379614
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A042F3134A0A
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 11:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DDA3E92B5;
	Wed,  1 Apr 2026 11:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3T1INlz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69D83EC2CB;
	Wed,  1 Apr 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775042357; cv=none; b=ioM5r9VAjx5YDUr0K0FTtBgIJ5q48F10po8QNYyJ1g2F6uKKOYosewbVppYqJ1x9IWK8icCuc8sYHzArf4VFWC0lt5/fgei7xUnbMKz89ZNMnNG/zo2FB2o3GM94MMXHb7VS0drvswii8D9f6Tt4ILT0CSDNgYvo8XvihwqDACk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775042357; c=relaxed/simple;
	bh=xpFWMh9MkdSBc1hJn+/AhQ/w65T3zgOUU+VStizxE4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW/bAAQ0fyJIMS21Fg510bGOz8ydlXUywQUr3A9QWXoKw4DnY+VG8BHsQZhPR/0wHP6dICeH/uTblT9xqs5O6nRAq9QWTSa5LowH3VwGOwDKlNNCRqcUxmgSWgeEiSU3u7FEEdtwufWl3unKnR+BtkuHmXiZhsZarj7HrLI/hBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3T1INlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6BC4CEF7;
	Wed,  1 Apr 2026 11:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775042356;
	bh=xpFWMh9MkdSBc1hJn+/AhQ/w65T3zgOUU+VStizxE4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3T1INlz224JnvHd+iI/XTnAO57Xnl3aK9ePNoq/6qIJSX5mgLV+QHeUTpHeQXZhS
	 AOKIshDblweICaHv7+3y7gpoNJnSgXUUyvsP0J3BJQ5MHIAZnntCiKjPetRiIIu2s0
	 kP+fEhUtZMfMWv0qy/qUs5yjQkZpOKcP49EYUHiAq2HFx3AYfQgNDwa7Gdhg9HJMIj
	 BHE4QbHE805rQ7ISCK28qG/Dn83fdR3bU8IHdZVCrNdXtAKqLu+kNIaX3LifW6wK0n
	 /HZOJGHGkpF7y8srBH7x6egrSN350zRfrcNr8Kj9Nkb3EMxdkzFtsJ8eibqndNsMwA
	 FkLH/NxvGiYew==
Date: Wed, 1 Apr 2026 12:19:09 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
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
Message-ID: <a2b60504-5971-4cff-bb0d-2005e2a216f6@lucifer.local>
References: <20260401-b4-are-you-serious-v1-1-dcacda70647d@kernel.org>
 <d5cdcb88-c7ca-4a29-9b8e-3abb7c37726c@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5cdcb88-c7ca-4a29-9b8e-3abb7c37726c@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15148-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,cmpxchg.org,linux.dev,google.com,arm.com,oracle.com,gentwo.org,suse.de,infradead.org,suse.com,vger.kernel.org,googlegroups.com,kvack.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5F14379614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 01:05:34PM +0200, David Hildenbrand (Arm) wrote:
> On 4/1/26 12:59, Vlastimil Babka (SUSE) wrote:
> > The boot-time enabled per-cache debugging has served us well in the
> > past, but it's time for it to go, for the following reasons.
> >
> > - It's a debugging feature. However, thanks to the advent of LLM-based
> >   reviews, we are not adding bugs to the kernel anymore, so it's
> >   unnecessary now.
>
> Right, and probably LLM review would find many of bugs in the existing
> SLUB_DEBUG code.
>
> >
> > - KASAN is more powerful anyway for the classes of bugs that SLUB_DEBUG
> >   can catch. But I suspect KASAN is likely to be removed soon too, see
> >   above.
>
> Of course.
>
> >
> > - SLAB never had no such dynamic debugging functionality. With the
> >   introduction of sheaves percpu caching, we have turned SLUB back into
> >   SLAB partially, so this just follows that direction.
> >
> > - It's removing ~2500 lines of code and I want to keep my overal
> >   diffstats negative. This adds a nice margin.
>
> Personal stats clearly matter more than anything else.
>
> >
> > Since the slub kunit test depends on SLUB_DEBUG, remove it too. It's not
> > a big loss, see the first point above.
> >
> > Singed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
> > Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> > ---
> >  lib/Kconfig.debug      |   12 -
> >  lib/Kconfig.kasan      |    2 -
> >  lib/tests/Makefile     |    1 -
> >  lib/tests/slub_kunit.c |  329 --------
> >  mm/Kconfig.debug       |   60 --
> >  mm/dmapool.c           |    4 -
> >  mm/memcontrol-v1.c     |   17 -
> >  mm/mempool.c           |  105 ---
> >  mm/slab.h              |   34 -
> >  mm/slub.c              | 2074 +-----------------------------------------------
>
> slab.h vs. slub.c is annoying.
>
> Can you just rename that to sheaf.c / sheaf.h now while at it?

I'd prefer sheav.es.c, but naturally all comments in that file would need to be
translated to Spanish.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

