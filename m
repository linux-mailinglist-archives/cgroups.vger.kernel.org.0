Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9147517B
	for <lists+cgroups@lfdr.de>; Wed, 15 Dec 2021 04:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236417AbhLODr6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 22:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbhLODr5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 22:47:57 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEE3C061574
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 19:47:57 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id z6so19534616pfe.7
        for <cgroups@vger.kernel.org>; Tue, 14 Dec 2021 19:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WX18AvwNcCC2p0SRhjMK6GhbrhT1JBIKs0M6zY3Lj7Q=;
        b=WPMmh69mSOiH8mgu7ySy0stRSmNQGrh1n9Iu5lufvirjG8da5krGccBikzmhxIsonV
         GbYy/0bHveh5UqULIOuHH20n1HJHPYTsvZW5BCUkJsJDXDgnV+nHa9RB4IBg2YWPJ/qe
         d5vdXmlTtFUjiF+1U4AFPGuBU6UXbON5hAccSzNXB5qEG8PdX3brb3YXmDMWwz1J8OgI
         UstG31izgnPdQHQofdMy4Pv5BBjgfkIxeFVKEuskD09VJSK12WfK1GTx0gXEl7PF3xsW
         1V9a83ysdKElKSmypE0spqdeA2uIe+86YAbXC1pKh4RUT89rp+4xvKASaUTEbBqH5mWU
         RuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WX18AvwNcCC2p0SRhjMK6GhbrhT1JBIKs0M6zY3Lj7Q=;
        b=TUeSorL1nKQop0cVZ1/R8Qq+NPw3uZQ1lFsN3k4wTJtQgNsPfYCu7WTRXB9d/YNrCu
         4aAvH8KMA6pAUQxfEpPeyq82gLijJcetTpHgOiTmSQn2TkO6T57/p1/31S5CHnO9E2Y0
         xAIU6gIaRJwCFmnxpnPzl3wsWVRF/THBsw3gLoB467prk4/hW0oe3Xyj07Pw79/1lcAL
         +ds3gCZjL54NqbPeCktC7n8VQ64KoMESOLhlfWTNyW5IvN00dOXSkq1wW+5Dv5mUwyg4
         OFiyaWh/0kKKPHojb2Pr4acfMUWY8cWEN+yqhyyIKU/PYdYdP1eQl/+q7knZVaNt46py
         FWUA==
X-Gm-Message-State: AOAM531zKl5kuCr6oPvUZNrmOHwRtEfHSvhlk8aoiBCwR6R8SXMTO+BH
        qvGnDUCtL2ptt7y5YqWGWv0=
X-Google-Smtp-Source: ABdhPJwH10ZHWDFi6cCdKP8OhQjj1dB7avN/b0cOOYyztSjA2GG31Cmv5mFdBR/aJtU91LzSkrUsRA==
X-Received: by 2002:a62:7a54:0:b0:494:6e78:994b with SMTP id v81-20020a627a54000000b004946e78994bmr7244240pfc.5.1639540077124;
        Tue, 14 Dec 2021 19:47:57 -0800 (PST)
Received: from odroid ([114.29.23.242])
        by smtp.gmail.com with ESMTPSA id x11sm418405pjq.52.2021.12.14.19.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 19:47:56 -0800 (PST)
Date:   Wed, 15 Dec 2021 03:47:46 +0000
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
Message-ID: <20211215034746.GA1097530@odroid>
References: <20211201181510.18784-1-vbabka@suse.cz>
 <4c3dfdfa-2e19-a9a7-7945-3d75bc87ca05@suse.cz>
 <20211214143822.GA1063445@odroid>
 <87584294-b1bc-aabe-d86a-1a8b93a7f4d4@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87584294-b1bc-aabe-d86a-1a8b93a7f4d4@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 03:43:35PM +0100, Vlastimil Babka wrote:
> On 12/14/21 15:38, Hyeonggon Yoo wrote:
> > On Tue, Dec 14, 2021 at 01:57:22PM +0100, Vlastimil Babka wrote:
> >> On 12/1/21 19:14, Vlastimil Babka wrote:
> >> > Folks from non-slab subsystems are Cc'd only to patches affecting them, and
> >> > this cover letter.
> >> > 
> >> > Series also available in git, based on 5.16-rc3:
> >> > https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slab-struct_slab-v2r2
> >> 
> >> Pushed a new branch slab-struct-slab-v3r3 with accumulated fixes and small tweaks
> >> and a new patch from Hyeonggon Yoo on top. To avoid too much spam, here's a range diff:
> >> 
> > 
> > Hello Vlastimil, Thank you for nice work.
> > I'm going to review and test new version soon in free time.
> 
> Thanks!
> 

You're welcome!

> > Btw, I gave you some review and test tags and seems to be missing in new
> > series. Did I do review/test process wrongly? It's first time to review
> > patches so please let me know if I did it wrongly.
> 
> You did right, sorry! I didn't include them as those were for patches that I
> was additionally changing after your review/test and the decision what is
> substantial change enough to need a new test/review is often fuzzy. 

Ah, Okay. review/test becomes invalid after some changing.
that's okay. I was just unfamiliar with the process. Thank you!

> So if you can recheck the new versions it would be great and then I will pick that
> up, thanks!

Okay. I'll new versions.

> 
> > --
> > Thank you.
> > Hyeonggon.
> 
