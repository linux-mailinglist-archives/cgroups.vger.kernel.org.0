Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE0533CDF1
	for <lists+cgroups@lfdr.de>; Tue, 16 Mar 2021 07:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhCPG2Z (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Mar 2021 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCPG2U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Mar 2021 02:28:20 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C559FC061756
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 23:28:19 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id gb6so10086773pjb.0
        for <cgroups@vger.kernel.org>; Mon, 15 Mar 2021 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4WMa4KM9fFev9zFfsGZL1hiGSj5b5g6V/60hVlEG9mE=;
        b=kAcbsz0zpfOoY1eq9SS2Tf5iLTvNd1+VONP1B0IXfqyjIamQ/j4B1AZIk/Xej3gtPO
         /BIJKwsMq09EtFF7rSx60NCz32pq4F0iifIm3ZnTszJ8+Cy3SC2zDrosJPDUfBgiRw8J
         WpHLksEvtnHLRgydskPl8+p21gRkN5lpSngr9qTO7Q67KinGKssJ587CCWB7ML6nMOgG
         WWUtoUx5a3pcObz5xEiO2hZ+De9kS5PVLrzFUU+crJuLFukr7fwGJFKRLugYMJrfpR1W
         hsEyw9ft7EZKEfo/EfK5YzaCP8Ub44Y9wBc5bjBOgUkNshjVw2aRLRBYfanaGFjrEYd7
         4B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4WMa4KM9fFev9zFfsGZL1hiGSj5b5g6V/60hVlEG9mE=;
        b=ZoGRGsYttMKLbjfYRSFR4YzOQsFwuGRkXAkKo5pxPvavIPCQZMDlfiJtIzGZFMMkzS
         dRCuxwPGU2Zv/2d+Hsra4GhZWR46gMFLnPJDyfl62aYXWoHZdlIi7dKdHueuRFoge3Gm
         n51IZO4r4tA6eNXWXQFL4eOFw7Srt/3sUw4mdk17R0aqhDV0twTvxMeyJpysV6x4ARsI
         yeW2cZ3a7IrOVha3guFK8l/iuQLEClywiK3h1YwNcc2rv8EXsyzALsr6yhRUJIY1nuxe
         Am2mMrPOkCYB9BSjjIfiUmVboaT/UG8LRWruXM3ojhCjdhxNw52NSJ1XdbWzEot3jnpR
         oGJg==
X-Gm-Message-State: AOAM532I9e9W2ZwSXU3AZgXBaoBhYQ1YUFD8mcK8VFq6KyAIJbaqRRCT
        2YjE4hxMrSTPIv8+03zelvA/nxhQuzQpDjLaIRXdsw==
X-Google-Smtp-Source: ABdhPJyQeEVtil+ykZ9O1pMASi07bihZgTaks/id/aa2GLXNnBC00VJaT6BjOTBO+Z04YQfBs6wAhZp8/sOeI97bcWg=
X-Received: by 2002:a17:90a:ce0d:: with SMTP id f13mr3175085pju.85.1615876099037;
 Mon, 15 Mar 2021 23:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210316041645.144249-1-arjunroy.kdev@gmail.com>
 <CAOFY-A1L8c626HZYSWm6ZKFO9mqBdBszv6obX4-1_LmDBQ6Z4A@mail.gmail.com>
 <CALvZod7hgtdrN_KXD_5JdB2vzJzTc8tVz_5YFN53-xZjpHLLRw@mail.gmail.com> <CAOFY-A0v2BEwRinhPXspjL_3dvyw2kDSyzQgUiJxc+P-3OLP8g@mail.gmail.com>
In-Reply-To: <CAOFY-A0v2BEwRinhPXspjL_3dvyw2kDSyzQgUiJxc+P-3OLP8g@mail.gmail.com>
From:   Arjun Roy <arjunroy@google.com>
Date:   Mon, 15 Mar 2021 23:28:08 -0700
Message-ID: <CAOFY-A2q4otqu=pD60tUiD0GTDZnpcm+zajFp6SRDh4VixbV2Q@mail.gmail.com>
Subject: Re: [mm, net-next v2] mm: net: memcg accounting for TCP rx zerocopy
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Arjun Roy <arjunroy.kdev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 15, 2021 at 11:22 PM Arjun Roy <arjunroy@google.com> wrote:
>
> On Mon, Mar 15, 2021 at 9:29 PM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Mon, Mar 15, 2021 at 9:20 PM Arjun Roy <arjunroy@google.com> wrote:
> > >
> > [...]
> > > >
> > >
> > > Apologies for the spam - looks like I forgot to rebase the first time
> > > I sent this out.
> > >
> > > Actually, on a related note, it's not 100% clear to me whether this
> > > patch (which in its current form, applies to net-next) should instead
> > > be based on the mm branch - but the most recent (clean) checkout of mm
> > > fails to build for me so net-next for now.
> > >
> >
> > It is due to "mm: page-writeback: simplify memcg handling in
> > test_clear_page_writeback()" patch in the mm tree. You would need to
> > reintroduce the lock_page_memcg() which returns the memcg and make
> > __unlock_page_memcg() non-static.
>
> To clarify, Shakeel - the tag "tag: v5.12-rc2-mmots-2021-03-11-21-49"
> fails to build on a clean checkout, without this patch, due to a
> compilation failure in mm/shmem.c, for reference:
> https://pastebin.com/raw/12eSGdGD
> (and that's why I'm basing this patch off of net-next in this email).
>
> -Arjun

Another seeming anomaly - the patch sent out passes
scripts/checkpatch.pl but netdev/checkpatch finds plenty of actionable
fixes here: https://patchwork.kernel.org/project/netdevbpf/patch/20210316041645.144249-1-arjunroy.kdev@gmail.com/

Is netdev using some other automated checker instead of scripts/checkpatch.pl?

-Arjun
