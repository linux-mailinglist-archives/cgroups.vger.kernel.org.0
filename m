Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C412A2E39
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 16:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKBPWc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 10:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgKBPWc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 10:22:32 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9C5C061A04
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 07:22:31 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id c5so9419461qtw.3
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 07:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PZfLygvPchTUSgGMmFZPk8zJRPc7y3a0+u5vclYWa+g=;
        b=bAkYwaocuGeef7r/WOYoDUSYpYjQDgRDpirAbBQA4pgs0hzQ0GiYmrYxa29dxnVHRF
         WxZ+s5OiKNjfk7VuV+xQNYKlAGD4juHOKsM0ZetbZkYA9t1Tbh1k2izLHb7ERccLcgHm
         GCCABAf8ThtuwtqKtEcG6HvFonuEEIP0GHWjilwMZYs78mM8ItctpBi0UBxTd5qcNaAs
         QdZ7tgIjuj20hncEA5VgCavYzeW6I9e9gAOIUgoiUtVovsIhhie+0DjaKZnVF0kJxI0J
         Jf02bfDygNUlJuqZ865wjaIfGmJK7DpfTtDj0KZDfr56i5YflC13w1YJT5czGz7ws46t
         JTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PZfLygvPchTUSgGMmFZPk8zJRPc7y3a0+u5vclYWa+g=;
        b=Og5UhIjmyyTm2aKi35Kybyi6iB0H0bP49dmuWU0HzXJsRLfFZ+1Q0Dk3J1B8FHnvHb
         IQ314A2j+DXLhzKOmpY4hMixU9pYaD19lYoq+gZ2RGBxN++zBPSHEOjTvt24/58C39pK
         v3RKamTpKnXQzMlt6FPrsLA7/w9gtdpCW+ZZa7TwCml1AvGr4JXm0S6Zp2EoYyUoXAIK
         ChI1RZKQlTkHUwz2YGFVvoWwh5Pr/qQE6AONsrgnurkfcxHwsdFrp19pPHNyKLkqc4Yz
         0lZdXeMtCxFAhJV4HNQFvDBEw2q9no9jDxcarCgzGRQwYZoKmluKWcg0N4YbkXeGtQLy
         +wCA==
X-Gm-Message-State: AOAM533INT0aL1pO50c9dwbfOzNiIot0ErtMmXIrJi6egk41A+HT7ZWs
        xFt5Akb/C5hUENbyy/paF29dsA==
X-Google-Smtp-Source: ABdhPJxSwd5B22hT5eiV6LBd9rt7/VanBXU8KpL4jRhTH+94Q2JIMRQvuMsiEz1tN3erRApM/xKQzA==
X-Received: by 2002:aed:2941:: with SMTP id s59mr14633752qtd.387.1604330550876;
        Mon, 02 Nov 2020 07:22:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id p2sm3861044qkk.34.2020.11.02.07.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 07:22:30 -0800 (PST)
Date:   Mon, 2 Nov 2020 10:20:45 -0500
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
Subject: Re: [PATCH v20 17/20] mm/swap.c: serialize memcg changes in
 pagevec_lru_move_fn
Message-ID: <20201102152045.GJ724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-18-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-18-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:45:02PM +0800, Alex Shi wrote:
> Hugh Dickins' found a memcg change bug on original version:
> If we want to change the pgdat->lru_lock to memcg's lruvec lock, we have
> to serialize mem_cgroup_move_account during pagevec_lru_move_fn. The
> possible bad scenario would like:
> 
> 	cpu 0					cpu 1
> lruvec = mem_cgroup_page_lruvec()
> 					if (!isolate_lru_page())
> 						mem_cgroup_move_account
> 
> spin_lock_irqsave(&lruvec->lru_lock <== wrong lock.
> 
> So we need TestClearPageLRU to block isolate_lru_page(), that serializes
> the memcg change. and then removing the PageLRU check in move_fn callee
> as the consequence.
> 
> __pagevec_lru_add_fn() is different from the others, because the pages
> it deals with are, by definition, not yet on the lru.  TestClearPageLRU
> is not needed and would not work, so __pagevec_lru_add() goes its own
> way.
> 
> Reported-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
