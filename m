Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4E9483672
	for <lists+cgroups@lfdr.de>; Mon,  3 Jan 2022 18:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232215AbiACR4Y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jan 2022 12:56:24 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56786 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiACR4Y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jan 2022 12:56:24 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CFB7D21108;
        Mon,  3 Jan 2022 17:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641232582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWXmfQBKbsotJ+DKTiOu/dBjpnMA9AO60pYklnpK268=;
        b=RhtzrMx8l25Gp/dHfXaSGxIrVaiGPT1oHmkDlXhSWyOvA3XmL4u7MKmkETxcTTsnSdyvu2
        2jQ+42aJxQsIJcy8XiqzBTF5lvvMOIEw62rvN/I2Cv3SEGwEYtC0RgDlqOLKfcdrrpJrAI
        TwUGB6+/291CiiyPqlt5NX4O2jOPKt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641232582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CWXmfQBKbsotJ+DKTiOu/dBjpnMA9AO60pYklnpK268=;
        b=t8qwh7PKelubXDsAPcP//m32DqwLxiSz3osyPqIC0+7efv+uVAzzP9TnLLkkHY3hH0TlrX
        HpPoN6SxQtgI3lBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40BC413B0C;
        Mon,  3 Jan 2022 17:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wx1+DsY402GiJQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Jan 2022 17:56:22 +0000
Message-ID: <d3f0e9ef-7d21-8de6-5b15-116f39c2aca3@suse.cz>
Date:   Mon, 3 Jan 2022 18:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        patches@lists.linux.dev, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, cgroups@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        kasan-dev@googlegroups.com, Lu Baolu <baolu.lu@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Marco Elver <elver@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Roman Gushchin <guro@fb.com>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
 <YcxFDuPXlTwrPSPk@ip-172-31-30-232.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
In-Reply-To: <YcxFDuPXlTwrPSPk@ip-172-31-30-232.ap-northeast-1.compute.internal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/29/21 12:22, Hyeonggon Yoo wrote:
> On Wed, Dec 22, 2021 at 05:56:50PM +0100, Vlastimil Babka wrote:
>> On 12/14/21 13:57, Vlastimil Babka wrote:
>> > On 12/1/21 19:14, Vlastimil Babka wrote:
>> >> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
>> >> this cover letter.
>> >>
>> >> Series also available in git, based on 5.16-rc3:
>> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
>> > 
>> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
>> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
>> 
>> Hi, I've pushed another update branch slab-struct_slab-v4r1, and also to
>> -next. I've shortened git commit log lines to make checkpatch happier,
>> so no range-diff as it would be too long. I believe it would be useless
>> spam to post the whole series now, shortly before xmas, so I will do it
>> at rc8 time, to hopefully collect remaining reviews. But if anyone wants
>> a mailed version, I can do that.
>>
> 
> Hello Matthew and Vlastimil.
> it's part 3 of review.
> 
> # mm: Convert struct page to struct slab in functions used by other subsystems
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert most struct page to struct slab by spatch
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> with a question below.
> 
> -static int check_slab(struct kmem_cache *s, struct page *page)
> +static int check_slab(struct kmem_cache *s, struct slab *slab)
>  {
>         int maxobj;
>  
> -       if (!PageSlab(page)) {
> -               slab_err(s, page, "Not a valid slab page");
> +       if (!folio_test_slab(slab_folio(slab))) {
> +               slab_err(s, slab, "Not a valid slab page");
>                 return 0;
>         }
> 
> Can't we guarantee that struct slab * always points to a slab?

Normally, yes.

> for struct page * it can be !PageSlab(page) because struct page *
> can be other than slab. but struct slab * can only be slab
> unlike struct page. code will be simpler if we guarantee that
> struct slab * always points to a slab (or NULL).

That's what the code does indeed. But check_slab() is called as part of
various consistency checks, so there we on purpose question all assumptions
in order to find a bug (e.g. memory corruption) - such as a page that's
still on the list of slabs while it was already freed and reused and thus
e.g. lacks the slab page flag.

But it's nice how using struct slab makes such a check immediately stand out
as suspicious, right?

> # mm/slub: Convert pfmemalloc_match() to take a struct slab
> It's confusing to me because the original pfmemalloc_match() is removed
> and pfmemalloc_match_unsafe() was renamed to pfmemalloc_match() and
> converted to use slab_test_pfmemalloc() helper.
> 
> But I agree with the resulting code. so:
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert alloc_slab_page() to return a struct slab
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> 
> # mm/slub: Convert print_page_info() to print_slab_info()
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> I hope to review rest of patches in a week.

Thanks for your reviews/tests!
