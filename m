Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4666FCAD2
	for <lists+cgroups@lfdr.de>; Tue,  9 May 2023 18:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbjEIQKa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 May 2023 12:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235645AbjEIQK2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 May 2023 12:10:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF88549D7
        for <cgroups@vger.kernel.org>; Tue,  9 May 2023 09:10:04 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f38a9918d1so187811cf.1
        for <cgroups@vger.kernel.org>; Tue, 09 May 2023 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683648602; x=1686240602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=054gJFj18y9E5NHnUst30bbm3PQm/ns3W+RPSXlvtZM=;
        b=FeyJSto0eE1PW0zKt+JH2brPNMpgwF9ERJtxTo4A+lAjD1oNYOqOUWAiXdiuC4vUoK
         yYi8ZhCTvz3SG4FGMPuw3RRq5NJGNEeVdXXuggcvpXO4/LBardBfE5kS89dALJpVCpIo
         Ir0Ek2UuCCDbsICvBiSHNs9UlJ5HRoljbiIOLCAmgQSSk5OHi9gRVgh/HfMVyyCYz7rI
         Pr22DNiatqevl8xq5optxjhuQvQiEyqJ5CgrIDyRW/JSxgBl4qH6U2+GffrqzGjiBguS
         s8HqCC65JeYfj2ejdPo3RstWVvHJzyCeCV7jW5reMGX8xjySgL6UVakoJhOSulZvuODm
         0Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683648602; x=1686240602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=054gJFj18y9E5NHnUst30bbm3PQm/ns3W+RPSXlvtZM=;
        b=FXYPoLDt/PmH/k9dfOkifg6s1jt5ctRBAIIpddjlce4E7Y/bYj1lRmPC/3wKqzi2Dp
         MD9toOCayfHWKAM/b2BlztfdPhhT1RILXfu4arkoQf3obyVH6LEHk3nj8fFNQVr9GT+k
         yxDeLEI40KOjHn9mzc97uMLIitEAbpMeCvufeuvzJnGeSY87u/opH3IJPSF7h/jXCROi
         aCCi5IC8EQJnk7xnLbFKEOvLRg1JDxLVGLKNisvJfDXG/8cuXNaBBt0HPTZA2txdSQeP
         culdCrSf77bNQHVp6BrFlFpRpom/zJVrojnVTnWimriVIOjHsPtzAT3XvYQi2avtp7Rm
         hxbg==
X-Gm-Message-State: AC+VfDzVSTDIiGBHHKxMY5U8WDuNgedHaIYuG6spJQkYbmGTCcLV4gEE
        oWkBipul2V4XfkZEE1OeseLxRQhWauyZO1echga6fg==
X-Google-Smtp-Source: ACHHUZ7Js3saEMZDJR4cRznuKzrKfr6n52KBV+AV0kCsx3edMnIueD8bXVMMoId0w2UCa8rZeMO+I/5BZGr0nURAiHE=
X-Received: by 2002:a05:622a:5ca:b0:3ef:1c85:5b5e with SMTP id
 d10-20020a05622a05ca00b003ef1c855b5emr284466qtb.19.1683648602215; Tue, 09 May
 2023 09:10:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230508020801.10702-1-cathy.zhang@intel.com> <20230508020801.10702-2-cathy.zhang@intel.com>
 <3887b08ac0e55e27a24d2f66afcfff1961ed9b13.camel@redhat.com>
 <CH3PR11MB73459006FCE3887E1EA3B82FFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CH3PR11MB73456D792EC6E7614E2EF14DFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89iL6Ckuu9vOEvc7A9CBLGuh-EpbwFRxRAchV-6VFyhTUpg@mail.gmail.com>
 <CH3PR11MB73458BB403D537CFA96FD8DDFC769@CH3PR11MB7345.namprd11.prod.outlook.com>
 <CANn89iJvpgXTwGEiXAkFwY3j3RqVhNzJ_6_zmuRb4w7rUA_8Ug@mail.gmail.com>
In-Reply-To: <CANn89iJvpgXTwGEiXAkFwY3j3RqVhNzJ_6_zmuRb4w7rUA_8Ug@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 9 May 2023 09:09:50 -0700
Message-ID: <CALvZod6JRuWHftDcH0uw00v=yi_6BKspGCkDA4AbmzLHaLi2Fg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: Keep sk->sk_forward_alloc as a proper size
To:     Eric Dumazet <edumazet@google.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>
Cc:     "Zhang, Cathy" <cathy.zhang@intel.com>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+linux-mm & cgroup

Thread: https://lore.kernel.org/all/20230508020801.10702-1-cathy.zhang@inte=
l.com/

On Tue, May 9, 2023 at 8:43=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
[...]
> Some mm experts should chime in, this is not a networking issue.

Most of the MM folks are busy in LSFMM this week. I will take a look
at this soon.
