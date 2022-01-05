Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28403485712
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242158AbiAERIs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 12:08:48 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59832 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242157AbiAERIs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 12:08:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1593721101;
        Wed,  5 Jan 2022 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641402526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29fjnm569NOx8opF3VJURmxxXs5tPBd+njPEliFY6vg=;
        b=Yp5zyhN55xPlgtXUSDEWS8ZqkuvunbCQnFj6iBc4VZWle07lY7jMZ58LznZAhvTwa0XfAA
        eczLEe1zySZcSFbsqJ7xCX90XIO2UZ9CoSqooqQjqOhyg4dG6vZaMfnzkI5Z01G5SfaYAJ
        x13HG044++hLIyXJfgo1rntzMtWy1jQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641402526;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29fjnm569NOx8opF3VJURmxxXs5tPBd+njPEliFY6vg=;
        b=eDpp4vu0iWT2XSATxygwktscqoGN9pcOwnFgc3cM01p341RTh/Txx3p8CeRx9itQyCVz/G
        IAJopIDSMqg+6eCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0F9913BF9;
        Wed,  5 Jan 2022 17:08:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGY8Mp3Q1WEdHQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 05 Jan 2022 17:08:45 +0000
Message-ID: <56c7a92b-f830-93dd-3fd0-4b6f1eb723ef@suse.cz>
Date:   Wed, 5 Jan 2022 18:08:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Roman Gushchin <guro@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, patches@lists.linux.dev,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-24-vbabka@suse.cz>
 <YdUFXUbeYGdFbVbq@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v4 23/32] mm/memcg: Convert slab objcgs from struct page
 to struct slab
In-Reply-To: <YdUFXUbeYGdFbVbq@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/5/22 03:41, Roman Gushchin wrote:
> On Tue, Jan 04, 2022 at 01:10:37AM +0100, Vlastimil Babka wrote:
>> page->memcg_data is used with MEMCG_DATA_OBJCGS flag only for slab pages
>> so convert all the related infrastructure to struct slab. Also use
>> struct folio instead of struct page when resolving object pointers.
>> 
>> This is not just mechanistic changing of types and names. Now in
>> mem_cgroup_from_obj() we use folio_test_slab() to decide if we interpret
>> the folio as a real slab instead of a large kmalloc, instead of relying
>> on MEMCG_DATA_OBJCGS bit that used to be checked in page_objcgs_check().
>> Similarly in memcg_slab_free_hook() where we can encounter
>> kmalloc_large() pages (here the folio slab flag check is implied by
>> virt_to_slab()). As a result, page_objcgs_check() can be dropped instead
>> of converted.
>> 
>> To avoid include cycles, move the inline definition of slab_objcgs()
>> from memcontrol.h to mm/slab.h.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>> Cc: <cgroups@vger.kernel.org>
>>  	/*
>>  	 * Slab objects are accounted individually, not per-page.
>>  	 * Memcg membership data for each individual object is saved in
>>  	 * the page->obj_cgroups.
>                ^^^^^^^^^^^^^^^^^
> 	       slab->memcg_data

Good catch, fixed.
 
>>  	 */
>> -	if (page_objcgs_check(page)) {
>> -		struct obj_cgroup *objcg;
>> +	if (folio_test_slab(folio)) {
>> +		struct obj_cgroup **objcgs;
>> +		struct slab *slab;
>>  		unsigned int off;
>>  
>> -		off = obj_to_index(page->slab_cache, page_slab(page), p);
>> -		objcg = page_objcgs(page)[off];
>> -		if (objcg)
>> -			return obj_cgroup_memcg(objcg);
>> +		slab = folio_slab(folio);
>> +		objcgs = slab_objcgs(slab);
>> +		if (!objcgs)
>> +			return NULL;
>> +
>> +		off = obj_to_index(slab->slab_cache, slab, p);
>> +		if (objcgs[off])
>> +			return obj_cgroup_memcg(objcgs[off]);
>>  
>>  		return NULL;
>>  	}
> 
> There is a comment below, which needs some changes:
> 	/*
> 	 * page_memcg_check() is used here, because page_has_obj_cgroups()
> 	 * check above could fail because the object cgroups vector wasn't set
> 	 * at that moment, but it can be set concurrently.
> 	 * page_memcg_check(page) will guarantee that a proper memory
> 	 * cgroup pointer or NULL will be returned.
> 	 */
> 
> In reality the folio's slab flag can be cleared before releasing the objcgs \
> vector. It seems that there is no such possibility at setting the flag,
> it's always set before allocating and assigning the objcg vector.

You're right. I'm changing it to:

         * page_memcg_check() is used here, because in theory we can encounter
         * a folio where the slab flag has been cleared already, but
         * slab->memcg_data has not been freed yet
         * page_memcg_check(page) will guarantee that a proper memory
         * cgroup pointer or NULL will be returned.

I wrote "in theory" because AFAICS it implies a race as we would have to be
freeing a slab and at the same time query an object address. We probably
could have used the non-check version, but at this point I don't want to
make any functional changes besides these comment fixes.

I assume your patch on top would cover it?

>> @@ -2896,7 +2901,7 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
>>  	 * page_memcg_check(page) will guarantee that a proper memory
>>  	 * cgroup pointer or NULL will be returned.
>>  	 */
>> -	return page_memcg_check(page);
>> +	return page_memcg_check(folio_page(folio, 0));
>>  }
>>  
>>  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>> diff --git a/mm/slab.h b/mm/slab.h
>> index bca9181e96d7..36e0022d8267 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -412,15 +412,36 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>>  }
>>  
>>  #ifdef CONFIG_MEMCG_KMEM
>> -int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>> -				 gfp_t gfp, bool new_page);
>> +/*
>> + * slab_objcgs - get the object cgroups vector associated with a slab
>> + * @slab: a pointer to the slab struct
>> + *
>> + * Returns a pointer to the object cgroups vector associated with the slab,
>> + * or NULL. This function assumes that the slab is known to have an
>> + * associated object cgroups vector. It's not safe to call this function
>> + * against slabs with underlying pages, which might have an associated memory
>> + * cgroup: e.g.  kernel stack pages.
> 
> Hm, is it still true? I don't think so. It must be safe to call it for any
> slab now.

Right, forgot to update after removing the _check variant.
Changing to:

  * Returns a pointer to the object cgroups vector associated with the slab,
  * or NULL if no such vector has been associated yet.

> The rest looks good to me, please feel free to add
> Reviewed-by: Roman Gushchin <guro@fb.com>
> after fixing these comments.

Thanks!
 
> Thanks!

