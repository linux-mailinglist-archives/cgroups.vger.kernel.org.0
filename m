Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F05EB0AA
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 21:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbiIZTAZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 15:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiIZTAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 15:00:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C2DF1D
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 12:00:20 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id f189so9547021yba.12
        for <cgroups@vger.kernel.org>; Mon, 26 Sep 2022 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qXIxC7hvTXMP9MB1PSPsSRSKcgWgbfgrr/VeVt3XfAQ=;
        b=kY6xlSFSYIIHIvjaNJS23jWOFKwiW1EPiXbC8vrod+Q+q2Cc3PWw1S+nstgMveEKWl
         4G7V17L68GtrHi9sRrCNGa9SF3c35JwHDIFg32Mj1bSaBN9UdBmdjabUl7sVpb5qO2mH
         j0b/IhQl0aBvlv1Xndc3R5LkAJapRUSXW8/MKoEDAMYg7lk98Ri89xbAioeZ8vkTC4fZ
         xLcQl62yvW0eOPdk0vIbeYnrHszlSKHn/yXnK7OUkPA363it4nEYe5f3ue6BIpH0bPYZ
         Gdqe8GN6sGWeHnmy3JqmQZbgSMDgZSrgHueSkL7kKxqpkin8c5Ba+uywFJMii7Gk2GQQ
         HuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qXIxC7hvTXMP9MB1PSPsSRSKcgWgbfgrr/VeVt3XfAQ=;
        b=yfLyzDWN1Tb091IVHNPAS1nhrz2+bcoyPrstzGVlGldgP8fibq+ox7TfRe4ePhCfWy
         2/XVvjQDXAQC0LitFAry+k2JL4yhyrzcOZ0ZLpCWfSah/6iZul7/xERiz8+X15Pl3A0o
         kJaJQuB3hVYY+QUhLwpaiYYpfoQbQ7OfsA0jmBdygUx06h/DkAP3p6pDhzqL8gIqLTby
         aUlxf5wAX32+ECNxhiOI6kKe1WEAfTOpUMk+34bc2woZ9hUrbpnQ7lXKjF9CZlR0nSEf
         dhCY0L6WPcFNSX/qTPwzpfLC0bDWGKv1LObbMAvfJtbWOYba3wyls59xYvRa7MInype8
         Tlng==
X-Gm-Message-State: ACrzQf1n2tsTWlN0SQarioJSY4bVakddq2W+g1Oebp9GMxSFcScFBY/2
        vE66hT2nKAonrxtbPD2AHRo/oaypbhRhXOMicl9Kew==
X-Google-Smtp-Source: AMsMyM7SxCJVEVFMYzin9Elcyunq4Xv10GhdLdcX8nEOYWO+X6ltxZk1x1jbEGy4aD/N8X0U5vDplgCamqX9JZm6D1s=
X-Received: by 2002:a25:84cf:0:b0:6b3:c0c3:19d8 with SMTP id
 x15-20020a2584cf000000b006b3c0c319d8mr20802543ybm.349.1664218819202; Mon, 26
 Sep 2022 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <20220918092849.GA10314@u164.east.ru>
 <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
 <20220921170259.GI8331@blackbody.suse.cz> <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
 <20220926102812.2b0696a7@kernel.org> <CALvZod5QProaWZgT9ykb-vrrRHBpLfqVGgW2jd-Td8aX5MBZFw@mail.gmail.com>
 <20220926103631.8cb144a6d0b683915b0ecb10@linux-foundation.org>
In-Reply-To: <20220926103631.8cb144a6d0b683915b0ecb10@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Sep 2022 12:00:07 -0700
Message-ID: <CALvZod62wAYAM5QLpjShdw5_0e391VqyfR-3jmyH_X3Sqt=DEg@mail.gmail.com>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Vasily Averin <vvs@openvz.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 26, 2022 at 10:36 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 26 Sep 2022 10:32:49 -0700 Shakeel Butt <shakeelb@google.com> wrote:
>
> > > Forgive my uniformed chime-in but Linus seemed happy with the size of
> > > -rc7 and now I'm worried there won't be an -rc8. AFAICT this is a 6.0
> > > regression. Vasily, Shakeel, do we have a plan to fix this?
> >
> > I was actually waiting for Vasily to respond. Anyways, I think the
> > easiest way to proceed is to revert the commit 1d0403d20f6c ("net: set
> > proper memcg for net_init hooks allocations"). We can debug the issue
> > in the next cycle.
>
> If agreeable, could someone please send along a tested and changelogged
> patch to do this?
>

I will send this revert soon and I think Anatoly has already tested
the revert but I will let him add his tested-by tag.
