Return-Path: <cgroups+bounces-3229-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7F790C86E
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 13:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6580286468
	for <lists+cgroups@lfdr.de>; Tue, 18 Jun 2024 11:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDD6205B18;
	Tue, 18 Jun 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="au2sTpPs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g922690h";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="au2sTpPs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g922690h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB93205B0F;
	Tue, 18 Jun 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704182; cv=none; b=gX5DuxuindmIN4MQJCrwzMuMxEdmPJRzt7jUWirgIehDQnEKJAsSXrq/E0RVMPNBfZlla48hMGLpf/wrUoQzcMC5ISllBR2uxazetl/tqTHKTNAFFlsPLQ7sTYlKB2aLFxJpNpdZAzMD2vMYBFui553DLsgpOC34xExEJyJQd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704182; c=relaxed/simple;
	bh=j2zbuA0EXWOXlcCx8XOXLDFqKwoh8yJG6MidhFefpN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhhcaHLXESrUndd8jT6eaxbJrw4uwxux/02sCy9rsngo6jhUM79IZPg/9yzEuK+szL2J6npPwUUrWBHfW1zGB/SE1lc8x74PXffKpESs2HvWqc07Makz1i03e4CYeJ12JHtEfruuYmjrhacTY50fjba2Nud/tu5sAwGejrnAAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=au2sTpPs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g922690h; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=au2sTpPs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g922690h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F34391F397;
	Tue, 18 Jun 2024 09:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718704175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QI4+RixGFW9ZrNAjdbwVasoe3hLeUsr/76KFsPgkzIA=;
	b=au2sTpPsRDOUWnlKa7dFLwrfvObDNfeiubIqHx4s+4SMhx4MIsXJJdSrLpJiHtbMjY/Izm
	6u0zcQtr0wqZeBsKzvZRhgqKrvHFx5zsbaosxFZicJILnhJcKclNyeWDjw1nxPuFMWtlP1
	TWBXHz3sgU3keLFQmgSAf5dglH3im38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718704175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QI4+RixGFW9ZrNAjdbwVasoe3hLeUsr/76KFsPgkzIA=;
	b=g922690hjog51L4gQSvgupgMqIunUdwPojHLhuww8cWHWs8NBk4xtU5mHKYJgb8e0uBARY
	uXqnqJxnxNz9DWCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=au2sTpPs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g922690h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718704175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QI4+RixGFW9ZrNAjdbwVasoe3hLeUsr/76KFsPgkzIA=;
	b=au2sTpPsRDOUWnlKa7dFLwrfvObDNfeiubIqHx4s+4SMhx4MIsXJJdSrLpJiHtbMjY/Izm
	6u0zcQtr0wqZeBsKzvZRhgqKrvHFx5zsbaosxFZicJILnhJcKclNyeWDjw1nxPuFMWtlP1
	TWBXHz3sgU3keLFQmgSAf5dglH3im38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718704175;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QI4+RixGFW9ZrNAjdbwVasoe3hLeUsr/76KFsPgkzIA=;
	b=g922690hjog51L4gQSvgupgMqIunUdwPojHLhuww8cWHWs8NBk4xtU5mHKYJgb8e0uBARY
	uXqnqJxnxNz9DWCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7B2C13AA0;
	Tue, 18 Jun 2024 09:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YRWOOC5YcWZ6HwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Jun 2024 09:49:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A0A4A0886; Tue, 18 Jun 2024 11:49:34 +0200 (CEST)
Date: Tue, 18 Jun 2024 11:49:34 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, paolo.valente@unimore.it, axboe@kernel.dk, tj@kernel.org,
	josef@toxicpanda.com, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH -next] block, bfq: remove blkg_path()
Message-ID: <20240618094934.lnezpxyxktiz6637@quack3>
References: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618032753.3502528-1-yukuai1@huaweicloud.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F34391F397
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 18-06-24 11:27:53, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After commit 35fe6d763229 ("block: use standard blktrace API to output
> cgroup info for debug notes"), the field 'bfqg->blkg_path' is not used
> and hence can be removed, and therefor blkg_path() is not used anymore
> and can be removed.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Yay, nice to see code removed! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-cgroup.c  | 51 ---------------------------------------------
>  block/bfq-iosched.h |  3 ---
>  block/blk-cgroup.h  | 13 ------------
>  3 files changed, 67 deletions(-)
> 
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index d442ee358fc2..b758693697c0 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -797,57 +797,6 @@ void bfq_bic_update_cgroup(struct bfq_io_cq *bic, struct bio *bio)
>  	 */
>  	bfq_link_bfqg(bfqd, bfqg);
>  	__bfq_bic_change_cgroup(bfqd, bic, bfqg);
> -	/*
> -	 * Update blkg_path for bfq_log_* functions. We cache this
> -	 * path, and update it here, for the following
> -	 * reasons. Operations on blkg objects in blk-cgroup are
> -	 * protected with the request_queue lock, and not with the
> -	 * lock that protects the instances of this scheduler
> -	 * (bfqd->lock). This exposes BFQ to the following sort of
> -	 * race.
> -	 *
> -	 * The blkg_lookup performed in bfq_get_queue, protected
> -	 * through rcu, may happen to return the address of a copy of
> -	 * the original blkg. If this is the case, then the
> -	 * bfqg_and_blkg_get performed in bfq_get_queue, to pin down
> -	 * the blkg, is useless: it does not prevent blk-cgroup code
> -	 * from destroying both the original blkg and all objects
> -	 * directly or indirectly referred by the copy of the
> -	 * blkg.
> -	 *
> -	 * On the bright side, destroy operations on a blkg invoke, as
> -	 * a first step, hooks of the scheduler associated with the
> -	 * blkg. And these hooks are executed with bfqd->lock held for
> -	 * BFQ. As a consequence, for any blkg associated with the
> -	 * request queue this instance of the scheduler is attached
> -	 * to, we are guaranteed that such a blkg is not destroyed, and
> -	 * that all the pointers it contains are consistent, while we
> -	 * are holding bfqd->lock. A blkg_lookup performed with
> -	 * bfqd->lock held then returns a fully consistent blkg, which
> -	 * remains consistent until this lock is held.
> -	 *
> -	 * Thanks to the last fact, and to the fact that: (1) bfqg has
> -	 * been obtained through a blkg_lookup in the above
> -	 * assignment, and (2) bfqd->lock is being held, here we can
> -	 * safely use the policy data for the involved blkg (i.e., the
> -	 * field bfqg->pd) to get to the blkg associated with bfqg,
> -	 * and then we can safely use any field of blkg. After we
> -	 * release bfqd->lock, even just getting blkg through this
> -	 * bfqg may cause dangling references to be traversed, as
> -	 * bfqg->pd may not exist any more.
> -	 *
> -	 * In view of the above facts, here we cache, in the bfqg, any
> -	 * blkg data we may need for this bic, and for its associated
> -	 * bfq_queue. As of now, we need to cache only the path of the
> -	 * blkg, which is used in the bfq_log_* functions.
> -	 *
> -	 * Finally, note that bfqg itself needs to be protected from
> -	 * destruction on the blkg_free of the original blkg (which
> -	 * invokes bfq_pd_free). We use an additional private
> -	 * refcounter for bfqg, to let it disappear only after no
> -	 * bfq_queue refers to it any longer.
> -	 */
> -	blkg_path(bfqg_to_blkg(bfqg), bfqg->blkg_path, sizeof(bfqg->blkg_path));
>  	bic->blkcg_serial_nr = serial_nr;
>  }
>  
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 467e8cfc41a2..08ddf2cfae5b 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -1003,9 +1003,6 @@ struct bfq_group {
>  	/* must be the first member */
>  	struct blkg_policy_data pd;
>  
> -	/* cached path for this blkg (see comments in bfq_bic_update_cgroup) */
> -	char blkg_path[128];
> -
>  	/* reference counter (see comments in bfq_bic_update_cgroup) */
>  	refcount_t ref;
>  
> diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
> index 25833221a12b..6dcaf63c560a 100644
> --- a/block/blk-cgroup.h
> +++ b/block/blk-cgroup.h
> @@ -301,19 +301,6 @@ static inline struct blkcg *cpd_to_blkcg(struct blkcg_policy_data *cpd)
>  	return cpd ? cpd->blkcg : NULL;
>  }
>  
> -/**
> - * blkg_path - format cgroup path of blkg
> - * @blkg: blkg of interest
> - * @buf: target buffer
> - * @buflen: target buffer length
> - *
> - * Format the path of the cgroup of @blkg into @buf.
> - */
> -static inline int blkg_path(struct blkcg_gq *blkg, char *buf, int buflen)
> -{
> -	return cgroup_path(blkg->blkcg->css.cgroup, buf, buflen);
> -}
> -
>  /**
>   * blkg_get - get a blkg reference
>   * @blkg: blkg to get
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

