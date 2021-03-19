Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70F73421AD
	for <lists+cgroups@lfdr.de>; Fri, 19 Mar 2021 17:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhCSQUq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Mar 2021 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbhCSQUl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Mar 2021 12:20:41 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF334C061760
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id m12so10867494lfq.10
        for <cgroups@vger.kernel.org>; Fri, 19 Mar 2021 09:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ABhrPzAtdhWSaCHAY3A5zu5xcg0uIN31nsx8czLOuLA=;
        b=nZc8gOjoMUSSwfSmGreBrhMExobRUEiMyrB+ufxf6snC18UHUFIZvEG3vZvpJL45Ee
         yDEC5aagO1+xQ9Vrb39wZwxtpTAy3P6N1sXos3/Q8j7YqkLCHBRd9VlCIxUoAGtTJldM
         cnHthANh/a/pPnmzkAjYYElBk6+bTmLG3wAxiJZTy2SyYeW8eKOgfRTX8T5liDKNkO7M
         9t/GEE5Eb6kcO70YmYHhS91PnvKTVyfB5vOVgv/Qw5DjJiR/9TS1cBgQXtwp3gU9HAld
         DC2gXySVATLhIF+L0dtZAKGQ6P9hM3qkjRSDwl52Zbze20y3u3f3ki8R/6CYQED9rX/d
         bamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ABhrPzAtdhWSaCHAY3A5zu5xcg0uIN31nsx8czLOuLA=;
        b=tvGs5nQ0MZBuW3XsrUJjb0zc6JhhVzQIRUmWPv/uslfJOMNmmBcY0GOhcb2SCxhHYW
         gTtqBipJotMW4pHDBgFtwDRUhKutLlDMTmEUJe8FVzbI2YsDhrk1o2GqJmS7utC+JuBC
         CxGZotHDsnmMWp2S7sj9puTnR3j51fCk8wx48jbJihi17woPkvANJkv+d5tplUWBUehh
         61+LoyISpyc+RTqBU2ETuS+dHYtHAFVJn1Tb57IMKpQIhoJk+vmGic8OeUrE7nJr5TQf
         GX1CmKj632VxYmt3IAy0BOPY2ySQL3FwppbBX7jS5vbREF5m+riXpbi8iOUoxzxuZAfi
         d+wQ==
X-Gm-Message-State: AOAM531T0F3x/vuTuUlFZOUCiWcLp38AH24lIUwzDswl8X0GIFRn6KPV
        49NaRTjgB2MrEKqkXCLTtuLX/ps04fnATvQhtdRkNw==
X-Google-Smtp-Source: ABdhPJxXpE+vp95qCI4rudYe5Bb8jNBHnrf2SQ1HmBFBpzNwDuFrFqe5vWyJN8iSECKBxa1EHhXynFCcniLz74oF9L4=
X-Received: by 2002:a19:f50e:: with SMTP id j14mr1266068lfb.299.1616170828550;
 Fri, 19 Mar 2021 09:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210316153655.500806-1-schatzberg.dan@gmail.com>
 <7ca79335-026f-2511-2b58-0e9f32caa063@kernel.dk> <CALvZod6tvrZ_sj=BnM4baQepexwvOPREx3qe5ZJrmqftrqwBEA@mail.gmail.com>
 <8c32421c-4bd8-ec46-f1d0-25996956f4da@kernel.dk> <20210318164625.1018062b042e540bd83bb08e@linux-foundation.org>
 <CALvZod6FMQQC17Zsu9xoKs=dFWaJdMC2Qk3YiDPUUQHx8teLYg@mail.gmail.com> <YFTIepcb+qm/+/9d@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
In-Reply-To: <YFTIepcb+qm/+/9d@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 19 Mar 2021 09:20:16 -0700
Message-ID: <CALvZod7TyCb1c9iPYmf4aGiCgcb9fboRDXiChaYDCBQHii+J7A@mail.gmail.com>
Subject: Re: [PATCH v10 0/3] Charge loop device i/o to issuing cgroup
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Mar 19, 2021 at 8:51 AM Dan Schatzberg <schatzberg.dan@gmail.com> wrote:
>
> On Thu, Mar 18, 2021 at 05:56:28PM -0700, Shakeel Butt wrote:
> >
> > We need something similar for mem_cgroup_swapin_charge_page() as well.
> >
> > It is better to take this series in mm tree and Jens is ok with that [1].
> >
> > [1] https://lore.kernel.org/linux-next/4fea89a5-0e18-0791-18a8-4c5907b0d2c4@kernel.dk/
>
> It sounds like there are no concerns about the loop-related work in
> the patch series. I'll rebase on the mm tree and resubmit.

One suggestion would be to make get_mem_cgroup_from_mm() more generic
(i.e. handle !mm && active_memcg() case) and avoid
get_mem_cgroup_from_current() as it might go away.
