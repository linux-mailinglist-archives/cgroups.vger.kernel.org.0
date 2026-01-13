Return-Path: <cgroups+bounces-13148-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B08D18F16
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 020DC30915CC
	for <lists+cgroups@lfdr.de>; Tue, 13 Jan 2026 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678D38FF0C;
	Tue, 13 Jan 2026 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PtKODF2C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PT3EfSwo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZSqy1HgV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EG7JhaQ4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CA638F93C
	for <cgroups@vger.kernel.org>; Tue, 13 Jan 2026 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308637; cv=none; b=l7yfG06sh+Y8FWoQMLJjk9ZKTs9mrzTWLMfxWInD4ZzoWimgipLpuiBmjxfNg+Tg7YEZUDhiprySfZ7zuHL4mnSkXhEEqR7RzFpUikHKfCNZvhz9Xw3fv9bwERwqoRC0IotjBIlJP3PijjkusLwbeOAC9kfUOUfG7KoiwQ09EVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308637; c=relaxed/simple;
	bh=YReuZ8zKuekpIYu0vNYuZ28I+evIFykGn2Uh/X/gnkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nexYvi3Sx8EdWg1U76XBbM2REpyx5IZW/aQXAEj2ygVGqYaQdisBr739qeH+D6J1MThybTBxpxT4pMIbkrCxQui3N2QvVl3xetnwio6Bo99epF5INeDIJWobyL3jkNI2ufvpE2uHoC84h3oJBZrdPW4uCVw3InCyVb2p8W9+ytg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PtKODF2C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PT3EfSwo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZSqy1HgV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EG7JhaQ4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B86A45BCDD;
	Tue, 13 Jan 2026 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768308633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2njxT4444vBXRDjwl5oV8xG18I9Zx+u69QZ0TThv5yQ=;
	b=PtKODF2C89mNQqZDnNW2Ix+E9RLbAX94raLi8h+W9Y1olJTvTw0oa/89eqwUySXclG1WBW
	95G9xw46Y7qgGlCVcEZHRvbSaStEd48FmkoXPKREfZSz/EWbmGkkm7qgCSi0icYohGOa32
	c7hJm/eHvi7soMeADZNFEmsoVYLRLs0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768308633;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2njxT4444vBXRDjwl5oV8xG18I9Zx+u69QZ0TThv5yQ=;
	b=PT3EfSwoctTCsX9vB1Ictmh6xkEmd0eEmdzyC0Jr2biwYKQCtE8Q44XvRPgSkP5fP5bkPb
	Klk3Cc+i/j3wyADg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768308632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2njxT4444vBXRDjwl5oV8xG18I9Zx+u69QZ0TThv5yQ=;
	b=ZSqy1HgVgimt5AtDjjv8i7a1DInik/wFsJk9b01D5CW4aY7HKqj+ofIOJmYnmdTGo3C/wP
	OMBE4bITRvIaFw3JaDIF7MvHEqBV+5Vg+2NQXDBinpjGsHpXAJ7euc9fc6AXt06y0Y9wJv
	w0cr5u1+rpleAm9sQ0OdrIV4imqElB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768308632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2njxT4444vBXRDjwl5oV8xG18I9Zx+u69QZ0TThv5yQ=;
	b=EG7JhaQ4NfhIbtJG05pU1lrvSj3BJrfB5/DXov0pm1cTgI+VHZxvL3YqbPo8oLov1Ue4+6
	RAOVPfao0Q82/KAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D3B93EA63;
	Tue, 13 Jan 2026 12:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kTzPGZg/ZmlzagAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 12:50:32 +0000
Message-ID: <fecd4166-618d-4d69-be02-d9b3e8f0f271@suse.cz>
Date: Tue, 13 Jan 2026 13:50:31 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 9/9] mm/slab: place slabobj_ext metadata in unused
 space within s->size
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260113061845.159790-1-harry.yoo@oracle.com>
 <20260113061845.159790-10-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <20260113061845.159790-10-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gentwo.org,google.com,cmpxchg.org,kvack.org,kernel.org,linux.dev,arm.com,mit.edu,dilger.ca,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,oracle.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/13/26 7:18 AM, Harry Yoo wrote:
> When a cache has high s->align value and s->object_size is not aligned
> to it, each object ends up with some unused space because of alignment.
> If this wasted space is big enough, we can use it to store the
> slabobj_ext metadata instead of wasting it.
> 
> On my system, this happens with caches like kmem_cache, mm_struct, pid,
> task_struct, sighand_cache, xfs_inode, and others.
> 
> To place the slabobj_ext metadata within each object, the existing
> slab_obj_ext() logic can still be used by setting:
> 
>   - slab->obj_exts = slab_address(slab) + (slabobj_ext offset)
>   - stride = s->size
> 
> slab_obj_ext() doesn't need know where the metadata is stored,
> so this method works without adding extra overhead to slab_obj_ext().
> 
> A good example benefiting from this optimization is xfs_inode
> (object_size: 992, align: 64). To measure memory savings, 2 millions of
> files were created on XFS.
> 
> [ MEMCG=y, MEM_ALLOC_PROFILING=n ]
> 
> Before patch (creating ~2.64M directories on xfs):
>   Slab:            5175976 kB
>   SReclaimable:    3837524 kB
>   SUnreclaim:      1338452 kB
> 
> After patch (creating ~2.64M directories on xfs):
>   Slab:            5152912 kB
>   SReclaimable:    3838568 kB
>   SUnreclaim:      1314344 kB (-23.54 MiB)
> 
> Enjoy the memory savings!
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Does this look OK to you or was there a reason you didn't do it? :)

diff --git a/mm/slub.c b/mm/slub.c
index ba15df4ca417..deb69bd9646a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -981,8 +981,7 @@ static inline bool obj_exts_in_slab(struct kmem_cache *s, struct slab *slab)
 #if defined(CONFIG_SLAB_OBJ_EXT) && defined(CONFIG_64BIT)
 static bool obj_exts_in_object(struct kmem_cache *s, struct slab *slab)
 {
-       return obj_exts_in_slab(s, slab) &&
-              (slab_get_stride(slab) == s->size);
+       return obj_exts_in_slab(s, slab) && (s->flags & SLAB_OBJ_EXT_IN_OBJ);
 }
 
 static unsigned int obj_exts_offset_in_object(struct kmem_cache *s)


