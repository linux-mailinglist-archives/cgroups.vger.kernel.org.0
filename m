Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3332A6BC268
	for <lists+cgroups@lfdr.de>; Thu, 16 Mar 2023 01:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjCPA0e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 20:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCPA0d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 20:26:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA68C0E2
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 17:26:29 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id fd5so1266114edb.7
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmCQ5bc+C9iO3H73ytNfZkYAlpZcblBVxwQDXjSAzCk=;
        b=UdYkNlgR1Wtz/47/irEnt549HqrEdeO4feJz++7oONmHwyUT/Ut+foiSaou2eZrBWL
         TaKG9TBACFTi1lGwnfAvFhsGAHL1A2OOFE6DzQdbtmsz2tGK7w52hzCch/ab9zrKzVbm
         PERzqoBCV/zdgFWi8HqoelQBGIsAcutQ88iGFaHJNpzwBLgCLoo5BBLtdo3OVgNgiPtl
         1vNUQyuQ6wO/42+/aNHQuhRYjZG3dbZLuoCdF9VE43IKnxSwT4oHo+wRtB6c8QRnTwmh
         MVRqel6WHmdebLAvFSV1/NnRIlimvBL6hyIK9UcHzxOt2ebUDKoFRZ7OfY/h9/lj+jvY
         qDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qmCQ5bc+C9iO3H73ytNfZkYAlpZcblBVxwQDXjSAzCk=;
        b=oLy+MsifMgCJg05TlUJeoszp5wHWoBTwyMacfhr92aos21LNYtNjfq/uzzY1e/pjF+
         snlOvd9ChQ7KuiGtDsaRBcl8l/9audZzoSkPIKasfV+OzYIqVMXugiF5kTPTRYpxriEF
         xS3WOdtlMum3uoUj5aCdQAktBZemmapLAtxL6x9EJGdWOQ0x5ogrBP01MtYZkf2LxgzQ
         GBy4eUNQjr8eY68MiSyqhEE2n6bJnOw4shwVLIzGw92gWC2gI46S0JfxmOeXXnIUziC4
         KEJ2Xx1c2qCc2Az1k2qs0RyDJP+og91leXyWSQ9hA114a1OMt1WZilpF26iiN+X7RWx2
         ICuw==
X-Gm-Message-State: AO0yUKUKOEdG2z+zV+Dy+39IBkk3SGi5O0NOTzEDd8lg1TmJcOgVf66R
        x66qwxLRcrMF8Ind782Qo15ivC1e7B8Kx9HYsrOHmw==
X-Google-Smtp-Source: AK7set9jkIOt4pi7NvFPVNNngZMHFf4dK7LYw5SaHhw1cQY8z8D+JIGqsxygKFk4F5L6wjlP+kZcS2hDsbIwbhobslw=
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr4333797ejb.15.1678926387257; Wed, 15
 Mar 2023 17:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <ZBFPh6j+4Khl1Je8@casper.infradead.org> <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
 <ZBG3xzGd6j+uByyN@casper.infradead.org> <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
 <8d4e1b74-6ae8-4243-d5c2-e63e8046d355@redhat.com>
In-Reply-To: <8d4e1b74-6ae8-4243-d5c2-e63e8046d355@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Mar 2023 17:25:49 -0700
Message-ID: <CAJD7tkbNtJHse5BH=FzgRGUW=oLLoORb7yb8xqUFhF097zDLyg@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Waiman Long <longman@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
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

On Wed, Mar 15, 2023 at 5:09=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
>
> On 3/15/23 17:43, Yosry Ahmed wrote:
> > On Wed, Mar 15, 2023 at 5:19=E2=80=AFAM Matthew Wilcox <willy@infradead=
.org> wrote:
> >> On Wed, Mar 15, 2023 at 12:04:10AM -0700, Yosry Ahmed wrote:
> >>> On Tue, Mar 14, 2023 at 9:54=E2=80=AFPM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> >>>> On Mon, Mar 13, 2023 at 02:08:53PM -0700, Yosry Ahmed wrote:
> >>>>> On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
> >>>>> <akpm@linux-foundation.org> wrote:
> >>>>>> On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.=
com> wrote:
> >>>>>>
> >>>>>>> From: Hugh Dickins <hughd@google.com>
> >>>>>>>
> >>>>>>> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check=
(), we
> >>>>>>> observed a warning from page_cgroup_ino() when reading
> >>>>>>> /proc/kpagecgroup.
> >>>>>> If this is the only known situation in which page_memcg_check() is
> >>>>>> passed a tail page, why does page_memcg_check() have
> >>>>>>
> >>>>>>          if (PageTail(page))
> >>>>>>                  return NULL;
> >>>>>>
> >>>>>> ?  Can we remove this to simplify, streamline and clarify?
> >>>>> I guess it's a safety check so that we don't end up trying to cast =
a
> >>>>> tail page to a folio. My opinion is to go one step further and chan=
ge
> >>>>> page_memcg_check() to do return the memcg of the head page, i.e:
> >>>>>
> >>>>> static inline struct mem_cgroup *page_memcg_check(struct page *page=
)
> >>>>> {
> >>>>>      return folio_memcg_check(page_folio(page));
> >>>>> }
> >>>> If you look at my commit becacb04fdd4, I was preserving the existing
> >>>> behaviour of page_memcg_check() when passed a tail page.  It would
> >>>> previously, rightly or wrongly, read the memcg_data from the tail pa=
ge
> >>>> and get back NULL.
> >>> Right, I looked at that. I also looked at 1b7e4464d43a which added
> >>> folio_memcg() and changed page_memcg()'s behavior to use page_folio()
> >>> to retrieve the memcg from the head, which made me wonder why
> >>> different decisions were made for these 2 helpers.
> >>>
> >>> Were the users of page_memcg() already passing in head pages only?
> >> There were 18 months between those commits ... I'd learned to be
> >> more careful about maintaining the semantics instead of changing
> >> them to "what they should have been".
> >>
> >>>> I suspect that was not the intended behaviour, but I do not think th=
is
> >>>> patch is the right fix; it simply papers over the problem and maybe
> >>>> creates a new one.  Callers of page_memcg_check() should be eliminat=
ed,
> >>>> precisely because of this ambiguity.  It's up to the people who unde=
rstand
> >>>> each of the callers who need to make the decision to always convert =
the
> >>>> page that they have to a folio and ask about its memcg, or whether t=
hey
> >>>> want to preserve the existing behaviour of returning NULL for tail p=
ages.
> >>>>
> >>>> So, I say NACK to this patch as it does not preserve existing behavi=
our,
> >>>> and does not advance our understanding of what we have wrought.
> >>> I am not sure which patch you are NACKing, the original patch from
> >>> Hugh (adding compound_head() to page_cgroup_ino()) or the suggested
> >>> alternative patch which changes page_memcg_check() to use
> >>> page_folio().
> >> Both patches are NACKed.  page_memcg_check() needs to go away
> >> because it has the tail page ambiguity.  Both callers should be using
> >> folio_memcg_check() directly and resolving for themselves what the
> >> correct behaviour is when seeing a tail page.
> >>
> > I agree. I even suggested this to Michal in one of the replies.
> >
> > For page_cgroup_ino() we can simply pass in
> > folio_memcg(page_folio(page)), which would mimic what Hugh's patch is
> > doing for page_cgroup_ino().
> >
> > For page owner, I am not sure if we want to do something similar
> > (which would start printing the memcg for tail pages as well), or
> > explicitly excluding tail pages and THEN do
> > folio_memcg(page_folio(page)) to get the memcg of head pages. Waiman,
> > what do you think?
>
> I prefer the current behavior of printing information for the head page
> only. I am open to suggestion of the best APIs to use.

I think instead of explicitly checking page->memcg_data, we can check
PageTail() and return explicitly for tail pages tails, check
PageSlab() to print the message for slab pages, then get the page's
memcg through folio_memcg_check(page_folio(page)).

Something like:

static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
struct page *page)
{
    ...
    rcu_read_lock();

    /* Only head pages hold refs to a memcg */
    if (PageTail(page))
        goto out_unlock;

    if (PageSlab(page))
        ret +=3D scnprintf(kbuf + ret, count - ret, "Slab cache page\n");

    memcg =3D folio_memcg_check(page_folio(page));
    if (!memcg)
        goto out_unlock;
    ...
}

Matthew, What do you think?

>
> Cheers,
> Longman
>
