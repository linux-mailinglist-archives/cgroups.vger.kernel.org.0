Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0991E450E03
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 19:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbhKOSKE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 13:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbhKOSFF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 13:05:05 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF04BC110F0E
        for <cgroups@vger.kernel.org>; Mon, 15 Nov 2021 09:32:55 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id e9so37168146ljl.5
        for <cgroups@vger.kernel.org>; Mon, 15 Nov 2021 09:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fIZsV1tZ1zejKBLMIoMZpzHmx69X5V2FDPLBZdbpb4I=;
        b=I0XsVPB1FjfH1rhf3ncp0KEXwazjq2PIf6R5llK+ireA6WKRE5bO3s2q5dXEaBJirg
         YEYLAzgw4ei9euOlx+LKjVYERdtPvbKR51tBnmc02VDC6I6eXPtR2Nwot1iCYcb02ert
         AfJSWq9PE3c7BltHeWeZeZP/T1xtt0Q3fy37o4qC+tcObqJJB6uKfDoMRKylB4DSebuc
         Yty4EIwtGqQZ6wZp2zIpfxkCz5x6nqi0tAsY2milaXqCyhYjnqtSt77DsEiKnZqpWDc0
         CErK70dbfqIkSjJfcr2z14RsNvlkNnVX2qvpnShUPEtUoMtHp7FZxsiumXCEnZnkCB6V
         3WYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fIZsV1tZ1zejKBLMIoMZpzHmx69X5V2FDPLBZdbpb4I=;
        b=TEJQcV89T8EEB3BXoEFU8gq5I4Zn+rGO7/AqNYjBd59c1vqocV5d8FKY45/wbXJdz+
         6VeV4O1vRGZCg7chhNt4OM5bwQqbxE1TOOV21Ku8zz20Usa5dFTI6ouWdpHMgeA8mowR
         C3+lSNlS80uTCmudG10iRIR+L2ARGakRIupDed4t76u5nKh9dUMn4mKNkBzpWPqQI7Ho
         hZjd/1xPiLkGyWiC9fqi3YVKhWRhzNwLNCIeGJ2j94uS7P+/Tlocflm7RQAjsz3CEnIi
         X3n2y/ua18iPoBBmTsJgwQ18ZCvLyY9umLZQdiROkVf1gNZTt+hnDe0dNivcu6S/VOKK
         wMXQ==
X-Gm-Message-State: AOAM533V63AyuxM+EPA1gMlP6bAkF3a7/KSSPn0Cfvvnt4jh+thR5mqI
        /S8fOybnUEjLr3flMAoJf/XZ9T8+B3qoOtDk26lQdQ==
X-Google-Smtp-Source: ABdhPJyaBBfC+vfCO5R9uufkjWJYBe2T5CgoqLc2lysplK5NQmmEvq/aLPvOlcgfRzAM3cMTLACBIhbgPcNlt4aK4+g=
X-Received: by 2002:a2e:a314:: with SMTP id l20mr335865lje.86.1636997573877;
 Mon, 15 Nov 2021 09:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20211111234203.1824138-1-almasrymina@google.com>
 <20211111234203.1824138-3-almasrymina@google.com> <YY4dHPu/bcVdoJ4R@dhcp22.suse.cz>
 <CAHS8izNMTcctY7NLL9+qQN8+WVztJod2TfBHp85NqOCvHsjFwQ@mail.gmail.com>
 <YY4nm9Kvkt2FJPph@dhcp22.suse.cz> <CAHS8izMjfwgiNEoJWGSub6iqgPKyyoMZK5ONrMV2=MeMJsM5sg@mail.gmail.com>
 <YZI9ZbRVdRtE2m70@dhcp22.suse.cz>
In-Reply-To: <YZI9ZbRVdRtE2m70@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Nov 2021 09:32:42 -0800
Message-ID: <CALvZod7+P-2JR=Wsi_eYDymabAt=DFz4eR4w2KNtC-k1+AUtBg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm/oom: handle remote ooms
To:     Michal Hocko <mhocko@suse.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, riel@surriel.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Nov 15, 2021 at 2:58 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> >
> > The behavior I saw returning ENOMEM for this edge case was that the
> > code was forever looping the pagefault, and I was (seemingly
> > incorrectly) under the impression that a suggestion to forever loop
> > the pagefault would be completely fundamentally unacceptable.
>
> Well, I have to say I am not entirely sure what is the best way to
> handle this situation. Another option would be to treat this similar to
> ENOSPACE situation. This would result into SIGBUS IIRC.
>
> The main problem with OOM killer is that it will not resolve the
> underlying problem in most situations. Shmem files would likely stay
> laying around and their charge along with them.

This and similar topics were discussed during LSFMM 2019
(https://lwn.net/Articles/787626/).

> Killing the allocating
> task has problems on its own because this could be just a DoS vector by
> other unrelated tasks sharing the shmem mount point without a gracefull
> fallback. Retrying the page fault is hard to detect. SIGBUS might be
> something that helps with the latest. The question is how to communicate
> this requerement down to the memcg code to know that the memory reclaim
> should happen (Should it? How hard we should try?) but do not invoke the
> oom killer. The more I think about this the nastier this is.
> --

IMHO we should punt the resolution to the userspace and keep the
kernel simple. This is an opt-in feature and the user is expected to
know and handle exceptional scenarios. The kernel just needs to tell
the userspace that this exceptional situation is happening somehow.

How about for remote ooms irrespective of page fault path or not, keep
the allocator looping but keep incrementing a new memcg event
MEMCG_OOM_NO_VICTIM? The userspace will get to know the situation
either through inotify or polling and can handle the situation by
either increasing the limit or by releasing the memory of the
monitored memcg.

thanks,
Shakeel
