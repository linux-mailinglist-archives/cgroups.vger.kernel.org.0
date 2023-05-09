Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA26FCD13
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 19:58:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjEIR6Q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 13:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbjEIR6P (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 13:58:15 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDEA4499
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 10:58:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f38a9918d1so220711cf.1
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 10:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683655093; x=1686247093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhZkJ8mwG4mA4GCg1/8ebcBN7nEL6s99qLu8EGL+6aM=;
        b=KgfWhPK3zHiclIOgn2Kt/8GHAUxSexMKKgnsWOlc7aVOEV4EKytoa+H0EqUWWLumnT
         1dRSubDaBeFdDFq5mk6LysSPbERN+lyQPD6IuvnSJnePeVD1mQLJ88Za+dm8IVENdkjb
         WQRDUXrSe8O8ohUX6luTRGj+g5E9a9OHHVag8TjgszPmoF94rDtT+dNxqBrAns28z89w
         V5qmy+0WHT/mBZruiHDgKsBO1vYTxuKtWFMvj3ulbgcdd/+mfQsRI7sweMdZHiLG7Cab
         FDLGqCHgc/hpMLWaXSeZ00gzyUNtkn9ZNZnNo5zXiUsxk7Epss7emB+77WZKRnXVFIUf
         UZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683655093; x=1686247093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhZkJ8mwG4mA4GCg1/8ebcBN7nEL6s99qLu8EGL+6aM=;
        b=HHCCi8dE7T3TzroZ+h8nYq4OcmXJrc8ilDi2j+GFR0LOIjHTliJNHgfKKpSLI6tH7y
         lFyT/zOzZnHj8u1ntM5KNMxOtDcNUw/y4WgiRFhDfk3+V98Qhc+rUwOYMknoj7YRXp64
         qEMSGhbLp7U+pqEFUq1IGXdu2PPacGdGp1mRXC/jdMrvCGXhLSl32oxio7x+0w2eZLqO
         siOLQI4e2yGamI8SuzOh/ww4BmKhZVJFW1nWvdMtkRiQvgq26T7LAL3SQVx/ctuzhvya
         g8N3OQ9nwV9p+DwGduWUWnew6ScBeMZH725YgXUiX9NqxLM5AHg843uagSNRTDdWZTA+
         MkAQ==
X-Gm-Message-State: AC+VfDxMg3suY8h+dsyYUnFpWWMgFo6XPDw9jszWozBjs2xHi01a6NO9
        txnvLoTR42uS0hps1EoxUHsQnzlaNpJLmyDdJB3K1Q==
X-Google-Smtp-Source: ACHHUZ49rJPjHxjqOEHg2XTDvvYXxlAomMZ/J8dwcm1ggGpbs6cJE4E4fgmh/Nng3T5GtklLnTYVfidXTQDFZNjsIF8=
X-Received: by 2002:a05:622a:1a0a:b0:3ef:302c:319e with SMTP id
 f10-20020a05622a1a0a00b003ef302c319emr15535qtb.8.1683655093002; Tue, 09 May
 2023 10:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230508020801.10702-1-cathy.zhang@intel.com> <20230508020801.10702-2-cathy.zhang@intel.com>
 <3887b08ac0e55e27a24d2f66afcfff1961ed9b13.camel@redhat.com>
 <CH3PR11MB73459006FCE3887E1EA3B82FFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CH3PR11MB73456D792EC6E7614E2EF14DFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89iL6Ckuu9vOEvc7A9CBLGuh-EpbwFRxRAchV-6VFyhTUpg@mail.gmail.com> <CH3PR11MB73458BB403D537CFA96FD8DDFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB73458BB403D537CFA96FD8DDFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 May 2023 10:58:01 -0700
Message-ID: <CALvZod6JK1Ts90uGYSDRWXX3-D=gyN3q+Bpy-oW+dqJsjjBm2w@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     "Zhang, Cathy" <cathy.zhang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Srinivas, Suresh" <suresh.srinivas@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "You, Lizhen" <lizhen.you@intel.com>,
        "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 9, 2023 at 8:07=E2=80=AFAM Zhang, Cathy <cathy.zhang@intel.com>=
 wrote:
>
[...]
> >
> > Something must be wrong in your setup, because the only small issue tha=
t
> > was noticed was the memcg one that Shakeel solved last year.
>
> As mentioned in commit log, the test is to create 8 memcached-memtier pai=
rs
> on the same host, when server and client of the same pair connect to the =
same
> CPU socket and share the same CPU set (28 CPUs), the memcg overhead is
> obviously high as shown in commit log. If they are set with different CPU=
 set from
> separate CPU socket, the overhead is not so high but still observed.  Her=
e is the
> server/client command in our test:
> server:
> memcached -p ${port_i} -t ${threads_i} -c 10240
> client:
> memtier_benchmark --server=3D${memcached_id} --port=3D${port_i} \
> --protocol=3Dmemcache_text --test-time=3D20 --threads=3D${threads_i} \
> -c 1 --pipeline=3D16 --ratio=3D1:100 --run-count=3D5
>
> So, is there anything wrong you see?
>

What is the memcg hierarchy of this workload? Is each server and
client processes running in their own memcg? How many levels of
memcgs? Are you setting memory.max and memory.high to some value? Also
how are you limiting the processes to CPUs? cpusets?
