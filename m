Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C07217D0FE
	for <lists+cgroups@lfdr.de>; Sun,  8 Mar 2020 04:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgCHDS3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 7 Mar 2020 22:18:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53506 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgCHDS3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 7 Mar 2020 22:18:29 -0500
Received: by mail-pj1-f65.google.com with SMTP id l36so57689pjb.3;
        Sat, 07 Mar 2020 19:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YlUcTsthp1jT+o6f6NANQqT+eCJYTM4ae8wXuy/WzUk=;
        b=ECVc7jtBxuJMkBzqO7pgWcK0ajgrKB9b5cqpx18D9ofoE0+Ficc+pZhn2tDmOBGhHm
         ZVhdh2zoNOCi88ZF9Mo22agCA8qknCa0WBHft1UVXwcWfauUh7NKOp6/I5N8oDqe+IbM
         T7U3/kZubkFdMqZAAwtAY5bGj+38XnBreO/uZR1DDtlVYO46n0vozBkYqPVjnpvuDFV7
         FLmKwafHM6gwYy3cQh4knRZVbDOWjPm2cuJUqwGUu1YiWDW+25SfuU+PnbXmL9ww3DQs
         vqmQJseyhqZ0wb56pQn33955HJBES20I2ZeOIVlmKIWrxHBLCqBE8k8kTO8hR10uL4lq
         Stdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YlUcTsthp1jT+o6f6NANQqT+eCJYTM4ae8wXuy/WzUk=;
        b=T/N+6LEav6EbjZ56CCqy0sGL2V9suvQLWaODb34GdCJwIuNQHjbQ2iRPyOt90K7u6P
         sZHvg05uKG16gx78HuuGe/5a6wDYpV1r1Q8YHlBgPVlSFAm9inR+TE60WQDtCuwmvn47
         4UEouP+OSC72EGsyqy/9zvjt0L5KOHuAwsXBqHDgb3sCbXknjiaPecQsySCT8V08TY88
         ypVcQu1RQGl9nYnUGNQs9WMSSRGb0BTJIdCdfXuupC30QKGa3ienOXwwkeD0QDoHKoSk
         GVuLRHUJ09vQEIns+MGcdD7ZflxxZT5yHuXWl0BMf26LZ/uxQ+Kgpx2nBtZt4CTKxI0K
         yf6A==
X-Gm-Message-State: ANhLgQ0ltvJ9OTMPKMJoAAgiFQq7l4As3065LecA0JMCOksgm5fXg1Oq
        P/lw9sd9U0jEvWahalWlU2E=
X-Google-Smtp-Source: ADFU+vsTZipAN3SvKwN7VtGyO9BLqotNK0eK1y6C+EGAAdE5g2COWd703JhBPJtBCcVT1Sl0cyqrxw==
X-Received: by 2002:a17:90b:3542:: with SMTP id lt2mr10788454pjb.96.1583637508436;
        Sat, 07 Mar 2020 19:18:28 -0800 (PST)
Received: from localhost (194.99.30.125.dy.iij4u.or.jp. [125.30.99.194])
        by smtp.gmail.com with ESMTPSA id 186sm26726915pfz.145.2020.03.07.19.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 19:18:27 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sun, 8 Mar 2020 12:18:25 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: Use fallthrough;
Message-ID: <20200308031825.GB1125@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On (20/03/06 23:58), Joe Perches wrote:
[..]
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
>  
>  	switch (p->mode) {
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		*nodes = p->v.nodes;
>  		break;
> @@ -2092,7 +2091,6 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
>  		break;
>  
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		*mask =  mempolicy->v.nodes;
>  		break;
> @@ -2359,7 +2357,6 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
>  
>  	switch (a->mode) {
>  	case MPOL_BIND:
> -		/* Fall through */
>  	case MPOL_INTERLEAVE:
>  		return !!nodes_equal(a->v.nodes, b->v.nodes);
>  	case MPOL_PREFERRED:

Ditto. This doesn't convert /* Fall through */ to fallthrough;

	-ss
