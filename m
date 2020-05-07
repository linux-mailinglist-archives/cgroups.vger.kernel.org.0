Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343B11C96CC
	for <lists+cgroups@lfdr.de>; Thu,  7 May 2020 18:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEGQrD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 May 2020 12:47:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35802 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEGQrC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 May 2020 12:47:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id r26so7628844wmh.0;
        Thu, 07 May 2020 09:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EIgmxX814C2jT2rV+jySB1AamDNAJaeVnCN6Yqs05Yc=;
        b=Xef9qLQjR2f/kicB9gNJl7Eej+C7MRdgXG2das2uFdQx/D30LcYEg1afokNFfdRhev
         QuJq3i2XC7Udf7KH4wCIG6AgZ2tIXXPAbig2bpvhbHsB+m0vuhyy1Mmstl15r5JW/pCI
         gsPSoZrgAJiGjGlHrxVI5A8FwbCqGH1dc5c4CibhT/topZJfPsCoytqAcXUVVdqhVueO
         g++JNmVKZvPw3PHlR+uPWTEq/vBRiPnySxOMkDZQBrE7l//JF3fLCuVVPVrQi4bwlxPa
         owGOJeq1ltuQkQMet2JORaDA6cBNobgOcVm2OcJppbUypDcC0sw4CNsn6ecx4EBX/R+l
         VfDw==
X-Gm-Message-State: AGi0PuZmeZ+u1p1LDiwv4Ken/9QZNN+TMdgWdLZGBAmvyEoaGLBC9kKk
        38UV8zoCWuMWxYpWzIoDHTw=
X-Google-Smtp-Source: APiQypIRx74HYY9YS+imm0npI96iz1lm4ynkT4c22/lcqv53j+jdbFjzODq4YvtVDcRdtqQ+RrqWeQ==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr11315095wmh.93.1588870020627;
        Thu, 07 May 2020 09:47:00 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id q2sm3554922wrm.42.2020.05.07.09.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:46:59 -0700 (PDT)
Date:   Thu, 7 May 2020 18:46:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
Message-ID: <20200507164653.GM6345@dhcp22.suse.cz>
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
> +			if (page_counter_read(&memcg->memory) <=
> +			    READ_ONCE(memcg->high))
> +				break;

I am half way to a long weekend so bear with me. Shouldn't this be continue? The
parent memcg might be still in excess even the child got reclaimed,
right?

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
