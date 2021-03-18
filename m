Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A5D34085E
	for <lists+cgroups@lfdr.de>; Thu, 18 Mar 2021 16:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhCRPCw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 18 Mar 2021 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhCRPCU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 18 Mar 2021 11:02:20 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F57C06174A
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:02:20 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id l4so2297557qkl.0
        for <cgroups@vger.kernel.org>; Thu, 18 Mar 2021 08:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODku1sNI+qzXn1A0+oyYPRNoNufpW48D4xQgC/ecSb8=;
        b=hywKb9JeRd9aGyWq9FNaxWtEEW+yd82HTdswTVDd+YNG4CK4ZnSRTzRkxPwIlz3Wvy
         vUYCvr9m0vMQnHTsXASTFTDUD3quCYQd9i5tW7wERWnJdNCkzr67eUw5wTX6qg17tofO
         9RIb8wyrDa16vhsBdb2rZ68Ayv/cCciBiG1872zqL2E2adC+QLbEOFMixg2/K3jZEHJr
         JhI2uGgNAw1Z8EZKhaw9kxkZp1+2fdIJhxiq9F9xa/NdGrlZyijiKRnp1DmGv4d0ldn6
         MmiSWRlu3ortORbGmJAt5W7Uvf/CRMcPBb+0uOhER92DsjeQfjpL7iqD81yoelklufuB
         KhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODku1sNI+qzXn1A0+oyYPRNoNufpW48D4xQgC/ecSb8=;
        b=fyTP5LKBgMsLEz8HIQsQo7pRl60Wlf21uq+BFOdG/lZ1HbVZkjFwTR0LzMoTG3Xd8Y
         vrJe0fdjpb974aTWaFUG7/l5iCja2h4Ge+zEFy/McC+WkWS24+MK8lDq+CE3jDEfmwQD
         WxtXidUImiwtpHQOcCnyp57YC/VsKMzntAKlALlL2Ag71cR2++njHcLkOO393rEk3NLD
         0PyVg6ZewoC90JcEy4MsF+iQ4wEEjbUtpj4E/FM8VsqhCRBHqqWZs43xyNcg8Y2CqXBh
         VEOrKOjLHXQZAz9+9pyUtFpZOjKiad3SbikUF2Kph1so7E2VpeKEvyntoB88rWX3Y5Yd
         WdMg==
X-Gm-Message-State: AOAM530GXkWGMwRddu/W63YjH0nkucCe5ksP7dz5f0FCoJgPfgQr2BSo
        BUeqIof3Bsl6ifnyUzizuCYc1Q==
X-Google-Smtp-Source: ABdhPJzFwtMozhLsIS+BLcUnGrqDnpo8h60S/acyTWSOZHCapzWUxzzGAFfzt9inGi1480dvSUHVSQ==
X-Received: by 2002:a05:620a:4504:: with SMTP id t4mr4706137qkp.369.1616079739411;
        Thu, 18 Mar 2021 08:02:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e46c])
        by smtp.gmail.com with ESMTPSA id d10sm1947661qko.70.2021.03.18.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:02:18 -0700 (PDT)
Date:   Thu, 18 Mar 2021 11:02:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH] memcg: set page->private before calling swap_readpage
Message-ID: <YFNreYne/27T9XA8@cmpxchg.org>
References: <20210318015959.2986837-1-shakeelb@google.com>
 <YFNdNeczjnmF55bm@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNdNeczjnmF55bm@dhcp22.suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 18, 2021 at 03:01:25PM +0100, Michal Hocko wrote:
> On Wed 17-03-21 18:59:59, Shakeel Butt wrote:
> > The function swap_readpage() (and other functions it call) extracts swap
> > entry from page->private. However for SWP_SYNCHRONOUS_IO, the kernel
> > skips the swapcache and thus we need to manually set the page->private
> > with the swap entry before calling swap_readpage().
> 
> One thing that is not really clear to me is whether/why this is only
> needed with your patch. Can you expand a bit on that please? Maybe I am
> just missing something obvious but I just do not see any connection.

It was always needed, his original patch erroneously removed it.
