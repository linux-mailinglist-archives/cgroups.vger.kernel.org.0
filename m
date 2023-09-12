Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD6C79CF88
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 13:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjILLLx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Sep 2023 07:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234666AbjILLLL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Sep 2023 07:11:11 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3332723
        for <cgroups@vger.kernel.org>; Tue, 12 Sep 2023 04:10:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a21b6d105cso698499566b.3
        for <cgroups@vger.kernel.org>; Tue, 12 Sep 2023 04:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694517007; x=1695121807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Sq0fA/VatZ++ayfpGlQL3susC/RviepPCleB3baLTw=;
        b=ibueTLkYyDcakKnfmNNANAP0ZaZtuoHKt8ZiLX4Me5YTXK4m40JAcqFjJH463s68gA
         BCzfDROkDsS8eC4dlXWZ6nMWOJH12ce/HKdjFOmBD2wBBnHH11x9rNDPvb2ZfHfEqC+r
         4xgJML+gnriCrUO2Lb05RoDLr7IISXXtjM2NCh02a1hMd8zO6Pff0hR3XwylXCh3VAZJ
         F9+m07hsjzGA3YSAPQaTn4ZH/uXbhNGFO4fn0fDjlGqpRsMKCLwOmAeXvIThiBR94yJz
         zPRx3x8EjVpr+Cxj9xWR50hXpdArrUp0Ur0Dq1tNUbzCtPYzck+m2C1fd1v62U+LInqW
         cOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694517007; x=1695121807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sq0fA/VatZ++ayfpGlQL3susC/RviepPCleB3baLTw=;
        b=D+g/vcE2Oj+xObOzL7FDqA/rm6yC1byhXXMQCckdMNcslk6bX7OzMpXFVAUChC/Lfo
         /XWBA3xbSqMZwB79vnnRJqiBaUYAR0NNHUrRzjWSB+PW1u+g4mZ7szISNGax/akalHFs
         JDS6bzmfsrC/cEc+M2KbkObCamX+ijxZB6Sizn5cF00QF9lGw2A9XROm+bUQh1/4RFpP
         mYs5KRGVbxLmWUM/a6MRyIE5jzkfm7PiKmPiwl/FUdN/OXHU9AWbaIHAY2hyAcUffZNb
         8LzprF3bRJs1EwSjflKqz8qSLxDamQCAg7MjZG9Yti6xnIgPnAR4OLrdNXe3lefwodCf
         pUdQ==
X-Gm-Message-State: AOJu0YwrwGEkGJHtuSKSa08Rq5pIo+0uyxr62R7nq+ywat7jJU1mvZ32
        YvVP0FWUr/ho4gy9vlATzd/WhaqlUzUSB31S06d12Q==
X-Google-Smtp-Source: AGHT+IEqf692PpcwWJ+KIdN9fRGhrkF5AMtPRxevzTGnCQ4lbfLrNNYioDArel+eLcA3y9SeK6u55VX/HEgsrXww4s0=
X-Received: by 2002:a17:906:10dc:b0:99c:f47a:2354 with SMTP id
 v28-20020a17090610dc00b0099cf47a2354mr12544637ejv.70.1694517007270; Tue, 12
 Sep 2023 04:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-5-yosryahmed@google.com> <ZPX0kCKd4TaVLJY7@dhcp22.suse.cz>
 <CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com>
 <ZP8SDdjut9VEVpps@dhcp22.suse.cz> <CAAPL-u8NndkB2zHRtF8pVBSTsz854YmUbx62G7bpw6BMJiLaiQ@mail.gmail.com>
 <ZP9rtiRwRv2bQvde@dhcp22.suse.cz> <CAAPL-u9XwMcrqVRu871tGNKa3LKmJSy9pZQ7A98uDbG6ACzMxQ@mail.gmail.com>
 <ZP92xP5rdKdeps7Z@mtj.duckdns.org> <ZQBFZMRL8WmqRgrM@dhcp22.suse.cz>
In-Reply-To: <ZQBFZMRL8WmqRgrM@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 12 Sep 2023 04:09:28 -0700
Message-ID: <CAJD7tka4zEcu-jMycMo0=xB7PP1j7P0gu_weGJSLQvbhYMzv9Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
To:     Michal Hocko <mhocko@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Wei Xu <weixugc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 12, 2023 at 4:03=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Mon 11-09-23 10:21:24, Tejun Heo wrote:
> > Hello,
> >
> > On Mon, Sep 11, 2023 at 01:01:25PM -0700, Wei Xu wrote:
> > > Yes, it is the same test (10K contending readers). The kernel change
> > > is to remove stats_user_flush_mutex from mem_cgroup_user_flush_stats(=
)
> > > so that the concurrent mem_cgroup_user_flush_stats() requests directl=
y
> > > contend on cgroup_rstat_lock in cgroup_rstat_flush().
> >
> > I don't think it'd be a good idea to twist rstat and other kernel inter=
nal
> > code to accommodate 10k parallel readers.
>
> I didn't mean to suggest optimizing for this specific scenario. I was
> mostly curious whether the pathological case of unbound high latency due
> to lock dropping is easy to trigger by huge number of readers. It seems
> it is not and the mutex might not be really needed as a prevention.
>
> > If we want to support that, let's
> > explicitly support that by implementing better batching in the read pat=
h.
>
> Well, we need to be able to handle those situations because stat files
> are generally readable and we do not want unrelated workloads to
> influence each other heavily through this path.

I am working on a complete rework of this series based on the feedback
I got from Wei and the discussions here. I think I have something
simpler and more generic, and doesn't proliferate the number of
flushing variants we have. I am running some tests right now and will
share it as soon as I can.

It should address the high concurrency use case without adding a lot
of complexity. It basically involves a fast path where we only flush
the needed subtree if there's no contention, and a slow path where we
coalesce all flushing requests, and everyone just waits for a single
flush to complete (without spinning or contending on any locks). I am
trying to use this generic mechanism for both userspace reads and
in-kernel flushers. I am making sure in-kernel flushers do not
regress.

>
> [...]
>
> > When you have that many concurrent readers, most of them won't need to
> > actually flush.
>
> Agreed!
> --
> Michal Hocko
> SUSE Labs
