Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962A82205A2
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2020 09:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgGOHAH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Jul 2020 03:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbgGOHAH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Jul 2020 03:00:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8636C061755
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 00:00:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so1996456plt.7
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2020 00:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yBPygJDADyMNow8RF1wBXyoTGHqGjUzbugs5/7dNL0M=;
        b=n3ujhdyrkJ3XIm1Z2m0bjNTlOXVZRaAKbX073AtF4CoZfp+JL5moww96IYfa2Zp6CO
         Z6Hpm2uebEQCM39VwWuSv++0g/CcDGivEP6viEe3torjfdNt+1bgd5ow3ddxRujlYM1r
         Kiul0VFbezJQl35UeARAsbD+a2xyGDc6at7km2HIaGUEGtwGicYcaBJW2GGB5fUWLhel
         brUXOz/U12156GNtfE9BR15WhuZAUbuq85QdwqByA23LPsYe1f108hICSjufwSdbH/Vy
         5NHSLei0PXIsxhmxPDQ06sW0iedaGzmzOl6dLXc4qRJnfKeJNvQd4chCnVs7uO8C8FuJ
         i8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yBPygJDADyMNow8RF1wBXyoTGHqGjUzbugs5/7dNL0M=;
        b=NcHE93jpdnTTmdk0fU/0b6Wqdp1MSH6cZ+g1qD22zo6mgxed3l0N0g/CRXCLAIrIdp
         rnd2xhIf3ADVAcmQoQnuixTRr5prwj/nLw0xNX2Ukuytjoxz60X/o94A6EXvIZvddtSJ
         4aeYKnttdL/zfnl2bnCe6KLeVfqBAbezsY+16brnA1pWcMs2N7OfMOjpm1+afBpSpolY
         v+9kCRoatbMZGpzKdtFkZzqC1egV/tT7IfVSOYHOM2sPCuX/DOUu62AWJGukWHl4v+r5
         0/HplHnRbaGbIEZZy0S3bcc1bIFNW/mm6X8UgnRGCyNgDwdU6or8Cr7sZxf2MuYy+UX+
         GgMA==
X-Gm-Message-State: AOAM531iuhdg+Lx2QARllGDb8oYZuO31ZN9nDfO7pz8AGvFqnoDaTuJ/
        MXvzKnZGdZhBz60sFiYV9288PQ==
X-Google-Smtp-Source: ABdhPJyPnCMJ8yxvUFrjJQm7SHOtB4nUtjz+pspNUf7GK2HE55bWBAiVOa+UnCEl+v+Er1qQDKLSUQ==
X-Received: by 2002:a17:902:c086:: with SMTP id j6mr6867497pld.293.1594796405104;
        Wed, 15 Jul 2020 00:00:05 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id cv7sm1029072pjb.9.2020.07.15.00.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 00:00:04 -0700 (PDT)
Date:   Wed, 15 Jul 2020 00:00:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide a stat to describe reclaimable
 memory
In-Reply-To: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
Message-ID: <alpine.DEB.2.23.453.2007142353350.2694999@chino.kir.corp.google.com>
References: <alpine.DEB.2.23.453.2007142018150.2667860@chino.kir.corp.google.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, 14 Jul 2020, David Rientjes wrote:

> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1314,6 +1314,18 @@ PAGE_SIZE multiple when read back.
>  		Part of "slab" that cannot be reclaimed on memory
>  		pressure.
>  
> +	  avail
> +		An estimate of how much memory can be made available for
> +		starting new applications, similar to MemAvailable from
> +		/proc/meminfo (Documentation/filesystems/proc.rst).
> +
> +		This is derived by assuming that half of page cahce and
> +		reclaimable slab can be uncharged without significantly
> +		impacting the workload, similar to MemAvailable.  It also
> +		factors in the amount of lazy freeable memory (MADV_FREE) and
> +		compound pages that can be split and uncharged under memory
> +		pressure.
> +
>  	  pgfault
>  		Total number of page faults incurred
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1350,6 +1350,35 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> +/*
> + * Returns an estimate of the amount of available memory that can be reclaimed
> + * for a memcg, in pages.
> + */
> +static unsigned long mem_cgroup_avail(struct mem_cgroup *memcg)
> +{
> +	long deferred, lazyfree;
> +
> +	/*
> +	 * Deferred pages are charged anonymous pages that are on the LRU but
> +	 * are unmapped.  These compound pages are split under memory pressure.
> +	 */
> +	deferred = max_t(long, memcg_page_state(memcg, NR_ACTIVE_ANON) +
> +			       memcg_page_state(memcg, NR_INACTIVE_ANON) -
> +			       memcg_page_state(memcg, NR_ANON_MAPPED), 0);
> +	/*
> +	 * Lazyfree pages are charged clean anonymous pages that are on the file
> +	 * LRU and can be reclaimed under memory pressure.
> +	 */
> +	lazyfree = max_t(long, memcg_page_state(memcg, NR_ACTIVE_FILE) +
> +			       memcg_page_state(memcg, NR_INACTIVE_FILE) -
> +			       memcg_page_state(memcg, NR_FILE_PAGES), 0);
> +
> +	/* Using same heuristic as si_mem_available() */
> +	return (unsigned long)deferred + (unsigned long)lazyfree +
> +	       (memcg_page_state(memcg, NR_FILE_PAGES) +
> +		memcg_page_state(memcg, NR_SLAB_RECLAIMABLE)) / 2;
> +}
> +
>  static char *memory_stat_format(struct mem_cgroup *memcg)
>  {
>  	struct seq_buf s;
> @@ -1417,6 +1446,12 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
>  		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE) *
>  		       PAGE_SIZE);
> +	/*
> +	 * All values in this buffer are read individually, no implied
> +	 * consistency amongst them.
> +	 */
> +	seq_buf_printf(&s, "avail %llu\n",
> +		       (u64)mem_cgroup_avail(memcg) * PAGE_SIZE);
>  
>  	/* Accumulated memory events */
>  
> 

An alternative to this would also be to change from an "available" metric 
to an "anon_reclaimable" metric since both the deferred split queues and 
lazy freeable memory would pertain to anon.  This would no longer attempt 
to mimic MemAvailable and leave any such calculation to userspace
(anon_reclaimable + (file + slab_reclaimable) / 2).

With this route, care would need to be taken to clearly indicate that 
anon_reclaimable is not necessarily a subset of the "anon" metric since 
reclaimable memory from compound pages on deferred split queues is not 
mapped, so it doesn't show up in NR_ANON_MAPPED.

I'm indifferent to either approach and would be happy to switch to 
anon_reclaimable if others agree and doesn't foresee any extensibility 
issues.
