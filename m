Return-Path: <cgroups+bounces-17579-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcNPBj7gTWrT/QEAu9opvQ
	(envelope-from <cgroups+bounces-17579-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:29:34 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C54721CCF
	for <lists+cgroups@lfdr.de>; Wed, 08 Jul 2026 07:29:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Rj8cXHvK;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17579-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17579-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 255DE300D1D9
	for <lists+cgroups@lfdr.de>; Wed,  8 Jul 2026 05:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A9D3BAD88;
	Wed,  8 Jul 2026 05:29:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240238423D
	for <cgroups@vger.kernel.org>; Wed,  8 Jul 2026 05:29:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783488569; cv=none; b=MId2yVu9uz2ZmdZeD90KTUkt8zeFge5ZNzn5c9aDNIWzEd4x3piTxXdAuwpeu5Lnim73YJNdmzMHbAGmOA/A6tCw1dzUx0SLhjiT2sD3DkYzB9kXpkFk87pQOSoC6wNucIqyalUrIm7zHPM9dwVFkMdJDVxCPdpvmOKaLtfpAm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783488569; c=relaxed/simple;
	bh=Mx23BEurYBdD9RV7F9WDzvH/insE4RCer0qkbmzdg8g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QscV4olg3LH/2FkdWD37iyUBh6PatPlqFXRJ8pKkGXTVf83Q5Mi7f8YowfE7yusw4JlwFksipK4YoO0KODVwbC/zt5/XmJnUamOjZEyB45OdXf4mdUnweKhJYu2ZmI0W5prrN4c2+3G2mOBzepEvTrzK0ZGD1NCZr+hVFXunLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rj8cXHvK; arc=none smtp.client-ip=95.215.58.170
Message-ID: <f2f3f741-3420-4dbb-92e1-1598370922d8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783488565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ejGpNrC2JAC9u86ZLZjXZFPEDbeattvNItYeox/bzCs=;
	b=Rj8cXHvKweEMm+W5fqA6b7YP4A3fV2fklHYQKl5KMaGONWwF9ffezJfBwyw9BnvsIgV5XK
	3YW7wnYtAFXKNrsqwWyxVTbPFwzgDas+7icpoMpofHYm7oA6q12qAF6CkIUpYhATgTLj4g
	WmOqCW+N5oID2TEisj5hLhTGGIyFA2Y=
Date: Wed, 8 Jul 2026 13:29:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, Yu Kuai <yukuai@fygo.io>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: Re: [PATCH] blk-cgroup: clear blkg->pd[] with WRITE_ONCE() in
 blkcg_deactivate_policy()
To: Guopeng Zhang <guopeng.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
References: <20260707125814.1978139-1-guopeng.zhang@linux.dev>
 <841e91db-a51e-4df5-8cfc-e3762a2fecf1@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <841e91db-a51e-4df5-8cfc-e3762a2fecf1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17579-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:yukuai@fygo.io,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:zhangguopeng@kylinos.cn,m:guopeng.zhang@linux.dev,m:tj@kernel.org,m:josef@toxicpanda.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A8C54721CCF

FYI, this WRITE_ONCE() change is also in Yu Kuai's in-flight series that
factors the pd teardown loop into a helper:

  https://lore.kernel.org/all/20260625025739.2459651-5-yukuai@kernel.org/

That series isn't merged yet (v3, 2026-06-25), so this minimal Fixes
patch is still useful in the meantime -- just flagging the overlap.

在 2026/7/8 13:10, Tao Cui 写道:
> 
> 
> 在 2026/7/7 20:58, Guopeng Zhang 写道:
>> From: Guopeng Zhang <zhangguopeng@kylinos.cn>
>>
>> blkcg_activate_policy() installs blkg->pd[] entries with WRITE_ONCE()
>> and also uses WRITE_ONCE() when clearing them on its error path.
>> blkg_to_pd() is used by RCU readers and reads the same array with
>> READ_ONCE().
>>
>> blkcg_deactivate_policy() clears the entry with a plain store. Use
>> WRITE_ONCE() there as well.
>>
>> Fixes: 56cc24f59c14 ("blk-cgroup: don't nest queue_lock under rcu in blkcg_print_blkgs()")
>> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
>> ---
>>  block/blk-cgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index d2a1f5903f24..a1dd69f99f5c 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -1691,7 +1691,7 @@ void blkcg_deactivate_policy(struct gendisk *disk,
>>  			if (blkg->pd[pol->plid]->online && pol->pd_offline_fn)
>>  				pol->pd_offline_fn(blkg->pd[pol->plid]);
>>  			pol->pd_free_fn(blkg->pd[pol->plid]);
>> -			blkg->pd[pol->plid] = NULL;
>> +			WRITE_ONCE(blkg->pd[pol->plid], NULL);
>>  		}
>>  		spin_unlock(&blkcg->lock);
>>  	}
> 
> Reviewed-by: Tao Cui <cuitao@kylinos.cn>
> 


