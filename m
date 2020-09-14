Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4E268359
	for <lists+cgroups@lfdr.de>; Mon, 14 Sep 2020 06:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINEDL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 14 Sep 2020 00:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgINEDJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 14 Sep 2020 00:03:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4628C06174A
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 21:03:09 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b124so11424950pfg.13
        for <cgroups@vger.kernel.org>; Sun, 13 Sep 2020 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWdl+yaQbYEtdR4On3P7CGGpC+OD3QLDLkmMq6+C9k0=;
        b=CqIfTLtozQ3xvA/KXFvjkKb1zYdS2iyiXoVFEvA0vmD2FVJ2slyMgvSYQ00c8x7ytj
         mx61VL523WNZigppR8w4h/OfvHx0V+eROTHrLyDK0xMG3Q16At3IMZVLEVrm6smf4LQj
         Hm2mKdquGXG4js/HGAiwxp+2xYuFK3YPdudZHFzhQszumUV3IJSRZXKjZiuVessize+V
         ceqaoE/OpxcPAb+ASWwOkBOjlZ2MFCpWp48AaphS6mTD39B20SZQ+OCgYZ6qytmaRPnu
         A2P4M7baDBpOgQzsToSWLad01UMxaRUgCxc8NUQeTxn+66zGl7EL2Ao3fNh+GKSwaLUX
         c4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWdl+yaQbYEtdR4On3P7CGGpC+OD3QLDLkmMq6+C9k0=;
        b=EzxmpKB5FYxXKmQgx4rM00Trs21RVFRa1r86yVn3DD18otHMpip69q7pIIINkuuBw1
         W4fZDZvSV7NFpjUcmrqCAqbyXKZAnxD0xcx3dZVue6VDwXEKCzbRUIH6GffQHLrjXFOk
         76DlGFO/Xl2XHb6Zf/NdLp2Om5uN0v65VJ7VAI6jQF35oGgIbTdSEuGpSEayDd9Lio2r
         PDN2rzsdgd72h96ZFtkZ3Np/otZACI+Rr2qJrtXkdGC+L8IKajc6v2RrZYMRDhcQC2zg
         FrddSqzsoTtuoTCT3jlA7+QkNQ/NasLAzgbaFqM/yB1hhQ4qWqZ9a1VJpThxS3ntyqQK
         hx4w==
X-Gm-Message-State: AOAM533a5YbZUqpC1eujIehfV7xBTTC8Pv+VpbSIOlsba73sTHXC32v8
        LOTIPzi6hhZrZnz44G/Q7y/cmn4DbpSuxfdJ8oBH3Q==
X-Google-Smtp-Source: ABdhPJwJ5ImAc3zR+/ovbzQJqIFTBNyvaOQXjxE6WDS4XTm9eE+0WpjDQqQFxAhAREZOjstjQnmqTWIg/GfIct7L4vs=
X-Received: by 2002:a17:902:a70e:b029:d1:9be4:b49c with SMTP id
 w14-20020a170902a70eb02900d19be4b49cmr13241634plq.20.1600056189287; Sun, 13
 Sep 2020 21:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200912155100.25578-1-songmuchun@bytedance.com> <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
In-Reply-To: <20200912174241.eeaa771755915f27babf9322@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 14 Sep 2020 12:02:33 +0800
Message-ID: <CAMZfGtXNg31+8QLbUMj7f61Yg1Jgt0rPB7VTDE7qoopGCANGjA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: memcontrol: Fix out-of-bounds on the
 buf returned by memory_stat_format
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Sep 13, 2020 at 8:42 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 12 Sep 2020 23:51:00 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > The memory_stat_format() returns a format string, but the return buf
> > may not including the trailing '\0'. So the users may read the buf
> > out of bounds.
>
> That sounds serious.  Is a cc:stable appropriate?
>

Yeah, I think we should cc:stable.

-- 
Yours,
Muchun
