Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03645168831
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2020 21:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgBUUTe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Feb 2020 15:19:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40088 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUUTe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Feb 2020 15:19:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id i6so3163363otr.7
        for <cgroups@vger.kernel.org>; Fri, 21 Feb 2020 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfpZw+eQB6iSYwMvRBzJaMRaqdbsGid5gEGpxbg9sSM=;
        b=uEcpgNIxyzARyyktOQSbbTIs3P/w6TgKfs9rTrYnQfUyOtw+Y/jWrbLk7GkpTw92F7
         YHwCKs5T5uF+WI5VOd8W3VJSXefpdWblnH2gBQoZnI+NHI3YMXR7Z3urY25D/8f0kt+5
         ettm551MbN+59D/LxW/SLaMiPedHQ9kOlXA3X8v3r5noGfJwngzmXCWszw3mqnCjIzvo
         r7Z6FaMc9KsSbykj/UPyzOLNB2wYbJqvXWsCv08JWsILT0TMm+92HS6wbrXIHvqew/Kd
         4mh4l1iYel1wAbHtHlNBjxSVzH58UCi+aOlqSAai7VkXTKw6DzwAqSLjD83fek6LJzR4
         Swfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfpZw+eQB6iSYwMvRBzJaMRaqdbsGid5gEGpxbg9sSM=;
        b=VF5lgIKjB/Lh+yEPilhqLbtIMAqyaHy7eth9N6BUkTqV/6mzr2sAWLfTHS9PZWRLTZ
         HWaoRQEu2Mxs0uYTjjaVQCfjcoRWT6E2mJo0C8/bTIiivi+i9tv+uK43FHS2zBrsOrlr
         TNyybAQwHgnIITCgnm9FHkU79YIAQruP7ehI0Nx01TF6HyAODgiIvyPrbSuZ7AF/nPfD
         xlmgPtn2EQ+TyhlIUpWxqaHJasoW1We5Rw1R3As12G8+od0bk6D7fqb4ZLo8WDrdqpSV
         fkaW35FDkAL4UTWoav5gk1RFRE3jSDBtnxqafjn8AfJdVCh8y/vfdSBjTOCTjfmJwT5E
         hNTA==
X-Gm-Message-State: APjAAAXDLm96xT+Zm3l/2iE4KLNsgUbws4dnLXoM8KIqK565xycSZ0Yo
        cFroNrR8l+bfS5NGLVzAqFq+tn0CSiUpcKGMRnHXZQ==
X-Google-Smtp-Source: APXvYqyx/RGSX2qyoU/QNIJeZF7dI+U24Dxth1TtmWp8pOZPVerHNA8pMkzSW7LFvniRoOIoJ5G9d1IhZP3X8SA4R3Y=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr28357211otg.349.1582316373221;
 Fri, 21 Feb 2020 12:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com> <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
In-Reply-To: <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 21 Feb 2020 12:19:22 -0800
Message-ID: <CAHS8izPB1vwuZVFha+5_ca9gKC7UceDdJFJZe9eb-T43a6GF8A@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 1:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > > These counters will track hugetlb reservations rather than hugetlb
> > > > memory faulted in. This patch only adds the counter, following patches
> > > > add the charging and uncharging of the counter.
> > >
> > > We're still pretty thin on review here, but as it's v12 and Mike
> > > appears to be signed up to look at this work, I'll add them to -next to
> > > help move things forward.
> > >
> >
> > Hi Andrew,
> >
> > Since the patches were merged into -next there have been build fixes
> > and test fixes and some review comments. Would you like me to submit
> > *new* patches to address these, or would you like me to squash the
> > fixes into my existing patch series and submit another iteration of
> > the patch series?
>
> What you did worked OK ;)
>
> Please check the end result next time I release a kernel.

Hey Andrew,

Thanks for taking in the patset and fixes. Only pending change in the
latest -next tree is this one:
https://lore.kernel.org/linux-mm/20200219233610.13808-1-almasrymina@google.com/

It's reviewed by Mike here:
https://lore.kernel.org/linux-mm/a0d7b8e1-cb43-3b43-68c3-55631f2ce199@oracle.com/
