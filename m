Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992A91E2434
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgEZOf5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEZOf5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 10:35:57 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F5AC03E96D
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:35:57 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n141so8326832qke.2
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbXXCHKsbJxEBFGuFNxmnV1nB1pn7eVIzOVnQZl39BE=;
        b=L41qAU2gVYT6UQ3/bOvbAXNg6uvd0q5EUUFQIWCXmgMneAL7lD1EO+7yxopAGmBbf6
         gGVngFiyuJSjMD2/r4cxhC6nCZjpKYWRUpQ4lVcjOr7I8x9nXJL+LTGwoJh6imPZ4pCW
         BK0EI6BZWvYC6Q7984gFkoEgnMohmZO+bhIpboR9rO5xjdqymQVbE/TYU/pHJsbUnHGo
         UeJSseAupE6xTe2UkbOBVICNEroCr0oe2oaH0xdJwz9R4KwPiT5Dw1C1vnZ49PK5BsRa
         DQkaNdfm9ioT835YuZU7btJAX7o0+yeeLkYXr+b5WcxrQwbAA/N0oY2e1SqTvBmFePuH
         P0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbXXCHKsbJxEBFGuFNxmnV1nB1pn7eVIzOVnQZl39BE=;
        b=q9+Fxb7Gc+o2PqfRLjE0TQ9+yXmW+Tv1kyoY/hpBSuW5jBdS0rF+5SzAea8S2TjKFv
         icFr2L2H6dQqFsobQMc8khMtkSNHbAQhN57hZ8gnlUx8ATRpdbRkQ0TzqP3qAU/LJ/2Z
         /M/gVwqucbahERfR76sxm/NLi6isqDFg8lTCI2DN0uGD9UzXZLUkpyB77WgLetT1l/5q
         gA4PefQsvgqiI9gEmEQBsL74QsphYWV0m73dsltyxJBadLmMMRRHKaCv15AHLZNYpAiD
         +bsbrWRaS6Taqc7kYIyFG10fZfZWLGWUhDCd2hwXlqkx1NqLLSeAs26WTwuCGvT/UCww
         uZ4A==
X-Gm-Message-State: AOAM533dUb7TQH/ZXOH5vqzG/pKUVf84tXiChKq9zWqxyN+EEjGwHFuH
        Rh1rOfNA3Q1xJIeP0VzYhffLNg==
X-Google-Smtp-Source: ABdhPJxAZoMx3c1kWth3MvX3T+kjmEvAGGaEy+gFFs5TLo64uBPerv+BZlnlzou9IunUOYuUnyYvjg==
X-Received: by 2002:a37:812:: with SMTP id 18mr830706qki.296.1590503756472;
        Tue, 26 May 2020 07:35:56 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id i14sm4802143qkl.105.2020.05.26.07.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:35:55 -0700 (PDT)
Date:   Tue, 26 May 2020 10:35:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v5 RESEND 1/4] mm: prepare for swap over-high
 accounting and penalty calculation
Message-ID: <20200526143532.GA848026@cmpxchg.org>
References: <20200521002411.3963032-1-kuba@kernel.org>
 <20200521002411.3963032-2-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521002411.3963032-2-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 05:24:08PM -0700, Jakub Kicinski wrote:
> Slice the memory overage calculation logic a little bit so we can
> reuse it to apply a similar penalty to the swap. The logic which
> accesses the memory-specific fields (use and high values) has to
> be taken out of calculate_high_delay().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
