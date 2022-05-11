Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B560522A02
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 04:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241560AbiEKCsY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 22:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiEKCrp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 22:47:45 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191085DE6C
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 19:47:42 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id j6so762518pfe.13
        for <cgroups@vger.kernel.org>; Tue, 10 May 2022 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU8nuOBOYophOA1hloaA7o9A3ff/ju/iZFOpgx4Wpp8=;
        b=HsHjcfA4jYrmtymqyGxlfvrOgbtR0AATiQX915JjYpQBDC9guuXBZ5fkE7SC4SChYF
         eCRgDqQ+NSw6GnyPOXDJn7/wGNIrob6UupYsYC7qxbfIPelGPkuyTnkNTicbaiCNGJN8
         VO68ksXNyI6nSLJVESX7gKrwXPnwL1LDVRHBf6pvjX5Rw+a6JS3n/4vilUd7Peitm2On
         t0uyCGg6+E8MQCu0a6qO6ggWmi5zMvHk318FnjGyYZx4owtdDiFMHB2xz/E4aaxZsK92
         CKoj6+GqXS7oBiDvZV550aDCccXaq8KLRXwW2rzA1RwQoQ8TGAaLR5rEbn3V5TPH6/bP
         TdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU8nuOBOYophOA1hloaA7o9A3ff/ju/iZFOpgx4Wpp8=;
        b=WeZ6pE7gpX7ltqOFiBJ4GbX2DeMVyvcPFNcy5h3eL7zf8cUnaMjJu6caEqMm2i0XAM
         7xSgeR4VCDA9RNPYk3Kj2sK+lCZo2hToYXK21e+3KbgbN5V0rqzFaajmd5ENnvr7WH4y
         iOJDg723/X82MwiiMjlxRPGaHM26NrUD7bxVQbuhasnyvbhvHOerwYSBkX8zcyS7lCT1
         3yXU/yZGegAisWW2A99BLL7VMzXxfahhxjmWRW6c89MffG4FlTRPaVAhUu2iDupX8ElQ
         ry9t8dS56JZD8fPfq4e1Pprim7wNlqRNhf+5QvrhBjH9N5K5KDGkuAm+A/3/d8iIxc5H
         SLsQ==
X-Gm-Message-State: AOAM533IT4+tTOYaNy0dkQ91Hy5opFHP3HZsDMoWbP6sLIMQs4V9xDQu
        NDmu+vYwCSxWcaB9SyjgHa6zmllokNjw53h2D6t8JA==
X-Google-Smtp-Source: ABdhPJynco7KWu1tlLJFmHL3UbqOQ8ISOoU6Gvv0V/MUo2w+djtES+oiEgPw8O+7US6KMAW6NeoNZLivXil/V8Hw2i4=
X-Received: by 2002:a05:6a00:1c53:b0:50d:5860:5b58 with SMTP id
 s19-20020a056a001c5300b0050d58605b58mr23066386pfw.85.1652237261347; Tue, 10
 May 2022 19:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220505033814.103256-1-xu.xin16@zte.com.cn> <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com> <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com> <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com> <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
 <627b1d39.1c69fb81.fe952.6426@mx.google.com>
In-Reply-To: <627b1d39.1c69fb81.fe952.6426@mx.google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 10 May 2022 19:47:29 -0700
Message-ID: <CALvZod5aqZjUE8BBQZxwHDBuSWOSEAOqW4_xE22Am0sGZZs4sw@mail.gmail.com>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
To:     CGEL <cgel.zte@gmail.com>
Cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Yang Yang <yang.yang29@zte.com.cn>
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

On Tue, May 10, 2022 at 7:19 PM CGEL <cgel.zte@gmail.com> wrote:
>
[...]
> > > >
> > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > required for a proper delegation semantic.
> > > >
> > >
> > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > Some distributions like Ubuntu is still using cgroup v1.
> >
> > Other than enable flag, how would you handle the defrag flag
> > hierarchically? It is much more complicated.
>
> Refer to memory.swappiness for cgroup, this new interface better be independent.

Let me give my 0.02. I buy the use-case of Admin restricting THPs to
low priority jobs but I don't think memory controller is the right
place to enforce that policy. Michal gave one way (prctl()) to enforce
that policy. Have you explored the BPF way to enforce this policy?
