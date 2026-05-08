Return-Path: <cgroups+bounces-15677-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KL3IIiA/WnSfAAAu9opvQ
	(envelope-from <cgroups+bounces-15677-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:19:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FD74F266B
	for <lists+cgroups@lfdr.de>; Fri, 08 May 2026 08:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21DE83025E4D
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2026 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3B376BD5;
	Fri,  8 May 2026 06:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOxKgS0f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E45377EAC
	for <cgroups@vger.kernel.org>; Fri,  8 May 2026 06:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220949; cv=none; b=R5XoA37mtDtjARBpd4UYbM4goQT2WHnLG3NrEuVk5lC2OOgpORBZrknkyeOIyJMcPNE2o40u1r9NCLbvs4iJ02tjijeZv3pBVnoYbVph1zSZ53YCZ6vBCO3qxdKUPdTHcycZUn0Yg1g7ZA+cVjcptXEViSXUE5CZ8nOUebD2wbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220949; c=relaxed/simple;
	bh=X/UwBiqYJJsZdLIhzNbBhdHndZA/DHq8ISQzw6+43nQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWkPFALbMPSEzBhz8mipctLtX+GrJNCyToYGN+jUX3j9VuU8/Vm9AlVhhItM7WmSXJQRj1WNjcKUdu3iHjB3dUHZ5sNEwJ+K7Vwcc1Q350oif4UQJ97KFEU7dv89VdZ22lFkuYwFdvUQJxsjymAMdHlnKjSKYfChH9MgaKu7UFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOxKgS0f; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-83945063f70so1251118b3a.0
        for <cgroups@vger.kernel.org>; Thu, 07 May 2026 23:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220936; x=1778825736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rTA4CLloFA4PwQRrVh0QkmYUnMpU+ksh9ffBPHB3lKQ=;
        b=MOxKgS0fwrByji1o9c+g9YVl0zcgayKX+eVmzFysIZzE9wjv1n6gCZepL1qlCevm1K
         3OPdzM506A0HEZBMJuXtiCozaVZvPc6hXRlvzfAUFk3FoZCPtoB6mK70PF50Be86jOTS
         JKpErMtA4XHQBYFZ1+b+nfqKgVCJ/fcw8uCm/sdNGrY9CDu3IrD0J8bPDFd6JzjSd9Xy
         gtlv+JMsULKjeJPI23elYRnds0EuI+jdWtMVOQWCjvlDyXSw/irmXByDoaNmLpi4Gl6l
         K5ekaSDE/XGHD+CV+/BXELZS91Tg6p0d7nt84tX76U37rkZAQVv7haO3tptHF4W8fvTj
         LMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220936; x=1778825736;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTA4CLloFA4PwQRrVh0QkmYUnMpU+ksh9ffBPHB3lKQ=;
        b=HVvvxFRlA28nDf6d7kWDjiSZp8zmgU1vTP7FkAhimnxg+Iqv6sgaSXTWAjYu+sbaJa
         1GsPwq77U2XXjSI7RCctxEkLfrxFyVFCYIiEWG3hkTSbnnXdWlP8dDPSjpYZxfW9Hmhf
         lJceoq+KfAKmtM/DR6ci5Q83tkgMHlXB89AbgRsMk51EHD9iYoR+Y2a7TDI0boyVMti+
         QwaGXLbgYo/J2V9sX+gnZjYiMH4CBM+sQRHyKf+R5AiB0fL51lXLS7u8w5X2lB6M9AuA
         iRGuCpgB3Qn4Fx7mZeLOxNZMNHCnraF7jjYvLvQw+JCQNTj6QkuxP1fxwfYky6/lL1I1
         lM0w==
X-Gm-Message-State: AOJu0YwviCMhmDJD5ecPcC5T/l5WLSDfjcjXE0sIlVmhU+n7zZ2imRHD
	yBOlZUnjm/5CC20YtIDisEAITzyBRFAzqxHUDj2iie/u1N++s5862pF/
X-Gm-Gg: AeBDievEYOIGX/Po+qztcdYOX/+kxY8yOdDU4TarPAUBxhmhp1wQuCt1+l3/7QM9j5M
	LzSE9RORNH8LEhntW6FidWQ8wbai6zKkGyeND8eUI1ezqbx/eah9+5IjYfL4qHZrIWHTkPq6Cf3
	jRvGm4OQaNNcgtInbd/L7FmYot2KykDwtUv5UrC9nxnD/e9YCJlQ3YEJqluN+z+LNSSBbpA99Tz
	SelA7VOjlrVWFu3WoSnPVqjbi1m5Ed9eJgUNFEXme685PVQ8YitrPwfM4OcC7VvzRdGUnyo/IJa
	4+NnLHlvCq5VSlXk5u2c2xLh+OrnyUz32eBTwst3J7Euk5mPEFzD1cj6JzZ8kgXeTpEzxIYUk05
	Pcp+0Ye7GByj98rg13I9wwZBDQkwVKRpQ6TQsXiJj2JWzbDvvUiNfNCtqO1hONRNeRVk3HFXI6h
	KjlQAHUjhClpKp/q5/3TUeAC/RSHmsdnw=
X-Received: by 2002:a05:6a00:2e96:b0:81f:4e1c:1d3b with SMTP id d2e1a72fcca58-83bb8b74857mr5006976b3a.23.1778220936181;
        Thu, 07 May 2026 23:15:36 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682a52cesm10551955b3a.57.2026.05.07.23.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 23:15:35 -0700 (PDT)
Message-ID: <407ab4a5-87e5-4eca-99d3-baa031935702@gmail.com>
Date: Fri, 8 May 2026 14:15:28 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: move PF_EXITING check before
 __GFP_HARDWALL in cpuset_current_node_allowed()
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
References: <20260507105434.3266234-1-chenwandun@lixiang.com>
 <02352ad2-9c85-4825-82b6-49c6a4b081d8@huaweicloud.com>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <02352ad2-9c85-4825-82b6-49c6a4b081d8@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 03FD74F266B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_FROM(0.00)[bounces-15677-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.660];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenwandun1@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:email,lixiang.com:email]
X-Rspamd-Action: no action



On 5/8/26 09:39, Chen Ridong wrote:
>
> On 2026/5/7 18:54, Chen Wandun wrote:
>> Since prepare_alloc_pages() unconditionally adds __GFP_HARDWALL for the
>> fast path when cpusets are enabled, the __GFP_HARDWALL check in
>> cpuset_current_node_allowed() causes the PF_EXITING escape path to be
>> skipped on the first allocation attempt.  This makes it unreachable in
>> the common case, so dying tasks can get stuck in direct reclaim or even
>> trigger OOM while trying to exit, despite being allowed to allocate from
>> any node.
>>
>> Move the PF_EXITING check before __GFP_HARDWALL so that dying tasks
>> can allocate memory from any node to exit quickly, even when cpusets
>> are enabled.
>>
>> Also update the function comment to reflect the actual behavior of
>> prepare_alloc_pages() and the corrected check ordering.
>>
>> Signed-off-by: Chen Wandun <chenwandun@lixiang.com>
>> ---
>>   kernel/cgroup/cpuset.c | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e3a081a07c6d..a48901a0416a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -4176,11 +4176,11 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>>    * current's mems_allowed, yes.  If it's not a __GFP_HARDWALL request and this
>>    * node is set in the nearest hardwalled cpuset ancestor to current's cpuset,
>>    * yes.  If current has access to memory reserves as an oom victim, yes.
>> - * Otherwise, no.
>> + * If the current task is PF_EXITING, yes. Otherwise, no.
>>    *
>>    * GFP_USER allocations are marked with the __GFP_HARDWALL bit,
>>    * and do not allow allocations outside the current tasks cpuset
>> - * unless the task has been OOM killed.
>> + * unless the task has been OOM killed or is exiting.
>>    * GFP_KERNEL allocations are not so marked, so can escape to the
>>    * nearest enclosing hardwalled ancestor cpuset.
>>    *
>> @@ -4194,7 +4194,9 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>>    * The first call here from mm/page_alloc:get_page_from_freelist()
>>    * has __GFP_HARDWALL set in gfp_mask, enforcing hardwall cpusets,
>>    * so no allocation on a node outside the cpuset is allowed (unless
>> - * in interrupt, of course).
>> + * in interrupt, of course).  The PF_EXITING check must therefore
>> + * come before the __GFP_HARDWALL check, otherwise a dying task
>> + * would be blocked on the fast path.
>>    *
>>    * The second pass through get_page_from_freelist() doesn't even call
>>    * here for GFP_ATOMIC calls.  For those calls, the __alloc_pages()
>> @@ -4204,6 +4206,7 @@ static struct cpuset *nearest_hardwall_ancestor(struct cpuset *cs)
>>    *	in_interrupt - any node ok (current task context irrelevant)
>>    *	GFP_ATOMIC   - any node ok
>>    *	tsk_is_oom_victim   - any node ok
>> + *	PF_EXITING   - any node ok (let dying task exit quickly)
>>    *	GFP_KERNEL   - any node in enclosing hardwalled cpuset ok
>>    *	GFP_USER     - only nodes in current tasks mems allowed ok.
>>    */
>> @@ -4223,11 +4226,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>>   	 */
>>   	if (unlikely(tsk_is_oom_victim(current)))
>>   		return true;
>> -	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
>> -		return false;
>> -
>>   	if (current->flags & PF_EXITING) /* Let dying task have memory */
>>   		return true;
>> +	if (gfp_mask & __GFP_HARDWALL)	/* If hardwall request, stop here */
>> +		return false;
>>   
>>   	/* Not hardwall and node outside mems_allowed: scan up cpusets */
>>   	spin_lock_irqsave(&callback_lock, flags);
> Make sense.
>
> BTW, how did you find this issue?
I found this while reviewing the cpuset node-allowed logic during an
investigation into a memory allocation issue (not the root cause of
that investigation).
>
> Reviewed-by: Chen Ridong <chenridong@huaweicloud.com>
>


