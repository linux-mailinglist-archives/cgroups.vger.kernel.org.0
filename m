Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A640D29ED55
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 14:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgJ2Noj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbgJ2Noe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 09:44:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F0AC0613D4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id q25so3448222ioh.4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqBYxd6gdZY+0kETjwOQHnaPSjG1U2WLdxmZrjsdJ4Y=;
        b=SdxoTd/skkrCykVaET1+J+5hCEYXJHflSz6baJJCqEWp1bR12pNZ+YOSnreRIn2z9O
         w4cRr/IZ+DxMUaU9EiSvxQqzJDvx6MfHHJPoruwEc817OGmI+TxD33kEYPNSTzmhDX1Q
         PC4KvTxiTxEpQYDW+N5qq6QTzL+Qfscb3RYSvo/9nuQkpKqE0WkONClDJVKu+CJ3mpLD
         ZDSh0YbnXEq6vKDp6mT3OyjY6QAbmF8OqDOdYuDE8w3IkGBUgQeVU0pRx/moikeS5e5W
         wrLoCFz4RVkIej83adbPWFthi07otZnB+svAFq+7CWLtRx+bT3WR22cfpIFVsJcQfzDj
         R9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqBYxd6gdZY+0kETjwOQHnaPSjG1U2WLdxmZrjsdJ4Y=;
        b=kNMIuwZYPcVVxdpeCbCy6tQKZuprrJWcPDvv4g0xAX6iM3i0Q9P097W/taYNZxELiU
         D9KVtISsl3EXZ2jXefJVhzY1BzCnI/3HOVfWkb7sAzwNQPs5ux1nY+8ohWfV9NPYHoDI
         BftmMuJ8hu2DP5XwuAj9ZXufm2In5zforLeGws2NN2PtuKC0LGMMzR1YM/UWRSQ1Jn3g
         /xqjfGFD1tvk+VfcC2F4TMTdm6R6jsOCR82IlZy+gh2ijdMDyBFEZedUzkk8CgC+fvr5
         D60CL95wdDri5Fwwy9YQWItNZNZocRXNIJhKTqlD5nu+4jT2xtGW9knZC67rqCjZKTec
         zqpw==
X-Gm-Message-State: AOAM532RqqD7Lr4k5/2mIS77VN59z/wV9m64PzF8mcezvvDhhx85V0e/
        43tILSh/o4wYW8c92T78DSXasg==
X-Google-Smtp-Source: ABdhPJxS73ikw0/v0Vwi1QYdX2THvEu5KuDcpKF+LEfO1IH4NHOmAlTHM7m75YDQvXyuHNhQ8EtJ4A==
X-Received: by 2002:a5d:8543:: with SMTP id b3mr3599153ios.15.1603979072344;
        Thu, 29 Oct 2020 06:44:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:536c])
        by smtp.gmail.com with ESMTPSA id k8sm2347562ilh.8.2020.10.29.06.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 06:44:31 -0700 (PDT)
Date:   Thu, 29 Oct 2020 09:42:48 -0400
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
Subject: Re: [PATCH v20 11/20] mm/lru: move lock into lru_note_cost
Message-ID: <20201029134248.GA599825@cmpxchg.org>
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
 <1603968305-8026-12-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603968305-8026-12-git-send-email-alex.shi@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 06:44:56PM +0800, Alex Shi wrote:
> We have to move lru_lock into lru_note_cost, since it cycle up on memcg
> tree, for future per lruvec lru_lock replace. It's a bit ugly and may
> cost a bit more locking, but benefit from multiple memcg locking could
> cover the lost.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
