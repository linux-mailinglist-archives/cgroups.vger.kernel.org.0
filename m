Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B7268A61
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgINL5P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 07:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgINLrm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 07:47:42 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2304BC061788
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 04:47:13 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k15so12390478pfc.12
        for <cgroups@vger.kernel.org>; Mon, 14 Sep 2020 04:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PJJFfsXoL3LK4g3p5cL7uzGgHtTaKv/IoQGqOUptDbk=;
        b=LMoGgSjo/62BmNodRWPJOdh8Q7bYP3tBTm1Td+5oc2sRIrUVS6tveSb3pEQ+9NoNMU
         fvMnZkauo2lzC5L+bKV27PfBYAsIAldo0wtm8s4znd1aebcNyMyCWGiEVYMzS7i8bWC3
         i5dCVawJOXVg0YuNR/pjmkLgZMz54RqOVNEjRHvNYTpRlpkeqQF5aqzg4ERgZBifoG7X
         Y4qo/2/M1Ntc37rVLnQVCJuTKcUnr510/+mScEEvSJgMPMtykWDAIAmOge68yAeSbERN
         Jd5kVxs3lzLjFhIpZv8gqRiaXIR76JQSY7fVL0Z5+xYW+LX8O5KnOC/FjhsrmMCyAqxz
         IeVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJJFfsXoL3LK4g3p5cL7uzGgHtTaKv/IoQGqOUptDbk=;
        b=oSrm5Z/9nEAX9VR1ZbHI8aACRdPDNncuJWr/rAuN2DJRXqoFt1xx+Z8ZUe9PsSG0Wl
         lXKiL5zkpUW3mds8hR/qlZit9qefuzUwAC1OOMXzvL04i4ZKM9rhSFzwvpJOgi/qI3LK
         MA9jKuIl5Gq6swGd2BCKx4ZtOeK/tGIN5ZbLRpVNzeU3XkIjRAayCOKo4fKLwNWNRqdG
         0MOlqZgOCp6gzCk2SFVvZvHTHWQCyBs9mI9R073SSa5+zjD7Kc63buacg7kWU/OQxY8r
         lUh/tyUsgtMRHBvzFLFV46aLX6Xe9gPB8RrOAEiKTZg6FnBKlunwX22pJA+N5XL+wtiL
         4j4w==
X-Gm-Message-State: AOAM531ckSetQoCcjEtkGPtRQJIZY7FY53K0VYFbLGhWMkuIeEXZTP7D
        oPhOqqebN2M2PP1vf2qtV2ukvfLUG6yGG41QTp0qvgYt/aNEhS8o
X-Google-Smtp-Source: ABdhPJyjND+eSy82UJKuklU4sT9+Zf+lGuuR32yG+mG5u1LFcj1veM/R7jIcv7XuT1WF8+Qc6dxq4dxdcJqRrMgZJGA=
X-Received: by 2002:a63:3047:: with SMTP id w68mr10335591pgw.341.1600084032707;
 Mon, 14 Sep 2020 04:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200912155100.25578-1-songmuchun@bytedance.com>
 <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
 <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
 <20200914091844.GE16999@dhcp22.suse.cz> <CAMZfGtXd3DNrW5BPjDosHsz-FUYACGZEOAfAYLwyHdRSpOsqhQ@mail.gmail.com>
 <20200914103205.GI16999@dhcp22.suse.cz>
In-Reply-To: <20200914103205.GI16999@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 19:46:36 +0800
Message-ID: <CAMZfGtWBSCFWw7QN66-ZLTb8oT7UALkyaGONjcjB93DyeeXXTA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 14, 2020 at 6:32 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 14-09-20 17:43:42, Muchun Song wrote:
> > On Mon, Sep 14, 2020 at 5:18 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 14-09-20 12:02:33, Muchun Song wrote:
> > > > On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> > > > >
> > > > > > The memory_stat_format() returns a format string, but the return buf
> > > > > > may not including the trailing '\0'. So the users may read the buf
> > > > > > out of bounds.
> > > > >
> > > > > That sounds serious.  Is a cc:stable appropriate?
> > > > >
> > > >
> > > > Yeah, I think we should cc:stable.
> > >
> > > Is this a real problem? The buffer should contain 36 lines which makes
> > > it more than 100B per line. I strongly suspect we are not able to use
> > > that storage up.
> >
> > Before memory_stat_format() return, we should call seq_buf_putc(&s, '\0').
> > Otherwise, the return buf string has no trailing null('\0'). But users treat buf
> > as a string(and read the string oob). It is wrong. Thanks.
>
> I am not sure I follow you. vsnprintf which is used by seq_printf will
> add \0 if there is a room for that. And I argue there is a lot of room
> in the buffer so a corner case where the buffer gets full doesn't happen
> with the current code.

Thanks for your explanation. Yeah, seq_printf will add \0 if there is a
room for that. So I agree with you that the "Fixes" tag is wrong. There
is nothing to fix. Sorry for the noise.

I think that if someone uses seq_buf_putc(maybe in the feature) at the
end of memory_stat_format(). It will break the rule and there is no \0.
So this patch can just make the code robust but need to change the
commit log and remove the Fixes tag.


> --
> Michal Hocko
> SUSE Labs



--
Yours,
Muchun
