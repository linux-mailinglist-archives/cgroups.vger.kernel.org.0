Return-Path: <cgroups+bounces-1235-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0B183D7CC
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 11:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A7001F3102E
	for <lists+cgroups@lfdr.de>; Fri, 26 Jan 2024 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3506C1B7F4;
	Fri, 26 Jan 2024 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MEoO9Glb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YuZ0vCY2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W9rBeTum";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SX4rZHVl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F5C12B74;
	Fri, 26 Jan 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262649; cv=none; b=GzVVSpUJxS1hAq+jXNCRFskJhXTD/funUZQc0taJw3N9eSh2kUbWtyc3TvdtwzCgLzKG7qG4jJjPfrKWQ2YX0/QduqufYcQgiqI5SVQisQW1SwIN9YH46JcVu7ULY7dCo2Np2W5u9c+HiNkZrURmki70dkZYXIspPcyDp3oL5P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262649; c=relaxed/simple;
	bh=Ia6yD19K6LEzCtieN+qCdaD3X0tlGXT6OuBrNKG+Me8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mz3EQ1vHY2DUj/PiEe4oTM3gHQInggVQ2bWVvifJaYhbqnYmlwYsrGM4ec+A32Bv3rYgmjzu1qP+w30RJ4HFqWlup+YrRdCuEEd0BsE68mOAMD/ZVydqlk8IvoXNbxYgs2b15SGXf6xG3ycj5R0Mte0vKaxn2OrJ/eeSBoODRAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MEoO9Glb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YuZ0vCY2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W9rBeTum; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SX4rZHVl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C9AF71FB7A;
	Fri, 26 Jan 2024 09:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706262645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is/iDqG+bFU4E9wUAmu+LNf+g2iaZiR01G55UWoy7os=;
	b=MEoO9GlbedZvXve6QHsK1QdoWZIQv4eRNChypkr/YXRrnx4HOQxqPvTlHcaKEPFRFC7qHR
	s4oP5Msj1TGaT4e5dp5PlzAArIk6kZBlg4kibvo0/zsQgwnzaa1OYQu87pgB+qMB0RbY73
	fBgb74SyYet6SbnYouZ9145T1giU2zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706262645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is/iDqG+bFU4E9wUAmu+LNf+g2iaZiR01G55UWoy7os=;
	b=YuZ0vCY2RUr47eeXxpscatHm+HaSj2sx6VCP3xTcqP3womfttreIVAZBkoqYd8wzK2+1Hx
	QJerbUgzAYlXRZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706262644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is/iDqG+bFU4E9wUAmu+LNf+g2iaZiR01G55UWoy7os=;
	b=W9rBeTum0wpjO2D7yah0YPyiRATruBHH9CIgYimw/WyDwk+4vSqAk08aVsx7Ydh+YNdnRl
	UoA/WOIunC18uxcHrWXZxjTVJqAOMTs8ZqW9Yv5ZjJoYUf7Tz+/kqfFzq/Jz3lwRXkTjZM
	CSnkiMJkmxSv/Ts6WIe2IpTJl1yicOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706262644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Is/iDqG+bFU4E9wUAmu+LNf+g2iaZiR01G55UWoy7os=;
	b=SX4rZHVlVlkurAoXw0N++Ro+65TznaDVpGBEoiQhsTHdGmWv+jsaGSg9rotzyZ8PIXzd6e
	pWMQearG3LL9nKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FCAF134C3;
	Fri, 26 Jan 2024 09:50:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ooKsJnSAs2WFFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 26 Jan 2024 09:50:44 +0000
Message-ID: <6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz>
Date: Fri, 26 Jan 2024 10:50:44 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
 Vasily Averin <vasily.averin@linux.dev>, Michal Koutny <mkoutny@suse.com>,
 Waiman Long <longman@redhat.com>, Muchun Song <muchun.song@linux.dev>,
 Jiri Kosina <jikos@kernel.org>, cgroups@vger.kernel.org, linux-mm@kvack.org,
 Howard McLauchlan <hmclauchlan@fb.com>, bpf <bpf@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble>
 <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
 <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
 <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
 <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=W9rBeTum;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SX4rZHVl
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[21];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.50
X-Rspamd-Queue-Id: C9AF71FB7A
X-Spam-Flag: NO

On 1/22/24 06:10, Linus Torvalds wrote:
> On Wed, 17 Jan 2024 at 14:56, Shakeel Butt <shakeelb@google.com> wrote:
>> >
>> > So I don't see how we can make it really cheap (say, less than 5% overhead)
>> > without caching pre-accounted objects.
>>
>> Maybe this is what we want. Now we are down to just SLUB, maybe such
>> caching of pre-accounted objects can be in SLUB layer and we can
>> decide to keep this caching per-kmem-cache opt-in or always on.
> 
> So it turns out that we have another case of SLAB_ACCOUNT being quite
> a big expense, and it's actually the normal - but failed - open() or
> execve() case.
> 
> See the thread at
> 
>     https://lore.kernel.org/all/CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com/
> 
> and to see the effect in profiles, you can use this EXTREMELY stupid
> test program:
> 
>     #include <fcntl.h>
> 
>     int main(int argc, char **argv)
>     {
>         for (int i = 0; i < 10000000; i++)
>                 open("nonexistent", O_RDONLY);
>     }

This reminded me I can see should_failslab() in the profiles (1.43% plus the
overhead in its caller) even if it does nothing at all, and it's completely
unconditional since commit 4f6923fbb352 ("mm: make should_failslab always
available for fault injection").

We discussed it briefly when Jens tried to change it in [1] to depend on
CONFIG_FAILSLAB again. But now I think it should be even possible to leave
it always available, but behind a static key. BPF or whoever else uses these
error injection hooks would have to track how many users of them are active
and manage the static key accordingly. Then it could be always available,
but have no overhead when there's no active user? Other similars hooks could
benefit from such an approach too?

[1]
https://lore.kernel.org/all/e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk/#t


> where the point of course is that the "nonexistent" pathname doesn't
> actually exist (so don't create a file called that for the test).
> 
> What happens is that open() allocates a 'struct file *' early from the
> filp kmem_cache, which has SLAB_ACCOUNT set. So we'll do accounting
> for it, failt the pathname open, and free it again, which uncharges
> the accounting.
> 
> Now, in this case, I actually have a suggestion: could we please just
> make SLAB_ACCOUNT be something that we do *after* the allocation, kind
> of the same way the zeroing works?
> 
> IOW, I'd love to get rid of slab_pre_alloc_hook() entirely, and make
> slab_post_alloc_hook() do all the "charge the memcg if required".
> 
> Obviously that means that now a failure to charge the memcg would have
> to then de-allocate things, but that's an uncommon path and would be
> marked unlikely and not be in the hot path at all.
> 
> Now, the reason I would prefer that is that the *second* step would be to
> 
>  (a) expose a "kmem_cache_charge()" function that takes a
> *non*-accounted slab allocation, and turns it into an accounted one
> (and obviously this is why you want to do everything in the post-alloc
> hook: just try to share this code)
> 
>  (b) remote the SLAB_ACCOUNT from the filp_cachep, making all file
> allocations start out unaccounted.
> 
>  (c) when we have *actually* looked up the pathname and open the file
> successfully, at *that* point we'd do a
> 
>         error = kmem_cache_charge(filp_cachep, file);
> 
>     in do_dentry_open() to turn the unaccounted file pointer into an
> accounted one (and if that fails, we do the cleanup and free it, of
> course, exactly like we do when file_get_write_access() fails)
> 
> which means that now the failure case doesn't unnecessarily charge the
> allocation that never ends up being finalized.
> 
> NOTE! I think this would clean up mm/slub.c too, simply because it
> would get rid of that memcg_slab_pre_alloc_hook() entirely, and get
> rid of the need to carry the "struct obj_cgroup **objcgp" pointer
> along until the post-alloc hook: everything would be done post-alloc.
> 
> The actual kmem_cache_free() code already deals with "this slab hasn't
> been accounted" because it obviously has to deal with allocations that
> were done without __GFP_ACCOUNT anyway. So there's no change needed on
> the freeing path, it already has to handle this all gracefully.
> 
> I may be missing something, but it would seem to have very little
> downside, and fix a case that actually is visible right now.
> 
>               Linus


