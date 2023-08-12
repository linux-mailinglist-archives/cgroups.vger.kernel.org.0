Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E6779C83
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 04:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjHLCMX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 22:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjHLCMW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 22:12:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064D410DF
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:12:22 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so349153766b.1
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691806340; x=1692411140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JAmOXeQ0VHSXwwCpVm3J8YOQijq+7iGoLz/Vka2YTMk=;
        b=dL5mRwRgcxjtqEDoIfRVMPS7RQHFXTHE2dp81+2iSyKXxXmt4p7Hsdcs/WW6OzCHr8
         Y+xyvdJtwyK3FfdlwZaw/9Oa+tVjzhIK9ZpIYGIKTttzLEdfTgucXs5GlYa6o3PjHK4u
         kSBkUqpRxu+rx5jjYWx87+cxT1jssYONnzxfCbyWKZwB+wH+NnC+tBkidjKeFqT6RD5Z
         e7l2yuGfipD3XpnSOnDhKFMWcwXAehVpQ07p8xZ/bz0+NuI8JvWRtiEU3NapnlmZfpMP
         mJ2KxJGQLN6DjHjWVqh+mvYjfymau+k6k/smOk9HuULcU+wGkNjjR64SI5hB4UdvRJj/
         DzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691806340; x=1692411140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JAmOXeQ0VHSXwwCpVm3J8YOQijq+7iGoLz/Vka2YTMk=;
        b=CWTvR929fKiQxqEBzTRlN04DpG2z1KscAXahb7OWN9nvJBDau/QNXI4hZwYwEZNmIX
         VJMFdmArkTYxPNqVYU8ub/FRabhtvAkHdAeFoeH2OuppFN0CW0OtZMhwng0liR+CmfWX
         +Lf28+ucvkNPJ3U6sUC8dhp1RJOp6fMYjMph7CqqrISc/6q4sjrYUAk0OZ4faXOoqPfq
         n+NmaY/p9uic+3YqSGSgn/tLhJMivvnmYQm8pF5HMDmEu8uQ44MkL/fsXoiq/tyvOkDj
         qcNy8M/vjIBYJwh0D+rnoyOVk2sAlLWS5jGdDI8m/luize0oSHaK/XLAW808Oe0/czP8
         zgKg==
X-Gm-Message-State: AOJu0YyZrAyG+KwwgZ7NQr0SXbyu0UOoQo+fQCYbN8DyCN8gGALxeZdZ
        UDwVmbBEJAQJ5Xn1pI9KMJPHlm1xbfwZgMDoJWUa5w==
X-Google-Smtp-Source: AGHT+IE2He6oTlb1mSgLv7Sf/Jbk069NPiIARvyAXaubULmw2CYAwt1dcof3RXQ7QiFE0iEHEzRtxm+Y39pwK8Qurz8=
X-Received: by 2002:a17:906:de:b0:99b:f49c:fcfa with SMTP id
 30-20020a17090600de00b0099bf49cfcfamr3069435eji.21.1691806340376; Fri, 11 Aug
 2023 19:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
 <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
In-Reply-To: <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 11 Aug 2023 19:11:43 -0700
Message-ID: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 11, 2023 at 7:08=E2=80=AFPM Shakeel Butt <shakeelb@google.com> =
wrote:
>
> Hi all,
>
> (sorry for late response as I was away)
>
> On Fri, Aug 11, 2023 at 1:40=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> [...]
> > > > >
> > > > > Last note, for /proc/vmstat we have /proc/sys/vm/stat_refresh to =
trigger
> > > > > an explicit refresh. For those users who really need more accurat=
e
> > > > > numbers we might consider interface like that. Or allow to write =
to stat
> > > > > file and do that in the write handler.
> > > >
> > > > This wouldn't be my first option, but if that's the only way to get
> > > > accurate stats I'll take it.
> > >
> > > To be honest, this would be my preferable option because of 2 reasons=
.
> > > a) we do not want to guarantee to much on the precision front because
> > > that would just makes maintainability much more harder with different
> > > people having a different opinion of how much precision is enough and=
 b)
> > > it makes the more rare (need precise) case the special case rather th=
an
> > > the default.
> >
> > How about we go with the proposed approach in this patch (or the mutex
> > approach as it's much cleaner), and if someone complains about slow
> > reads we revert the change and introduce the refresh API? We might
> > just get away with making all reads accurate and avoid the hassle of
> > updating some userspace readers to do write-then-read. We don't know
> > for sure that something will regress.
> >
> > What do you think?
>
> Actually I am with Michal on this one. As I see multiple regression
> reports for reading the stats, I am inclined towards rate limiting the
> sync stats flushing from user readable interfaces (through
> mem_cgroup_flush_stats_ratelimited()) and providing a separate
> interface as suggested by Michal to explicitly flush the stats for
> users ok with the cost. Since we flush the stats every 2 seconds, most
> of the users should be fine and the users who care about accuracy can
> pay for it.

I am worried that writing to a stat for flushing then reading will
increase the staleness window which we are trying to reduce here.
Would it be acceptable to add a separate interface to explicitly read
flushed stats without having to write first? If the distinction
disappears in the future we can just short-circuit both interfaces.
