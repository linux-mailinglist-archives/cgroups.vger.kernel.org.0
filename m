Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CC85344DF
	for <lists+cgroups@lfdr.de>; Wed, 25 May 2022 22:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238164AbiEYUcZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 May 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiEYUcW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 May 2022 16:32:22 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB6E9FD4
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 13:32:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id p10so12999654wrg.12
        for <cgroups@vger.kernel.org>; Wed, 25 May 2022 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0dEd4NUNMrTRFFSR3+OfkYzmb9W3Zxpow0f09EOgls=;
        b=s5IkQauZnOLISvCoz7A9uhGFFCaH1f6gh+yufCmj+HN/vMS6luKtssU9qd7rvuHP09
         HhINtg7TpvcOmZm1ouHcVkjKk6zEEeNeWY6nO4yudTi3fchpTd2jAQqb7M+Nqsts4Yl7
         iU8Hbk1kY75EEpSOU6r93DqrrMnxdh+0P0FaPzPHtty0hvs+DnUoYHaN0FJ8JZvzSoqy
         3Q8c8fxts4s9EzUn+2U1k5GK3ykGZ9PNN1dkeb+A9fBG9SRLbEsFSjaOXJdyhkQ5EpFr
         5OFDAMcBoiBF7XQQZ+WFPEM44Gcr2BZC20P7JgeRPoHbwD64VcWUoQXv3RdTO+wXTsYy
         iKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0dEd4NUNMrTRFFSR3+OfkYzmb9W3Zxpow0f09EOgls=;
        b=psvbkWP0U+Q+RlyFtc534ARqnlQQWWAmRVscNyrRp/geYd5Z3LfdurrjQwfa6AhSwX
         5LRDdkAcUwxNx4FYbnlM8dv4VI2OrUQE5TbOiv+R8HClKNh5t7REWwUckA/RNzc2Qu/q
         6jbFIJo1UPFsQ4Zd9fQW1jb9ifoki32psKxCZr+P03sBaybzXVmOYcWEkfM0eyzzKH/f
         DaivvTlWF22kYFSmR9EaGGI5JgPcaioHc2UpxEZBOvXHC6+mfdg9Urzusdkcd3lzwSO9
         JBrHp0Gy/LMGMBNcg4nlHHfLqxGguVVEE8FCOIhWEG6WcteYg4RtcoP18K25R4ISLnds
         jmwg==
X-Gm-Message-State: AOAM5338sVqUknodVVCgypc6rZBxY9TWNpzIKRZe2npciELpvp9oicRq
        WDcllzQgkMQJaKhT8rSeD5B01YkicxTLEk6/XDh0jGk7/10=
X-Google-Smtp-Source: ABdhPJwXo576UKmIFQOkfOqX3ZmH0+6z5clVG1g8qmpwjGuMYibxp/UlYvMSX4DWWCcwuUAYtbcV6NZvvy1saRiJ69E=
X-Received: by 2002:a05:6000:544:b0:20f:ca41:cc4c with SMTP id
 b4-20020a056000054400b0020fca41cc4cmr18728082wrf.582.1653510738811; Wed, 25
 May 2022 13:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz> <87zgjcg4xs.fsf@vajain21.in.ibm.com>
 <YodDaFVeU33bu7yQ@dhcp22.suse.cz> <CAJD7tkYwv2LDZeV2F5pxuniw7LCNjBapDCm3WuRhzwTH-jN3PA@mail.gmail.com>
 <YozFZI2euSjWPgDb@cmpxchg.org> <CAJD7tkZxvmnrrjc4yAe5mC+SL-MZqMkn21yjetiLYyq0B=AhtA@mail.gmail.com>
 <Yo3v5k8UBNHF6QRi@dhcp22.suse.cz>
In-Reply-To: <Yo3v5k8UBNHF6QRi@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 25 May 2022 13:31:42 -0700
Message-ID: <CAJD7tkb7DRK_9wtiSFPiV6zsZGYYxs_JGECODtP+pta4k4MaiA@mail.gmail.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 25, 2022 at 1:59 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 24-05-22 12:01:01, Yosry Ahmed wrote:
> > On Tue, May 24, 2022 at 4:45 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Mon, May 23, 2022 at 03:50:34PM -0700, Yosry Ahmed wrote:
> > > > I think it might be useful to have a dedicated entry in memory.stat
> > > > for proactively reclaimed memory. A case where this would be useful is
> > > > tuning and evaluating userspace proactive reclaimers. For instance, if
> > > > a userspace agent is asking the kernel to reclaim 100M, but it could
> > > > only reclaim 10M, then most probably the proactive reclaimer is not
> > > > using a good methodology to figure out how much memory do we need to
> > > > reclaim.
> > > >
> > > > IMO this is more useful, and a superset of just reading the last
> > > > reclaim request status through memory.reclaim (read stat before and
> > > > after).
> > >
> > > +1
> >
> > It might also be useful to have a breakdown of this by memory type:
> > file, anon, or shrinkers.
> >
> > It would also fit in nicely with a potential type=file/anon/shrinker
> > argument to memory.reclaim. Thoughts on this?
>
> Can we start simple and see what real usecases actually will need?

Agreed. Let's start with a single proactively reclaimed memory stat
and then add subcategories if/when needed.

> --
> Michal Hocko
> SUSE Labs
