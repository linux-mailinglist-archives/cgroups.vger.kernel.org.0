Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C161AEA69
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 09:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDRHEv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 03:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgDRHEv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Apr 2020 03:04:51 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5AEC061A10
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2020 00:04:51 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x2so4069661qtr.0
        for <cgroups@vger.kernel.org>; Sat, 18 Apr 2020 00:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=frcRIzvUu/qQayHA5R2SRcLWyTjvWi33DiBNKj+vA2I=;
        b=LcLkUN501e4hh2Vf9DuLPtGQ/JpLMVGYDMR/tyElPI6RiZmLO6U26K0NH2SIUbCdwD
         UVcu1R6soOOc5voW8OC+ZA8WuFhGNjO6IPA0x/m05518n0j2VPVmIXJtEe7E+fZqMwWE
         fx4YB9PiLDHhEJERBLUGTsnnQSdaGzrWo0BBI1LjMg+anW6xdG0gAA9uJJ/Z9Fk4dosS
         mEY9vonmuIvTvndoy8hMKvBA3tzalWOQ+hwdXxX04hABIIonSd14gDSpgC66CHOXeZHa
         R/JRHWU/AmxWLqBjJUYwxf5ccY8uzDNJe9qum4Kx3xhTiaBszPVs02Kn2OLMScr+9MqQ
         ru8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=frcRIzvUu/qQayHA5R2SRcLWyTjvWi33DiBNKj+vA2I=;
        b=dAHY5IatW+KeVqTa7MHz2A1rAP70lJKRO7qYBIgumFSnxFwkq0WLmsifApdxZFm1Rx
         pz0z7V++Z1edZj3fu6dRNZMJNVZQXASwfy2X5ZBBuIOjTfaKd/R2N+Y0TNgBrwGT+MN7
         Ik6I/Erq5YfMMnaeVfGXHLMXp+t/IclFHUnWsFeoMnNwsq4u6XimRxL8DWuxbGwhtCTU
         Tae14VGJO6IIXObpV8XRpJlGLPa+CvuJm9FJfQ7pqxlYHW8FmHtLN9Q0jItSFS3vROzZ
         tNf0EAqY8pMPc2SHFivrJCdGcsFyqy6wPdZaiJLvkZkptV9cHwyuFnUWr5nA4WemeH0s
         OkCQ==
X-Gm-Message-State: AGi0PuZqACynK4g4OZG68+Ckoxo+SPNkn+qF85WY8Fi7wf+WXHiAqVD9
        8F0IltLcscvBQErVlFB1iqgQ4kQc40JSdk83s/MStw==
X-Google-Smtp-Source: APiQypINDBkJDFArA1lpSkec1Z+GgV2eVqSt4z5L1ETOlwWtYWFglYmzQVtAF1J+CXbGHT+VoKbsR7tT4/0sIFn1G+4=
X-Received: by 2002:ac8:370c:: with SMTP id o12mr6795321qtb.380.1587193489821;
 Sat, 18 Apr 2020 00:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000022640205a04a20d8@google.com> <20200309092423.2ww3aw6yfyce7yty@box>
 <5b1196be-09ce-51f7-f5e7-63f2e597f91e@linux.alibaba.com> <d3fb0593-e483-3b69-bf2c-99ad6cd03567@linux.alibaba.com>
In-Reply-To: <d3fb0593-e483-3b69-bf2c-99ad6cd03567@linux.alibaba.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 Apr 2020 09:04:38 +0200
Message-ID: <CACT4Y+Zfcs2MxD9-zR748UbkEpsV4BYjFgw1XgSqX4X8z=92CA@mail.gmail.com>
Subject: Re: linux-next test error: BUG: using __this_cpu_read() in
 preemptible code in __mod_memcg_state
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        syzbot <syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Mar 9, 2020 at 2:27 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
> =E5=9C=A8 2020/3/9 =E4=B8=8B=E5=8D=885:56, Alex Shi =E5=86=99=E9=81=93:
> >
> >
> > =E5=9C=A8 2020/3/9 =E4=B8=8B=E5=8D=885:24, Kirill A. Shutemov =E5=86=99=
=E9=81=93:
> >>> check_preemption_disabled: 3 callbacks suppressed
> >>> BUG: using __this_cpu_read() in preemptible [00000000] code: syz-fuzz=
er/9432
> >>> caller is __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
> >>> CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306=
-syzkaller #0
> >>> Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 01/01/2011
> >>> Call Trace:
> >>>  __dump_stack lib/dump_stack.c:77 [inline]
> >>>  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >>>  check_preemption_disabled lib/smp_processor_id.c:47 [inline]
> >>>  __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
> >>>  __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
> >>>  __split_huge_page mm/huge_memory.c:2575 [inline]
> >>>  split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
> >>>  split_huge_page include/linux/huge_mm.h:167 [inline]
> >> It looks like a regression due to c8cba0cc2a80 ("mm/thp: narrow lru
> >> locking").
> >
> > yes, I guess so.
>
> Yes, it is a stupid mistake to pull out lock for __mod_memcg_state which
> should be in a lock.
>
> revert this patch should be all fine, since ClearPageCompound and page_re=
f_inc
> later may related with lru_list valid issue in release_pges.
>
>
> Sorry for the disaster!
>
> Alex

+linux-next, Stephen for currently open linux-next build/boot failure

Hi Alex,

What's the status of this? Was the guilty patch reverted? If so,
please mark it as invalid for syzbot, otherwise it still shows up as
open bug.
