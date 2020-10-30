Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4F2A0729
	for <lists+cgroups@lfdr.de>; Fri, 30 Oct 2020 14:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgJ3NyO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 30 Oct 2020 09:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgJ3NyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 30 Oct 2020 09:54:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18BBC0613CF
        for <cgroups@vger.kernel.org>; Fri, 30 Oct 2020 06:54:03 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id a64so1466068qkc.5
        for <cgroups@vger.kernel.org>; Fri, 30 Oct 2020 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=p1nkWHsTTJ1phk0MECInN7pnDwPUF1bojBnmQs9PZoM=;
        b=JsNIng18yHH5/LXDpPA+BwLTBHcs1T13ZwrR46DvSQd2iyr/I2H49p0AaTvTYPWxtu
         hRlzMwdMBF7gPpGJExMS3hcyvwcq2OLXMcHJRUYaIINATS2DLqUpB59uW/MCb8eG1cmy
         KIX7EF8KQzWW81n5ccWUkUQOY5wf00O99LDkOtjXk3o27fEMFo/HJDlPg7FqiHLAHTPP
         S8DBv/CExSuAh1XX/bl1C3LjbAgG1WJWjXBibLWMbrn+cWxhUD3vFLKq8SWWvl8XFGzZ
         1q1WFkMcp6/IugaIHT2dqvt7HYV96HeBabnklmKeSNKFtYP/mXrizgDpZLO2t9x51Da1
         lZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=p1nkWHsTTJ1phk0MECInN7pnDwPUF1bojBnmQs9PZoM=;
        b=LDdjixxPFXZ2TbOhtyyztROI8jIMJitzOKIAin+ota+5ii0QvrHEh2ovhyxonor8TL
         nBUVtfvv3mX0GtlETGS+nhRzZCEtEU5rUyaVfR/4zF1JzukxG8p1JEZmJdqKm1Np9Nj3
         CDzYWWwCrp4Tq41JoG0xNu4QUIr4vIrRhSqQ+WoEbQuXvg2QJ4LJnJhm0lomQae/uR4o
         XLHxjKwC/6ZqY2OYr+qBrvlsotZdTywjGICNyLK+K4MPcA2SGFS52bSigmsNob9Fi081
         RTwSY22aVyfZsP0M6V/L9RQBbLNZtJj6k0pXBqXfPsuQAepYgNuZvJPrt1Voigbuqe/X
         k92Q==
X-Gm-Message-State: AOAM5327ar/yTh1Vip5YgGsxjaHmCdonEbcGZRI7ZJqomJD41gxjX8Rj
        uQy0MF/fjM0AIqYs6OmYhMewPQ==
X-Google-Smtp-Source: ABdhPJyF+BFubaC/JGYM6eWjmxwnbrrCuZ0ryHOd/RS/yxhobmdvosNJSoJpp5+YvCHoPljCfCzHEA==
X-Received: by 2002:a05:620a:16dc:: with SMTP id a28mr2289149qkn.372.1604066043143;
        Fri, 30 Oct 2020 06:54:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fb53])
        by smtp.gmail.com with ESMTPSA id k4sm2577028qkj.46.2020.10.30.06.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 06:54:02 -0700 (PDT)
Date:   Fri, 30 Oct 2020 09:52:18 -0400
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
Subject: Re: [PATCH v20 04/20] mm/thp: use head for head page in
 lru_add_page_tail
Message-ID: <20201030135218.GA666074@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-5-git-send-email-alex.shi@linux.alibaba.com>
 <20201029135047.GE599825@cmpxchg.org>
 <06a5b7d8-bbf2-51b7-1352-2b630186e15f@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <06a5b7d8-bbf2-51b7-1352-2b630186e15f@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 30, 2020 at 10:46:54AM +0800, Alex Shi wrote:
> 在 2020/10/29 下午9:50, Johannes Weiner 写道:
> > It may be better to pick either
> > 	head and tail
> 
> Hi Johannes,
> 
> Thanks for comments!
> 
> Right, Consider functions in this file are using head/tail more as parameters
> I will change to use head/tail too. And then, the 04th, 05th, and 18th patch 
> will be changed accordingly.

That's great, thank you!

> From a9ee63a213f40eb4d5a69b52fbb348ff9cd7cf6c Mon Sep 17 00:00:00 2001
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Date: Tue, 26 May 2020 16:49:22 +0800
> Subject: [PATCH v21 04/20] mm/thp: use head for head page in lru_add_page_tail
> 
> Since the first parameter is only used by head page, it's better to make
> it explicit.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
