Return-Path: <cgroups+bounces-17695-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id km/BNVawVGodpgMAu9opvQ
	(envelope-from <cgroups+bounces-17695-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:31:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4393774953E
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 11:31:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wmWjcdrQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Z8PIDeg;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wmWjcdrQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+Z8PIDeg;
	dmarc=pass (policy=none) header.from=suse.de;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17695-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17695-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBCCF30333F4
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 09:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1B93E5EF6;
	Mon, 13 Jul 2026 09:29:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12B93E5A19
	for <cgroups@vger.kernel.org>; Mon, 13 Jul 2026 09:29:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934979; cv=none; b=MfKZYWQmhCRrPx9a0VrU3/Is3mkPBiX97Wj2bJI8nx4OtKRiClsYphAyHscel4hceRQsV+Grn1CujH3KLDfHWOTuJJztEX7EJcNw/Zr/ezZ7du+4h782lEJNmn9CS/s78yvOum/5ABTloYoouDhjul1Ldji7JiHw5Dgq3aNHLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934979; c=relaxed/simple;
	bh=Sv7EfPKsdbJ6hdpMjzJTPLU8hZ/RskOBEKEerGdUwpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrNlETttSDo4yhCT//2AScd2Kpk++ezU6gRmAZhnJZlbdrhhQaMTnojVcQAlkKaPdChPhBUYnzOv5D44wVJ86M+8G0iJ4mKq0aetvPlttn4F/ktSl5n5q8Mh+4lca8mqNUoNJE8JN5uwiLeHhitQlLarQ4o/rJKaezUZhSWysm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wmWjcdrQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Z8PIDeg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wmWjcdrQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+Z8PIDeg; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0975177653;
	Mon, 13 Jul 2026 09:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783934976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=wmWjcdrQtwWtJIeyLq2t5fcwg5iX2uJajA/r/0RMTrEjlLscL3f4QsEFByBg3/2ReeQJYt
	FdU4qmXkDN98inPHlgV1owGzGkEbXZkw2ln0WTBPPuMj5ziyiqJjnljKAyYfNY4CuX1n1a
	jLomKU0J4eYnu+ZCUTEfDTO75sA1oTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783934976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=+Z8PIDeglO+Dj12Ww+r+s63GWL/dREZ5YhTFEjHue5szurCi8eQEz8zyOim1Z/6XbntnUP
	y+EzIprM/3lPc5BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783934976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=wmWjcdrQtwWtJIeyLq2t5fcwg5iX2uJajA/r/0RMTrEjlLscL3f4QsEFByBg3/2ReeQJYt
	FdU4qmXkDN98inPHlgV1owGzGkEbXZkw2ln0WTBPPuMj5ziyiqJjnljKAyYfNY4CuX1n1a
	jLomKU0J4eYnu+ZCUTEfDTO75sA1oTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783934976;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9gcUkxCkRN2ZaCCFrl4N86ehymkTSYCDoMlEuWqjAE=;
	b=+Z8PIDeglO+Dj12Ww+r+s63GWL/dREZ5YhTFEjHue5szurCi8eQEz8zyOim1Z/6XbntnUP
	y+EzIprM/3lPc5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B7312779AE;
	Mon, 13 Jul 2026 09:29:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U0pALP+vVGpCdwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 13 Jul 2026 09:29:35 +0000
Message-ID: <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
Date: Mon, 13 Jul 2026 11:29:35 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios
 from requeue work
To: Yu Kuai <yukuai@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Dongsheng Yang <dongsheng.yang@linux.dev>, Zheng Gu <cengku@gmail.com>,
 Coly Li <colyli@fygo.io>, Kent Overstreet <kent.overstreet@linux.dev>,
 Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
 Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
 dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
References: <20260704195124.1375075-1-yukuai@kernel.org>
 <20260704195124.1375075-2-yukuai@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260704195124.1375075-2-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17695-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,kernel.org,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hare@suse.de,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_RECIPIENTS(0.00)[m:yukuai@kernel.org,m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hare@suse.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fygo.io:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4393774953E

On 7/4/26 9:51 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> bio_set_dev() is about to become explicitly sleepable because it can
> associate the bio with a blkg for the destination queue.  NVMe failover
> can run from request completion context, and nvme_failover_req() also holds
> head->requeue_lock with interrupts disabled while it steals bios from the
> failed request.  Calling bio_set_dev() there is not safe once the helper is
> allowed to sleep.
> 
> The requeue lock only protects head->requeue_list.  Keep the list
> manipulation under that lock, but defer retargeting to nvme_requeue_work(),
> which already drains the list from process context before resubmitting each
> bio.  The bios remain private to the requeue list until the worker pops
> them, so moving the device switch there preserves the existing retry flow
> while avoiding a sleepable helper in completion context.
> 
> Signed-off-by: Yu Kuai <yukuai@fygo.io>
> ---
>   drivers/nvme/host/multipath.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..76baa180ae1c 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>   	struct nvme_ns *ns = req->q->queuedata;
>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>   	unsigned long flags;
> -	struct bio *bio;
>   
>   	nvme_mpath_clear_current_path(ns);
>   	atomic_long_inc(&ns->failover);
> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>   	}
>   
>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> -	for (bio = req->bio; bio; bio = bio->bi_next)
> -		bio_set_dev(bio, ns->head->disk->part0);

If you remove this the original device remains being referenced by
the bio, so there might be a chance of some accidentally referencing
the (now invalid) bdev.
I think it might be better if you were set it to NULL here, to
signal that this bio currently has no bdev associated.

>   	blk_steal_bios(&ns->head->requeue_list, req);
>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>   
> @@ -684,6 +681,7 @@ static void nvme_requeue_work(struct work_struct *work)
>   		next = bio->bi_next;
>   		bio->bi_next = NULL;
>   
> +		bio_set_dev(bio, head->disk->part0);
>   		submit_bio_noacct(bio);
>   	}
>   }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

