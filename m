Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BC2787792
	for <lists+cgroups@lfdr.de>; Thu, 24 Aug 2023 20:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbjHXSQv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Aug 2023 14:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242993AbjHXSQ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Aug 2023 14:16:27 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086321BE9
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:16:25 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bccda76fb1so951551fa.2
        for <cgroups@vger.kernel.org>; Thu, 24 Aug 2023 11:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692900983; x=1693505783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7V339yE8bPMm+KmAAdyGZ6ExwOtcmP76lDiycvZ+QhM=;
        b=P7byTXhX2Ze5Ua+2lm2QhtKtc3P56x6cahDM1celc3QwjF0+Ix+nBD+S1+b0WJDZCI
         6IxZTNq5SGvVmyLTnhZ8Bo1bXlPtpi7L/5qqwTm0JgNJJxJmI8jfnwNCEIB6gnl1srAD
         tNC/V8X0CKXn4FEpmR2LSJeRRvVvKMDXOH9IWAGqEYCCyY9tIALrfOlZHSbRgHOaIqPm
         WeWyljfyHCv8gpRcPCZV5ImGaxPPJyqn8uSXCGLdjtXxtYRmprRbyyI+qBrAvmt8lqmg
         Qwyss28dCn8v2XA2KpRopKuaZuXDNde1+NZ+p6/slJ6Lluyf6LCArRlnwV0XKXMAPKrS
         Pong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692900983; x=1693505783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7V339yE8bPMm+KmAAdyGZ6ExwOtcmP76lDiycvZ+QhM=;
        b=TMYyr9Vbu1QfGCGiRtUq+Cqz6XcVuozSevi2ojgwXlDuQGA+wQK7lWMSwa49u97Mzw
         aI2gSPsVpn8snB17TlIg1lyYP5tVZXqq7cSM6PerhuHfSOAELtwtyuHZKxUCAk+lcK3g
         99ME9+tQJCQ+nDhsxALr/A0OjgcPQ5RYm+fmjzGSi5QVzQ0IvhdPMsJKB07vQPor4fcX
         kCp/fNOEKFS6KzUyzfdbwDBFFuezd/ZiNHm8WPA4FYdh8MHtOU4dR2ZB/pO+5aVJIE96
         C/YWISiONA3uvaPlxovFAPAQIVuw2uDsoe7JJdU2qLnhruiecqINIn5G/oThiwpEHULY
         revA==
X-Gm-Message-State: AOJu0Yy41YL9NvgTEiVGwfPRXJLd+SB6IoLZIEjZMJy4DtGQXOv4YBs6
        KWe7EStJMH5x5BPEwdF9AOipHzlJnQtl7x/Q/blkXw==
X-Google-Smtp-Source: AGHT+IECNuJjCUDHAbVkXcrjqS3Bj6d3JaKHEw0JOGYScAGMdiPhJmizveJJgIi+tQXrkfH46aZeiQvAlOl6fbb4ins=
X-Received: by 2002:a2e:6e0c:0:b0:2b9:ef0a:7d4b with SMTP id
 j12-20020a2e6e0c000000b002b9ef0a7d4bmr12177646ljc.31.1692900982999; Thu, 24
 Aug 2023 11:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230821205458.1764662-1-yosryahmed@google.com>
 <20230821205458.1764662-4-yosryahmed@google.com> <ZOR6eyYfJYlxdMet@dhcp22.suse.cz>
 <CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com>
 <ZOW2PZN8Sgqq6uR2@dhcp22.suse.cz> <CAJD7tka34WjtwBWfkTu8ZCEUkLm7h-AyCXpw=h34n4RZ5qBVwA@mail.gmail.com>
 <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
In-Reply-To: <ZOcDLD/1WaOwWis9@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 24 Aug 2023 11:15:46 -0700
Message-ID: <CAJD7tkZby2enWa8_Js8joHqFx_tHB=aRqHOizaSiXMUjvEei4g@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 24, 2023 at 12:13=E2=80=AFAM Michal Hocko <mhocko@suse.com> wro=
te:
>
> On Wed 23-08-23 07:55:40, Yosry Ahmed wrote:
> > On Wed, Aug 23, 2023 at 12:33=E2=80=AFAM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > On Tue 22-08-23 08:30:05, Yosry Ahmed wrote:
> > > > On Tue, Aug 22, 2023 at 2:06=E2=80=AFAM Michal Hocko <mhocko@suse.c=
om> wrote:
> > > > >
> > > > > On Mon 21-08-23 20:54:58, Yosry Ahmed wrote:
> > > [...]
> > > > So to answer your question, I don't think a random user can really
> > > > affect the system in a significant way by constantly flushing. In
> > > > fact, in the test script (which I am now attaching, in case you're
> > > > interested), there are hundreds of threads that are reading stats o=
f
> > > > different cgroups every 1s, and I don't see any negative effects on
> > > > in-kernel flushers in this case (reclaimers).
> > >
> > > I suspect you have missed my point.
> >
> > I suspect you are right :)
> >
> >
> > > Maybe I am just misunderstanding
> > > the code but it seems to me that the lock dropping inside
> > > cgroup_rstat_flush_locked effectivelly allows unbounded number of
> > > contenders which is really dangerous when it is triggerable from the
> > > userspace. The number of spinners at a moment is always bound by the
> > > number CPUs but depending on timing many potential spinners might be
> > > cond_rescheded and the worst time latency to complete can be really
> > > high. Makes more sense?
> >
> > I think I understand better now. So basically because we might drop
> > the lock and resched, there can be nr_cpus spinners + other spinners
> > that are currently scheduled away, so these will need to wait to be
> > scheduled and then start spinning on the lock. This may happen for one
> > reader multiple times during its read, which is what can cause a high
> > worst case latency.
> >
> > I hope I understood you correctly this time. Did I?
>
> Yes. I would just add that this could also influence the worst case
> latency for a different reader - so an adversary user can stall others.

I can add that for v2 to the commit log, thanks.

> Exposing a shared global lock in uncontrolable way over generally
> available user interface is not really a great idea IMHO.

I think that's how it was always meant to be when it was designed. The
global rstat lock has always existed and was always available to
userspace readers. The memory controller took a different path at some
point with unified flushing, but that was mainly because of high
concurrency from in-kernel flushers, not because userspace readers
caused a problem. Outside of memcg, the core cgroup code has always
exercised this global lock when reading cpu.stat since rstat's
introduction. I assume there hasn't been any problems since it's still
there. I was hoping Tejun would confirm/deny this.
