Return-Path: <cgroups+bounces-1275-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F38B842232
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB771F2E523
	for <lists+cgroups@lfdr.de>; Tue, 30 Jan 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9276C66B47;
	Tue, 30 Jan 2024 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="upl+k7v2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bA274UEq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="upl+k7v2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bA274UEq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07066B4C;
	Tue, 30 Jan 2024 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612701; cv=none; b=ZXcb+SM8NsXLvJe0WRkLHKlsQ6YcEFryNUR28JmOjo0tFoPozgCMUrxJ52A0SYekPZ9nBrl93zljvUsm2IadbNjCu6Ghfi40bf9DOQ0eGhVMeodBW+MNisa6SYm/f4q6bz1dIzN45OUj+anRpRdAt34WqGK6Sp/24Sl2SJl/Lzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612701; c=relaxed/simple;
	bh=PdeoMiYgUER3iysKvji/sSX8mFKzGpxS1nsIZk+d188=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dfHVzTKq/eFwrO3w/58It+v/I+2bEf016Va8qwYDg6J94/NI/UR3sAwhONucvjilSFhsIc55KTL75/9BYI/i2IcFkoYyiV6I8cGvCorheWniy0bdFRXuO1gN+iJPHIy72ES8iE4T49TC1yRHUlINSMMhpHwiDMyD5sH+bng677E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=upl+k7v2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bA274UEq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=upl+k7v2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bA274UEq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98AFC1F842;
	Tue, 30 Jan 2024 11:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706612697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC3VT/yxm8QuquH0mJbFZHi45tefg50JMHGoP/3fP8=;
	b=upl+k7v2jgC8e/LOcqed3oJ7nMEKZZwBBVVFePzAUZivut0SOR3ayyCUaQEkqeOtEU2wlN
	EBECpioeOmWyyQ9aYCJ1GVRZDjTtNrEhDbND7YGNXMzI1rFjXrKUwRXZDhIbx8XMzjYOOU
	FJ3AJS2RJq+ToBlBmw7fxgdaMHJy/SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706612697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC3VT/yxm8QuquH0mJbFZHi45tefg50JMHGoP/3fP8=;
	b=bA274UEqLWuoPqTyOiMkMod8zh206bkz2t3SI/Lg/j24OKwKuIzwxprbxrwonjFXWwe5qr
	bOS/gUc8alVD1JCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706612697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC3VT/yxm8QuquH0mJbFZHi45tefg50JMHGoP/3fP8=;
	b=upl+k7v2jgC8e/LOcqed3oJ7nMEKZZwBBVVFePzAUZivut0SOR3ayyCUaQEkqeOtEU2wlN
	EBECpioeOmWyyQ9aYCJ1GVRZDjTtNrEhDbND7YGNXMzI1rFjXrKUwRXZDhIbx8XMzjYOOU
	FJ3AJS2RJq+ToBlBmw7fxgdaMHJy/SI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706612697;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UKC3VT/yxm8QuquH0mJbFZHi45tefg50JMHGoP/3fP8=;
	b=bA274UEqLWuoPqTyOiMkMod8zh206bkz2t3SI/Lg/j24OKwKuIzwxprbxrwonjFXWwe5qr
	bOS/gUc8alVD1JCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F88012FF7;
	Tue, 30 Jan 2024 11:04:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pETmGtnXuGVMPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 30 Jan 2024 11:04:57 +0000
Message-ID: <8fc59462-2940-4e60-95f1-2955a8c24ea0@suse.cz>
Date: Tue, 30 Jan 2024 12:04:57 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/4] fs/locks: Fix file lock cache accounting, again
From: Vlastimil Babka <vbabka@suse.cz>
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
 Howard McLauchlan <hmclauchlan@fb.com>, bpf <bpf@vger.kernel.org>
References: <cover.1705507931.git.jpoimboe@kernel.org>
 <ac84a832feba5418e1b58d1c7f3fe6cc7bc1de58.1705507931.git.jpoimboe@kernel.org>
 <6667b799702e1815bd4e4f7744eddbc0bd042bb7.camel@kernel.org>
 <20240117193915.urwueineol7p4hg7@treble>
 <CAHk-=wg_CoTOfkREgaQQA6oJ5nM9ZKYrTn=E1r-JnvmQcgWpSg@mail.gmail.com>
 <CALvZod6LgX-FQOGgNBmoRACMBK4GB+K=a+DYrtExcuGFH=J5zQ@mail.gmail.com>
 <ZahSlnqw9yRo3d1v@P9FQF9L96D.corp.robot.car>
 <CALvZod4V3QTULTW5QxgqCbDpNtVO6fXzta33HR7GN=L2LUU26g@mail.gmail.com>
 <CAHk-=whYOOdM7jWy5jdrAm8LxcgCMFyk2bt8fYYvZzM4U-zAQA@mail.gmail.com>
 <6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz>
Content-Language: en-US
In-Reply-To: <6d5bb852-8703-4abf-a52b-90816bccbd7f@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.09

On 1/26/24 10:50, Vlastimil Babka wrote:
> On 1/22/24 06:10, Linus Torvalds wrote:
>> On Wed, 17 Jan 2024 at 14:56, Shakeel Butt <shakeelb@google.com> wrote:
>>> >
>>> > So I don't see how we can make it really cheap (say, less than 5% overhead)
>>> > without caching pre-accounted objects.
>>>
>>> Maybe this is what we want. Now we are down to just SLUB, maybe such
>>> caching of pre-accounted objects can be in SLUB layer and we can
>>> decide to keep this caching per-kmem-cache opt-in or always on.
>> 
>> So it turns out that we have another case of SLAB_ACCOUNT being quite
>> a big expense, and it's actually the normal - but failed - open() or
>> execve() case.
>> 
>> See the thread at
>> 
>>     https://lore.kernel.org/all/CAHk-=whw936qzDLBQdUz-He5WK_0fRSWwKAjtbVsMGfX70Nf_Q@mail.gmail.com/
>> 
>> and to see the effect in profiles, you can use this EXTREMELY stupid
>> test program:
>> 
>>     #include <fcntl.h>
>> 
>>     int main(int argc, char **argv)
>>     {
>>         for (int i = 0; i < 10000000; i++)
>>                 open("nonexistent", O_RDONLY);
>>     }
> 
> This reminded me I can see should_failslab() in the profiles (1.43% plus the
> overhead in its caller) even if it does nothing at all, and it's completely
> unconditional since commit 4f6923fbb352 ("mm: make should_failslab always
> available for fault injection").
> 
> We discussed it briefly when Jens tried to change it in [1] to depend on
> CONFIG_FAILSLAB again. But now I think it should be even possible to leave
> it always available, but behind a static key. BPF or whoever else uses these
> error injection hooks would have to track how many users of them are active
> and manage the static key accordingly. Then it could be always available,
> but have no overhead when there's no active user? Other similars hooks could
> benefit from such an approach too?
> 
> [1]
> https://lore.kernel.org/all/e01e5e40-692a-519c-4cba-e3331f173c82@kernel.dk/#t

Just for completeness, with the hunk below I've seen some 2% improvement on
the test program from Linus.
Of course something needs to operate the static key and I'm not familiar
enough with bpf and related machinery whether it's tracking users of the
injection points already where the static key toggling could be hooked.

diff --git a/mm/slub.c b/mm/slub.c
index 2ef88bbf56a3..da07b358d092 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3750,6 +3750,8 @@ noinline int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
 }
 ALLOW_ERROR_INJECTION(should_failslab, ERRNO);
 
+static DEFINE_STATIC_KEY_FALSE(failslab_enabled);
+
 static __fastpath_inline
 struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
                                       struct list_lru *lru,
@@ -3760,8 +3762,10 @@ struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
 
        might_alloc(flags);
 
-       if (unlikely(should_failslab(s, flags)))
-               return NULL;
+       if (static_branch_unlikely(&failslab_enabled)) {
+               if (unlikely(should_failslab(s, flags)))
+                       return NULL;
+       }
 
        if (unlikely(!memcg_slab_pre_alloc_hook(s, lru, objcgp, size, flags)))
                return NULL;




