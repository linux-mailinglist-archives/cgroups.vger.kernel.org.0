Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9B77ED38
	for <lists+cgroups@lfdr.de>; Thu, 17 Aug 2023 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343804AbjHPWgO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Aug 2023 18:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346889AbjHPWgG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Aug 2023 18:36:06 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE4173F
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 15:36:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bccc9ec02so982310666b.2
        for <cgroups@vger.kernel.org>; Wed, 16 Aug 2023 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692225363; x=1692830163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQmT7Uh6sWQfVX+jY524yxLYNHKGsl2fBek6097smRE=;
        b=HE9ACyuPPztqNyPxMJQxaWvmISJrT2O9wxlj6I3goqtgzDkkUS1kgXt+rhwzwpNVau
         vgAcjEFeg8oZ2Y7Qn54zx6x10dTczteNXnJCK8dJiC8IdA1AnK98T4udBeNNZDHmCxT8
         TesHS7tlAyWIfqrRXQ5Bq0wKxcgC92lmxlUCOADGVHL1AYWe9PWf+1vxj7oSPUonsg4N
         8bexPQjNfdrbICA/7tpvLEd7RzKCdazkK1XZJ5tw9Iull4sR7NqpzIELjVlqslZvIoz+
         FNMUm9u69u6T8dHHa6ghSukbVowSf6hc6Z+mTkLJdHWWEHWESEj5KRZkM2SrzOr7eUp8
         wLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692225363; x=1692830163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQmT7Uh6sWQfVX+jY524yxLYNHKGsl2fBek6097smRE=;
        b=Z6oJwbRCk9+fDPTQF6bGIur11qoWJG7Bxy55xhMrqvMbYNXAblYXcV5j8udmY+PGuA
         MFv7gS2cvsYEeSqLl39+uU/jlo0YAGzKSWXBoxX8J6LcpmHcYbLxzYtKediWbU/tNC3o
         XYCVV3V4OFr27pIWYKnEkeWmEHWq78qioPb6arzpmx2VoaLT6MtdWSMLXukilS5AW35l
         uzSiC6yxlgRxpyH4aIkn2Y5lFGKIOODgy7pZin11apM1n7alz9mISU622+LMYFRgThTk
         EaRGx7yWAOjZVDj3cWCZ0YxuRUwUnzwmyB8TKJZS4rTymYH9CNHh5y5hwi1jDSloDfEy
         w30A==
X-Gm-Message-State: AOJu0YyQ7pmJ1MYf1RO97nfc1OYXDPDMy0UGwXBSeUVxjLsgOHe76kZS
        VCODqdYatuv8HTnSel0yireKQ2vFmRw+MAOjNmHifw==
X-Google-Smtp-Source: AGHT+IEMFyFOdyFVoQT+XlqGRpULwvmyipNra1bP9KYmfqYJt1udtszGG/fZE+m1+7FS8iRCYv31nvmhnFivxhOxM1w=
X-Received: by 2002:a17:907:78c2:b0:99a:e756:57bf with SMTP id
 kv2-20020a17090778c200b0099ae75657bfmr2349406ejc.7.1692225362689; Wed, 16 Aug
 2023 15:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com>
 <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
 <CALvZod6HUtYhDaXiwXSrcwfxLSrZ37sZhKY1Mg4kmpDFk13aYw@mail.gmail.com>
 <CAJD7tkYzr2cg-aQ899vfqB4jR7iP83t8f-Z4AH8d9iW-yw-nnQ@mail.gmail.com>
 <CALvZod441xBoXzhqLWTZ+xnqDOFkHmvrzspr9NAr+nybqXgS-A@mail.gmail.com> <ZN0eqq4hLRYQPHCI@slm.duckdns.org>
In-Reply-To: <ZN0eqq4hLRYQPHCI@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 16 Aug 2023 15:35:26 -0700
Message-ID: <CAJD7tkYSk-73c1=5vmuRdykAQO=pJSkQFgRqkpdfnh7f-Zufkw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 16, 2023 at 12:08=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Wed, Aug 16, 2023 at 10:11:20AM -0700, Shakeel Butt wrote:
> > These options are not white and black and there can be something in
> > between but let me be very clear on what I don't want and would NACK.
>
> I'm not a big fan of interfaces with hidden states. What you're proposing
> isn't strictly that but it's still a bit nasty. So, if we can get by with=
out
> doing that, that'd be great.

Agreed. I will try to send patches soon implementing option (2) above,
basically removing unified flushing. I will try to document any
potential regressions that may happen and how we may fix them. Ideally
we see no regressions.

>
> > I don't want a global sleepable lock which can be taken by potentially
> > any application running on the system. We have seen similar global
> > locks causing isolation and priority inversion issues in production.
> > So, not another lock which needs to be taken under extreme condition
> > (reading stats under OOM) by a high priority task (node controller)
> > and might be held by a low priority task.
>
> Yeah, this is a real concern. Those priority inversions do occur and can =
be
> serious but causing serious problems under memory pressure usually requir=
es
> involving memory allocations and IOs. Here, it's just all CPU. So, at lea=
st
> in OOM conditions, this shouldn't be in the way (the system wouldn't have
> anything else to do anyway).
>
> It is true that this still can lead to priority through CPU competition t=
ho.
> However, that problem isn't necessarily solved by what you're suggesting
> either unless you want to restrict explicit flushing based on permissions
> which is another can of worms.

Right. Also in the case of a mutex, if we disable preemption while
holding the mutex, this makes sure that whoever holding the mutex does
not starve waiters. Essentially the difference would be that waiters
will sleep with the mutex instead of spinning, but the mutex holder
itself wouldn't sleep.

I will make this a separate patch, just in case it's too
controversial. Switching the spinlock to a mutex should not block
removing unified flushing.

>
> My preference is not exposing this in user interface. This is mostly aris=
ing
> from internal implementation details and isn't what users necessarily car=
e
> about. There are many things we can do on the kernel side to make trade-o=
ffs
> among overhead, staleness and priority inversions. If we make this an
> explicit userland interface behavior, we get locked into that semantics
> which we'll likely regret in some future.
>

Yeah that's what I am trying to do here as well.  I will try to follow
up on this discussion with patches soon.

Thanks everyone!
