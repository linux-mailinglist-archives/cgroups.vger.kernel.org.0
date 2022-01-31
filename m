Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E83D4A505D
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 21:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiAaUnC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 15:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiAaUnB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 15:43:01 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70FFC061714;
        Mon, 31 Jan 2022 12:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC1EECE1281;
        Mon, 31 Jan 2022 20:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3634C340E8;
        Mon, 31 Jan 2022 20:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643661778;
        bh=RF9Uzy656eNPo86dgtYZteEf2qMfnRVGKDWgsayxNo0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=URvBe94F0JMMty2g/M6kg26bLOxEoYKeDYSuC7kvnkiHFQb0nt3o6aO+C2ToQJymO
         XAxwdDkfCU2XzYUPgUduz+X9dBk8UNmCBpnHrvCqeot0ipz4t58JkPVmJ3evjNkJqj
         EHbM/CFvqQWyvVCUN5Q/YmioMkX6yyhyMvzGzSMlwU845x3KlgzGC8sutoRk2tBrEO
         gkD/WBreqxVcZGhr7Nhh+wPPMnsZlCY5XfH36Udit6NpHz06ljNqa4PYJFbGz7ltzY
         Cynpz3oaSPQIWv4B+Rpwcewpp6Yq+lpRDN7Qgys6DG+rIgiN/GMANpUGuVAMT49dLM
         kW5RDxujS5QqQ==
Date:   Mon, 31 Jan 2022 22:42:43 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3 1/4] lib/vsprintf: Avoid redundant work with 0 size
Message-ID: <YfhJw1t+Ajp+u59G@kernel.org>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131192308.608837-2-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 31, 2022 at 02:23:05PM -0500, Waiman Long wrote:
> For *scnprintf(), vsnprintf() is always called even if the input size is
> 0. That is a waste of time, so just return 0 in this case.
> 
> Note that vsnprintf() will never return -1 to indicate an error. So
> skipping the call to vsnprintf() when size is 0 will have no functional
> impact at all.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Roman Gushchin <guro@fb.com>

Acked-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  lib/vsprintf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 3b8129dd374c..d419154b47bb 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2895,13 +2895,15 @@ int vscnprintf(char *buf, size_t size, const char *fmt, va_list args)
>  {
>  	int i;
>  
> +	if (unlikely(!size))
> +		return 0;
> +
>  	i = vsnprintf(buf, size, fmt, args);
>  
>  	if (likely(i < size))
>  		return i;
> -	if (size != 0)
> -		return size - 1;
> -	return 0;
> +
> +	return size - 1;
>  }
>  EXPORT_SYMBOL(vscnprintf);
>  
> -- 
> 2.27.0
> 

-- 
Sincerely yours,
Mike.
