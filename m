Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33878828
	for <lists+cgroups@lfdr.de>; Mon, 29 Jul 2019 11:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbfG2JRk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 29 Jul 2019 05:17:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:34460 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbfG2JRk (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 29 Jul 2019 05:17:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2C442AEFD;
        Mon, 29 Jul 2019 09:17:39 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:17:38 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH RFC] mm/memcontrol: reclaim severe usage over high limit
 in get_user_pages loop
Message-ID: <20190729091738.GF9330@dhcp22.suse.cz>
References: <156431697805.3170.6377599347542228221.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156431697805.3170.6377599347542228221.stgit@buzz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun 28-07-19 15:29:38, Konstantin Khlebnikov wrote:
> High memory limit in memory cgroup allows to batch memory reclaiming and
> defer it until returning into userland. This moves it out of any locks.
> 
> Fixed gap between high and max limit works pretty well (we are using
> 64 * NR_CPUS pages) except cases when one syscall allocates tons of
> memory. This affects all other tasks in cgroup because they might hit
> max memory limit in unhandy places and\or under hot locks.
> 
> For example mmap with MAP_POPULATE or MAP_LOCKED might allocate a lot
> of pages and push memory cgroup usage far ahead high memory limit.
> 
> This patch uses halfway between high and max limits as threshold and
> in this case starts memory reclaiming if mem_cgroup_handle_over_high()
> called with argument only_severe = true, otherwise reclaim is deferred
> till returning into userland. If high limits isn't set nothing changes.
> 
> Now long running get_user_pages will periodically reclaim cgroup memory.
> Other possible targets are generic file read/write iter loops.

I do see how gup can lead to a large high limit excess, but could you be
more specific why is that a problem? We should be reclaiming the similar
number of pages cumulatively.
-- 
Michal Hocko
SUSE Labs
