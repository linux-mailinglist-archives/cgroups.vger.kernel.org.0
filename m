Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2677F567CA0
	for <lists+cgroups@lfdr.de>; Wed,  6 Jul 2022 05:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiGFDnb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 5 Jul 2022 23:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGFDna (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 5 Jul 2022 23:43:30 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92884E0C5;
        Tue,  5 Jul 2022 20:43:27 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id b81so6828655vkf.1;
        Tue, 05 Jul 2022 20:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4s7QfIni8DNDKUYteD89leDpxTEhHiten0cLfesaJz4=;
        b=UyQxnKyKoBR4VtdV1CEMjIZa+lTh/H3cn2zFHp1RBMW4Oj9KSB/m6y3YZ54vLf9iL9
         GrvvJIV+YqkeVwTtqPZGOZ1tHmuMVjz0jKRhE7qSys62FSUD9gmLmalULyvqqMICQI/N
         1EMbRQgg1P2QsWlyqTzkwOMPIwC1iFa3xgFqN+R0gFtUL9klR9t33bigmdHs0Im9ntTV
         tDluc/Z6v6Oqf8wqakDEKAt0Ok4+cG+oYgqp2G20B1YDpTZ/G16PSP1FUvTO+AbpxqYz
         TT74ed4RtJVYwtDlX/1qU9hWnFsCx6YTroIXm2xmWpIaTGiUMjZ/UQJhY/36wvYSDPMY
         Z/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4s7QfIni8DNDKUYteD89leDpxTEhHiten0cLfesaJz4=;
        b=smBzMsM1T7xnwyneYlt8+nnlpXhZxHhfxwjlh3lfRhMRtWaViLsKQEMexMsYcJaW5L
         WL+5abh/O4NxnLmUIHzFW26dRfPh7Q/6a6ami5j5vcEwHY2D4Wx8KL7s+Yw3/OSLJy8J
         23pcepcx1XZVzIuh8rUggiVnHEtxjnOTAEj5ywPQjCKwiO4d0h7ozOGCjgevJ+/HBNpP
         nL7b7nWJ58c0TXxwzAh9tDwD540R9ibLjDHy35szetDN5HuRXHjd1AhoM18Hyibdonlm
         in3A3wDu2qjA+WfjBB4q+zENMWMYAKQSo4PA9BwufVi9RQkNxqZc2xKQNRDLF95qZxRE
         wPWw==
X-Gm-Message-State: AJIora84X4v4yrmqJXk6vjc6AaO8Z99Wkx2eOYAsaSRJICtvBGLIiC6Y
        r4/Ht7UMklvg5imHR9nFC7UPNU4tR1DRH/cL53o=
X-Google-Smtp-Source: AGRyM1vnsq/BKAFKGOmTnJmTq4p0i/3b7U5U9R9o6b8Cbx6nZePzKQoG5ubL8lObfp+ph1yuTSR7xtvaR4iieJqnvJ0=
X-Received: by 2002:ac5:cb6f:0:b0:36c:424b:6d79 with SMTP id
 l15-20020ac5cb6f000000b0036c424b6d79mr21794473vkn.14.1657079006712; Tue, 05
 Jul 2022 20:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220702033521.64630-1-roman.gushchin@linux.dev>
 <CALvZod7TGhWtcRD6HeEx90T2+Rod-yamq9i+WbEQUKwNFTi-1A@mail.gmail.com>
 <YsBmoqEBCa7ra7w2@castle> <YsMCMveSdiYX/2eH@dhcp22.suse.cz>
 <YsSj6rZmUkR8amT2@castle> <CALOAHbAb9DT6ihyxTm-4FCUiqiAzRSUHJw9erc+JTKVT9p8tow@mail.gmail.com>
 <YsUBQsTjVuXvt1Wr@castle>
In-Reply-To: <YsUBQsTjVuXvt1Wr@castle>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 6 Jul 2022 11:42:50 +0800
Message-ID: <CALOAHbDjRzySCHeMVHtVDe=Ji+qh=n0pT4CwiAM5Pahi2-QNCQ@mail.gmail.com>
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

On Wed, Jul 6, 2022 at 11:28 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Wed, Jul 06, 2022 at 10:46:48AM +0800, Yafang Shao wrote:
> > On Wed, Jul 6, 2022 at 4:49 AM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > >
> > > On Mon, Jul 04, 2022 at 05:07:30PM +0200, Michal Hocko wrote:
> > > > On Sat 02-07-22 08:39:14, Roman Gushchin wrote:
> > > > > On Fri, Jul 01, 2022 at 10:50:40PM -0700, Shakeel Butt wrote:
> > > > > > On Fri, Jul 1, 2022 at 8:35 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> > > > > > >
> > > > > > > Yafang Shao reported an issue related to the accounting of bpf
> > > > > > > memory: if a bpf map is charged indirectly for memory consumed
> > > > > > > from an interrupt context and allocations are enforced, MEMCG_MAX
> > > > > > > events are not raised.
> > > > > > >
> > > > > > > It's not/less of an issue in a generic case because consequent
> > > > > > > allocations from a process context will trigger the reclaim and
> > > > > > > MEMCG_MAX events. However a bpf map can belong to a dying/abandoned
> > > > > > > memory cgroup, so it might never happen.
> > > > > >
> > > > > > The patch looks good but the above sentence is confusing. What might
> > > > > > never happen? Reclaim or MAX event on dying memcg?
> > > > >
> > > > > Direct reclaim and MAX events. I agree it might be not clear without
> > > > > looking into the code. How about something like this?
> > > > >
> > > > > "It's not/less of an issue in a generic case because consequent
> > > > > allocations from a process context will trigger the direct reclaim
> > > > > and MEMCG_MAX events will be raised. However a bpf map can belong
> > > > > to a dying/abandoned memory cgroup, so there will be no allocations
> > > > > from a process context and no MEMCG_MAX events will be triggered."
> > > >
> > > > Could you expand little bit more on the situation? Can those charges to
> > > > offline memcg happen indefinetely?
> > >
> > > Yes.
> > >
> > > > How can it ever go away then?
> > >
> > > Bpf map should be deleted by a user first.
> > >
> >
> > It can't apply to pinned bpf maps, because the user expects the bpf
> > maps to continue working after the user agent exits.
> >
> > > > Also is this something that we actually want to encourage?
> > >
> > > Not really. We can implement reparenting (probably objcg-based), I think it's
> > > a good idea in general. I can take a look, but can't promise it will be fast.
> > >
> > > In thory we can't forbid deleting cgroups with associated bpf maps, but I don't
> > > thinks it's a good idea.
> > >
> >
> > Agreed. It is not a good idea.
> >
> > > > In other words shouldn't those remote charges be redirected when the
> > > > target memcg is offline?
> > >
> > > Reparenting is the best answer I have.
> > >
> >
> > At the cost of increasing the complexity of deployment, that may not
> > be a good idea neither.
>
> What do you mean? Can you please elaborate on it?
>

                   parent memcg
                         |
                    bpf memcg   <- limit the memory size of bpf
programs
                        /           \
         bpf user agent     pinned bpf program

After bpf user agents exit, the bpf memcg will be dead, and then all
its memory will be reparented.
That is okay for preallocated bpf maps, but not okay for
non-preallocated bpf maps.
Because the bpf maps will continue to charge, but as all its memory
and objcg are reparented, so we have to limit the bpf memory size in
the parent as follows,

                   parent memcg   <-      limit the memory size of bpf
programs
                         |
                    bpf memcg
                        /           \
         bpf user agent     pinned bpf program

That means parent memcg can't be deleted and can only contain one bpf memcg.
It may work if we use systemd to manage the memcgs, but it will be a
problem if we use k8s to manage the memcgs.

-- 
Regards
Yafang
