Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8977C166
	for <lists+cgroups@lfdr.de>; Mon, 14 Aug 2023 22:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjHNUTK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Aug 2023 16:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbjHNUSi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Aug 2023 16:18:38 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8474313E
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 13:18:37 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-407db3e9669so17811cf.1
        for <cgroups@vger.kernel.org>; Mon, 14 Aug 2023 13:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692044316; x=1692649116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFWKye89AohEqYgCuqyO0wjrP9O8bS1Mmve3otWwOUQ=;
        b=updUYgXLDGG4jlzZd5VTLcn4ck7IV7JsmtsFDKY3gGoK8cHcDcVAF65Px8wrcx4Rpw
         5aeohd2TIc+lBdHaUcKOLojjvG5i1Sjtomi5Efvu9HKhrYtbkVsFBJQDc/gXDZXhrqDd
         BTw7bVAxF4h6WbITliiLtT4buweGCJUSmaTwZQspzLmIKsmCe14t6a9HVIWT6YKlLvDV
         mNs74AwJ0zU0/tetCBfCfSp0XcnRJ1m3IpOmybV/upnND0Ytv7jyrvl1TXrF9NGHKWnc
         ExRJysByXqm0J8czAGmplNNLUBdHGyai37qngjYtFkqBvNbS/eLxW99NXQ+KREqbFOkq
         +u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692044316; x=1692649116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFWKye89AohEqYgCuqyO0wjrP9O8bS1Mmve3otWwOUQ=;
        b=bG7uX1p2RZEpf5tCdETml36o66swNdmRVgH6mj3iK32E4O7IRkT8Q+LmEtk9MNgLgM
         BWLF2Z2s20HaK80JNsX9l1iA0Ji7YrjrJ2fnYR0br0aL0rtyUmvcDCrVVlk2pTP25abX
         aREdR899RAdcO+NzmMknXOvGeH/mB/bvISSQSrTsIIQXrRdq9z2xL/bwW/Vi6ZhJy1vP
         GdlZXFkb9j0fZA8ZofRr5/WVS8eFFgCUvH7U1CUBB87RhwA9FRwzMpqMCRbgTcf+H2SG
         bCDqboZtrxTKOogXeV1pHID1f4ZhvNT2ve5t6x267JA8QIzIyrusUDP+tAAiQ4lwBveW
         QzOA==
X-Gm-Message-State: AOJu0YxkTIPhmCM2oKYukUMjGWk3WjwMsXsRKRsYJ88M1vOb86VtRJte
        5tdABslboucEe76Z+Pf6VsyvrHOfqOEwf19saL9nWw==
X-Google-Smtp-Source: AGHT+IEFdGrDQ4Nwqtzcf6NqnLR2GAMh5mfN76hFiLoqG57pskcDNdbraJUTBqKQzWqKSGAdkPmPVqBGYqsl0XuRfHo=
X-Received: by 2002:ac8:7c50:0:b0:40f:db89:5246 with SMTP id
 o16-20020ac87c50000000b0040fdb895246mr696564qtv.21.1692044316493; Mon, 14 Aug
 2023 13:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230814070923.35769-1-wuyun.abel@bytedance.com>
In-Reply-To: <20230814070923.35769-1-wuyun.abel@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Aug 2023 13:18:23 -0700
Message-ID: <CALvZod5C3yWdgWr83EAdVUCH5PEK8ew7Q+FOt_zGOFOE9HVyQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net-memcg: Fix scope of sockmem pressure indicators
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 14, 2023 at 12:09=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com>=
 wrote:
>
> Now there are two indicators of socket memory pressure sit inside
> struct mem_cgroup, socket_pressure and tcpmem_pressure, indicating
> memory reclaim pressure in memcg->memory and ->tcpmem respectively.
>
> When in legacy mode (cgroupv1), the socket memory is charged into
> ->tcpmem which is independent of ->memory, so socket_pressure has
> nothing to do with socket's pressure at all. Things could be worse
> by taking socket_pressure into consideration in legacy mode, as a
> pressure in ->memory can lead to premature reclamation/throttling
> in socket.
>
> While for the default mode (cgroupv2), the socket memory is charged
> into ->memory, and ->tcpmem/->tcpmem_pressure are simply not used.
>
> So {socket,tcpmem}_pressure are only used in default/legacy mode
> respectively for indicating socket memory pressure. This patch fixes
> the pieces of code that make mixed use of both.
>
> Fixes: 8e8ae645249b ("mm: memcontrol: hook up vmpressure to socket pressu=
re")
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

So, this is undoing the unintended exposure of v2 functionality for
the v1. I wonder if someone might have started depending upon that
behavior but I am more convinced that no one is using v1's tcpmem
accounting due to performance impact. So, this looks good to me.

Acked-by: Shakeel Butt <shakeelb@google.com>

I do think we should start the deprecation process of v1's tcpmem accountin=
g.
