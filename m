Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4BF7150DE
	for <lists+cgroups@lfdr.de>; Mon, 29 May 2023 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE2VMN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 May 2023 17:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjE2VMM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 29 May 2023 17:12:12 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8008DD2
        for <cgroups@vger.kernel.org>; Mon, 29 May 2023 14:12:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5651d8acfe2so82291727b3.2
        for <cgroups@vger.kernel.org>; Mon, 29 May 2023 14:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685394727; x=1687986727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNIbMRRuukreAZUC2GpTXXJapIJH6ZTqRY6eETcu5do=;
        b=a58aF0yeP61zDhlUOfNZLdoceiGGu26FxV3w360cVEX5mXHSCikCT9QZERrFOn+Wgg
         PQV3rmSuBZyWY7RJpxGCaweRtPtOGXNtJcQhRUc2Iiihmavwag/sytmxBLigXGwWZ5lk
         MLQoJyIYLb64f3BZPnDxbbiLlxkUMoohc9b/lJFrsKSBEmQDa4uuUXrKl0lWOYjJlass
         Vm9R7gNJl0aoBHuFj+eLnN5KovJ8X9KpPljEMIAznmET2jGKoJR2W7ks9R7Zl7Kw+ity
         mkmUkdCwuo7zJwvR5vpEgDRs5datWM1md9+4+SU5d4GrZlIohZop23cGF+rwOMxEyoPR
         NYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685394727; x=1687986727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNIbMRRuukreAZUC2GpTXXJapIJH6ZTqRY6eETcu5do=;
        b=N/mZWunkHv37kvyz8BRAc2r2nmzuK29pMGgTAPv6GcvjINeLdHaSWZe7MJ2aNkjKs0
         DWrL3PxAkKyz05ZWdJXc8yl/JnhOAstfuJhGWUMSwVLf+A3XnIcUxqUiBv/DEh7Q0Dj0
         n4ynbdOoKE423Te6TQyxOJPTNkflWtnIMsCwl/bpF8B36cts8QIMeiftU9KIRmCd9udq
         4DXMKCW7b+NMNDpZkfkDmLGOtvQdY5VTvO0xz72zZAwzj1IDWFEEmSn1v3XH/jFOzYzM
         kTMeuNq9+kY25MhkufV9+rKYqNZ8Bn+GAJiM9ioAFsDDeQ34ok9iqC6BW9ICnG7HINpl
         UaPw==
X-Gm-Message-State: AC+VfDzpgKWRDpxkzG6dUTcKAr6KT0h9gy1fsRwIPt9rHfhFXb+xWeAb
        MI+qJfJpxE5Q5sjIw8QGrgn7suzOAMAsEg==
X-Google-Smtp-Source: ACHHUZ4EK9Ki5lqBKfhxeJ5UQrbZDNyq0mE3Vi/VAJElmaNP79ShHBWggELHy87FMqUFasJeW9t+ieHOM3yayw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a81:b619:0:b0:561:bf07:ee28 with SMTP id
 u25-20020a81b619000000b00561bf07ee28mr54893ywh.5.1685394727672; Mon, 29 May
 2023 14:12:07 -0700 (PDT)
Date:   Mon, 29 May 2023 21:12:05 +0000
In-Reply-To: <73b1381e-6a59-26fe-c0b6-51ea3ebf60f8@bytedance.com>
Mime-Version: 1.0
References: <20230522070122.6727-1-wuyun.abel@bytedance.com>
 <20230522070122.6727-4-wuyun.abel@bytedance.com> <20230525012259.qd6i6rtqvvae3or7@google.com>
 <73b1381e-6a59-26fe-c0b6-51ea3ebf60f8@bytedance.com>
Message-ID: <20230529211205.6clthjyt37c4opju@google.com>
Subject: Re: [PATCH v2 3/4] sock: Consider memcg pressure when raising sockmem
From:   Shakeel Butt <shakeelb@google.com>
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


+linux-mm and cgroups

On Mon, May 29, 2023 at 07:58:45PM +0800, Abel Wu wrote:
> Hi Shakeel, thanks for reviewing! And sorry for replying so late,
> I was on a vocation :)
> 
> On 5/25/23 9:22 AM, Shakeel Butt wrote:
> > On Mon, May 22, 2023 at 03:01:21PM +0800, Abel Wu wrote:
> > > For now __sk_mem_raise_allocated() mainly considers global socket
> > > memory pressure and allows to raise if no global pressure observed,
> > > including the sockets whose memcgs are in pressure, which might
> > > result in longer memcg memstall.
> > > 
> > > So take net-memcg's pressure into consideration when allocating
> > > socket memory to alleviate long tail latencies.
> > > 
> > > Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> > 
> > Hi Abel,
> > 
> > Have you seen any real world production issue which is fixed by this
> > patch or is it more of a fix after reading code?
> 
> The latter. But we do observe one common case in the production env
> that p2p service, which mainly downloads container images, running
> inside a container with tight memory limit can easily be throttled and
> keep memstalled for a long period of time and sometimes even be OOM-
> killed. This service shows burst usage of TCP memory and I think it
> indeed needs suppressing sockmem allocation if memcg is already under
> pressure. The memcg pressure is usually caused by too many page caches
> and the dirty ones starting to be wrote back to slow backends. So it
> is insane to continuously receive net data to consume more memory.
> 

We actually made an intentional decision to not throttle the incoming
traffic under memory pressure. See 720ca52bcef22 ("net-memcg: avoid
stalls when under memory pressure"). If you think the throttling
behavior is preferred for your application, please propose the patch
separately and we can work on how to enable flexible policy here.

> > 
> > This code is quite subtle and small changes can cause unintended
> > behavior changes. At the moment the tcp memory accounting and memcg
> > accounting is intermingled and I think we should decouple them.
> 
> My original intention to post this patchset is to clarify that:
> 
>   - proto pressure only considers sysctl_mem[] (patch 2)
>   - memcg pressure only indicates the pressure inside itself
>   - consider both whenever needs allocation or reclaim (patch 1,3)
> 
> In this way, the two kinds of pressure maintain purer semantics, and
> socket core can react on both of them properly and consistently.

Can you please resend you patch series (without patch 3) and Cc to
linux-mm, cgroups list and memcg maintainers as well?
