Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFB2A2D42
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKBOrn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 09:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgKBOrn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 09:47:43 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5356FC0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 06:47:43 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 140so11655633qko.2
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2EQEYsdl91ythedVS5CbIaac/O1VzM4oNTqK3zX2+mk=;
        b=XBPlkqmRr/I9IXZ93ewuFmXOVmiqScb7IKEEpyKP6hDEFveEL+2iyaWz2Rap78rQsv
         PhSuMRS+tMZrnEoCMtNlZCNPr/b8PcyBKL+rNSFR3VUw/vyM03pEOTBYs6io9c6W/+5V
         m+Yi9eLNS9TUDzPEVQhdtb5ey/6XoJUzJcdDErfRkkXJvIiSRGqsxEuJk9liWJNGQFDK
         X3/YKbeCkUS27pVkmCABhGYexhEMFN/wZAFRUhCRJjL4vH691liVm8mXQIKVywQUaney
         EkUScfWC0PqqjKvxYeTLKUz+ZuSOmqiwzWwymxMFkP+sz/oEs63OX32bcp6ytc90vdO2
         gGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2EQEYsdl91ythedVS5CbIaac/O1VzM4oNTqK3zX2+mk=;
        b=PmfWM/rs/cIkzTf1LGVnBWuLksJOgjIzJgIuxL88qgcyBurvgnkj9ZsDRj/RI07fSB
         j+Vc1oG++pfhFa68HtmCDOQxaYofvO5NuGx95YvPWVfnLx594fLISZaHoxrwiIxINExp
         hIexiXxRSV5fpeod3UR4b1AguS0d9p4DSPPp++kt8aUWmPTjSPvBTiUUHJoPnuoYmufh
         MYW0iztJt86/ezoIoz3IgXGu218v9raQTNC6cgkhKc2WOzxrpuYdBzUi+PeCLeapMc8o
         90QYSl2xq7jBxVo1dJZiY+N67XtIYF3aVgGX2u0Okx+B5BG3ko7kHWfwg16ZJ0ew7km/
         MCQQ==
X-Gm-Message-State: AOAM5304DWli5zr3U5MK/zADn/6FoURBNC2K2nDKxvWpD1UGLY1+hK0Y
        Aa0X/Xpo6YTauFbdQv9v/l3VRA==
X-Google-Smtp-Source: ABdhPJw5RAfqHvXVJPW3dOFsENGkqy36MuBPEwzggaN8V/NFBbnS3QZ12Rx3n9/XE58tqM2s26TmEw==
X-Received: by 2002:a05:620a:21c4:: with SMTP id h4mr13587374qka.242.1604328462641;
        Mon, 02 Nov 2020 06:47:42 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id 66sm5935254qkd.81.2020.11.02.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:47:41 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:45:57 -0500
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
        shy828301@gmail.com, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v20 09/20] mm/memcg: add debug checking in lock_page_memcg
Message-ID: <20201102144557.GC724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-10-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-10-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:54PM +0800, Alex Shi wrote:
> Add a debug checking in lock_page_memcg, then we could get alarm
> if anything wrong here.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
