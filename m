Return-Path: <cgroups+bounces-15670-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKFxClpD/WkoZwAAu9opvQ
	(envelope-from <cgroups+bounces-15670-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 03:58:50 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6E14F0A75
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 03:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B92E6300D763
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BAB23D2A4;
	Fri,  8 May 2026 01:58:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9261FECAB;
	Fri,  8 May 2026 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205522; cv=none; b=SqoIiA3VmVwUdoloWqgyTPnXMDHizH5X8UhPplgCs5dvUTUQf9ojpTvN+qWqKM/iayf0Yv/WW9V2DOI/YjQ9GQyGkLYIXjOXpmq/H54vWkge0xqY8BMfBzf8RU5LLY8SqHl8r9epsIiyo/D1Ut6cE/5mbWXnmFVzMHo/3lI6OIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205522; c=relaxed/simple;
	bh=IFOa+dcoaldD4uCTzBx/ob6giJ4Z7U9VrpWeh2VXEOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdqFKLK4hPLzVDHMHs1pXz0TTSaVa0+oz+YhQW8UoZGw13ycW01R78c/8WPxQlJHa7AHDDhsmckXnALQMHYL1vSVWgh8tGjC0amMy9rLE2gqo6fmS82tQ3fMUF44uNBriZj4frwP9eXKICNwsSe05lm/DX6nl1Km9Wb7UfJ8crE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gBWxn2gRWzYQtlv;
	Fri,  8 May 2026 09:39:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7B15E40592;
	Fri,  8 May 2026 09:39:48 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDnTPvjPv1ptK3yBQ--.32089S2;
	Fri, 08 May 2026 09:39:48 +0800 (CST)
Message-ID: <02352ad2-9c85-4825-82b6-49c6a4b081d8@huaweicloud.com>
Date: Fri, 8 May 2026 09:39:47 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
To: Chen Wandun <chenwandun1@gmail.com>, longman@redhat.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260507105434.3266234-1-chenwandun@lixiang.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnTPvjPv1ptK3yBQ--.32089S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXry8WF45Ww1ftF4xGF17KFg_yoW5Kw15pF
	s5CayjyFs5AFyIkws0qw4kuFyF9w4rCF45GFyj934FvFZxtF1jkr1DG3W5XFyjyry5uF1F
	qF13tFs7ua1DAa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 2D6E14F0A75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15670-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,kernel.org,cmpxchg.org,suse.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:104.64.211.4:c];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lixiang.com:email,huaweicloud.com:email,huaweicloud.com:mid]
X-Rspamd-Action: no action



On 2026/5/7 18:54, Chen Wandun wrote:
> Since prepare_alloc_pages() unconditionally adds __GFP_HARDWALL for the
> fast path when cpusets are enabled, the __GFP_HARDWALL check in
> cpuset_current_node_allowed() causes the PF_EXITING escape path to be
> skipped on the first allocation attempt.  This makes it unreachable in
> the common case, so dying tasks can get stuck in direct reclaim or even
> trigger OOM while trying to exit, despite being allowed to allocate from
> any node.
> 
> Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
> can allocate memory from any node to exit quickly, even when cpusets
> are enabled.
> 
> Also update the function comment to reflect the actual behavior of
> prepare_alloc_pages() and the corrected check ordering.
> 
> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
> ---
>  kernel/cgroup/cpuset.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3a081a07c6d..a48901a0416a 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4176,11 +4176,11 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>   * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
>   * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
>   * yes.  If current has access to memory reserves as an oom victim, yes.
> - * Otherwise, no.
> + * If the current task is PF_EXITING, yes. Otherwise, no.
>   *
>   * GFP_USER allocations are marked with the __GFP_HARDWALL bit,
>   * and do not allow allocations outside the current tasks cpuset
> - * unless the task has been OOM killed.
> + * unless the task has been OOM killed or is exiting.
>   * GFP_KERNEL allocations are not so marked, so can escape to the
>   * nearest enclosing hardwalled ancestor cpuset.
>   *
> @@ -4194,7 +4194,9 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>   * The first call here from mm/page_alloc:get_page_from_freelist()
>   * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets,
>   * so no allocation on a node outside the cpuset is allowed (unless
> - * in interrupt, of course).
> + * in interrupt, of course).  The PF_EXITING check must therefore
> + * come before the __GFP_HARDWALL check, otherwise a dying task
> + * would be blocked on the fast path.
>   *
>   * The second pass through get_page_from_freelist() doesn't even call
>   * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
> @@ -4204,6 +4206,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>   *	in_interrupt - any node ok (current task context irrelevant)
>   *	GFP_ATOMIC   - any node ok
>   *	tsk_is_oom_victim   - any node ok
> + *	PF_EXITING   - any node ok (let dying task exit quickly)
>   *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
>   *	GFP_USER     - only nodes in current tasks mems allowed ok.
>   */
> @@ -4223,11 +4226,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  	 */
>  	if (unlikely(tsk_is_oom_victim(current)))
>  		return true;
> -	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
> -		return false;
> -
>  	if (current->flags & PF_EXITING) /* Let dying task have memory */
>  		return true;
> +	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
> +		return false;
>  
>  	/* Not hardwall and node outside mems_allowed: scan up cpusets */
>  	spin_lock_irqsave(&callback_lock, flags);

Make sense.

BTW, how did you find this issue?

Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>

-- 
Best regards,
Ridong


