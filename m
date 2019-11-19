Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35B5102846
	for <lists+cgroups@lfdr.de>; Tue, 19 Nov 2019 16:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfKSPll (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 Nov 2019 10:41:41 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39893 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfKSPll (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 Nov 2019 10:41:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id 15so18180291qkh.6
        for <cgroups@vger.kernel.org>; Tue, 19 Nov 2019 07:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=s1bq7+cOv9v3qwlU6gAe5f/6wD81CFSArjCOgnPV2zo=;
        b=yB8b7itby2xJJEdH7wfhMdISJn7yj0OPf6+/xk6WSX8SqbJPJt+sq4eFvNicdyug6m
         TM2uLIeizmWzrpI6V0peXhVjzQEJuS8YApUE1CENkFwRuBJjQfmghRJveMDzA/KqqV1L
         P1/MOVjxZ9JOA9tuCi5XyR9gWzEaP8OmU+0WyIkppFH5fM088hQekVTHL7Rm7mPJUbiK
         IsmlHQ2g1cao+y/FNhK3v+EXNkCUxjFCO2U00x37INvJX7zK6gyEONARrOtFM0zOdtiS
         eo9EVWFsFYBMjaIrTgVGRonvwE3m8ZRtTTSF+eKPMtPX1yRk+Zwak6B3Ms5MBtmMvqX3
         Fn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=s1bq7+cOv9v3qwlU6gAe5f/6wD81CFSArjCOgnPV2zo=;
        b=NgUivt8gQQxVEPrAE/icDTN3HoDxL7YE6ALX2aB49ZvfqDhBK9jeIVwqWl0S5oAR9O
         V9BK5oV04fKGs6XvebKiPLi/qlqx94v/9A32x5YnUklQ4mR4lQgRPbc70Gx7d27jPlMu
         YN4s7iuMsFCu3K5KryLKgC7cd2ZLtk7M/ii57Km+kkaT9SEuQSpPnaGZ77w9jb0teOAg
         bflQsVnJNxmzee86Lz8PNU5oFmvK2LK9yVqnZa4gboqs/z0CLN6VEqa9yppJfjJ3m/0e
         ZskUfYiaiSaFKoU/TGVXKxNLcriMIeSuDdtiTTXxTYMLepnceeDkhkAx7hye2wXiePrh
         fgGw==
X-Gm-Message-State: APjAAAVtszBW33AVZ23UookICCDcshhTSsIVLWcC2Xxzzg/35hSDNmJO
        nSA+7jdH05N3QpjRZWUp5siySw==
X-Google-Smtp-Source: APXvYqwMzPNv93VY69VMBP223fZwyRZfzHLPwfj61+hK5jVyx6O0vjaMFg7nJsTeal375kEVpuotaw==
X-Received: by 2002:a37:a010:: with SMTP id j16mr17267203qke.84.1574178100040;
        Tue, 19 Nov 2019 07:41:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::c7ac])
        by smtp.gmail.com with ESMTPSA id 7sm10611517qkf.67.2019.11.19.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:41:39 -0800 (PST)
Date:   Tue, 19 Nov 2019 10:41:38 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        shakeelb@google.com
Subject: Re: [PATCH v4 1/9] mm/swap: fix uninitialized compiler warning
Message-ID: <20191119154138.GB382712@cmpxchg.org>
References: <1574166203-151975-1-git-send-email-alex.shi@linux.alibaba.com>
 <1574166203-151975-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1574166203-151975-2-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 19, 2019 at 08:23:15PM +0800, Alex Shi wrote:
>   ../mm/swap.c: In function ‘__page_cache_release’:
>   ../mm/swap.c:67:10: warning: ‘flags’ may be used uninitialized in this
>   function [-Wmaybe-uninitialized]
>        lruvec = lock_page_lruvec_irqsave(page, pgdat, flags);
>        ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

At this point in the series, there is no lock_page_lruvec_irqsave()
yet, so this patch is out of order. Please don't do that. It's very
hard to review patches that depend on later changes to make sense.

> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/swap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/swap.c b/mm/swap.c
> index 5341ae93861f..c36a10244d07 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -62,7 +62,7 @@ static void __page_cache_release(struct page *page)
>  	if (PageLRU(page)) {
>  		pg_data_t *pgdat = page_pgdat(page);
>  		struct lruvec *lruvec;
> -		unsigned long flags;
> +		unsigned long flags = 0;

Use unintialized_var() for these cases to make the intent clear.
