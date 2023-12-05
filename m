Return-Path: <cgroups+bounces-808-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78A80500D
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 11:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A4F1F21504
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3652A4F1E1;
	Tue,  5 Dec 2023 10:17:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5293E181;
	Tue,  5 Dec 2023 02:16:58 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D0EA2207E;
	Tue,  5 Dec 2023 10:16:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C908136CF;
	Tue,  5 Dec 2023 10:16:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3fBhGZj4bmV8aAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 05 Dec 2023 10:16:56 +0000
Message-ID: <432494ef-b47f-16fa-41a0-f68613f94fc4@suse.cz>
Date: Tue, 5 Dec 2023 11:16:56 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 03/21] KASAN: remove code paths guarded by CONFIG_SLAB
Content-Language: en-US
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: David Rientjes <rientjes@google.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Marco Elver
 <elver@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeelb@google.com>,
 Muchun Song <muchun.song@linux.dev>, Kees Cook <keescook@chromium.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-3-9c9c70177183@suse.cz>
 <ZW6mjFlmm0ME18OQ@localhost.localdomain>
 <CAB=+i9R+zZo-AGuEAYDzEZV7f=YSC9fdczARQijk-WPZUr0iDA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAB=+i9R+zZo-AGuEAYDzEZV7f=YSC9fdczARQijk-WPZUr0iDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++++++
X-Spam-Score: 12.84
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of vbabka@suse.cz) smtp.mailfrom=vbabka@suse.cz;
	dmarc=none
X-Rspamd-Queue-Id: 9D0EA2207E
X-Spamd-Result: default: False [12.84 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_SPF_SOFTFAIL(4.60)[~all];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 NEURAL_SPAM_SHORT(2.95)[0.983];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[google.com,linux.com,kernel.org,lge.com,linux-foundation.org,linux.dev,gmail.com,arm.com,cmpxchg.org,chromium.org,kvack.org,vger.kernel.org,googlegroups.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On 12/5/23 05:48, Hyeonggon Yoo wrote:
> On Tue, Dec 5, 2023 at 1:27 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>>
>> On Mon, Nov 20, 2023 at 07:34:14PM +0100, Vlastimil Babka wrote:
>> > With SLAB removed and SLUB the only remaining allocator, we can clean up
>> > some code that was depending on the choice.
>> >
>> > Reviewed-by: Kees Cook <keescook@chromium.org>
>> > Reviewed-by: Marco Elver <elver@google.com>
>> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> > ---
>> >  mm/kasan/common.c     | 13 ++-----------
>> >  mm/kasan/kasan.h      |  3 +--
>> >  mm/kasan/quarantine.c |  7 -------
>> >  3 files changed, 3 insertions(+), 20 deletions(-)
>> >
>> > diff --git a/mm/kasan/common.c b/mm/kasan/common.c
>> > index 256930da578a..5d95219e69d7 100644
>> > --- a/mm/kasan/common.c
>> > +++ b/mm/kasan/common.c
>> > @@ -153,10 +153,6 @@ void __kasan_poison_object_data(struct kmem_cache *cache, void *object)
>> >   * 2. A cache might be SLAB_TYPESAFE_BY_RCU, which means objects can be
>> >   *    accessed after being freed. We preassign tags for objects in these
>> >   *    caches as well.
>> > - * 3. For SLAB allocator we can't preassign tags randomly since the freelist
>> > - *    is stored as an array of indexes instead of a linked list. Assign tags
>> > - *    based on objects indexes, so that objects that are next to each other
>> > - *    get different tags.
>> >   */
>> >  static inline u8 assign_tag(struct kmem_cache *cache,
>> >                                       const void *object, bool init)
>> > @@ -171,17 +167,12 @@ static inline u8 assign_tag(struct kmem_cache *cache,
>> >       if (!cache->ctor && !(cache->flags & SLAB_TYPESAFE_BY_RCU))
>> >               return init ? KASAN_TAG_KERNEL : kasan_random_tag();
>> >
>> > -     /* For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU: */
>> > -#ifdef CONFIG_SLAB
>> > -     /* For SLAB assign tags based on the object index in the freelist. */
>> > -     return (u8)obj_to_index(cache, virt_to_slab(object), (void *)object);
>> > -#else
>> >       /*
>> > -      * For SLUB assign a random tag during slab creation, otherwise reuse
>> > +      * For caches that either have a constructor or SLAB_TYPESAFE_BY_RCU,
>> > +      * assign a random tag during slab creation, otherwise reuse
>> >        * the already assigned tag.
>> >        */
>> >       return init ? kasan_random_tag() : get_tag(object);
>> > -#endif
>> >  }
>> >
>> >  void * __must_check __kasan_init_slab_obj(struct kmem_cache *cache,
>> > diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
>> > index 8b06bab5c406..eef50233640a 100644
>> > --- a/mm/kasan/kasan.h
>> > +++ b/mm/kasan/kasan.h
>> > @@ -373,8 +373,7 @@ void kasan_set_track(struct kasan_track *track, gfp_t flags);
>> >  void kasan_save_alloc_info(struct kmem_cache *cache, void *object, gfp_t flags);
>> >  void kasan_save_free_info(struct kmem_cache *cache, void *object);
>> >
>> > -#if defined(CONFIG_KASAN_GENERIC) && \
>> > -     (defined(CONFIG_SLAB) || defined(CONFIG_SLUB))
>> > +#ifdef CONFIG_KASAN_GENERIC
>> >  bool kasan_quarantine_put(struct kmem_cache *cache, void *object);
>> >  void kasan_quarantine_reduce(void);
>> >  void kasan_quarantine_remove_cache(struct kmem_cache *cache);
>> > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
>> > index ca4529156735..138c57b836f2 100644
>> > --- a/mm/kasan/quarantine.c
>> > +++ b/mm/kasan/quarantine.c
>> > @@ -144,10 +144,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>> >  {
>> >       void *object = qlink_to_object(qlink, cache);
>> >       struct kasan_free_meta *meta = kasan_get_free_meta(cache, object);
>> > -     unsigned long flags;
>> > -
>> > -     if (IS_ENABLED(CONFIG_SLAB))
>> > -             local_irq_save(flags);
>> >
>> >       /*
>> >        * If init_on_free is enabled and KASAN's free metadata is stored in
>> > @@ -166,9 +162,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
>> >       *(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
>> >
>> >       ___cache_free(cache, object, _THIS_IP_);
>> > -
>> > -     if (IS_ENABLED(CONFIG_SLAB))
>> > -             local_irq_restore(flags);
>> >  }
>> >
>> >  static void qlist_free_all(struct qlist_head *q, struct kmem_cache *cache)
>>
>> Looks good to me,
>> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

> nit: Some KASAN tests depends on SLUB, but as now it's the only allocator
>       KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB); in
>       mm/kasan/kasan_test.c can be removed

Hmm I see, but will rather also leave it for later cleanup at this point,
thanks!

>>
>> >
>> > --
>> > 2.42.1
>> >
>> >


