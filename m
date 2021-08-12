Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B343EA525
	for <lists+cgroups@lfdr.de>; Thu, 12 Aug 2021 15:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhHLNJT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 12 Aug 2021 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhHLNJT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 12 Aug 2021 09:09:19 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC28C061765
        for <cgroups@vger.kernel.org>; Thu, 12 Aug 2021 06:08:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id b1so5134488qtx.0
        for <cgroups@vger.kernel.org>; Thu, 12 Aug 2021 06:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xs8EmBt7Wwwk0rDo3WH++ioTrTW94g/xJg4dS2VTU70=;
        b=B5u5MqvyKhZf+vJdh29wKQ5uSD8KVQ0z4A9dz5siLPjFNEs9Fu1QKsbl48q8OWNNvx
         X4ln3uTu9KiU3bN7egPX0wn4rWzwnfWkD4P/g0gFBxGIu9O1Sf6TYSlH8mdfIAz8mErj
         6/PWaHr3fn5iEEtxLtwNcIJeYC4V2tN09GGiDZBWut3fVYh8EYt2ccqvTrlQ5K+ifegP
         zuYsHO0Nxi7bVcC2bq4BgAnOB6jAhAvKK9q6TdUr1otRZFE0dUqedOfPUNXl6r1YTguv
         vzFlBzPdQoSt6hcHDg2ohSM7NHejJkya7sFheFmnpVXUhaFzy2qGyo66NHt9MGVM9GaM
         Q/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xs8EmBt7Wwwk0rDo3WH++ioTrTW94g/xJg4dS2VTU70=;
        b=sswRelannx/AlTfh8IN3pQQc6ycfny29DKQoEf7+7RR/tZNE23D911G5Kw7gm/oYsk
         TOsCi8bdguzmn5UT59aS8tXFrLFE7JfxkRdTSkMBM0EuO5nLxAPma2KMfyyNJnMg3X4S
         NqaVfPiZR3w1IRw5+xF1okAfENHEsotQZb+8KJHOqWbFEW//J2tkSz7fOgkhOpZ3yPds
         zs/25rOb3ft4LO4Jx5lk3Nf5QIBNc+kVVsjF1hEaqWCFMz2PX8tFT63/1+HzR5u45fKG
         MnIv/qaHtoZif3qdHhXw8kZm3ySK4IQvynuT9igmzJoivSwVu2tgDErjRkG2GM2vs6Kf
         NeTg==
X-Gm-Message-State: AOAM5313L0vnj5CeedjrlvUI/7bXB6mgTe0BUnLGoUTk7mNXWta54BK9
        2WvumU599ud4Y0Gstcgn7hckQQ==
X-Google-Smtp-Source: ABdhPJyD1sQnwutEBQEi934zsMk0rmVovkjcAHalsbe125JSWOsOzFGplbTIi19IH9KQ5jnc9Xrcvg==
X-Received: by 2002:ac8:6b19:: with SMTP id w25mr3752598qts.222.1628773733005;
        Thu, 12 Aug 2021 06:08:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d9fa])
        by smtp.gmail.com with ESMTPSA id d16sm1036744qte.3.2021.08.12.06.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:08:51 -0700 (PDT)
Date:   Thu, 12 Aug 2021 09:08:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: Enable memory migration for cpuset v2
Message-ID: <YRUdYQzxj8rswNyz@cmpxchg.org>
References: <20210811195707.30851-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811195707.30851-1-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Aug 11, 2021 at 03:57:07PM -0400, Waiman Long wrote:
> When a user changes cpuset.cpus, each task in a v2 cpuset will be moved
> to one of the new cpus if it is not there already. For memory, however,
> they won't be migrated to the new nodes when cpuset.mems changes. This is
> an inconsistency in behavior.
> 
> In cpuset v1, there is a memory_migrate control file to enable such
> behavior by setting the CS_MEMORY_MIGRATE flag. Make it the default
> for cpuset v2 so that we have a consistent set of behavior for both
> cpus and memory.
> 
> There is certainly a cost to make memory migration the default, but it
> is a one time cost that shouldn't really matter as long as cpuset.mems
> isn't changed frequenty.  Update the cgroup-v2.rst file to document the
> new behavior and recommend against changing cpuset.mems frequently.
> 
> Since there won't be any concurrent access to the newly allocated cpuset
> structure in cpuset_css_alloc(), we can use the cheaper non-atomic
> __set_bit() instead of the more expensive atomic set_bit().
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

LGTM.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
