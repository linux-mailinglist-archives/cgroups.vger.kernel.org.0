Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5035242E0
	for <lists+cgroups@lfdr.de>; Thu, 12 May 2022 04:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243351AbiELCsl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 11 May 2022 22:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243042AbiELCsl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 11 May 2022 22:48:41 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652F51957BA
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 19:48:39 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id s23so3960853iog.13
        for <cgroups@vger.kernel.org>; Wed, 11 May 2022 19:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xtNpsVsaVZqX+nLgswyUb5xinkvrzu2jSXspDWuy6ao=;
        b=IsD81cUQTxFLLiCf8ZUh17UC4XEeB4YvQSbZCBminUMBlEwBgG1pdELuzADA6mkmtO
         bN1VjOS1G4iq0pPoFUuCdL01CJPbcWU/jtZw/r/Iw/TWW2O2sT/2DBYeDEPg6REYgnrx
         YiCvy2OBG7mUbOCxCwSOXiZdIZ70fNYpvxx8gsQb92k4LR86sHH8dW4LgzPXNe4UYBHh
         WQvvU2HywxJjxSnkQv86Z36xEoxTmZsLGF6pfr8mdrPMu72RHi7UYdQ9kJmIf66MC7M/
         T7aFNuI8/YhJogcUESiT9cTOYQR7Z5pg2ExCQ17zeq3NYowpC/JW6BdAXop6h+lPNa2e
         d0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xtNpsVsaVZqX+nLgswyUb5xinkvrzu2jSXspDWuy6ao=;
        b=jC8cYpNIXiFwJ0q119Ydq3oqZlLsXLfEVYy0U0bdImjhVHee4awbLUJeWmMZTFyZRf
         tpy5pkyloNS/hzz3t0X+8AQ1/wD5kjn8q820i+1PUXpbEpBUdNq3g1MT1MG9oe6As662
         grWlJr++vGKVTx/gOgchCUuA4nppxgn/Qgc35G+ymg3mkgzeWWOqNE9AyJFkAej7emuK
         gHtRjGi5/NMuK1ylHGPBATxnlTMmETKeRiYZ03q16aO8sFIT5pX5Y7dHMNt/S7EYT0+e
         DRn69+xHaZs0nxRKk3f71Fm649WLSzyqqzGsOGlVAkFmNBbZGPin8Te0xn9zFXBn/cGP
         4pQA==
X-Gm-Message-State: AOAM532y6fAchsbAuo8B7/OPQHzYJN9l59KATV2MjdOOzGyr0nAhwuSd
        cFmwUNdN+iP5k08ZiPuSBvxIfX/2/FeignNxwx1nNrMOOw4=
X-Google-Smtp-Source: ABdhPJzi3anp8Q8gPIsD6XBEhZ/Loy2GtAZEdcg7f2IXP18hLfoq33T/Bwoc33Z98HXk2skhR9bYB+eRGvoSa1EShGQ=
X-Received: by 2002:a02:3b07:0:b0:32a:efae:69ce with SMTP id
 c7-20020a023b07000000b0032aefae69cemr12979932jaa.275.1652323718649; Wed, 11
 May 2022 19:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220507050916.GA13577@us192.sjc.aristanetworks.com> <20220511174953.GC31592@blackbody.suse.cz>
In-Reply-To: <20220511174953.GC31592@blackbody.suse.cz>
From:   Ganesan Rajagopal <rganesan@arista.com>
Date:   Thu, 12 May 2022 08:18:01 +0530
Message-ID: <CAPD3tpG_mDq+zpKnFTKgWCuW9_wCfsHMu2ndzOEBsLaqZp-KWA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/memcontrol: Export memcg->watermark via sysfs for
 v2 memcg
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 11, 2022 at 11:19 PM Michal Koutn=C3=BD <mkoutny@suse.com> wrot=
e:
>
> Hi.
>
> On Fri, May 06, 2022 at 10:09:16PM -0700, Ganesan Rajagopal <rganesan@ari=
sta.com> wrote:
> > We run a lot of automated tests when building our software and run into
> > OOM scenarios when the tests run unbounded. v1 memcg exports
> > memcg->watermark as "memory.max_usage_in_bytes" in sysfs. We use this
> > metric to heuristically limit the number of tests that can run in
> > parallel based on per test historical data.
> >
> > This metric is currently not exported for v2 memcg and there is no
> > other easy way of getting this information. getrusage() syscall returns
> > "ru_maxrss" which can be used as an approximation but that's the max
> > RSS of a single child process across all children instead of the
> > aggregated max for all child processes. The only work around is to
> > periodically poll "memory.current" but that's not practical for
> > short-lived one-off cgroups.
> >
> > Hence, expose memcg->watermark as "memory.peak" for v2 memcg.
>
> It'll save some future indirections if the commit messages includes the
> argument about multiple readers and purposeful irresetability.

Good point. The patch has already been picked up for mm-unstable. I don't
know what's the process in this situation. Should I post a "[PATCH v3]"
with an updated commit message?

>
> >
> > Signed-off-by: Ganesan Rajagopal <rganesan@arista.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst |  7 +++++++
> >  mm/memcontrol.c                         | 13 +++++++++++++
> >  2 files changed, 20 insertions(+)
>
> Besides that it looks useful and correct, feel free to add
> Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>

Thank you.

Ganesan
