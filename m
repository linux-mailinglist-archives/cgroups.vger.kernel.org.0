Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBFD47F2C0
	for <lists+cgroups@lfdr.de>; Sat, 25 Dec 2021 10:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhLYJRG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 25 Dec 2021 04:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhLYJRG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 25 Dec 2021 04:17:06 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F019C061401
        for <cgroups@vger.kernel.org>; Sat, 25 Dec 2021 01:17:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id n16so8018491plc.2
        for <cgroups@vger.kernel.org>; Sat, 25 Dec 2021 01:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j8TrOsw0QgcOPU1it/XtIDhHHO12dds110STZzwzYD0=;
        b=nOfcDm4R5YmmsgOzRMD28sPCqa+TwQDAQHfEwt3dW/ogm2rgFf/ajmkB4ScNuPhyO8
         vYbJwRK0IZSKimBi3gea8Oje+/59Z+0N6771bKnQRHOPYgG0nV5O3ZG7v8mbs1axOAGL
         G+qJ4RNKx03TigPLiGc18Rfr8Tekoumv1fh6eY6ElmMFViRIArxRcUUDaxqriuwSKbep
         aHEYUZxo1aUj7I0wrJ0eHssFN6dTHiyDQT0tqulG//pf997KhiOJDjAnKMwINw04gyQ1
         7SPueCO4+F38JtWp128b+dPBIVb22KtU1MqSpIOk9k85uyu5uIhMGcIwIXKUCBRmUlek
         2Anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j8TrOsw0QgcOPU1it/XtIDhHHO12dds110STZzwzYD0=;
        b=NHkBZYwOMdKLiS+Lxtk6YD1QLPnh9DZMsLTqAI96WIhsO1toRS2Uf3gEHSznrrkMO9
         95TSVwvI+h1TXatQ+UNtJrjQcl9611tMXYtupD7aQEUlE2Lz4zlCGDNh6bYymHRfY7fp
         cYrfal2U+T9+tZILOQoK9i8/UZIGap+HBDPKk6JXON+Vqr5+ckvFbicDAQP2K7vsfuMa
         Km4SjMH8TxSznrZYwkkRVU4N8JkRnTpxGAPlwWK8zhXthzOJ8DGO4pwrrUMsropO8B6u
         TDEIMggNu+d8Gu67zeKJ0f1ixV+kYUFky/8AbGVzpiHgYSJLR50BbFWy3QyGWCAs5kkb
         jfTw==
X-Gm-Message-State: AOAM530wExWVAex1Y0GYZ6XtHIOu4r6q/p1M3hFHGH6gpwadLBSnIUt8
        wYXfWB71Q01S1S0roRE+sLQ=
X-Google-Smtp-Source: ABdhPJz9jlowVnaWF5WFDxgb4hC4jKXBJ9R7DZT7d9Gt8MbbdXuDlBdTHBahWN62xgb0xOPaqu1h7Q==
X-Received: by 2002:a17:903:2303:b0:149:50d1:19d0 with SMTP id d3-20020a170903230300b0014950d119d0mr9507103plh.86.1640423825603;
        Sat, 25 Dec 2021 01:17:05 -0800 (PST)
Received: from ip-172-31-30-232.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id t10sm11886406pfg.105.2021.12.25.01.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 01:17:05 -0800 (PST)
Date:   Sat, 25 Dec 2021 09:16:55 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
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
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <Ycbhh5n8TBODWHR+@ip-172-31-30-232.ap-northeast-1.compute.internal>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3a83708-3f3c-a634-7bee-dcfcaaa7f36e@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Dec 22, 2021 at 05:56:50PM +0100, Vlastimil Babka wrote:
> On 12/14/21 13:57, Vlastimil Babka wrote:
> > On 12/1/21 19:14, Vlastimil Babka wrote:
> >> Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> >> this cover letter.
> >>
> >> Series also available in git, based on 5.16-rc3:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> > 
> > Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> > and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 
> Hi, I've pushed another update branch slab-struct_slab-v4r1, and also to
> -next. I've shortened git commit log lines to make checkpatch happier,
> so no range-diff as it would be too long. I believe it would be useless
> spam to post the whole series now, shortly before xmas, so I will do it
> at rc8 time, to hopefully collect remaining reviews. But if anyone wants
> a mailed version, I can do that.

Hello Vlastimil, Merry Christmas!
This is part 2 of reviewing/testing patches.

# mm/kasan: Convert to struct folio and struct slab
I'm not familiar with kasan yet but kasan runs well on my machine and
kasan's bug report functionality too works fine.
Tested-by: Hyeongogn Yoo <42.hyeyoo@gmail.com>

# mm: Convert struct page to struct slab in functions used by other subsystems
I'm not familiar with kasan, but to ask:
Does ____kasan_slab_free detect invalid free if someone frees
an object that is not allocated from slab?

@@ -341,7 +341,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
-       if (unlikely(nearest_obj(cache, virt_to_head_page(object), object) !=
+       if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
            object)) {
                kasan_report_invalid_free(tagged_object, ip);
                return true;

I'm asking this because virt_to_slab() will return NULL if folio_test_slab()
returns false. That will cause NULL pointer dereference in nearest_obj.
I don't think this change is intended.

This makes me think some of virt_to_head_page() -> virt_to_slab()
conversion need to be reviewed with caution.

# mm/slab: Finish struct page to struct slab conversion
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

# mm/slab: Convert most struct page to struct slab by spatch
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

I'll come back with part 3 :)
Enjoy your Christmas!
Hyeonggon

> Changes in v4:
> - rebase to 5.16-rc6 to avoid a conflict with mainline
> - collect acks/reviews/tested-by from Johannes, Roman, Hyeonggon Yoo -
> thanks!
> - in patch "mm/slub: Convert detached_freelist to use a struct slab"
> renamed free_nonslab_page() to free_large_kmalloc() and use folio there,
> as suggested by Roman
> - in "mm/memcg: Convert slab objcgs from struct page to struct slab"
> change one caller of slab_objcgs_check() to slab_objcgs() as suggested
> by Johannes, realize the other caller should be also changed, and remove
> slab_objcgs_check() completely.
