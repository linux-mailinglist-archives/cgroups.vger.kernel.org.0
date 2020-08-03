Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3DF23B078
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 00:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgHCWuL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Aug 2020 18:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCWuK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Aug 2020 18:50:10 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D1FC06174A;
        Mon,  3 Aug 2020 15:50:10 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t18so32588511ilh.2;
        Mon, 03 Aug 2020 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAO+PpuYLBX0uefa2B1NpsdRhW1fJ0Gox2/GooMZOIM=;
        b=KoPTr2noAD6XVqblQ0ZDm8p+m1GxTbJgLxmKlP6peN1JC+e0602LcrNh6gu9ebaXQ2
         JeatTeBzUATzp79AE5HlxpKkODqdTWABRJnBgKaTw1JEK6M35cNoSvDmynZZU17JNPCd
         qDj173WmJzHySDfVECR+KGtPR7MNNMY4YEGUCLvWzdtUO4Di7z/F4K+gMHaacHSdb/7i
         6fRIEyaptXGL9Dai6I1u/EbsyMk/NV+sQpP6f8ifB7QfaCeZDWs8z9Ki0VaWK9WOv0l9
         Y7hn756uAd0RcZkpy+MFgf71qbBeZGVeI33T25YFXcnpiZe9iwydIXXFJ/R7aDm0wOdh
         XohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAO+PpuYLBX0uefa2B1NpsdRhW1fJ0Gox2/GooMZOIM=;
        b=SILPbqstLXR8k1UwIRlGEwJk5p8JGMr08EFVcwo/87tl8PtokQZKXxYyFWx6UTsGOx
         lvvqM0t4UOu4DlWkduQW2FeMnQNvXh8zJrngriVjUlVDGN8TdWVmD30tD3or0q+ZLnWn
         axRY7OwFMsdk88eb1Vm8bwm5O+Vs6eON7S4AbyUOIW+sdBXjWbtD6dd0KOJZmKt5w1IJ
         95p2t8nVN0a98cwTq8ysIojYzeUZAJsBoQ0wgiafUAKIZjl8wjYhH+NsmHVyZcEy7XO/
         mqiIdVIS356g2GwWdZYAVOcYVSBY8kKX4syDweXtc+BBCMAphh17om7i5N54zfsd7LrL
         Psig==
X-Gm-Message-State: AOAM531xfgaKlxxjdIgAevoc1tp9P8NkDslj7c4zr1ohTxJ3+m9EXHdf
        B59tM6xqe8gpKO0mxxuSFoHG8VkOPkBC2LiCTSA=
X-Google-Smtp-Source: ABdhPJyzIp0mBLgEAMF9KBUD33iW7ci/UwoWCClOTift/uX4YrgooLg8UXJJ4J7qT3jcBwOKYf8c3cDy6dv0B9fT68M=
X-Received: by 2002:a92:bd0f:: with SMTP id c15mr1705273ile.95.1596495009904;
 Mon, 03 Aug 2020 15:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com> <1595681998-19193-20-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1595681998-19193-20-git-send-email-alex.shi@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 3 Aug 2020 15:49:59 -0700
Message-ID: <CAKgT0UebLfdju0Ny9ad5bigzAazqpzfwk2_JNQQ9yEHYyVm5-Q@mail.gmail.com>
Subject: Re: [PATCH v17 19/21] mm/vmscan: use relock for move_pages_to_lru
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
        Rong Chen <rong.a.chen@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jul 25, 2020 at 6:00 AM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> From: Hugh Dickins <hughd@google.com>
>
> Use the relock function to replace relocking action. And try to save few
> lock times.
>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

I am assuming this is only separate from patch 18 because of the fact
that it is from Hugh and not yourself. Otherwise I would recommend
folding this into patch 18.

Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
