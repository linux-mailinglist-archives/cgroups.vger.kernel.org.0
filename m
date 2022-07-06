Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96BB567C12
	for <lists+cgroups@lfdr.de>; Wed,  6 Jul 2022 04:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiGFCr2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 22:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGFCr1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 22:47:27 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED91A052;
        Tue,  5 Jul 2022 19:47:26 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id n3so2716724uak.13;
        Tue, 05 Jul 2022 19:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S9Mt83UidD28OhlwNN6+a26gUoMj9OoZPvbz6iZ0AlM=;
        b=Joe9DE7EU8kAGqBqAjOwKqrgE3mMBW8IwAllrOhLeyDETeCVuORC1apyRnd7dLCGrl
         U3+990DpayvNdMoY8AGZwxLc5Ytcj5vdoXRJKDuTSvbjRKGnmPkWrJOFLtTiRw+O3OV+
         RJ4a+gpZThw1uxY2N8l5b8BLrHxg6GkWdwX8Q/7Wjs8Z+RnbEo9hDrTbDdY2Msj10Ltp
         5xwWp47snGla1a2BRqRZJo9vgpw74Zv4xbn+1mkcyi0I7KLp6OypLhk7PKVTZmrH0hKu
         G09XhV6yVb3UncTpN64P5U5RAUaj3Tst+PatNnGJB7oQExE0ot1FVzSGY6SrsGGYrwJq
         TAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S9Mt83UidD28OhlwNN6+a26gUoMj9OoZPvbz6iZ0AlM=;
        b=3Ch2E27GzB2yXgQJzrxhvvEds+YiNeDvZHfz//6PitA/jBT1MR7NedsdyALnkyYZB2
         7/c3EmfHkjPFMnNfuouayLmjjEaBgtLLWqgq26FYzZruW3fF2J8z1N4rNknYMW5ukgOA
         90D+IJWbAf4JstcprR7enu62dJCx54+B/c192V8GSkP1A/VTTlcmkcmpmQ1MhdTHJJCS
         qTQUDm2odeVvrFln629tt/hw5ILhqheHNON/U5hkgi19mhr6aJvtTqZtqllaFroff/Jq
         KiI/tev10XLNawIj9IwrWW18RKk39ZAhF0cEvstO5aRHvkUpLNdHjjT+PxmjWVebvoqx
         N/dg==
X-Gm-Message-State: AJIora9MTmc5oF0QwiAuW4eh0rrRfD0l2G27Lqz39lOxxVnIkVlny0iv
        x1hNQEQZbernt83I/0rfDlKeOisqZLtyGqf/8fQ=
X-Google-Smtp-Source: AGRyM1tJaqE0DGsOmF8lAq+c2aQLkjDUk/sFWiBC3orx2Pvt/SlOM+OvevduvWaOJ1uBNJUzxOGKtvGhg/Ypk93FSys=
X-Received: by 2002:a05:6130:121:b0:382:dbf7:93a1 with SMTP id
 h33-20020a056130012100b00382dbf793a1mr433829uag.89.1657075645679; Tue, 05 Jul
 2022 19:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle> <YsMCMveSdiYX/2eH@dhcp22.suse.cz> <YsSj6rZmUkR8amT2@castle>
In-Reply-To: <YsSj6rZmUkR8amT2@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Jul 2022 10:46:48 +0800
Message-ID: <CALOAHbAb9DT6ihyxTm-4FCUiqiAzRSUHJw9erc+JTKVT9p8tow@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: do not miss MEMCG_MAX events for enforced allocations
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jul 6, 2022 at 4:49 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Mon, Jul 04, 2022 at 05:07:30PM +0200, Michal Hocko wrote:
> > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > >
> > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > events are not raised.
> > > > >
> > > > > It's not/less of an issue in a generic case because consequent
> > > > > allocations from a process context will trigger the reclaim and
> > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > memory cgroup, so it might never happen.
> > > >
> > > > The patch looks good but the above sentence is confusing. What might
> > > > never happen? Reclaim or MAX event on dying memcg?
> > >
> > > Direct reclaim and MAX events. I agree it might be not clear without
> > > looking into the code. How about something like this?
> > >
> > > "It's not/less of an issue in a generic case because consequent
> > > allocations from a process context will trigger the direct reclaim
> > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > from a process context and no MEMCG_MAX events will be triggered."
> >
> > Could you expand little bit more on the situation? Can those charges to
> > offline memcg happen indefinetely?
>
> Yes.
>
> > How can it ever go away then?
>
> Bpf map should be deleted by a user first.
>

It can't apply to pinned bpf maps, because the user expects the bpf
maps to continue working after the user agent exits.

> > Also is this something that we actually want to encourage?
>
> Not really. We can implement reparenting (probably objcg-based), I think it's
> a good idea in general. I can take a look, but can't promise it will be fast.
>
> In thory we can't forbid deleting cgroups with associated bpf maps, but I don't
> thinks it's a good idea.
>

Agreed. It is not a good idea.

> > In other words shouldn't those remote charges be redirected when the
> > target memcg is offline?
>
> Reparenting is the best answer I have.
>

At the cost of increasing the complexity of deployment, that may not
be a good idea neither.

-- 
Regards
Yafang
