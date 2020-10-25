Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD929832A
	for <lists+cgroups@lfdr.de>; Sun, 25 Oct 2020 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416975AbgJYSh0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 25 Oct 2020 14:37:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415361AbgJYSh0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 25 Oct 2020 14:37:26 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DC612072C;
        Sun, 25 Oct 2020 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603651046;
        bh=AKPWbbhGU2lDq8bH1SvgMMUeWmC+dVgo7ZU0pT2CqBo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NrxUh7Ba2gTECKM/q2Nb8g7MqpeqjWVu+CAWoTjJUX/Xn1y/Q5hnn6KlhM+GpLPkg
         2tNRiG7gHYOqtaJXG05Ww3O7BpZlEBqcme73OYOcJpfFNaDI0CpD94hEw4kvO5XbRg
         hNzx1hkDDMKIB1YweVadIc2+HdMbcNwoITFZpxe8=
Date:   Sun, 25 Oct 2020 11:37:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: add file_thp, shmem_thp to memory.stat
Message-Id: <20201025113725.b60f2b08d7331a31edf009a1@linux-foundation.org>
In-Reply-To: <20201022151844.489337-1-hannes@cmpxchg.org>
References: <20201022151844.489337-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 22 Oct 2020 11:18:44 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> As huge page usage in the page cache and for shmem files proliferates
> in our production environment, the performance monitoring team has
> asked for per-cgroup stats on those pages.
> 
> We already track and export anon_thp per cgroup. We already track file
> THP and shmem THP per node, so making them per-cgroup is only a matter
> of switching from node to lruvec counters. All callsites are in places
> where the pages are charged and locked, so page->memcg is stable.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1507,6 +1507,8 @@ static struct memory_stat memory_stats[] = {
>  	 * constant(e.g. powerpc).
>  	 */
>  	{ "anon_thp", 0, NR_ANON_THPS },
> +	{ "file_thp", 0, NR_FILE_THPS },
> +	{ "shmem_thp", 0, NR_SHMEM_THPS },

Documentation/admin-guide/cgroup-v2.rst is owed an update?

