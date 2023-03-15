Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E5A6BA549
	for <lists+cgroups@lfdr.de>; Wed, 15 Mar 2023 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCOCiM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 22:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjCOChx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 22:37:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6DE2332B
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 19:37:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id o12so69956132edb.9
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 19:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678847870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TjQwVhKxvRBVOIVGwg9edcQgPJbZ2IzzSGcTnAej4Y=;
        b=Xc9yCfLwHeoLdBRIRQRNb2Tduv5hbX2UFiomKdP9082kmEUpOZN2/Cx0H0vvMehFtg
         Yge5x6d74c10tjaTAiuSHCRG7dSPbZcL78D0XLFrSg4s/QFRb3VDfC+pw3VrUj5VKbm2
         kMlolJIobPM3ZEwBDoyXlZptFj5lNvc6fiAh74JHFcX/puKA50YSN0lVVZFw4L9xHwbJ
         3vpGZFqn/4NvXg/f4r2K9UdgvtUbEwGCm2dzbKmPir0VFOQZYa57AHYEc9ke3LTMO61c
         WUZASHfvlI/H7yTTt2SIci4c8pqnBqO+4IKZ2akiISFsOFyfSPa2sV6xTFggeZE9ctuI
         IFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678847870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TjQwVhKxvRBVOIVGwg9edcQgPJbZ2IzzSGcTnAej4Y=;
        b=vw1OSffS+cxo71TKrsEaTQyB0RLW6cT11hXFmgRnvEFTt5F1ijv3rXJE5Hd7d6sH1F
         lLruw28k56HX5eA+bzTYg/8zuJgBXb4k5qtrrff0PcTPePzehR6tx3ZODBUu3rT9/hK2
         0Aimzy+5ey34J2wD+mLX0wncLPgHtsazHXtqkUkBoESk0fIgCvGDDydHFc0n44gvNSZV
         BxiiWEDLl/KMEjBfqRdgY2e4sKAdNfj68qfMaEshH2I5y23YEazJu/S/J7VWEjhvl1vh
         oZzcPp5R5BZjnP2n30kzz0fCzqpjJEBZr7t34LXgMcBohZjcXueVGXQxr7dui1HfDDio
         Hs+g==
X-Gm-Message-State: AO0yUKUX+NaZ9WhdPE9figB8zlg5H5vyrWmJKSvo57hy2r3hsDUfUd2q
        no87NjVZs/eY/mrYzVUpk9I1rzO3BPWHk2dUbESsGw==
X-Google-Smtp-Source: AK7set/FUAgI87tFNNLhJZFSXdaN/kovbwZHdnYf5yKup5e4N/qypccb6AKWoAdOtbNUDb8R1j717jLKUK47g7y7aF4=
X-Received: by 2002:a17:906:309a:b0:925:c396:b1b4 with SMTP id
 26-20020a170906309a00b00925c396b1b4mr2704985ejv.5.1678847870057; Tue, 14 Mar
 2023 19:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230313083452.1319968-1-yosryahmed@google.com>
In-Reply-To: <20230313083452.1319968-1-yosryahmed@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 14 Mar 2023 19:37:13 -0700
Message-ID: <CAJD7tkayQPpqxuh4Jqn0m=w2WhFsk2_NAcevdmcE9vvLnLm3Bw@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_cgroup_ino() get memcg from compound_head(page)
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org
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

Somehow I was stupid enough to forget CC'ing Matthew :)

+Matthew Wilcox

On Mon, Mar 13, 2023 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> From: Hugh Dickins <hughd@google.com>
>
> In a kernel with added WARN_ON_ONCE(PageTail) in page_memcg_check(), we
> observed a warning from page_cgroup_ino() when reading
> /proc/kpagecgroup. This warning was added to catch fragile reads of
> a page memcg. Make page_cgroup_ino() get memcg from compound_head(page):
> that gives it the correct memcg for each subpage of a compound page,
> so is the right fix.
>
> I dithered between the right fix and the safer "fix": it's unlikely but
> conceivable that some userspace has learnt that /proc/kpagecgroup gives
> no memcg on tail pages, and compensates for that in some (racy) way: so
> continuing to give no memcg on tails, without warning, might be safer.
>
> But hwpoison_filter_task(), the only other user of page_cgroup_ino(),
> persuaded me.  It looks as if it currently leaves out tail pages of the
> selected memcg, by mistake: whereas hwpoison_inject() uses compound_head(=
)
> and expects the tails to be included.  So hwpoison testing coverage has
> probably been restricted by the wrong output from page_cgroup_ino() (if
> that memcg filter is used at all): in the short term, it might be safer
> not to enable wider coverage there, but long term we would regret that.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>
> (Yosry: Alternatively, we could modify page_memcg_check() to do
>  page_folio() like its sibling page_memcg(), as page_cgroup_ino() is the
>  only remaining caller other than print_page_owner_memcg(); and it alread=
y
>  excludes pages that have page->memcg_data =3D 0)
>
> ---
>  mm/memcontrol.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5abffe6f8389..e3a55295725e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -395,7 +395,7 @@ ino_t page_cgroup_ino(struct page *page)
>         unsigned long ino =3D 0;
>
>         rcu_read_lock();
> -       memcg =3D page_memcg_check(page);
> +       memcg =3D page_memcg_check(compound_head(page));
>
>         while (memcg && !(memcg->css.flags & CSS_ONLINE))
>                 memcg =3D parent_mem_cgroup(memcg);
> --
> 2.40.0.rc1.284.g88254d51c5-goog
>
