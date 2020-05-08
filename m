Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5CA1CBA43
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 23:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgEHV4e (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgEHV4e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 17:56:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2CC05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 14:56:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g185so3387947qke.7
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 14:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zne5kD9U815Qp7lQoOfSkfWPnKdq4UH7l4ACZ1laQI=;
        b=rVWxHIzDFvif9rrgKfKEzuzUqpug84jgH+pn6g2K+if7ys4WCpoBTPfsO3vQPvKAhN
         yVfFa2Lp+fBa+5PTkzDejJhE9e4mKzNB4oFie8Fb4O99NmTGN8QvA+xTxmSSZnk3ibBc
         HY2i6VFZUdjANcY0MDN1d4b9v0m8v8op+VhiOv7vwRUaW0FVadyL0QI7pMaOVKtzkkDK
         eICt41IJctDdTY3MUPL17fid7XHKjjKefy0raEReMlnpRuJoXM9b+XyKVFxobwnSPF9F
         Mh/uSrnjUReBhhaHgRTzE7vs/YNfmZ2ip7aKqPqWJrOr4nWGMCvhk2K4BK7cIVcztiM7
         Ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zne5kD9U815Qp7lQoOfSkfWPnKdq4UH7l4ACZ1laQI=;
        b=TS46cA3McqqUgkgOQrL4PAlhU/qFZecCwHeokMA+Y+im5f9MjsqyXDXQSsqoU8vBjN
         VcUQdDj6pJ0tIsQkhFisWReyNPHMqzB6iIOciE3Z0xFZYIzAAYZMc5sYAv28uqgV9WkS
         ojyZNOcaStJ5MdcViMPi7i0QKX41vDSmSv768cQXKxgAgnaYw0DOLaBq3QQ27JELgLJu
         WIZjQSfW+RwT+mzTIl9lNmZ4zt3vJJq/pVmaMr5ykUAw5hOGEX1JOL4i2bTKRWMiGb1Y
         Ehc9ilqQ5LhOgmlLD52QKt2L4bbBhguZfG6OYxyyLuEInbwm7eU8dHnMN/ogzg1psqaU
         2PiQ==
X-Gm-Message-State: AGi0PubF+N4Ao8GbtWIzytaCGcXKfx5C10KLUfwb+WMHJ6kPoh2Fqja5
        42Ks5TzNnJvVjNQtgA3uZ6iZijbRZyA=
X-Google-Smtp-Source: APiQypLlrrLFKBShNnNVF90buqGFklh0fnoXQOu7te0s+VgmO3xy05UxmrY5DdaE5ky534ULac25jA==
X-Received: by 2002:a37:ac08:: with SMTP id e8mr4618592qkm.439.1588974993311;
        Fri, 08 May 2020 14:56:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id x8sm2438260qti.51.2020.05.08.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:56:32 -0700 (PDT)
Date:   Fri, 8 May 2020 17:56:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: swap: memcg: fix memcg stats for huge pages
Message-ID: <20200508215616.GD226164@cmpxchg.org>
References: <20200508212215.181307-1-shakeelb@google.com>
 <20200508212215.181307-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508212215.181307-2-shakeelb@google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 08, 2020 at 02:22:14PM -0700, Shakeel Butt wrote:
> The commit 2262185c5b28 ("mm: per-cgroup memory reclaim stats") added
> PGLAZYFREE, PGACTIVATE & PGDEACTIVATE stats for cgroups but missed
> couple of places and PGLAZYFREE missed huge page handling. Fix that.
> Also for PGLAZYFREE use the irq-unsafe function to update as the irq is
> already disabled.
> 
> Fixes: 2262185c5b28 ("mm: per-cgroup memory reclaim stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
