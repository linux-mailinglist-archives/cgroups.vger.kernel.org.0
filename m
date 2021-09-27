Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D322E419D3A
	for <lists+cgroups@lfdr.de>; Mon, 27 Sep 2021 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbhI0Rqg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Sep 2021 13:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbhI0Rq2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Sep 2021 13:46:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F323C01C1D0
        for <cgroups@vger.kernel.org>; Mon, 27 Sep 2021 10:28:25 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y35so21140889ede.3
        for <cgroups@vger.kernel.org>; Mon, 27 Sep 2021 10:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GvswBwCE1hBWGNhCX7mBzDB5cCZTD4rBxUPDGl7SjQ4=;
        b=luTsp91hJW5aSmAVu3g2RH1xaosBUC7NSs5ERIXPp2H/bas6zXC4JdXKepZLKG45Lb
         YlcU8EV/oseObIB4+8oP3ysu1nKQ7JEsMvweYCIIk4Y5BJFh5grmwu0VYXHQFxlfsYGx
         mYnBI0xFisC0ks7cUH7BMaEqD8zOUbzpwdbYKzdoxuLTyCusde5i4WOlaEPp0vR1XI5y
         59T453vMTu5KJ5rEqhquFj9PCqd1RN7+oELDkotMOyw1Ij7K3amcCruKl5TV6fq8W9Xk
         LxdTnCbClHRI18ryyR8TkOxVoa+Ypa8Fv+ygLeIsSoTVjioUJaC/dTv6zYICnRw1vh2G
         An5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GvswBwCE1hBWGNhCX7mBzDB5cCZTD4rBxUPDGl7SjQ4=;
        b=eMq5TXjSmUBDxUqalAovauHkT4jmE6UJtyi9hDERppoDszk76HqaEf9BudpWuuIq+k
         xu6DH5q9mu9yOavW7TDNCpynT5O6W1jZLt1YtqqsrSZ0+27DGZAE3uC3mgGNELRcTSHy
         YdQKc9QjxflL1mRNJakq2B12/lCmBn/+OnF7+fuQRT6uAqaTpJChGFXwuiO3EvIrs8QQ
         HJ4qdjqiP8kdW5Q6FzV+pxHkhm59PpLcHZcAq+UTeUkocw38OBnflGGUIBoHEDIr6JGx
         cLf3QtrcyTYUhGqLWx6vYqHh9YM8mNk4H86SCUQmnlfro7WvTcm/L1GXuotacAU1l4fX
         enDw==
X-Gm-Message-State: AOAM530i9TctZpFA4LD6ViPxPOR4rbcdf+XATPzEJ3kDdEeGawUhgfC0
        +qdkDpVNHlelfre+eC1Q1oX6vSIxNi7dTYIO4wM=
X-Google-Smtp-Source: ABdhPJyE5pS2Z5liHh8dmEoUIxz9amCIzT55Zl8dQS4CcfX97HnESTJfKtpUBFWFaH95iDa1rc8OoTEjA+RZNJn/15w=
X-Received: by 2002:a17:907:6297:: with SMTP id nd23mr1445172ejc.62.1632763704099;
 Mon, 27 Sep 2021 10:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAHKqYaa7H=M4E-=ObO0ecj+NE2KwZN5d7QSz4_b6tXz2vOo+VA@mail.gmail.com>
In-Reply-To: <CAHKqYaa7H=M4E-=ObO0ecj+NE2KwZN5d7QSz4_b6tXz2vOo+VA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 27 Sep 2021 10:28:10 -0700
Message-ID: <CAHbLzkpBCQp7UGK_WPJ-akdQ7HqkOEMtE6+9qX5ciu3DU-ZVrg@mail.gmail.com>
Subject: Re: [BUG] The usage of memory cgroup is not consistent with processes
 when using THP
To:     =?UTF-8?B?5Y+w6L+Q5pa5?= <yunfangtai09@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Tejun Heo <tj@kernel.org>,
        vdavydov@parallels.com, Cgroups <cgroups@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 26, 2021 at 12:35 AM =E5=8F=B0=E8=BF=90=E6=96=B9 <yunfangtai09@=
gmail.com> wrote:
>
> Hi folks=EF=BC=8C
> We found that the usage counter of containers with memory cgroup v1 is
> not consistent with the  memory usage of processes when using THP.
>
> It is  introduced in upstream 0a31bc97c80 patch and still exists in
> Linux 5.14.5.
> The root cause is that mem_cgroup_uncharge is moved to the final
> put_page(). When freeing parts of huge pages in THP, the memory usage
> of process is updated  when pte unmapped  and the usage counter of
> memory cgroup is updated when  splitting huge pages in
> deferred_split_scan. This causes the inconsistencies and we could find
> more than 30GB memory difference in our daily usage.

IMHO I don't think this is a bug. The disparity reflects the
difference in how the page life cycle is viewed between process and
cgroup. The usage of process comes from the rss_counter of mm. It
tracks the per-process mapped memory usage. So it is updated once the
page is zapped.

But from the point of cgroup, the page is charged when it is allocated
and uncharged when it is freed. The page may be zapped by one process,
but there might be other users pin the page to prevent it from being
freed. The pin may be very transient or may be indefinite. THP is one
of the pins. It is gone when the THP is split, but the split may
happen a long time after the page is zapped due to deferred split.

>
> It is reproduced with the following program and script.
> The program named "eat_memory_release" allocates every 8 MB memory and
> releases the last 1 MB memory using madvise.
> The script "test_thp.sh" creates a memory cgroup, runs
> "eat_memory_release  500" in it and loops the proceed by 10 times. The
> output shows the changing of memory, which should be about 500M memory
> less in theory.
> The outputs are varying randomly when using THP, while adding  "echo 2
> > /proc/sys/vm/drop_caches" before accounting can avoid this.
>
> Are there any patches to fix it or is it normal by design?
>
> Thanks,
> Yunfang Tai
