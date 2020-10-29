Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F279A29ED8B
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 14:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgJ2NtX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 09:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgJ2NtU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 09:49:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51B5C0613D4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:49:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id y17so3076077ilg.4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aaIMvQUgy5GfKnfOz1OmQc/tQFUJWmKT+5EU7lJnpIg=;
        b=Rkh4mNNWCGTBaZ0kV3h45r9aCfQYTEYCWwhRTXhZukO72CfLpaYAPvSKsRefVLAzBS
         XY2eapgWAFWjyUUoH7y9nXTAJxwWC0HpyKLRREWAnnPufo2nFhCVDJwAxmSRiG1SmYRt
         6de9omlzVlZi/CoRpBC8oLf0Zij5KZIx0kMdZbchDA9917NbYrk8f8zEeYVWy2US9YjA
         rcbo+L01DJPTZi0FIodyReVMGdqEpBmGzPA6I4C628VHdPh3HjvJyu+YvqWL6rvh+ovW
         n34QeAf/1/kiOVFLMOiZqY0/zzh8MIaom8wOQ4Bn/zCvhHIA8fL2jeT3TJy7SmFibzxX
         yETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aaIMvQUgy5GfKnfOz1OmQc/tQFUJWmKT+5EU7lJnpIg=;
        b=IWb1v8sl49xJc3f6XXS8UFaa6zUOlrypcunpsJsCS+uJHp0zJRiG5Fh5n5Zhie2YK+
         wJoZ14dbSmEI93I0SBNiPznNoWaH4K/eCNRINtP8o6H7kpmypmS/BISWXqWW6bvDC5l8
         zzjOw08OkgjoOYAATHY+771w7GJV2pCONZkTOW4x5blgOd3A/My4lXww9TrDCzZWYq3v
         pALDrShWUpxa9CFvcMvkkKUB1lxFYZCSKbmpYE2GgZOJBJLg5iq1T6moRNOdLGMs7EdQ
         Dunjdvref5WIrEfh3t8QU/lw+v5MAtS+6FUcCe1uyigAocJG7QYP0bAqAR/O5H+1eN/v
         hmog==
X-Gm-Message-State: AOAM532/ODo8n6so7romDbkB36iTfTiYdJf5YcVaqgGf0WhPMzplVQjU
        64u1AQ20uLNMG/Z6HnD2Kdm6MA==
X-Google-Smtp-Source: ABdhPJx6akD2dWp5vXCJd42qFVzh3uxf4Fx0OHthh0wIVykcUn348X8rO6ye2ci3U/17ms/WaumXwg==
X-Received: by 2002:a05:6e02:ca9:: with SMTP id 9mr2947150ilg.96.1603979360131;
        Thu, 29 Oct 2020 06:49:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id n84sm2881225ild.16.2020.10.29.06.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:49:19 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:47:36 -0400
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
Subject: Re: [PATCH v20 03/20] mm/thp: move lru_add_page_tail func to
 huge_memory.c
Message-ID: <20201029134736.GD599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-4-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:48PM +0800, Alex Shi wrote:
> The func is only used in huge_memory.c, defining it in other file with a
> CONFIG_TRANSPARENT_HUGEPAGE macro restrict just looks weird.
> 
> Let's move it THP. And make it static as Hugh Dickin suggested.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
