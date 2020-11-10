Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD5E72ADF06
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 20:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgKJTD1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 Nov 2020 14:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731187AbgKJTD0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 Nov 2020 14:03:26 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84DEC0613D3
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 11:03:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id h12so9372147qtc.9
        for <cgroups@vger.kernel.org>; Tue, 10 Nov 2020 11:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPj1mYmXqOWOz3TEiog9Zh5vT3acF5XixS22iuZzAIA=;
        b=oSzlQ+aZKJ+JtX7hBOzJ6QuxNdqcLauhjHFsVIve5PuHfOiAhBQP7vT28Pm0UhsV1F
         niWeWfpQFlQfk/RbeF3CC/XDpLPH8x2OpyaosMNkEKmofRAP2RLPWK0CISlT7mz8+k6L
         Ogvl1E8vhzyA4EBAyDF5hZ87LvKJk1nPjzHtRvVxPcpYstS8Y6gbvBorj4CWcBizdaci
         sXILka5r/IVEdHN6qNh+d4lj/vl6K02b9mjiEJEunCrInhniMjic3dfF9flk981t6QnU
         L47YPELx/y+49FzFNqmf4vmsapRk4D9hpHq2HOCrTOOAfkdrWtK6Z1iVx4ZUH2br1ppd
         lENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPj1mYmXqOWOz3TEiog9Zh5vT3acF5XixS22iuZzAIA=;
        b=mTr4ZIleIMwJppsZRk9qbRr8FF7ppEsFP/h6Vc4FO3RAecK/sk7I1Gf5M1LTnLIl1A
         I+TH4PbsAPlQ2l7tPRjX15IUDkFm2PkIKdTilSYfoHjjx6py+WShOJNL7xPzuXd1rMLO
         48DnhG9S0EeHepkVitrOdDlIIlBKMAwNGQEcX+KxvRtcgtGU8M+9ktKhMBZzYIIjocvV
         eosGDEtUH/LJM3ySG567H9iLYrXv9gzdCS1DhnO+JFPLQSU7YIjNRgqUUdmI3qXeP3l9
         +ANxVvHdvhbEmEoIH8gldqoETNo7/QcBCiL/z/9c6AYfo+oReG9jrtsdZomdrdXHPGUM
         or4w==
X-Gm-Message-State: AOAM530nabjRnQj221CesltJQd5yJlnPbjnoeOMuq6QQRhYmhg18HPQZ
        kQxmAE+oMtU88eJN0qYNlpxBAg==
X-Google-Smtp-Source: ABdhPJytHHzLMJg40qegnPnje7IYDJ+RMvN9cVBdzFFWhbDZGWSSHK7faXUGzh+ZUmYD25cREX9xVg==
X-Received: by 2002:ac8:6682:: with SMTP id d2mr8584069qtp.349.1605035004225;
        Tue, 10 Nov 2020 11:03:24 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:64f7])
        by smtp.gmail.com with ESMTPSA id p13sm8604430qti.58.2020.11.10.11.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:03:23 -0800 (PST)
Date:   Tue, 10 Nov 2020 14:01:36 -0500
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
        shy828301@gmail.com, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v21 07/19] mm: page_idle_get_page() does not need lru_lock
Message-ID: <20201110190136.GD850433@cmpxchg.org>
References: <1604566549-62481-1-git-send-email-alex.shi@linux.alibaba.com>
 <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604566549-62481-8-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 05, 2020 at 04:55:37PM +0800, Alex Shi wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> It is necessary for page_idle_get_page() to recheck PageLRU() after
> get_page_unless_zero(), but holding lru_lock around that serves no
> useful purpose, and adds to lru_lock contention: delete it.
> 
> See https://lore.kernel.org/lkml/20150504031722.GA2768@blaptop for the
> discussion that led to lru_lock there; but __page_set_anon_rmap() now
> uses WRITE_ONCE(), and I see no other risk in page_idle_clear_pte_refs()
> using rmap_walk() (beyond the risk of racing PageAnon->PageKsm, mostly
> but not entirely prevented by page_count() check in ksm.c's
> write_protect_page(): that risk being shared with page_referenced() and
> not helped by lru_lock).
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
