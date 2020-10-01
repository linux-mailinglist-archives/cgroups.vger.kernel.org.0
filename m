Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466BA280193
	for <lists+cgroups@lfdr.de>; Thu,  1 Oct 2020 16:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJAOqq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Oct 2020 10:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOqq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Oct 2020 10:46:46 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71519C0613D0;
        Thu,  1 Oct 2020 07:46:46 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n14so4702237pff.6;
        Thu, 01 Oct 2020 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/bvJaeIsvnVRyggeVeOl1YTR4So/Xa/e8HzZoos6sug=;
        b=hDzu1IyME39GYnbjWw4BBFlrkMJP7fdud853cSG9GTOcrxENdsTmlATM/v3JjnXH18
         2lRsNhTDtVgJhpdW/8YJUjxcHjjYAXk1NTLmmLIdzwl4j4cYpliXjmioKmRhlfVCuxDv
         V5lwQY7ec1dESimJTLFfCdPeAqAK860WhBRTdW7/7elmIOQiI2E3FbwM1UrP8SE/2/4h
         0dabI25Qy31pPdCq4JYI3wzHjAZwMBI5J4p69B/1ohk/ng5x9ltM1Yrxhdf24f4lXQJk
         bZk85kzBw1MpgsjimKsu6RrMlZGSakjQ7iujFCd4sgxiVlFoeLYuCgq7nNXEQmgeVqZ2
         syNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/bvJaeIsvnVRyggeVeOl1YTR4So/Xa/e8HzZoos6sug=;
        b=COv4uKD/irI+gSW9hxMVyrgb3gqaRrxy73sTK2X25MrjYCKORf3IU9HjiMGbxVwP3r
         oeK9agM+Tf6dyBnQPpmiK04g/rmUpCQh8bgastzZ2xfLDBsDbCTpGg1lAK/5mxogPvCM
         JX7nopeiIXIqieNas/Qn5cIcBfuRkmLcfcu5H819HvyDzpGAJvLnPwTZ/vx4UtxrCfoI
         9cWHxa9XMHQRFqlSJVe9Ek4o2gW+OkQl9+NGApVwDP0i27fjE8KBretsCDl5ky1h+aI+
         dASggRkg/uqFL74JSe95F5AHPZWLDgnkmkhzToQOUpjL6F0nEmIbYPJn5iEVfuv165N0
         7DUg==
X-Gm-Message-State: AOAM530wsDd14s1/F/sg186cAUTwHfK3ArROB66IOpXfbrXjU3EWTsMu
        L2CULnlEEWsGfbW2OXAclDoCg0/Bn90p6g==
X-Google-Smtp-Source: ABdhPJz842WSS8+2az075Bn5TOYPjtXo7qBjlhcNob1H7oqEdivj3cWK61Ab0DfvT7PGLgSiA9zjXA==
X-Received: by 2002:aa7:86ce:0:b029:152:1702:d791 with SMTP id h14-20020aa786ce0000b02901521702d791mr1654244pfo.13.1601563606016;
        Thu, 01 Oct 2020 07:46:46 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id h31sm5549185pgh.71.2020.10.01.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:46:42 -0700 (PDT)
Date:   Thu, 1 Oct 2020 14:46:41 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove unnecessary call to strstrip()
Message-ID: <20201001144641.GB8928@haolee.github.io>
References: <20200908133350.GA22979@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908133350.GA22979@haolee.github.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Ping. Thanks.

On Tue, Sep 08, 2020 at 01:33:50PM +0000, Hao Lee wrote:
> The string buf will be stripped in cgroup_procs_write_start() before it
> is converted to int, so remove this unnecessary call to strstrip().
> 
> Signed-off-by: Hao Lee <haolee.swjtu@gmail.com>
> ---
>  kernel/cgroup/cgroup.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index b6714166106d..90ee7e73eb2e 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -4772,14 +4772,12 @@ static ssize_t cgroup_threads_write(struct kernfs_open_file *of,
>  {
>  	struct cgroup *src_cgrp, *dst_cgrp;
>  	struct task_struct *task;
>  	ssize_t ret;
>  	bool locked;
>  
> -	buf = strstrip(buf);
> -
>  	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
>  	if (!dst_cgrp)
>  		return -ENODEV;
>  
>  	task = cgroup_procs_write_start(buf, false, &locked);
>  	ret = PTR_ERR_OR_ZERO(task);
> -- 
> 2.24.1
> 
