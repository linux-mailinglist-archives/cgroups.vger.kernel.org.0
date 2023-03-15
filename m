Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC316BBF48
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 22:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCOVob (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Mar 2023 17:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCOVob (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Mar 2023 17:44:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA223A65
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 14:44:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id h8so1494ede.8
        for <cgroups@vger.kernel.org>; Wed, 15 Mar 2023 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678916668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS9QHmxXIu3DIhidQgO6UvYgPUAw45nJ7B6l2iIDBks=;
        b=KE+5xcsZLzBqQb6gvedBFvhYUI2Ss6NdsJFxy6K3P9O+4zmRIYaXSgsfg3KQ1ZYzew
         28CbANzT0zZNc+HzsUBw47D/7Y8RXIE5Nq8IDIj2usRfHWlBlHXyCtQswgVc26h6dAjh
         2ijXhxdbSSVFo/ajPzw+P9M4kHMuFuHIyTtlvbsbIrqBIYa+3ujV6lU4tqqCdopOoFSt
         MiEoh5FBxBp1NCeyzJGfaZWmV2NNm43KcjxGtoZy09MOEi+vZFiu4yC0y/tMg9v6s9L1
         XjZ8q1u114WkY585sov7cbjFe5Z2ccXxZeBCltCz2VHhxAmPpeK09YfbGp88/LNez5Us
         TljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678916668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS9QHmxXIu3DIhidQgO6UvYgPUAw45nJ7B6l2iIDBks=;
        b=Q2f3yK3nSNrJQNOiD2VJsNcmu88z9cUbg+nRC77pvVOgqeK0u9R73F7C5MZlA2Tauy
         n6bs5nfXFTb4cXqfqaMZv3SJ27Me6Imn6U/PszKi6rPOWwQvymlmh3VQ21StX+hnUZHQ
         69xXWYbL4l2K6HkxyfVDjPL1Fu6R9WYeeU9+alqHA473GX+2qBcbU7NewLmK2VZ5yGOS
         NIjRvOgP1ZNYqDnD3zbgsHgMbcfZDGT/bxkOA8WImI26VGqDyPVQDmZG0ISLhhuGbPQL
         CqrN1WqE//HplBPok6OLGCulx9ZXY9rT5PB+qvM+y/6yfZu2SB+N32Ibh4aA/oSGfZLv
         sWug==
X-Gm-Message-State: AO0yUKVujnJ1ofVcysFsFOqw3jm1TAkZO+KenJal6jkNHutJ7LORvSQy
        yCeqB4OiuTsEq6ilM0g6bhlCBeh5olHixUYjpwnD2g==
X-Google-Smtp-Source: AK7set/BTdj+LtbJR4/bFPCrNgmDa7VLYAoNE/dvKKcduNoEj3PrXV+57EiLZqthSyPbIcvFu+TWKJRrsyOZXfS2SOE=
X-Received: by 2002:a50:a412:0:b0:4fb:9735:f917 with SMTP id
 u18-20020a50a412000000b004fb9735f917mr2285440edb.8.1678916666848; Wed, 15 Mar
 2023 14:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com>
 <ZBFPh6j+4Khl1Je8@casper.infradead.org> <CAJD7tkYFjRPq6ATj-d0P25FhDaMzKdXfqTa_hh7TZp_Xyt4v+w@mail.gmail.com>
 <ZBG3xzGd6j+uByyN@casper.infradead.org>
In-Reply-To: <ZBG3xzGd6j+uByyN@casper.infradead.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 15 Mar 2023 14:43:50 -0700
Message-ID: <CAJD7tkbcTMo1oZAa0Pa3v_6d0n4bHCo+8vTxzXGU6UBVOhrUQw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Matthew Wilcox <willy@infradead.org>,
        Waiman Long <longman@redhat.com>
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

On Wed, Mar 15, 2023 at 5:19=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Mar 15, 2023 at 12:04:10AM -0700, Yosry Ahmed wrote:
> > On Tue, Mar 14, 2023 at 9:54=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > >
> > > On Mon, Mar 13, 2023 at 02:08:53PM -0700, Yosry Ahmed wrote:
> > > > On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
> > > > <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google=
.com> wrote:
> > > > >
> > > > > > From: Hugh Dickins <hughd@google.com>
> > > > > >
> > > > > > In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_che=
ck(), we
> > > > > > observed a warning from page_cgroup_ino() when reading
> > > > > > /proc/kpagecgroup.
> > > > >
> > > > > If this is the only known situation in which page_memcg_check() i=
s
> > > > > passed a tail page, why does page_memcg_check() have
> > > > >
> > > > >         if (PageTail(page))
> > > > >                 return NULL;
> > > > >
> > > > > ?  Can we remove this to simplify, streamline and clarify?
> > > >
> > > > I guess it's a safety check so that we don't end up trying to cast =
a
> > > > tail page to a folio. My opinion is to go one step further and chan=
ge
> > > > page_memcg_check() to do return the memcg of the head page, i.e:
> > > >
> > > > static inline struct mem_cgroup *page_memcg_check(struct page *page=
)
> > > > {
> > > >     return folio_memcg_check(page_folio(page));
> > > > }
> > >
> > > If you look at my commit becacb04fdd4, I was preserving the existing
> > > behaviour of page_memcg_check() when passed a tail page.  It would
> > > previously, rightly or wrongly, read the memcg_data from the tail pag=
e
> > > and get back NULL.
> >
> > Right, I looked at that. I also looked at 1b7e4464d43a which added
> > folio_memcg() and changed page_memcg()'s behavior to use page_folio()
> > to retrieve the memcg from the head, which made me wonder why
> > different decisions were made for these 2 helpers.
> >
> > Were the users of page_memcg() already passing in head pages only?
>
> There were 18 months between those commits ... I'd learned to be
> more careful about maintaining the semantics instead of changing
> them to "what they should have been".
>
> > >
> > > I suspect that was not the intended behaviour, but I do not think thi=
s
> > > patch is the right fix; it simply papers over the problem and maybe
> > > creates a new one.  Callers of page_memcg_check() should be eliminate=
d,
> > > precisely because of this ambiguity.  It's up to the people who under=
stand
> > > each of the callers who need to make the decision to always convert t=
he
> > > page that they have to a folio and ask about its memcg, or whether th=
ey
> > > want to preserve the existing behaviour of returning NULL for tail pa=
ges.
> > >
> > > So, I say NACK to this patch as it does not preserve existing behavio=
ur,
> > > and does not advance our understanding of what we have wrought.
> >
> > I am not sure which patch you are NACKing, the original patch from
> > Hugh (adding compound_head() to page_cgroup_ino()) or the suggested
> > alternative patch which changes page_memcg_check() to use
> > page_folio().
>
> Both patches are NACKed.  page_memcg_check() needs to go away
> because it has the tail page ambiguity.  Both callers should be using
> folio_memcg_check() directly and resolving for themselves what the
> correct behaviour is when seeing a tail page.
>

I agree. I even suggested this to Michal in one of the replies.

For page_cgroup_ino() we can simply pass in
folio_memcg(page_folio(page)), which would mimic what Hugh's patch is
doing for page_cgroup_ino().

For page owner, I am not sure if we want to do something similar
(which would start printing the memcg for tail pages as well), or
explicitly excluding tail pages and THEN do
folio_memcg(page_folio(page)) to get the memcg of head pages. Waiman,
what do you think?
