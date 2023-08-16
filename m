Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF2B77D786
	for <lists+cgroups@lfdr.de>; Wed, 16 Aug 2023 03:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjHPBO4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Aug 2023 21:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjHPBOo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Aug 2023 21:14:44 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6591984
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 18:14:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso90611cf.1
        for <cgroups@vger.kernel.org>; Tue, 15 Aug 2023 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692148483; x=1692753283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVVaJzAMOPLs4F5EbaziKRc8Rzjn1Gof//6KpkJlzlQ=;
        b=Vyshv/iyYwR/oFEOKc1JYHMUrHXFkWIoQxeD1rRWIN0P1XogOx5MjMYvYkUY6T9etq
         Zyy+W6dszX02xqzVxcGnzkiWibtt560W+RPTXwER5Qmf0ZZx6l3Swf03vaNrgkidKm5V
         Ej/KmVtxqPaC0pd4xGzE58TL6WJ5bPesj0D801i/T+wyBZfYfcBz9gQF8xBvFFT6Vqpb
         uJQox/dXljUPbaHHuiQofbJMHJgJpluHl5tdkpEyPgxbT4CQBHktXf2KCsM0dFTCMBwz
         kn8NICYHPgpjhsrh4cNbGwSHhulF3tQ+l22DrSd/Dz81D2atgZBtsQPqUUYRbZqq3sKU
         di6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148483; x=1692753283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVVaJzAMOPLs4F5EbaziKRc8Rzjn1Gof//6KpkJlzlQ=;
        b=hhG9BKDxJQaLzsBdycqHJP4M97fHKOca7zrDw9z/8CpF567bwi9ZGGiSwHB4j/N6aY
         83nTJJvsnMdWlISvbkk57Z2In8dN4qTlhs4jqRQfZ3rFxaZuqyxge7wpeeFcaUR/ddn4
         9jX6yNsemvpZHqjWwNsAqpnMcAKdMPL8JOABsgzZb+Ic8mf6DPSftKxnj+7zH8UNa3qv
         PZaRS5zwZcXgf1Y3fUe7tHZsN9C46Orsa6HCQadQhGQA4oGQc+MGSRmZh+nibou7a7V8
         7U27uol2SYIT8Or4GOhDK3RaWPhHGYYRhzF7WSsb08jvoMOG2OyqxaFPuAwIRS8ERQu7
         t4lA==
X-Gm-Message-State: AOJu0Yw3Yewvi9d97MoeGBWkYQB/j+D4AidtoJiXnlbb1OoThYxPJfqK
        4BBvh386H4NlXRNYjbqaHdErkHf4RUiAkIty9hMwMQ==
X-Google-Smtp-Source: AGHT+IH8TYko1Bh6ENJiY9cnctcLBXofliPDjplhGZbCyU2pM4y2EIXq+p6ecUUKdPOKf9+5dRJChmOai1+wd5cANig=
X-Received: by 2002:ac8:4e86:0:b0:3f5:2006:50f1 with SMTP id
 6-20020ac84e86000000b003f5200650f1mr130504qtp.12.1692148483063; Tue, 15 Aug
 2023 18:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkYZxjAHrodVDK=wmz-sULJrq2VhC_5ecRP7T-KiaOcTuw@mail.gmail.com>
 <CALvZod46Cz_=5UgiyAKM+VgKyk=KJCqDqXu91=9uHy7-2wk53g@mail.gmail.com>
 <CAJD7tkY-ezyYebvcs=8Z_zrw2UVW8jf2WvP1G8tu2rT=2sMnAA@mail.gmail.com>
 <CALvZod5fH9xu_+6x85K38f63GfKGWD1LqtD2R4d09xmDtLB7ew@mail.gmail.com>
 <ZNdEaw2nktq1NfmH@dhcp22.suse.cz> <CAJD7tkaFHgc3eN1K1wYsQFWMLu4+Frf9DJ-5HOja2nC20Es9Dw@mail.gmail.com>
 <ZNrDWqfjXtAYhnvT@slm.duckdns.org> <CAJD7tkYBFz-gZ2QsHxUMT=t0KNXs66S-zzMPebadHx9zaG0Q3w@mail.gmail.com>
 <ZNrITZVTf2EILRJq@slm.duckdns.org> <CAJD7tkaXwoF-faApweAmm7Db7jAuS3EO7hVvdyVtqW_rE+T9Vg@mail.gmail.com>
 <ZNrLO5PAEZw4yjI9@slm.duckdns.org> <CAJD7tkYgCySTX28zK9GZiWwsabR4nv7M2hQ57y12si-fqtv7zg@mail.gmail.com>
 <CALvZod6KRxiDzrppCgx+=SHg2+96nFE5crwXCKwe9PZbWM_6cQ@mail.gmail.com> <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
In-Reply-To: <CAJD7tkaUzhvZPohpo1F8TUKRPuXH7bjDeg9VCzN2CbywQbRutQ@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 15 Aug 2023 18:14:30 -0700
Message-ID: <CALvZod6HUtYhDaXiwXSrcwfxLSrZ37sZhKY1Mg4kmpDFk13aYw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
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

On Tue, Aug 15, 2023 at 5:29=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> >
> > I thought we already reached the decision on how to proceed here. Let
> > me summarize what I think we should do:
> >
> > 1. Completely remove the sync flush from stat files read from userspace=
.
> > 2. Provide a separate way/interface to explicitly flush stats for
> > users who want more accurate stats and can pay the cost. This is
> > similar to the stat_refresh interface.
> > 3. Keep the 2 sec periodic stats flusher.
>
> I think this solution is suboptimal to be honest, I think we can do bette=
r.
>
> With recent improvements to spinlocks/mutexes, and flushers becoming
> sleepable, I think a better solution would be to remove unified
> flushing and let everyone only flush the subtree they care about. Sync
> flushing becomes much better (unless you're flushing root ofc), and
> concurrent flushing wouldn't cause too many problems (ideally no
> thundering herd, and rstat lock can be dropped at cpu boundaries in
> cgroup_rstat_flush_locked()).
>
> If we do this, stat reads can be much faster as Ivan demonstrated with
> his patch that only flushes the cgroup being read, and we do not
> sacrifice accuracy as we never skip flushing. We also do not need a
> separate interface for explicit refresh.
>
> In all cases, we need to keep the 2 sec periodic flusher. What we need
> to figure out if we remove unified flushing is:
>
> 1. Handling stats_flush_threshold.
> 2. Handling flush_next_time.
>
> Both of these are global now, and will need to be adapted to
> non-unified non-global flushing.

The only thing we are disagreeing on is (1) the complete removal of
sync flush and an explicit flush interface versus (2) keep doing the
sync flush of the subtree.

To me (1) seems more optimal particularly for the server use-case
where a node controller reads stats of root and as well as cgroups of
a couple of top levels (we actually do this internally). Doing flush
once explicitly and then reading the stats for all such cgroups seems
better to me.
