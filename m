Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5145607C52
	for <lists+cgroups@lfdr.de>; Fri, 21 Oct 2022 18:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiJUQeg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Oct 2022 12:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJUQee (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Oct 2022 12:34:34 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913E36BDF
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 09:34:32 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-36a4b86a0abso12559887b3.7
        for <cgroups@vger.kernel.org>; Fri, 21 Oct 2022 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eezqEwsIGJ/3LQ+iomLSnITt2mDK2P9swpPnQUGCMyw=;
        b=eeYBEPOInivK/gm9Wbwr5myNmL3Je14M9B/vkpy9C6yuJsq62jmu+St6YRyVSeo6K7
         eYigHE3TI0fmuyXCzTIeDm0E9yzx0c/RPTwgh2ANcXRBYFOTDDRZNqGhHovA9qDCFejO
         vJc7kvg5AQw0o23AGo1zxjljqKjjlDzQ4/9oWZ+KzHTVFdUUaWfKCsw3j0Rb1e4nnEkV
         niAvcIdmPNqpdQYKwhRTKgy0FUoNEsMb0GmjXbbwqbQAqzJxUgojWyJCVvdEfo+iEpz6
         s3z4l01ggnsAsEryGKg0Pvr+Xl2Pw+sshGyIzje1hKAUDEWm9qbDhhavsAFChCl8Dcy4
         rUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eezqEwsIGJ/3LQ+iomLSnITt2mDK2P9swpPnQUGCMyw=;
        b=H9QGRD2AgjLayzgutAe6pkFIBvfLKOl83HcWirm9CRHxT90ZZfwJZMrlY5yjUmRGW7
         85Y8fs1q9wH4S78cp/LjdiHEeniHk2cNjG3wv7ZjN0Kw70Os9l/W8TPrluHY3yRkO2/Q
         eE05Lz7qatSae11hNlznorBkLWNfVZ3d/jEWgK+QVHnn6ux7KR4qGo6/yf/E/0Hk6Xyu
         M0cqznpGDiMYLoGGiavUbKXo4xMpjFuVv6uJQGF4B8Xn5Y9KpBzMiO0PqUODQDC2/T+D
         eoOtsC8S7+q5OgxXhykYgxYSX4xkMzxzFmXMllByfpNgfLppM99653MBir7rJfH1OHQ1
         bj3Q==
X-Gm-Message-State: ACrzQf2TAUOnvCfouwMieWxB33L7B2fWsXY+ryJHYAz+7jotSop4+vEI
        zTEngFu+5bM4xNQlVMt2FoLG0+0U5yHAGWLxMCtGmw==
X-Google-Smtp-Source: AMsMyM4ANDQPBUw4NtIbT6ahOVpd4py92PgVK1DB3C4kWmACZ4DJQUVXOt9FeSdSZvqmlz2Q2lG+IsBHsjxCgbVAFQY=
X-Received: by 2002:a0d:ff01:0:b0:353:380e:ca03 with SMTP id
 p1-20020a0dff01000000b00353380eca03mr17607801ywf.466.1666370071183; Fri, 21
 Oct 2022 09:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221021160304.1362511-1-kuba@kernel.org> <CALvZod4eezAXpehT4jMiQry4JQ5igJs7Nwi1Q+YhVpDcQ8BMRA@mail.gmail.com>
 <CANn89iKTi5TYyFOOpgw3P0eTi1Gqn4k-eX+xRTX78Q4sAunm2Q@mail.gmail.com>
In-Reply-To: <CANn89iKTi5TYyFOOpgw3P0eTi1Gqn4k-eX+xRTX78Q4sAunm2Q@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 21 Oct 2022 09:34:20 -0700
Message-ID: <CALvZod5di3saFdDJ1cwFDgvLPmnEJ7XB9P8YBTJ3uzfBKAFi3Q@mail.gmail.com>
Subject: Re: [PATCH net] net-memcg: avoid stalls when under memory pressure
To:     Eric Dumazet <edumazet@google.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        davem@davemloft.net, pabeni@redhat.com, cgroups@vger.kernel.org,
        roman.gushchin@linux.dev, weiwan@google.com, ncardwell@google.com,
        ycheng@google.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, Oct 21, 2022 at 9:28 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Oct 21, 2022 at 9:26 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Fri, Oct 21, 2022 at 9:03 AM Jakub Kicinski <kuba@kernel.org> wrote:
> > >
> > > As Shakeel explains the commit under Fixes had the unintended
> > > side-effect of no longer pre-loading the cached memory allowance.
> > > Even tho we previously dropped the first packet received when
> > > over memory limit - the consecutive ones would get thru by using
> > > the cache. The charging was happening in batches of 128kB, so
> > > we'd let in 128kB (truesize) worth of packets per one drop.
> > >
> > > After the change we no longer force charge, there will be no
> > > cache filling side effects. This causes significant drops and
> > > connection stalls for workloads which use a lot of page cache,
> > > since we can't reclaim page cache under GFP_NOWAIT.
> > >
> > > Some of the latency can be recovered by improving SACK reneg
> > > handling but nowhere near enough to get back to the pre-5.15
> > > performance (the application I'm experimenting with still
> > > sees 5-10x worst latency).
> > >
> > > Apply the suggested workaround of using GFP_ATOMIC. We will now
> > > be more permissive than previously as we'll drop _no_ packets
> > > in softirq when under pressure. But I can't think of any good
> > > and simple way to address that within networking.
> > >
> > > Link: https://lore.kernel.org/all/20221012163300.795e7b86@kernel.org/
> > > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > > Fixes: 4b1327be9fe5 ("net-memcg: pass in gfp_t mask to mem_cgroup_charge_skmem()")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > > CC: weiwan@google.com
> > > CC: shakeelb@google.com
> > > CC: ncardwell@google.com
> > > CC: ycheng@google.com
> > > ---
> > >  include/net/sock.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 9e464f6409a7..22f8bab583dd 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2585,7 +2585,7 @@ static inline gfp_t gfp_any(void)
> > >
> > >  static inline gfp_t gfp_memcg_charge(void)
> > >  {
> > > -       return in_softirq() ? GFP_NOWAIT : GFP_KERNEL;
> > > +       return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
> > >  }
> > >
> >
> > How about just using gfp_any() and we can remove gfp_memcg_charge()?
>
> How about keeping gfp_memcg_charge() and adding a comment on its intent ?
>
> gfp_any() is very generic :/

SGTM.
