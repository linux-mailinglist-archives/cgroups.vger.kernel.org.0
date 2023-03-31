Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1746D28A2
	for <lists+cgroups@lfdr.de>; Fri, 31 Mar 2023 21:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCaT0a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Mar 2023 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjCaT02 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Mar 2023 15:26:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F520D92
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 12:26:27 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id h8so93804076ede.8
        for <cgroups@vger.kernel.org>; Fri, 31 Mar 2023 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680290786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iu7s9DYyfZiIezMIZDBeMPsNtoiOPCl5mln2vnX6FPU=;
        b=Jh1exDm2YeiM89cAzqqWvMxVLriZxCQArLnH4Mf6OVhEcGsrWa67g4r4iY9GxBqbL4
         OwiVm/ocExjWSMEDP9eTxqD46U6I3d7SVjjjUi82zkGcqJI5cy9NeZDc2aVMrm+tu9D4
         2ihR1w8LzwPVi8V2GpLFeCJCC1+5Wib5Jjnd3W7a3/qpPLT61HDDmpxc1WBzkXj7GdjS
         c1V7ynE2tVtUYK2imikTkrZvZSfAfE1k58a/h1So+lVWALmAznug58niAX2/RU1yHRnX
         6j8J+n3+dwdR/5N3u5VPOS2w5wXbjINi/VhPfdgtNb3Syg0XszV+79drAnURLA3puqU3
         ithQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iu7s9DYyfZiIezMIZDBeMPsNtoiOPCl5mln2vnX6FPU=;
        b=uBRetyIw6gAVr2GkZSlTjo7IIzBUbWCKNSuIIplZasNUZuos9KMnUKhNJ+PGo7MUFX
         /bBdbx/imWdkC+4GSJPUnN2KlGPJjOQDu+9i9gfCkCqFnwU0EGWXJHuqVsqUekSprhsg
         +F53zHhLkko39BEFjd/XkqYZfs/k9k/WRvkJCqNUbEeYfSnzPXH/FZbvYWdGiXHs+IwT
         TQr7MtTBFg5pko2dCWQdSGxijmSafDksgHMUAapVHd/F5ZDHG9uJKYnieL8hSYak5CHe
         LVMUGNgd4JsRYcIFfvZ8ffKEyDxquYHwfmirA0hA7rEPlNS7zfZxpaj5yqk8OQJfRzOB
         CYvg==
X-Gm-Message-State: AAQBX9eaYHj2ziG0OYHVDa6iU3fFUJDJSGdbMrn6Bc70+cDSQh+jPBAN
        fsWxYTO9J6n66nfjlp7UMxYxR0UBlnWpFW0ggqXXDeipuUgYJCDx6/RN9w==
X-Google-Smtp-Source: AKy350ZZEcKgHsHr/ECELw8BJ/h68MCP5nK4LN8Aq5fROKV7DPp8rn3vM61laMTH1JyPBhMidoe2xvyT7fEFemHrGiY=
X-Received: by 2002:a50:8e0d:0:b0:4fc:473d:3308 with SMTP id
 13-20020a508e0d000000b004fc473d3308mr14071517edw.8.1680290785726; Fri, 31 Mar
 2023 12:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAEeXeQLTQjt6O4C-_3dE63gPEgXU9qtdM2+XDxYemV9bsfq_pg@mail.gmail.com>
In-Reply-To: <CAEeXeQLTQjt6O4C-_3dE63gPEgXU9qtdM2+XDxYemV9bsfq_pg@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Fri, 31 Mar 2023 12:25:49 -0700
Message-ID: <CAJD7tkZ+ZkQX01MHDGd0mT7=qt82VfJ_AAXA2xy1w35Drws-0g@mail.gmail.com>
Subject: Re: freezer cgroups: Forcing frozen memory to swap
To:     Tyler Rider <tylerjrider@gmail.com>
Cc:     cgroups@vger.kernel.org
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

On Fri, Mar 31, 2023 at 11:49=E2=80=AFAM Tyler Rider <tylerjrider@gmail.com=
> wrote:
>
> Hi all,
>
> I've been trying to search for some mechanism(s) to reclaim resident
> memory of some frozen applications on a small embedded device. The
> typical use case is to bring up an app and once backgrounded/dismissed
> the idea is to freeze/thaw for faster resume/restart times.
>
> The issue is that after starting/pausing several of these applications
> (and subsequently freezing) memory begins dropping, and memory
> thrashing begins. (I can stop the apps of course, but then that leads
> to longer load times).
>
> I've already got memory constraint issues, which led to adding a swap
> partition. I've tried bumping the memory.swapiness to 100 within a
> memory cgroup, and waiting a few seconds for kswapd to kick in before
> freezing but since the app is running it only puts a handful of pages
> into swap.
>
> Some projects exist (crypopid(2) / CRIU) for dumping the process state
> in userspace, but unless I'm missing something, I'd imagine there must
> be some existing kernel mechanism (seems like a useful feature for
> small memory constrained devices) within the freezer/memory cgroups
> that can force all pages of the frozen process to a swap partition,
> and restore on thaw.
>
> Does this sort of  cgroup-level S4 (hibernate-to-disk) exist or even
> just a mechanism to force a frozen process's pages to swap?

In memory cgroups there is a memory.reclaim interface, where you can
request the kernel to reclaim X amount of memory from the cgroup. A
few things to keep in mind:

* This is per-cgroup, not per-process.

* This is irrelevant to freezing.

* This will try to reclaim all types of memory, not just swapbacked
(anon & tmpfs memory). So it may writeback file pages charged to the
cgroup, or shrink slabs.

* I am not aware of a mechanism to fault back in all the memory mapped
by processes in a cgroup to restore the pages. Perhaps you can use
MADV to do this per-process, or just let processes fault their memory
back in on-demand.

>
> Thanks,
> Tyler
