Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29F2433C07F
	for <lists+cgroups@lfdr.de>; Mon, 15 Mar 2021 16:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhCOPsx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Mar 2021 11:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhCOPsj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Mar 2021 11:48:39 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD65C06174A
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:48:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x4so50895863lfu.7
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMQX9cSTk4pNl9nGi7mtI/mLokkbjIxGL748SGLyk7Q=;
        b=cyJf+6PyxCCi1Oz5oXDGFThBCrClPxSRsk4OIhR45gZ2yQRY5505jv96pHlPM/tocl
         KPKqQJb+vUy978TiwjWk3UPiulBwwPx58fsQNlVOJKblEvN6u9pCGreAPcktDGh2C2sU
         wKzfAotaFmv1XxCu51PCvql11jzjj2Y0SJbTz4hPCZ1lalDud8yTldxQLM1kbOMh/Uu9
         OPSJwhyq4omWbP7uT8st4DL9pnnbZvr2MwMEuww9YQ9xUKiNW/TZiPls4Ry2k2BsVM7m
         dkK3DT0CwEdJred10Dzs6Bvjx0UWVLhcsglbl/5f/1omrcFR/v8hb89/8egTNRWofpJo
         k3Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMQX9cSTk4pNl9nGi7mtI/mLokkbjIxGL748SGLyk7Q=;
        b=N/VE16EuZ7em04pIB3nJ8L/ynp+24mNLIUeSuEhQD0Ovi4lk1uQTC+gdXhfgfRsunY
         CyMk43O7mM7faUdfPhf8/RKWRyAKEnuepO0vnKPQMKEMC5pEM4XDEJaryH4KwisQx6Kb
         Zoxd3+7Gju1u6pqzKXCD2a7BYpOZKE7kRQlqk+Gb9XerF+s5ZX1Dm8nFT6mTdCEDyXKq
         VlS3vbV5BS3vptbt6VgufodWA2vHDchmNr052ifmbBEXqksX6sF96jy9JLw6wJYyCNML
         s/4J+4HlTZXEo22YDNZnzHYvdl8BnDeRGIOo5oFGCzy8FFc8bNqAZa6U26A6GlK1zAyX
         W/tQ==
X-Gm-Message-State: AOAM531T2PvN8IPn7px2QnfEnTMVS11r0evHKRYed5DsOYCHUARs6tdV
        kZtDAsO4w6nXQ8/pYyM8wBgt2JRHw7TUvtvCJkQf1fWC/ic=
X-Google-Smtp-Source: ABdhPJyBvJJTNobhkMcsNMWUHz0l/kEKAnfXiE9uvivfXxfu7wuG5j+kXwwsAwReel/C9A8uvf+UI1u7FpmvwIK4xzI=
X-Received: by 2002:a19:e0d:: with SMTP id 13mr8300885lfo.549.1615823317678;
 Mon, 15 Mar 2021 08:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <YEnWUrYOArju66ym@dhcp22.suse.cz> <360b4c94-8713-f621-1049-6bc0865c1867@virtuozzo.com>
 <20210315132740.GB20497@zn.tnic>
In-Reply-To: <20210315132740.GB20497@zn.tnic>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Mar 2021 08:48:26 -0700
Message-ID: <CALvZod7aT7t_Yp67CaECbCSzk8CuqBRMUBccthLCpz4osqDLKw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] memcg: accounting for ldt_struct objects
To:     Borislav Petkov <bp@alien8.de>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 6:27 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Mar 15, 2021 at 03:24:01PM +0300, Vasily Averin wrote:
> > Unprivileged user inside memcg-limited container can create
> > non-accounted multi-page per-thread kernel objects for LDT
>
> I have hard time parsing this commit message.
>
> And I'm CCed only on patch 8 of what looks like a patchset.
>
> And that patchset is not on lkml so I can't find the rest to read about
> it, perhaps linux-mm.
>
> /me goes and finds it on lore
>
> I can see some bits and pieces, this, for example:
>
> https://lore.kernel.org/linux-mm/05c448c7-d992-8d80-b423-b80bf5446d7c@virtuozzo.com/
>
>  ( Btw, that version has your SOB and this patch doesn't even have a
>    Signed-off-by. Next time, run your whole set through checkpatch please
>    before sending. )
>
> Now, this URL above talks about OOM, ok, that gets me close to the "why"
> this patch.
>
> From a quick look at the ldt.c code, we allow a single LDT struct per
> mm. Manpage says so too:
>
> DESCRIPTION
>        modify_ldt()  reads  or  writes  the local descriptor table (LDT) for a process.
>        The LDT is an array of segment descriptors that can be referenced by user  code.
>        Linux  allows  processes  to configure a per-process (actually per-mm) LDT.
>
> We allow
>
> /* Maximum number of LDT entries supported. */
> #define LDT_ENTRIES     8192
>
> so there's an upper limit per mm.
>
> Now, please explain what is this accounting for?
>

Let me try to provide the reasoning at least from my perspective.
There are legitimate workloads with hundreds of processes and there
can be hundreds of workloads running on large machines. The
unaccounted memory can cause isolation issues between the workloads
particularly on highly utilized machines.
