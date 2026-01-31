Return-Path: <cgroups+bounces-13562-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKDCErJwfWmzSAIAu9opvQ
	(envelope-from <cgroups+bounces-13562-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 04:02:10 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAFBC075E
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 04:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250FD3034658
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 03:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE06339875;
	Sat, 31 Jan 2026 03:00:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48303382F0;
	Sat, 31 Jan 2026 03:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769828413; cv=none; b=nIK6RH/tn1Uq2twd5+mW/or5S8kBOjimjqEa4uWDQgXfCHJUSlZ4BGtok59IoRrI2/FrIcynqMruT2AjmHInc8yale1VhQxBIX39ptePv0jBQCmPOAT3sOGM4lwhcnylEWC2dtH/NoNvOuIqDX2kTm3qKRuTcH1S9N5FXiiTHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769828413; c=relaxed/simple;
	bh=y+Cab3dQhVHz0xBzECojs2MRdDDVGQOQmnQpaYSYSMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjyohP8TCmupQeMp3zWhY/mWkdju2TcowMt6spXw/XO9rHpvp9W4jFpPeKjDm32N6f3+ANXr+RaHG6ZoMk7bsFcQy04y7YZHrK+Y70ma6ksFLyS25qTDs608FJwO8NW2ECLze3yIsFZQ14Z59g0Yl0C9U/cns/JSAYl0T+keWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4f2yKL33PXzKHMP6;
	Sat, 31 Jan 2026 10:59:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id DF03940574;
	Sat, 31 Jan 2026 11:00:06 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXQvM2cH1pd+DjFg--.14099S2;
	Sat, 31 Jan 2026 11:00:06 +0800 (CST)
Message-ID: <1f31d8d2-811d-4dff-b036-2eb201f623ba@huaweicloud.com>
Date: Sat, 31 Jan 2026 11:00:05 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: increase maximum subsystem count from 16 to
 32
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, inwardvessel@gmail.com,
 shakeel.butt@linux.dev, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20260129063133.209874-1-chenridong@huaweicloud.com>
 <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
 <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
 <stsf73lnkx2luuak3a7oi3q4l5axosrxogi2lncw4dkndnc2ge@3tioqa6ww5q7>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <stsf73lnkx2luuak3a7oi3q4l5axosrxogi2lncw4dkndnc2ge@3tioqa6ww5q7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQvM2cH1pd+DjFg--.14099S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rXw1UGF48Zr4UXF15CFg_yoW3trc_Wr
	Z0yr1kCr15AFyIkwsFvF4rCrWqyay8Kry3A3ykWr47ZryavrnxJw1kCFy5ZF47G3WIkrn7
	urn5ZanFv3sF9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUb
	mii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13562-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid,huaweicloud.com:email]
X-Rspamd-Queue-Id: BFAFBC075E
X-Rspamd-Action: no action



On 2026/1/30 18:22, Michal Koutný wrote:
> On Thu, Jan 29, 2026 at 05:51:33PM +0800, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> We compiled with 'make allmodconfig'.
> 
> A-ha.
> 
>> The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly.
> 
> Good.
> 
>> Can I propose increasing the maximum number now? If we switch certain configs to
>> default N and then a new subsystem is added later, the default configuration may
>> work fine, but it will become a problem under allmodconfig — which some users
>> actually rely on.
>>
>> Besides, this shouldn't be a major change, right?
> 
> I'd like there to be gradual move away from legacy controllers code
> captured in config defaults.
> Could you adjust the commit message to stress out the allmodconfig tests?
> 

Sure, will update.

-- 
Best regards,
Ridong


