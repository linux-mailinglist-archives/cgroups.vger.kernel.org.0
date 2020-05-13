Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3BD1D0AEF
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2020 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732239AbgEMIiU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 May 2020 04:38:20 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33820 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgEMIiS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 May 2020 04:38:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g14so11263102wme.1
        for <cgroups@vger.kernel.org>; Wed, 13 May 2020 01:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oFsa0LErIymXz9nEeCHbYZeDaAUm0vYvIFciXQM1UZ0=;
        b=pJzmvjNR2WTIBASTLt/LK59fcUGNcyS3tDpAfJevcfmoP9sADDLK4EmzHYUQYGxQBI
         jTXNxVBQYFftfT3HfwU2RbfUsfDcptJNjf1O3yfyNk6atgNWht6smiSqCIKhTAwQ0Pke
         YIZ0ZD/JFOTilEdn5qq6sfxVKKfe/CM7GcAKJknyHqcdPSXaSUmCBt5Sdkzvl8BCbYas
         vD3QXrNQFM+eijDzAQWTJxFKK1JgElzO57hpBDW0rjiDyJVtUvsGPIAaGlKWMfgpMibn
         ovSlMnlQpPVN05gNWdwIit8nIDLIyYEMJmRle47FrsutufxkBE4dgNPKKbo/ksXp73i9
         LsWw==
X-Gm-Message-State: AGi0PubYJANzfffdY2vQvHVLZZzljZL4mmpmlunJdR1eytOZdrGnQHDy
        jLmEHaUjwVB63rYo1Key+4w=
X-Google-Smtp-Source: APiQypLN3NH5oB3pG5WZOnYlbIG9ZnAPA9fHndBOkVLpR2E+bgJBOtS0RvbIZ9Ok5yWxJrSqLWPaAw==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr40091267wmj.3.1589359096391;
        Wed, 13 May 2020 01:38:16 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id j2sm26800817wrp.47.2020.05.13.01.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:38:15 -0700 (PDT)
Date:   Wed, 13 May 2020 10:38:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org, kernel-team@fb.com,
        tj@kernel.org, hannes@cmpxchg.org, chris@chrisdown.name,
        cgroups@vger.kernel.org, shakeelb@google.com
Subject: Re: [PATCH mm v2 3/3] mm: automatically penalize tasks with high
 swap use
Message-ID: <20200513083814.GT29153@dhcp22.suse.cz>
References: <20200511225516.2431921-1-kuba@kernel.org>
 <20200511225516.2431921-4-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511225516.2431921-4-kuba@kernel.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 11-05-20 15:55:16, Jakub Kicinski wrote:
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5f12f203822e..c60226daa193 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1374,6 +1374,22 @@ PAGE_SIZE multiple when read back.
>  	The total amount of swap currently being used by the cgroup
>  	and its descendants.
>  
> +  memory.swap.high
> +	A read-write single value file which exists on non-root
> +	cgroups.  The default is "max".
> +
> +	Swap usage throttle limit.  If a cgroup's swap usage exceeds
> +	this limit, all its further allocations will be throttled to
> +	allow userspace to implement custom out-of-memory procedures.
> +
> +	This limit marks a point of no return for the cgroup. It is NOT
> +	designed to manage the amount of swapping a workload does
> +	during regular operation. Compare to memory.swap.max, which
> +	prohibits swapping past a set amount, but lets the cgroup
> +	continue unimpeded as long as other memory can be reclaimed.
> +
> +	Healthy workloads are not expected to reach this limit.
> +

Btw. I forgot to mention that before but you should also add a
documentation for the swap high event to this file.
-- 
Michal Hocko
SUSE Labs
