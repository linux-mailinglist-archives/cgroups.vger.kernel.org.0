Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9534A3C9E
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 03:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357425AbiAaCyF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 21:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357427AbiAaCxr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 21:53:47 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFE4C061714
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 18:53:47 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id n32so11695022pfv.11
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 18:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6nez3pOZHeNZeiNmWCxSv7m+o4l1wZUkGv8l3sBghcI=;
        b=bl5s49Mf5Jo0PPhp/YsG2pTfX/cSkte5Lb2YhdUnfcNtzIDFxkyo9yob+m2iPtZt5l
         xv1Vy09vmGfTJgQMgshwZY6wjI8DTo9tDQAicdQ1O3Aqys0vTHUn6jxnEoqVLuU2iR4W
         zrtwNdfbEMlcxfBvB1g967RSxbAm1PeIBDoKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6nez3pOZHeNZeiNmWCxSv7m+o4l1wZUkGv8l3sBghcI=;
        b=gynY7Z4hjKjnabIJ7XIgpl9MyJrQrACiMv3ZSTFNyB2G+cEpBwGAZ5gTraway9nxfG
         o+qZ43/Txh58vWOEe2eozVsRrSHfD4Q3oAF7HQAdnDACR2pIQfvpZU0aSlbQ+ZB/PK5j
         OZJRby/fENneHQmUWmBaTZ3s4xAAJmxlYKzH/qTOrs2gujsT/nPIOCuNkaStpWVfaXUd
         6sERWk9kQOsC6AZNanXp856ec3HqPT96cj2iGB/mVzPg6RvHW8dQQAg4z9ridCZOzn99
         OOaugzRx59Xq2s5o37S+qawY3Tpv1bE8uyj1e9GHyDWGX6nhsuucwjYEVUeh3f/G4TtP
         Nb0w==
X-Gm-Message-State: AOAM532OaqM0GkqQEaKzXfKKUuSu2sYih9lHsGe9Ge2JPLjEDaN9CPWK
        vkaznluTrP/pRVjS7oKc+UuApw==
X-Google-Smtp-Source: ABdhPJzO+7lFn8ygZzzqkaFmFJWnpaPl2WneC2yR92lFloNUW2Ont7/aPnzolC2YcwGu0sJ4yGqn2g==
X-Received: by 2002:a63:2a92:: with SMTP id q140mr15200339pgq.379.1643597626524;
        Sun, 30 Jan 2022 18:53:46 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:c6d0:3c7:e220:605c])
        by smtp.gmail.com with ESMTPSA id y128sm17628695pfb.75.2022.01.30.18.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 18:53:45 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:53:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YfdPNPCjSZ5WI9+4@google.com>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129205315.478628-2-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (22/01/29 15:53), Waiman Long wrote:
> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>


> +++ b/lib/vsprintf.c
> @@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  {
>  	int i;
>  
> +	if (!size)
> +		return 0;
> +
>  	i = vsnprintf(buf, size, fmt, args);
>  
>  	if (likely(i < size))
>  		return i;
> -	if (size != 0)
> -		return size - 1;
> -	return 0;
> +
> +	return size - 1;
>  }
>  EXPORT_SYMBOL(vscnprintf);
