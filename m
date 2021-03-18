Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48909340861
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 16:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhCRPDY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhCRPDN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 11:03:13 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD84C06175F
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:03:13 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id a9so2225722qkn.13
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z7lTVVRuSUfjS6oFurvBuW+lqnBMNQb+/M9MCKQeJGA=;
        b=hAWWBQ5r7q2qGQHnUkSAaN9SgxOHXzxDQuWPR9UYpiwDv9bKlXuBl9O9bQwvhnecCX
         V9pMmBkWY/uctykn77aF8/spzsmXw8rM3L1lJxcvgPVmo/SS9Om1LTqmDdxw+UClUl+U
         PxAWoeJhP4OsOJtOJ3+na7BN9Glh4mTVNyUPNu/gGjoJ8vh5fbhD8H07IOHGxhH7LMjr
         /V8tIIGrAfHjCGBzUlMuMltFDshNKlOb9J2//RnV6fYCAyAd27Oo3Bu4BbmmqdwkJW4D
         sh9KvbypBkoy7kBfHZUEhCtnPsonmS0cioBYmureMdgxGY8s8YIfL0vdL0H+/uwAz82k
         8e7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z7lTVVRuSUfjS6oFurvBuW+lqnBMNQb+/M9MCKQeJGA=;
        b=EqQ72cHuuozJEq7BZZC8kalaBp1lCiKfhvWywraHEE9da3HGH9ZLJL52e48OYyuaiO
         XqcAcCuvnBkS5ot27f6ysS30vPfrtzXB0/QceEeK7u2X7tJXhhTgiw+FizcotdrZ20Dy
         YD8MEv3/fQp+L9p7yDZ0v76/xqzHn9bFz7Nn5iRzwYBEweWB0nTAZOESA/W89ABbbW/t
         nzMMQt9aVXO3iiUtPrdoU6o0fE15y5wK7MekkYuZIe3bFcSdeVQshujA2J8GPtLLOYJj
         hezNW7bnqQQIAwFK8dGuKPopMsbuT8uqIwziwLcSDDwsyXkDLwRjct3ZMxe2kiIYHRhH
         s2MA==
X-Gm-Message-State: AOAM533Yp5B74ZWQ2Omj2YFDJ0XpksMWbF5RwfTdyb9sWXdA05IjLVNp
        6fv6E8yvyWFT0F/zjDe84UpXWQ==
X-Google-Smtp-Source: ABdhPJyIgDLaHHCU8sW5eq1vsv7FTz+05aFOuJTSx/oJJ18ACJl8GOweg+N0HKmwfRR5GC3cJg4xuQ==
X-Received: by 2002:a05:620a:641:: with SMTP id a1mr4568571qka.257.1616079792499;
        Thu, 18 Mar 2021 08:03:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id g2sm1626319qtu.0.2021.03.18.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:03:12 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:03:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] memcg: set page->private before calling swap_readpage
Message-ID: <YFNrrlPBmdgdanH1@cmpxchg.org>
References: <20210318015959.2986837-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318015959.2986837-1-shakeelb@google.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 17, 2021 at 06:59:59PM -0700, Shakeel Butt wrote:
> The function swap_readpage() (and other functions it call) extracts swap
> entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
> skips the swapcache and thus we need to manually set the page->private
> with the swap entry before calling swap_readpage().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Heiko Carstens <hca@linux.ibm.com>

LGTM
