Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6148B775
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 20:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiAKTka (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 14:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236898AbiAKTk3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 14:40:29 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620B2C06173F
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:40:28 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o15so250209lfo.11
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72nCaH0D5cVWOpCSRc18GR2eFwD5HF2lWhLZ438H8+E=;
        b=IbI2Ue6xwevdXzForB3sPC7JLpGCLW4aJaiaqGPQM519ZpN4Iw53D7dK6TEvItwJQM
         lU0w7yPNWbufVbo7aTy0WNF/06ot4HROv5RcW7EH+B/47POEIinAhzsJIzijm2pqH0rA
         32W/JrQJcTgkaHK2M1qJ6iERelYscbkX2JYhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=72nCaH0D5cVWOpCSRc18GR2eFwD5HF2lWhLZ438H8+E=;
        b=3YbI+Kjv9Wm/kLyJ7ulrTTXx2VoR1Zy4jopFLK0YgesBrLM6CoNvFNmABZPGLnAR8r
         wYGL2TDkrzsrckDV2ei+hugRezq7qxSyF4v0couy/qrEltuHVv7fpB4fHb3HSykYUAov
         HhwUNpLY1Z7JLAuK7MINAB/KVLs+9qz95zSG2KcIa25kZIde7LFdxCHjFRozP4XHEoWy
         X1j12GS3aEbEu1zM742MSONkIT5KuUFssJZzk8ZeCwUGWxiAtO9++xmgxYJBaQUNxWD5
         Bxg4GPnPFJGnkVEOgNGwyI/xYOJK7/zYMip44BdvPT2KbaClX+S9kC8VNcAQJMxr+VEA
         9XSQ==
X-Gm-Message-State: AOAM532si+YsnDmtGgZ+zFtCi3m03CQeIfvPASMcqpb6RZLpVdd9d8Jn
        Zwa+bwXQMI/Lbzs3U6iXMuXKoeaOflHBTEE1oIk=
X-Google-Smtp-Source: ABdhPJwxkwb8IKb4BOkjGitjXWcwOk23/V4mKvvYxuvjVio1TWUFyOBl+JNmFJm42LcZgvzil75mBQ==
X-Received: by 2002:a05:6512:2039:: with SMTP id s25mr4449172lfs.41.1641930026506;
        Tue, 11 Jan 2022 11:40:26 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y7sm1429605lfb.272.2022.01.11.11.40.26
        for <cgroups@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:40:26 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id d3so215204lfv.13
        for <cgroups@vger.kernel.org>; Tue, 11 Jan 2022 11:40:26 -0800 (PST)
X-Received: by 2002:adf:c74e:: with SMTP id b14mr5117431wrh.97.1641929709117;
 Tue, 11 Jan 2022 11:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
 <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com> <CAJuCfpE3feNU=36qRUdCJsk41rxQBv1gRYy5R1dB1djMd0NLjg@mail.gmail.com>
In-Reply-To: <CAJuCfpE3feNU=36qRUdCJsk41rxQBv1gRYy5R1dB1djMd0NLjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:34:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9-9mFcoaD3rdHd+HKYpyTXkkE2iJkPoTTCrp-+sD=ew@mail.gmail.com>
Message-ID: <CAHk-=wj9-9mFcoaD3rdHd+HKYpyTXkkE2iJkPoTTCrp-+sD=ew@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
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
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 11, 2022 at 11:27 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> Thanks for the explanation!
> So, it sounds like the best (semantically correct) option I have here
> is smp_store_release() to set the pointer, and then smp_load_acquire()
> to read it. Is my understanding correct?

Yeah, that's the clearest one from a memory ordering standpoint, and
is generally also cheap.

                Linus
