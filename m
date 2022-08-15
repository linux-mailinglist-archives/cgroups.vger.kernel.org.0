Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37239593236
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiHOPnG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 11:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiHOPnB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 11:43:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251DA634E
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:43:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m10-20020a05600c3b0a00b003a603fc3f81so122163wms.0
        for <cgroups@vger.kernel.org>; Mon, 15 Aug 2022 08:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VXv0LOcDj4wDch9oUz0Rg6Hn1DlfxulSzEjxccYfhGA=;
        b=kuXZ020zirScuI8v9FKyyjruMwGPxrzXP6LoEx3u/8kcVVLGMONtTMedOIwBzD3Q4y
         h1vq0DMIcF8z5GzNykL4EUewOg3nx/rYdnNk7N83gzbus1Kz9jcmr2Q1Nh1MIPup0GTr
         64ZjOM7ixJCy36gyD3x9r1bVvlWALIaRdQrmWbZD19HvfB+o8tLqRXwNNJi7/0+xYLic
         8L9ikKVSiX/VOb8RTFpTmTiB2Wr4LH+DUu7DLEOo1IP5RNc8yumVeZ3JSz++XNcihLf1
         /w68PiG5Ayrydse3W1c7L/cQh70wh+R8OqutqgdgUrGKLnk9Z4JbKL72vlZefQAAXt7d
         jbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VXv0LOcDj4wDch9oUz0Rg6Hn1DlfxulSzEjxccYfhGA=;
        b=sFjIsrqq3RuGtM78z0Le5HF2jNK6gyYpquCaE9jtuFe1E0oelZajNp99QN7armDLpv
         /qDggpnN9ECQTrpGqvMLcfl067cWjMpE4e6bJxHWltJMqAHNFh5sAR1nW8+b0HM2Wg0F
         14/b24suBO39mknOFl9f8EDQiayKNqIYu/dMGCFZ8i0oYvrv7CT8akfBeluhGX2T2WVz
         4ediUMo77WlC3G8xN2gNSN6PJeCXZZAijnnVvfOH4J7zoYB4XTXGQUD8e3W+3WRA8ta6
         AxmqbSE8uuHA27P/XwTm0ZtLnwleh77c214s5+dNXmSpaSAOLthjSOy6x51dTt/isAw/
         gCjA==
X-Gm-Message-State: ACgBeo0Q2b5b8xrz+Y/Hy9mNqj60ZTLA8je/3v0KdPQ6pkHXmOLjn6hH
        iDyz7cLWyiL9H3r4st4WeTF+q+BCdKHFqo+YUTBuHQ==
X-Google-Smtp-Source: AA6agR7bAfA1WsIxESmZab8V41V3VdXyK1mDC3QI1IpyqEpMXC1wCmJEKmzMSseUayG1c6XSsU2euR3JJN3ZR4CaVyE=
X-Received: by 2002:a7b:ce12:0:b0:3a5:4d8b:65df with SMTP id
 m18-20020a7bce12000000b003a54d8b65dfmr10514445wmc.27.1660578179613; Mon, 15
 Aug 2022 08:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220811081913.102770-1-liliguang@baidu.com> <YvWa9MOQWBICInjO@P9FQF9L96D.corp.robot.car>
 <CALvZod4nnn8BHYqAM4xtcR0Ddo2-Wr8uKm9h_CHWUaXw7g_DCg@mail.gmail.com>
 <CAJD7tkbrCNDMkE8dJDWHiTfi=nJJzrZwepaWb3YioRHMrSEuQA@mail.gmail.com>
 <1704B09B-F758-47DF-BDDE-FEA9AB227E12@baidu.com> <CAJD7tkaW7qtaNpc3UHuQAcJAjdjzjmWZCqCMafT-nUES+2QtYg@mail.gmail.com>
 <E0E6FD3B-242B-4187-B4B4-9D4496A5B19A@baidu.com> <CAJD7tkYdJrakJGp8XMt49ixZJuf=qpGm=vSxH6G_GWeenk35dQ@mail.gmail.com>
 <Yvpm3cubIRAqUUJn@cmpxchg.org>
In-Reply-To: <Yvpm3cubIRAqUUJn@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 15 Aug 2022 08:42:22 -0700
Message-ID: <CAJD7tkaSS61YqYHKztqimASEaEakAdV0XqMs_k0ooJhUbX0+=g@mail.gmail.com>
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

On Mon, Aug 15, 2022 at 8:31 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:46:46AM -0700, Yosry Ahmed wrote:
> > Yeah I understand this much, what I don't understand is why we charge
> > the zswap memory through objcg (thus tying it to memcg kmem charging)
> > rather than directly through memcg.
>
> The charged quantities are smaller than a page, so we have to use the
> byte interface.
>
> The byte interface (objcg) was written for slab originally, hence the
> link to the kmem option. But note that CONFIG_MEMCG_KMEM is no longer
> a user-visible option, and for all intents and purposes a fixed part
> of CONFIG_MEMCG.
>
> (There is the SLOB quirk. But I'm not sure anybody uses slob, let
> alone slob + memcg.)

Thanks for the clarification, it makes sense to use the byte interface
here for this, and thanks for pointing out that CONFIC_MEMCG_KMEM is
not part of CONFIG_MEMCG.

One more question :) memcg kmem charging can still be disabled even
with !CONFIG_MEMCG_KMEM, right? In this case zswap charging will also
be off, which seems like an unintended side effect, right?
