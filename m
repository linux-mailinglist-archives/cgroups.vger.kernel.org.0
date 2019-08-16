Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F835904EC
	for <lists+cgroups@lfdr.de>; Fri, 16 Aug 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfHPPrM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Aug 2019 11:47:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33356 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727345AbfHPPrM (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 16 Aug 2019 11:47:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9567AF55;
        Fri, 16 Aug 2019 15:47:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AD9061E4009; Fri, 16 Aug 2019 17:47:09 +0200 (CEST)
Date:   Fri, 16 Aug 2019 17:47:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 4/5] writeback, memcg: Implement cgroup_writeback_by_id()
Message-ID: <20190816154709.GH3041@quack2.suse.cz>
References: <20190815195619.GA2263813@devbig004.ftw2.facebook.com>
 <20190815195902.GE2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815195902.GE2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 15-08-19 12:59:02, Tejun Heo wrote:
> Implement cgroup_writeback_by_id() which initiates cgroup writeback
> from bdi and memcg IDs.  This will be used by memcg foreign inode
> flushing.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/fs-writeback.c         |   67 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/writeback.h |    2 +
>  2 files changed, 69 insertions(+)
> 
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -892,6 +892,73 @@ restart:
>  }
>  
>  /**
> + * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
> + * @bdi_id: target bdi id
> + * @memcg_id: target memcg css id
> + * @nr_pages: number of pages to write
> + * @reason: reason why some writeback work initiated
> + * @done: target wb_completion
> + *
> + * Initiate flush of the bdi_writeback identified by @bdi_id and @memcg_id
> + * with the specified parameters.
> + */
> +int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr,
> +			   enum wb_reason reason, struct wb_completion *done)
> +{
> +	struct backing_dev_info *bdi;
> +	struct cgroup_subsys_state *memcg_css;
> +	struct bdi_writeback *wb;
> +	struct wb_writeback_work *work;
> +	int ret;
> +
> +	/* lookup bdi and memcg */
> +	bdi = bdi_get_by_id(bdi_id);
> +	if (!bdi)
> +		return -ENOENT;
> +
> +	rcu_read_lock();
> +	memcg_css = css_from_id(memcg_id, &memory_cgrp_subsys);
> +	if (memcg_css && !css_tryget(memcg_css))
> +		memcg_css = NULL;
> +	rcu_read_unlock();
> +	if (!memcg_css) {
> +		ret = -ENOENT;
> +		goto out_bdi_put;
> +	}
> +
> +	/*
> +	 * And find the associated wb.  If the wb isn't there already
> +	 * there's nothing to flush, don't create one.
> +	 */
> +	wb = wb_get_lookup(bdi, memcg_css);
> +	if (!wb) {
> +		ret = -ENOENT;
> +		goto out_css_put;
> +	}
> +
> +	/* issue the writeback work */
> +	work = kzalloc(sizeof(*work), GFP_NOWAIT | __GFP_NOWARN);
> +	if (work) {
> +		work->nr_pages = nr;
> +		work->sync_mode = WB_SYNC_NONE;
> +		work->reason = reason;
> +		work->done = done;
> +		work->auto_free = 1;
> +		wb_queue_work(wb, work);
> +		ret = 0;
> +	} else {
> +		ret = -ENOMEM;
> +	}
> +
> +	wb_put(wb);
> +out_css_put:
> +	css_put(memcg_css);
> +out_bdi_put:
> +	bdi_put(bdi);
> +	return ret;
> +}
> +
> +/**
>   * cgroup_writeback_umount - flush inode wb switches for umount
>   *
>   * This function is called when a super_block is about to be destroyed and
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -217,6 +217,8 @@ void wbc_attach_and_unlock_inode(struct
>  void wbc_detach_inode(struct writeback_control *wbc);
>  void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
>  			      size_t bytes);
> +int cgroup_writeback_by_id(u64 bdi_id, int memcg_id, unsigned long nr_pages,
> +			   enum wb_reason reason, struct wb_completion *done);
>  void cgroup_writeback_umount(void);
>  
>  /**
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
