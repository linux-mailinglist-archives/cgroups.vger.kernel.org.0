Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D942A1B37A3
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2020 08:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDVGlp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Apr 2020 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgDVGlo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Apr 2020 02:41:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5622C03C1A6;
        Tue, 21 Apr 2020 23:41:44 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b8so582310pfp.8;
        Tue, 21 Apr 2020 23:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHdvDOllQWAa51R+Fb+AFKea2IfMdQevdkCOltYp2Bg=;
        b=ZVWkRcS052Kc6o3h3NDPurylsN58IsNi3UfUKY6ZB4/enpkd4UC5OC/GNbgrjlmXR4
         0bbbIzvjh8nJRwQ9mYUK5cCuAyJkY7OnwHGemniWr9zZLfI+przXMtp69I8t/vKr+Ycz
         yxQXvekQMg/bEE+Yjjry3/vVWH2Y/ILe3QmE90cQTlmL1p4WHPcOQ9mXOcu/dcypSOJI
         9dor/2cX33nDx9lDz5rhEmADMhqv2x2kkmX8mbEN2RjP/RMDPPWzqzZu12ylEX5sczz5
         TR/5X09hqnJfmKZLW4i8Bw9xYsorD21TGEZUAjAWRUY7WbuvQ5sTw3FNEyL4kEqnm5QC
         iQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHdvDOllQWAa51R+Fb+AFKea2IfMdQevdkCOltYp2Bg=;
        b=GxMiZ6imKux6ZZyvUyecKd0oylMcOi8q6xBeF4hqchwDiDJpazcQBgBMwwkZoJBdwg
         zS921xtUk5C41AKjIwwc0NKvZ8UFealI75bCEbZNZS8JESZmJ6uL3OjNCONAllREX5y/
         wRpo3Fgibnw3MfdYEjUcWLBr0O5PaRf3RUKFpnWN9oAjGIt3cZJQrLDI0zm+huMIvBTg
         9LHqWCQzG+Nv88tIe92ptgLoqhuPG3drxQLYKHCOTCKGhocc+EqZ3vi+mMC05QoMbk4A
         He2opZ8uKmwRwU8YZa7hCiZJLOjuAtpL8/50pi9ch+KFv3ZeGpX20evhWz0HZY5QacBJ
         GYpA==
X-Gm-Message-State: AGi0PuYXtJitQ7nnrEUppl56DRY6LsfRJR6OUN8Ggdi45uMgEMQb2X8Q
        rFvmNLXxCk6pZ/WNvj1aVoVnz4m0CiU=
X-Google-Smtp-Source: APiQypKwSsucs0koGf/EZo4j2dCcsIvA9TU22pC/FEZyHGH+vXdenU+CwYBX7VRpgeGM2yJsq1I7NA==
X-Received: by 2002:a62:1a53:: with SMTP id a80mr26723331pfa.157.1587537704302;
        Tue, 21 Apr 2020 23:41:44 -0700 (PDT)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id dw12sm2694017pjb.31.2020.04.21.23.41.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2020 23:41:44 -0700 (PDT)
Date:   Wed, 22 Apr 2020 15:41:38 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 07/18] mm: memcontrol: prepare move_account for removal
 of private page type counters
Message-ID: <20200422064138.GG6780@js1304-desktop>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-8-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-8-hannes@cmpxchg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:15PM -0400, Johannes Weiner wrote:
> When memcg uses the generic vmstat counters, it doesn't need to do
> anything at charging and uncharging time. It does, however, need to
> migrate counts when pages move to a different cgroup in move_account.
> 
> Prepare the move_account function for the arrival of NR_FILE_PAGES,
> NR_ANON_MAPPED, NR_ANON_THPS etc. by having a branch for files and a
> branch for anon, which can then divided into sub-branches.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

