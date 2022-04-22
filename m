Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6A50B55E
	for <lists+cgroups@lfdr.de>; Fri, 22 Apr 2022 12:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiDVKlY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 22 Apr 2022 06:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446640AbiDVKlT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 22 Apr 2022 06:41:19 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA4654FAF
        for <cgroups@vger.kernel.org>; Fri, 22 Apr 2022 03:38:25 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b26so8088910ybj.13
        for <cgroups@vger.kernel.org>; Fri, 22 Apr 2022 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CsjTxEEAvysZcrGQCgnoFVKXKLqNd9huKoE9KzmmMI0=;
        b=svVpZpsCBwi05D6HGuAV6VNl0TnNbi1By/r9OWleeVotyMkYhrsbqEJDIDSdPkREjz
         3362oZIRJFtkLcg5aEJpF3n1xd6ipXFEq/j48MVsozpuWi4XWg+JUCI54KpRFm6k9fuH
         iuiYLtukeDIzvPYOnFvdeD/Dh3cWMScn6ijy/wJ9dMAM+Ai2YRgE3cPtVrKFn8pBOMiS
         p0gTaif83J768pmvmDZo9cf506rFJd/SfdoLFgYs7uAXbxxuhhAh95UKsS8QPEpG0lM9
         hAwDNyeI/sHaoL/fQQkj7rT73VhtZtRoFC2YjZupOfhfwmA9IsZitPApsKPfei2M4NAh
         nktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CsjTxEEAvysZcrGQCgnoFVKXKLqNd9huKoE9KzmmMI0=;
        b=SZLAQ81XrelRQsamsAItObQxgA+Pv8sWYH7z++EYQJuETvwWsqkrhAvTabSWfJlxKS
         i4fJ+7z6CO/xj4zHqb7knCjRp/QNqOxDyO32P1bqEpyR1JuxEi///CvKNaiUeD4+d+yT
         ltFUYvLefUYwVCU4KmZIA3pjJ5s0kRef7wWXbCAp4yCCEyEO44NBeqCfMFThBz1zZ6H5
         innmVCE86rcBqzF8zRkguLU3gD3Vm0ZeV1N8yrZf4npgkP+nQt4kpYdk7zpBaLtoNqjQ
         xhlE/bxRwq7G+hSPx8CPXojSkj/nFI0rn9CH4U0RMFJOLChn6dl+GqPgOLZSq9um/xwJ
         3AMw==
X-Gm-Message-State: AOAM530Fu20pqRguBh8CILJXaF09So2VtKkkN+UXJNKstPnx6BByxWFQ
        h2S4x5Cw/HgQNaX1XsVoVwt9VIkMu6Qse5GFGxnLpg==
X-Google-Smtp-Source: ABdhPJwoWm73p/RTkzfbVpkviY0RnM3o6+33FT79Cu+M02kBxAUNqMYZoyFQVWm/BUVU98mJ8P1OBCoMWhjNFhY8R9Y=
X-Received: by 2002:a25:9b85:0:b0:63d:ad6c:aae8 with SMTP id
 v5-20020a259b85000000b0063dad6caae8mr3527563ybo.609.1650623904827; Fri, 22
 Apr 2022 03:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f46c6305dd264f30@google.com> <YmEf8dpSXJeZ2813@elver.google.com>
 <YmI4d8xR3tafv2Cq@FVFYT0MHHV2J.usts.net>
In-Reply-To: <YmI4d8xR3tafv2Cq@FVFYT0MHHV2J.usts.net>
From:   Marco Elver <elver@google.com>
Date:   Fri, 22 Apr 2022 12:37:48 +0200
Message-ID: <CANpmjNPyBV8RCXf_=4oOvkLCavmgeLKw9w3M4zQEFcNMG7RCDg@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __kfence_free
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     syzbot <syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Roman Gushchin <roman.gushchin@linux.dev>,
        cgroups@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, 22 Apr 2022 at 07:09, Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Thu, Apr 21, 2022 at 11:12:17AM +0200, Marco Elver wrote:
> > On Thu, Apr 21, 2022 at 01:58AM -0700, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    559089e0a93d vmalloc: replace VM_NO_HUGE_VMAP with VM_ALLO..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10853220f00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=2e1f9b9947966f42
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=ffe71f1ff7f8061bcc98
> > > compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: arm64
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+ffe71f1ff7f8061bcc98@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 2216 at mm/kfence/core.c:1022 __kfence_free+0x84/0xc0 mm/kfence/core.c:1022
> >
> > That's this warning in __kfence_free:
> >
> >       #ifdef CONFIG_MEMCG
> >               KFENCE_WARN_ON(meta->objcg);
> >       #endif
> >
> > introduced in 8f0b36497303 ("mm: kfence: fix objcgs vector allocation").
> >
> > Muchun, are there any circumstances where the assumption may be broken?
> > Or a new bug elsewhere?
>
> meta->objcg always should be NULL when reaching __kfence_free().
> In theory, meta->objcg should be cleared via memcg_slab_free_hook().
>
> I found the following code snippet in do_slab_free().
>
>   /* memcg_slab_free_hook() is already called for bulk free. */
>   if (!tail)
>         memcg_slab_free_hook(s, &head, 1);
>
> The only posibility is @tail is not NULL, which is the case of
> kmem_cache_free_bulk(). However, here the call trace is kfree(),
> it seems to be impossible that missing call memcg_slab_free_hook().

Fair enough - we can probably wait for the bug to reoccur on another
instance, and until then assume something else wrong. What is slightly
suspicious is that it only occurred once on a QEMU TCG arm64 MTE
instance.

Thanks,
-- Marco
