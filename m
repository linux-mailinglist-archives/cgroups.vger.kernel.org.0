Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7890522A70
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 05:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiEKDbM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 23:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbiEKDbD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 23:31:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3937A3D;
        Tue, 10 May 2022 20:31:01 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p12so901740pfn.0;
        Tue, 10 May 2022 20:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3y8JeeuRKLfinU+E+7GukwHp8s5bConUpcRwZiK5/Y=;
        b=BKbENFHQMubnhde7tbStDgYqbvdUGHDGa3+vDByOTiOk/cx4ITbwSWFkiUnYPiOv3T
         m/6+vUBywcMUXD73hoF8tjZVxt/Cwrm7I/1Adn8e/mobzys25xFLr0E5RWtPk2HuprZc
         /Qqxa5EHnsPlq8/oBzZh8cq1Kp/z82xrVJHa/6sfoD15YJe+oIh3NFv4OI8NZgLvHOUQ
         5FdE6CSuZdylu/Nt90wYkNqL0Cu28p+s/fADnxBfxxR6Pf0FeDb8TiqIcw95VgLQUn01
         ROjN0OtWv3ORaq8G8SJG44rVQLb4tS6a5/nNQawPHTg2VOxI/KHK9dSaWWQBnDGUZnHL
         m8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3y8JeeuRKLfinU+E+7GukwHp8s5bConUpcRwZiK5/Y=;
        b=u6qMy9tuWuGiviY1oIsSotC2DoKJIp1iVkJxWm6KSqSrX/26q+WoKSzd6SBxsFdR5+
         VOdXAM1qkY4E04zvmY+QyFb2Sj3XN7NmfGYi+YohMBybGA7ipcKm8O/ketPhsD0H7IhT
         mNCsvOu5T7CGD6dOk6FB+b3fvJ+lE+Wxm1M5cJkBBDurNitzvK7LjJ6kRfOiM0V8o7nc
         hP62WYb73y9mn3gTlcIIJa3VxVa7MHs7sk10usbLyruKMC7rmmsUQ/Yrukv00klI5BlJ
         6NcGOlk9tXcv/hZdacZ0yfad+p8cNrWr+hpgBIeC1L9hrFmgltAt19zIHzZQQWOsVJvT
         OENA==
X-Gm-Message-State: AOAM533iHBUuQG06szZKQhFfE6xG4GnGHTvHT5cz1lyF0elJfZ0jrzBj
        qAtmVISkHYAuLniBk0FZfAo=
X-Google-Smtp-Source: ABdhPJz10XSZ3O1XC+b2OBJCjfyw1qIWUYbdr3HGoF/ULVgejPJuCh8MmJf6bl4fNCCDXIo6uA/3Hw==
X-Received: by 2002:a63:1762:0:b0:3db:3306:da60 with SMTP id 34-20020a631762000000b003db3306da60mr167742pgx.23.1652239861465;
        Tue, 10 May 2022 20:31:01 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b0015ea8b4b8f3sm379160plg.263.2022.05.10.20.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:31:01 -0700 (PDT)
Message-ID: <627b2df5.1c69fb81.4a22.160f@mx.google.com>
X-Google-Original-Message-ID: <20220511033100.GA1498085@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 03:31:00 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
 <627b1d39.1c69fb81.fe952.6426@mx.google.com>
 <CALvZod5aqZjUE8BBQZxwHDBuSWOSEAOqW4_xE22Am0sGZZs4sw@mail.gmail.com>
 <YnspVPGOtzlo5n+7@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnspVPGOtzlo5n+7@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 08:11:16PM -0700, Roman Gushchin wrote:
> On Tue, May 10, 2022 at 07:47:29PM -0700, Shakeel Butt wrote:
> > On Tue, May 10, 2022 at 7:19 PM CGEL <cgel.zte@gmail.com> wrote:
> > >
> > [...]
> > > > > >
> > > > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > > > required for a proper delegation semantic.
> > > > > >
> > > > >
> > > > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > > > Some distributions like Ubuntu is still using cgroup v1.
> > > >
> > > > Other than enable flag, how would you handle the defrag flag
> > > > hierarchically? It is much more complicated.
> > >
> > > Refer to memory.swappiness for cgroup, this new interface better be independent.
> > 
> > Let me give my 0.02. I buy the use-case of Admin restricting THPs to
> > low priority jobs but I don't think memory controller is the right
> > place to enforce that policy. Michal gave one way (prctl()) to enforce
> > that policy. Have you explored the BPF way to enforce this policy?
> 
> +1 for bpf
> 
> I think these THP hints are too implementation-dependent and unstable to become
> a part of cgroup API.
>

Thanks! If no other suggesting we will submit a bpf version of this patch.

> Thanks!
