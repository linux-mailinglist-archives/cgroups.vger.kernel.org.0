Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE1D315A06
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 00:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbhBIX0j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 18:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbhBIWrA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 17:47:00 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8B5C061793
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 13:19:48 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id es14so9416236qvb.3
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E+GwgIRGKbJyN6BMx9osGrabexMLPqEhC8h9yJvwcPI=;
        b=qVg6eWt/p+mtaLHMJ3UMS3pa7cP8tRdSZltmlPVvywtYM1Xz2GgR7lvaILGqsvNc5q
         vYrdlEDpJ6LAExkiYJ+B2vgDJ4ic2ZFx3wDChTDEaZfGBOTtJtLCbFQKoE4/Vk9+CRMe
         /MncFu/kd8cMm7K8t7NNOuyjR2eP2G5CTovSmA03FmKDfH7k80wPNw51QigLDkuqVVoO
         9Jsosv3nlBPAAyWAq3Pt67mVcQfjR5jY5YDPEDWGyqd4Kp1yax1q4OadysJ422FdpCbt
         WX/JTNoTftwxDefcRi52Porkf9IdP/D/O6sbzPHti4g2tYZ9YwaiO2XPK1xOKsZWKK6h
         TUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E+GwgIRGKbJyN6BMx9osGrabexMLPqEhC8h9yJvwcPI=;
        b=e7B7uXA8hC45nP7G52jTCBTajVKeHjl8TjcjYt1qgRKw2s+Mo6I89cOhXCZTne+Fee
         Xc/Lc8SPseS3lVI4Z+ScbeecQK5Rf0A3lzLpkaA7tte2FZ2YCSqBgM+ltyCPUkXVdX2p
         U7RL1afDIR7mjSnfIUURBaDu2ADBE4oNu6mGkNAoWKNadwBhOdwiccXPe39q0IjMRkuO
         e/KJxCqBU6TNgHv+NxGrkGcwlSD/KXrN1/5E1Z35MJssA5/i8GaelO+ax3bf4RbTbiAY
         Q+OB6QQsn9/ggV8MXUnBOQbuR2V0NKJyfa+OFqkIFxDSdGmxp7iDzsTs7MIsYQQqRwev
         3l4g==
X-Gm-Message-State: AOAM531Qd+dnkMEOSdr149QQK33hATJQ8aF2X73qD4fq35bX+sMPtjGg
        bTvrcu6rNBDhGcFi/AGBdNLRKg==
X-Google-Smtp-Source: ABdhPJzC1y781rKFs2oJ/EMXGnR/H0Bxxy1Ep70Zk8iEdT2DuGjbTeRKP6O9dCSwmHzW9pi7dRURgA==
X-Received: by 2002:a05:6214:1643:: with SMTP id f3mr122351qvw.4.1612905588033;
        Tue, 09 Feb 2021 13:19:48 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 199sm20696467qkm.126.2021.02.09.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:19:47 -0800 (PST)
Date:   Tue, 9 Feb 2021 16:19:46 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Michal Hocko <mhocko@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Prakash Gupta <guptap@codeaurora.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH stable 4.9] mm: memcontrol: fix NULL pointer crash in
 test_clear_page_writeback()
Message-ID: <YCL8cnXFtpdnAAUj@cmpxchg.org>
References: <20210209202616.2257512-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209202616.2257512-1-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 09, 2021 at 12:26:15PM -0800, Florian Fainelli wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> commit 739f79fc9db1b38f96b5a5109b247a650fbebf6d upstream

...

> This patch is present in a downstream Android tree:
> 
> https://source.mcwhirter.io/craige/bluecross/commit/d4a742865c6b69ef931694745ef54965d7c9966c
> 
> and I happened to have stumbled across the same problem too.
> 
> Johannes can you review it for correctness with respect to the 4.9
> kernel? Thanks!

Looks good to me.
