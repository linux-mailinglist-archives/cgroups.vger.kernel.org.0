Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914464EE6D5
	for <lists+cgroups@lfdr.de>; Fri,  1 Apr 2022 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244697AbiDADks (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Mar 2022 23:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244693AbiDADkn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Mar 2022 23:40:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98803546A2
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 20:38:49 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id 9so1856416iou.5
        for <cgroups@vger.kernel.org>; Thu, 31 Mar 2022 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hJ9w0vjGF60hV1jwTCwkmqKMT8MPf1xtJXL++UES4qY=;
        b=sdZWMtzHnJv1VHTyDpKpYUwNhjIuI9a7tcXI/FgRTIIZ5ukpZ4YE1gzZ4NIwUJ/yLW
         ontK0twBtMRgMUAuB3XoVPBxkx1u8ljBY3neVZ/ZbKwoxvvOmtITTYduYFewRSwCrzgg
         9ZgIB9ihjVZADAfyBSTxCQxVJHg0wEwL+QsxHCNc5OYHJcDV1fFk4tAcv81F2UhtPley
         Hncdj/WWY39C2l70OUJY7Tby2YvHAG4c/hVHDFx4R78Dj60TZX/eDiMRa82AM73wK7wh
         xP5FKWMZLhlqm3Z4lOn+c0+dLNADzkK1dadFETFvblqC8MQuUarqI4R43OmYEFbg22nl
         MCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hJ9w0vjGF60hV1jwTCwkmqKMT8MPf1xtJXL++UES4qY=;
        b=pHRqtSmlS8nWcNOJpCNqlFYRXf1Jph39+C/vIrfKw2rWLHUMGaeMP5ncQ/c8aDZFCH
         WHWAJ6LWVv5BFGq9OVlUJdtrNZLGheNHr5O1gHL/Nn9TSlv7u8FNLyCw4NOWsE9dFUs+
         Km4lgkC0nqBEE/W1IR6lTtexjKiRHxVqNThl4z/Xcvb6apT10YsVZtkBCN/6NBBbEsvK
         c7f2Grqh9KlGZWY7X33GpSsja2mebUQFHSMeKVc3xQtoVP+KbZz/cTgOdWX4N+MI0+6k
         l5BzRVOtAA66wpew1BMkIK2WwF2qrj5BJKpG/Q7y8tGBxsNe6xUNZl96EMqF8QyWKhPu
         lfkA==
X-Gm-Message-State: AOAM531E4jSASXDV71muzDI4Q5lufQTWKz9k6kQevRPemk99qtoDtEZd
        OZZyDfSpFcYktL25FH7hinbfMTkMxBk8X5mnzdJiHQ==
X-Google-Smtp-Source: ABdhPJxeYgYAUsseH/rAMZM0rgUWfeHewSkxHQ10KcJClxBVFbO0qRkSJr/2Qjs1IEEJ5i8mMVQVP8aUF3NyPqW/K7E=
X-Received: by 2002:a05:6638:3012:b0:317:9a63:ecd3 with SMTP id
 r18-20020a056638301200b003179a63ecd3mr4934731jak.210.1648784329202; Thu, 31
 Mar 2022 20:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com> <20220331173350.1fe09370479a4a6f916b477d@linux-foundation.org>
In-Reply-To: <20220331173350.1fe09370479a4a6f916b477d@linux-foundation.org>
From:   Wei Xu <weixugc@google.com>
Date:   Thu, 31 Mar 2022 20:38:38 -0700
Message-ID: <CAAPL-u-_Da0qe7h_o70HCz4gPtjT8_bjx4rVNdgKZh3KNruzpA@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Jonathan Corbet <corbet@lwn.net>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Thelen <gthelen@google.com>
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

On Thu, Mar 31, 2022 at 5:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 31 Mar 2022 08:41:51 +0000 Yosry Ahmed <yosryahmed@google.com> wrote:
>
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6355,6 +6355,38 @@ static ssize_t memory_oom_group_write(struct kernfs_open_file *of,
> >       return nbytes;
> >  }
> >
> > +static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
> > +                           size_t nbytes, loff_t off)
> > +{
> > +     struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > +     unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +     unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +     int err;
> > +
> > +     buf = strstrip(buf);
> > +     err = page_counter_memparse(buf, "", &nr_to_reclaim);
> > +     if (err)
> > +             return err;
> > +
> > +     while (nr_reclaimed < nr_to_reclaim) {
> > +             unsigned long reclaimed;
> > +
> > +             if (signal_pending(current))
> > +                     break;
> > +
> > +             reclaimed = try_to_free_mem_cgroup_pages(memcg,
> > +                                             nr_to_reclaim - nr_reclaimed,
> > +                                             GFP_KERNEL, true);
> > +
> > +             if (!reclaimed && !nr_retries--)
> > +                     break;
> > +
> > +             nr_reclaimed += reclaimed;
> > +     }
>
> Is there any way in which this can be provoked into triggering the
> softlockup detector?

memory.reclaim is similar to memory.high w.r.t. reclaiming memory,
except that memory.reclaim is stateless, while the kernel remembers
the state set by memory.high.  So memory.reclaim should not bring in
any new risks of triggering soft lockup, if any.

> Is it optimal to do the MAX_RECLAIM_RETRIES loop in the kernel?
> Would additional flexibility be gained by letting userspace handle
> retrying?

I agree it is better to retry from the userspace.
