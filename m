Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1226BA588
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 04:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCODLe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 23:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCODLd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 23:11:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B12BED4
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:11:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eh3so14256063edb.11
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678849891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXqCKGMyW/C+0Hogx41I4dQn/i/iOzKSbxMPqIV3gX0=;
        b=gvJCiPYbBgWxA/3y98DWHdOpJYKUc0mYgM4igQE4cMa+S1vjhhHBTFcV3pd3erEvNX
         o9tufmTIVgzVU4Zc9pbYdrPnCy7vstq4ZMLRRzjPCFFenh/sJlNtSc7XITQUGrjSp+dD
         OIdhh+SFVgd8DT2bpIBTp7WaL8V2svJCYwVW2x492qCSsxGu8Llgr3OBGCEbpx4PMPA/
         Ai2jMvvMwqW+sy+LdMt8lseB2EVAYv4YeN3QAgTFEQYa7a4U64tSzPo9xvhX5uO7IBFJ
         4oKB9rGM9KM7U9TG6BtcDrqQCcJeGyLioy4i1JAMcFm2211dRy+TaJPMauys4R9mV1Nr
         EA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXqCKGMyW/C+0Hogx41I4dQn/i/iOzKSbxMPqIV3gX0=;
        b=WcHMGFrtOFqhFO4YMKtF6xq4LTp7MdbgaREJqdNmlfZmbPRz3Cz/oEMLAHOdOijCtk
         +7k1aOti5d9X1FHEn2mhYw3BC5DWfIbzK7M4prekN8lZvAKrD4NVUc3h/1tUtdQ74dWv
         PrA/rdtb8qL5uwpQ8WIWe9H1Hl9W6imptDdjO4Xe2VbPd1oGbiD76LZISivWx7m+e4Zt
         uzRDcy4JpLdu1vRpha2QW9Ep5m7m6rX+vYG4IrX26mQ9Bqa9RW8RvMDPWvvf23g7ubgI
         nihkSlR2GpxguoXTpaJhmmRNjUNTirBg39n9eQ5TKk8q4xNW8u9UWOk412mWbYgM8HoP
         0H3Q==
X-Gm-Message-State: AO0yUKXnKoRPyPw3Bqa+UrolNMiIUrfgKl5LN56rGnyamNWJYuOC88TO
        T8r/CRmK/T5RbrBUBUpRA0Kz/zLc3thNRsmxh4OlpQ==
X-Google-Smtp-Source: AK7set9QCtoouRDiZmo0H0lx5dNDudt+NxwGawmXylQ936F9n1Uuf2tm9YjmxP6LkSSaBz9A1vETQzmGqqdlfe7Iz6E=
X-Received: by 2002:a17:907:2069:b0:8af:4963:fb08 with SMTP id
 qp9-20020a170907206900b008af4963fb08mr2483530ejb.15.1678849890539; Tue, 14
 Mar 2023 20:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
 <20230313124431.fe901d79bc8c7dc96582539c@linux-foundation.org>
 <CAJD7tkZKhNRiWOrUOiHWuEQbOuDhjyHx0H01M1mQziM36viq9w@mail.gmail.com> <61e8e6d3-697e-f9a5-a1fb-45a3448ee5db@redhat.com>
In-Reply-To: <61e8e6d3-697e-f9a5-a1fb-45a3448ee5db@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 20:10:54 -0700
Message-ID: <CAJD7tkYm25ohS_P1Q6mzZMHJp4Hjwr3LqLaiPA3NFpa1gfOdJw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Waiman Long <longman@redhat.com>
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
        cgroups@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
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

On Tue, Mar 14, 2023 at 8:07=E2=80=AFPM Waiman Long <longman@redhat.com> wr=
ote:
>
> On 3/13/23 17:08, Yosry Ahmed wrote:
> > On Mon, Mar 13, 2023 at 12:44=E2=80=AFPM Andrew Morton
> > <akpm@linux-foundation.org> wrote:
> >> On Mon, 13 Mar 2023 08:34:52 +0000 Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> >>
> >>> From: Hugh Dickins <hughd@google.com>
> >>>
> >>> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), =
we
> >>> observed a warning from page_cgroup_ino() when reading
> >>> /proc/kpagecgroup.
> >> If this is the only known situation in which page_memcg_check() is
> >> passed a tail page, why does page_memcg_check() have
> >>
> >>          if (PageTail(page))
> >>                  return NULL;
> >>
> >> ?  Can we remove this to simplify, streamline and clarify?
> > I guess it's a safety check so that we don't end up trying to cast a
> > tail page to a folio. My opinion is to go one step further and change
> > page_memcg_check() to do return the memcg of the head page, i.e:
> >
> > static inline struct mem_cgroup *page_memcg_check(struct page *page)
> > {
> >      return folio_memcg_check(page_folio(page));
> > }
> >
> > This makes it consistent with page_memcg(), and makes sure future
> > users are getting the "correct" memcg for whatever page they pass in.
> > I am interested to hear other folks' opinions here.
> >
> > The only other user today is print_page_owner_memcg(). I am not sure
> > if it's doing the right thing by explicitly reading page->memcg_data,
> > but it is already excluding pages that have page->memcg_data =3D=3D 0,
> > which should be the case for tail pages.
>
> It is reading memcg_data directly to see if it is slab cache page. It is
> currently skipping page that does not have memcg_data set.

IIUC this skips tail pages, because they should always have
page->memcg_data =3D=3D 0, even if they are charged to a memcg. To
correctly get their memcg we should read it from the
compound_head()/page_folio().

My 2c, we can check PageSlab() to print the extra message for slab
pages, instead of reading memcg_data directly, which kinda breaks the
abstraction created by the various helpers for reading a page memcg.
Someone can easily change something in how memcg_data is interpreted
in those helpers without realizing that page_owner is also reading it.

>
> Cheers,
> Longman
>
