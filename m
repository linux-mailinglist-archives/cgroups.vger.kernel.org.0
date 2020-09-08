Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C7F2618AA
	for <lists+cgroups@lfdr.de>; Tue,  8 Sep 2020 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgIHR6u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 8 Sep 2020 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731536AbgIHQMN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 8 Sep 2020 12:12:13 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2C0C061376;
        Tue,  8 Sep 2020 05:48:54 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id o20so10856464pfp.11;
        Tue, 08 Sep 2020 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWON0+1XdczHoZAJuQK9B5Y7ioXiOI58hC6mWgDZwPw=;
        b=KC+X7VswXrScqirdxGrptiUf3sW5/V9eti0jfe/rQeuXOmuHl020tCgfg6WEgzkqoa
         hhdPEQP/9JV0KpAN9nzQoEsl5H7c5w+VudjujLIi2sXPGQaEDOpGjDNQidZavdZflIyj
         TFx3JhxQUVN/bJ9/3F0O1Eq6DJvWFDHeJYFBpDfcN+F6fwz57sMdk7tBoofKS64yL0AB
         vyI5U1d6E4bB/SHZ5ioQp4uLZnzSKqicBI8h5m1sgy8+O4lRvyEp2ovdP9M8fk00Nd9Q
         bi0+VJRa+A92OXPuX+Bw1GOFQUnV0Ta6Do8F9lRRXsfdDfnn9MNbcs3cVNgzsNq2/0iW
         sF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWON0+1XdczHoZAJuQK9B5Y7ioXiOI58hC6mWgDZwPw=;
        b=U7wMTtrH896d0xuhncd72HWm9rCHpOrfeSRzCpqDlkJkdCB8T3uv0vD43q5pV1LVbB
         HIFTdgcGOVVK1piA0RG8CmBgbtXsCnAxr5Kw08KT+awirRnoDJLz0Czv23i0FQ0qUYc5
         TKElk9bSNPr40qcQ9KONLIgV6ZiUKV0ukwVUzD05IILsScRJ7ZvlUtK7yfCn71d1qeA+
         hXNZlyCZjaZ1uSlNEhfxGenL+aNb4hrDeNTfYwCy5hCT3Nk4I3SY5aT6KOC4F9GjOVDh
         sf7YW/wrMlqk5/Zz50qu4cBCfaq+5rQSxCegvNG3FudYbyUA69KXnMchReSIazeWaS64
         y4lA==
X-Gm-Message-State: AOAM533edv0F6WYa3BUx1YSGAnTcR7C48U+MgvF92ZQ2fjNzrGwfzAOT
        GfU6qQ8z7mIyehOwi2dlbiw=
X-Google-Smtp-Source: ABdhPJyKo3dVVd+Yo+sf8G2x8Tmx0c5relINOmwxnl/0k72I0vC/4f4EjbDeoZbpxmRsByzEuV1YrQ==
X-Received: by 2002:a63:a08:: with SMTP id 8mr18312731pgk.300.1599569334520;
        Tue, 08 Sep 2020 05:48:54 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id 131sm16406253pgh.67.2020.09.08.05.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 05:48:54 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:48:52 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     tj@kernel.org
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Delete unnecessary if statement in css_visible()
Message-ID: <20200908124852.GB22780@haolee.github.io>
References: <20200829100202.GA855@haolee.github.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829100202.GA855@haolee.github.io>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

ping

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
