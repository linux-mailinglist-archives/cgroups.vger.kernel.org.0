Return-Path: <cgroups+bounces-15146-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EehBnf9zGnRYgYAu9opvQ
	(envelope-from <cgroups+bounces-15146-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:11:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7523792AC
	for <lists+cgroups@lfdr.de>; Wed, 01 Apr 2026 13:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 612AD300C034
	for <lists+cgroups@lfdr.de>; Wed,  1 Apr 2026 11:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBB238B157;
	Wed,  1 Apr 2026 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lm1/Oucy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EZIpCN9Y";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="q3ydXVuF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="INUdjBYh"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777872EC083
	for <cgroups@vger.kernel.org>; Wed,  1 Apr 2026 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041693; cv=none; b=aGq19ywKoczzs5f+qL8OAmOwp0ycYWSLdoMaI5CwBPDxIZh7VyAUseMx8xGGPGL3C3BoeRLiSCKnCnFsKduR198ovu0L7Gn+ozki4I67xFwKDa5d23U0328UE9cgSHPb2o/PgpNMRYe/PyiDP9m7m9EgPVL8C9zcBRYBvg/meJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041693; c=relaxed/simple;
	bh=rlRFeRDc7nNGsnKoSU8sBKHAXZjyG7tk1BVQ2QYJ310=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB2+BC33a+Qvko8IPZrWohqyOnKkYZuqUqLyAhheDfW1KAQnCCI/4lIdsIhvIeN3oUrq09m/4UqAtG7NebGIKVz+HXcXjaP9/v6i9tDPpj2XfpICcn0hcU9yBz+2a2ZU0Rmd+JaLJp6kn6YvFKzP/uTB8BlETpu3Qu6H5csn7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lm1/Oucy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EZIpCN9Y; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=q3ydXVuF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=INUdjBYh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68DBD5BD9B;
	Wed,  1 Apr 2026 11:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775041689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyTjX+7gYFGs/V0ReF4YKYRShc/UaAx67M+99AWTHXg=;
	b=Lm1/OucyVPxvlpIQSHxeZ947XENpxtQcrAJMPYNwo0OqfFUO2LLVvYjgeOoo3CK3spVh/h
	3keGC+MCrp3EVKI3Y8DRfxGKzdloMVSZy3DXu16AP2OBlxzXvTdWgcXrbxbVkjWytIUPc9
	svJPxLATcfPQ73QtX75AY4zobDjaJ+E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775041689;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyTjX+7gYFGs/V0ReF4YKYRShc/UaAx67M+99AWTHXg=;
	b=EZIpCN9YL7pYI06K2vgVPcVWxoXWOAb8I6kfU+P+anC7WiLahUBYKqRP2PActbHiQbglA/
	m85o2xRw81mMUICw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=q3ydXVuF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=INUdjBYh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775041688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyTjX+7gYFGs/V0ReF4YKYRShc/UaAx67M+99AWTHXg=;
	b=q3ydXVuFVxfH8iEkkfH8BtFtNcXz63n4VgJmlyPpSpUOxGHACUrfdme9DuvfTMHWOKu/PL
	ze1ks8WiQEWqah46R37DHTlN1qtlf8V/sP8LYw1GXCQRqp/M6rfOX8SCA4L+sghn7zEPFN
	4oFT42Xh3KjZoCEYjhnHh+2pw+jVOSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775041688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gyTjX+7gYFGs/V0ReF4YKYRShc/UaAx67M+99AWTHXg=;
	b=INUdjBYh8tlcTC4rUTQza3BTc0IwPuKHOjU3huRK9bSLq8naJWkk7te6DcxkJQBYXYDSvn
	wvkjrT5rKA5RBtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A78104A0B0;
	Wed,  1 Apr 2026 11:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sm16JZb8zGnULwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 01 Apr 2026 11:08:06 +0000
Date: Wed, 1 Apr 2026 12:08:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Muchun Song <muchun.song@linux.dev>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Petr Tesarik <ptesarik@suse.com>, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] slab: remove the SLUB_DEBUG functionality and config
 option
Message-ID: <vjwodyrd7h72xutanjmgeriu37gwp5ooqakimaifk33347ka7g@adlojotcd4j3>
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
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15146-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.org,cmpxchg.org,linux.dev,google.com,arm.com,oracle.com,gentwo.org,infradead.org,suse.com,vger.kernel.org,googlegroups.com,kvack.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim]
X-Rspamd-Queue-Id: AC7523792AC
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
> 
> Since the slub kunit test depends on SLUB_DEBUG, remove it too. It's not
> a big loss, see the first point above.

Did you check if there's a performance regression with this patch?

> 
> Singed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

LGTM, thanks

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

-- 
Pedro

