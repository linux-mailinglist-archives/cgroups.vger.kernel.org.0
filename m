Return-Path: <cgroups+bounces-8949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CF8B16BFB
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 08:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F2818C693E
	for <lists+cgroups@lfdr.de>; Thu, 31 Jul 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E97242927;
	Thu, 31 Jul 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f20RvpfT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zZxff0tW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hE3oKsnw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qOql1gyA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DA13D52F
	for <cgroups@vger.kernel.org>; Thu, 31 Jul 2025 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753942844; cv=none; b=pHjFdEWt8g0SSM0XqItfpv7WqU8lOxUWRhCaDlwFB3QmxX+FDPdWqr80edohdrYfIBOgBRobMS2q/e5KE7xUTRGLy2zEnHvtD6wsMLXyXUDD1zL1hLnPSF7wRVsfe6iWgdp82DU9VZIkHQWa47lxaXzKv85pJz/D6m+ENnKzZmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753942844; c=relaxed/simple;
	bh=Yjti4CUR7TQcb5sWl1icbveMX40Gc8XA1uEAjDD/Kmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dZ4ZTwzXWMic7MClelNTghoPLUS/RM0GjAfS4yKOtm5dPLz2V5U+QjMrfqR/+yB1LUi9pR5QdrEIUgkqFsWISm5SCXigeZT9qFBzadRodY6qfq14qBMAyYLTeP0Jan6sMnEvv0KGr01Ex0Z/kPNLuDuSBHnWgwdXz6xxM+DeqBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f20RvpfT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zZxff0tW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hE3oKsnw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qOql1gyA; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C93E81F814;
	Thu, 31 Jul 2025 06:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrteJ67mSCnc/iU95eMDL1o2TpheWqWopmYroPxQUjE=;
	b=f20RvpfTmJ+boWtuud2nUb/zsFebP9gKzK4tvN1KniqqNkSATGHTNTPNujqDtvHE1ZCdC8
	EqDBIJWjR7ViQPyJih3gTmmBErvRnazrgEJFxyDYZsTbqShQnsZSTz7X35JTqrDnyfWxFn
	SBuhYEIVN9O49/JbUjbBIgIB4DVqGqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrteJ67mSCnc/iU95eMDL1o2TpheWqWopmYroPxQUjE=;
	b=zZxff0tWWjAz2mAq59ZJqPgyXldejqaRGf2R9lKkmP/rd37On+XM/yRzCcDeh+8kEKj6DH
	7JhppwZfZjiEonDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hE3oKsnw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qOql1gyA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753942840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrteJ67mSCnc/iU95eMDL1o2TpheWqWopmYroPxQUjE=;
	b=hE3oKsnwe2WDYtaJXEH9X8mBFJ+FZ68jwsJCGMFI9WQETb1N9p/iqThTPmQlrGNZyl2QYg
	iP3dmu+ErsbS6OPyaGjPUJCLQHfoDqKaEtVVi+MOpYT67SpgYxL2s3bNa8zObaajULYnrZ
	nn7YzQEZejQA6T+7DjvzYrC+1ORcBjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753942840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jrteJ67mSCnc/iU95eMDL1o2TpheWqWopmYroPxQUjE=;
	b=qOql1gyASBL9QLbFBQYNCAcL1gyRFgLYzu8LkzwHCzFE0j9g6NBRxZhOs6DmfbjJUxfbov
	NQ6gfPN9vXE6W8AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60BC113AA9;
	Thu, 31 Jul 2025 06:20:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id if1GFTgLi2iHWwAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 31 Jul 2025 06:20:40 +0000
Message-ID: <750643e5-9f24-4e4c-8270-e421a03cf463@suse.de>
Date: Thu, 31 Jul 2025 08:20:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mq-deadline: switch to use elevator lock
To: Yu Kuai <yukuai1@huaweicloud.com>, dlemoal@kernel.org, jack@suse.cz,
 tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, yukuai3@huawei.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 johnny.chenyi@huawei.com
References: <20250730082207.4031744-1-yukuai1@huaweicloud.com>
 <20250730082207.4031744-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250730082207.4031744-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: C93E81F814
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 7/30/25 10:22, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Replace the internal spinlock 'dd->lock' with the new spinlock in
> elevator_queue, there are no functional changes.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/mq-deadline.c | 58 +++++++++++++++++++++------------------------
>   1 file changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 9ab6c6256695..2054c023e855 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -101,7 +101,7 @@ struct deadline_data {
>   	u32 async_depth;
>   	int prio_aging_expire;
>   
> -	spinlock_t lock;
> +	spinlock_t *lock;
>   };
>   
>   /* Maps an I/O priority class to a deadline scheduler priority. */
> @@ -213,7 +213,7 @@ static void dd_merged_requests(struct request_queue *q, struct request *req,
>   	const u8 ioprio_class = dd_rq_ioclass(next);
>   	const enum dd_prio prio = ioprio_class_to_prio[ioprio_class];
>   
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>   
>   	dd->per_prio[prio].stats.merged++;
>   
> @@ -253,7 +253,7 @@ static u32 dd_queued(struct deadline_data *dd, enum dd_prio prio)
>   {
>   	const struct io_stats_per_prio *stats = &dd->per_prio[prio].stats;
>   
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>   
>   	return stats->inserted - atomic_read(&stats->completed);
>   }
> @@ -323,7 +323,7 @@ static struct request *__dd_dispatch_request(struct deadline_data *dd,
>   	enum dd_prio prio;
>   	u8 ioprio_class;
>   
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>   
>   	if (!list_empty(&per_prio->dispatch)) {
>   		rq = list_first_entry(&per_prio->dispatch, struct request,
> @@ -434,7 +434,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
>   	enum dd_prio prio;
>   	int prio_cnt;
>   
> -	lockdep_assert_held(&dd->lock);
> +	lockdep_assert_held(dd->lock);
>   
>   	prio_cnt = !!dd_queued(dd, DD_RT_PRIO) + !!dd_queued(dd, DD_BE_PRIO) +
>   		   !!dd_queued(dd, DD_IDLE_PRIO);
> @@ -466,10 +466,9 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   	struct request *rq;
>   	enum dd_prio prio;
>   
> -	spin_lock(&dd->lock);
>   	rq = dd_dispatch_prio_aged_requests(dd, now);
>   	if (rq)
> -		goto unlock;
> +		return rq;
>   
>   	/*
>   	 * Next, dispatch requests in priority order. Ignore lower priority
> @@ -481,9 +480,6 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
>   			break;
>   	}
>   
> -unlock:
> -	spin_unlock(&dd->lock);
> -
>   	return rq;
>   }
>   
> @@ -538,9 +534,9 @@ static void dd_exit_sched(struct elevator_queue *e)
>   		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_READ]));
>   		WARN_ON_ONCE(!list_empty(&per_prio->fifo_list[DD_WRITE]));
>   
> -		spin_lock(&dd->lock);
> +		spin_lock(dd->lock);
>   		queued = dd_queued(dd, prio);
> -		spin_unlock(&dd->lock);
> +		spin_unlock(dd->lock);
>   
>   		WARN_ONCE(queued != 0,
>   			  "statistics for priority %d: i %u m %u d %u c %u\n",

Do you still need 'dd->lock'? Can't you just refer to the lock from the
elevator_queue structure directly?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

