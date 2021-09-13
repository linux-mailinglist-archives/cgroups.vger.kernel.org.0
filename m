Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B119D409BB7
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhIMSHO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbhIMSHN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Sep 2021 14:07:13 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A8C061574;
        Mon, 13 Sep 2021 11:05:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so49103pjc.3;
        Mon, 13 Sep 2021 11:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lTZVobgM/3IcweDVBRrPU9HP9E4rGk6Uc/SK3CeJgbs=;
        b=hz+MNqFoGnCqooN4pC0ZNqbr8/ZDMZ29FkRELhIRuC5hKGL9L9J9cPYqbJJJ9EeVlD
         uieVwHvuZtCzWv2i9+5nUuSYWc6YHpCTvW/uCVKVWanM3bGO9clHLlZDJTRQdh+vStXT
         JebR147UMte2xKNSG766+KWPqjmormL7wvrfV4Oo6q7tYf9OBdp3Q9Sgyp+cXVXKPhd2
         LZbVzW+nhGFJ8DywljsBashi5kxWlbVV3SrTxrThfU+pfx9HknFRDPUv/2nBqsbfr0kF
         mIB2JcID3JCKEdZYv1v67prapGM5itGUbWpzNfCUP+Gqx5xyBuRbv2pPH1Nx8ieaI2kr
         VBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lTZVobgM/3IcweDVBRrPU9HP9E4rGk6Uc/SK3CeJgbs=;
        b=o+L+HeTT+4nDG++RZe2DkiGASmrOV4JgHtpG+TzpPcF9lQYZf3wWHtCMJ7WteUPdaa
         cOaawNpa6t3sqS42UMvJAKlc2OzPeMyWpWaq1fRkqFSFahnPKCbTk4ukLqAMw3MssUBk
         molGsGdILJwrR9a8jNxUR9jW89ZxThxGF6uZ+fdMRbckt05e5DOGcwt/EL3lbM+sck/T
         /UfjMtjrEjDgOcaPtu7dZosKLh5b2Db9ZIlHkGCM+5A5f+Zl/5AQueGslPkq/asOnOhr
         c5K8wiR1rAPIUYd6zUf9CI5LRNUtFePT/6t6rDQOEhb4slppwtePbAAdjNpWRCEvf7ms
         gNag==
X-Gm-Message-State: AOAM532AuTmUNGTmZtcAPt0Fj8kx0VcvoDgbPfMHy8umnKFC+04AvNoa
        t63Gq6ksCWWjMCUm8YJoTA8=
X-Google-Smtp-Source: ABdhPJwyUpLIfNUMvoWs8sNgwzlqizBHfnN+mQ+oZCTgPHX/7QjouVw56wymPnKahxjrFxQSQ7uEuQ==
X-Received: by 2002:a17:902:8494:b0:13b:9365:6f12 with SMTP id c20-20020a170902849400b0013b93656f12mr6143553plo.19.1631556357279;
        Mon, 13 Sep 2021 11:05:57 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id ch19sm7823993pjb.33.2021.09.13.11.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:05:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Sep 2021 08:05:55 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cgroup: Fix incorrect warning from
 cgroup_apply_control_disable()
Message-ID: <YT+TA6ItnF9xM3cR@slm.duckdns.org>
References: <20210910024256.7615-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910024256.7615-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Sep 09, 2021 at 10:42:55PM -0400, Waiman Long wrote:
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 881ce1470beb..e31bca9fcd46 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3140,7 +3140,16 @@ static void cgroup_apply_control_disable(struct cgroup *cgrp)
>  			if (!css)
>  				continue;
>  
> -			WARN_ON_ONCE(percpu_ref_is_dying(&css->refcnt));
> +			/*
> +			 * A kill_css() might have been called previously, but
> +			 * the css may still linger for a while before being
> +			 * removed. Skip it in this case.
> +			 */
> +			if (percpu_ref_is_dying(&css->refcnt)) {
> +				WARN_ON_ONCE(css->parent &&
> +					cgroup_ss_mask(dsct) & (1 << ss->id));
> +				continue;
> +			}

This warning did help me catch some gnarly bugs. Any chance we can keep it
for normal cases and elide it just for remounting?

Thanks.

-- 
tejun
