Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EA453793
	for <lists+cgroups@lfdr.de>; Tue, 16 Nov 2021 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhKPQgF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Nov 2021 11:36:05 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51202 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbhKPQf7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Nov 2021 11:35:59 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8EF91FD37;
        Tue, 16 Nov 2021 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637080378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdNHsSJ0TUD00V1kkWXYSG/GlAFO0QPXtO8TfYkofSY=;
        b=MijUyi88lZ9DiijG3jxYOvHLk3fRiZzkR+fpqvw/u1z0LEueLN/0KUr7R3BvYU1M4z6aBE
        zhnvy154JcLZ4I5wXS7KnTyl7U7XczcEzaEGt54cc8nMDHqImnQ2IfYFGx830RQdTAkIlY
        4ss7d7Tu0HfV1mYRx3tt0igHxDXiZps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637080378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdNHsSJ0TUD00V1kkWXYSG/GlAFO0QPXtO8TfYkofSY=;
        b=JKrI4zxYmDk0OoP0A4AGw4Uj1AYkJhYXTHuBPrGvh+prinKuWrhEVkFyZhC891suL7lvHV
        vhCNK4l3K5a0L5BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CC0313C25;
        Tue, 16 Nov 2021 16:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i4pYHDrdk2FtUQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 16 Nov 2021 16:32:58 +0000
Message-ID: <6866ad09-f765-0e8b-4821-8dbdc6d0f24e@suse.cz>
Date:   Tue, 16 Nov 2021 17:32:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
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
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CA+fCnZd_39cEvP+ktfxSrYAj6xdM02X6C0CxA5rLauaMhs2mxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 11/16/21 15:02, Andrey Konovalov wrote:
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
>>
>>         if (page && PageSlab(page)) {
>>                 struct kmem_cache *cache = page->slab_cache;
>> -               void *object = nearest_obj(cache, page, addr);
>> +               void *object = nearest_obj(cache, page_slab(page),      addr);
> 
> The tab before addr should be a space. checkpatch should probably report this.

Good catch, thanks. Note the tab is there already before this patch, it just
happened to appear identical to a single space before.
