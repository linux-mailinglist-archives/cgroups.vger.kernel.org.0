Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6A453CBD
	for <lists+cgroups@lfdr.de>; Wed, 17 Nov 2021 00:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhKPXk7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Nov 2021 18:40:59 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:34688 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhKPXk6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Nov 2021 18:40:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0B00A212C4;
        Tue, 16 Nov 2021 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637105880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5bLQ6GbPOxbu8UfgtnzISb6N4GArkk8FZZtgzRR1Pw=;
        b=o+YYhc6IVrXBbJ5AzfTt2aG4U97QfhFhVLZulFKrbPXXHJDAwn5ED25sersT1yfZtEhqhD
        /CcE1TbiYUJSCYdxyvpCY6ZyDOvvankpDn3Q0gcXAZemANM7tjTz0T+BOQ2zDEq5nndIZ7
        9PsgaVR+tisqkhLz7B+WNHiQvv273Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637105880;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B5bLQ6GbPOxbu8UfgtnzISb6N4GArkk8FZZtgzRR1Pw=;
        b=apY56TBrKIjgpu73fWg2YklYy+VgPdFETTCb9k12WeKOuvsIUvcRMZaWqrSFXvLqBF0b07
        4mp0aXzxmPtloICw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A7D413C6A;
        Tue, 16 Nov 2021 23:37:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id U6uhFNZAlGFURQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 23:37:58 +0000
Message-ID: <52923dbf-82f7-8e0d-dc82-cbead3a526d7@suse.cz>
Date:   Wed, 17 Nov 2021 00:37:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 21/32] mm: Convert struct page to struct slab in
 functions used by other subsystems
Content-Language: en-US
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>, cgroups@vger.kernel.org
References: <20211116001628.24216-1-vbabka@suse.cz>
 <20211116001628.24216-22-vbabka@suse.cz>
 <CA+fCnZd_39cEvP+ktfxSrYAj6xdM02X6C0CxA5rLauaMhs2mxQ@mail.gmail.com>
 <6866ad09-f765-0e8b-4821-8dbdc6d0f24e@suse.cz>
 <CA+fCnZcwti=hiPznPoMNWR-hvEOQbQRjEcDgnGbX+cb=kFa6sA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+fCnZcwti=hiPznPoMNWR-hvEOQbQRjEcDgnGbX+cb=kFa6sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/17/2021 12:04 AM, Andrey Konovalov wrote:
> On Tue, Nov 16, 2021 at 5:33 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 11/16/21 15:02, Andrey Konovalov wrote:
>>>> --- a/mm/kasan/report.c
>>>> +++ b/mm/kasan/report.c
>>>> @@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
>>>>
>>>>         if (page && PageSlab(page)) {
>>>>                 struct kmem_cache *cache = page->slab_cache;
>>>> -               void *object = nearest_obj(cache, page, addr);
>>>> +               void *object = nearest_obj(cache, page_slab(page),      addr);
>>>
>>> The tab before addr should be a space. checkpatch should probably report this.
>>
>> Good catch, thanks. Note the tab is there already before this patch, it just
>> happened to appear identical to a single space before.
> 
> Ah, indeed. Free free to keep this as is to not pollute the patch. Thanks!

I will fix it up in patch 24/32 so that this one can stay purely autogenerated
and there's no extra pre-patch.
