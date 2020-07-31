Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE02234D02
	for <lists+cgroups@lfdr.de>; Fri, 31 Jul 2020 23:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgGaVbV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 31 Jul 2020 17:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgGaVbV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 31 Jul 2020 17:31:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23186C061574;
        Fri, 31 Jul 2020 14:31:21 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so24895983iod.1;
        Fri, 31 Jul 2020 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IPQ4YxQDiIfVNt/lLYL1uBZHZt0DN0r5SckeWlUL42o=;
        b=ZqlUeZYlm3G5RmGJ/gBq3usEdl293NPeNsf49vRwQFLjpkFcMWw+/wHHQF6OC4lnEP
         UYDZlF8vFK8pP7i3LP5yfgXYgTcpyUR4UwcUnE6SMXnXfcK4/ymgbvAloDaeW1XQ/7sF
         mIoGy57n/qQO2ubYE7SWThSVcKDv9ygK/qFBuHnT+K103p4/RMBjdNGuzR8h/3BotrLk
         SnIDwhtP7EWGGpssFryMLmnyNz0ZvHxRrqEA7eBsskIgqQkumayrOCdAFLfOvEnNbK1W
         FNwJP/oozmm4xtxuJ+f8VMzsh2DtO8LvNBSg3tUjEuW/ft6bstP8wUjPiuE/+DZsY7Lz
         n/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPQ4YxQDiIfVNt/lLYL1uBZHZt0DN0r5SckeWlUL42o=;
        b=nVNWeuScYVXly+pKPeu42JlUvkjkT3jvPQ+bONHg4gxFunoEqppnAT/5IeOYXDlHzH
         gSPtDHXOWB3k8F9vS5xBJuFguyTO5+op2whk+OO1cbTBm9ZF0T3T4LWuNDKiQ5wBUEO6
         3lXNVSGuUKhpNHnJVcJTEHPj0BOAdI/a3zFRjAEJwzYlxhArbTqARKQx0VpmfCRdqsBb
         3pFKbdlOdBulzfq8j2Zg2/e3D0+NRwe850wrEMNhr/x+2e4PLd+wmrbbLfnrnRM+jl9G
         DWdior71SifO7poGCdJaQ23cvsPeslGVsTdTkA6/O+qTy+uk5tGXjR0zgMzL6Hob7sfM
         8wHQ==
X-Gm-Message-State: AOAM533HbBEDRQGlqxywQD4IKQd2C8Hu5QJty95eH6SlMvM+mwFPxJpL
        T4Mb1lYp6SRBaHcXzabrg+cNNDp+ImGbwgDB5Ew=
X-Google-Smtp-Source: ABdhPJwdLNEFCnWUSxtOXLRAFdZSVwbu2VSbb24NWwr7R+O5oVVHBXi1NoFBl5lk5aI8qoQlxhxMOXQ/bRMFkEeE1gI=
X-Received: by 2002:a6b:da0d:: with SMTP id x13mr5550869iob.138.1596231080492;
 Fri, 31 Jul 2020 14:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Fri, 31 Jul 2020 14:31:09 -0700
Message-ID: <CAKgT0UfMD1GytjJKYLQNCYzNFs1trdYFCtPkAhqnFhkW5ppYOg@mail.gmail.com>
Subject: Re: [PATCH v17 00/21] per memcg lru lock
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> The new version which bases on v5.8-rc6. It includes Hugh Dickins fix in
> mm/swap.c and mm/mlock.c fix which Alexander Duyck pointed out, then
> removes 'mm/mlock: reorder isolation sequence during munlock'
>
> Hi Johanness & Hugh & Alexander & Willy,
>
> Could you like to give a reviewed by since you address much of issue and
> give lots of suggestions! Many thanks!
>

I just finished getting a test pass done on the patches. I'm still
seeing a regression on the will-it-scale/page_fault3 test but it is
now only 3% instead of the 20% that it was so it may just be noise at
this point.

I'll try to make sure to get my review feedback wrapped up early next week.

Thanks.

- Alex
