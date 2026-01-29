Return-Path: <cgroups+bounces-13508-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNr0IrEte2mbCAIAu9opvQ
	(envelope-from <cgroups+bounces-13508-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 10:51:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBECAE45E
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 10:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 509C7300B461
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 09:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16DD376BD2;
	Thu, 29 Jan 2026 09:51:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1F0EAE7;
	Thu, 29 Jan 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769680300; cv=none; b=lxo78cHU62XhD9MjFYe0E7aG7RBHvpTZba7gTrTPpDwbaAu3LYIDHnpVgmrxXnlSMq18OR4ImUa9GqubIkcfvWFh0L9L8iY35BUHqE4brVxmEgt6WTWSUqjeyP6GIFQW3fWYSa2raKxwb8GlHoybUMa7MgiTd1OEpB2S6Gs/WfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769680300; c=relaxed/simple;
	bh=iPKeHQY/SEe8RmowNYDTmXbl8B82NqPO9DGJuPCk04Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMYJU8sUwGEJGOkmnZoSXG70Dg7NSnki+FD6QQtYGTdOqNVDnaZhBlS7s+k+C1PHapSOl3+DxRoByzCaaR753psa/RuVGQ9ZEqzd3NYcxi9ZRyUCgwve8IsAwvaLAVASkt3qMk2o0MDBpKCreAnffTFF8KayehbUTdnR7yBNfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4f1vXc2ns0zYQvHn;
	Thu, 29 Jan 2026 17:50:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24B004056D;
	Thu, 29 Jan 2026 17:51:35 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCXQ_SlLXtpnyQWFg--.58350S2;
	Thu, 29 Jan 2026 17:51:34 +0800 (CST)
Message-ID: <3a12eb16-3a91-4278-9dfd-6c6f424e7f9f@huaweicloud.com>
Date: Thu, 29 Jan 2026 17:51:33 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <asryf3kk6c337l33faqpeznk7d4a3rxblzmqrawxffq7sfbaf7@5yfzzdroltjq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXQ_SlLXtpnyQWFg--.58350S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4kZr47tryUAF1ruw48WFg_yoW8Aw1Upr
	Wvqw17Ka1kJF1fCw4vv3WIgryrt3Z3Gw1UtFn5GryxJw4Uu342gr1Igr4jvFy7Xr1fCw47
	JFWj9F9Fya4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,goodmis.org,efficios.com,gmail.com,linux.dev,vger.kernel.org,huawei.com];
	TAGGED_FROM(0.00)[bounces-13508-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCBECAE45E
X-Rspamd-Action: no action



On 2026/1/29 17:23, Michal Koutný wrote:
> On Thu, Jan 29, 2026 at 06:31:33AM +0000, Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The current cgroup subsystem limit of 16 is insufficient, as the number of
>> subsystems has already reached this maximum.
> 
> Indeed. But some of them are legacy (and some novel). Do you really need
> one kernel image with every subsys config enabled?
> 

We compiled with 'make allmodconfig'.

>> Attempting to add new subsystems beyond this limit results in boot
>> failures.
> 
> That sounds like BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) doesn't trigger
> during build for you. Is the macro broken?
> 

The BUILD_BUG_ON(CGROUP_SUBSYS_COUNT > 16) macro worked correctly. However, I
only modified the code to allow compilation to pass, and the system subsequently
failed to boot.

>> This patch increases the maximum number of supported cgroup subsystems from
>> 16 to 32, providing adequate headroom for future subsystem additions.
> 
> It may be needed one day but I'd suggest binding this change with
> introduction of actual new controller.
> >
> (As we have some CONFIG_*_V1 options that default to N, I'm thinking
> about switching config's default to N as well (like:
> CONFIG_CGROUP_CPUACCT CONFIG_CGROUP_DEVICE CONFIG_CGROUP_FREEZER
> CONFIG_CGROUP_DEBGU), arch/x86/configs/x86_64_defconfig is not exactly
> pinnacle of freshness :-/)
> 
> 

Can I propose increasing the maximum number now? If we switch certain configs to
default N and then a new subsystem is added later, the default configuration may
work fine, but it will become a problem under allmodconfig — which some users
actually rely on.

Besides, this shouldn't be a major change, right?

-- 
Best regards,
Ridong


