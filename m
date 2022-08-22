Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF959C1F4
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 16:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiHVO4M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235465AbiHVO4L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 10:56:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA2193D2
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 07:56:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bf22so11228536pjb.4
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Q7WYgfj+D74q3tCpU5JrwR7f8DS8YPdEHB5QL4Zw+3E=;
        b=jjZM2OFr/3FVWHbl+N6HxUndM4ZQsTxjvR0U5CsuexneKgVxqdV1bXLtaFMj4Z0OGG
         3rbrlz78/uOXN4/dBpeueMFz7QDTr89EvKklVfCjuU38Xe6odVZy5ZIZfFogK2w9Kz08
         O2Xg6uOeH2cAeEZ7kHIG3YkhVp1G7ltowW0IQOo8qvWCACurSPdYzcOV5ebirHsqU4fv
         BrKhmOCSgPClIiIzFGj5oOJ2erOyckssP0wY1islBfgBntr7B/hpZWVE5+nTof6D/jks
         FYtLJt7EkaEUp/kmK6o9V8yjRSu6idnj6Btq68OCK3Qjp59HUWfIapwm0yH6RRbPlx4F
         UBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Q7WYgfj+D74q3tCpU5JrwR7f8DS8YPdEHB5QL4Zw+3E=;
        b=QMjekpYtvz/GmijTPOUQWaqbX2JATjsuN9kjtdFq+iWAFRDhvCpzeazFsqkNEmErFF
         onbrx0EKXEdWOioSbbAPy0ctk/W173e6vlgnKqw4BqDbRv04LoyWalnR9QSRgK+Sb8Lc
         aOuXE0T07VKzgj9Qluoi8/5sov+A4+/j7L3oopRGAHv9QGjOceHjMC4HFp3UChcU52Br
         6UVVfIfTrxGyiLMAUA3SwxVZQQd5BWvsgbM4vbAzP1rJeblov9oiC4oXLxccbHif4vIN
         pvEeqMvQQXL3plPQDIRU8m2eLOQAO0CjAjqBZotfIBc1fwvsfP3fqWzthi6EKaHJvPCB
         E4+w==
X-Gm-Message-State: ACgBeo2fTIqLI4Q92rPL/SQjft/WQIQETlJvQt0oDrmA6ACdmfVY79Ei
        kz8C69VdcOHoJsshup14HZV9RrNE2zEyx+tuslCLUw==
X-Google-Smtp-Source: AA6agR4pjeCo4sfTRvPxIMsKbhBf7tq6lkeLni7LueWtlNFZuZBasGE1lD6mN+eHQeRHv7PGybIw63IFG+r7joXQ1gM=
X-Received: by 2002:a17:90b:4d0f:b0:1f7:ae99:b39d with SMTP id
 mw15-20020a17090b4d0f00b001f7ae99b39dmr23665783pjb.237.1661180169772; Mon, 22
 Aug 2022 07:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com> <20220822001737.4120417-2-shakeelb@google.com>
 <YwNSlZFPMgclrSCz@dhcp22.suse.cz> <YwNX+vq9svMynVgW@dhcp22.suse.cz>
In-Reply-To: <YwNX+vq9svMynVgW@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Aug 2022 07:55:58 -0700
Message-ID: <CALvZod720nwfP68OM2QtyyWJpOV5aO8xF6iuN0U2hpX9Pzj8PA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: page_counter: remove unneeded atomic ops for low/min
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 22, 2022 at 3:18 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 22-08-22 11:55:33, Michal Hocko wrote:
> > On Mon 22-08-22 00:17:35, Shakeel Butt wrote:
> [...]
> > > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > > index eb156ff5d603..47711aa28161 100644
> > > --- a/mm/page_counter.c
> > > +++ b/mm/page_counter.c
> > > @@ -17,24 +17,23 @@ static void propagate_protected_usage(struct page_counter *c,
> > >                                   unsigned long usage)
> > >  {
> > >     unsigned long protected, old_protected;
> > > -   unsigned long low, min;
> > >     long delta;
> > >
> > >     if (!c->parent)
> > >             return;
> > >
> > > -   min = READ_ONCE(c->min);
> > > -   if (min || atomic_long_read(&c->min_usage)) {
> > > -           protected = min(usage, min);
> > > +   protected = min(usage, READ_ONCE(c->min));
> > > +   old_protected = atomic_long_read(&c->min_usage);
> > > +   if (protected != old_protected) {
> >
> > I have to cache that code back into brain. It is really subtle thing and
> > it is not really obvious why this is still correct. I will think about
> > that some more but the changelog could help with that a lot.
>
> OK, so the this patch will be most useful when the min > 0 && min <
> usage because then the protection doesn't really change since the last
> call. In other words when the usage grows above the protection and your
> workload benefits from this change because that happens a lot as only a
> part of the workload is protected. Correct?

Yes, that is correct. I hope the experiment setup is clear now.

>
> Unless I have missed anything this shouldn't break the correctness but I
> still have to think about the proportional distribution of the
> protection because that adds to the complexity here.

The patch is not changing any semantics. It is just removing an
unnecessary atomic xchg() for a specific scenario (min > 0 && min <
usage). I don't think there will be any change related to proportional
distribution of the protection.
