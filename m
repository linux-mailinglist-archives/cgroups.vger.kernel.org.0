Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5DA8EE4A
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 16:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfHOOeH (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 10:34:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51194 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbfHOOeH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Aug 2019 10:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B26AAAD09;
        Thu, 15 Aug 2019 14:34:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B2D2C1E4200; Thu, 15 Aug 2019 16:34:04 +0200 (CEST)
Date:   Thu, 15 Aug 2019 16:34:04 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 4/4] writeback, memcg: Implement foreign dirty flushing
Message-ID: <20190815143404.GK14313@quack2.suse.cz>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-5-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803140155.181190-5-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 03-08-19 07:01:55, Tejun Heo wrote:
> +void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
> +					     struct bdi_writeback *wb)
> +{
> +	struct mem_cgroup *memcg = page->mem_cgroup;
> +	struct memcg_cgwb_frn *frn;
> +	u64 now = jiffies_64;
> +	u64 oldest_at = now;
> +	int oldest = -1;
> +	int i;
> +
> +	/*
> +	 * Pick the slot to use.  If there is already a slot for @wb, keep
> +	 * using it.  If not replace the oldest one which isn't being
> +	 * written out.
> +	 */
> +	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++) {
> +		frn = &memcg->cgwb_frn[i];
> +		if (frn->bdi_id == wb->bdi->id &&
> +		    frn->memcg_id == wb->memcg_css->id)
> +			break;
> +		if (frn->at < oldest_at && atomic_read(&frn->done.cnt) == 1) {
> +			oldest = i;
> +			oldest_at = frn->at;
> +		}
> +	}
> +
> +	if (i < MEMCG_CGWB_FRN_CNT) {
> +		unsigned long update_intv =
> +			min_t(unsigned long, HZ,
> +			      msecs_to_jiffies(dirty_expire_interval * 10) / 8);
> +		/*
> +		 * Re-using an existing one.  Let's update timestamp lazily
> +		 * to avoid making the cacheline hot.
> +		 */
> +		if (frn->at < now - update_intv)
> +			frn->at = now;
> +	} else if (oldest >= 0) {
> +		/* replace the oldest free one */
> +		frn = &memcg->cgwb_frn[oldest];
> +		frn->bdi_id = wb->bdi->id;
> +		frn->memcg_id = wb->memcg_css->id;
> +		frn->at = now;
> +	}

I have to say I'm a bit nervous about the completely lockless handling
here. I understand that garbage in the cgwb_frn will just result in this
mechanism not working and possibly flushing wrong wb's but still it seems a
bit fragile. But I don't see any cheap way of synchronizing this so I guess
let's try how this will work in practice.

								Honza
--
Jan Kara <jack@suse.com>
SUSE Labs, CR
