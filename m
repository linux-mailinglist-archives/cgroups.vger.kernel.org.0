Return-Path: <cgroups+bounces-7190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192DCA69C16
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 23:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA65F9823F1
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 22:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF2A209F32;
	Wed, 19 Mar 2025 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uz26driL"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814581DD889
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 22:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742423440; cv=none; b=IsWTRkPbVqj/5Yi5NHOVjsrJfrBoCiNtD5F4PTQPE2J9iJTg2//1ekfVfGIsmuj6pH9QhwzV9A+toIuSprJ8UtjQNr2kokPc0guFPlcfzBG8WgBoDperaAVs21cc471uzh5v9KFEosBDSn0GkuEHaMsMzckNs185hY9ohS39Ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742423440; c=relaxed/simple;
	bh=BBMskuUk3/Og83hX/obRLQ+fIs4s7cZcODtbaQfMcGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YZRAzvMPPvHO7sqlisLybzXcw7LlriDqT0WDvx0quiOiIJLVmS5HoW0eHJgkPxUbMnyGFsZElah9tb7NU8UrQH7LSVfghAnbs1j0ILuJqQz36kmN+8KjctT4/7/fSDnsB6qpBL+uy0LPCJ31RPBmzAkHhX9uYs1Qh4TPEXkcUZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uz26driL; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742423426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd2WLgcVNLSLKrrtZe9Gb+auVQLYKtFm8mpaYa55yUc=;
	b=uz26driLeSZMatO2fSgTb797TKT5X5Zr1pAgC31DrX0BalzYpoNqjFTlQOTuwpQjor6DZU
	5TASewyKPmHxyscxdtamHEztWY3TLJIDHSiRdYSqI4yjBQz8tMO7lW8SpDVX2O4yZ2qZ2a
	E0iyZH2NBJsO6B7S5uZQYXbyvyvuz0M=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jingxiang Zeng <linuszeng@tencent.com>,  akpm@linux-foundation.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kernel@vger.kernel.org,  hannes@cmpxchg.org,  mhocko@kernel.org,
  muchun.song@linux.dev,  kasong@tencent.com
Subject: Re: [RFC 2/5] memcontrol: add boot option to enable memsw account
 on dfl
In-Reply-To: <m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
	(Shakeel Butt's message of "Wed, 19 Mar 2025 12:34:00 -0700")
References: <20250319064148.774406-1-jingxiangzeng.cas@gmail.com>
	<20250319064148.774406-3-jingxiangzeng.cas@gmail.com>
	<m35wwnetfubjrgcikiia7aurhd4hkcguwqywjamxm4xnaximt7@cnscqcgwh4da>
Date: Wed, 19 Mar 2025 22:30:20 +0000
Message-ID: <7ia4tt7ovekj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Shakeel Butt <shakeel.butt@linux.dev> writes:

> On Wed, Mar 19, 2025 at 02:41:45PM +0800, Jingxiang Zeng wrote:
>> From: Zeng Jingxiang <linuszeng@tencent.com>
>> 
>> Added cgroup.memsw_account_on_dfl startup parameter, which
>> is off by default. When enabled in cgroupv2 mode, the memory
>> accounting mode of swap will be reverted to cgroupv1 mode.
>> 
>> Signed-off-by: Zeng Jingxiang <linuszeng@tencent.com>
>> ---
>>  include/linux/memcontrol.h |  4 +++-
>>  mm/memcontrol.c            | 11 +++++++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>> 
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index dcb087ee6e8d..96f2fad1c351 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -62,10 +62,12 @@ struct mem_cgroup_reclaim_cookie {
>>  
>>  #ifdef CONFIG_MEMCG
>>  
>> +DECLARE_STATIC_KEY_FALSE(memsw_account_on_dfl);
>>  /* Whether enable memory+swap account in cgroupv2 */
>>  static inline bool do_memsw_account_on_dfl(void)
>>  {
>> -	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL);
>> +	return IS_ENABLED(CONFIG_MEMSW_ACCOUNT_ON_DFL)
>> +				|| static_branch_unlikely(&memsw_account_on_dfl);
>
> Why || in above condition? Shouldn't it be && ?
>
>>  }
>>  
>>  #define MEM_CGROUP_ID_SHIFT	16
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 768d6b15dbfa..c1171fb2bfd6 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -5478,3 +5478,14 @@ static int __init mem_cgroup_swap_init(void)
>>  subsys_initcall(mem_cgroup_swap_init);
>>  
>>  #endif /* CONFIG_SWAP */
>> +
>> +DEFINE_STATIC_KEY_FALSE(memsw_account_on_dfl);
>> +static int __init memsw_account_on_dfl_setup(char *s)
>> +{
>> +	if (!strcmp(s, "1"))
>> +		static_branch_enable(&memsw_account_on_dfl);
>> +	else if (!strcmp(s, "0"))
>> +		static_branch_disable(&memsw_account_on_dfl);
>> +	return 1;
>> +}
>> +__setup("cgroup.memsw_account_on_dfl=", memsw_account_on_dfl_setup);
>
> Please keep the above in memcontrol-v1.c

Hm, I'm not sure about this. This feature might be actually useful with
cgroup v2, as some companies are dependent on the old cgroup v1
semantics here but otherwise would prefer to move to v2.
In other words, I see it as a cgroup v2 feature, not as a cgroup v1.
So there is no reason to move it into the cgroup v1 code.

I think it deserves a separate config option (if we're really concerned
about the memory overhead in struct mem_cgroup) or IMO better a
boot/mount time option.

Thanks!

