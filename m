Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8494F2CD45
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 19:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfE1RLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 13:11:31 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44018 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfE1RLb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 13:11:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id u27so15198342lfg.10;
        Tue, 28 May 2019 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A8QVP2Qf5aJcHIy8l49WfRPomDE8uUrBG/3Am/yYNlU=;
        b=tbj82VcOGB/BLqdwN+zId/aL1F3LbvsduOAs5GjftF3C0NFgGGQfU7vrCi+8ZFR4Ew
         uMeDuC9cIWItsZjEU/EYdPtcQbKmV0dwqkHg9AKjbOptmKOd7+DPQ5dAVm05PXKt+oqr
         Td+xYmJbU2LeazwHzmVCPZVcSIPUATTVRVMsqa/4LHzrIbZLk9+XKgatIB2qZQOx+2ZA
         HWq/fedWq82lYNQt9lABwgmMYVhppMEEmA50HzdtSJIgMvQoAuTqzJ3bJoQ5o3mjftyT
         3JTeLVmb57ufyHL1txvLiGXT8sTJqMyPMloJLNcl+S/m1XAOixYz0YB+OWBWw35SNfR1
         S1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A8QVP2Qf5aJcHIy8l49WfRPomDE8uUrBG/3Am/yYNlU=;
        b=YhNFAwgmYB6Uaj7F5WZV4dbf8W39BEFOTNyrERDVhxN1d0KuFcK41XtUHgC5E+qQ1g
         f12Fc5ZOmoHVFnnUXh6x+zAQyxs9cmg3ALRQhWISr533wgTRvTw+DHdZooVxyt9E5iup
         3tFJlwv7Jc6DZi8c2febJYYLkAsa70AsV8C/sab1v/u9diTa69LzxnGupT63x8Nl6LHN
         dmBWgLQp6ubHY1xZ/XYqaVAwOT3yxNkgqMEqzBcOW3LHd6JUsxvCsy879yPw5MGjFKh1
         s9oCv77QQb2V5RByJmYYFDVaN6HZR/8CljaSApSoTRVqBTdzoNy2ryI2psJV9pS9gp2f
         J+/g==
X-Gm-Message-State: APjAAAWwcnXwKOISIa21LjbqP9rU+kV5ZQSsOxHhOvL805cfNK4LHBXH
        1DozqopimoUBxNt/ZaHoFBM=
X-Google-Smtp-Source: APXvYqwQOyDJDkoWZFLu1XnDsguS/WvRfLzgNCnt9179uP3/qtkWME3gOICVuCXUEZgQ3/k83zfTpg==
X-Received: by 2002:a05:6512:6c:: with SMTP id i12mr45456509lfo.130.1559063489378;
        Tue, 28 May 2019 10:11:29 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id h22sm3057578ljk.86.2019.05.28.10.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 10:11:28 -0700 (PDT)
Date:   Tue, 28 May 2019 20:11:26 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Christoph Lameter <cl@linux.com>, cgroups@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 2/7] mm: generalize postponed non-root kmem_cache
 deactivation
Message-ID: <20190528171126.oaneakkydwyzied6@esperanza>
References: <20190521200735.2603003-1-guro@fb.com>
 <20190521200735.2603003-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521200735.2603003-3-guro@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 21, 2019 at 01:07:30PM -0700, Roman Gushchin wrote:
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 6e00bdf8618d..4e5b4292a763 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -866,11 +859,12 @@ static void flush_memcg_workqueue(struct kmem_cache *s)
>  	mutex_unlock(&slab_mutex);
>  
>  	/*
> -	 * SLUB deactivates the kmem_caches through call_rcu. Make
> +	 * SLAB and SLUB deactivate the kmem_caches through call_rcu. Make
>  	 * sure all registered rcu callbacks have been invoked.
>  	 */
> -	if (IS_ENABLED(CONFIG_SLUB))
> -		rcu_barrier();
> +#ifndef CONFIG_SLOB
> +	rcu_barrier();
> +#endif

Nit: you don't need to check CONFIG_SLOB here as this code is under
CONFIG_MEMCG_KMEM which depends on !SLOB.

Other than that, the patch looks good to me, provided using rcu for slab
deactivation proves to be really necessary, although I'd split it in two
patches - one doing renaming another refactoring - easier to review that
way.
