Return-Path: <cgroups+bounces-17852-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k5gzAW+BV2orTgAAu9opvQ
	(envelope-from <cgroups+bounces-17852-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 14:47:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FDA75E525
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 14:47:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=fWO690wB;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17852-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17852-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A4F3008A63
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E03EF67B;
	Wed, 15 Jul 2026 12:44:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EAB41DEDC
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 12:44:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119491; cv=none; b=oZpBWc0rtjgHHEtgc2xJ23+j/4y8AXiMJKL4Hi/EvUSwNg7uC4q8tLyt6zyMd567aJn89ZQ6eV5ZBTpMc72Y/UK+WggQ+hEkO3BhNBETgIFAdM1fY8jRDc9bFbnptZnkmcDONZpoaopwFr27Np6Xp+3uSld3NNCim4VjCicZOdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119491; c=relaxed/simple;
	bh=Z13mCUbakk2/eWKWVOW9JmH2y08kjCRmD4nBz4zwb/k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QK8bDceiVIMgT03OnaQEMegC5k6r28veW68p4vyvoEOaGZl9kI03rzdnyw8gqhmoilijCaeZRpYdkeHJvlG5z5p2jJ82vUo99om2MnGCrca8S4JCYkS4skgtkacHIpl5HuIaS/9jW4U+NYnhRlnXCFnY0ayknd26kbx44vXGIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fWO690wB; arc=none smtp.client-ip=95.215.58.172
Message-ID: <882fbac2-bd42-44a7-8fba-b387b3f0fb2b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784119481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/AULJBPGThMdnA0tzmgbmYa+mAU/00kSN7xatYKRAg=;
	b=fWO690wBzePos0ZC41kuuDNM8sVZqLVxEMHoTKZKM+z5izjTgG0PTb8GKSIt+lJpqHRw05
	lIIZ+C+q70zFfdYGqMrUsFCnLdwIcyaIRFRQg2Zgjq60IZ08Un5ol4ziofVIWiudMPimPN
	S8kQ+SBV6OGIbLSKrMYlHq7kGtKdWBk=
Date: Wed, 15 Jul 2026 20:44:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] blk-throttle: fix divide-by-zero on legacy iops limit of
 0
To: David Laight <david.laight.linux@gmail.com>
References: <20260714103552.1335658-1-cui.tao@linux.dev>
 <20260714123754.7a88a65b@pumpkin>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260714123754.7a88a65b@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17852-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,m:david.laight.linux@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 48FDA75E525
X-Rspamd-Action: no action



在 2026/7/14 19:37, David Laight 写道:
> On Tue, 14 Jul 2026 18:35:52 +0800
> Tao Cui <cui.tao@linux.dev> wrote:
> 
>> From: Tao Cui <cuitao@kylinos.cn>
>>
>> Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
>> throttle iops file (blkio.throttle.{read,write}_iops_device) silently
>> truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
>> an unsigned int field with no clamping. The cgroup v2 path,
>> tg_set_limit(), already clamps the same kind of value with
>> min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
>> the "!v -> U64_MAX" mapping only catches an explicit zero and does not
>> catch a value that truncates to zero.
>>
>> With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
>> the next IO reaches tg_within_iops_limit(), which computes
>>
>>     jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
>>
>> triggering a divide-by-zero oops.
>>
>> Fix it in two places:
>>
>>   * tg_set_conf(): clamp the value to UINT_MAX, consistent with
>>     tg_set_limit(). This closes the truncation root cause (and the
>>     general silent truncation for any value above UINT_MAX).
>>
>>   * tg_dispatch_iops_time(): treat iops_limit == 0 as unlimited so the
>>     divide in tg_within_iops_limit() is never reached, defending
>>     against any future path that could produce a zero limit.
>>
>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
>> ---
>>  block/blk-throttle.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
>> index ffc3b70065d4..3f3c1374f4b2 100644
>> --- a/block/blk-throttle.c
>> +++ b/block/blk-throttle.c
>> @@ -883,7 +883,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
>>  	u32 iops_limit = tg_iops_limit(tg, rw);
>>  	unsigned long iops_wait;
>>  
>> -	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
>> +	/*
>> +	 * iops_limit == 0 is not a valid limit. Treat it as unlimited so we
>> +	 * never reach the HZ / iops_limit divide in tg_within_iops_limit().
>> +	 */
>> +	if (iops_limit == UINT_MAX || iops_limit == 0 ||
>> +	    tg->flags & THROTL_TG_CANCELING)
>>  		return 0;
>>  
>>  	tg_update_slice(tg, rw);
>> @@ -1386,7 +1391,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>>  	if (is_u64)
>>  		*(u64 *)((void *)tg + of_cft(of)->private) = v;
>>  	else
>> -		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
>> +		*(unsigned int *)((void *)tg + of_cft(of)->private) =
>> +			min_t(u64, v, UINT_MAX);
> 
> The LHS casts look horrid - there has to be a nicer way to do that.
> 
> And you don't need min_t() a plain min() will be fine.
> 
Hi David,

Both done in v2 — introduced a void *field local so the writes read
*(u64 *)field / *(unsigned int *)field, and switched to
min(v, (u64)UINT_MAX).

Thanks,
Tao
> 	David
> 
> 
> 
>>  
>>  	tg_conf_updated(tg, false);
>>  	ret = 0;
> 


