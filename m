Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC04223E5C
	for <lists+cgroups@lfdr.de>; Fri, 17 Jul 2020 16:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGQOj6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jul 2020 10:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGQOj5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jul 2020 10:39:57 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDAC0619D2
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 07:39:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b185so8946603qkg.1
        for <cgroups@vger.kernel.org>; Fri, 17 Jul 2020 07:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=STv7WsxvA8+TLcU34mj2MS3Xd7Gr7Bu4P1KzwtIAOuE=;
        b=nxkPNAOOmMGSq8vdVAA45szRlpUlEv1fwfOC/OOzpgnTUQHlx85q/CguxHfQAzzEJD
         8klFI7rewse8RvzYNgGppXlmSetz04nEL8MZ6IQdzlPEERJj5iHptUllNKRePqwhTg+4
         RaDMHisQI+f8ikCcgQGwdRk9s5MoR6ZMQ1TA/1sx5NletxVp3ubJ7LNHbYThF00qLfcI
         KisWyutsRTi24ry8UsqpxYbxaKW01FZkYeASduAh6oXvL/5EdEMRU//NZjMDQmnnWfAC
         xK8+loM+0EYxajNdy33qCNAqyc85ZB8hBeynDAUnBAFw0/M8ZcBXlJ3IQqVbIsUOvvTF
         Jo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=STv7WsxvA8+TLcU34mj2MS3Xd7Gr7Bu4P1KzwtIAOuE=;
        b=gcri6lhuDlf1RO81ZzFDaUU2Ed2pVhd56R42Q8OulVhu0etmHMb/NgAIfRxrPQf01/
         iM4QmSU7oaCWAVL7sLPk16rLh9DjetnFZ98OdEhP71R2u+M14/JBLILoRWsywNuOWQA8
         EKDM7EBWeRdqn9med7trEJnxDScrd89wY4UhZ7uyHmToaDws5fT0kdzV30Ld353F+WYH
         vb7olkne47UT5RQdRqVBmiHkyXb/GNFW3i1+jF+byWOvJiMpJ1EEzNImETVqaZuXxEuU
         f+oSG8ev0yZLE0R66+TJqWcD0wPHOc7snNfSj6li5q4NiDj4YEdXB+pLGadfGGBxAOa9
         oa+A==
X-Gm-Message-State: AOAM530r8aRzDJw9jof6qsVmfnF0aCvXZ8bWwxYE5DcZZZOE+zw5Adf4
        gf72Ki62IzZuAIpOLyaJgltUTQ==
X-Google-Smtp-Source: ABdhPJxMXKxdEQiTF9nJ+aEIegm5INEc54s4Mkb5WF+o979C6xr7dEsy9yXIaT0Csd9/0rMmTfTfag==
X-Received: by 2002:ae9:e8c5:: with SMTP id a188mr9435703qkg.222.1594996796013;
        Fri, 17 Jul 2020 07:39:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7d])
        by smtp.gmail.com with ESMTPSA id e129sm10150402qkf.132.2020.07.17.07.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:39:55 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:39:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     David Rientjes <rientjes@google.com>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, memcg: provide an anon_reclaimable stat
Message-ID: <20200717143902.GA266388@cmpxchg.org>
References: <20200715071522.19663-1-sjpark@amazon.com>
 <alpine.DEB.2.23.453.2007151031020.2788464@chino.kir.corp.google.com>
 <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.23.453.2007161357490.3209847@chino.kir.corp.google.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 16, 2020 at 01:58:19PM -0700, David Rientjes wrote:
> @@ -1350,6 +1350,32 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
>  	return false;
>  }
>  
> +/*
> + * Returns the amount of anon memory that is charged to the memcg that is
> + * reclaimable under memory pressure without swap, in pages.
> + */
> +static unsigned long memcg_anon_reclaimable(struct mem_cgroup *memcg)
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

Unfortunately, we don't know if these have been reused after the
madvise until we actually do the rmap walk in page reclaim. All of
these could have dirty ptes and require swapout after all.

The MADV_FREE tradeoff was that the freed pages can get reused by
userspace without another context switch and tlb flush in the common
case, by exploiting the fact that the MMU sets the dirty bit for
us. The downside is that the kernel doesn't know what state these
pages are in until it takes a close-up look at them one by one.
