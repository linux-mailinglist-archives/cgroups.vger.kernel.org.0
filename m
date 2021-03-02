Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7086932B1B1
	for <lists+cgroups@lfdr.de>; Wed,  3 Mar 2021 04:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239672AbhCCArV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Mar 2021 19:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242089AbhCBDni (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 1 Mar 2021 22:43:38 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F306BC061794
        for <cgroups@vger.kernel.org>; Mon,  1 Mar 2021 19:43:40 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id h4so21989917ljl.0
        for <cgroups@vger.kernel.org>; Mon, 01 Mar 2021 19:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3B0Sx20A1r9upf4Kb0C/kpU0MZoTOmOraXVoNYgXq+0=;
        b=vhnQXwzEG4fSKT+nNG8JUDOp8WuwtYyM9Vz5u8UuMP5J6E6kOng7zABNCZkGIvqO/Z
         lF4txvkAhYVRIOspQwJRhpV/pfvlYUWQ8uOzwdf7klS7QjLw4GNL+ZBCxj7jb1kaXaWW
         2EVpdc+nUpLUFYKejU4N1/NkqXpsK+iNO2iUhOD5PzWkGPjRXlFH5Vq9hI5nweviVxJ0
         NpiRLjezGtQ6dFxliVjEln5wPhPJNrZsZ1EAFlEqOtxnHA3L0FT4PBwuk8yR82LJKP06
         vMlaRaiuezL4cMfKgC2gSDIA/EiixC0Hmd9+1A8bYAQyOZYqpDyERlYiqDTLSGk7L7Vd
         2HCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3B0Sx20A1r9upf4Kb0C/kpU0MZoTOmOraXVoNYgXq+0=;
        b=lO+OTVrlniHY+KeoBHxvXl/X7D4rUeAFXrT+hmcnO3n6kEgb7chBg/Y+9klBX9UuZL
         YgJVlfEQw3RX6rZPEPadtzF84BGlhKJbrfED4aWNEDgOjLD2rSCoYsptN1ILf+ctpAOi
         ot3FL+SfSqNtmPlY6VSJn8Be1VHDy6Jfsx+v5XSyGNlDnJQR+Xagq54tF/Oac8nYGSXc
         7/g5jvxKMUEnwj2Gr0KStGiavRQ4erWbbrjSIApYPKA3C716ybVlojhivBqfY4mRQl4L
         DZCReCBwW1x5XmY0doPk8Vs1duyAr2fUYCwg/X8Vmmh7Qi0WHAuuHn9otAgOYfqiSFlH
         twgw==
X-Gm-Message-State: AOAM532pHsKv1uxFIFghyI+2jPbJo7V30rA0L6n7lZT+jXMv9eQ+52Br
        OB3mDwDM/ooix3Cj7FUnWflHuBCOrAvpifZaBT7QdQ==
X-Google-Smtp-Source: ABdhPJyC5KTWWfJMUVQrljO6hX8iwyh7wkZlnr5yI6GC2wySp0634pLrU6si7GQKQAf9+DCrxQr24mvnkUGVPNVCw6o=
X-Received: by 2002:a2e:7d03:: with SMTP id y3mr9224356ljc.0.1614656619239;
 Mon, 01 Mar 2021 19:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-5-songmuchun@bytedance.com> <YD2RuPzikjPnI82h@carbon.dhcp.thefacebook.com>
In-Reply-To: <YD2RuPzikjPnI82h@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Mar 2021 19:43:27 -0800
Message-ID: <CALvZod4rWvMJdnbfMm4SGtj0WyqDzvH8RY9G32y=NLNCZqJ2Gg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: memcontrol: move remote memcg charging APIs to CONFIG_MEMCG_KMEM
To:     Roman Gushchin <guro@fb.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, esyr@redhat.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 1, 2021 at 5:16 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Mar 01, 2021 at 02:22:26PM +0800, Muchun Song wrote:
> > The remote memcg charing APIs is a mechanism to charge kernel memory
> > to a given memcg. So we can move the infrastructure to the scope of
> > the CONFIG_MEMCG_KMEM.
>
> This is not a good idea, because there is nothing kmem-specific
> in the idea of remote charging, and we definitely will see cases
> when user memory is charged to the process different from the current.
>

Indeed and which remind me: what happened to the "Charge loop device
i/o to issuing cgroup" series? That series was doing remote charging
for user pages.
