Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADC5EA8CE
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiIZOoN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbiIZOnp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 10:43:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE6184E72;
        Mon, 26 Sep 2022 06:06:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so8176262wmb.0;
        Mon, 26 Sep 2022 06:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=lHYmumLvyE4V6WpEgRdvIHKDaBX6pkuSXgTnGyOxhOQ=;
        b=IbCR66K42xKS/M7CztGQ/LQwHaP2woOeBjaIbh+fDq1UpLATW4PO90HWgwWtBykUjM
         0HFnd3Fvcq4RrR+0gAVoejrdv99y5kHVbenxc5NAbMGkf3N4Q6uM9TRajq85B4J8ZjSV
         V9XJrozFgaVtJ66AgOm/XY3g53aH44A0ATIQsMFfMwFsaPIFTE6EeXYZrIlDC2l48fAE
         KZHd8afOJREzG4jpDC7lYSeU43uR6LjGw2LPG7z95O1bkwfXoBdZ3PiLVcxGwPbEtwIn
         33/32wZQKrjC+cbzxJ37ne+EwCc+Kc0RpNFBDDOyHXuTSz5aY6q2E8thqzuOeyX4aNQ+
         aSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lHYmumLvyE4V6WpEgRdvIHKDaBX6pkuSXgTnGyOxhOQ=;
        b=q8qItM1rlQBqvC+6sHvu12x8LsDjPSHug+PhVGvV4EtFN/sCzIapGYZhqe4sjAteps
         8PpE1bftc/KWXJQs3GzmWvnDydbEMAcqnInupljlCEAxt+XhRtnPnGG0vyv8AFIzRSPQ
         fSB+Mo+iPuBKeXx+v7m4/7EhQprWCTeoPP1kR7Qy3wfg9Y4UsUkm89oy3TG4Y2k7To9W
         8fszdH2wopQxCLd+dgKTg4JJ2zHjtTNCmn05b/2CVD1bFj4Bo50l7QDqSYW2wS9rA9uV
         wPTrKKaDBpTIuQMVHn+my9YZL9FUr5zcG/Wbthr/53UI5WVqDK21PppzgkSEGwFUgkA/
         xa6Q==
X-Gm-Message-State: ACrzQf3FnU/Q2tMkFiOzKp00/FlhXPiSTH4i157yk/w07yR457gyWrik
        kXSPEfyIx/ZkxZxejcHz9at9gWjal3Th1VxiCuc=
X-Google-Smtp-Source: AMsMyM4b0qgmhm6PiBNfWnLD3vMEtUlll0xIKZtIF9qUWcglWtI/yMWUUVWoPKE4QceNSNvUf+y3+KI8RAgNAvb9sR8=
X-Received: by 2002:a7b:c389:0:b0:3b4:a67a:2ef7 with SMTP id
 s9-20020a7bc389000000b003b4a67a2ef7mr21793251wmj.180.1664197580076; Mon, 26
 Sep 2022 06:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <20220918092849.GA10314@u164.east.ru>
 <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com> <20220921170259.GI8331@blackbody.suse.cz>
In-Reply-To: <20220921170259.GI8331@blackbody.suse.cz>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 26 Sep 2022 16:06:08 +0300
Message-ID: <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     Vasily Averin <vvs@openvz.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 21, 2022 at 8:03 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrote=
:
> On Wed, Sep 21, 2022 at 05:44:56PM +0300, Anatoly Pugachev <matorola@gmai=
l.com> wrote:
> > On Sun, Sep 18, 2022 at 12:39 PM Anatoly Pugachev <matorola@gmail.com> =
wrote:
> > >
> > >
> > > I'm unable to boot my sparc64 VM anymore (5.19 still boots, 6.0-rc1 d=
oes not),
> > > bisected up to this patch,
> > >
> > > mator@ttip:~/linux-2.6$ git bisect bad
> > > 1d0403d20f6c281cb3d14c5f1db5317caeec48e9 is the first bad commit
> > > commit 1d0403d20f6c281cb3d14c5f1db5317caeec48e9
> >
> > reverting this patch makes my sparc64 box boot successfully.
>
> The failed address falls into vmmemmap region (per your boot log
> output). It looks like the respective page/folio (of init_net struct) is
> unbacked there (and likely folio_test_slab fails dereferencing ->flags).
>
> Would you mind sharing your kernel's config?
> (I'm most curious about CONFIG_SPARSMEM_VMEMMAP, I'm not familiar with
> your arch at all though.)

mator@ttip:~/dmesg$ zcat config-6.0.0-rc6-00010-gb7f0f527dc3c.gz | grep VME=
MMAP
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy

I do upload config and boot logs to
https://github.com/mator/sparc64-dmesg

building a new kernel version/releases as 'make olddefconfig && make -j'
current version of booted 6.0.0-rc6 is available as
https://github.com/mator/sparc64-dmesg/blob/master/config-6.0.0-rc6-00010-g=
b7f0f527dc3c.gz
