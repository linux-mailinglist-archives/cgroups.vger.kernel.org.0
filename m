Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C192A0764
	for <lists+cgroups@lfdr.de>; Fri, 30 Oct 2020 15:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgJ3OHB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Oct 2020 10:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgJ3OHA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Oct 2020 10:07:00 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB40C0613CF
        for <cgroups@vger.kernel.org>; Fri, 30 Oct 2020 07:06:05 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s14so4846759qkg.11
        for <cgroups@vger.kernel.org>; Fri, 30 Oct 2020 07:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XFvLixYNsnzdj4toTcnFoItKGAiR6MimcB7uXhxEsAY=;
        b=YdSmPnE65j6ZxU34kUIayYUWOJdr/r9gmpdMjuHb3lqo4k7Ldna9+SpQYp+Q/O0rpo
         WDajdXIoc3E12pCo7NqjkA5VdTd3GcxyIs6fRkV9TDwZFbcvFqV+vpX1kEwgkglssWVp
         hrXznUwOVgnLP4ssAB6TzjQZYCZCsYzKg3NFhoUAkFoL5+R2IA2zHpXGCyjZ/IF6/MMx
         gqFNMF1zPrQ27+qJm3plMXyMAHfqxPv8dn/ClpIMvSHlmfhmD44gWnz56F6/+2+9h2y+
         kYQTmd6XxzlYFlW17S94k8DW9B2C0Zx8DoGp66gvVqRDJ3ZbNZTsrXicfYnke5xW9AFr
         1v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XFvLixYNsnzdj4toTcnFoItKGAiR6MimcB7uXhxEsAY=;
        b=gabuUCScWk7QD4/jfFCNE4TscIRCGlT4acmxNeSC+PyUe8KYT0LNVkUIOv6BPKuqFp
         SwtOjxCJdBzGnHo8lEfBwdNpHBfPiQK8XWNb09AQZBAyh0jq7eekNBgbYCSvLxjm0yt2
         VyCakwzPMso1TSvOMVP5Z4MFK5ArMTf9g9cDmQB7Mx3CKVITmlPk+smh/liB2yRFtmh6
         zeKQmvSy4vultCtJDI0eye46C+59Ido9X4vQ/2U2XK/G/UK9EvBetChX03JzWDcXQfWE
         h97TkkM5yK3r+GdvuXXtv/XWjdpibce03K00ajODxLpE+wa8SIXqmVcfJh8zsnD72rNl
         IOgw==
X-Gm-Message-State: AOAM5321AQmgjJeE8r+TrPGhZ2WQw2owEPX82RoeQ8KOFhjbueJFbZxS
        UfGZcZjPNhA+Wb7/6wP2ZaCK4Q==
X-Google-Smtp-Source: ABdhPJy6GSdDtgopMaSrcuhTI50F6OgXI/etTV6OK///4TfnmY4zL1gXH/AwTDzNi59Yk5VOzZtUbA==
X-Received: by 2002:ae9:e802:: with SMTP id a2mr2343108qkg.227.1604066764803;
        Fri, 30 Oct 2020 07:06:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fb53])
        by smtp.gmail.com with ESMTPSA id 19sm2609429qki.33.2020.10.30.07.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:06:03 -0700 (PDT)
Date:   Fri, 30 Oct 2020 10:04:20 -0400
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
Subject: Re: [PATCH v20 02/20] mm/memcg: bail early from swap accounting if
 memcg disabled
Message-ID: <20201030140420.GB666074@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-3-git-send-email-alex.shi@linux.alibaba.com>
 <20201029134648.GC599825@cmpxchg.org>
 <96b6d122-df0e-dfb0-368c-6bd714fab116@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96b6d122-df0e-dfb0-368c-6bd714fab116@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 30, 2020 at 10:27:51AM +0800, Alex Shi wrote:
> 
> 
> 在 2020/10/29 下午9:46, Johannes Weiner 写道:
> >>  ? release_pages+0x1ae/0x410
> >>  shmem_alloc_and_acct_page+0x77/0x1c0
> >>  shmem_getpage_gfp+0x162/0x910
> >>  shmem_fault+0x74/0x210
> >>  ? filemap_map_pages+0x29c/0x410
> >>  __do_fault+0x37/0x190
> >>  handle_mm_fault+0x120a/0x1770
> >>  exc_page_fault+0x251/0x450
> >>  ? asm_exc_page_fault+0x8/0x30
> >>  asm_exc_page_fault+0x1e/0x30
> >>
> >> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> >> Reviewed-by: Roman Gushchin <guro@fb.com>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Acked-by: Hugh Dickins <hughd@google.com>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Michal Hocko <mhocko@kernel.org>
> >> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: cgroups@vger.kernel.org
> >> Cc: linux-mm@kvack.org
> >> Cc: linux-kernel@vger.kernel.org
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > 
> > This should go in before the previous patch that adds the WARN for it.
> 
> Right, but than the long ops may not weird. Should I remove the ops and resend the whole patchset?

You mean the warning in the changelog? I think that's alright. You can
just say that you're about to remove the !page->memcg check in the
next patch because the original reasons for having it are gone, and
memcg being disabled is the only remaining exception, so this patch
makes that check explicit in preparation for the next.

Sorry, it's all a bit of a hassle, I just wouldn't want to introduce a
known warning into the kernel between those two patches (could confuse
bisection runs, complicates partial reverts etc.)
