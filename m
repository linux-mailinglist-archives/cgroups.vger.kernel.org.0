Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20F05932D4
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiHOQQs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiHOQQr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 12:16:47 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA7A11462
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 09:16:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs25so9631743wrb.2
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=NiPfdsvJTMDvYiHxjIlVruzvPreI0sXDM9XcYGIg7ro=;
        b=nwlr6RfxGmDc9FPkJ8pMlRUSKkvKSg+/dfOHtYjazvYB24ITZuxH/BAX6MimWtVEt5
         n+rj74b/x0akMGs3XmfmLkowqdqDvCffGxwrIOz8S4UhChIKz9jmQAwrsZqnpX8RdzC9
         w9sqnuDygJOGVGsaHKzf8Jm6cyhZ9mykLbbOFlbSpHYSm4ahEYXZWoe/P71sxc+tM+0i
         rB0ns4hUoBgGGlfHhNxrjsWInDwvOjLhCs1zKhHVDgUjuyOHM/eRK4Tj6k8QruiD7PGo
         QNiOubqUnrhLUSOQuqw7ppZqZHrfeHy/9losRWfPEW/FRmo0+orGsjl7Wz7PiCGNqjIh
         AU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=NiPfdsvJTMDvYiHxjIlVruzvPreI0sXDM9XcYGIg7ro=;
        b=Z2Cam2OpsAH6Tzhpztkf4mz4H24eBS2X9pjEcqG7Cla+ZUIcmZPAVkhqcycc8hT+dy
         CSkgFQpKo+7evNLA6BpOIb9XmwFatkI1ekHak2lVR+YmjXLTTGSvaYQtsTp5eQaf+Fjh
         AYhRzhMBtSwIIzC462G8CbyB4d7D0olHojklQPxpq2AOg0dDduY3AaMKdhd6HN87+5CW
         Ht+S2XDVQxeXnhYhOJkAT1BMSQJqjvVykXJt7oDUWKgMrq1ADLfGgPJ5PxQcFTLVRTXx
         0CF8NmSS3L1VPkskqht+vsvOkgSjIC0i40CsubCCtZG1UVy0QEdV1CrFiog97V+LfSw6
         sqsQ==
X-Gm-Message-State: ACgBeo1MriNHK6ybk/pCNtJoOy66TgzfcAOdKuHd/Mj54PkSuNzj/GQv
        rWPo97hRs/bepwWG2bueorHcoOsCsYlDQqBk1iy6tw==
X-Google-Smtp-Source: AA6agR7wnzX0cPOcBpRwKh4CONE07IPvK6A7N0EsOaKxiU2s3xeJZN6akI8wO98n3eKC4k4TQOx2f3mlBiHOm/tZslw=
X-Received: by 2002:a05:6000:1188:b0:220:6c20:fbf6 with SMTP id
 g8-20020a056000118800b002206c20fbf6mr9406978wrx.372.1660580204489; Mon, 15
 Aug 2022 09:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com> <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com> <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
 <Yvpm3cubIRAqUUJn@cmpxchg.org> <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
In-Reply-To: <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 09:16:08 -0700
Message-ID: <CAJD7tkbVz44d64yPm15kUMmpFEQwFtut6Ye8D8oO1jiS9s_tBw@mail.gmail.com>
Subject: Re: [PATCH] mm: correctly charge compressed memory to its memcg
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     "Li,Liguang" <liliguang@baidu.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
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

On Mon, Aug 15, 2022 at 8:42 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Mon, Aug 15, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> > > Yeah I understand this much, what I don't understand is why we charge
> > > the zswap memory through objcg (thus tying it to memcg kmem charging)
> > > rather than directly through memcg.
> >
> > The charged quantities are smaller than a page, so we have to use the
> > byte interface.
> >
> > The byte interface (objcg) was written for slab originally, hence the
> > link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
> > a user-visible option, and for all intents and purposes a fixed part
> > of CONFIG_MEMCG.
> >
> > (There is the SLOB quirk. But I'm not sure anybody uses slob, let
> > alone slob + memcg.)
>
> Thanks for the clarification, it makes sense to use the byte interface
> here for this, and thanks for pointing out that CONFIC_MEMCG_KMEM is
> not part of CONFIG_MEMCG.
>
> One more question :) memcg kmem charging can still be disabled even
> with !CONFIG_MEMCG_KMEM, right? In this case zswap charging will also
> be off, which seems like an unintended side effect, right?

memcg kmem charging can still be disabled even
with CONFIG_MEMCG_KMEM***
