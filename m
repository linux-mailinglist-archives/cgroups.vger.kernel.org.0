Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB7A7AF30D
	for <lists+cgroups@lfdr.de>; Tue, 26 Sep 2023 20:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjIZSiF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Sep 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbjIZSiF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Sep 2023 14:38:05 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC66E5
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 11:37:57 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32320381a07so5402096f8f.0
        for <cgroups@vger.kernel.org>; Tue, 26 Sep 2023 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695753476; x=1696358276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9U+hyK0DC2msywzl8E5WSklE3JM2O4AFWpd5vWieyg=;
        b=qZoEA6tNGIf86kFye+vtDlYn0NwynKxS3QN5nciFYrgAmUK+uRSaQHEQf7u5/wDYK6
         hM1a3uHc+MQFEMUrpu+yhNvb43T3OaQYEUWV0WpxPtI/hfXeqSFkmdUfDzduZSGp+Otm
         ssFK8lf3Nog/PDg/eHN12j9h5C5WhIhj73NfA/Gf6OTVzVEjuQO/q9HeWiGx8wNIuV79
         b5c2tqq7eoiqdOtCroAKV/rCQ54GcGKOKUiQGl6dZYHIwQCnj5w9oxJdygkOlbQsz7F6
         rgphE2wOT/+vIVQdizptmp96tzLuL+J5EsYbha3312iJ2dDyQ1APs0Y32KfikCcuXaC3
         mVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695753476; x=1696358276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9U+hyK0DC2msywzl8E5WSklE3JM2O4AFWpd5vWieyg=;
        b=BWSWPkZeOGM6Ts/f/vln4FWQKlFPah968+d0LStFsUHjWb19Bn73gjbiYXeuby+laB
         ZI/Wa+G03MU6k6yx+WQ8GUNWRJfb9FCjgo7LaG2JEJhkmk6t5Npcht6c4YQuXjMC+BOq
         bpBLK9HfD2fXTxKyaDOPT7QP+P7M4Ng71no1737K/WYyGvBujwlfotdRskwOMx8COGvs
         KA6fH7swUyDYiwixZaH5u1VNzs8gI7928pswJsNr2pV8Kwgd7mSoZCHCSdtEypCUyqZU
         hlI9dbgsP3u5xgwvCF9t1mUOJIA4jFXYN9uOpWT75WjR63ZdjNMpFmLotReMsv5YjpwC
         kOBA==
X-Gm-Message-State: AOJu0Yy5pq3EjELviDsLWv7/p07cydij7gKjAvO9IW+wfQu/omiLHPLg
        Cr/EAv+mXKtdv7tnS0toIt08ZEy3WBFe999Q9HwKow==
X-Google-Smtp-Source: AGHT+IFAjP8KuW4iDeZ3x3Vs1/DfJYlj4R1eAd9xqe2b40gmueIHHWwtEC+M5UyEkHoWh5saxpwpLNX+V8ZCpHBn5MM=
X-Received: by 2002:a5d:404d:0:b0:31f:e534:2d6f with SMTP id
 w13-20020a5d404d000000b0031fe5342d6fmr10166471wrp.11.1695753476063; Tue, 26
 Sep 2023 11:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230919171447.2712746-1-nphamcs@gmail.com> <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com> <20230926182436.GB348484@cmpxchg.org>
In-Reply-To: <20230926182436.GB348484@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 26 Sep 2023 11:37:17 -0700
Message-ID: <CAJD7tkYN=S8uMeXthJ1rqsRwFar-nzDGESevtM_+C6yVB1VatQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 11:24=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Mon, Sep 25, 2023 at 01:17:04PM -0700, Yosry Ahmed wrote:
> > +Chris Li
> >
> > On Tue, Sep 19, 2023 at 10:14=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> > > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > >
> > > Currently, we only have a single global LRU for zswap. This makes it
> > > impossible to perform worload-specific shrinking - an memcg cannot
> > > determine which pages in the pool it owns, and often ends up writing
> > > pages from other memcgs. This issue has been previously observed in
> > > practice and mitigated by simply disabling memcg-initiated shrinking:
> > >
> > > https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.co=
m/T/#u
> > >
> > > This patch fully resolves the issue by replacing the global zswap LRU
> > > with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> > >
> > > a) When a store attempt hits an memcg limit, it now triggers a
> > >    synchronous reclaim attempt that, if successful, allows the new
> > >    hotter page to be accepted by zswap.
> > > b) If the store attempt instead hits the global zswap limit, it will
> > >    trigger an asynchronous reclaim attempt, in which an memcg is
> > >    selected for reclaim in a round-robin-like fashion.
> >
> > Hey Nhat,
> >
> > I didn't take a very close look as I am currently swamped, but going
> > through the patch I have some comments/questions below.
> >
> > I am not very familiar with list_lru, but it seems like the existing
> > API derives the node and memcg from the list item itself. Seems like
> > we can avoid a lot of changes if we allocate struct zswap_entry from
> > the same node as the page, and account it to the same memcg. Would
> > this be too much of a change or too strong of a restriction? It's a
> > slab allocation and we will free memory on that node/memcg right
> > after.
>
> My 2c, but I kind of hate that assumption made by list_lru.
>
> We ran into problems with it with the THP shrinker as well. That one
> strings up 'struct page', and virt_to_page(page) results in really fun
> to debug issues.
>
> IMO it would be less error prone to have memcg and nid as part of the
> regular list_lru_add() function signature. And then have an explicit
> list_lru_add_obj() that does a documented memcg lookup.

I also didn't like/understand that assumption, but again I don't have
enough familiarity with the code to judge, and I don't know why it was
done that way. Adding memcg and nid as arguments to the standard
list_lru API makes the pill easier to swallow. In any case, this
should be done in a separate patch to make the diff here more focused
on zswap changes.

>
> Because of the overhead, we've been selective about the memory we
> charge. I'd hesitate to do it just to work around list_lru.

On the other hand I am worried about the continuous growth of struct
zswap_entry. It's now at ~10 words on 64-bit? That's ~2% of the size
of the page getting compressed if I am not mistaken. So I am skeptical
about storing the nid there.

A middle ground would be allocating struct zswap_entry on the correct
node without charging it. We don't need to store the nid and we don't
need to charge struct zswap_entry. It doesn't get rid of
virt_to_page() though.
