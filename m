Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE51763A97
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 17:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbjGZPOZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 11:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbjGZPNm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 11:13:42 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A62D56
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:13:18 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-63d170a649eso12867716d6.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1690384396; x=1690989196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cOppSR5vSHMc40APmcMzvAsvziT5KwEmkPNskmCaQgY=;
        b=razagjx5BCylQt5gjh9JrWZm0vXpRLG/piHYhTLKRLsw9zcpX1u5k0Vs+hrO22eo3e
         SfkcFjXF8k7a6zX2GsTDxVI2P7C+p9cdeVVWqBacemwDslPEmqfniR9mE8nddDPpabCq
         6dpDA4eXbXF/C7KRKLKH9oiVBg422CJtTD+CuvLV8xPXFpUPKo+R5iLBGqZvb3s/Lcgh
         hcK6qEOL48zST1lv9PuFKcWCke1qdlDDBpP5Om1APf4OhVh7DuHGAn6rqniiipNv2AJS
         PvL182LpjVrdjNiaGRVqcfKAt3ZgIZ/o2SV1UV7SVi8513mRcui/7i7sk96Jke6mFDC+
         XSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690384396; x=1690989196;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOppSR5vSHMc40APmcMzvAsvziT5KwEmkPNskmCaQgY=;
        b=P+M04DqRpZ//Bad55iI9MPTAY0Y2hspE/lDxcSlmehloqWEhj5efB/DauCFo7UOAb0
         +2aS+Lf63oS3KnAQtnsa2CXC3q4kOGDPd08y2jaE2HAX/Fpd1HA1PiBLTzvd1hmT94Da
         GmzaDhtYHJKHLb8IQscBSHbbjznMH954luaVkaX0wXdlVtqrNTUyHJVcH1IzHkTRsn/Y
         M6s/PW9LCF83C92quhI1jiL8riF0yKU4zGRmyNBqnQLX7GyjiXANKsurTHUOjGXEo5LS
         N7xXukk9WtIMJKyiqpPYCW4mOclTliR/YOtWUziUxnrBbYqqWSAAXnEqVAa2e9lNbRFN
         9MEg==
X-Gm-Message-State: ABy/qLbd2Da6OFTzKq0sEil4EeCmvwLjiuP42iV6UJgHePFKwQMWP2/3
        4brLbAPM5LdfVZKdvuU3m3Vgjg==
X-Google-Smtp-Source: APBJJlFecabGZMkHefQhOYETrzqZggXS46ZDMFNpHahsxsOZeHwJwD3Wm+TOSeeugGs4BmH72plYFQ==
X-Received: by 2002:a0c:aa99:0:b0:623:690c:3cd7 with SMTP id f25-20020a0caa99000000b00623690c3cd7mr2342136qvb.47.1690384396635;
        Wed, 26 Jul 2023 08:13:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ad06])
        by smtp.gmail.com with ESMTPSA id a26-20020a0c8bda000000b006238b37fb05sm283391qvc.119.2023.07.26.08.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:13:16 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:13:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
Message-ID: <20230726151315.GB1365610@cmpxchg.org>
References: <20230726002904.655377-1-yosryahmed@google.com>
 <20230726002904.655377-2-yosryahmed@google.com>
 <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZK2T2ebOPw6K0M+YWyKUtx9bE2uyFj4VOehhd+fYnk8w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 25, 2023 at 05:36:45PM -0700, Yosry Ahmed wrote:
> On Tue, Jul 25, 2023 at 5:29 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > - Fix a subtle bug where updating a local counter would be missed if it
> >   was cancelled out by a pending update from child memcgs.
> 
> 
> Johannes, I fixed a subtle bug here and I kept your Ack, I wasn't sure
> what the Ack retention policy should be here. A quick look at the fix
> would be great.

Ah, I found it:

> > @@ -5542,19 +5539,23 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> >                         memcg->vmstats->state_pending[i] = 0;
> >
> >                 /* Add CPU changes on this level since the last flush */
> > +               delta_cpu = 0;
> >                 v = READ_ONCE(statc->state[i]);
> >                 if (v != statc->state_prev[i]) {
> > -                       delta += v - statc->state_prev[i];
> > +                       delta_cpu = v - statc->state_prev[i];
> > +                       delta += delta_cpu;
> >                         statc->state_prev[i] = v;
> >                 }
> >
> > -               if (!delta)
> > -                       continue;
> > -
> >                 /* Aggregate counts on this level and propagate upwards */
> > -               memcg->vmstats->state[i] += delta;
> > -               if (parent)
> > -                       parent->vmstats->state_pending[i] += delta;
> > +               if (delta_cpu)
> > +                       memcg->vmstats->state_local[i] += delta_cpu;

When delta nulls out, but delta_cpu is non-zero... subtle.

This fixed version looks good, please keep my ack :)
