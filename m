Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF805183B02
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2020 22:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCLVG7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Mar 2020 17:06:59 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36690 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbgCLVG7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Mar 2020 17:06:59 -0400
Received: by mail-ot1-f68.google.com with SMTP id j14so7887315otq.3
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=f+l+gXIKYD8ZqIsbSKM4dLqAUjD21JGnao8P6oy+6Zmm9Rb8AXN6l/tS4s9RT9ecgP
         8OTh+Gt18uKCXrL2agzWwd/jaz4kTY1PcHwRp8AM/PzPPozlKad5X4ZfeHipH/tIBjxa
         99BbLEDknWH+7czLa5Ds6pxh1qQr+8L/YyNq5vH159Q93v9ftJQBMYn9MTLI0ylozz0g
         SxF6JBvVR6aRYy+G/pWJCbP5kvTgAoAwODj4DnUgeTdzCZUniI5BUzeE45A4/CVcJor4
         PJTNqoA2uuZZ4WpMILVN15YTIvUc7nqvO81ayj7Ez+wssmSZmgvM6o862uS0AIZwCaSh
         XIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=PYpGcI4aQXXJU+A8oJaN5ICLlZmEVk/+BgAqtTRnjj6Y3fJUoWa1e5+ecQUFA3LDry
         XnaNjF4o1LTqKw2+R0fYvMZxchjdE1GOhymIx92ToLGp9Yiq2dzbyMLq/NcBKhKascrq
         BX4pw9qTxbfRByW5nqqEjNT6gf9Aq6En3AZ3OWQHSY8CevhPwVqQb2GnnszEKHO0aBMu
         WupOhCVURwyfiuABvaAD/GH77hqFPTDspPabYjH94COicb5rTkVCGa3QWngg7q4siKRX
         m/ZF1ezPqMlphqwZvRHc0DLkmkBdvEBhRVva0Ahrdz2BI/6uLZdopj5GlxXTJu6A2erJ
         zX/g==
X-Gm-Message-State: ANhLgQ1XCaT0Ms1AVJrG7pXkR+VMQKiN+dEG7Sd/FVJQ8WVgYnYJIHLi
        AQr1qHLnnDfpGGKjZ5aiiYTsYMA/uxo6RFfj57Q4iQKIXF4=
X-Google-Smtp-Source: ADFU+vuorKp4Am1Eft4fdcP1G8Nf7OvlWyXXPJjJAuw2HysSDIhCcZVTlSzqZ6RrA6JxKhMxZ3B+h9vZHTYAu4IJG2I=
X-Received: by 2002:a9d:c24:: with SMTP id 33mr8191344otr.355.1584047218074;
 Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000041c6c205a08225dc@google.com> <20200312182826.GG79873@mtj.duckdns.org>
In-Reply-To: <20200312182826.GG79873@mtj.duckdns.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 12 Mar 2020 14:06:47 -0700
Message-ID: <CAHS8izPySSO07dHi3OZ_1uXjmMCGnNMWey+o-qwFM7GnD7oSHw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in cgroup_file_notify
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, andriin@fb.com,
        ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        christian@brauner.io, daniel@iogearbox.net,
        Johannes Weiner <hannes@cmpxchg.org>, kafai@fb.com,
        open list <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, netdev@vger.kernel.org,
        sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 12, 2020 at 11:28 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 08:55:14AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c99b17ac Add linux-next specific files for 20200225
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1610d70de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6b7ebe4bd0931c45
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cac0c4e204952cf449b1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1242e1fde00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1110d70de00000
> >
> > The bug was bisected to:
> >
> > commit 6863de00e5400b534cd4e3869ffbc8f94da41dfc
> > Author: Mina Almasry <almasrymina@google.com>
> > Date:   Thu Feb 20 03:55:30 2020 +0000
> >
> >     hugetlb_cgroup: add accounting for shared mappings
>
> Mina, can you please take a look at this?
>

Gah, I missed the original syzbot email but I just saw this. I'll take a look.

> Thanks.

>
> --
> tejun
