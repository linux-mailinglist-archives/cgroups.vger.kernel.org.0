Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE26CFD7B
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 09:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjC3H4N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 03:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjC3H4D (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 03:56:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA02661AD
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:55:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id r11so73090574edd.5
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 00:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=ZD9aj6n0GX26RjIgVcV8XWHXeXxhiTySnXtfLlIh2Y4ULsYer620/o/Gxai5NDEyx0
         U9cLhrKkIyrcXCb9H0C1LsSrI3aYqgf3GO6P4vMGibxu+NJs5rV7tQbNe7/BuzZ9ngD4
         QlTJGq/55WJCvX0baHxwlbOU546xXFXX3rhwhxfTlPe1DtgL+SZFj+3v/M/zynT9IjDn
         ZyadAB66teMDMbs9xKwieRC4GEnlOFheMYpz1xGF7yvvoKjAofsoTZMoVDKAnSS6/+pv
         n2YA0BsqSmXP4EqjlRt/DgekBF6qWk4ejPD+mZWis8RRK9kN76WGkT00+z0dkPShQagp
         7beQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anbj3k8bVreIFvoy5ezWKZvlLhuV6pERZy1Bnx+kNns=;
        b=sNYz/11HTBTMNP/Us/CVjGAZEhZx+/sSlHJc/bk1Pq+wLzeruMhsYncNUEgpxEBMwo
         QvY6wqV49BFyx+zetTEmhM21MqZo8db+TajhB4/RXTpgyR/dCo8iNFwc4Bf4FgVT2D0s
         yJa+cSRi1CbikjDAcbxdoEFYQaivTl62+Is4r3AY8et7QpXIJiLD6Y5H/sK6/qJji6ek
         EmRlIPy/yCUYV3wrLd+nfzc+CGA4sInxyA1idMGcfiJv7BjUgqxtDkNnePxUgKvtWuIg
         e548lY4Gx/igRaE4hKACM9XGoed2FujhoTXmbyHlIFB3/LG1fXSb9Rg7E7WILn90PtEY
         EaaQ==
X-Gm-Message-State: AAQBX9f5NImFLVKkq46jM00wt0J1BY2tB90Y0m/9qNuGD/XB7+uZq3xs
        dvPSEucvZhO8mkHfc/tajIHwLvMQqP1aWNwC4u8DOg==
X-Google-Smtp-Source: AKy350ZKBVchKo8yL5qnCRGOKj6HMXymGhCHv0sbs5xG5akH53sSrKAZcQmbeW6Sz+oAWJWB2Er2VE8WUpb+CRjLT3s=
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr10952473ejb.15.1680162953989; Thu, 30
 Mar 2023 00:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
 <20230328221644.803272-8-yosryahmed@google.com> <ZCU8tjqzg8cDbobQ@dhcp22.suse.cz>
 <CAJD7tkZLBs=A8m5u=9jGtMeD0ptOgtCTYUoh2r4Ex+fCkvwAXg@mail.gmail.com> <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
In-Reply-To: <ZCU/SMr5gC9C0U+R@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 30 Mar 2023 00:55:17 -0700
Message-ID: <CAJD7tkZfexGoyZx0ormVzp_KkYmOczxBPfFaffKqd_TD4gvGCg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] workingset: memcg: sleep when flushing stats in workingset_refault()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 30, 2023 at 12:50=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Thu 30-03-23 00:42:36, Yosry Ahmed wrote:
> > On Thu, Mar 30, 2023 at 12:39=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Tue 28-03-23 22:16:42, Yosry Ahmed wrote:
> > > > In workingset_refault(), we call
> > > > mem_cgroup_flush_stats_atomic_ratelimited() to flush stats within a=
n
> > > > RCU read section and with sleeping disallowed. Move the call above
> > > > the RCU read section and allow sleeping to avoid unnecessarily
> > > > performing a lot of work without sleeping.
> > >
> > > Could you say few words why the flushing is done before counters are
> > > updated rather than after (the RCU section)?
> >
> > It's not about the counters that are updated, it's about the counters
> > that we read. Stats readers do a flush first to read accurate stats.
> > We flush before a read, not after an update.
>
> Right you are, my bad I have misread the intention here.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
> --
> Michal Hocko
> SUSE Labs
