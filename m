Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C33280185
	for <lists+cgroups@lfdr.de>; Thu,  1 Oct 2020 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgJAOod (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Oct 2020 10:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOod (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Oct 2020 10:44:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73298C0613D0;
        Thu,  1 Oct 2020 07:44:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m34so4185625pgl.9;
        Thu, 01 Oct 2020 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zMEk1N3CPCYeqn3NdVc8YKuWmziT/BdSn/3LxjNiWOU=;
        b=oQQBAehJs1Sn1ReuyfeqJbYvwoxoA8y+v5MEwvM2JIUhO3ln3XX1m/RkxitRT5Va+O
         NZOZMTBf53KxgTUUu7JauIBYEOLXSyOmljXm2VWWePOfOdDpVQbwfGHXaN9fOAQCSq7A
         j1M0/gcMDuIbO/QiA6piA4mrs5YbNaVagVsf9TSbFahelXCeQnyoZr/CEvh521IVNTWz
         rNkogept4EfC35lmArB9frWAs8+81EqlPoW+c8wgaw3ey9v8EqB86AM4M/fH0rSIDHQF
         aNW79D0G9oiJTuXKtcNjugOVD5gY5PsyO76bZq2IXoGF+w22aa3auu9JsAZj+RC3nV9+
         u73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zMEk1N3CPCYeqn3NdVc8YKuWmziT/BdSn/3LxjNiWOU=;
        b=DBnP3dYc6+lPqRv6kPZLrF2ur9hrgbzIeTy8BmkCAcQUkrVkFRiblPTP0thkgMA8ji
         X/LuZ/6xhBETnfTuR3/3V8xQs/i3u2CnSGiNRFpJFejO7gyKhoSx5yxUXTUePzb1lnpo
         MzDCZjK+YKmWcdOtVi7FM8U5IIKNtRkhin+PPi0kRqnC4C5k0dIUXQf10zHTQj/p8i+l
         LadanXWv52t79zBM9eYC4PYc4qq9rSA68+wQWBvT18Tqx6sFmDqQJD18fPxg8ZAp0KiS
         Oz1JE9929ix5A0u7wuNhU+UoICOsrsEoJpI4/SnSxbydtqRZedh47QEzggOqi7e2lZb+
         3BNg==
X-Gm-Message-State: AOAM532zlVu+8ZUlqzRutRQ81A5kcMZS74M9IovYTCwvtsKRBlvwONys
        M7Xk8iu6k4C/5ru2nlFFgVw=
X-Google-Smtp-Source: ABdhPJx/9o5i1Smx42G83DuVpQqJUcIlBpzQIctmhhu96V0T8BG+vVb2X5pXkwmMCo+rUZn2bb8JgA==
X-Received: by 2002:a63:f815:: with SMTP id n21mr6580516pgh.410.1601563472609;
        Thu, 01 Oct 2020 07:44:32 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id i36sm5644702pgm.43.2020.10.01.07.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:44:29 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:44:26 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Delete unnecessary if statement in css_visible()
Message-ID: <20201001144426.GA8928@haolee.github.io>
References: <20200829100202.GA855@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829100202.GA855@haolee.github.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi, ping...

On Sat, Aug 29, 2020 at 10:03:16AM +0000, Hao Lee wrote:
> css_visible() is called in either cgroup_apply_control_enable()
> or cgroup_apply_control_disable().
> In cgroup_apply_control_enable(), we have checked ss_mask before calling
> css_visible(), so there is no need to do the same thing again.
> In cgroup_apply_control_disable():
>  - If css->parent is not NULL, we have checked ss_mask in the
>    second condition, so there is no need to do the same thing again.
>  - If css->parent is NULL, dsct is root cgroup so the deleted if
>    statement is always false and there is no need to keep it.
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  kernel/cgroup/cgroup.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index dd247747ec14..b6714166106d 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -3023,8 +3023,6 @@ static bool css_visible(struct cgroup_subsys_state *css)
>  
>  	if (cgroup_control(cgrp) & (1 << ss->id))
>  		return true;
> -	if (!(cgroup_ss_mask(cgrp) & (1 << ss->id)))
> -		return false;
>  	return cgroup_on_dfl(cgrp) && ss->implicit_on_dfl;
>  }
>  
> -- 
> 2.24.1
> 
