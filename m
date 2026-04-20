Return-Path: <cgroups+bounces-15367-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCjtOnSq5WkCmwEAu9opvQ
	(envelope-from <cgroups+bounces-15367-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 06:24:20 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7E7426B6F
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 06:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C76A30082BE
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 04:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857FD37F8C0;
	Mon, 20 Apr 2026 04:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="e7yWFhT1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4662F744F
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 04:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776659058; cv=none; b=KvDly8fmHJHWC8fpQEXD8u5TRA8h1QdsHuaPWgirLXrU/21TSYWBhavh1DsI71J34jq335P7dbKBh7eUDkt+97RHX8tczYcdQts+QaWi45z6HsCbc0W1lb11BqCIVxeFSpZ6RPIiUAooL/pCqAY2m/QALy6YdyB2YWRsJcFbf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776659058; c=relaxed/simple;
	bh=0ZpLmOcLcnK4da77S5TGIzVJmjCohlBH6F21+hRNvbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgJBUnIqI7Li5RhCd/3fVPKKLIy0A6HRF4mNnlazisG/dUYjBuDj0mg8MwECgTPKXAoIzhjAKtatykG9rKqSlAvl/nhF5K/WR+mQZmsZvIfjrxpqiuMLcHZmqZYQ3fzUTr3a4Kejn0I3x77YjKOsR+DBwTfanTjfgDsT5ZdB+Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=e7yWFhT1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b24fdac394so24420855ad.3
        for <cgroups@vger.kernel.org>; Sun, 19 Apr 2026 21:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776659056; x=1777263856; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4vxCa2z6HMfkqchkIRH1SCRyDKSV7iNrjCESWkp9vxY=;
        b=e7yWFhT1Hm3gVMRlIDFzbxz9muB+yqiltvZJ6mKEoCEp1aMKI7jGQjxPtZgyvrjKQO
         JMHdN3YxgiaK+UddUbeIkROCWrqkYKPd/aI3JH+Z91ol6qGzY9QQWmypCs2tTmkGolp+
         G1t//iZssQzRh8rtbdOyXTI9mjvdnG8RetSRpB4en5PamoEnOC0RzVFY9zDXHFjg8Dr2
         1UDaTT2E5eJ1HsVZLwPGuiTp1/3Z3ZMDT9b8upGijjH3MfNAJaklOZnmYvJBvn2qW8V/
         R4DafwzofokCIoShbSLvrtg9WQpQUMqfH1KYhXf+RmTaXh1/IF/N4SLroS/CMT+PH7F0
         CYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776659056; x=1777263856;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4vxCa2z6HMfkqchkIRH1SCRyDKSV7iNrjCESWkp9vxY=;
        b=LTFl+ffqsqeDNoW3J3IPSDbTJ+NVhXeOnoiEQyYOW4ByewNWKch5jPXtTemDbd+NSF
         B5+6Sa7X0GfZScDl45hgiOGSDLeT42gyUsWqikT8LtAAM0xZa7r1DJV1tnrnIbSFM+zX
         YMafNKigz7OyxjXZih6GtEgLelgwqJ5Ho+tDRv2K8CTPCApoxEstU49g+D31AtK5B1yS
         CrWxNoX7vzXdnxYPqgVggwYgb5FW1vIiwU6khPrm8o9VuEVoQ2dlswCARTkWl6n/UIxr
         qNJa8FBac2Al3YgDh2Ums/cdomlxYCm15zU5LRsXE/+odaJPYR2/TY/BqtuJ0hRtzoZB
         T3kg==
X-Forwarded-Encrypted: i=1; AFNElJ9yGcIvNiMLtlurpbRysWwBPOJApAB8BfoOvfeqUZIpi4Yp/qUx+7wRqpdJ54ZF4ekHLLPuDFsp@vger.kernel.org
X-Gm-Message-State: AOJu0YyZHazcqOQm/JaXlDCHIr8/agFJKKKm6Zxn3yEn5JoV6pvZVt88
	jn7DhvoK0PPJveb28mPrmdZfDn18vSjwcEPd3E+lt3t4HVMN/Re3TP7BpKa7HOW03/4=
X-Gm-Gg: AeBDievYmxikn9GcH1Lxx+sbxkh9lpChvv5n/ouKDa9ax31QUijEdXEjDh+8HLsW9vn
	3Kgj/g57BVC2RWMJfxHtQkht0k+sR7R802TttVd+ifBy8w13xfn4Gp9JgsAiHvV1Oh/dpB5hM7a
	fvNYd3HtRhkpTpIWkarW6jjY0aabZlxI2zYcOaBUSZEkoaUj9K0CaQyXMkyEO9AJP8zsVbgBbN9
	H/FtgwNi0HHQ2ibDfLJ8SVJfwndDchu0nRM7NhqO+Pls5dTo6AMaj4sEBJvwYRiLEt2tq9lF8Uf
	rgfTyOBQIBhYmC0Wsar1Aq0tfwlw044tW3LDNc2Y05uXGCs/PIfxvAvD92Xs0cBomHqPvZz7DFV
	CW1d7JboOfWDbeAdiNcwInukLUP5KIv+MgRLiMPoKI9h/KAtj9+MnD/cD/Vz3ZMuhwG23OITw1Z
	qw1AkisQygmvn+IUwLodvUgabFBqZj3CP0v14l6KGRmH/nRGjcLDdrdVjvd16SbkWoEEzIXV4S5
	xmatw==
X-Received: by 2002:a17:903:2acb:b0:2b4:5ed3:415f with SMTP id d9443c01a7336-2b5f9f05bc9mr131455295ad.18.1776659055637;
        Sun, 19 Apr 2026 21:24:15 -0700 (PDT)
Received: from [10.88.210.107] ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa1739fsm89696905ad.22.2026.04.19.21.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2026 21:24:15 -0700 (PDT)
Message-ID: <53e18c70-a670-47cd-ba17-2d6f1adde1c8@bytedance.com>
Date: Mon, 20 Apr 2026 12:24:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/cpuset: Skip cpuset_top_mutex for cpuset.mems
 writes
To: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
References: <20260418100220.3717207-1-sunjunchao@bytedance.com>
 <7249e345-8218-4232-9fc1-4109039a9aad@huaweicloud.com>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <7249e345-8218-4232-9fc1-4109039a9aad@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-15367-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sunjunchao@bytedance.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]
X-Rspamd-Queue-Id: 8C7E7426B6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 9:24 AM, Chen Ridong wrote:
> 
> 
> On 2026/4/18 18:02, Julian Sun wrote:
>> cpuset_top_mutex serializes regular cpuset writes against the
>> housekeeping_update() path. That path has to drop cpus_read_lock() and
>> cpuset_mutex before calling housekeeping_update(), while keeping the
>> housekeeping cpumask update ordered against other cpuset writes.
>>
>> cpuset_write_resmask() currently takes cpuset_top_mutex for all
>> resource-mask writes. This is broader than needed for cpuset.mems. The
>> mems path updates nodemasks, task mems_allowed and mempolicy state, and
>> may queue page migration work, but it does not change isolated CPUs,
>> scheduler domains or housekeeping cpumasks.
>>
> 
> Hello,

Hi, Thanks for your review.
> 
> Has any regression been observed that prompted you to make this change?

No regression has been observed.

I sent this patch because I recently noticed the global cpuset_top_mutex 
while looking at the cpuset locking. After checking what it is used for, 
it looked like the cpuset.mems path does not need to take it.

> 
>> Add cpuset_mems_lock()/cpuset_mems_unlock() for FILE_MEMLIST. The new
>> lock helper still takes cpus_read_lock() and cpuset_mutex because
>> update_nodemask() can reach check_insane_mems_config(), which calls
>> static_branch_enable_cpuslocked(). CPU mask writes keep using
>> cpuset_full_lock().
>>
>> Record update_housekeeping and force_sd_rebuild on entry and warn if
>> FILE_MEMLIST changes either value. If that warning ever fires, the mems
>> path has gained a sched-domain or housekeeping side effect and must stop
>> using the lighter lock path.
>>
>> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>> ---
>>   kernel/cgroup/cpuset.c | 40 ++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 36 insertions(+), 4 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 1335e437098e..5e0927ea71a9 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -331,6 +331,28 @@ void cpuset_full_unlock(void)
>>   	mutex_unlock(&cpuset_top_mutex);
>>   }
>>   
>> +/*
>> + * cpuset.mems writes cannot change isolated CPUs or sched domains. Skip
>> + * cpuset_top_mutex, but verify that the path leaves finalizer state unchanged.
>> + */
>> +static void cpuset_mems_lock(bool *hk_update, bool *sd_rebuild)
>> +{
>> +	cpus_read_lock();
>> +	mutex_lock(&cpuset_mutex);
>> +
>> +	*hk_update = update_housekeeping;
>> +	*sd_rebuild = force_sd_rebuild;
>> +}
>> +
>> +static void cpuset_mems_unlock(bool hk_update, bool sd_rebuild)
>> +{
>> +	WARN_ON_ONCE(update_housekeeping != hk_update);
>> +	WARN_ON_ONCE(force_sd_rebuild != sd_rebuild);
>> +
>> +	mutex_unlock(&cpuset_mutex);
>> +	cpus_read_unlock();
>> +}
>> +
>>   #ifdef CONFIG_LOCKDEP
>>   bool lockdep_is_cpuset_held(void)
>>   {
>> @@ -3209,6 +3231,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   {
>>   	struct cpuset *cs = css_cs(of_css(of));
>>   	struct cpuset *trialcs;
>> +	cpuset_filetype_t type = of_cft(of)->private;
>> +	bool mems = type == FILE_MEMLIST;
>> +	bool hk_update = false;
>> +	bool sd_rebuild = false;
>>   	int retval = -ENODEV;
>>   
>>   	/* root is read-only */
>> @@ -3216,7 +3242,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   		return -EACCES;
>>   
>>   	buf = strstrip(buf);
>> -	cpuset_full_lock();
>> +	if (mems)
>> +		cpuset_mems_lock(&hk_update, &sd_rebuild);
>> +	else
>> +		cpuset_full_lock();
>>   	if (!is_cpuset_online(cs))
>>   		goto out_unlock;
>>   
>> @@ -3226,7 +3255,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   		goto out_unlock;
>>   	}
>>   
>> -	switch (of_cft(of)->private) {
>> +	switch (type) {
>>   	case FILE_CPULIST:
>>   		retval = update_cpumask(cs, trialcs, buf);
>>   		break;
>> @@ -3243,9 +3272,12 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>   
>>   	free_cpuset(trialcs);
>>   out_unlock:
>> -	cpuset_update_sd_hk_unlock();
>> -	if (of_cft(of)->private == FILE_MEMLIST)
>> +	if (mems) {
>> +		cpuset_mems_unlock(hk_update, sd_rebuild);
>>   		schedule_flush_migrate_mm();
>> +	} else {
>> +		cpuset_update_sd_hk_unlock();
>> +	}
>>   	return retval ?: nbytes;
>>   }
>>   
> 

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>

