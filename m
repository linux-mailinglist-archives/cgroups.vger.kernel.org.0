Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075D868CA9A
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 00:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBFXfx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Feb 2023 18:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFXff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 Feb 2023 18:35:35 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3AD12594
        for <cgroups@vger.kernel.org>; Mon,  6 Feb 2023 15:35:33 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p26so38778954ejx.13
        for <cgroups@vger.kernel.org>; Mon, 06 Feb 2023 15:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PebMER0tSx+oPRhl8r2nT8XfQ1hRr+Ea9P0OXUFJBO8=;
        b=gFiziMfcVl6htohZH8DlPgIj6VdnPBkJp7qScsRATWcBx+1yfn1eAcW9er4AEysOHd
         Xk1Adh1uLwfzboDoZyy3rPGdgXK+RZHyUZ32Ow5GPWlnotZgFwNf1tE4/4f/arM8LZvP
         yRZfnNWC1I694JkleoUgTzrH7QHU0TylPU2krrvGosY2416XSugbuQreh9EzSAQTYxB4
         yAJqZnsDw6WYSXo5hhQBYATmHo6hejbhN1bS6ugPVDTMd1by080RDRh/gUqPTjxRmpwi
         RhJh2zzvqilmf0h2+wraGV49VV+k5Ba5MqNATmTZSGODba5KRZCV1Y7AidKhmrOhn9F8
         pmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PebMER0tSx+oPRhl8r2nT8XfQ1hRr+Ea9P0OXUFJBO8=;
        b=pSn0dOBmMZYzUR02JtOrCrAt/daSizmJJP6CqN01dlWu/7dVK0MmZ/tYcUMPwu0iS1
         eYm03Wl5oq3Ud/HhjJzqf2upmhrMs8/sR3VpJKCpMhb/w52dMKXvjwOHAGWHkhdMY/yS
         EXvXIXyd6N2iKid9GOyVbYs0IkqdNOzCATimoIAQv3iscmGiRFb/IQAIU2AYZbEzn6Qf
         /5WUcpv38V9rRwtIEpGacQUQIt8DvyLHa3p7UFhL9zQQZ8U6+5DZLK9CuTONsEIWJrpk
         114SVDwksz4LY2ZIunTmI68ueLmkWKm2ixxeZ8DBMIgCCfKHAen+C67Vi33HLlzP6YEy
         NOkg==
X-Gm-Message-State: AO0yUKVUUJtSf0rxkII7hNHMDrHfUW+6nFTef3qZWVRoLam7QAFC54ES
        Oz/cYAHTfL74GHS30CNZBYsPH8FNdRrva+jaMNqMvA==
X-Google-Smtp-Source: AK7set/LwhzSakQ5P7peQYkQ92BhJVbq00+VQIWbfGe8HACHEPOt/Vfx9S1nCqBe+Ki8mU/16uRn7J/nzy5p/F4cQFg=
X-Received: by 2002:a17:906:37c2:b0:878:7bc7:958a with SMTP id
 o2-20020a17090637c200b008787bc7958amr320380ejc.220.1675726532194; Mon, 06 Feb
 2023 15:35:32 -0800 (PST)
MIME-Version: 1.0
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
 <c7b5e502d1a3b9b8f6e96cbf9ca553b143c327e0.1675669136.git-series.apopple@nvidia.com>
 <Y+Fttp1ozejoSQzl@slm.duckdns.org> <CAJD7tkb_Cr7rTTpKc1VBpS8h=n3Hu+nGiV8dkLH-NdC1bSG9mg@mail.gmail.com>
 <Y+GA6Y7SVhAW5Xm9@slm.duckdns.org> <CAJD7tka6SC1ho-dffV0bK_acoZd-5DQzBOy0xg3TkOFG1zAPMg@mail.gmail.com>
 <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
In-Reply-To: <Y+GMbWWP/YhtJQqe@slm.duckdns.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Feb 2023 15:34:55 -0800
Message-ID: <CAJD7tkYP_4PbrLumDYaTHN2vh8BmLcmy_hWFDbWeA0p58xmYEw@mail.gmail.com>
Subject: Re: [PATCH 14/19] mm: Introduce a cgroup for pinned memory
To:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@nvidia.com, jhubbard@nvidia.com, tjmercier@google.com,
        hannes@cmpxchg.org, surenb@google.com, mkoutny@suse.com,
        daniel@ffwll.ch, "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Feb 6, 2023 at 3:25 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Feb 06, 2023 at 02:39:17PM -0800, Yosry Ahmed wrote:
> > On Mon, Feb 6, 2023 at 2:36 PM Tejun Heo <tj@kernel.org> wrote:
> > >
> > > On Mon, Feb 06, 2023 at 02:32:10PM -0800, Yosry Ahmed wrote:
> > > > I guess it boils down to which we want:
> > > > (a) Limit the amount of memory processes in a cgroup can be pinned/locked.
> > > > (b) Limit the amount of memory charged to a cgroup that can be pinned/locked.
> > > >
> > > > The proposal is doing (a), I suppose if this was part of memcg it
> > > > would be (b), right?
> > > >
> > > > I am not saying it should be one or the other, I am just making sure
> > > > my understanding is clear.
> > >
> > > I don't quite understand what the distinction would mean in practice. It's
> > > just odd to put locked memory in a separate controller from interface POV.
> >
> > Assume we have 2 cgroups, A and B. A process in cgroup A creates a
> > tmpfs file and writes to it, so the memory is now charged to cgroup A.
> > Now imagine a process in cgroup B tries to lock this memory.
> > - With (a) the amount of locked memory will count toward's cgroup A's
> > limit, because cgroup A is charged for the memory.
> > - With (b) the amount of locked memory will count toward's cgroup B's
> > limit, because a process in cgroup B is locking the memory.
> >
> > I agree that it is confusing from an interface POV.
>
> Oh yeah, that's confusing. I'd go with (a) for consistency with the rest of
> memcg - locked memory should fit inside e.g. memory.max. The problem with
> shared memory accounting exists for non-locked memory as well and prolly
> best to handle the same way rather than handling differently.

+Michal Hocko +Roman Gushchin +Shakeel Butt for visibility with memcg.

>
> Thanks.
>
> --
> tejun
