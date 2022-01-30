Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0594A4A3975
	for <lists+cgroups@lfdr.de>; Sun, 30 Jan 2022 21:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbiA3Utj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 30 Jan 2022 15:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347586AbiA3Utj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 30 Jan 2022 15:49:39 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C82C061714
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 12:49:39 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l13so2095628plg.9
        for <cgroups@vger.kernel.org>; Sun, 30 Jan 2022 12:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aE3FiEfD4YX71c3f0yLgS/uNySrINu0tsaBgzhna2ek=;
        b=Zjc4YSbGgk5QwhyB+a51LM72RbO00quYJOUYe1md1PNeyr/pecUXyZy7c65ujwauiA
         CUXD+drBbDEDTaQ4MV92WmTsZfC1dJ8T8yrwIOweCjuFhprfvSu8cEBcojLm4+52bSK3
         hjteoxIHrZN7kcEWFRqyz9jfr3ZIvCrsWiL8+zSAtgeBonKZzynzshN8x3jZCgWYXTsy
         f3jg0rnNBNZh7xLjmAYXc8WSRADrZEQTFdN0a9S1En9/RjEz98r1OKDSxZdZ6AS+ctMq
         EcyxQCOAQSj95T6quv5E/UQAfAfzA+PKBTErMyBRTY9t23qn6560MJ0PuKndvNAQsRY3
         qj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aE3FiEfD4YX71c3f0yLgS/uNySrINu0tsaBgzhna2ek=;
        b=vfA6S1XGE2pw5LIi+B/ZVdm6Q3JoyaOYn900P9RKM0Kw8n9s30SERARSRSua7kePm0
         D6psRgcQxXSkhXngtR28zgRY5Koms0nVsLMClTrd1xl5uYkboWR9We5sfkOHcLcSePHS
         +ayht0XhfCoelDmSVkNWSUOGtySxiFVqhOUWNOAEoXSsxDnMyeABc2q1wyeABVGx571h
         xsxEDUJ2CCfFtl0h+K5qBpirxKOBHxVIlmxHvF1jrFxGgypYAT7knn6snl4Yi1Rw0Att
         wQnAJ+zM3pkvbCvrH+uAX8sBAV7npgv1Y6hE2yFAEzGKp+2sSINldM571xz5QFQ83P+k
         qrAg==
X-Gm-Message-State: AOAM531Sr6w+V3mt6J6nueAN6bkYMgUZ9mtzgYR7kjQdcYw9NgtsvR0A
        SZOTGWXl8s9jxcFHlUvvF4Wr0A==
X-Google-Smtp-Source: ABdhPJzknUBOF48IkBEUpy+P7QTvqoIlz5pQ0VVuk6JLHYZn5+JJKai/TswjaJ3CjRFcvKy4MFgcBw==
X-Received: by 2002:a17:90a:8592:: with SMTP id m18mr21353483pjn.142.1643575778465;
        Sun, 30 Jan 2022 12:49:38 -0800 (PST)
Received: from [2620:15c:29:204:2b97:ce13:593d:973d] ([2620:15c:29:204:2b97:ce13:593d:973d])
        by smtp.gmail.com with ESMTPSA id f64sm12998472pfa.165.2022.01.30.12.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:49:38 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:49:37 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Waiman Long <longman@redhat.com>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
In-Reply-To: <20220129205315.478628-2-longman@redhat.com>
Message-ID: <d99b3c4b-7b6e-529-6e4b-b91b65c92d81@google.com>
References: <20220129205315.478628-1-longman@redhat.com> <20220129205315.478628-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 29 Jan 2022, Waiman Long wrote:

> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  lib/vsprintf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b8129dd374c..a65df546fb06 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  {
>  	int i;
>  
> +	if (!size)
> +		return 0;

Nit: any reason this shouldn't be unlikely()?  If the conditional for 
i < size is likely(), this seems assumed already?

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
>  
> -- 
> 2.27.0
> 
> 
> 
