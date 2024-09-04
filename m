Return-Path: <cgroups+bounces-4693-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FEC96BBF4
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 14:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DB1D1F237F6
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 12:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBCC1D79BB;
	Wed,  4 Sep 2024 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqGmgEwk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5OEQ42S";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqGmgEwk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u5OEQ42S"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0971D79A5;
	Wed,  4 Sep 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452539; cv=none; b=Dn8kKVRnv+M95+NhjM6vg4Q3xNJDUbiJwvqHxCihI+2WzIUaD8ymQZ7O06yo+tbeaxdo2rVHAJn4VPp616kOi+EvBHVqJ7BMUQb06IOgJjZb6sHIV0ND5bqvEocGoJAb0GhaTbmF+j8Xq/dis93njyJ3ZNUlzhZRxHq+3XAQ/+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452539; c=relaxed/simple;
	bh=z48fEH0ijldrUr/b4ibpQaTwTHJYq69qPwg69pAfMVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gc4gQ+nLReACh5qrLqaJ3iA22COM3CLRNInX0lOOL4AwkR45RZ8/26SfFip9HFgr2Ehx/ftIIlsZGV6LjbP6vkmJLasrkqD2RmP/6IUp1ZzH1ZXwAc6afzBIKN4K3L7D6ITQnZV31GrVmki9NLWf962FGJ0JwzZRUQ7g6Nb0LiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqGmgEwk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5OEQ42S; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqGmgEwk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u5OEQ42S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6BDE92199C;
	Wed,  4 Sep 2024 12:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68IeuwLaDc3zXZDdFfQLZaudCoc1gWBpyGwkrp9TFmM=;
	b=wqGmgEwkq6I6VCb4pRfbKZxH0+tn4iw6KqP6J6DyMJxo4FxUFO1yGFsdhMNhQol7x9HfNG
	DQOqK+35Z+p6xY0C3se8pmX+o8KUt7bUPu9jWCC/oHlUoPqc7drMjlfutAng5Sfcdh8KTc
	7caD1d9aG87zoAAiAJa5xZ+fm+EoW1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68IeuwLaDc3zXZDdFfQLZaudCoc1gWBpyGwkrp9TFmM=;
	b=u5OEQ42S4yxBVt/nYCqMh6Vpm4X5q3hMxhiZIub72qQDP3e6wqfnYS3f5CD8bRhDsf/CPH
	9PNO09ipGMosLxAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68IeuwLaDc3zXZDdFfQLZaudCoc1gWBpyGwkrp9TFmM=;
	b=wqGmgEwkq6I6VCb4pRfbKZxH0+tn4iw6KqP6J6DyMJxo4FxUFO1yGFsdhMNhQol7x9HfNG
	DQOqK+35Z+p6xY0C3se8pmX+o8KUt7bUPu9jWCC/oHlUoPqc7drMjlfutAng5Sfcdh8KTc
	7caD1d9aG87zoAAiAJa5xZ+fm+EoW1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=68IeuwLaDc3zXZDdFfQLZaudCoc1gWBpyGwkrp9TFmM=;
	b=u5OEQ42S4yxBVt/nYCqMh6Vpm4X5q3hMxhiZIub72qQDP3e6wqfnYS3f5CD8bRhDsf/CPH
	9PNO09ipGMosLxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FAE9139D2;
	Wed,  4 Sep 2024 12:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jSFaF/dQ2GbpTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 12:22:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 06535A0968; Wed,  4 Sep 2024 14:22:15 +0200 (CEST)
Date: Wed, 4 Sep 2024 14:22:14 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	paolo.valente@unimore.it, mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 4/4] block, bfq: use bfq_reassign_last_bfqq() in
 bfq_bfqq_move()
Message-ID: <20240904122214.57ectrb42rvbqt6w@quack3>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <20240902130329.3787024-5-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902130329.3787024-5-yukuai1@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,toxicpanda.com,kernel.dk,unimore.it,gmail.com,vger.kernel.org,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 02-09-24 21:03:29, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Instead of open coding it, there are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 7 +------
>  block/bfq-iosched.c | 4 ++--
>  block/bfq-iosched.h | 2 ++
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index b758693697c0..9fb9f3533150 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -679,12 +679,7 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  		bfq_put_idle_entity(bfq_entity_service_tree(entity), entity);
>  	bfqg_and_blkg_put(old_parent);
>  
> -	if (entity->parent &&
> -	    entity->parent->last_bfqq_created == bfqq)
> -		entity->parent->last_bfqq_created = NULL;
> -	else if (bfqd->last_bfqq_created == bfqq)
> -		bfqd->last_bfqq_created = NULL;
> -
> +	bfq_reassign_last_bfqq(bfqq, NULL);
>  	entity->parent = bfqg->my_entity;
>  	entity->sched_data = &bfqg->sched_data;
>  	/* pin down bfqg and its associated blkg  */
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ca766b7d5560..d1bf2b8a3576 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -3097,8 +3097,8 @@ static void bfq_bfqq_save_state(struct bfq_queue *bfqq)
>  }
>  
>  
> -static void
> -bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq, struct bfq_queue *new_bfqq)
> +void bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq,
> +			    struct bfq_queue *new_bfqq)
>  {
>  	if (cur_bfqq->entity.parent &&
>  	    cur_bfqq->entity.parent->last_bfqq_created == cur_bfqq)
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 08ddf2cfae5b..e16d96e2367b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1156,6 +1156,8 @@ void bfq_del_bfqq_busy(struct bfq_queue *bfqq, bool expiration);
>  void bfq_add_bfqq_busy(struct bfq_queue *bfqq);
>  void bfq_add_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
>  void bfq_del_bfqq_in_groups_with_pending_reqs(struct bfq_queue *bfqq);
> +void bfq_reassign_last_bfqq(struct bfq_queue *cur_bfqq,
> +			    struct bfq_queue *new_bfqq);
>  
>  /* --------------- end of interface of B-WF2Q+ ---------------- */
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

