Return-Path: <cgroups+bounces-17714-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gFH3GkbYVGr3fgAAu9opvQ
	(envelope-from <cgroups+bounces-17714-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:21:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D513274AE10
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 14:21:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17714-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17714-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E73331FED4D
	for <lists+cgroups@lfdr.de>; Mon, 13 Jul 2026 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F8409134;
	Mon, 13 Jul 2026 12:12:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303963F58CC;
	Mon, 13 Jul 2026 12:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783944775; cv=none; b=oGD+fS18slEfVGYgmC+i0l591ek3Y8xyxI0+PDkXUMnd5hkz1PHFhL+QDpIJ/I5VTOyaVG7Lxg/wYG6k13iEYsxlCL4g8fS/hIAryPIXu6t0zHlOgQU8FKwGyUoSFVQWfQAy9U6MgjJAqmwutDKq7DzGXY4YG5HpcgK71y9gJFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783944775; c=relaxed/simple;
	bh=GijumX0JE2j1JX91GbOsOLhMJNjDmmJ36d5S80X0KTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lur+T+pmrrpnOO/iLCcnD5GkBcwKftGuMjy9l8OGFl5YoOildYXUuzSl7xc45xjSFGrf4NIW6Z/KDkCvHJlYGWoL/kFWguYdbcDlsB9pWTWIYFSoCDCo9e6Funw+LJRf+jXKKRUiEYKp+eg5ay+1oCLlZDsRGDknHjsxfDOTc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4694468BFE; Mon, 13 Jul 2026 14:12:45 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:12:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Yu Kuai <yukuai@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev, linux-bcache@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/17] nvme-multipath: retarget failedover bios
 from requeue work
Message-ID: <20260713121244.GA20084@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-2-yukuai@kernel.org> <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ded62a6-b3da-4790-adf0-566ded30ee43@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hare@suse.de,m:yukuai@kernel.org,m:axboe@kernel.dk,m:tj@kernel.org,m:hch@lst.de,m:kbusch@kernel.org,m:sagi@grimberg.me,m:agk@redhat.com,m:bmarzins@redhat.com,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:dongsheng.yang@linux.dev,m:cengku@gmail.com,m:colyli@fygo.io,m:kent.overstreet@linux.dev,m:josef@toxicpanda.com,m:yukuai@fygo.io,m:nilay@linux.ibm.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:dm-devel@lists.linux.dev,m:linux-bcache@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-17714-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,lst.de,grimberg.me,redhat.com,linux.dev,gmail.com,fygo.io,toxicpanda.com,linux.ibm.com,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fygo.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:from_mime,lst.de:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D513274AE10

On Mon, Jul 13, 2026 at 11:29:35AM +0200, Hannes Reinecke wrote:
> On 7/4/26 9:51 PM, Yu Kuai wrote:
>> From: Yu Kuai <yukuai@fygo.io>
>>
>> bio_set_dev() is about to become explicitly sleepable because it can
>> associate the bio with a blkg for the destination queue.  NVMe failover
>> can run from request completion context, and nvme_failover_req() also holds
>> head->requeue_lock with interrupts disabled while it steals bios from the
>> failed request.  Calling bio_set_dev() there is not safe once the helper is
>> allowed to sleep.
>>
>> The requeue lock only protects head->requeue_list.  Keep the list
>> manipulation under that lock, but defer retargeting to nvme_requeue_work(),
>> which already drains the list from process context before resubmitting each
>> bio.  The bios remain private to the requeue list until the worker pops
>> them, so moving the device switch there preserves the existing retry flow
>> while avoiding a sleepable helper in completion context.
>>
>> Signed-off-by: Yu Kuai <yukuai@fygo.io>
>> ---
>>   drivers/nvme/host/multipath.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index 9b9a657fa330..76baa180ae1c 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -149,7 +149,6 @@ void nvme_failover_req(struct request *req)
>>   	struct nvme_ns *ns = req->q->queuedata;
>>   	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
>>   	unsigned long flags;
>> -	struct bio *bio;
>>     	nvme_mpath_clear_current_path(ns);
>>   	atomic_long_inc(&ns->failover);
>> @@ -165,8 +164,6 @@ void nvme_failover_req(struct request *req)
>>   	}
>>     	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>> -	for (bio = req->bio; bio; bio = bio->bi_next)
>> -		bio_set_dev(bio, ns->head->disk->part0);
>
> If you remove this the original device remains being referenced by
> the bio, so there might be a chance of some accidentally referencing
> the (now invalid) bdev.
> I think it might be better if you were set it to NULL here, to
> signal that this bio currently has no bdev associated.

What should reference it?  This moves setting bi_bdev from the only
place adding to the list to the only place removing from the list.


