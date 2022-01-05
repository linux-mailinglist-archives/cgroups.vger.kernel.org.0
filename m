Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB94856C0
	for <lists+cgroups@lfdr.de>; Wed,  5 Jan 2022 17:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiAEQjO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Jan 2022 11:39:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiAEQjL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Jan 2022 11:39:11 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B75F1F37F;
        Wed,  5 Jan 2022 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641400750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=671oRtpp5WCs8Fk9Hz2g9PU50UrRMSTbK7reBDGjtCs=;
        b=NRsZKCZitYMeU3RMI4mLOr+6li06jujBRhQsffYRQUkFW9PzULWtrL9sf+TAZSnQfN/PFW
        vM6/MTfW8m/iSdJQlSZGTuf8ommuOTf4zyXfj2xodWa580XJFAlrfobKzZGZpOqhkgcw7b
        w7Rkd3lRVPo05v08Q4Ze6NDY68SHnmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641400750;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=671oRtpp5WCs8Fk9Hz2g9PU50UrRMSTbK7reBDGjtCs=;
        b=A7c4TZBO+fD7rEud8NwULvyOqkWaT+XnEGjIj6AYNSs4vZ4Apwth/CZG0akr5xMhlAzuDJ
        JMYPGpTT1ZH7AUAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5418C13BF8;
        Wed,  5 Jan 2022 16:39:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7jnnE67J1WGcEAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 05 Jan 2022 16:39:10 +0000
Message-ID: <d49a5ea1-3592-3db2-24d5-e274be880e35@suse.cz>
Date:   Wed, 5 Jan 2022 17:39:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v4 22/32] mm: Convert struct page to struct slab in
 functions used by other subsystems
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
References: <20220104001046.12263-1-vbabka@suse.cz>
 <20220104001046.12263-23-vbabka@suse.cz>
 <YdT+qU4xgQeZc/jP@carbon.dhcp.thefacebook.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YdT+qU4xgQeZc/jP@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/5/22 03:12, Roman Gushchin wrote:
> On Tue, Jan 04, 2022 at 01:10:36AM +0100, Vlastimil Babka wrote:
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
>>  
>>  	if (page && PageSlab(page)) {
>>  		struct kmem_cache *cache = page->slab_cache;
>> -		void *object = nearest_obj(cache, page,	addr);
>> +		void *object = nearest_obj(cache, page_slab(page),	addr);
>                                                                   s/tab/space

Yeah it was pointed out earlier that the tab was already there but only this
change made it stand out. Fixing that up here would go against the automated
spatch conversion, so it's done in later manual patch that also touches this
line.

>> 2.34.1
>> 
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>
> 
> Thanks!

Thanks!
