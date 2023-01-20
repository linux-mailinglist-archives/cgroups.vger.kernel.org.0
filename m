Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4130675014
	for <lists+cgroups@lfdr.de>; Fri, 20 Jan 2023 10:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjATJA7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Jan 2023 04:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjATJA6 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Jan 2023 04:00:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06C540DF;
        Fri, 20 Jan 2023 01:00:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83F31228D8;
        Fri, 20 Jan 2023 09:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674205255; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqzOV/Iv6aZGmhpj9C+RqWOJmqu+Ctue2fjtEzP4yH4=;
        b=velkg0L7SxjsHBOqYT+6tMAKhONYwZ3ifUwnZVFNT0JXcsFyvdoySKvCW1k7nAwD8iEWHt
        Ff040TOvcRxOW3pk4PH5QmxTqoQ2NxENgeMg/6McancT7UEffC6JBa+gTeQ3ypA8R1R6jP
        Wv3yUlFQm3vwApsY5ZoDiUsbulR62is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674205255;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bqzOV/Iv6aZGmhpj9C+RqWOJmqu+Ctue2fjtEzP4yH4=;
        b=niSXmgnKh0jSdn+019P+rsXUDASphFEl10alKXPUnPSIyW8rBNF8fokRUohcM5mD3JED/f
        cCVmj7+BwHW2PKDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A91913251;
        Fri, 20 Jan 2023 09:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yxXJOUZYymMkIwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Fri, 20 Jan 2023 09:00:54 +0000
Date:   Fri, 20 Jan 2023 10:00:53 +0100
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH 05/15] blk-cgroup: store a gendisk to throttle in struct
 task_struct
Message-ID: <Y8pYReOp6VW3Va4O@suselix>
References: <20230117081257.3089859-1-hch@lst.de>
 <20230117081257.3089859-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230117081257.3089859-6-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 17, 2023 at 09:12:47AM +0100, Christoph Hellwig wrote:
> Switch from a request_queue pointer and reference to a gendisk once
> for the throttle information in struct task_struct.
> 
> Move the check for the dead disk to the latest place now that is is
                                                                ^^
								it
> unboundled from the reference grab.
  ^^^^^^^^^^
  unbundled
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c    | 37 +++++++++++++++++++------------------
>  include/linux/sched.h |  2 +-
>  kernel/fork.c         |  2 +-
>  mm/swapfile.c         |  2 +-
>  4 files changed, 22 insertions(+), 21 deletions(-)

Looks good to me. Feel free to add
Reviewed-by: Andreas Herrmann <aherrmann@suse.de>

> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index f5a634ed098db0..603e911d1350db 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1334,9 +1334,9 @@ static void blkcg_bind(struct cgroup_subsys_state *root_css)
>  
>  static void blkcg_exit(struct task_struct *tsk)
>  {
> -	if (tsk->throttle_queue)
> -		blk_put_queue(tsk->throttle_queue);
> -	tsk->throttle_queue = NULL;
> +	if (tsk->throttle_disk)
> +		put_disk(tsk->throttle_disk);
> +	tsk->throttle_disk = NULL;
>  }
>  
>  struct cgroup_subsys io_cgrp_subsys = {
> @@ -1778,29 +1778,32 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
>   *
>   * This is only called if we've been marked with set_notify_resume().  Obviously
>   * we can be set_notify_resume() for reasons other than blkcg throttling, so we
> - * check to see if current->throttle_queue is set and if not this doesn't do
> + * check to see if current->throttle_disk is set and if not this doesn't do
>   * anything.  This should only ever be called by the resume code, it's not meant
>   * to be called by people willy-nilly as it will actually do the work to
>   * throttle the task if it is setup for throttling.
>   */
>  void blkcg_maybe_throttle_current(void)
>  {
> -	struct request_queue *q = current->throttle_queue;
> +	struct gendisk *disk = current->throttle_disk;
>  	struct blkcg *blkcg;
>  	struct blkcg_gq *blkg;
>  	bool use_memdelay = current->use_memdelay;
>  
> -	if (!q)
> +	if (!disk)
>  		return;
>  
> -	current->throttle_queue = NULL;
> +	current->throttle_disk = NULL;
>  	current->use_memdelay = false;
>  
> +	if (test_bit(GD_DEAD, &disk->state))
> +		goto out_put_disk;
> +
>  	rcu_read_lock();
>  	blkcg = css_to_blkcg(blkcg_css());
>  	if (!blkcg)
>  		goto out;
> -	blkg = blkg_lookup(blkcg, q);
> +	blkg = blkg_lookup(blkcg, disk->queue);
>  	if (!blkg)
>  		goto out;
>  	if (!blkg_tryget(blkg))
> @@ -1809,11 +1812,12 @@ void blkcg_maybe_throttle_current(void)
>  
>  	blkcg_maybe_throttle_blkg(blkg, use_memdelay);
>  	blkg_put(blkg);
> -	blk_put_queue(q);
> +	put_disk(disk);
>  	return;
>  out:
>  	rcu_read_unlock();
> -	blk_put_queue(q);
> +out_put_disk:
> +	put_disk(disk);
>  }
>  
>  /**
> @@ -1835,18 +1839,15 @@ void blkcg_maybe_throttle_current(void)
>   */
>  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>  {
> -	struct request_queue *q = disk->queue;
> -
>  	if (unlikely(current->flags & PF_KTHREAD))
>  		return;
>  
> -	if (current->throttle_queue != q) {
> -		if (!blk_get_queue(q))
> -			return;
> +	if (current->throttle_disk != disk) {
> +		get_device(disk_to_dev(disk));
>  
> -		if (current->throttle_queue)
> -			blk_put_queue(current->throttle_queue);
> -		current->throttle_queue = q;
> +		if (current->throttle_disk)
> +			put_disk(current->throttle_disk);
> +		current->throttle_disk = disk;
>  	}
>  
>  	if (use_memdelay)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 853d08f7562bda..6f6ce9ca709798 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1436,7 +1436,7 @@ struct task_struct {
>  #endif
>  
>  #ifdef CONFIG_BLK_CGROUP
> -	struct request_queue		*throttle_queue;
> +	struct gendisk			*throttle_disk;
>  #endif
>  
>  #ifdef CONFIG_UPROBES
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe354189785..d9c97704b7c9a4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1044,7 +1044,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
>  #endif
>  
>  #ifdef CONFIG_BLK_CGROUP
> -	tsk->throttle_queue = NULL;
> +	tsk->throttle_disk = NULL;
>  	tsk->use_memdelay = 0;
>  #endif
>  
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 908a529bca12c9..3e0a742fb7bbff 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3642,7 +3642,7 @@ void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
>  	 * We've already scheduled a throttle, avoid taking the global swap
>  	 * lock.
>  	 */
> -	if (current->throttle_queue)
> +	if (current->throttle_disk)
>  		return;
>  
>  	spin_lock(&swap_avail_lock);
> -- 
> 2.39.0
> 

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
