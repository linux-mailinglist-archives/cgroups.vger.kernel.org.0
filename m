Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5743AB329
	for <lists+cgroups@lfdr.de>; Thu, 17 Jun 2021 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbhFQMEG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Jun 2021 08:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhFQMEF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Jun 2021 08:04:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0581EC06175F
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 05:01:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id i94so6481946wri.4
        for <cgroups@vger.kernel.org>; Thu, 17 Jun 2021 05:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PZ6ISBSnRrzVuSGvUd0b/8GChX0lbxx7dZ00sY7kWSQ=;
        b=ClmgFWz8+2HypoYvC+r5XNcMSnn1uiYnYp9+/m/RvaoK11RlmLCbs34RQTbCbb6cbu
         2eQf+wKIYAocO/nXeeV61afl8dulo+jZrID6MlWbalOUB/oTE2h8iG5eveHIGujPTPnV
         UtX8AHiXIb60iJU58NIuKJ4AO8EKGXwWL1+nETQGyRH8W9j0M6BYHxOUXiMGXyowzkTB
         d3b5FzexoMOIxC1W0zO5Q7jzFPxPvd+M8KwrFeCNr4JRxojO8hfd+gzUJ50cqvy53OLK
         hvP0OMPF0pgl5d7kNwZWWufubnFSrBBGqLzs7Hazj6PBc3uXj1F19829cgHCp+GZLipT
         eZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PZ6ISBSnRrzVuSGvUd0b/8GChX0lbxx7dZ00sY7kWSQ=;
        b=mQ4PZzaT2YC5R2N7NCTc1BXmGw1qtGya7WmUHSflTB0bHoX5dPYZkY+i9tHbXUb2Ai
         xszz5QoRyKG0z0u+d6NQHPvQRZ00eBTKWTkQ+sLreBhwdxRT6vX8pU5BDkqGCbxuEtt7
         /HBpvAFLZmNYZzIA4jrBCSR+iibn3PvwkyXY0rXbc6Gl3NAyn2eSyjmgY+LNJmpHBjfC
         ZGdicIXVmRJzBXuVPZJR9G2ecEwWRqjCPnSkH/kQ/OW7BHh8jPZePUJjIPsEvRFeDwkf
         +4WK0fzYbegOIGfVWk6sNdbQLhY6043N0WaKxEl9P3/6Oa9OT/J5jChKdDJv9ceidtQ0
         JVDw==
X-Gm-Message-State: AOAM530LudaNNXm+M4hxNB652iu7aLYY8Ou6JoCDZZzZkTry75enpgVG
        ouB4LrkCoFt96TmqW/le+6H7Xg==
X-Google-Smtp-Source: ABdhPJx5r/jGmOfQQj6nA8f4ig9gMPFor5XBGiyM22eY1yqPLWqZk6GnztPSqq+w26fAvTSFl472kQ==
X-Received: by 2002:a05:6000:186c:: with SMTP id d12mr5255316wri.123.1623931316627;
        Thu, 17 Jun 2021 05:01:56 -0700 (PDT)
Received: from dell ([91.110.221.170])
        by smtp.gmail.com with ESMTPSA id 61sm5597887wrp.4.2021.06.17.05.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 05:01:56 -0700 (PDT)
Date:   Thu, 17 Jun 2021 13:01:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/1] cgroup-v1: Grant CAP_SYS_NICE holders permission to
 move tasks between cgroups
Message-ID: <YMs5ssb50B208Aad@dell>
References: <20210617090941.340135-1-lee.jones@linaro.org>
 <YMs08Ij8PZ/gemLL@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YMs08Ij8PZ/gemLL@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Tejun,

Thanks for your reply.

On Thu, 17 Jun 2021, Tejun Heo wrote:
> On Thu, Jun 17, 2021 at 10:09:41AM +0100, Lee Jones wrote:
> > It should be possible for processes with CAP_SYS_NICE capabilities
> > (privileges) to move lower priority tasks within the same namespace to
> > different cgroups.
> 
> I'm not sure that "should" is justified that easily given that cgroup can
> affect things like device access permissions and basic system organization.

The latter part of that sentence does provide some additional caveats.

> > One extremely common example of this is Android's 'system_server',
> > which moves processes around to different cgroups/cpusets, but should
> > not require any other root privileges.
> 
> Why is this being brought up now after all the years?

This has been discussed before?

I didn't find any evidence of that on the lists.

> Isn't android moving onto cgroup2 anyway?

That I would have to check.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
