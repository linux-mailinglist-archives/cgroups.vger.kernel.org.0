Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1153A7220FE
	for <lists+cgroups@lfdr.de>; Mon,  5 Jun 2023 10:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjFEI2o (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 5 Jun 2023 04:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjFEI2n (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 5 Jun 2023 04:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6C2106
        for <cgroups@vger.kernel.org>; Mon,  5 Jun 2023 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685953674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4k9ejeJipUmGqnerdW7qBglT2xl37GJzyfeka156tNU=;
        b=i1ITGBn7F2D+xDC6J/xGYInn0BFyLPzwMqthZaSfQJw/+ytuYviEQ7+iRFqdB88LGvGBMQ
        TIU8MS9PWDUsbEcoDSN+bJQrqJBWWUMcA7LYLrfNk18Z+jOh6PZzCmLZFfqNrCR+haMuIr
        VQMioVEp4baZMV+hZ7avYId6zOb0PeA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-1csm31DOP22SCSjZPu0_MA-1; Mon, 05 Jun 2023 04:27:52 -0400
X-MC-Unique: 1csm31DOP22SCSjZPu0_MA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-62829b2aa10so5004086d6.1
        for <cgroups@vger.kernel.org>; Mon, 05 Jun 2023 01:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685953672; x=1688545672;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4k9ejeJipUmGqnerdW7qBglT2xl37GJzyfeka156tNU=;
        b=WEURqgM/CtERpB9y5gt72mnv5C6GkEMJnpyxf/uELGhgFBGtDIBtM3Ewb7iiIwUyHv
         hSaD2q9r0IkTkCqIpQRdsbEZE1P4yqg9GzdzVjuPxL5ZqIhP5DljkmDFBpWRGkVymaBC
         Y1xaoem2LVdUmt6kTvSZ+1+Tb1jdQfFK1TJVM3j6FKzEm9JP5V0payK6pW3kCm3XJXVR
         7VQa8UMOhXfcS/4HYwR9mjoGTKP20IqV3JpGVw0COFmxFpgx0PJfLAZnxAa0hzBh+AnA
         hNrMnjy/ER1t6dLn76ntqR6tfc4mbq02CCi7/B3lMir8TNRAYu2A/1XbMSAdJY+gBAjv
         tkIg==
X-Gm-Message-State: AC+VfDyoXmGm2AEA9azYbE1+IIeZw6rmaVzUxGybqUWJnKV1i21U/uIc
        f+7lNQHozdf8pko7MwxY7wyPcWYvmYO6og/q8hwyP7IMeeFZZ7PmPX2fZ33H9PJRn/PVipNp9xa
        OrMzj1GaSLU5RzyKAJQ==
X-Received: by 2002:a05:6214:410f:b0:626:2305:6073 with SMTP id kc15-20020a056214410f00b0062623056073mr21712842qvb.4.1685953672207;
        Mon, 05 Jun 2023 01:27:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6x8xvjBHOeDpKThqJXAjz1LvTbJ5ry30UCc6PfetIEWY5eDRgLkUTv9HqbaPAJ3FV7Rmk7OQ==
X-Received: by 2002:a05:6214:410f:b0:626:2305:6073 with SMTP id kc15-20020a056214410f00b0062623056073mr21712826qvb.4.1685953671963;
        Mon, 05 Jun 2023 01:27:51 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-207.dyn.eolo.it. [146.241.254.207])
        by smtp.gmail.com with ESMTPSA id y22-20020ac87096000000b003f38f55e71asm4541409qto.47.2023.06.05.01.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:27:51 -0700 (PDT)
Message-ID: <727b1fb64d04deb8b2a9ae1fec4b51dafa1ff2b5.camel@redhat.com>
Subject: Re: Re: [PATCH net-next v5 2/3] sock: Always take memcg pressure
 into consideration
From:   Paolo Abeni <pabeni@redhat.com>
To:     Abel Wu <wuyun.abel@bytedance.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <muchun.song@linux.dev>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 05 Jun 2023 10:27:47 +0200
In-Reply-To: <6f67c3ca-5e73-d7ac-f32a-42a21d3ea576@bytedance.com>
References: <20230602081135.75424-1-wuyun.abel@bytedance.com>
         <20230602081135.75424-3-wuyun.abel@bytedance.com>
         <20230602204159.vo7fmuvh3y2pdfi5@google.com>
         <CAF=yD-LFQRreWq1RMkvLw9Nj3NQpJwbDSCfECUhh-aVchR-jsg@mail.gmail.com>
         <6f67c3ca-5e73-d7ac-f32a-42a21d3ea576@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, 2023-06-05 at 11:44 +0800, Abel Wu wrote:
> On 6/4/23 6:36 PM, Willem de Bruijn wrote:
> > On Fri, Jun 2, 2023 at 10:42=E2=80=AFPM Shakeel Butt <shakeelb@google.c=
om> wrote:
> > >=20
> > > On Fri, Jun 02, 2023 at 04:11:34PM +0800, Abel Wu wrote:
> > > > The sk_under_memory_pressure() is called to check whether there is
> > > > memory pressure related to this socket. But now it ignores the net-
> > > > memcg's pressure if the proto of the socket doesn't care about the
> > > > global pressure, which may put burden on its memcg compaction or
> > > > reclaim path (also remember that socket memory is un-reclaimable).
> > > >=20
> > > > So always check the memcg's vm status to alleviate memstalls when
> > > > it's in pressure.
> > > >=20
> > >=20
> > > This is interesting. UDP is the only protocol which supports memory
> > > accounting (i.e. udp_memory_allocated) but it does not define
> > > memory_pressure. In addition, it does have sysctl_udp_mem. So
> > > effectively UDP supports a hard limit and ignores memcg pressure at t=
he
> > > moment. This patch will change its behavior to consider memcg pressur=
e
> > > as well. I don't have any objection but let's get opinion of UDP
> > > maintainer.

Thanks for the head-up, I did not notice the side effect on UDP.

>=20
> > So this commit only affects the only other protocol-independent
> > caller, __sk_mem_reduce_allocated, to possibly call
> > sk_leave_memory_pressure if now under the global limit.
> >=20
> > What is the expected behavioral change in practice of this commit?
>=20
> Be more conservative on sockmem alloc if under memcg pressure, to
> avoid worse memstall/latency.

I guess the above is for TCP sockets only, right? Or at least not for
UDP sockets?

If so, I think we should avoid change of behaviour for UDP - e.g.
keeping the initial 'if (!sk->sk_prot->memory_pressure)' in
sk_under_memory_pressure(), with some comments about the rationale for
future memory. That should preserve the whole patchset effect for other
protocols, right?

If instead you are also interested into UDP sockets under pressure, how
that is going to work? UDP sockets can reclaim memory only at send and
close time. A memcg under pressure could starve some sockets forever if
the the ones keeping the memory busy are left untouched.

Cheers,

Paolo

