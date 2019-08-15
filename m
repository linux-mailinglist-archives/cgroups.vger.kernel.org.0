Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0FE78EE78
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 16:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbfHOOlb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 10:41:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:54284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731874AbfHOOla (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Aug 2019 10:41:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B5CAAE03;
        Thu, 15 Aug 2019 14:41:25 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EBA241E4200; Thu, 15 Aug 2019 16:41:23 +0200 (CEST)
Date:   Thu, 15 Aug 2019 16:41:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 1/4] writeback: Generalize and expose wb_completion
Message-ID: <20190815144123.GL14313@quack2.suse.cz>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803140155.181190-2-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 03-08-19 07:01:52, Tejun Heo wrote:
> wb_completion is used to track writeback completions.  We want to use
> it from memcg side for foreign inode flushes.  This patch updates it
> to remember the target waitq instead of assuming bdi->wb_waitq and
> expose it outside of fs-writeback.c.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs-writeback.c                | 47 ++++++++++----------------------
>  include/linux/backing-dev-defs.h | 20 ++++++++++++++
>  include/linux/backing-dev.h      |  2 ++
>  3 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 542b02d170f8..6129debdc938 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -36,10 +36,6 @@
>   */
>  #define MIN_WRITEBACK_PAGES	(4096UL >> (PAGE_SHIFT - 10))
>  
> -struct wb_completion {
> -	atomic_t		cnt;
> -};
> -
>  /*
>   * Passed into wb_writeback(), essentially a subset of writeback_control
>   */
> @@ -60,19 +56,6 @@ struct wb_writeback_work {
>  	struct wb_completion *done;	/* set if the caller waits */
>  };
>  
> -/*
> - * If one wants to wait for one or more wb_writeback_works, each work's
> - * ->done should be set to a wb_completion defined using the following
> - * macro.  Once all work items are issued with wb_queue_work(), the caller
> - * can wait for the completion of all using wb_wait_for_completion().  Work
> - * items which are waited upon aren't freed automatically on completion.
> - */
> -#define DEFINE_WB_COMPLETION_ONSTACK(cmpl)				\
> -	struct wb_completion cmpl = {					\
> -		.cnt		= ATOMIC_INIT(1),			\
> -	}
> -
> -
>  /*
>   * If an inode is constantly having its pages dirtied, but then the
>   * updates stop dirtytime_expire_interval seconds in the past, it's
> @@ -182,7 +165,7 @@ static void finish_writeback_work(struct bdi_writeback *wb,
>  	if (work->auto_free)
>  		kfree(work);
>  	if (done && atomic_dec_and_test(&done->cnt))
> -		wake_up_all(&wb->bdi->wb_waitq);
> +		wake_up_all(done->waitq);
>  }
>  
>  static void wb_queue_work(struct bdi_writeback *wb,
> @@ -206,20 +189,18 @@ static void wb_queue_work(struct bdi_writeback *wb,
>  
>  /**
>   * wb_wait_for_completion - wait for completion of bdi_writeback_works
> - * @bdi: bdi work items were issued to
>   * @done: target wb_completion
>   *
>   * Wait for one or more work items issued to @bdi with their ->done field
> - * set to @done, which should have been defined with
> - * DEFINE_WB_COMPLETION_ONSTACK().  This function returns after all such
> - * work items are completed.  Work items which are waited upon aren't freed
> + * set to @done, which should have been initialized with
> + * DEFINE_WB_COMPLETION().  This function returns after all such work items
> + * are completed.  Work items which are waited upon aren't freed
>   * automatically on completion.
>   */
> -static void wb_wait_for_completion(struct backing_dev_info *bdi,
> -				   struct wb_completion *done)
> +void wb_wait_for_completion(struct wb_completion *done)
>  {
>  	atomic_dec(&done->cnt);		/* put down the initial count */
> -	wait_event(bdi->wb_waitq, !atomic_read(&done->cnt));
> +	wait_event(*done->waitq, !atomic_read(&done->cnt));
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -843,7 +824,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>  restart:
>  	rcu_read_lock();
>  	list_for_each_entry_continue_rcu(wb, &bdi->wb_list, bdi_node) {
> -		DEFINE_WB_COMPLETION_ONSTACK(fallback_work_done);
> +		DEFINE_WB_COMPLETION(fallback_work_done, bdi);
>  		struct wb_writeback_work fallback_work;
>  		struct wb_writeback_work *work;
>  		long nr_pages;
> @@ -890,7 +871,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>  		last_wb = wb;
>  
>  		rcu_read_unlock();
> -		wb_wait_for_completion(bdi, &fallback_work_done);
> +		wb_wait_for_completion(&fallback_work_done);
>  		goto restart;
>  	}
>  	rcu_read_unlock();
> @@ -2362,7 +2343,8 @@ static void wait_sb_inodes(struct super_block *sb)
>  static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  				     enum wb_reason reason, bool skip_if_busy)
>  {
> -	DEFINE_WB_COMPLETION_ONSTACK(done);
> +	struct backing_dev_info *bdi = sb->s_bdi;
> +	DEFINE_WB_COMPLETION(done, bdi);
>  	struct wb_writeback_work work = {
>  		.sb			= sb,
>  		.sync_mode		= WB_SYNC_NONE,
> @@ -2371,14 +2353,13 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
>  		.nr_pages		= nr,
>  		.reason			= reason,
>  	};
> -	struct backing_dev_info *bdi = sb->s_bdi;
>  
>  	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
>  		return;
>  	WARN_ON(!rwsem_is_locked(&sb->s_umount));
>  
>  	bdi_split_work_to_wbs(sb->s_bdi, &work, skip_if_busy);
> -	wb_wait_for_completion(bdi, &done);
> +	wb_wait_for_completion(&done);
>  }
>  
>  /**
> @@ -2440,7 +2421,8 @@ EXPORT_SYMBOL(try_to_writeback_inodes_sb);
>   */
>  void sync_inodes_sb(struct super_block *sb)
>  {
> -	DEFINE_WB_COMPLETION_ONSTACK(done);
> +	struct backing_dev_info *bdi = sb->s_bdi;
> +	DEFINE_WB_COMPLETION(done, bdi);
>  	struct wb_writeback_work work = {
>  		.sb		= sb,
>  		.sync_mode	= WB_SYNC_ALL,
> @@ -2450,7 +2432,6 @@ void sync_inodes_sb(struct super_block *sb)
>  		.reason		= WB_REASON_SYNC,
>  		.for_sync	= 1,
>  	};
> -	struct backing_dev_info *bdi = sb->s_bdi;
>  
>  	/*
>  	 * Can't skip on !bdi_has_dirty() because we should wait for !dirty
> @@ -2464,7 +2445,7 @@ void sync_inodes_sb(struct super_block *sb)
>  	/* protect against inode wb switch, see inode_switch_wbs_work_fn() */
>  	bdi_down_write_wb_switch_rwsem(bdi);
>  	bdi_split_work_to_wbs(bdi, &work, false);
> -	wb_wait_for_completion(bdi, &done);
> +	wb_wait_for_completion(&done);
>  	bdi_up_write_wb_switch_rwsem(bdi);
>  
>  	wait_sb_inodes(sb);
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 6a1a8a314d85..8fb740178d5d 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -67,6 +67,26 @@ enum wb_reason {
>  	WB_REASON_MAX,
>  };
>  
> +struct wb_completion {
> +	atomic_t		cnt;
> +	wait_queue_head_t	*waitq;
> +};
> +
> +#define __WB_COMPLETION_INIT(_waitq)	\
> +	(struct wb_completion){ .cnt = ATOMIC_INIT(1), .waitq = (_waitq) }
> +
> +/*
> + * If one wants to wait for one or more wb_writeback_works, each work's
> + * ->done should be set to a wb_completion defined using the following
> + * macro.  Once all work items are issued with wb_queue_work(), the caller
> + * can wait for the completion of all using wb_wait_for_completion().  Work
> + * items which are waited upon aren't freed automatically on completion.
> + */
> +#define WB_COMPLETION_INIT(bdi)		__WB_COMPLETION_INIT(&(bdi)->wb_waitq)
> +
> +#define DEFINE_WB_COMPLETION(cmpl, bdi)	\
> +	struct wb_completion cmpl = WB_COMPLETION_INIT(bdi)
> +
>  /*
>   * For cgroup writeback, multiple wb's may map to the same blkcg.  Those
>   * wb's can operate mostly independently but should share the congested
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 35b31d176f74..02650b1253a2 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -44,6 +44,8 @@ void wb_start_background_writeback(struct bdi_writeback *wb);
>  void wb_workfn(struct work_struct *work);
>  void wb_wakeup_delayed(struct bdi_writeback *wb);
>  
> +void wb_wait_for_completion(struct wb_completion *done);
> +
>  extern spinlock_t bdi_lock;
>  extern struct list_head bdi_list;
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
