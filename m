Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479C7B0D7E
	for <lists+cgroups@lfdr.de>; Wed, 27 Sep 2023 22:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjI0Ujf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Sep 2023 16:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjI0Ujf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Sep 2023 16:39:35 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B61F11F
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:39:32 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7a8aec82539so5256087241.2
        for <cgroups@vger.kernel.org>; Wed, 27 Sep 2023 13:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695847171; x=1696451971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z2gl2b6anOv/WlO5fpZiL7fnlm+S3JfLVNwXnhVppVA=;
        b=G+laWL8CAzVQa6H1iMsBmUT6elmRbi5ZT1BZmF1zCpdQR/GR3rDDPzurwMdZ4JOaLh
         1L03ba7TzZJKRHnnTRugXjuOV5ctsUAbJVHREVPqXe5xVi8ifhgfY/WSXuwFW8kHrjof
         FMY9wBEBzmzF8xGQBpYhOefBHisOPPp+mrKOTE3G2by7pFCp1xVnqdnWAp4YUZUIOO3s
         YrtwmxWjc6bTYeVLy/NeNh7yNQtf77pn1EtJjEgkmSK7iUb3toYaVoOWIp5QXVKxqFj6
         qs9694XfKK2h4oM5PxKUxYv0ySJ/tYiLYTvpqZ/CS4dAF+L/vpSjWSS7KXNLZ3fatnd6
         4GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695847171; x=1696451971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2gl2b6anOv/WlO5fpZiL7fnlm+S3JfLVNwXnhVppVA=;
        b=Q1zKNoXcZ0/EFluLx42TF4zcDjxviKh6ycvd5XXp0P4Ob9KRxBoGL23xv3LU7YOkRp
         5dDlsvTKlzf/g9TlwMAE0KRFOHZ6As5tLcCUTZuq2lhiL1uWCNNUq55oegz8F/Zr+tz8
         E/w1xZzNOVy+4ZXQ7anTkJnb2AOBkBFRW8mP+ZDzmeYUgEkN+tAfKEMaYnHxO6v9Q5vj
         +rSRnNttQ1he1zpC2RIeFTIGG6MusQ7fcPEijAUkzUYUvczZHMy06WevBdT1B8wpDNVm
         cLvF2QbmjrgC3+c8hfF60zTVuiSjyTVeExBuF2wxBm3rqBXZcnvzi1gW0hxZf0o5qpTc
         kGog==
X-Gm-Message-State: AOJu0Yzhj5Tf5XHBpJdI0YIH6oYnf0ctGz6oh94z0gHs+vhuULCTYNw/
        zImc6SiGhCdj4HxLEkoX/Jp2EA==
X-Google-Smtp-Source: AGHT+IHYckBTqMPbLNAfsNcVh7/kOSbCbqWFqji9OTMU0IgQOfgIaUmZJgp26NbpR8o1s0L4hy1XIw==
X-Received: by 2002:a67:bd05:0:b0:452:b96c:313b with SMTP id y5-20020a67bd05000000b00452b96c313bmr3069566vsq.13.1695847171214;
        Wed, 27 Sep 2023 13:39:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id n11-20020a0cdc8b000000b0065b2be40d58sm1426496qvk.25.2023.09.27.13.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 13:39:30 -0700 (PDT)
Date:   Wed, 27 Sep 2023 16:39:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Chris Li <chrisl@kernel.org>
Subject: Re: [PATCH v2 1/2] zswap: make shrinking memcg-aware
Message-ID: <20230927203929.GA399644@cmpxchg.org>
References: <20230919171447.2712746-1-nphamcs@gmail.com>
 <20230919171447.2712746-2-nphamcs@gmail.com>
 <CAJD7tkZqm9ZsAL0triwJPLYuN02jMMS-5Y8DE7TuDJVnOCm_7Q@mail.gmail.com>
 <20230926182436.GB348484@cmpxchg.org>
 <CAJD7tkYN=S8uMeXthJ1rqsRwFar-nzDGESevtM_+C6yVB1VatQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYN=S8uMeXthJ1rqsRwFar-nzDGESevtM_+C6yVB1VatQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 26, 2023 at 11:37:17AM -0700, Yosry Ahmed wrote:
> On Tue, Sep 26, 2023 at 11:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Sep 25, 2023 at 01:17:04PM -0700, Yosry Ahmed wrote:
> > > +Chris Li
> > >
> > > On Tue, Sep 19, 2023 at 10:14 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > > >
> > > > Currently, we only have a single global LRU for zswap. This makes it
> > > > impossible to perform worload-specific shrinking - an memcg cannot
> > > > determine which pages in the pool it owns, and often ends up writing
> > > > pages from other memcgs. This issue has been previously observed in
> > > > practice and mitigated by simply disabling memcg-initiated shrinking:
> > > >
> > > > https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u
> > > >
> > > > This patch fully resolves the issue by replacing the global zswap LRU
> > > > with memcg- and NUMA-specific LRUs, and modify the reclaim logic:
> > > >
> > > > a) When a store attempt hits an memcg limit, it now triggers a
> > > >    synchronous reclaim attempt that, if successful, allows the new
> > > >    hotter page to be accepted by zswap.
> > > > b) If the store attempt instead hits the global zswap limit, it will
> > > >    trigger an asynchronous reclaim attempt, in which an memcg is
> > > >    selected for reclaim in a round-robin-like fashion.
> > >
> > > Hey Nhat,
> > >
> > > I didn't take a very close look as I am currently swamped, but going
> > > through the patch I have some comments/questions below.
> > >
> > > I am not very familiar with list_lru, but it seems like the existing
> > > API derives the node and memcg from the list item itself. Seems like
> > > we can avoid a lot of changes if we allocate struct zswap_entry from
> > > the same node as the page, and account it to the same memcg. Would
> > > this be too much of a change or too strong of a restriction? It's a
> > > slab allocation and we will free memory on that node/memcg right
> > > after.
> >
> > My 2c, but I kind of hate that assumption made by list_lru.
> >
> > We ran into problems with it with the THP shrinker as well. That one
> > strings up 'struct page', and virt_to_page(page) results in really fun
> > to debug issues.
> >
> > IMO it would be less error prone to have memcg and nid as part of the
> > regular list_lru_add() function signature. And then have an explicit
> > list_lru_add_obj() that does a documented memcg lookup.
> 
> I also didn't like/understand that assumption, but again I don't have
> enough familiarity with the code to judge, and I don't know why it was
> done that way. Adding memcg and nid as arguments to the standard
> list_lru API makes the pill easier to swallow. In any case, this
> should be done in a separate patch to make the diff here more focused
> on zswap changes.

Just like the shrinker, it was initially written for slab objects like
dentries and inodes. Since all the users then passed in charged slab
objects, it ended up hardcoding that assumption in the interface.

Once that assumption no longer holds, IMO we should update the
interface. But agreed, a separate patch makes sense.

> > Because of the overhead, we've been selective about the memory we
> > charge. I'd hesitate to do it just to work around list_lru.
> 
> On the other hand I am worried about the continuous growth of struct
> zswap_entry. It's now at ~10 words on 64-bit? That's ~2% of the size
> of the page getting compressed if I am not mistaken. So I am skeptical
> about storing the nid there.
> 
> A middle ground would be allocating struct zswap_entry on the correct
> node without charging it. We don't need to store the nid and we don't
> need to charge struct zswap_entry. It doesn't get rid of
> virt_to_page() though.

I like that idea.

The current list_lru_add() would do the virt_to_page() too, so from
that POV it's a lateral move. But we'd save the charging and the extra
nid member.
