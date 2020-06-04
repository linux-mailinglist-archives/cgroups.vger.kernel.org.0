Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D811EE816
	for <lists+cgroups@lfdr.de>; Thu,  4 Jun 2020 17:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgFDP5I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Jun 2020 11:57:08 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42864 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729216AbgFDP5I (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Jun 2020 11:57:08 -0400
Received: by mail-ej1-f66.google.com with SMTP id k11so6658705ejr.9
        for <cgroups@vger.kernel.org>; Thu, 04 Jun 2020 08:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Icf5qOuQ0PqhfFGqACEYzjrp6a9b4hmTL4gSujxhojA=;
        b=L9Dy4FeF0FsnZXBCPMytTOwIkCbMyC/ZYXA+dFhQFwsXjErvuByk5D6x/IkcMWlSW8
         ooyfYiJgN3WmM0yuB2pqzngU5v4H+/H8OZzW+uK3/WBU1mTqTnsZIEZ6m7PHhbcPzpY7
         eDUN66xRszZPUuno7Vcl1VFO2nfldFmhq/684PC1HBSUn3kTUYkGzSIg+UljvJvWqiqQ
         4oTWcpQ0VwWWE7mCkJtBnzQISdPZ+z/j29/ZKWjR3evswekM89sY2A2l3NzYlqXMXubC
         LJqqQ4Dnwji/f/oWuTtKfhdKplTP2LJXj9FMCxTfXrK2WxDwhE3Q7QFQ7cL3S2sDlaf+
         sGOg==
X-Gm-Message-State: AOAM531ov6A4ZJzOdgumrwQ1Fvmt1AYJYu2KM+vtqNsH7TWymKTyuJxo
        W5BcNPGTvXr7NtIxxn7f9YA=
X-Google-Smtp-Source: ABdhPJz0IXqhK/g0xGjZ0NqbNofp5gGXOAMGVRTQ4INUODYUzpJ42S9KNHPAn4Ts5G6tNTwjSc1EFg==
X-Received: by 2002:a17:907:b15:: with SMTP id h21mr4573394ejl.450.1591286226320;
        Thu, 04 Jun 2020 08:57:06 -0700 (PDT)
Received: from localhost (ip-37-188-245-182.eurotel.cz. [37.188.245.182])
        by smtp.gmail.com with ESMTPSA id l8sm2533564ejz.52.2020.06.04.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 08:57:04 -0700 (PDT)
Date:   Thu, 4 Jun 2020 17:57:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v6 4/4] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200604155700.GD4362@dhcp22.suse.cz>
References: <20200527195846.102707-1-kuba@kernel.org>
 <20200527195846.102707-5-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527195846.102707-5-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 27-05-20 12:58:46, Jakub Kicinski wrote:
> Add a memory.swap.high knob, which can be used to protect the system
> from SWAP exhaustion. The mechanism used for penalizing is similar
> to memory.high penalty (sleep on return to user space).
> 
> That is not to say that the knob itself is equivalent to memory.high.
> The objective is more to protect the system from potentially buggy
> tasks consuming a lot of swap and impacting other tasks, or even
> bringing the whole system to stand still with complete SWAP
> exhaustion. Hopefully without the need to find per-task hard
> limits.
> 
> Slowing misbehaving tasks down gradually allows user space oom
> killers or other protection mechanisms to react. oomd and earlyoom
> already do killing based on swap exhaustion, and memory.swap.high
> protection will help implement such userspace oom policies more
> reliably.
> 
> We can use one counter for number of pages allocated under
> pressure to save struct task space and avoid two separate
> hierarchy walks on the hot path. The exact overage is
> calculated on return to user space, anyway.
> 
> Take the new high limit into account when determining if swap
> is "full". Borrowing the explanation from Johannes:
> 
>   The idea behind "swap full" is that as long as the workload has plenty
>   of swap space available and it's not changing its memory contents, it
>   makes sense to generously hold on to copies of data in the swap
>   device, even after the swapin. A later reclaim cycle can drop the page
>   without any IO. Trading disk space for IO.
> 
>   But the only two ways to reclaim a swap slot is when they're faulted
>   in and the references go away, or by scanning the virtual address space
>   like swapoff does - which is very expensive (one could argue it's too
>   expensive even for swapoff, it's often more practical to just reboot).
> 
>   So at some point in the fill level, we have to start freeing up swap
>   slots on fault/swapin. Otherwise we could eventually run out of swap
>   slots while they're filled with copies of data that is also in RAM.
> 
>   We don't want to OOM a workload because its available swap space is
>   filled with redundant cache.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I am sorry for being late here but thanks for adding clarifications
which make the semantic much more clear now! Also thanks for simplifying 
the throttling implementation. If a different scaling is needed then
this can be added later on.

I do not see any other problems with the patch.

Thanks!
-- 
Michal Hocko
SUSE Labs
