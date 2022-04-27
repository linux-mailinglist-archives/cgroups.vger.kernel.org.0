Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7105123EB
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 22:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiD0Uc6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 16:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiD0Ucv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 16:32:51 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B99B3C64;
        Wed, 27 Apr 2022 13:29:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso2625438pjj.2;
        Wed, 27 Apr 2022 13:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KjZdJc+2UDuaCV9hUSLVuNI4CiOYxCjI+J/98h/W9G4=;
        b=Tac3djEA5bXqIgvvbxyz8RUsVLAM/lkHxNcYv/gitY3QhUpuLEKTucRMeN/6RsXCGY
         o+ND4wPwR7gIoVajI8XzV34aqcMZYBllRJa5CVXDwBN9THDIzgLL7016DHdilf1gzjMz
         JBJSBtSylrg2tT/vIHuAsyDgpuPlKRq43zYsflK5fOqXp1BiJE+1A1+Mu1h/oSLoWtio
         2hWay8lfn1y8G5t3h/vJ5ZSoxP6MHkL/FCYcr4gUwQao3/hJOqIu6jF52DW8/vVqxW3u
         bDaHlEKJ801uxbQhxfssVyszMyKhnTbbk9wfJf/4+AJLMyhhD4fHNXagJ1XlR7rrf97D
         RTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KjZdJc+2UDuaCV9hUSLVuNI4CiOYxCjI+J/98h/W9G4=;
        b=cjlEFzImAA2EokWTsrZrAem+a7CHdifIXfkR/D6xu4KlK/LJBkaQU11ky4cOWN6vi3
         zrG72BeD/bRSjqThc2Jkc1IogATS9b03PnDwhdXd2S0IQQkdtVVhRgzPkoboYx7W/fJr
         81VKj1M2GnwVS+Zly8pppoEsZiJ8b17830m/UjsPcglcesn9mgCiz0+J9++loZEfomc7
         4nsrtH1XYTb2RhThQ6JU/iS/Ql21WQNPMPBu7+NcdhhJ3cYp4PmUB9CZnH0FFBeQdywW
         QyP26Ptjeq8moDg5yYv4W4EgqDy6/07nPcSKUsoPEX50LW4nwAslfqEmbftU8AD1lGfi
         TQ6w==
X-Gm-Message-State: AOAM530Jb3Nh8z0EDMuubt1FyNxHKGRE/btE52wkP0Ynp1Egw7LXpzSr
        4Z9qVKtVs6/BiMkNtJ04H0w=
X-Google-Smtp-Source: ABdhPJznOXxFH5HHWoubJvtIMRhCBLHqEyqk7PM/z3PtAH8Xc0e4aUUlIjaIlnJushp4AkaYzDUCIA==
X-Received: by 2002:a17:903:2285:b0:15b:cd9e:f018 with SMTP id b5-20020a170903228500b0015bcd9ef018mr29018515plh.106.1651091376925;
        Wed, 27 Apr 2022 13:29:36 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:546a:2875:2a75:1b94])
        by smtp.gmail.com with ESMTPSA id p27-20020a056a000a1b00b004f3f63e3cf2sm22917044pfh.58.2022.04.27.13.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 13:29:36 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 27 Apr 2022 13:29:34 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <Ymmnrkn0mSWcuvmH@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427160016.144237-5-hannes@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes,

On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> Currently it requires poking at debugfs to figure out the size and
> population of the zswap cache on a host. There are no counters for
> reads and writes against the cache. As a result, it's difficult to
> understand zswap behavior on production systems.
> 
> Print zswap memory consumption and how many pages are zswapped out in
> /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  fs/proc/meminfo.c             |  7 +++++++
>  include/linux/swap.h          |  5 +++++
>  include/linux/vm_event_item.h |  4 ++++
>  mm/vmstat.c                   |  4 ++++
>  mm/zswap.c                    | 13 ++++++-------
>  5 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6fa761c9cc78..6e89f0e2fd20 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  
>  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
>  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> +#ifdef CONFIG_ZSWAP
> +	seq_printf(m,  "Zswap:          %8lu kB\n",
> +		   (unsigned long)(zswap_pool_total_size >> 10));
> +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> +		   (PAGE_SHIFT - 10));
> +#endif

I agree it would be very handy to have the memory consumption in meminfo

https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/

If we really go this Zswap only metric instead of general term
"Compressed", I'd like to post maybe "Zram:" with same reason
in this patchset. Do you think that's better idea instead of
introducing general term like "Compressed:" or something else?
