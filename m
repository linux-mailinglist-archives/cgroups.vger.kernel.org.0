Return-Path: <cgroups+bounces-10661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF09BD3821
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 16:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F9354F4B99
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 14:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B701265CAD;
	Mon, 13 Oct 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEpsrrYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5pjDvXRA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEpsrrYD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5pjDvXRA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF91E5B7A
	for <cgroups@vger.kernel.org>; Mon, 13 Oct 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760365394; cv=none; b=C9uwMXox782lu2rYmgJpVqjQb39SYXeeL5ETfh4oQdXPjBHosRMXzro1aHx51VxpAcsGl17jJ21mibZPh28fXOcXIafW0gdhCtlAksZ/NsX8yRxW7jRgYHz9jIO5RANeQ6keM30OmNyJzntx9ugIeVhffILx/+xw/7E36mHb52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760365394; c=relaxed/simple;
	bh=17tE4QZc2k/ThlXJzTpUoKL99gVIQtnCMUO2C5BZ3r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7cSsiEvG/2SfJVxlrCbySHJjY4kLQbwU65EyTR27j9v6dMUCbSwucifNEgK9Z3UQATyO3Pfc85D4l8gt0FZT41nNLFUMKx5Aa+b5JLo9SEm5OyC0FQBmqpvs7QhFmEhdZF5W/Z+5KD/Llx8XuM8LQbWJg/T7Aa9H0vYSljpIBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEpsrrYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5pjDvXRA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEpsrrYD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5pjDvXRA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC11A219A7;
	Mon, 13 Oct 2025 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760365389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P5Lw4ToLU1Itg1XX8KOQTgSZN6HqmiufSv56wGNzAnM=;
	b=HEpsrrYD5nTSjDzXcBw7/lADaBtw6Pi01toYeMbhrX6nwRMKFaHNXxKc3zm43JaIrbNkFR
	5baplKmBffm7XTXvipHyH/RnGh3HS2TycGO+c8wEWOfqj++rPiARStU7KPkSwTpoANUTZa
	OAiv+4z+zmBzTxytbSwYlHDbPriVH1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760365389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P5Lw4ToLU1Itg1XX8KOQTgSZN6HqmiufSv56wGNzAnM=;
	b=5pjDvXRAariB+XFpW8neIT5suldrRwrgAvkeEUlFYF5nohnHSeNy3bAAVGv/WTwaxfi3G/
	oMfsD2fuLmFFvsBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HEpsrrYD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5pjDvXRA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760365389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P5Lw4ToLU1Itg1XX8KOQTgSZN6HqmiufSv56wGNzAnM=;
	b=HEpsrrYD5nTSjDzXcBw7/lADaBtw6Pi01toYeMbhrX6nwRMKFaHNXxKc3zm43JaIrbNkFR
	5baplKmBffm7XTXvipHyH/RnGh3HS2TycGO+c8wEWOfqj++rPiARStU7KPkSwTpoANUTZa
	OAiv+4z+zmBzTxytbSwYlHDbPriVH1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760365389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P5Lw4ToLU1Itg1XX8KOQTgSZN6HqmiufSv56wGNzAnM=;
	b=5pjDvXRAariB+XFpW8neIT5suldrRwrgAvkeEUlFYF5nohnHSeNy3bAAVGv/WTwaxfi3G/
	oMfsD2fuLmFFvsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8DA913874;
	Mon, 13 Oct 2025 14:23:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UsztKE0L7WgFFAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 13 Oct 2025 14:23:09 +0000
Message-ID: <ca53e0cd-95a3-43c9-b012-194d80cb3fcc@suse.cz>
Date: Mon, 13 Oct 2025 16:23:09 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [slab] af92793e52:
 BUG_kmalloc-#(Not_tainted):Freepointer_corrupt
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <202510101652.7921fdc6-lkp@intel.com> <aOzKEsav2RubINEO@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aOzKEsav2RubINEO@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BC11A219A7
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/13/25 11:44, Harry Yoo wrote:
> On Fri, Oct 10, 2025 at 04:39:12PM +0800, kernel test robot wrote:
>> 
>> 
>> Hello,
>> 
>> kernel test robot noticed "BUG_kmalloc-#(Not_tainted):Freepointer_corrupt" on:
>> 
>> commit: af92793e52c3a99b828ed4bdd277fd3e11c18d08 ("slab: Introduce kmalloc_nolock() and kfree_nolock().")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
>> 
>> [test failed on      linus/master ec714e371f22f716a04e6ecb2a24988c92b26911]
>> [test failed on linux-next/master 0b2f041c47acb45db82b4e847af6e17eb66cd32d]
>> [test failed on        fix commit 83d59d81b20c09c256099d1c15d7da21969581bd]
>> 
>> in testcase: trinity
>> version: trinity-i386-abe9de86-1_20230429
>> with following parameters:
>> 
>> 	runtime: 300s
>> 	group: group-01
>> 	nr_groups: 5
>> 
>> config: i386-randconfig-012-20251004
>> compiler: gcc-14
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>> 
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <oliver.sang@intel.com>
>> | Closes: https://lore.kernel.org/oe-lkp/202510101652.7921fdc6-lkp@intel.com
>> 
>> [   66.142496][    C0] =============================================================================
>> [   66.146355][    C0] BUG kmalloc-96 (Not tainted): Freepointer corrupt
>> [   66.147370][    C0] -----------------------------------------------------------------------------
>> [   66.147370][    C0]
>> [   66.149155][    C0] Allocated in alloc_slab_obj_exts+0x33c/0x460 age=7 cpu=0 pid=3651
>> [   66.150496][    C0]  kmalloc_nolock_noprof (mm/slub.c:4798 mm/slub.c:5658)
>> [   66.151371][    C0]  alloc_slab_obj_exts (mm/slub.c:2102 (discriminator 3))
>> [   66.152250][    C0]  __alloc_tagging_slab_alloc_hook (mm/slub.c:2208 (discriminator 1) mm/slub.c:2224 (discriminator 1))
>> [   66.153248][    C0]  __kmalloc_cache_noprof (mm/slub.c:5698)
>> [   66.154093][    C0]  set_mm_walk (include/linux/slab.h:953 include/linux/slab.h:1090 mm/vmscan.c:3852)
>> [   66.154810][    C0]  try_to_inc_max_seq (mm/vmscan.c:4077)
>> [   66.155627][    C0]  try_to_shrink_lruvec (mm/vmscan.c:4860 mm/vmscan.c:4903)
>> [   66.156512][    C0]  shrink_node (mm/vmscan.c:4952 mm/vmscan.c:5091 mm/vmscan.c:6078)
>> [   66.157363][    C0]  do_try_to_free_pages (mm/vmscan.c:6336 mm/vmscan.c:6398)
>> [   66.158233][    C0]  try_to_free_pages (mm/vmscan.c:6644)
>> [   66.159023][    C0]  __alloc_pages_slowpath+0x28b/0x6e0
>> [   66.159977][    C0]  __alloc_frozen_pages_noprof (mm/page_alloc.c:5161)
>> [   66.160941][    C0]  __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
>> [   66.161739][    C0]  shmem_alloc_and_add_folio+0x40/0x200
>> [   66.162752][    C0]  shmem_get_folio_gfp+0x30b/0x880
>> [   66.163649][    C0]  shmem_fallocate (mm/shmem.c:3813)
>> [   66.164498][    C0] Freed in kmem_cache_free_bulk+0x1b/0x50 age=89 cpu=1 pid=248
> 
>> [   66.169568][    C0]  kmem_cache_free_bulk (mm/slub.c:4875 (discriminator 3) mm/slub.c:5197 (discriminator 3) mm/slub.c:5228 (discriminator 3))
>> [   66.170518][    C0]  kmem_cache_free_bulk (mm/slub.c:7226)
>> [   66.171368][    C0]  kvfree_rcu_bulk (include/linux/slab.h:827 mm/slab_common.c:1522)
>> [   66.172133][    C0]  kfree_rcu_monitor (mm/slab_common.c:1728 (discriminator 3) mm/slab_common.c:1802 (discriminator 3))
>> [   66.173002][    C0]  kfree_rcu_shrink_scan (mm/slab_common.c:2155)
>> [   66.173852][    C0]  do_shrink_slab (mm/shrinker.c:438)
>> [   66.174640][    C0]  shrink_slab (mm/shrinker.c:665)
>> [   66.175446][    C0]  shrink_node (mm/vmscan.c:338 (discriminator 1) mm/vmscan.c:4960 (discriminator 1) mm/vmscan.c:5091 (discriminator 1) mm/vmscan.c:6078 (discriminator 1))
>> [   66.176205][    C0]  do_try_to_free_pages (mm/vmscan.c:6336 mm/vmscan.c:6398)
>> [   66.177017][    C0]  try_to_free_pages (mm/vmscan.c:6644)
>> [   66.177808][    C0]  __alloc_pages_slowpath+0x28b/0x6e0
>> [   66.178851][    C0]  __alloc_frozen_pages_noprof (mm/page_alloc.c:5161)
>> [   66.179753][    C0]  __folio_alloc_noprof (mm/page_alloc.c:5183 mm/page_alloc.c:5192)
>> [   66.180583][    C0]  folio_prealloc+0x36/0x160
>> [   66.181430][    C0]  do_anonymous_page (mm/memory.c:4997 mm/memory.c:5054)
>> [   66.182288][    C0]  do_pte_missing (mm/memory.c:4232)
> 
> So here we are freeing an object that is allocated via kmalloc_nolock().
> (And before being allocated via kmalloc_nolock(), it was freed via
> kfree_rcu()).
> 
>> [   66.183062][    C0] Slab 0xe41bfb28 objects=21 used=17 fp=0xedf89320 flags=0x40000200(workingset|zone=1)
>> [   66.184609][    C0] Object 0xedf89b60 @offset=2912 fp=0xeac7a8b4
> 
> fp=0xeac7a8b4
> 
> the address of the object is: 0xedf89b60.
> 
> 0xedf89b60 - 0xeac7a8b4 = 0x330f2ac
> 
> If FP was not corrupted, the object pointed to by FP is
> too far away for them to be in the same slab.
> 
> That may suggest that some code built a list of free objects
> across multiple slabs/caches. That's what deferred free does!
> 
> But in free_deferred_objects(), we have:
>> /*
>>  * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
>>  * to take sleeping spin_locks from __slab_free() and deactivate_slab().
>>  * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
>>  */
>> static void free_deferred_objects(struct irq_work *work)
>> {
>>         struct defer_free *df = container_of(work, struct defer_free, work);
>>         struct llist_head *objs = &df->objects;
>>         struct llist_head *slabs = &df->slabs;
>>         struct llist_node *llnode, *pos, *t;
>>
>>         if (llist_empty(objs) && llist_empty(slabs))
>>                 return;
>>
>>         llnode = llist_del_all(objs);
>>         llist_for_each_safe(pos, t, llnode) {
>>                 struct kmem_cache *s;
>>                 struct slab *slab;
>>                 void *x = pos;
>>
>>                 slab = virt_to_slab(x);
>>                 s = slab->slab_cache; 
>>    
>>                 /*
>>                  * We used freepointer in 'x' to link 'x' into df->objects.
>>                  * Clear it to NULL to avoid false positive detection
>>                  * of "Freepointer corruption".
>>                  */
>>                 *(void **)x = NULL;

Oh wait, isn't it just the case that this is not using set_freepointer() and
with CONFIG_SLAB_FREELIST_HARDENED even the NULL is encoded as a non-NULL?

>>
>>                 /* Point 'x' back to the beginning of allocated object */
>>                 x -= s->offset;
>>                 __slab_free(s, slab, x, x, 1, _THIS_IP_);
>>         }
>>
> 
> This should have cleared the FP before freeing it.
> 
> Oh wait, there are more in the dmesg:
>> [   67.073014][    C1] ------------[ cut here ]------------
>> [   67.074039][    C1] WARNING: CPU: 1 PID: 3894 at mm/slub.c:1209 object_err+0x4d/0x6d
>> [   67.075394][    C1] Modules linked in: evdev serio_raw tiny_power_button fuse drm drm_panel_orientation_quirks stm_p_basic
>> [   67.077222][    C1] CPU: 1 UID: 0 PID: 3894 Comm: sed Tainted: G    B   W           6.17.0-rc3-00014-gaf92793e52c3 #1 PREEMPTLAZY  2cffa6c1ad8b595a5f5738a3e143d70494d8da79
>> [   67.079495][    C1] Tainted: [B]=BAD_PAGE, [W]=WARN
>> [   67.080303][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>> [   67.085915][    C1] EIP: object_err+0x4d/0x6d
>> [   67.086691][    C1] Code: 8b 45 fc e8 95 fe ff ff ba 01 00 00 00 b8 05 00 00 00 e8 46 1e 12 00 6a 01 31 c9 ba 01 00 00 00 b8 f8 84 76 db e8 b3 e1 2b 00 <0f> 0b 6a 01 31 c9 ba 01 00 00 00 b8 e0 84 76 db e8 9e e1 2b 00 83
>> [   67.089537][    C1] EAX: 00000000 EBX: c10012c0 ECX: 00000000 EDX: 00000000
>> [   67.090581][    C1] ESI: aacfa894 EDI: edf89320 EBP: ed7477b8 ESP: ed7477a0
>> [   67.091578][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010046
>> [   67.092767][    C1] CR0: 80050033 CR2: b7fa58c8 CR3: 01b5b000 CR4: 000406d0
>> [   67.093840][    C1] Call Trace:
>> [   67.094450][    C1]  check_object.cold+0x11/0x17
>> [   67.095280][    C1]  free_debug_processing+0x111/0x300
>> [   67.096076][    C1]  free_to_partial_list+0x62/0x440
>> [   67.101664][    C1]  ? free_deferred_objects+0x3e/0x110
>> [   67.104785][    C1]  __slab_free+0x2b7/0x5d0
>> [   67.105539][    C1]  ? free_deferred_objects+0x3e/0x110
>> [   67.106362][    C1]  ? rcu_is_watching+0x3f/0x80
>> [   67.107090][    C1]  free_deferred_objects+0x4d/0x110
> 
> Hmm... did we somehow clear wrong FP or is the freepointer set again
> after we cleared it?
> 


