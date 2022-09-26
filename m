Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DE65EAEB2
	for <lists+cgroups@lfdr.de>; Mon, 26 Sep 2022 19:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiIZRxx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Sep 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIZRxS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Sep 2022 13:53:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C12CD74CF;
        Mon, 26 Sep 2022 10:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA1C2B80B91;
        Mon, 26 Sep 2022 17:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD7FC433C1;
        Mon, 26 Sep 2022 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664213294;
        bh=TpZUQWxRgvsRBZ9B6zo0p7FzXoiaePpQxMiDDnNBgKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QPSqUe9Ur/PUiiTJBtm8l0/4UZdPjkeotTSVg1TDe0LQs09d6EE9xqiO02aHRQn4J
         k5g56tuXXwqJkmYMMxkoPGFcZYnkqPDRk/Am3nfAKi7Pi9wecOHnuNy3ZdMuQKfe5c
         nxol9cbQ0D6apJIbIRD6Xo13sHw0pZC5ZcwMeZJxEx/a8BwUrYJ90z7k3HlxiMtcUt
         YPt/8rML1+1qoqY6l2Iv/s7RFc61Z/vF/gfJd0yLhF2b8TWUbPEiTwr6oUbmdB2V4j
         ed+vAxHyJ8a5G0ETuggC63KgqvqsoIB4FDaepGxXzi6YUmNKGqafq886belqPc5Sj8
         yT0gbiHM+2kjg==
Date:   Mon, 26 Sep 2022 10:28:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Vasily Averin <vvs@openvz.org>, Shakeel Butt <shakeelb@google.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Michal =?UTF-8?B?S291dG7DvQ==?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [sparc64] fails to boot, (was: Re: [PATCH memcg v6] net: set
 proper memcg for net_init hooks allocations)
Message-ID: <20220926102812.2b0696a7@kernel.org>
In-Reply-To: <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
        <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org>
        <20220918092849.GA10314@u164.east.ru>
        <CADxRZqyyHAtzaaPjcKi8AichGew2yi-_vQcKoLoxPanLvXZL0g@mail.gmail.com>
        <20220921170259.GI8331@blackbody.suse.cz>
        <CADxRZqyAG5Co9hLEp6p8vPC9WyGERR6un-3Rqapyv14G4vPXJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 26 Sep 2022 16:06:08 +0300 Anatoly Pugachev wrote:
> On Wed, Sep 21, 2022 at 8:03 PM Michal Koutn=C3=BD <mkoutny@suse.com> wro=
te:
> > On Wed, Sep 21, 2022 at 05:44:56PM +0300, Anatoly Pugachev <matorola@gm=
ail.com> wrote: =20
> > > reverting this patch makes my sparc64 box boot successfully. =20
> >
> > The failed address falls into vmmemmap region (per your boot log
> > output). It looks like the respective page/folio (of init_net struct) is
> > unbacked there (and likely folio_test_slab fails dereferencing ->flags).
> >
> > Would you mind sharing your kernel's config?
> > (I'm most curious about CONFIG_SPARSMEM_VMEMMAP, I'm not familiar with
> > your arch at all though.) =20
>=20
> mator@ttip:~/dmesg$ zcat config-6.0.0-rc6-00010-gb7f0f527dc3c.gz | grep V=
MEMMAP
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
>=20
> I do upload config and boot logs to
> https://github.com/mator/sparc64-dmesg
>=20
> building a new kernel version/releases as 'make olddefconfig && make -j'
> current version of booted 6.0.0-rc6 is available as
> https://github.com/mator/sparc64-dmesg/blob/master/config-6.0.0-rc6-00010=
-gb7f0f527dc3c.gz

Forgive my uniformed chime-in but Linus seemed happy with the size of
-rc7 and now I'm worried there won't be an -rc8. AFAICT this is a 6.0
regression. Vasily, Shakeel, do we have a plan to fix this?
