Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8488C1E2437
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 16:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgEZOgo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 10:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEZOgo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 10:36:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541EEC03E96D
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:36:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b27so10749242qka.4
        for <cgroups@vger.kernel.org>; Tue, 26 May 2020 07:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSMxkbANh+XLN6PP/4ucZuGEACp8kUKlkMdq6GXfIvM=;
        b=U+0g7ZbyD4qZebQ9Yr1Tde+o7I3mql3aPxL8sWDvzlxU5cmn3t+uZbtx6mIDzprHCt
         2C1fQt0QvnAPRBhgLV1A3bTwEtphKN0Lc25f0vKTBeBo2MSRgY/a7fkL6Pa7k6lRb8ZM
         94e45AvYbveRYbGHyWuW2Njv/RRLthFzznzNwqkkTSBAhWQdyICWRSo5fZ3SIx4kGrU0
         mNrFMJNxiRIop05HbW3bdvfcWD+GC1x8BjbP9We1hQ/lH+EkPK6bs2I7dwerFkfHRpxL
         iYavJ0KJ10REHmnxvLdjnI4beMn21lvjWSTncPsPsjtGSDIS0L6UPtmAoe3Qu8OSCfol
         CYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSMxkbANh+XLN6PP/4ucZuGEACp8kUKlkMdq6GXfIvM=;
        b=ivlQS3CGtwHNHO6EAUoeldp3HY/rhB9xK0JW68Uw5EFjYOyDvi4RW1ZDKYERLO2FS4
         bZZK5HgtAKjHoev9HfLjysuX0v5IA7k5RbKo0q/Ey6FW0gOK3hx2y6A+jednJaTG88It
         3OfyphEqmR8AU0TxspYv++QGg2gCw1aWJphpXGEVzx4YNxMcfiZB+yQ1UF8hGLJ5YGQz
         Jo0EYGNJqfmHqFQq23tbq8hMTvWqwYdT2qfIMoI4F3DBKJ+/P9zcuqM6apfOp/HIaIde
         5pxZ91egNsI73IF3vz6bwChYP+FvbsLC9S4ywQCfrLgPUYBjnuqZbxF2hMoruTs5prSq
         WoCg==
X-Gm-Message-State: AOAM531rqT+nZESDJMw0U+ychI8G54gUMgjmcLb2UVUCbBwY7DeFKmx2
        FvXq3H1pkKhJ2ttyuBWQml/RJQ==
X-Google-Smtp-Source: ABdhPJwOKF5sdpcFqW9yOgw50aYn4nD7GBnxXJATNZK4P49/0FheNH4a5ZFyHsrHdK8qUHMPywDWGw==
X-Received: by 2002:a37:4c11:: with SMTP id z17mr1549126qka.180.1590503803641;
        Tue, 26 May 2020 07:36:43 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id i3sm17142417qkf.39.2020.05.26.07.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 07:36:43 -0700 (PDT)
Date:   Tue, 26 May 2020 10:36:19 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, chris@chrisdown.name, cgroups@vger.kernel.org,
        shakeelb@google.com, mhocko@kernel.org
Subject: Re: [PATCH mm v5 RESEND 2/4] mm: move penalty delay clamping out of
 calculate_high_delay()
Message-ID: <20200526143619.GB848026@cmpxchg.org>
References: <20200521002411.3963032-1-kuba@kernel.org>
 <20200521002411.3963032-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521002411.3963032-3-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 20, 2020 at 05:24:09PM -0700, Jakub Kicinski wrote:
> We will want to call calculate_high_delay() twice - once for
> memory and once for swap, and we should apply the clamp value
> to sum of the penalties. Clamping has to be applied outside
> of calculate_high_delay().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
