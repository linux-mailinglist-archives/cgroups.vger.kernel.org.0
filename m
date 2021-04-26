Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0B36B680
	for <lists+cgroups@lfdr.de>; Mon, 26 Apr 2021 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhDZQJc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Apr 2021 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhDZQJ2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Apr 2021 12:09:28 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717E8C061574
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 09:08:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j4so49608179lfp.0
        for <cgroups@vger.kernel.org>; Mon, 26 Apr 2021 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCAc8uLKViQfUk6B9sQWnMNVd4nGJwcjR6PW4cxuT2A=;
        b=MzCzIiVtMu1qdJI/u9e7KD/8RmMP8y12i8ZSPtKP62d9lMQPum9lvtHdiRC8oHx/qh
         XffKtPgLq0Su+RJ5q+ESjxgur66Phf9k8nqh+RdvNdoD6KiKthenym8pjlzysAYqMRvC
         yE2VYwXpeTkAQi9kbB/QfLC3XmyzDBLuBx68WBxljpr74J3xca1Y28ExEDwCa1LPOt7o
         BO8bwn4beRzTJFNsB4ILYHbHvyPK0hgk9pDcAhk111GosEN6pkXxitqOCD+JcFO3ChkL
         IWe25tp7V5+Csw1QtUmxLzsIVfvrOV3eS3Mo6KhGSeY9FgLN+KCvIr7TbRmS96MP00Zy
         TAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCAc8uLKViQfUk6B9sQWnMNVd4nGJwcjR6PW4cxuT2A=;
        b=P8Fszst4+W6sxI8flLoLnfMmEcK/YmFBdZ3xkPfaZSHN8f1HViIA77Xy7/l5J4AJzL
         lzcIdEoVbpxYNXT4e/iVmTmRGU4V2ljo6AHzG4G5OkTLBYcSAti3yzWHY0OblG1C/C8J
         XXjGWX+QhlAk3zr6CVuPcMoYzhdYgrNcGMygj0bhhXREcWRVQoy49bxAMtwYfJH4IEx+
         Men/x4EN3hJnJoWCRtZ9VvpItsxoNvOwT7eiH9+ZBPukYoZcOM+oX3CdL0fEW929w7v3
         Fq0qTJ1aCGv8j03T8EYA6TTT5M5x4pnJ450mQY248Ow+RXjQhMxRiANR+6KbE2dp1rFD
         4cdA==
X-Gm-Message-State: AOAM532sHjASfOEhV9GyXEeybl9n1biwEiYOdbx0jOfGyb9nRWgxHVdy
        N99jf0/xfhsyhckz3dzVuZpnpLI09XldSAL0UneIsA==
X-Google-Smtp-Source: ABdhPJzwOgCtG1j8UN9F5jO+xUolC2cySL3zSgj6jyX9FwuliFEWn6HjHjbgdUfK2XnXOEA+5mlYpxIP2uNeVl+BnGY=
X-Received: by 2002:ac2:58ee:: with SMTP id v14mr13004371lfo.83.1619453323740;
 Mon, 26 Apr 2021 09:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210423171351.3614430-1-brauner@kernel.org> <YIbRZeWIl8i6soSN@blackbook>
 <20210426152932.ekay5rfyqeojzihc@wittgenstein>
In-Reply-To: <20210426152932.ekay5rfyqeojzihc@wittgenstein>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 26 Apr 2021 09:08:32 -0700
Message-ID: <CALvZod5=eLQMdVXxuhj9ia=PkoRvT5oBxeqZAVtQpSukZ=tCxA@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: add cgroup.signal
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 26, 2021 at 8:29 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
[...]
> > Have you considered accepting a cgroup fd to pidfd_send_signal and
> > realize this operation through this syscall? (Just asking as it may
> > prevent some of these consequences whereas bring other unclarities.)
>
> That's semantically quite wrong on several fronts, I think.
> pidfd_send_signal() operates on pidfds (and for a quirky historical
> reason /proc/<pid> though that should die at some point). Making this
> operate on cgroup fds is essentially implicit multiplexing which is
> pretty nasty imho. In addition, this is a cgroup concept not a pidfd
> concept.

What's your take on a new syscall cgroupfd_send_signal()? One
complexity would be potentially different semantics for v1 and v2.
