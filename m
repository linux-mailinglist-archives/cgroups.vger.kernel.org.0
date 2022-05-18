Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4466952B555
	for <lists+cgroups@lfdr.de>; Wed, 18 May 2022 11:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiERIxI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 May 2022 04:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiERIxG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 May 2022 04:53:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9237836E06
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 01:53:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u7so989338ljd.11
        for <cgroups@vger.kernel.org>; Wed, 18 May 2022 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBjJyFH8sXSyFWd7Z+l2eetv8x/giv4M4DnMxkIMcdI=;
        b=cezYN/54uwp401iZm2wviNOMyJq8YW8GnuhGTcKzr+80Ubn4/x8YgkkbPeybNJyGty
         Eom5EzKnHoSX8rrNyy9vABq5+8UKzIydpFBz12hOxCsUWtVcv/3nsoeXQC6oWUafmAPi
         0NQTOh1yzdwZHiEqmRECvR+1WuzibquI82nOC+PglVuN6eXSyLGUVlUfQwiqeE7bwekp
         XCjd3Lo3K3MPS8VcDUjfSCyq5yqHhNx1LnfDaojed4nLf1EykDrmNNyqv+66NULYaSss
         wYDAE/PgoYcq9hRgQd7fhs4xgwCYlJAqHb0alSfNKSWuSyEWSJrgJzcf+oVs1WFDAMEU
         stKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBjJyFH8sXSyFWd7Z+l2eetv8x/giv4M4DnMxkIMcdI=;
        b=vEegkBTy1wIOo0+xxBvb6abD7yfMeqtQJ9/3+zLjS1j6iifybhZd/UIxQC1MNiw6/0
         lDbwPvHo1L8JzCSvszUaWlhNpVRgEnvltvf/Quk+Ww2AJkXOWgpENl+IXdXsk4Vwo8F4
         4hgi7i5t7Us9Z0Mgf8gQEbBM904+xVURAn5pL+aY79nSxtRhjBNfAfa84WNqVV8/TNZ3
         j2VPIR0Qk9hRgjK3sfhiBUv4Kq+ktJZnptIQhDALdzZbjUovrfyMulQYea/gdEcyYpd+
         jXWj8WXeK+ITpz/5cTwoWDPc4PfAZBiM2IRJN2ZRCxz3Odfq6BYthli37BDhhZDjXKXC
         nfzg==
X-Gm-Message-State: AOAM532gsLdgmuP4Rxw4OcBAAreDaSmdPYFYlrgUdHeDBc3gfayNW893
        n1mPPnoLUnHCliX4TWkx7/7SDG3qaIKUlT0LjVeKUg==
X-Google-Smtp-Source: ABdhPJxbqSr9Qqsjk0zyFVPQZy3Fi77TFOlOqJFgxI5ws2ajUa+93wA9kO/j+w1syMPAbzbkUGsiZ7FWTG7ULtquuHg=
X-Received: by 2002:a2e:87d0:0:b0:250:76dd:3bdf with SMTP id
 v16-20020a2e87d0000000b0025076dd3bdfmr16003686ljj.33.1652863983580; Wed, 18
 May 2022 01:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220512123428.fq3wofedp6oiotd4@ppc.localdomain>
 <20220516094726.b5rrsjg7rvei2od5@ppc.localdomain> <20220517170817.94ca21558bbe035ae06bf6fa@linux-foundation.org>
In-Reply-To: <20220517170817.94ca21558bbe035ae06bf6fa@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 May 2022 10:52:51 +0200
Message-ID: <CACT4Y+ZkDJmoaT5ks8cmhzaNhhgaLYAhvzx+5q3yzKQEW1LZ5A@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: fix uninit-value in mpol_rebind_policy()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wang Cheng <wanngchenng@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 18 May 2022 at 02:08, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 16 May 2022 17:47:26 +0800 Wang Cheng <wanngchenng@gmail.com> wrote:
>
> >
> > ...
> >
> > This patch seems to fix below bug too.
> > KMSAN: uninit-value in mpol_rebind_mm (2)
> > https://syzkaller.appspot.com/bug?id=f2fecd0d7013f54ec4162f60743a2b28df40926b
> >
> > The uninit-value is pol->w.cpuset_mems_allowed in mpol_rebind_policy().
> > When syzkaller reproducer runs to the beginning of mpol_new(),
> >
> >           mpol_new() mm/mempolicy.c
> >         do_mbind() mm/mempolicy.c
> >       kernel_mbind() mm/mempolicy.c
> >
> > `mode` is 1(MPOL_PREFERRED), nodes_empty(*nodes) is `true` and `flags`
> > is 0. Then
> >
> >       mode = MPOL_LOCAL;
> >       ...
> >       policy->mode = mode;
> >       policy->flags = flags;
> >
> > will be executed. So in mpol_set_nodemask(),
> >
> >           mpol_set_nodemask() mm/mempolicy.c
> >         do_mbind()
> >       kernel_mbind()
> >
> > pol->mode is 4(MPOL_LOCAL), that `nodemask` in `pol` is not initialized,
> > which will be accessed in mpol_rebind_policy().
>
> Thanks, I added the above to the changelog and I plan to import the
> result into mm-stable later this week.
>
> > IIUC, "#syz fix: mm/mempolicy: fix uninit-value in mpol_rebind_policy()"
> > could be sent to syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
> > to attach the fixing commit to the bug. WDYT?
>
> Could be.  The "syz fix" isn't a thing I've paid much attention to.
> I'll start doing so ;)

Yes, we can send:

#syz fix: mm/mempolicy: fix uninit-value in mpol_rebind_policy()

to syzbot+ad1b8c404f0959c4bfcc@syzkaller.appspotmail.com
and now it should be reflected at:
https://syzkaller.appspot.com/bug?extid=ad1b8c404f0959c4bfcc

and the bug will be closed when the fix is merged everywhere.
