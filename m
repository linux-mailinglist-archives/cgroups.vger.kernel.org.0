Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1421C2CF1C5
	for <lists+cgroups@lfdr.de>; Fri,  4 Dec 2020 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLDQUr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Dec 2020 11:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLDQUq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Dec 2020 11:20:46 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFC7C0613D1
        for <cgroups@vger.kernel.org>; Fri,  4 Dec 2020 08:20:06 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c79so4048570pfc.2
        for <cgroups@vger.kernel.org>; Fri, 04 Dec 2020 08:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fe+vbNKf2orQSQdQfp84tFWO7dmTK0e8xZVK2kuk9vc=;
        b=00ymjmeHcRm+t9WqfDypR12xjjGpRELcXY0sIkHfHtMG6GdeFg8EcQt28ccHWoeOIk
         tOcEiwui9V9z5lzZCtEYUMXKoXacmBh3GI5G/Obk0zIwy7KXlWsq7P8hxvuUC9JLs4cT
         NatI8Rdmu1F+VnftUvhJ6bJj+11mSL4aVSPk7Qt8f5pEYc29Sva7p5t1SmunuF4uZlLV
         DAoYBcmG/3chKFux9QqTK0Y+YruaH4fHQglRAaT4ywJ5KetCdUKm5N5kWPd6ultHAUpO
         G6oupDP9ndJQ4STkntJw/zwi4f1qtk5NJbc4eX9ND0GJAgw6X5UEcw2iFT1Opd4n3cKz
         V6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fe+vbNKf2orQSQdQfp84tFWO7dmTK0e8xZVK2kuk9vc=;
        b=IRqxwbMBwrS/GF8pN+rlX7Rl9M1p/31q4gi5DuT+SVK9o6VEQ/i55qnSrNE5UTrdw7
         fcXPCNzw1FUl/Sq7zHhg++BN/VKVygsXWYUDZJaaplMjt5RkzDqjdo+KH0Cy0DBOfL3B
         bnRM9tTdWlMdH8dTMSVS7dL2qWayPrFqaxB1pJNBfmWE+TXOdSgVfEqJnUDj325czR0r
         xrszVN5tvo3Swr03++vblijGP+LI4oXMyU9/FTyhk0U68BVVb/+6qyocqmJHxCQHYoGa
         WYrHVL96RidXIBTibV639rs7lExtFlekzoubjvz836R/QS5VhHYy4gPuT4zk3FVytZYb
         I3qw==
X-Gm-Message-State: AOAM533bBDC0fG5wvXTKzHu1hW+UboI17wujimsXUEEOArrDJYZD6dxS
        Hh2L+UCeklDZfChVaGzQ4jAVgSndKdridypAkBt4Hw==
X-Google-Smtp-Source: ABdhPJx3djr9fUf8EXR6B02YTCxWp5UKSEi9b1HmR59NDusa/KdvB75cQjsaMRdK5L9unlrT3dQcwY8opF6Bq/+6m5U=
X-Received: by 2002:a62:3103:0:b029:19b:d4e8:853c with SMTP id
 x3-20020a6231030000b029019bd4e8853cmr4524242pfx.59.1607098806291; Fri, 04 Dec
 2020 08:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20201203031111.3187-1-songmuchun@bytedance.com> <20201204154613.GA176901@cmpxchg.org>
In-Reply-To: <20201204154613.GA176901@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sat, 5 Dec 2020 00:19:30 +0800
Message-ID: <CAMZfGtUkQUoy39qyHLPTdBY_38U23yThmFaHx2yfqz5ocfMViw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm/memcontrol: make the slab
 calculation consistent
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Dec 4, 2020 at 11:48 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Dec 03, 2020 at 11:11:11AM +0800, Muchun Song wrote:
> > Although the ratio of the slab is one, we also should read the ratio
> > from the related memory_stats instead of hard-coding. And the local
> > variable of size is already the value of slab_unreclaimable. So we
> > do not need to read again. Simplify the code here.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
>
> I agree that ignoring the ratio right now is not very pretty, but
>
>                 size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
>                        memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
>                 seq_buf_printf(&s, "slab %llu\n", size);
>
> is way easier to understand and more robust than using idx and idx + 1
> and then requiring a series of BUG_ONs to ensure these two items are
> actually adjacent and in the right order.
>
> There is a redundant call to memcg_page_state(), granted, but that
> function is extremely cheap compared with e.g. seq_buf_printf().
>
> >  mm/memcontrol.c | 26 +++++++++++++++++++++-----
> >  1 file changed, 21 insertions(+), 5 deletions(-)
>
> IMO this really just complicates the code with little discernible
> upside. It's going to be a NAK from me, unfortunately.
>
>
> In retrospect, I think that memory_stats[] table was a mistake. It
> would probably be easier to implement this using a wrapper for
> memcg_page_state() that has a big switch() for unit
> conversion. Something like this:
>
> /* Translate stat items to the correct unit for memory.stat output */
> static unsigned long memcg_page_state_output(memcg, item)
> {
>         unsigned long value = memcg_page_state(memcg, item);
>         int unit = PAGE_SIZE;
>
>         switch (item) {
>         case NR_SLAB_RECLAIMABLE_B:
>         case NR_SLAB_UNRECLAIMABLE_B:
>         case WORKINGSET_REFAULT_ANON:
>         case WORKINGSET_REFAULT_FILE:
>         case WORKINGSET_ACTIVATE_ANON:
>         case WORKINGSET_ACTIVATE_FILE:
>         case WORKINGSET_RESTORE_ANON:
>         case WORKINGSET_RESTORE_FILE:
>         case MEMCG_PERCPU_B:
>                 unit = 1;
>                 break;
>         case NR_SHMEM_THPS:
>         case NR_FILE_THPS:
>         case NR_ANON_THPS:
>                 unit = HPAGE_PMD_SIZE;
>                 break;
>         case NR_KERNEL_STACK_KB:
>                 unit = 1024;
>                 break;
>         }
>
>         return value * unit;
> }
>
> This would fix the ratio inconsistency, get rid of the awkward mix of
> static and runtime initialization of the table, is probably about the
> same amount of code, but simpler and more obvious overall.

Good idea. I can do that :)

Thanks.

-- 
Yours,
Muchun
