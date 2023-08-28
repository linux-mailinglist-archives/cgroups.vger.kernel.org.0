Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A278B533
	for <lists+cgroups@lfdr.de>; Mon, 28 Aug 2023 18:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjH1QQC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjH1QPq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 12:15:46 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A610112A
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 09:15:42 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5256d74dab9so4586899a12.1
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693239341; x=1693844141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afndblcX2lRDuYfUApnBPqsi2v65E21M+ezFScH4A9I=;
        b=z9hy+WFbV3mqJF5+e6G+9u318/zbHUxgPF7+6+RgQPVzS2F5Y8Bz0h2q8ekbD5EBSf
         3emje4+dmIqG2khkmT56tknzwt2pJK9F5mUEBE1sRZqjj4NoKg1RIMx1tMK/OatzB47d
         myhHtFxWRnoQX7/L26zjMrpg118ISAL9x21YlZJg+AuLaeVErL1X/bQheZkJUhNp+o26
         W0+oN1sA/CLo6UgAX6spklh9+MAMtebMFNvwI0vI801GXMOn1XvB5k/7E0EWQFbAkupP
         0xLP96B2UJ+NjPvLpb1tylYlizIBbIEOFofWuZi6xRkuy1C2JgwPw6fASZILjuvpW2M3
         zaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693239341; x=1693844141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afndblcX2lRDuYfUApnBPqsi2v65E21M+ezFScH4A9I=;
        b=J8H4685U0pBBHW/M8+A7yeoVydWM/0uSSJy3UT1p2x/xk9sRzWGiU+trwVqN1GMy3e
         tq/to+X4uQHreUEDPWfA3Yh3QhrQoFX1hVf2R4PIjB50cTh4pKLxs0E+I5dAlwgS+z0R
         YKlUeYt+iFgRXC/4DV+MQ+hii9CcRdlmD4cwLBiteYiRrx/xLRpRBDyFxzyJ9CVVTaGW
         88H62BHO2e11qUmi6iEAlrzzo09wlr6vB49+L8PZK8adot7nF67KG798HIoGwsQe7xAB
         kk2M16cabHjEUEc53DmAi8VKNKGqu6mIkW6JyoI0wiZV4EMT9dlyuDJB5F6Lb3ib7aGP
         Yejw==
X-Gm-Message-State: AOJu0Yy+Hw2nGLkNjo/yeUixiFUUgZK2E5u7rU0UWhwdxPFzFtYYwpvc
        m5rXshtlLgb4mndEceFV4hd2qT1HtJhaUOedlAXIOg==
X-Google-Smtp-Source: AGHT+IHTrCXkoHR92O+FxDNQrmaptlu1BrNxnDGg+mTPtYzWw8N3OL4JEbvvAvwBdOsk+vHpp15nQIkSs29QnAyLlxA=
X-Received: by 2002:a17:907:7758:b0:9a1:f10d:9751 with SMTP id
 kx24-20020a170907775800b009a1f10d9751mr11005838ejc.23.1693239340768; Mon, 28
 Aug 2023 09:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-4-yosryahmed@google.com>
 <ZOR6eyYfJYlxdMet@dhcp22.suse.cz> <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz> <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
 <CAJD7tkadEtjK_NFwRe8yhUh_Mdx9LCLmCuj5Ty-pqp1rHTb-DA@mail.gmail.com>
 <ZOhSyvDxAyYUJ45i@dhcp22.suse.cz> <CAJD7tkYPyb+2zOKqctQw-vhuwYRg85e6v2Y44xWJofHZ+F+YQw@mail.gmail.com>
 <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
In-Reply-To: <ZOzBgfzlGdrPD4gk@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 28 Aug 2023 09:15:04 -0700
Message-ID: <CAJD7tkakMcaR_6NygEXCt6GF8TOuzYAUQe1im+vu2F3G4jtz=w@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 28, 2023 at 8:47=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> Done my homework and studied the rstat code more (sorry should have done
> that earlier).
>
> On Fri 25-08-23 08:14:54, Yosry Ahmed wrote:
> [...]
> > I guess what I am trying to say is, breaking down that lock is a major
> > surgery that might require re-designing or re-implementing some parts
> > of rstat. I would be extremely happy to be proven wrong. If we can
> > break down that lock then there is no need for unified flushing even
> > for in-kernel contexts, and we can all live happily ever after with
> > cheap(ish) and accurate stats flushing.
>
> Yes, this seems like a big change and also over complicating the whole
> thing. I am not sure this is worth it.
>
> > I really hope we can move forward with the problems at hand (sometimes
> > reads are expensive, sometimes reads are stale), and not block fixing
> > them until we can come up with an alternative to that global lock
> > (unless, of course, there is a simpler way of doing that).
>
> Well, I really have to say that I do not like the notion that reading
> stats is unpredictable. This just makes it really hard to use. If
> the precision is to be sarificed then this should be preferable over
> potentially high global lock contention. We already have that model in
> place of /proc/vmstat (configurable timeout for flusher and a way to
> flush explicitly). I appreciate you would like to have a better
> precision but as you have explored the locking is really hard to get rid
> of here.

Reading the stats *is* unpredictable today. In terms of
accuracy/staleness and cost. Avoiding the flush entirely on the read
path will surely make the cost very stable and cheap, but will make
accuracy even less predictable.

>
> So from my POV I would prefer to avoid flushing from the stats reading
> path and implement force flushing by writing to stat file. If the 2s
> flushing interval is considered to coarse I would be OK to allow setting
> it from userspace. This way this would be more in line with /proc/vmstat
> which seems to be working quite well.
>
> If this is not accaptable or deemed a wrong approach long term then it
> would be good to reonsider the current cgroup_rstat_lock at least.
> Either by turning it into mutex or by dropping the yielding code which
> can severly affect the worst case latency AFAIU.

Honestly I think it's better if we do it the other way around. We make
flushing on the stats reading path non-unified and deterministic. That
model also exists and is used for cpu.stat. If we find a problem with
the locking being held from userspace, we can then remove flushing
from the read path and add interface(s) to configure the periodic
flusher and do a force flush.

I would like to avoid introducing additional interfaces and
configuration knobs unless it's necessary. Also, if we remove the
flush entirely the cost will become really cheap. We will have a hard
time reversing that in the future if we want to change the
implementation.

IOW, moving forward with this change seems much more reversible than
adopting the /proc/vmstat model.

If using a mutex will make things better, we can do that now. It
doesn't introduce performance issues in my testing. My only concern is
someone sleeping or getting preempted while holding the mutex, so I
would prefer disabling preemption while we flush if that doesn't cause
problems.

Thanks!
