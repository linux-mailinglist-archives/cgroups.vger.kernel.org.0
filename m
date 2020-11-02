Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFF82A2D5E
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 15:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKBOuZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBOuZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 09:50:25 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595EBC061A04
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 06:50:25 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id d1so5597623qvl.6
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JYqsaLDo1+ctYQbIf4q0wk9qZ0QBJ7TUi9/Nha1uioc=;
        b=H5HLQwnJYlowV4BaCrk9lh4Rqv7LFNr1+ef9UuGrfs5uzMNGGH4S3gy1OrnNoSg1n4
         qjp/UBXHnGGn1vs0uilbdhjR/qhdlhJpKTd9NxFS1BE5ZhEW2XuxKOspnRlJ+4skQPuH
         obC3duxwWHpG7NXn6/W1y7hs83JBQN9iCx+IVzi7b9VHiiqPZQpNL+zRrDOUuL88XfNn
         gIb9BTXH9zbiDnNL993P6oZIKIVEApD/z1PUM8nxlTqGIJSpp4aDemPjumqzx4KDDxOX
         oCkknATB88ysU2YL0ak/MykrNAe7SxDvIW8asaLYvRq6wxUgOscIZcZiesigfHfsq590
         6UwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JYqsaLDo1+ctYQbIf4q0wk9qZ0QBJ7TUi9/Nha1uioc=;
        b=NVLZqR9JJlFTfLZ1lmUAvUlS67qcBDBGrXSXFfmtuRkQJm2PEle7e8ZRMexeit/1LV
         GVfvmhVwqguxa7S/A9WGQ08UDxuCF57WXKqy7zZXb5xWI8ZkfJTV8Go1fApc1HQGXqUN
         DO+M6iDfuXGO59gxdPJoqi0/z45selinSEGwuTDoijaaSI0RT08tRG311X0F4kugWe+C
         /SRDb9i7xLrUpAuRTpstrL50Po9c7G3RdupEzIUnK1US+v1JpnTObUYT35XAaUPJaLVA
         osDgcN25igi9L+EINE2M2NEMr5cKnlrPgoWMr8mGS/GR7HjRxgwp5dm0QIvvsvc2bUEc
         lk3g==
X-Gm-Message-State: AOAM533NYxnVeu0LzDJE0Bl+hsa89H6VFHT8P4Ufn+S4/d7JxVkKM9x4
        57og3TYKHL4Jh5PgQKLMnXPnUA==
X-Google-Smtp-Source: ABdhPJzj1J9AKPe3dC+yW0U2xFyrVrE+rjSPK4kJgqTdJiq9AvDFHLk5Q3e/F/uvXBjPSr1yhPXXFg==
X-Received: by 2002:ad4:54e9:: with SMTP id k9mr22510163qvx.18.1604328624605;
        Mon, 02 Nov 2020 06:50:24 -0800 (PST)
Received: from localhost ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id w5sm4316339qkj.102.2020.11.02.06.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:50:23 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:48:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com
Subject: Re: [PATCH v20 10/20] mm/swap.c: fold vm event PGROTATED into
 pagevec_move_tail_fn
Message-ID: <20201102144839.GD724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-11-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-11-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:55PM +0800, Alex Shi wrote:
> Fold the PGROTATED event collection into pagevec_move_tail_fn call back
> func like other funcs does in pagevec_lru_move_fn. Thus we could save
> func call pagevec_move_tail().
> Now all usage of pagevec_lru_move_fn are same and no needs of its 3rd
> parameter.
> 
> It's just simply the calling. No functional change.
> 
> [lkp@intel.com: found a build issue in the original patch, thanks]
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Nice.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
