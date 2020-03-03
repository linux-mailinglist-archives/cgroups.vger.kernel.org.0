Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A31786AA
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 00:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCCXty (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Mar 2020 18:49:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39964 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgCCXty (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Mar 2020 18:49:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id x19so227450otp.7
        for <cgroups@vger.kernel.org>; Tue, 03 Mar 2020 15:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpXe9qW1IE+W6FbdZ2WrOfJnBA8frqrFQCxhnKyXLE4=;
        b=bB6r52TIAf9ibs8y+NORyBaaxS8dDSOoFewL5V+z/CPv0VD4b2OXTG6GjdIJmrw58z
         cwXa6SOKYzcoE6dWgm+bCSol1ivF2L9qVLVRz3mKzFvrJAPRf4PWTkXNXW/is292Zn74
         J55/rf2DmiKqvpVC6Odc7IREGf3IQi86Z6kTQ7sARuwR+Lvq65kG2x/EoNvUplkvFTO8
         bSq3pb01X7RoInfsU5ZI55las/N8rTcK8Glm07jN+KgrytBr1AfviEAZU3goLEalPW+n
         doZIGwWim8QgvhWhdUTNejU9cr0K+fD99+36FFBaMy74hYx5hyy0UMccTYHE1fqqH6cy
         gT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpXe9qW1IE+W6FbdZ2WrOfJnBA8frqrFQCxhnKyXLE4=;
        b=N34VuewEi9eVrg5uzJsigqqll5O1x5aym6x38kTixsNGuA7kGw6Wzmm7zWy7vKWJxn
         YB44VJOxsK0iNKKtOzS01mYSFJh7b7u1Sl3hGU1fU/9mpe8wwahlhohykYEmAIawItEb
         xQ0M55gCN2RgGKbRGa9EpktuLZCzEMuFLy5UZYjJ+sBeu1V/dGxPhU4qzqxdzmh/A4R6
         +pQ8u0AMXzPYBfLIjszAwrXDZR4RmwvuVqSxZiaeK21gKxofWbgBHbYi42JdUw3BD/dj
         6Xj2hrGZCKEd94YyEtldKOnWoLHxkAKhqj4DHyy5KEn3/t8d9kkfDnU28QXN5by+Yq7B
         5C8A==
X-Gm-Message-State: ANhLgQ3mfbqpw8zVTbQsUG1tAge1nTqR6hb9GmP0ieBQsR2n074tHUUS
        jXR5DELZxT/rJ2nnm3GzneqUdkkmXNHlz7xDhDwd6Q==
X-Google-Smtp-Source: ADFU+vu5NG+LHZgFGYQ4CEDf0TzVyEVrAmHZbBF/cGdeYsoE/2mnZSmIsLY7rEqxxdjQqEx7kSxEZ5YVlstsYogMaFY=
X-Received: by 2002:a9d:664d:: with SMTP id q13mr329754otm.30.1583279393250;
 Tue, 03 Mar 2020 15:49:53 -0800 (PST)
MIME-Version: 1.0
References: <20200302203109.179417-1-shakeelb@google.com> <20200303093251.GD4380@dhcp22.suse.cz>
In-Reply-To: <20200303093251.GD4380@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 3 Mar 2020 15:49:41 -0800
Message-ID: <CALvZod7C9nrS4S36AfTY74cx0=58LXNNh_b+mXzXNG1j9_6RZg@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: css_tryget_online cleanups
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Mar 3, 2020 at 1:32 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 02-03-20 12:31:09, Shakeel Butt wrote:
> > Currently multiple locations in memcg code, css_tryget_online() is being
> > used. However it doesn't matter whether the cgroup is online for the
> > callers. Online used to matter when we had reparenting on offlining and
> > we needed a way to prevent new ones from showing up.
> >
> > The failure case for couple of these css_tryget_online usage is to
> > fallback to root_mem_cgroup which kind of make bypassing the memcg
> > limits possible for some workloads. For example creating an inotify
> > group in a subcontainer and then deleting that container after moving the
> > process to a different container will make all the event objects
> > allocated for that group to the root_mem_cgroup. So, using
> > css_tryget_online() is dangerous for such cases.
> >
> > Two locations still use the online version. The swapin of offlined
> > memcg's pages and the memcg kmem cache creation. The kmem cache indeed
> > needs the online version as the kernel does the reparenting of memcg
> > kmem caches. For the swapin case, it has been left for later as the
> > fallback is not really that concerning.
>
> Could you be more specific about the swap in case please?
>

With swap accounting enabled, if the memcg of the swapped out page is
not online then the memcg extracted from the given 'mm' will be
charged and if 'mm' is NULL then root memcg will be charged. However I
could not find a code path where the given 'mm' will be NULL for
swap-in case.

>
> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
>
> Other than that nothing really jumped at me although I have to confess
> that I am far from deeply familiar with the sk_buff charging path.
>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks.
