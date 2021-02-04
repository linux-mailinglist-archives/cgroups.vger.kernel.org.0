Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2208730FA0A
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 18:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238665AbhBDRop (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 12:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238610AbhBDRoi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 12:44:38 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA87AC061786
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 09:43:58 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n15so4124852qkh.8
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCBGFufjjtkKM79QaCqD4gnNbGr/Jp0wwB8/7DPDEJI=;
        b=kNmXSlAAZOA5BA1Nd/FHNTmnZuUl+kBcrKvgz0V3T9PaqZLDkAdiv+vpuvjGJWzgIQ
         1JbP6ozldUU5i9up9n52QDgGGYGoDr2vLQPsW3ypPSvSxzf47qEyMaHhjlht+j+pN+Am
         0SC3HBoEE2tK35rFDjrbYwH6woQAqVY+EP9KnLUo6SV1bNagCuG4CyFcPPx5AvuoKcPK
         hlMTyTVcLovypO7oBoPsJ00SQg0EViX0k+ScJ67WU8/8sMm7MpxTfTpmb9HHxGuwY84a
         31WQ5Pt3MX0MummZwo7oyY4RA7sqHnFFYctmMseNA4rmTHJTHv75zulDM5FQKOCrxpog
         rfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCBGFufjjtkKM79QaCqD4gnNbGr/Jp0wwB8/7DPDEJI=;
        b=dwm/6sB8/wUuP9V+8C5u/WKHRrQMjrny4qF7umWMKwYy0LNFkLcXNpuXHRsVcCPPnu
         A3LG8E5yDORkDU9I2M9AEnB4+ySNrgEvKECj5FfxtasfanmJSJR3YLTRC3Yfg3pzzY87
         5rpeAo4I9YBKJIhvO41jd3Xsuh6oyoMA76yEgdQg5l+4UxgeMlC6yDk/0gxSvvDqgN1P
         OtRq9Zi6sSCHn1mct4PG2MZNS2gtGJSbR/UQ0Epg/pfsMgHS3+uVrFaPh5IJpnoJ2dM9
         h83IlQCIYsSKJ7QWbT1qoim72kMJN1heUEqUzSjWpCFBJ3n1Jz5pgiApm9IQoroAPO5x
         bRxQ==
X-Gm-Message-State: AOAM533zwyMFwovhNpXEXnrzuBCDvv1VI9lSEl+fm/MeOMHGxCvmh+RP
        99jE8QEi8FKfNmg/LLTHw3ao1w==
X-Google-Smtp-Source: ABdhPJwSWSWJ3qN496EhBpkdEWHOjRYgA4xdU1ivxrfW3e7LvIBSZqrcATMr2s9xqu/1g+yI8+bOMA==
X-Received: by 2002:a37:345:: with SMTP id 66mr248338qkd.358.1612460638075;
        Thu, 04 Feb 2021 09:43:58 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id d16sm5443086qka.44.2021.02.04.09.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 09:43:57 -0800 (PST)
Date:   Thu, 4 Feb 2021 12:43:56 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: memcontrol: replace the loop with a
 list_for_each_entry()
Message-ID: <YBwyXPFoXrLcxsZR@cmpxchg.org>
References: <20210204163055.56080-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204163055.56080-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 05, 2021 at 12:30:55AM +0800, Muchun Song wrote:
> The rule of list walk has gone since:
> 
>  commit a9d5adeeb4b2 ("mm/memcontrol: allow to uncharge page without using page->lru field")
> 
> So remove the strange comment and replace the loop with a
> list_for_each_entry().
> 
> There is only one caller of the uncharge_list(). So just fold it into
> mem_cgroup_uncharge_list() and remove it.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thank you, Muchun!
