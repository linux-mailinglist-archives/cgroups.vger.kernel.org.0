Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D82C349CFF4
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 17:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbiAZQrP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 11:47:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbiAZQrO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 11:47:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B03C06161C
        for <cgroups@vger.kernel.org>; Wed, 26 Jan 2022 08:47:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so3323702pjl.0
        for <cgroups@vger.kernel.org>; Wed, 26 Jan 2022 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7tjkVWkeJikq0MYiRHHkM9K0li9PU6oyj23BwxkVz/4=;
        b=L6uQCEsWfha23cY9vLp5bDKfNpb0ng8apf1wuq0/YmnUr11q04UbSGTzyeyoJUVejD
         zvk/aAn6lhfj0MHMQ4Aby1rlHO7LC4ODl6PeH9SVGtxLw2z3VVA+7j9hYiE3X1bpCSml
         6HmwFidqgQBnqsbmRFqxuXFTqgiaOMUso5OtBqA1iICkeHQScbO7c6WOY8Qnk6FHG3cQ
         jfpqL7P+opQXXJs00VuIC5KzbfFknG6knrHs1tP6iG/1gUm10CwaKAJAmlJexXXqTGaF
         7na+gzbI40WGd0AieBd269viVnWp6arPOG6lnrL4vtrJ6woPhRwkE2igLLm7TuYV9Y1a
         g9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=7tjkVWkeJikq0MYiRHHkM9K0li9PU6oyj23BwxkVz/4=;
        b=vg4uA66PcJD60PTmP1pXkvE7x8iS6NixeODLfyRp6WPc9kR7b/LMjFGespZ6yyRUY3
         DI2DvA0JyWXn1OfNYvQq9H4ZqB9X2DK+mwcR2UGD86j2XQ+IEaP+ISa+kY+DJPJrVmlD
         aq7my2snKHK98T3vmxCd6mtxi+xzBrDo4VOojlDcyDMMds3jcFpM1/sAvx2R2hmDvOSM
         tVXVR+vEYo8Lxz7TgSCIsBoP0Hzdm8LHe/PQzWnDRDbiXUYLKkk/RhkEU1f0uDeK0B8/
         aiJ3e7pj2wBnsmaADyH+813p8YY8Noy3bvAvTi7yQ3zPqIzCDcjlAuxq0Hni4A34M7J6
         yqSQ==
X-Gm-Message-State: AOAM530soQOWv+czA1uT/aFb1/oKdvJIZHtZ2g38LefUoubsbZDN/bjT
        MuVSorZxyV1TXCqKrFh24zzVOSxvAU7T+g==
X-Google-Smtp-Source: ABdhPJxrMtLuI3T2JvRSwLpczjXkra1AN5Zl93CDmKSgS2VqPv3V5gR4mUMBtVMuiJDG+dN2cEtAlg==
X-Received: by 2002:a17:902:e552:b0:149:b7bf:9b42 with SMTP id n18-20020a170902e55200b00149b7bf9b42mr23062520plf.70.1643215633946;
        Wed, 26 Jan 2022 08:47:13 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d9sm2631864pfl.69.2022.01.26.08.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 08:47:13 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 26 Jan 2022 06:47:11 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH] cgroup: minor optimization around the usage of
 cur_tasks_head
Message-ID: <YfF7DwvzzTxY+2Io@slm.duckdns.org>
References: <20220126141705.6497-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126141705.6497-1-laoar.shao@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 26, 2022 at 02:17:05PM +0000, Yafang Shao wrote:
> Recently there was an issue occurred on our production envrionment with a
> very old kernel version 4.19. That issue can be fixed by upstream
> commit 9c974c772464 ("cgroup: Iterate tasks that did not finish do_exit()")
> 
> When I was trying to fix that issue on our production environment, I found
> we can create a hotfix with a simplified version of the commit -
> 
> As the usage of cur_tasks_head is within the function
> css_task_iter_advance(), we can make it as a local variable. That could
> make it more clear and easier to understand. Another benefit is we don't
> need to carry it in css_task_iter.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Michal Koutný <mkoutny@suse.com>

I can't tell whether this is better or not. Sure, it loses one pointer from
the struct but that doesn't really gain anything practical. On the other
hand, before, we could understand where the iteration was by just dumping
the struct. After, we can't. At best, maybe this change is a wash.

Thanks.

-- 
tejun
