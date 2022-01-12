Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB6148CA98
	for <lists+cgroups@lfdr.de>; Wed, 12 Jan 2022 19:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355982AbiALSEP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Jan 2022 13:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356008AbiALSDy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Jan 2022 13:03:54 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B296C061751
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:03:54 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id z22so13138931edd.12
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhSCFec3TdzZgoMmjiOtfrqEeP0ETxz+5Dx8yofaKqk=;
        b=ACYcmQYX22hOF9eHsSpz63wI3cG/WXMRlzAlN2whKAaJhPR9GPIxx9qzxyuqNMjA+7
         rZivP0MyhKT2m5OXVlrJzc4KyBRcDy7L36J2mi7wYToYCPNHQweiy7y/QtQh9y37tYtS
         Q95EMM11LnVKXAhQsE7YRBQZnsA8tqq/mJJvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhSCFec3TdzZgoMmjiOtfrqEeP0ETxz+5Dx8yofaKqk=;
        b=uiFVa6HrpKCjkVR/0zoaMhGrWq2WQ56yMO6+47ewnqjSaebOZCpnZcJCflaSLLbNKG
         4MeGiEY7hPqCeT+jfsjtjfHrZbFAvS5thHdcZKAAZ4GuzleStKTMCN7coZZNTv/I37Xh
         yJDK/6uSnfnhUDmwWX9SKsTgvimL16UytaHnoD6WsopwZB9HNRhEnxWzSH//RIRZCtHY
         NaxZkHYyEhrPYx5VyN691JlfOPRMOPMIuPJNgYoEyLEhf3YGw19xuAhZAaTlj0XUhyyK
         n+hFJ0v/MAdDB9d1bfa7mf2vXODbAe4hfIt1hGt96rJrXaKK0DJC+i7Q/iIppj2FDraX
         E8Jw==
X-Gm-Message-State: AOAM533wxX5YNQpGxlq+AiRm6lc9/xYfxIQajYQQ356V508McC8Elpyv
        ntjH4vzsipMlPqMOIamRHra9OIGA9at7Xsrjhwk=
X-Google-Smtp-Source: ABdhPJxeqVrY9GrBAHiyQVT+SalVAPx8aBOZ6H/d1UQPSzkR+OAVuMbYJot0/f3awTR8tqZ16HzkVQ==
X-Received: by 2002:a17:907:72c2:: with SMTP id du2mr718621ejc.326.1642010632765;
        Wed, 12 Jan 2022 10:03:52 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id c19sm208721ede.47.2022.01.12.10.03.50
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jan 2022 10:03:51 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso3961624wmj.2
        for <cgroups@vger.kernel.org>; Wed, 12 Jan 2022 10:03:50 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr7775750wmq.152.1642010629913;
 Wed, 12 Jan 2022 10:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20220111232309.1786347-1-surenb@google.com> <Yd6niK1gzKc5lIJ8@hirez.programming.kicks-ass.net>
In-Reply-To: <Yd6niK1gzKc5lIJ8@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jan 2022 10:03:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiNQD6o-REKoZv_5cHWrGmsT_KgduYCsLdLqbdHWUKcdw@mail.gmail.com>
Message-ID: <CAHk-=wiNQD6o-REKoZv_5cHWrGmsT_KgduYCsLdLqbdHWUKcdw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 12, 2022 at 2:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Thanks, I'll go stick this in sched/urgent unless Linus picks it up
> himself.

I'll let it go through the proper channels, it's not like a few days
or whatever will make a difference.

               Linus
