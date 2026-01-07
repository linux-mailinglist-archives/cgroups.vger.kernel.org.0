Return-Path: <cgroups+bounces-12948-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD9CFF882
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 19:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A6B2329664E
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 17:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7837935CB8B;
	Wed,  7 Jan 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9B4IYW1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMQDgDvq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9B4IYW1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMQDgDvq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18537346A00
	for <cgroups@vger.kernel.org>; Wed,  7 Jan 2026 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807823; cv=none; b=MfkWJoXZugwb1p/+zImMimiNnnDxJ8zBSfpdY0DqmWg+d7lA529rf3HBQVCwRiLkXmuR707Mp0bUp/+bNthkekS+RH5euxLJArC2Mel7VTCqJ4JzPrGG4i0JhvxHBceWOgH9B7mUCHxGmvVnpDh/181CReEUdzwGDEVh5A1nnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807823; c=relaxed/simple;
	bh=CVy31zC43f9X0TWwOZEkd2ypj+Ac0oN4odsdsmAQO9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ncn961kzPM+GbO9aj1LUdGWQxIO9LebuEvwjxAa1Zmct9gpdOedZCrbvpYsHv59hfDvhbPa8vx9pFjn/xNQHdiTOrW/2Mbu1cxIzoAG0HRIGbVuqodRkb9lqYEJaspqHwbwWyv/lHZJjFQAmJSf4l9d/A6e+xE1NiGzcSlOEBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9B4IYW1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMQDgDvq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9B4IYW1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMQDgDvq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 931F034063;
	Wed,  7 Jan 2026 17:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767807810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lGUqL9KTjnVMejcKxQZbj5hWRTaoZ4PIKb1md3pmVag=;
	b=C9B4IYW1tY4C+ZJ2UHAd8pkP14AIBeOdhDzu7v/kYuLhCkc459lT2SPvknmFHmejAj6b/b
	AehJmPCzv+nGGuYM4WAgotAcbwJ5UPTlJtaTmLYJCyo4p1qdreBAGoiKpsaF0p5fbxdMkT
	jQSYgr/D5eCC1bE1mvHXPq6OO9i3upE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767807810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lGUqL9KTjnVMejcKxQZbj5hWRTaoZ4PIKb1md3pmVag=;
	b=nMQDgDvqcs2P8S8lZDsu4LIgdj1cdscIovkzKG8qU9Adp4kjmGQmuMM8DmqPEgOXpWKNhO
	iY/uddSdv47QKfCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C9B4IYW1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nMQDgDvq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767807810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lGUqL9KTjnVMejcKxQZbj5hWRTaoZ4PIKb1md3pmVag=;
	b=C9B4IYW1tY4C+ZJ2UHAd8pkP14AIBeOdhDzu7v/kYuLhCkc459lT2SPvknmFHmejAj6b/b
	AehJmPCzv+nGGuYM4WAgotAcbwJ5UPTlJtaTmLYJCyo4p1qdreBAGoiKpsaF0p5fbxdMkT
	jQSYgr/D5eCC1bE1mvHXPq6OO9i3upE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767807810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lGUqL9KTjnVMejcKxQZbj5hWRTaoZ4PIKb1md3pmVag=;
	b=nMQDgDvqcs2P8S8lZDsu4LIgdj1cdscIovkzKG8qU9Adp4kjmGQmuMM8DmqPEgOXpWKNhO
	iY/uddSdv47QKfCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EFAD3EA63;
	Wed,  7 Jan 2026 17:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vPLGGkKbXmk2BgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 Jan 2026 17:43:30 +0000
Message-ID: <14a0f149-5d22-4a3b-9cbf-3336d0783e9d@suse.cz>
Date: Wed, 7 Jan 2026 18:43:30 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 0/8] mm/slab: reduce slab accounting memory overhead by
 allocating slabobj_ext metadata within unsed slab space
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, akpm@linux-foundation.org
Cc: andreyknvl@gmail.com, cl@gentwo.org, dvyukov@google.com,
 glider@google.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 mhocko@kernel.org, muchun.song@linux.dev, rientjes@google.com,
 roman.gushchin@linux.dev, ryabinin.a.a@gmail.com, shakeel.butt@linux.dev,
 surenb@google.com, vincenzo.frascino@arm.com, yeoreum.yun@arm.com,
 tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, hao.li@linux.dev
References: <20260105080230.13171-1-harry.yoo@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20260105080230.13171-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
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
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 931F034063
X-Spam-Flag: NO
X-Spam-Score: -3.01

On 1/5/26 09:02, Harry Yoo wrote:
> Happy new year!
> 
> V4: https://lore.kernel.org/linux-mm/20251027122847.320924-1-harry.yoo@oracle.com
> V4 -> V5:
> - Patch 4: Fixed returning false when the return type is unsigned long
> - Patch 7: Fixed incorrect calculation of slabobj_ext offset (Thanks Hao!)

Besides the stuff pointed out the rest seemed ok to me. Can you resend with
those addressed, and rebased on slab.git slab/for-7.0/obj_metadata to avoid
a conflict in patch 8/8 with Hao's comment update patch there? I will add
the series on top there then. Thanks!

> When CONFIG_MEMCG and CONFIG_MEM_ALLOC_PROFILING are enabled,
> the kernel allocates two pointers per object: one for the memory cgroup
> (actually, obj_cgroup) to which it belongs, and another for the code
> location that requested the allocation.
> 
> In two special cases, this overhead can be eliminated by allocating
> slabobj_ext metadata from unused space within a slab:
> 
>   Case 1. The "leftover" space after the last slab object is larger than
>           the size of an array of slabobj_ext.
> 
>   Case 2. The per-object alignment padding is larger than
>           sizeof(struct slabobj_ext).
> 
> For these two cases, one or two pointers can be saved per slab object.
> Examples: ext4 inode cache (case 1) and xfs inode cache (case 2).
> That's approximately 0.7-0.8% (memcg) or 1.5-1.6% (memcg + mem profiling)
> of the total inode cache size.
> 
> Implementing case 2 is not straightforward, because the existing code
> assumes that slab->obj_exts is an array of slabobj_ext, while case 2
> breaks the assumption.
> 
> As suggested by Vlastimil, abstract access to individual slabobj_ext
> metadata via a new helper named slab_obj_ext():
> 
> static inline struct slabobj_ext *slab_obj_ext(struct slab *slab,
>                                                unsigned long obj_exts,
>                                                unsigned int index)
> {
>         return (struct slabobj_ext *)(obj_exts + slab_get_stride(slab) * index);
> } 
> 
> In the normal case (including case 1), slab->obj_exts points to an array
> of slabobj_ext, and the stride is sizeof(struct slabobj_ext).
> 
> In case 2, the stride is s->size and
> slab->obj_exts = slab_address(slab) + s->red_left_pad + (offset of slabobj_ext)
> 
> With this approach, the memcg charging fastpath doesn't need to care the
> storage method of slabobj_ext.
> 
> Harry Yoo (8):
>   mm/slab: use unsigned long for orig_size to ensure proper metadata
>     align
>   mm/slab: allow specifying free pointer offset when using constructor
>   ext4: specify the free pointer offset for ext4_inode_cache
>   mm/slab: abstract slabobj_ext access via new slab_obj_ext() helper
>   mm/slab: use stride to access slabobj_ext
>   mm/memcontrol,alloc_tag: handle slabobj_ext access under KASAN poison
>   mm/slab: save memory by allocating slabobj_ext array from leftover
>   mm/slab: place slabobj_ext metadata in unused space within s->size
> 
>  fs/ext4/super.c      |  20 ++-
>  include/linux/slab.h |  39 +++--
>  mm/memcontrol.c      |  31 +++-
>  mm/slab.h            | 120 ++++++++++++++-
>  mm/slab_common.c     |   8 +-
>  mm/slub.c            | 345 +++++++++++++++++++++++++++++++++++--------
>  6 files changed, 466 insertions(+), 97 deletions(-)
> 


