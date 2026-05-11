Return-Path: <cgroups+bounces-15728-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH5AOeeiAWpKhAEAu9opvQ
	(envelope-from <cgroups+bounces-15728-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:35:35 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B650B01C
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73BAA319382E
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BD3CA486;
	Mon, 11 May 2026 09:05:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207733F8B1;
	Mon, 11 May 2026 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490329; cv=none; b=U4ScQFTbyQpWM0DFAJWkyUytM1q5dKPb4jb57C6tyhUf8E/mTYcJLwS/VETTNCA4ca8C6Tg2YUznjOGw35fOzj9n+7LrhdPfdZw9qV2i/Ilo32E9J+TLkf61ljBheJ0ba72yNprF99pXwcFwvS5jrbw+qTllUZy0VFejbER2J/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490329; c=relaxed/simple;
	bh=srk5mZG7aTdHgcZkrQCyoDZYyMrqXbpKqPz+lXoIZSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MuUkK3/bLYgV4OzeFsmLhLiKOQYOIOo1Oe4HYD8cZJ4JKTORxWHqGTCp4KUAn7dtrweEX5caO7YnCoi7kEc58WN5oYWVvSxH2Db/2VlbxMFEtFMrzpJ54AnmSf2cj8gfgRQR2ia72kyisM0Lwqr1bmR+cGSkJ+Q31Sz0M6lEdQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gDYhL1dVSzYQv2f;
	Mon, 11 May 2026 17:04:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 047C840576;
	Mon, 11 May 2026 17:05:19 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgDHJC3NmwFqxEJ0Bw--.56076S2;
	Mon, 11 May 2026 17:05:18 +0800 (CST)
Message-ID: <22d91fdc-db54-4bcf-bc5a-2a496cc43057@huaweicloud.com>
Date: Mon, 11 May 2026 17:05:17 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup: Keep favordynmods enabled once per-threadgroup
 rwsem is active
To: Guopeng Zhang <zhangguopeng@kylinos.cn>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Yi Tao <escape@linux.alibaba.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260511081607.83490-1-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHJC3NmwFqxEJ0Bw--.56076S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw17tFWxKr4DKFWDKr4Uurg_yoW5ZrWfpa
	nrAryftws8KFn0yas7ta40qF18Jr4FqFW7JFWDKw18Aw13GrsYqr4Ik3WUXF1jvFnrGFW7
	JwnIyr4kCF4qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 455B650B01C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,huaweicloud.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-15728-lists,cgroups=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action



On 2026/5/11 16:16, Guopeng Zhang wrote:
> cgroup_enable_per_threadgroup_rwsem is a one-way switch. Once it is
> enabled, cgroup.procs writes use the per-threadgroup rwsem and
> cgroup_threadgroup_change_begin()/end() use the same global state to
> decide whether to take and release the per-threadgroup rwsem.
> 
> The disable path warned that the per-threadgroup rwsem mechanism could not
> be disabled but still called rcu_sync_exit() and cleared
> CGRP_ROOT_FAVOR_DYNMODS. That partially disabled favordynmods while the
> global per-threadgroup rwsem mode remained enabled: cgroup.procs writes
> would continue to use the per-threadgroup rwsem, while
> cgroup_threadgroup_change_begin()/end() could observe the exited rcu_sync
> state. The root would also no longer report favordynmods.
> 
> Make the transition match the documented one-way semantics. Call
> rcu_sync_enter() only for the first favordynmods enable, and make later
> disable attempts a no-op after warning once the per-threadgroup rwsem mode
> has been enabled.
> 
> Fixes: 0568f89d4fb8 ("cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
> Manual AB test:
> 
> Before this patch:
>   enable favordynmods:
>     cgroup2 opts: rw,relatime,favordynmods
>   disable attempt:
>     cgroup2 opts: rw,relatime
>   dmesg:
>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
> 
> After this patch:
>   enable favordynmods:
>     cgroup2 opts: rw,relatime,favordynmods
>   disable attempt:
>     cgroup2 opts: rw,relatime,favordynmods
>   dmesg:
>     cgroup: cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled
> 
>  kernel/cgroup/cgroup.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 6152add0c5eb..fd10fb5b3598 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1297,14 +1297,13 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
>  	 */
>  	percpu_down_write(&cgroup_threadgroup_rwsem);
>  	if (favor && !favoring) {
> -		cgroup_enable_per_threadgroup_rwsem = true;
> -		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
> +		if (!cgroup_enable_per_threadgroup_rwsem) {

Is this branch redundant? I think if (favor && !favoring) alone should suffice —
or can the outer condition be true twice (i.e., can this block be entered
multiple times)?


> +			cgroup_enable_per_threadgroup_rwsem = true;
> +			rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
> +		}
>  		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
>  	} else if (!favor && favoring) {
> -		if (cgroup_enable_per_threadgroup_rwsem)
> -			pr_warn_once("cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
> -		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
> -		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
> +		pr_warn_once("cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
>  	}
>  	percpu_up_write(&cgroup_threadgroup_rwsem);
>  }

-- 
Best regards,
Ridong


