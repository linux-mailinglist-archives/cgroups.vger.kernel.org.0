Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2DFDFEAF4
	for <lists+cgroups@lfdr.de>; Sat, 16 Nov 2019 07:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfKPGbe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 16 Nov 2019 01:31:34 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37667 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKPGbe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 16 Nov 2019 01:31:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id d5so9994666otp.4
        for <cgroups@vger.kernel.org>; Fri, 15 Nov 2019 22:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mpODNTcWa+A401urYWGM84SXXQR7l3TKPlFdQmVBzs0=;
        b=gF5tsuVznJqnYWo56MgDxdPAGHHFgIvh1vwSch7ES7KJAJagvN85gQi55vmuMMjr8g
         fAl9TmJtGOhmH9KI53u2YV33HKDJ8GTzQJbR3olwc6IyhHVNXyxed7HTw3rcbH4O5lXg
         DFBWyLdLVZMA+dXLRbjIYwehUYEqK7HGAZdwGwaXyMuFMJEDQbOtHMaVrIC4JoOFEdrD
         FtnKLpPZy5bsGy7UUfNuL1Tdyd/MRvKuAOQJSQIf8kI9Mmr9deFM9R29KE4nATXS8TTA
         T9Afm2+ns3B0dWXdhrrPyZZ0VPSd/wl9QL8b4RH2Lv7wLMh5fKb1HP5Vpcak//Q3Ps9F
         jZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpODNTcWa+A401urYWGM84SXXQR7l3TKPlFdQmVBzs0=;
        b=LRHnkIgBszd1/EZQq5/GKsFOLFJJECDwH1rRtDITSTZ1laLsQiEHXuVoRUrdcZEwAO
         c+E6zc9n7nI3Hg6uuk+4SM/3rtCexE4Dx89rPokwPK2mJ04KN9HlLjRzAt6g/GcwNTS5
         ePLZJHdQqHBWJ2xKRITwgyhL02ou4QefUMMFfZrPP4DCETC5eidpAu5qSyGFgbXPhwpb
         k5iZtQcf9RYaG3TOyQhFNSKSIE1CPniahFdb2K2oHelxuxIozuXz3E8bJ8lXnc4KGF+2
         FAwiW6thqsdcktSuL2SuN8D3kFri/64HmHxueKJZqM8WX3PGEmKPhQy2cwqPMnyUxR8K
         drjA==
X-Gm-Message-State: APjAAAWMJkgCiILlhoExbkFnYFDiYD+RZuP4dYuvqNN6HjjSO+Ip0z6B
        dSlwsGlhWakoXppBOKLKHBXCjSAB/gdW7FBDzcy+iA==
X-Google-Smtp-Source: APXvYqy+ZtE/c62xax1ax1pMapTf40gQj6BeNbMWYRA6Pe8p/qNZ7oGWKtS/5hg4q9wMQECRwkR+6tYjUMuHgQwxl6I=
X-Received: by 2002:a9d:400d:: with SMTP id m13mr13658836ote.360.1573885893136;
 Fri, 15 Nov 2019 22:31:33 -0800 (PST)
MIME-Version: 1.0
References: <1573874106-23802-1-git-send-email-alex.shi@linux.alibaba.com> <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1573874106-23802-3-git-send-email-alex.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 Nov 2019 22:31:22 -0800
Message-ID: <CALvZod5xuetOb8Vunhgjp69-HcrnHgGHZKKyjVBo3tmoc3WqaA@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/lruvec: add irqsave flags into lruvec struct
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Arun KS <arunks@codeaurora.org>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Nov 15, 2019 at 7:15 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> We need a irqflags vaiable to save state when do irqsave action, declare
> it here would make code more clear/clean.
>
> Rong Chen <rong.a.chen@intel.com> reported the 'irqflags' variable need
> move to the tail of lruvec struct otherwise it causes 18% regressions of
> vm-scalability testing on his machine. So add the flags and lru_lock to
> both near struct tail, even I have no clue of this perf losing.

Regressions compared to what? Also no need to have a separate patch.

>
> Originally-from: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> CC: Rong Chen <rong.a.chen@intel.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/mmzone.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index a13b8a602ee5..9b8b8daf4e03 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -269,6 +269,8 @@ struct lruvec {
>         unsigned long                   flags;
>         /* per lruvec lru_lock for memcg */
>         spinlock_t                      lru_lock;
> +       /* flags for irqsave */
> +       unsigned long                   irqflags;
>  #ifdef CONFIG_MEMCG
>         struct pglist_data *pgdat;
>  #endif
> --
> 1.8.3.1
>
