Return-Path: <cgroups+bounces-4691-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD3296BBD6
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D96F1C20A24
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0121D9321;
	Wed,  4 Sep 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkL1edlR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6mGRgEz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LkL1edlR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t6mGRgEz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC81D88C5;
	Wed,  4 Sep 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452262; cv=none; b=KyJ9uq7jNW8Q67EirM5wYoQbSSVW40BAZkkf1cVctX4OzjDAiRTWRIAPi4p3rlXYtHeAhsv19M4C8p5ZEZLPTS9x3OWPxsgVKex8DUMT0smbiWEve1qscY7m/hJWYhzLklAhmH9MrgT9jAftFN4U1jZNspZOlA7flu2UUUpPCUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452262; c=relaxed/simple;
	bh=3CZ+w+fMqcMb61N7WhboSrSzA3buCKvlmhjogmi+5Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIXjwDcBY13CzFAlAO2hMCAXJKAX5TsfOjubqPqvbrqDOeHEWuDSZh9VFx5UjIIXSIDFPQEz4pkZ+ZHTlPbcHpAoQAVSkyUp4ryTJLR+T8OSxdGdbyN7vYxmi5qq5vxLc50FG8qqaHyOxO+DVWmrZTI7lp6m3IgJ4Q3C2ZM9qSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkL1edlR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6mGRgEz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LkL1edlR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t6mGRgEz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F21E721989;
	Wed,  4 Sep 2024 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VsW8QFH025hlOmFkcorfhqr2hOQOtApRVi7d+teVSk=;
	b=LkL1edlRLaXYpiMxjRv0UHdvA4RgkulkEKQ5RdQ3SWWEVroa+G5ZOx+GrYbKLyHI/Qul+n
	slJftbkONeG2oba/bySVHLw4tuKCouMXYWGDF/FIF+0dm3A0MI111bl38vBWfU/W4/qv1j
	2VknFu4EezUPgkNwq2JhZ4Mcw63hf7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VsW8QFH025hlOmFkcorfhqr2hOQOtApRVi7d+teVSk=;
	b=t6mGRgEzSPviXhpNbPJJm1c4onn64Kgsrg3uqEUENWBKWCv0h5K+svWCSA7gV2idral1ps
	yaCkAYQylwby5OAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VsW8QFH025hlOmFkcorfhqr2hOQOtApRVi7d+teVSk=;
	b=LkL1edlRLaXYpiMxjRv0UHdvA4RgkulkEKQ5RdQ3SWWEVroa+G5ZOx+GrYbKLyHI/Qul+n
	slJftbkONeG2oba/bySVHLw4tuKCouMXYWGDF/FIF+0dm3A0MI111bl38vBWfU/W4/qv1j
	2VknFu4EezUPgkNwq2JhZ4Mcw63hf7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452259;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VsW8QFH025hlOmFkcorfhqr2hOQOtApRVi7d+teVSk=;
	b=t6mGRgEzSPviXhpNbPJJm1c4onn64Kgsrg3uqEUENWBKWCv0h5K+svWCSA7gV2idral1ps
	yaCkAYQylwby5OAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E02BA13A5F;
	Wed,  4 Sep 2024 12:17:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L2u2NuJP2GZpTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 12:17:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4FDB5A0968; Wed,  4 Sep 2024 14:17:23 +0200 (CEST)
Date: Wed, 4 Sep 2024 14:17:23 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	paolo.valente@unimore.it, mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 2/4] block, bfq: choose the last bfqq from merge
 chain in bfq_setup_cooperator()
Message-ID: <20240904121723.elseqvr277hzmnd6@quack3>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <20240902130329.3787024-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902130329.3787024-3-yukuai1@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 02-09-24 21:03:27, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Consider the following merge chain:
> 
> Process 1       Process 2       Process 3	Process 4
>  (BIC1)          (BIC2)          (BIC3)		 (BIC4)
>   Λ                |               |               |
>    \--------------\ \-------------\ \-------------\|
>                    V               V		   V
>   bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
> 
> IO from Process 1 will get bfqf2 from BIC1 first, then
> bfq_setup_cooperator() will found bfqq2 already merged to bfqq3 and then
> handle this IO from bfqq3. However, the merge chain can be much deeper
> and bfqq3 can be merged to other bfqq as well.
> 
> Fix this problem by iterating to the last bfqq in
> bfq_setup_cooperator().
> 
> Fixes: 36eca8948323 ("block, bfq: add Early Queue Merge (EQM)")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index 83adac3e71db..ffaa0d56328a 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -2911,8 +2911,12 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
>  	struct bfq_iocq_bfqq_data *bfqq_data = &bic->bfqq_data[a_idx];
>  
>  	/* if a merge has already been setup, then proceed with that first */
> -	if (bfqq->new_bfqq)
> -		return bfqq->new_bfqq;
> +	new_bfqq = bfqq->new_bfqq;
> +	if (new_bfqq) {
> +		while (new_bfqq->new_bfqq)
> +			new_bfqq = new_bfqq->new_bfqq;
> +		return new_bfqq;
> +	}
>  
>  	/*
>  	 * Check delayed stable merge for rotational or non-queueing
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

