Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B21CD5DD
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 12:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEKKHR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 06:07:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53179 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbgEKKHQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 06:07:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id m24so7798556wml.2;
        Mon, 11 May 2020 03:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oS9WtyDRHWlRdyoRSU0/FnBNR13KjsZKG7jcHWkqIkU=;
        b=kzBH7J9I+upt8FssoC3ZSQM4NFOEi8mu3424YSoV33W2GGCCFW2Mix17HYF31VWdR3
         hU5xHaM5+rlHOt5mY/OW52RkbsjOC5zsDq0NoYxko4YxQvYtH3ckS0jZweKX1C1zCwoJ
         nXiZqKmqiEM5DiN+pbRDD/IUWInMRQLqiKXbczHzGMR9YCGoqlC0o5F88vRNVjhRUhyr
         rhZHfjP1jokvrin8AZ+/ldWX/CwXLvCgz5NMyPqPbVCgSQxQNXNLBmc7CTg+hRyTMeV2
         z2x6mT0JOdBHHDisFJlsZCbZSKlyIYFqWVTHI30f3aSfrxKicWOjvytpV0GtjxMnTkwo
         xGDg==
X-Gm-Message-State: AGi0Pua42W94lg4cIhlaUxaY460Lfesf5ndF8hRFEVOmt+e4WERxISA5
        z4+KB0+qyA+zRd3o4S0rjDA=
X-Google-Smtp-Source: APiQypJkwSIKemO65K6ZcN6yWG6sAWj3mdwEhFrdCFM8763O2S3TjPOdJ0Xitr7mhqHPujXKMLw3dg==
X-Received: by 2002:a7b:c0cb:: with SMTP id s11mr33139486wmh.180.1589191633454;
        Mon, 11 May 2020 03:07:13 -0700 (PDT)
Received: from localhost (ip-37-188-228-19.eurotel.cz. [37.188.228.19])
        by smtp.gmail.com with ESMTPSA id m18sm10287104wru.78.2020.05.11.03.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 03:07:12 -0700 (PDT)
Date:   Mon, 11 May 2020 12:07:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
Message-ID: <20200511100711.GD29153@dhcp22.suse.cz>
References: <20200507163301.229070-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507163301.229070-1-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 07-05-20 09:33:01, Shakeel Butt wrote:
> Currently the reclaim of excessive usage over memory.high is scheduled
> to run on returning to the userland. The main reason behind this
> approach was simplicity i.e. always reclaim with GFP_KERNEL context.
> However the underlying assumptions behind this approach are: the current
> task shares the memcg hierarchy with the given memcg and the memcg of
> the current task most probably will not change on return to userland.
> 
> With the remote charging, the first assumption breaks and it allows the
> usage to grow way beyond the memory.high as the reclaim and the
> throttling becomes ineffective.
> 
> This patch forces the synchronous reclaim and potentially throttling for
> the callers with context that allows blocking. For unblockable callers
> or whose synch high reclaim is still not successful, a high reclaim is
> scheduled either to return-to-userland if current task shares the
> hierarchy with the given memcg or to system work queue.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Michal Hocko <mhocko@suse.com>

I would just make the early break a bit more clear.

[...]
> @@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  				schedule_work(&memcg->high_work);
>  				break;
>  			}
> -			current->memcg_nr_pages_over_high += batch;
> -			set_notify_resume(current);
> +
> +			if (gfpflags_allow_blocking(gfp_mask))
> +				reclaim_over_high(memcg, gfp_mask, batch);
> +

			/*
			 * reclaim_over_high reclaims parents up the
			 * hierarchy so we can break out early here.
			 */
> +			if (page_counter_read(&memcg->memory) <=
> +			    READ_ONCE(memcg->high))
> +				break;
> +			/*
> +			 * The above reclaim might not be able to do much. Punt
> +			 * the high reclaim to return to userland if the current
> +			 * task shares the hierarchy.
> +			 */
> +			if (current->mm && mm_match_cgroup(current->mm, memcg)) {
> +				current->memcg_nr_pages_over_high += batch;
> +				set_notify_resume(current);
> +			} else
> +				schedule_work(&memcg->high_work);
>  			break;
>  		}
>  	} while ((memcg = parent_mem_cgroup(memcg)));
> -- 
> 2.26.2.526.g744177e7f7-goog
> 

-- 
Michal Hocko
SUSE Labs
