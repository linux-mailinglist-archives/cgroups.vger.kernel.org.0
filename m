Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456A452B47F
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiERIOy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 04:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232798AbiERIOv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 04:14:51 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC75E81998;
        Wed, 18 May 2022 01:14:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m12so1092370plb.4;
        Wed, 18 May 2022 01:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WoEf2mJXOA2MejlK2DAjiC6YKTbTSAG0lBrKeEx56e8=;
        b=JnJoLDdO3Cr3yxlTa2CqxnmoSJWnIgeN9bE1GtOXbZrEi3HH/aUCbqqMPQ1XBmuuDJ
         CufWXNwnV9NyvbwBtELZ+WkzLZdqsS56GMSgC3kQHMqjWqfnT54P/ue6lfRVzzV1rzES
         wv7OaWRhgrmMWDNDK1pwopJLJlxnEoS5IjKy8hCTeBmUwvvlS+7icQS5kLusciC2wXhC
         /hjwWCtRUTnnm1EOpgUHfBmvsFlrP2rmD8SQkTzy4+4aCHWzXXDc+KhJObrWWetXXoMe
         tujFvcq7DTJF0XhdEM/hvgE+S9mIuWOC9YkMxDtHXmov36dPVh6XKcOavrVzsBQbmrbn
         VAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WoEf2mJXOA2MejlK2DAjiC6YKTbTSAG0lBrKeEx56e8=;
        b=yctqLtarydGG2NaEbnYVf0NrsDmlgZR0fh77sHgmTGfmFVcwEk0O+qRM4zawQmyvwM
         6HJZFQpKKHOwnhIjwt57QLPB1X8GSWeRlWp5/zhIrTaBb+eeHpP784glCtd523E5DG3D
         NE/xGIwX0GjqIwrLDE2jK4wVW0jtMFqQQqjz4EGVHtAv0JZxoT7G4ilnxcrNnojospqa
         OCXGgaMIblr84ngWcvIU3GgQHDHnzHCPa/NGfh7KXa9UU7pQl7cbeQyBiIHicFBfhl/v
         iwhRZVCvtGkXETcYqi9O5iUmjNiW6dONk4pADd/Ja9JDHcqlanrBszzaJkwSWQTelYru
         YFgQ==
X-Gm-Message-State: AOAM533sAD50AxoWELYxVok1v1g84M2VLA/tC95/jpwJUsMrIKrN1of8
        4n7yqOOwaHYCJdxb98hRq4Y=
X-Google-Smtp-Source: ABdhPJz4fy3tXiRYqOmcuYo/xV2Tcspgny8tZwqZ8dotVRB60Ql+BGevhIlTyHp9NNG1v3J4MWNoaw==
X-Received: by 2002:a17:90a:4f05:b0:1df:afae:180b with SMTP id p5-20020a17090a4f0500b001dfafae180bmr2507522pjh.80.1652861689818;
        Wed, 18 May 2022 01:14:49 -0700 (PDT)
Received: from localhost ([1.157.44.177])
        by smtp.gmail.com with ESMTPSA id d7-20020a056a00244700b00512ee2f2363sm1290401pfj.99.2022.05.18.01.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 01:14:48 -0700 (PDT)
Date:   Wed, 18 May 2022 18:14:45 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     CGEL <cgel.zte@gmail.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
Message-ID: <YoSq9W995QPM6tWQ@balbir-desktop>
References: <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
 <627b1d39.1c69fb81.fe952.6426@mx.google.com>
 <CALvZod5aqZjUE8BBQZxwHDBuSWOSEAOqW4_xE22Am0sGZZs4sw@mail.gmail.com>
 <YnspVPGOtzlo5n+7@carbon>
 <627b2df5.1c69fb81.4a22.160f@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <627b2df5.1c69fb81.4a22.160f@mx.google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 03:31:00AM +0000, CGEL wrote:
> On Tue, May 10, 2022 at 08:11:16PM -0700, Roman Gushchin wrote:
> > On Tue, May 10, 2022 at 07:47:29PM -0700, Shakeel Butt wrote:
> > > On Tue, May 10, 2022 at 7:19 PM CGEL <cgel.zte@gmail.com> wrote:
> > > >
> > > [...]
> > > > > > >
> > > > > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > > > > required for a proper delegation semantic.
> > > > > > >
> > > > > >
> > > > > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > > > > Some distributions like Ubuntu is still using cgroup v1.
> > > > >
> > > > > Other than enable flag, how would you handle the defrag flag
> > > > > hierarchically? It is much more complicated.
> > > >
> > > > Refer to memory.swappiness for cgroup, this new interface better be independent.
> > > 
> > > Let me give my 0.02. I buy the use-case of Admin restricting THPs to
> > > low priority jobs but I don't think memory controller is the right
> > > place to enforce that policy. Michal gave one way (prctl()) to enforce
> > > that policy. Have you explored the BPF way to enforce this policy?
> > 
> > +1 for bpf
> > 
> > I think these THP hints are too implementation-dependent and unstable to become
> > a part of cgroup API.
> >
> 
> Thanks! If no other suggesting we will submit a bpf version of this patch.
>

What is your proposal for BPF? How do you intend to add attach points
(attach_type) for policy? Is it still going to be per cgroup?

Balbir Singh
