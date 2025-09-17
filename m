Return-Path: <cgroups+bounces-10193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9D9B7ED51
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC363A8056
	for <lists+cgroups@lfdr.de>; Wed, 17 Sep 2025 09:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E862D7DDC;
	Wed, 17 Sep 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBSD/CJ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p+dXr11a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBSD/CJ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="p+dXr11a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE6028002B
	for <cgroups@vger.kernel.org>; Wed, 17 Sep 2025 09:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100699; cv=none; b=qvqGkhsN3BkuT6abwcp1m1VWblRASls9Th1AvCH9tRWvKOxMweSHAHOeU3OSGfH4NqkWHNhuDXtsgFz/qV4KcoIgmRg/QbTBVH+ZeiFR7VsrWfE0fgRhg/zS/LY65fPeOazOEXmrCoWJUdbyo/XNGvmEFrhKpO3mHSYU1Ixf/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100699; c=relaxed/simple;
	bh=kBZi6VUKm0pLXG91GDDQrv9k/W3raNeqHHPY5sq2VVc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TejqUb3PiGEdB6BoKuBzAGpXY1QqBnO4O9p7TPghcq+fJUQTiZwclwrZ4Ejo4tLY5DZK/sSUbu3FcofADrugnKfioYIdh9Gyhl6XsWzVdWTnlUxBE28UsOEAuwMkVOGLDBI+2ps+xCMGbZt9+ehmn5h0Qi3ZucsnzSIclK7kSC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBSD/CJ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p+dXr11a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBSD/CJ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=p+dXr11a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 95AEB21DA6;
	Wed, 17 Sep 2025 09:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758100695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HdoRh34zKgekx7h76Ak8Vo2WP4hVIe9wi/o5NYVnBo=;
	b=TBSD/CJ7aEAdZOulQqwYzv9ky15Gudyaio1J6JHoIca6qxFC3rHhtZmGW8ivvyANCzo0Rx
	/uIJRJ0Ee2ztSA+X7Q5XBL034hndjGei79CNFwkZXuOdf1Tch986d1v2GxifMxG1fmR5BY
	ZUdWzIFk0odFAK/B3bChMKHKvcMJ+/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758100695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HdoRh34zKgekx7h76Ak8Vo2WP4hVIe9wi/o5NYVnBo=;
	b=p+dXr11aPLofkChHMIFbeHMXb4klD4OvXTq3o2B3Vuah+Bi+9jmnyIa8zmE5/cDauMo5Z3
	MDNmjUacUjKjJ8Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758100695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HdoRh34zKgekx7h76Ak8Vo2WP4hVIe9wi/o5NYVnBo=;
	b=TBSD/CJ7aEAdZOulQqwYzv9ky15Gudyaio1J6JHoIca6qxFC3rHhtZmGW8ivvyANCzo0Rx
	/uIJRJ0Ee2ztSA+X7Q5XBL034hndjGei79CNFwkZXuOdf1Tch986d1v2GxifMxG1fmR5BY
	ZUdWzIFk0odFAK/B3bChMKHKvcMJ+/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758100695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/HdoRh34zKgekx7h76Ak8Vo2WP4hVIe9wi/o5NYVnBo=;
	b=p+dXr11aPLofkChHMIFbeHMXb4klD4OvXTq3o2B3Vuah+Bi+9jmnyIa8zmE5/cDauMo5Z3
	MDNmjUacUjKjJ8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73F26137C3;
	Wed, 17 Sep 2025 09:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D3umG9d8ymhqHAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 17 Sep 2025 09:18:15 +0000
Message-ID: <ead41e07-c476-4769-aeb6-5a9950737b98@suse.cz>
Date: Wed, 17 Sep 2025 11:18:15 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next:master] [slab] db93cdd664:
 BUG:kernel_NULL_pointer_dereference,address
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: kernel test robot <oliver.sang@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Harry Yoo <harry.yoo@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <202509171214.912d5ac-lkp@intel.com>
 <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <b7d4cf85-5c81-41e0-9b22-baa9a7e5a0c4@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30

On 9/17/25 10:03, Vlastimil Babka wrote:
> On 9/17/25 07:01, kernel test robot wrote:
>> 
>> 
>> Hello,
>> 
>> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
>> 
>> commit: db93cdd664fa02de9be883dd29343b21d8fc790f ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>> 
>> in testcase: boot
>> 
>> config: i386-randconfig-062-20250913
>> compiler: clang-20
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>> 
>> (please refer to attached dmesg/kmsg for entire log/backtrace)

Managed to reproduce locally and my suggested fix works so I'm going to fold
it unless there's objections or better suggestions.

Also I was curious to find out which path is triggered so I've put a
dump_stack() before the kmalloc_nolock call:

[    0.731812][    T0] Call Trace:
[    0.732406][    T0]  __dump_stack+0x18/0x30
[    0.733200][    T0]  dump_stack_lvl+0x32/0x90
[    0.734037][    T0]  dump_stack+0xd/0x20
[    0.734780][    T0]  alloc_slab_obj_exts+0x181/0x1f0
[    0.735862][    T0]  __alloc_tagging_slab_alloc_hook+0xd1/0x330
[    0.736988][    T0]  ? __slab_alloc+0x4e/0x70
[    0.737858][    T0]  ? __set_page_owner+0x167/0x280
[    0.738774][    T0]  __kmalloc_cache_noprof+0x379/0x460
[    0.739756][    T0]  ? depot_fetch_stack+0x164/0x180
[    0.740687][    T0]  ? __set_page_owner+0x167/0x280
[    0.741604][    T0]  __set_page_owner+0x167/0x280
[    0.742503][    T0]  post_alloc_hook+0x17a/0x200
[    0.743404][    T0]  get_page_from_freelist+0x13b3/0x16b0
[    0.744427][    T0]  ? kvm_sched_clock_read+0xd/0x20
[    0.745358][    T0]  ? kvm_sched_clock_read+0xd/0x20
[    0.746290][    T0]  ? __next_zones_zonelist+0x26/0x60
[    0.747265][    T0]  __alloc_frozen_pages_noprof+0x143/0x1080
[    0.748358][    T0]  ? lock_acquire+0x8b/0x180
[    0.749209][    T0]  ? pcpu_alloc_noprof+0x181/0x800
[    0.750198][    T0]  ? sched_clock_noinstr+0x8/0x10
[    0.751119][    T0]  ? local_clock_noinstr+0x137/0x140
[    0.752089][    T0]  ? kvm_sched_clock_read+0xd/0x20
[    0.753023][    T0]  alloc_slab_page+0xda/0x150
[    0.753879][    T0]  new_slab+0xe1/0x500
[    0.754615][    T0]  ? kvm_sched_clock_read+0xd/0x20
[    0.755577][    T0]  ___slab_alloc+0xd79/0x1680
[    0.756469][    T0]  ? pcpu_alloc_noprof+0x538/0x800
[    0.757408][    T0]  ? __mutex_unlock_slowpath+0x195/0x3e0
[    0.758446][    T0]  __slab_alloc+0x4e/0x70
[    0.759237][    T0]  ? mm_alloc+0x38/0x80
[    0.759993][    T0]  kmem_cache_alloc_noprof+0x1db/0x470
[    0.760993][    T0]  ? mm_alloc+0x38/0x80
[    0.761745][    T0]  ? mm_alloc+0x38/0x80
[    0.762506][    T0]  mm_alloc+0x38/0x80
[    0.763260][    T0]  poking_init+0xe/0x80
[    0.764032][    T0]  start_kernel+0x16b/0x470
[    0.764858][    T0]  i386_start_kernel+0xce/0xf0
[    0.765723][    T0]  startup_32_smp+0x151/0x160

And the reason is we still have restricted gfp_allowed_mask at this point:
/* The GFP flags allowed during early boot */
#define GFP_BOOT_MASK (__GFP_BITS_MASK & ~(__GFP_RECLAIM|__GFP_IO|__GFP_FS))

It's only lifted to a full allowed mask later in the boot.

That means due to "kmalloc_nolock() is not supported on architectures that
don't implement cmpxchg16b" such architectures will no longer get objexts
allocated in early boot. I guess that's not a big deal.

Also any later allocation having its flags screwed for some reason to not
have __GFP_RECLAIM will also lose its objexts. Hope that's also acceptable.
I don't know if we can distinguish a real kmalloc_nolock() scope in
alloc_slab_obj_exts() without inventing new gfp flags or passing an extra
argument through several layers of functions.

>> 
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202509171214.912d5ac-lkp@intel.com
>> 
>> 
>> [    7.101117][    T0] BUG: kernel NULL pointer dereference, address: 00000010
>> [    7.102290][    T0] #PF: supervisor read access in kernel mode
>> [    7.103219][    T0] #PF: error_code(0x0000) - not-present page
>> [    7.104161][    T0] *pde = 00000000
>> [    7.104762][    T0] Thread overran stack, or stack corrupted
> 
> Note this.
> 
>> [    7.105726][    T0] Oops: Oops: 0000 [#1]
>> [    7.106410][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Tainted: G                T   6.17.0-rc3-00014-gdb93cdd664fa #1 NONE  40eff3b43e4f0000b061f2e660abd0b2911f31b1
>> [    7.108712][    T0] Tainted: [T]=RANDSTRUCT
>> [    7.109368][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [ 7.110952][ T0] EIP: kmalloc_nolock_noprof (mm/slub.c:5607) 
> 
> That's here.
> if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
> 
> dmesg already contains line "SLUB: HWalign=64, Order=0-3, MinObjects=0,
> CPUs=1, Nodes=1" so all kmem caches are fully initialized, so doesn't look
> like a bootstrap issue. Probably it's due to the stack overflow and not
> actual bug on this line.
> 
> Because of that it's also unable to print the backtrace. But the only
> kmallock_nolock usage for now is in slub itself, alloc_slab_obj_exts():
> 
>         /* Prevent recursive extension vector allocation */
>         gfp |= __GFP_NO_OBJ_EXT;
>         if (unlikely(!allow_spin)) {
>                 size_t sz = objects * sizeof(struct slabobj_ext);
> 
>                 vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
>         } else {
>                 vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
>                                    slab_nid(slab));
>         }
> 
> Prevent recursive... hm? And we had stack overflow?
> Also .config has CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT=y
> 
> So, this?
> diff --git a/mm/slub.c b/mm/slub.c
> index 837ee037abb5..c4f17ac6e4b6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2092,7 +2092,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	if (unlikely(!allow_spin)) {
>  		size_t sz = objects * sizeof(struct slabobj_ext);
>  
> -		vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
> +		vec = kmalloc_nolock(sz, __GFP_ZERO | __GFP_NO_OBJ_EXT,
> +				     slab_nid(slab));
>  	} else {
>  		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
>  				   slab_nid(slab));
> @@ -5591,7 +5592,8 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>  	bool can_retry = true;
>  	void *ret = ERR_PTR(-EBUSY);
>  
> -	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
> +				      __GFP_NO_OBJ_EXT));
>  
>  	if (unlikely(!size))
>  		return ZERO_SIZE_PTR;
> 


