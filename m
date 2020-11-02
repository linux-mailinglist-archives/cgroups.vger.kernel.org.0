Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5C2A3560
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 21:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKBUsU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 15:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgKBUrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 15:47:53 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB03C0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 12:47:53 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id j31so3463885qtb.8
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 12:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nj7sBGiH3baY4a625q23mk4W+OwP4KOftkycQT8zu4o=;
        b=AooKG3JKnOmiHLh9nY54aYGlYs4PzFJ7MlNomW/8sYein7Vt3XnigPfayRPJcNRlrK
         ZBsuA/Hs9q+xHuwYyIZ0ExR0cE7+VVHZt8+QOG35Oru++TKZNJidpX/UuW05lxc4lHm1
         ehdA1V95yP0ap2IzhmgDjDrWwUq0Ay+RBeA8L3zPBLBnKSdRN/CPrpWYwOpaPZv6oo+1
         mJE7W5YL4VmmnXWJyxus2MHR2GjslNtuUQXItA05LBYMYAjYwNRjR8WGILXmQjuPsLFf
         tcxxfAY6lCD5wxFXijlzYwfHi+fE43euh1dwJzyDic0uGeDgD+zdvpLKx1MwijGOuhsd
         brUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nj7sBGiH3baY4a625q23mk4W+OwP4KOftkycQT8zu4o=;
        b=OFuMNPPtY6UnZc1jryWixF9lz9ME+DhGy8e71XtTW2IPiWJO/oRILP7uu3WAuv86WL
         zgbd3W8lQ1pnC9O9WD17FJ11T5gBmcMCyrndb+SdGoCaA9gR7i+kuGROrYhytTpxQuUV
         F9Czpvw6k1ADsqoR1eJDBtO+Vr5dR5UCR6+ON8VPk87sPLgPkWuBHEonYnKuLy16zN0U
         hFyD62eAikSIDQeHC2aFtnocQk1HxOp6WAqCLi/97oDGv5OSvVfqW/WUVqZo2TzBKmrB
         55lMtZIqPvYWFG25S0guQ7Oxjtj2PbeoJ13bE0QfAtgBzEH7GccXtpDF2JbmGJnWw+kZ
         yZGw==
X-Gm-Message-State: AOAM533Sio2f9LRUDbSg3SQ9EiV3yU4Zz0cBPQ9kaQDiHBVfF91otZRD
        ils5QqOBZFXYZj0tAHAu047WQg==
X-Google-Smtp-Source: ABdhPJwUqPE8UL+goivCuxPOedpZNc1PpHve+Wa7sHmVXfIF4vDKOnoQRO2PB2LDNWng556UnGVtYA==
X-Received: by 2002:ac8:4f06:: with SMTP id b6mr16800372qte.163.1604350072520;
        Mon, 02 Nov 2020 12:47:52 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id x22sm7963711qkn.125.2020.11.02.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 12:47:51 -0800 (PST)
Date:   Mon, 2 Nov 2020 15:46:07 -0500
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
        shy828301@gmail.com, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v20 20/20] mm/lru: revise the comments of lru_lock
Message-ID: <20201102204607.GD740958@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-21-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-21-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:45:05PM +0800, Alex Shi wrote:
> From: Hugh Dickins <hughd@google.com>
> 
> Since we changed the pgdat->lru_lock to lruvec->lru_lock, it's time to
> fix the incorrect comments in code. Also fixed some zone->lru_lock comment
> error from ancient time. etc.
> 
> I struggled to understand the comment above move_pages_to_lru() (surely
> it never calls page_referenced()), and eventually realized that most of
> it had got separated from shrink_active_list(): move that comment back.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
