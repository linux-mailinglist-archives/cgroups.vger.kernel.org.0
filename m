Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380A648A5E9
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 03:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiAKCza (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Jan 2022 21:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKCz3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Jan 2022 21:55:29 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52086C06173F
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 18:55:29 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q25so52925916edb.2
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 18:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Y28XxOTbwhPxzWhN6RbihwTYYfYJcoL9vjrnUr5zE=;
        b=dUok9tPThdjODcNE51pXamu5TwIzsdpaI5zTXGTRW4tg5ulv80Dh6+vkkiIFZ/PpyT
         FkFAgWhiQVPIXAOMWzUy1TGBrsE3Nu4l6kZFbOCJZ5CN61JWBAM6rkoXCl6at0rWQxhI
         PCR0gQqsIgknv2e3sVxB+FPFIdXxYloQtZRyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Y28XxOTbwhPxzWhN6RbihwTYYfYJcoL9vjrnUr5zE=;
        b=KqlWtaKiN+4ti5dMe5rJ4L2e8tFnXTV1TBQkSpaFjpLd0QxLxQsAQzINfYpsmvlhlk
         EqtEvlqh75BQ1Nqh3fe7HULUBMKOZV/ot2jEfk2JhVLx1BhNQ/R8lOxBiCN04F+oN+Pr
         FFp8IO/EENY6ncrnD2/v20OTCF5u+aJQhe4k5hAtlwFqKl99IGX2d/+LB+sy/9myHuPA
         WqUpp0US27fY8XKJws/+kXAIa3VmJdQ3oqXJS+MG7mk0/gcynSBNkyu+kCUuYt+mCh+/
         BXVBZqHKULNAnOjawy+jwDPhJTPcV4bUcJrX/sBwT2bYBgqbXAkzLbon3+H0K9ooNiHZ
         a0hg==
X-Gm-Message-State: AOAM533ITkbcjkcWOT6xbEt2J5v6g3SAzGtZELeb3wpHbBK7ilBlM4M+
        ehKJKKuhhc1Pl5gDQWE3D4XyxFvONJUqt0EpAvE=
X-Google-Smtp-Source: ABdhPJyZB5V4Z2uX64F1q9Q4+J9vac9sgJyWK07Dja+WQC6du+9EfSTQXATcWwhtp7Q2a851ZsEC4A==
X-Received: by 2002:a05:6402:10d6:: with SMTP id p22mr2436307edu.211.1641869727657;
        Mon, 10 Jan 2022 18:55:27 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id hc19sm550181ejc.81.2022.01.10.18.55.26
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 18:55:27 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id v123so10066562wme.2
        for <cgroups@vger.kernel.org>; Mon, 10 Jan 2022 18:55:26 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr548893wmj.144.1641869726504;
 Mon, 10 Jan 2022 18:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20220111025138.1071848-1-surenb@google.com>
In-Reply-To: <20220111025138.1071848-1-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Jan 2022 18:55:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=whxmsa7mnzwe-DV6m26teV32geB-n-aKbYHXNm1k4rVwg@mail.gmail.com>
Message-ID: <CAHk-=whxmsa7mnzwe-DV6m26teV32geB-n-aKbYHXNm1k4rVwg@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 10, 2022 at 6:51 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Fix this by disallowing to redefine an existing psi trigger. If a write
> operation is used on a file descriptor with an already existing psi
> trigger, the operation will fail with EBUSY error.

Looks fine to me. Eric?

I assume I'll get it through the usual channels unless there are issues,

                Linus
