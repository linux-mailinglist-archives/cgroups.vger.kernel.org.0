Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9D62A2D6B
	for <lists+cgroups@lfdr.de>; Mon,  2 Nov 2020 15:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgKBOyI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Nov 2020 09:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBOyH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Nov 2020 09:54:07 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816E1C0617A6
        for <cgroups@vger.kernel.org>; Mon,  2 Nov 2020 06:54:07 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id o205so4860824qke.10
        for <cgroups@vger.kernel.org>; Mon, 02 Nov 2020 06:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FF/JppJfxHL8ahJoJtPZ+p8h36QJk45Xb6vKWkqMYyw=;
        b=pg3oYsVQCcy7LuZa9ij1hYP+NbXJnYUJYqvAiWBgxzUX7RYZON9zygT2ZPp6F8QjqX
         ZebaplFHW2oBtkjQ7lAA0p4x7MxBLaBsmDqG7pXCTtCa1Wes9WpirKmT1NL69OmApInp
         +nt4h1EqBS7BIwpV1nZ5DpIkLmuDQP3XKHETORH2zXtib3kHz76R/hAXEQ1VZcCo9uJu
         7i8M0Kkhiu9bUVGyDP/6zSlARAhN3+BBVYtV/9a6rjBlj3DC/Dk6AbsZ6LHoCiWp1KsE
         PRxGR0eduA8DXKx3CILnmoNBdmyCJy22nLpB7SxGCF6Y8UIdrItHGqNZvXoHjy3BTn7H
         SpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FF/JppJfxHL8ahJoJtPZ+p8h36QJk45Xb6vKWkqMYyw=;
        b=g1xxEmp8s2UAzNQpPRxvbt9dBf9FPN0ABeAtcEoUPj7L6eG1ZjlnIph6n1uCNLDK4z
         zVbTmhpyuAhvNw4jkZhIavz2OHAoad8Z2VUJcHpVhNXD1WN7mSn25wKCybx9Gs6LAl17
         iTuubZ0xLcE8TT6lUEM9rQKAaawBL0jZrESAZtC0QkPsOC9wjCxoBctRdwXnVmRhZnoi
         B10uXQN+5ZjGF2ZPEdWJJPSjOwIVdAD629e+Zf51lYm2uu/wXjgmiKV4voWZuKhmhvLW
         7Gy5mj9tzvZTrGInmKyNLKk3hmUcXLQ6OwHRj9cd0gegRIWTXG2zGUZbLFuf2c9JoJ2N
         xmRQ==
X-Gm-Message-State: AOAM533yGOjrnLaWH2HY4+ccgwbUDAStmoys2sqXtl89geBuaJbsJDyK
        YpUohrRImCuI+kKdtYNtJk2kwUGciilt7A==
X-Google-Smtp-Source: ABdhPJzVl4fH3qjWKemLmU0HXb0wx7FNPKcWuNz2M0gD0VEI3nqrp45sniYdi3oRbTSM12OlI88x+w==
X-Received: by 2002:a37:e51:: with SMTP id 78mr15099002qko.191.1604328846819;
        Mon, 02 Nov 2020 06:54:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:2f6e])
        by smtp.gmail.com with ESMTPSA id z69sm8211620qkb.7.2020.11.02.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:54:05 -0800 (PST)
Date:   Mon, 2 Nov 2020 09:52:20 -0500
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
        shy828301@gmail.com,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v20 12/20] mm/vmscan: remove lruvec reget in
 move_pages_to_lru
Message-ID: <20201102145220.GE724984@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-13-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-13-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:57PM +0800, Alex Shi wrote:
> A isolated page shouldn't be recharged by memcg since the memcg
> migration isn't possible at the time.
> So remove unnecessary regetting.
> 
> Thanks to Alexander Duyck for pointing this out.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

A brief comment in the code could be good: all pages were isolated
from the same lruvec (and isolation inhibits memcg migration).
