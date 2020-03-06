Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A679F17B5DC
	for <lists+cgroups@lfdr.de>; Fri,  6 Mar 2020 05:54:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFEyv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Mar 2020 23:54:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38514 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFEyv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Mar 2020 23:54:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id x75so1335031oix.5
        for <cgroups@vger.kernel.org>; Thu, 05 Mar 2020 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MpUAWMUZ0nsUfjEg79z9N04zH9L3RObZfUg0695PRvk=;
        b=PThzNVAb6Nb1Dfs+tTbDHirwjN0U1rIcenmtDKH0p7vqy2XWlgokbVbIYqRGQWFwQX
         wwtqxkSLN5LqkNYuJQRcOhRxIMHGiB52X8885xTN1Myga1uwq+A3689vLEHE1jTa9yvt
         7p3DuEO/yvgD5KYCwWVI26lI8BEi7fd4TcJ6H66rZmbwyUyFA4HwuceyNgXIqEhNftSH
         j7M3EqnuUOqbrpoAG/FjA5ik4f0oHTQaSJU1TUGatZqv6BXBcRSbZTf7geDYUr6yKBLM
         7PQ1WOzT/U618Jey0i7perutOpaK+eqOQK48LGrLLzqKLr264H8nNi2YvS2phDsTB20r
         4yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpUAWMUZ0nsUfjEg79z9N04zH9L3RObZfUg0695PRvk=;
        b=GfjymIbmMttBadAMr8BejMTqXiPgPwH0G3AfBBaKNzaqzzfmpzU5gEKCgd9hPJyu/b
         osqUJgYHmjvevo85+C5wb6F3w3ZL6miKkBZzADY/P3+AOTTQAjgrKnriB1Rn8xrQsFWw
         TbhVg3gf6RnoMi06Lu2kwekR72pWhykl6pSWVS3wbdbwQESf5mDbzlcEX3jE5tecJxR3
         Ip9/d4+y7ur2sfDWS6aIdb1cLoGVR8GZU38gmHyN90R3LFcanMKhBpUvZoc6H49QFaBs
         mID+iVaZ0BCFR8aAMH+YkO1pdn7bXSJY+clPwc8MWFmqjgK1SuSRNrR3BozZUISqtw7J
         ZZnQ==
X-Gm-Message-State: ANhLgQ3grU4nc2AUrNzkVHph6r2/zjbGVAaMTNfU5Qfi037TcgH9Yj8K
        HVOkCZvM1Mq7fApKHp5FzWRzjMPTN8to65Bxhx/viD8F
X-Google-Smtp-Source: ADFU+vtNxEjhXH7+aG4thzPjJN/ZYpMvSrgzN5M2VSoSCqw6I671cwU1GUgJpvbLweYoi5YLQXLi2l+PSLl10Zyutrg=
X-Received: by 2002:aca:52c7:: with SMTP id g190mr1323278oib.144.1583470490279;
 Thu, 05 Mar 2020 20:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20200304022058.248270-1-shakeelb@google.com> <20200305204109.be23f5053e2368d3b8ccaa06@linux-foundation.org>
In-Reply-To: <20200305204109.be23f5053e2368d3b8ccaa06@linux-foundation.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 Mar 2020 20:54:39 -0800
Message-ID: <CALvZod7W-Qwa4BRKW0_Ts5f68fwkcqD72SF_4NqZRgEMgA_1-g@mail.gmail.com>
Subject: Re: [PATCH] memcg: optimize memory.numa_stat like memory.stat
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 5, 2020 at 8:41 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue,  3 Mar 2020 18:20:58 -0800 Shakeel Butt <shakeelb@google.com> wrote:
>
> > Currently reading memory.numa_stat traverses the underlying memcg tree
> > multiple times to accumulate the stats to present the hierarchical view
> > of the memcg tree. However the kernel already maintains the hierarchical
> > view of the stats and use it in memory.stat. Just use the same mechanism
> > in memory.numa_stat as well.
> >
> > I ran a simple benchmark which reads root_mem_cgroup's memory.numa_stat
> > file in the presense of 10000 memcgs. The results are:
> >
> > Without the patch:
> > $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> >
> > real    0m0.700s
> > user    0m0.001s
> > sys     0m0.697s
> >
> > With the patch:
> > $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> >
> > real    0m0.001s
> > user    0m0.001s
> > sys     0m0.000s
> >
>
> Can't you do better than that ;)
>
> >
> > +     page_state = tree ? lruvec_page_state : lruvec_page_state_local;
> > ...
> >
> > +     page_state = tree ? memcg_page_state : memcg_page_state_local;
> >
>
> All four of these functions are inlined.  Taking their address in this
> fashion will force the compiler to generate out-of-line copies.
>
> If we do it the uglier-and-maybe-a-bit-slower way:
>
> --- a/mm/memcontrol.c~memcg-optimize-memorynuma_stat-like-memorystat-fix
> +++ a/mm/memcontrol.c
> @@ -3658,17 +3658,16 @@ static unsigned long mem_cgroup_node_nr_
>         struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>         unsigned long nr = 0;
>         enum lru_list lru;
> -       unsigned long (*page_state)(struct lruvec *lruvec,
> -                                   enum node_stat_item idx);
>
>         VM_BUG_ON((unsigned)nid >= nr_node_ids);
>
> -       page_state = tree ? lruvec_page_state : lruvec_page_state_local;
> -
>         for_each_lru(lru) {
>                 if (!(BIT(lru) & lru_mask))
>                         continue;
> -               nr += page_state(lruvec, NR_LRU_BASE + lru);
> +               if (tree)
> +                       nr += lruvec_page_state(lruvec, NR_LRU_BASE + lru);
> +               else
> +                       nr += lruvec_page_state_local(lruvec, NR_LRU_BASE + lru);
>         }
>         return nr;
>  }
> @@ -3679,14 +3678,14 @@ static unsigned long mem_cgroup_nr_lru_p
>  {
>         unsigned long nr = 0;
>         enum lru_list lru;
> -       unsigned long (*page_state)(struct mem_cgroup *memcg, int idx);
> -
> -       page_state = tree ? memcg_page_state : memcg_page_state_local;
>
>         for_each_lru(lru) {
>                 if (!(BIT(lru) & lru_mask))
>                         continue;
> -               nr += page_state(memcg, NR_LRU_BASE + lru);
> +               if (tree)
> +                       nr += memcg_page_state(memcg, NR_LRU_BASE + lru);
> +               else
> +                       nr += memcg_page_state_local(memcg, NR_LRU_BASE + lru);
>         }
>         return nr;
>  }
>
> Then we get:
>
>                      text    data     bss     dec     hex filename
> now:               106705   35641    1024  143370   2300a mm/memcontrol.o
> shakeel:           107111   35657    1024  143792   231b0 mm/memcontrol.o
> shakeel+the-above: 106805   35657    1024  143486   2307e mm/memcontrol.o
>
> Which do we prefer?  The 100-byte patch or the 406-byte patch?

I would go with the 100-byte one. The for-loop is just 5 iteration, so
doing a check in each iteration should not be an issue.

Shakeel
