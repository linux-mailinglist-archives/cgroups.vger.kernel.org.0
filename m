Return-Path: <cgroups+bounces-14613-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mj0JPp5qGl0uwAAu9opvQ
	(envelope-from <cgroups+bounces-14613-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 19:29:14 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFB820657B
	for <lists+cgroups@lfdr.de>; Wed, 04 Mar 2026 19:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B611B31CF770
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2026 18:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDC3D5235;
	Wed,  4 Mar 2026 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJBlPgky"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286D63D1CD4
	for <cgroups@vger.kernel.org>; Wed,  4 Mar 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772647904; cv=none; b=NmjHVN1Qs861S2aL2OY+iYPm6nmBkokELZXho9/ReCEb81Q6b02UMJhyAoLF8NXSLwpWcJEoHz65UPzKFbItig5fS2yHpVqIFcCeeJuMdTamu7g2cXyk81BnUQntutlWC5By5ou3ex9Lfqj/BzeGTkOE1KAw//XXtjKBfdZg5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772647904; c=relaxed/simple;
	bh=cb4y2nZytFUTBjTWPqQJWtOD68YUktKfQo9N/u0reMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FwCCKHD8eyeLD5UAcipgO9/NQyAXeDO06o8ToaIf/0+YIABPHMTmHcTAuqw4tABqs8rHp4dSpUIlIiXcig70mTYcBG6ONSr/1/F7OhNAL0CpGDFk1jxGJhj6jOwX1JaT3v9T3eUd0CflyJ17k1wRU8GG9K/OsMQ9wuOcSzcM1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bJBlPgky; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772647902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r75+9K5ySWolahPAJ2e0ED/yndC4WL32Fqg5S686FY8=;
	b=bJBlPgkypVqKsAMAc+xCZSuklipcRmi14gkVvNkKfg0lFDwUqKlJic5VBJQ0nR3AYM6Ww+
	3Ytf5HTyDfH2Eae5HvHI/+5VY3OahXT8wv6E8ib+ACCP7JVhfJknxb/FMCQg3PNUg4e/6J
	Ek14QNEUClYmbuPe8SObdPgiUVx8ut8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-b_lShdBIOHOfL7-cqWjQdg-1; Wed,
 04 Mar 2026 13:11:38 -0500
X-MC-Unique: b_lShdBIOHOfL7-cqWjQdg-1
X-Mimecast-MFC-AGG-ID: b_lShdBIOHOfL7-cqWjQdg_1772647895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8842919560B7;
	Wed,  4 Mar 2026 18:11:34 +0000 (UTC)
Received: from [10.22.89.197] (unknown [10.22.89.197])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3182818002A6;
	Wed,  4 Mar 2026 18:11:30 +0000 (UTC)
Message-ID: <dbddcc76-da17-4f7c-9e96-475bec0898d2@redhat.com>
Date: Wed, 4 Mar 2026 13:11:29 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] cgroup/cpuset: Defer housekeeping_update() calls
 from CPU hotplug to workqueue
To: Jon Hunter <jonathanh@nvidia.com>,
 Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20260221185418.29319-1-longman@redhat.com>
 <20260221185418.29319-8-longman@redhat.com>
 <1a89aceb-48db-4edd-a730-b445e41221fe@nvidia.com>
 <8ad885a8-be65-4d1b-b8c4-dabe50fe3788@redhat.com>
 <d0695355-87bd-4d05-ad4e-8e591e226108@nvidia.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <d0695355-87bd-4d05-ad4e-8e591e226108@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: EDFB820657B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-14613-lists,cgroups=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Action: no action


On 3/4/26 6:07 AM, Jon Hunter wrote:
>
> On 04/03/2026 03:58, Waiman Long wrote:
>
> ...
>
>> It looks that -EBUSY was returned when the script tries to online/ 
>> offline a CPU. I ran a simple script to repetitively doing offline/ 
>> online operation and couldn't reproduce the problem. I don't have 
>> access to the tegra board that you use for testing. Would you mind 
>> trying out the following patch to see if it can get rid of the problem.
>>
>> Thanks,
>> Longman
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e200de7c60b6..5a5953fb391c 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3936,8 +3936,10 @@ static void cpuset_handle_hotplug(void)
>>           * previously queued work. Since hk_sd_workfn() doesn't use 
>> the work
>>           * item at all, this is not a problem.
>>           */
>> -       if (update_housekeeping || force_sd_rebuild)
>> -               queue_work(system_unbound_wq, &hk_sd_work);
>> +       if (force_sd_rebuild)
>> +               rebuild_sched_domains_cpuslocked();
>> +       if (update_housekeeping)
>> +               queue_work(system_dfl_wq, &hk_sd_work);
>>
>>          free_tmpmasks(ptmp);
>>   }
>>
>>
>
> Yes that did the trick. Works for me. Feel free to add my ...
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com> 

Thanks for the confirmation.

Cheers,
Longman


