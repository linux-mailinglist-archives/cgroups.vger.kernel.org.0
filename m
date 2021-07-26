Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991C13D5CA5
	for <lists+cgroups@lfdr.de>; Mon, 26 Jul 2021 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhGZO2f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 26 Jul 2021 10:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbhGZO22 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 26 Jul 2021 10:28:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A54AC061765
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 08:08:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l18so3831677wrv.5
        for <cgroups@vger.kernel.org>; Mon, 26 Jul 2021 08:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e5UdpVMTyl73+A5rHVvGJWmZMwd2mW5mt6a1agF9/w0=;
        b=ahvP1aV30Q5DhpiTfESrw/1uit6mE2eyQx0Dj3mgQtJZYv4p5GVf/lKCMJ+uD2ss+y
         SXHM8sIUAu0PJhRKGMxHity57cFmp/Qf9k3UWaFUHT3+BZJj5IjFWnDmZgtw9KGPvC6b
         mr/VcZS5JlhxhPa3RoqSdgRyEaqh6ygghNYNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e5UdpVMTyl73+A5rHVvGJWmZMwd2mW5mt6a1agF9/w0=;
        b=TRoxdkJX1ytqF52SZuXQj86DEXEm/Up/uztmzFx20o1JKBpnlMOimt3jauMjQBs65u
         CkQPboKkBM/3iWLTQbgA67Ho93WlQJ/7WODZnBitk/T+NL7XcML/V2p31h/NDT5HLsTo
         nwEYN/AvEoUqPPBwr80bO8UqY90M8mFr3ZBplJZoOWHETBsBQZWg4sxt/v+XfHl8f2j+
         SG0Ibp1jl1YiNF12G1e6AGRRIHrf2s3z9Pl0q1uKQuu4zbVca8FszSdbEzVEc9utKhJz
         +AHB2aFvVKlxNSHHfOm8I3HchfvA9DcNrwyEJjgUxcOD97GXV4C6b5gbFaDaUjJckgHa
         yWTw==
X-Gm-Message-State: AOAM533chHJcyo1TM2c6VNF9OsKAMVxYHH5u5UmBfoH0XaiFXwbpNdU8
        JSgtZ/IR5ZfN38SIh7X0Un4slA==
X-Google-Smtp-Source: ABdhPJxksYL0bB8V5EKs51meFD1O34Bc4KHxexLtI3fSHzTLqVk0ZZZ2SMBHun+uolI/AKaH5VQ3IQ==
X-Received: by 2002:a5d:4951:: with SMTP id r17mr4063191wrs.208.1627312135650;
        Mon, 26 Jul 2021 08:08:55 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:d571])
        by smtp.gmail.com with ESMTPSA id f26sm71897wrd.41.2021.07.26.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:08:55 -0700 (PDT)
Date:   Mon, 26 Jul 2021 16:08:54 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix blocking rstat function called from
 atomic cgroup1 thresholding code
Message-ID: <YP7QBuc+5gAlL4g7@chrisdown.name>
References: <20210726150019.251820-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210726150019.251820-1-hannes@cmpxchg.org>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Johannes Weiner writes:
>Dan Carpenter reports:
>
>    The patch 2d146aa3aa84: "mm: memcontrol: switch to rstat" from Apr
>    29, 2021, leads to the following static checker warning:
>
>	    kernel/cgroup/rstat.c:200 cgroup_rstat_flush()
>	    warn: sleeping in atomic context
>
>    mm/memcontrol.c
>      3572  static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>      3573  {
>      3574          unsigned long val;
>      3575
>      3576          if (mem_cgroup_is_root(memcg)) {
>      3577                  cgroup_rstat_flush(memcg->css.cgroup);
>			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>    This is from static analysis and potentially a false positive.  The
>    problem is that mem_cgroup_usage() is called from __mem_cgroup_threshold()
>    which holds an rcu_read_lock().  And the cgroup_rstat_flush() function
>    can sleep.
>
>      3578                  val = memcg_page_state(memcg, NR_FILE_PAGES) +
>      3579                          memcg_page_state(memcg, NR_ANON_MAPPED);
>      3580                  if (swap)
>      3581                          val += memcg_page_state(memcg, MEMCG_SWAP);
>      3582          } else {
>      3583                  if (!swap)
>      3584                          val = page_counter_read(&memcg->memory);
>      3585                  else
>      3586                          val = page_counter_read(&memcg->memsw);
>      3587          }
>      3588          return val;
>      3589  }
>
>__mem_cgroup_threshold() indeed holds the rcu lock. In addition, the
>thresholding code is invoked during stat changes, and those contexts
>have irqs disabled as well. If the lock breaking occurs inside the
>flush function, it will result in a sleep from an atomic context.
>
>Use the irsafe flushing variant in mem_cgroup_usage() to fix this.
>
>Fixes: 2d146aa3aa84 ("mm: memcontrol: switch to rstat")
>Cc: <stable@vger.kernel.org>
>Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks, looks good.

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/memcontrol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index ae1f5d0cb581..eb8e87c4833f 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -3574,7 +3574,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> 	unsigned long val;
>
> 	if (mem_cgroup_is_root(memcg)) {
>-		cgroup_rstat_flush(memcg->css.cgroup);
>+		/* mem_cgroup_threshold() calls here from irqsafe context */
>+		cgroup_rstat_flush_irqsafe(memcg->css.cgroup);
> 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
> 			memcg_page_state(memcg, NR_ANON_MAPPED);
> 		if (swap)
>-- 
>2.32.0
>
>
