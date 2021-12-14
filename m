Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFB4474548
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 15:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbhLNOif (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 09:38:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhLNOie (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 09:38:34 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963CCC061574
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 06:38:34 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z6so13697115plk.6
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 06:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R4NvS2jKJuj6HSBgH45i5FwQuCehWvgVUBxINrvhBWY=;
        b=GOrcD4BmPPCvB9InDaocP5JXrZvS55QPHn1oMIJngrl4K7kJOcg9M+7vSV/bfyml6r
         IGBOP+PcFOu20UPNiHymPfTVGc9kr3Yz86bsFSsSAyM/PXyDzyaOH11olTZHD4rZZ0fP
         MMpiarUSyE9MsPIhmuvQ6nl8aYEVn07PraTQjKS5Fp/apXNHC1Y5fRIxcAPj/jFVgMJ0
         CZmioE0R5dWEG1SScDLLvTu0JW1rZXFv9TsjAqLl/bJcpV6bq6fBWL2O/C8owVrdPosx
         VbzPg/9y6EUBAMs8DERVchvg+cYIQnre6n7DGD78lukKQBH2+EsxnhguwHMgGiPWEIDX
         G4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R4NvS2jKJuj6HSBgH45i5FwQuCehWvgVUBxINrvhBWY=;
        b=vsaAwiHPwyNbP7e5K0xsJPXXC1OhQv/l/PQRfroIBN0ceJGY1W6bNcR7llI5MhnZKh
         b5sFVdHk89Ft51ZOa6JkSuKd8fgRzzVJjMi/utNLAmzo1PntuZttDEIkL/BkSTRnejQC
         pTqWsqmZPf/97y26UuayaqATxV68esRxj1jzkmdgrY28Jn/rMUdBbgJcC6CzTD8Evpw+
         LE2FpXMFvBOJILoxzMAAjNYZbpFk3hH/2rV6jB+SzkB1+quTXxwr0Nb0q0nHpr61NkGO
         b8qsfCLM8H3PYTJU70VOTcW/+3dFYqotJ5d2TD+XPmUokxxItCRAj1xiL0Kioioiksxm
         V07Q==
X-Gm-Message-State: AOAM533isAQ4glTKgmNjbPnOC0kkOgT4eDaQjVBR67X0CCcmrQ2b9l7Z
        LcbjCbw9F4ifzim5khGTPvA=
X-Google-Smtp-Source: ABdhPJxQakCbY/pX/9j8kiCCq9EdRhXPHFP5tma5M2y+j3afCy5n5EXVWgIlpMhJmrgFUQoGQznkcQ==
X-Received: by 2002:a17:902:e544:b0:144:e3fa:3c2e with SMTP id n4-20020a170902e54400b00144e3fa3c2emr6596816plf.17.1639492714139;
        Tue, 14 Dec 2021 06:38:34 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id s16sm64466pfu.109.2021.12.14.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 06:38:33 -0800 (PST)
Date:   Tue, 14 Dec 2021 14:38:22 +0000
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
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 00/33] Separate struct slab from struct page
Message-ID: <20211214143822.GA1063445@odroid>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> On 12/1/21 19:14, Vlastimil Babka wrote:
> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> > this cover letter.
> > 
> > Series also available in git, based on 5.16-rc3:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> 
> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> 

Hello Vlastimil, Thank you for nice work.
I'm going to review and test new version soon in free time.

Btw, I gave you some review and test tags and seems to be missing in new
series. Did I do review/test process wrongly? It's first time to review
patches so please let me know if I did it wrongly.

--
Thank you.
Hyeonggon.
