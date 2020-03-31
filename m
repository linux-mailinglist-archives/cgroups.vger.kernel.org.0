Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF8A7199C78
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2020 19:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbgCaRES (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Mar 2020 13:04:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40643 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgCaRES (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Mar 2020 13:04:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id u10so26965578wro.7
        for <cgroups@vger.kernel.org>; Tue, 31 Mar 2020 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MfpJb9zskhXycF6Q+P3UTVTg3zrJvxkcEUgjbQFmfg=;
        b=pZsnQlx7/55ukASiC3RMQ5r/VpGpt2sx3fZv4j1t5eR0lL10S2G4wpBjHN2OsIgtCn
         KDGVXMzzasVXuh0uhzi5yOdpNZ+vUfAIwB7wIP+I1kFSUB+EG32TYMcVi5PRnLZKPf4c
         0M7AXZdWVpu+HwUc1q3BzVJz1NqBP6gcWGb00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MfpJb9zskhXycF6Q+P3UTVTg3zrJvxkcEUgjbQFmfg=;
        b=fcuGDJfFadBI6oJEfG8r+n6klH9xl5LPgFjzTSumobk0UbEp68W2EXiM/D/6LaeuYr
         zVVfA3cjbgfb+TYAJJtjcwWPbjXHE4GZC9cR81rP/eh+0HOfkzDCjsm5Vpd3texL2KP5
         YGBV2s4HkUkIl/le9qmXmveLKvJZVVwriBnevrmg1/Xmh4jw2n9XpHK9jAx6pq1n68GR
         RAtPJK+F8DZoiDrKY0hGj1OtcilinWA46x1Gy847scsU6mnOPrpVlPtKL/E7fZLxI6dZ
         ej7jga71xITImB13tsd0mU0ttgDxWWR5VL/c7Do81YXPBSYljg8T+B0RoxLRjhB35UGM
         s1dQ==
X-Gm-Message-State: ANhLgQ2sy26ZgnwST532SinJ8KMej0vbnGFIDIhuX/0Tz3O5qxffOlIT
        aF1A5kRZmDvzPO7+LdGDVXgfVQ==
X-Google-Smtp-Source: ADFU+vsyRM3LsPUxIXkBsY97QN1fJN2ENc2TMRygohrVkAY6lDjYhTsc8BzhHSDzgxzhXYr4e9HAFA==
X-Received: by 2002:adf:916f:: with SMTP id j102mr20527218wrj.335.1585674256639;
        Tue, 31 Mar 2020 10:04:16 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id r9sm4700820wma.47.2020.03.31.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:04:16 -0700 (PDT)
Date:   Tue, 31 Mar 2020 18:04:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331170410.GB972283@chrisdown.name>
References: <20200331152424.GA1019937@chrisdown.name>
 <20200331155752.GN30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200331155752.GN30449@dhcp22.suse.cz>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>I find this paragraph rather confusing. This is essentially an unsigned
>underflow when any of the memcg up the hierarchy is below the high
>limit, right?  There doesn't really seem anything complex in such a
>hierarchy.

The conditions to trigger the bug itself are easy, but having it obviously 
visible in tests requires a moderately complex hierarchy, since in the basic 
case ancestor_usage is "similar enough" to the test leaf cgroup's usage.
