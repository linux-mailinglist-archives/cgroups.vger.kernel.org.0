Return-Path: <cgroups+bounces-17170-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 30AcAEzlOWowywcAu9opvQ
	(envelope-from <cgroups+bounces-17170-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:45:48 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 040DD6B3590
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 03:45:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17170-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17170-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A213066C74
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BB36A361;
	Tue, 23 Jun 2026 01:38:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40709364059;
	Tue, 23 Jun 2026 01:38:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178730; cv=none; b=FkZYj/vjMag+BDzvzALWIgevXIrotn4f9l5jCMeEVnojzIvCZhs9dY7eWaeycWJpwN38sgtwR3UsWVEmfMKgKaA/oFj0djgwyYHmD1/A65bdPYPkeZGPgQK2fGdZ7k+yDhdPWbAQgqLOew2bBL9Qk/O5gKxrutnDKQfB9My2w3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178730; c=relaxed/simple;
	bh=pQkKsv0LS1e1L2qQfvRpSKq1vZOaj0Ak+cvv6zPx9I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxSNsLKnGyFPCIAZr4IIByWTLseADIOvzrZMADTtVTGRkWJ5l8irIuEUFDwi9qXfrRrMWBRm7BLfT3jCNbgEyyTpQPN6bCAxavpaVZueMvLfXAdi8Daetg6zwW929JJ9GX7RU1HQlC1BzRrqYveyXEKhknn4IzrASX/872s/fmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gknkf1qsvzKHMVn;
	Tue, 23 Jun 2026 09:37:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8C10040957;
	Tue, 23 Jun 2026 09:38:43 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP1 (Coremail) with SMTP id cCh0CgAnKT6e4zlqiLkXCw--.54950S3;
	Tue, 23 Jun 2026 09:38:41 +0800 (CST)
Message-ID: <6880c1b0-8a56-4b50-9c1f-73acfb32ca27@huaweicloud.com>
Date: Tue, 23 Jun 2026 09:38:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] blk-cgroup: fix blkg leak in blkg_create() error path
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, tj@kernel.org,
 josef@toxicpanda.com, linux-block@vger.kernel.org
Cc: cgroups@vger.kernel.org, yangerkun@huawei.com, chengzhihao1@huawei.com,
 houtao1@huawei.com, yukuai@fygo.io
References: <20260622070714.1158886-1-wozizhi@huaweicloud.com>
 <20260622070714.1158886-2-wozizhi@huaweicloud.com>
 <38704548-786f-4ec7-afd4-228aa8d68ad7@linux.dev>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <38704548-786f-4ec7-afd4-228aa8d68ad7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnKT6e4zlqiLkXCw--.54950S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAry8Ww4fCrWkKF4fJr1fWFg_yoW5Ww43pF
	W3GF45ArZxKFn3Cay3tF17Xw1Fvr4rJr1rt398K34Ykry3uFnavFy8Cw45XFW7J3ZrCF1Y
	qFWYqFykKa4jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17170-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:yangerkun@huawei.com,m:chengzhihao1@huawei.com,m:houtao1@huawei.com,m:yukuai@fygo.io,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[huaweicloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wozizhi@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 040DD6B3590



在 2026/6/23 9:16, Tao Cui 写道:
> Hi Zizhi,
> 
> Thanks for the patch.  I ran into the same issue and posted a fix for it
> earlier:
> 
>    https://lore.kernel.org/all/20260507061229.57466-1-cuitao@kylinos.cn/
> 
> The leak fix is identical to yours (blkg_put() -> percpu_ref_kill()),
> plus one extra change: moving blkg->online = true into the success
> block:
> 
> 	if (likely(!ret)) {
> 		...
> +		blkg->online = true;
> 	}
> -	blkg->online = true;
> 
> On the failure path the blkg was never inserted into any list, and its
> blkg->pd[i]->online flags were not set either (those are in the same
> block).  Leaving blkg->online = true marks a blkg as online that was
> never created -- inconsistent with pd[]->online and with
> blkg_destroy(), which clears blkg->online = false.  Not observable
> today, since the failed blkg is on no list and unreachable by the
> online readers, but the flag should track the actual insertion.
> 
> (This was sent to the cgroups list rather than linux-block, hence the
> overlap.)
> 
> Thanks,
> Tao

I'm not subscribed to the cgroup mailing list, so I didn't see that this
issue had already been fixed. :( And indeed, your patch nicely updates
blkg->online as well. — I hadn't realized that.

Thanks for the heads-up!

Thanks,
Zizhi Wo

> 
> 在 2026/6/22 15:07, Zizhi Wo 写道:
>> When radix_tree_insert() fails in blkg_create(), the error path calls
>> blkg_put() to release the blkg. This was correct when blkg->refcnt was an
>> atomic_t: blkg_put() dropped it to 0 and triggered the release path.
>>
>> But commit 7fcf2b033b84 ("blkcg: change blkg reference counting to use
>> percpu_ref") switched refcnt to a percpu_ref. In percpu mode
>> percpu_ref_put() never checks for zero, so the release callback is never
>> invoked. This blkg is on neither blkcg->blkg_list nor queue->blkg_list, so
>> blkg_destroy_all() / blkcg_destroy_blkgs() can never reach it to call
>> blkg_destroy()->percpu_ref_kill() either, cause the leak.
>>
>> Fix it by killing the percpu_ref instead, which switches it to atomic mode
>> and drops the initial ref.
>>
>> Fixes: 7fcf2b033b84 ("blkcg: change blkg reference counting to use percpu_ref")
>> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>
>> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
>> ---
>>   block/blk-cgroup.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>> index bc63bd220865..6386fe413994 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -437,11 +437,11 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg, struct gendisk *disk,
>>   
>>   	if (!ret)
>>   		return blkg;
>>   
>>   	/* @blkg failed fully initialized, use the usual release path */
>> -	blkg_put(blkg);
>> +	percpu_ref_kill(&blkg->refcnt);
>>   	return ERR_PTR(ret);
>>   
>>   err_put_css:
>>   	css_put(&blkcg->css);
>>   err_free_blkg:


