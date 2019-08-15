Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B528EE99
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2019 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHOOq0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Aug 2019 10:46:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:56200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfHOOq0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 15 Aug 2019 10:46:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0005CABB1;
        Thu, 15 Aug 2019 14:46:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id AC6771E4200; Thu, 15 Aug 2019 16:46:23 +0200 (CEST)
Date:   Thu, 15 Aug 2019 16:46:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tejun Heo <tj@kernel.org>
Cc:     axboe@kernel.dk, jack@suse.cz, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, guro@fb.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH 2/4] bdi: Add bdi->id
Message-ID: <20190815144623.GM14313@quack2.suse.cz>
References: <20190803140155.181190-1-tj@kernel.org>
 <20190803140155.181190-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803140155.181190-3-tj@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 03-08-19 07:01:53, Tejun Heo wrote:
> There currently is no way to universally identify and lookup a bdi
> without holding a reference and pointer to it.  This patch adds an
> non-recycling bdi->id and implements bdi_get_by_id() which looks up
> bdis by their ids.  This will be used by memcg foreign inode flushing.
> 
> I left bdi_list alone for simplicity and because while rb_tree does
> support rcu assignment it doesn't seem to guarantee lossless walk when
> walk is racing aginst tree rebalance operations.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

Although I would note that here you take effort not to recycle bdi->id so
that you don't flush wrong devices while in patch 4 you take pretty lax
approach to feeding garbage into the writeback system. So these two don't
quite match to me...

								Honza

> ---
>  include/linux/backing-dev-defs.h |  2 +
>  include/linux/backing-dev.h      |  1 +
>  mm/backing-dev.c                 | 65 +++++++++++++++++++++++++++++++-
>  3 files changed, 66 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index 8fb740178d5d..1075f2552cfc 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -185,6 +185,8 @@ struct bdi_writeback {
>  };
>  
>  struct backing_dev_info {
> +	u64 id;
> +	struct rb_node rb_node; /* keyed by ->id */
>  	struct list_head bdi_list;
>  	unsigned long ra_pages;	/* max readahead in PAGE_SIZE units */
>  	unsigned long io_pages;	/* max allowed IO size */
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 02650b1253a2..84cdcfbc763f 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -24,6 +24,7 @@ static inline struct backing_dev_info *bdi_get(struct backing_dev_info *bdi)
>  	return bdi;
>  }
>  
> +struct backing_dev_info *bdi_get_by_id(u64 id);
>  void bdi_put(struct backing_dev_info *bdi);
>  
>  __printf(2, 3)
> diff --git a/mm/backing-dev.c b/mm/backing-dev.c
> index e8e89158adec..4a8816e0b8d4 100644
> --- a/mm/backing-dev.c
> +++ b/mm/backing-dev.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  
>  #include <linux/wait.h>
> +#include <linux/rbtree.h>
>  #include <linux/backing-dev.h>
>  #include <linux/kthread.h>
>  #include <linux/freezer.h>
> @@ -22,10 +23,12 @@ EXPORT_SYMBOL_GPL(noop_backing_dev_info);
>  static struct class *bdi_class;
>  
>  /*
> - * bdi_lock protects updates to bdi_list. bdi_list has RCU reader side
> - * locking.
> + * bdi_lock protects bdi_tree and updates to bdi_list. bdi_list has RCU
> + * reader side locking.
>   */
>  DEFINE_SPINLOCK(bdi_lock);
> +static u64 bdi_id_cursor;
> +static struct rb_root bdi_tree = RB_ROOT;
>  LIST_HEAD(bdi_list);
>  
>  /* bdi_wq serves all asynchronous writeback tasks */
> @@ -859,9 +862,58 @@ struct backing_dev_info *bdi_alloc_node(gfp_t gfp_mask, int node_id)
>  }
>  EXPORT_SYMBOL(bdi_alloc_node);
>  
> +struct rb_node **bdi_lookup_rb_node(u64 id, struct rb_node **parentp)
> +{
> +	struct rb_node **p = &bdi_tree.rb_node;
> +	struct rb_node *parent = NULL;
> +	struct backing_dev_info *bdi;
> +
> +	lockdep_assert_held(&bdi_lock);
> +
> +	while (*p) {
> +		parent = *p;
> +		bdi = rb_entry(parent, struct backing_dev_info, rb_node);
> +
> +		if (bdi->id > id)
> +			p = &(*p)->rb_left;
> +		else if (bdi->id < id)
> +			p = &(*p)->rb_right;
> +		else
> +			break;
> +	}
> +
> +	if (parentp)
> +		*parentp = parent;
> +	return p;
> +}
> +
> +/**
> + * bdi_get_by_id - lookup and get bdi from its id
> + * @id: bdi id to lookup
> + *
> + * Find bdi matching @id and get it.  Returns NULL if the matching bdi
> + * doesn't exist or is already unregistered.
> + */
> +struct backing_dev_info *bdi_get_by_id(u64 id)
> +{
> +	struct backing_dev_info *bdi = NULL;
> +	struct rb_node **p;
> +
> +	spin_lock_irq(&bdi_lock);
> +	p = bdi_lookup_rb_node(id, NULL);
> +	if (*p) {
> +		bdi = rb_entry(*p, struct backing_dev_info, rb_node);
> +		bdi_get(bdi);
> +	}
> +	spin_unlock_irq(&bdi_lock);
> +
> +	return bdi;
> +}
> +
>  int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  {
>  	struct device *dev;
> +	struct rb_node *parent, **p;
>  
>  	if (bdi->dev)	/* The driver needs to use separate queues per device */
>  		return 0;
> @@ -877,7 +929,15 @@ int bdi_register_va(struct backing_dev_info *bdi, const char *fmt, va_list args)
>  	set_bit(WB_registered, &bdi->wb.state);
>  
>  	spin_lock_bh(&bdi_lock);
> +
> +	bdi->id = ++bdi_id_cursor;
> +
> +	p = bdi_lookup_rb_node(bdi->id, &parent);
> +	rb_link_node(&bdi->rb_node, parent, p);
> +	rb_insert_color(&bdi->rb_node, &bdi_tree);
> +
>  	list_add_tail_rcu(&bdi->bdi_list, &bdi_list);
> +
>  	spin_unlock_bh(&bdi_lock);
>  
>  	trace_writeback_bdi_register(bdi);
> @@ -918,6 +978,7 @@ EXPORT_SYMBOL(bdi_register_owner);
>  static void bdi_remove_from_list(struct backing_dev_info *bdi)
>  {
>  	spin_lock_bh(&bdi_lock);
> +	rb_erase(&bdi->rb_node, &bdi_tree);
>  	list_del_rcu(&bdi->bdi_list);
>  	spin_unlock_bh(&bdi_lock);
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
