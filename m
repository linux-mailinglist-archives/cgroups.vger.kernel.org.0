Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D18D2156E73
	for <lists+cgroups@lfdr.de>; Mon, 10 Feb 2020 05:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgBJE2l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 9 Feb 2020 23:28:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgBJE2l (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 9 Feb 2020 23:28:41 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D748214DB;
        Mon, 10 Feb 2020 04:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581308920;
        bh=l1OeRezZzhe+y0mBNHwN5J5otTAGBbttv+vIF5SGOJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=16CmDXbCPWS2GhluQtjfPjZiGcRa6DeS3CtEcGMYB8mhvGi20OtXYMbMkIR31W+2C
         5zAWDQKxBkgmbnZRu1EFfvvbU9j9vaofeckw1R3rowBSLuusqh01YIjP8JbNd3cLww
         44VYaNI4cEWAIktNi/gYtd6WzPyBlKFY/59jKcLo=
Date:   Sun, 9 Feb 2020 20:28:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memcontrol: fix a data race in scan count
Message-Id: <20200209202840.2bf97ffcfa811550d733c461@linux-foundation.org>
In-Reply-To: <20200206034945.2481-1-cai@lca.pw>
References: <20200206034945.2481-1-cai@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed,  5 Feb 2020 22:49:45 -0500 Qian Cai <cai@lca.pw> wrote:

> struct mem_cgroup_per_node mz.lru_zone_size[zone_idx][lru] could be
> accessed concurrently as noticed by KCSAN,
> 
> ...
>
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 95 PID: 50964 Comm: cc1 Tainted: G        W  O L    5.5.0-next-20200204+ #6
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> 
> The write is under lru_lock, but the read is done as lockless. The scan
> count is used to determine how aggressively the anon and file LRU lists
> should be scanned. Load tearing could generate an inefficient heuristic,
> so fix it by adding READ_ONCE() for the read.
> 
> ...
>
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -533,7 +533,7 @@ unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
>  	struct mem_cgroup_per_node *mz;
>  
>  	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	return mz->lru_zone_size[zone_idx][lru];
> +	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
>  }

I worry about the readability/maintainability of these things.  A naive
reader who comes upon this code will wonder "why the heck is it using
READ_ONCE?".  A possibly lengthy trawl through the git history will
reveal the reason but that's rather unkind.  Wouldn't a simple

	/* modified under lru_lock, so use READ_ONCE */

improve the situation?


