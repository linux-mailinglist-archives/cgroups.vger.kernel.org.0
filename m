Return-Path: <cgroups+bounces-4692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8450E96BBF1
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 14:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A78D01C20B51
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4138D1D79B7;
	Wed,  4 Sep 2024 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZBb7p5x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwciNKvW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ZBb7p5x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gwciNKvW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640731D04A1;
	Wed,  4 Sep 2024 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452467; cv=none; b=lqeOM2op72WspNwO8QR6FTBKW364JGzUSx/bGSdavWZ75cO9K1Zhix/Nbq1sSRdDrS9krbGSQqbxGX77q/B9opGaQMTaFhf9Dt7m0IKYc571yhxMruN4UhFu6ihXP00BbIAUFjBveP1SWZmkGjh64guNP+3Tsi6bKUVl0Pm6EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452467; c=relaxed/simple;
	bh=NDYNJ/KgM0qeTrlQDy0Cx3aE6XyZXkZFt/vTpnjW4/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex+Yy2SeYaCH9YuzFr/Y02FjAiPfSSvzGeaqhCq5SKyoA/5Pt9SjZzJuLnZ2/iWHCr4+jbyxWt84mqETQ8hg6V95zqJ34yTeBc3sh3d0me7Z1nME8IdCjd76oRxlKDCqWY7IStp8ziLqUYW0ym1G4/SUdwFCiBTUF5ywZrjc5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZBb7p5x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwciNKvW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ZBb7p5x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gwciNKvW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72AD81F38E;
	Wed,  4 Sep 2024 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09Bue8XVCm3MvH12Oc04zMmBCuvjYSyE7C6A5k12jN8=;
	b=0ZBb7p5xEq9VIhF6rgJ/Vm9WxZvy59M/8TCR41brajp9yAzyajvivk51Cg9EVaBD9sdo8w
	LQTbRdXO/dSM3J7a3JLF8jX/jtSU9ZFAnlZqwFafL49KsoMKRFLXrdwaHvgM8Q0qa01rQz
	dz2eGKMINKyu8mwxcm7Ez/pRFuAaaKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09Bue8XVCm3MvH12Oc04zMmBCuvjYSyE7C6A5k12jN8=;
	b=gwciNKvW5DDV0i6ug5x9pFEDpbbxLNfXENDJSQeuOgpt31weLCSnQfrfyJntPyIoPRHn8x
	61Asd2Rw5JmcafBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725452460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09Bue8XVCm3MvH12Oc04zMmBCuvjYSyE7C6A5k12jN8=;
	b=0ZBb7p5xEq9VIhF6rgJ/Vm9WxZvy59M/8TCR41brajp9yAzyajvivk51Cg9EVaBD9sdo8w
	LQTbRdXO/dSM3J7a3JLF8jX/jtSU9ZFAnlZqwFafL49KsoMKRFLXrdwaHvgM8Q0qa01rQz
	dz2eGKMINKyu8mwxcm7Ez/pRFuAaaKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725452460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09Bue8XVCm3MvH12Oc04zMmBCuvjYSyE7C6A5k12jN8=;
	b=gwciNKvW5DDV0i6ug5x9pFEDpbbxLNfXENDJSQeuOgpt31weLCSnQfrfyJntPyIoPRHn8x
	61Asd2Rw5JmcafBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B0B2139D2;
	Wed,  4 Sep 2024 12:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QjJSEqxQ2GaJTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 12:21:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5B2AA0968; Wed,  4 Sep 2024 14:20:43 +0200 (CEST)
Date: Wed, 4 Sep 2024 14:20:43 +0200
From: Jan Kara <jack@suse.cz>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
	paolo.valente@unimore.it, mauro.andreolini@unimore.it,
	avanzini.arianna@gmail.com, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH for-6.12 3/4] block, bfq: don't break merge chain in
 bfq_split_bfqq()
Message-ID: <20240904122043.nyaouj7qt2fyp6xa@quack3>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <20240902130329.3787024-4-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902130329.3787024-4-yukuai1@huaweicloud.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,toxicpanda.com,kernel.dk,unimore.it,gmail.com,vger.kernel.org,huawei.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 02-09-24 21:03:28, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Consider the following scenario:
> 
>     Process 1       Process 2       Process 3       Process 4
>      (BIC1)          (BIC2)          (BIC3)          (BIC4)
>       Λ               |               |                |
>        \-------------\ \-------------\ \--------------\|
>                       V               V                V
>       bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
> ref    0              1               2                4
> 
> If Process 1 issue a new IO and bfqq2 is found, and then bfq_init_rq()
> decide to spilt bfqq2 by bfq_split_bfqq(). Howerver, procress reference
> of bfqq2 is 1 and bfq_split_bfqq() just clear the coop flag, which will
> break the merge chain.
> 
> Expected result: caller will allocate a new bfqq for BIC1
> 
>     Process 1       Process 2       Process 3       Process 4
>      (BIC1)          (BIC2)          (BIC3)          (BIC4)
>                       |               |                |
>                        \-------------\ \--------------\|
>                                       V                V
>       bfqq1--------->bfqq2---------->bfqq3----------->bfqq4
> ref    0              0               1                3
> 
> Since the condition is only used for the last bfqq4 when the previous
> bfqq2 and bfqq3 are already splited. Fix the problem by checking if
> bfqq is the last one in the merge chain as well.
> 
> Fixes: 36eca8948323 ("block, bfq: add Early Queue Merge (EQM)")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/bfq-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
> index ffaa0d56328a..ca766b7d5560 100644
> --- a/block/bfq-iosched.c
> +++ b/block/bfq-iosched.c
> @@ -6727,7 +6727,7 @@ bfq_split_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq)
>  {
>  	bfq_log_bfqq(bfqq->bfqd, bfqq, "splitting queue");
>  
> -	if (bfqq_process_refs(bfqq) == 1) {
> +	if (bfqq_process_refs(bfqq) == 1 && !bfqq->new_bfqq) {
>  		bfqq->pid = current->pid;
>  		bfq_clear_bfqq_coop(bfqq);
>  		bfq_clear_bfqq_split_coop(bfqq);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

