Return-Path: <cgroups+bounces-13816-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Q9uaHjJIimm+JAAAu9opvQ
	(envelope-from <cgroups+bounces-13816-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:48:50 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69399114894
	for <lists+cgroups@lfdr.de>; Mon, 09 Feb 2026 21:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF265301FFBC
	for <lists+cgroups@lfdr.de>; Mon,  9 Feb 2026 20:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BFC333426;
	Mon,  9 Feb 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PKlnI1dM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IPTip7RA"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF84330339
	for <cgroups@vger.kernel.org>; Mon,  9 Feb 2026 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770670086; cv=none; b=mW4t347/Wc7bPKm25Z1UDF/7v3gxPjCLEfkao0loN34XLKEkKKy96T5GlE8aaAIM1mfcXW+BVUyL6ZZTVCDZgiP5quYLomNeG4qkDUZ1UCdOCEVRd/Jfo7gsKJtGNcr4/OarpcW2GbCXakFXLlm2nQBuz0I4ADofK0dt/Z2sRm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770670086; c=relaxed/simple;
	bh=zB0TgsTqPOUZ6c7fcWiP0FVWOC8g2W9dhEAU3gPWMZw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WAGOLcBhn0zYvF90MSxrJpSy2R+9Rqm1Jl/3k6D/SCL4Wb+j2+q6LEM/FAmf+9jPBB5AcTXSgpL3+I3JnoPJBDMBeyLwdhhMiwXCd7P7mWk/Zg5ApAZ7eSjDlImBFrdoCR0rInTqdKbEaQ5N74Y4jSLuCGPLejpDjM7eGwSDGf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PKlnI1dM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IPTip7RA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770670083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFz2HHJO0flQkCT+EP3v58+8Capft4jJvp38xn9xVew=;
	b=PKlnI1dMCJsxWkFptwU5VJUAl6TbeNrGk8HZaM2eTlpjvp3ymKxXN8T2Tcn3+JYbbnRXKC
	5WcQvDmEBcWM65w/u5AWqGey3ooTY1zVmyWCgN1WEVHFc8TtKL/1yydJY9ocFwfeW0NDsi
	r+fJV6/QjV42Wbq7CS+m6VvztIgiYH0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-zxNEysHuPaGoW_42PFE1nw-1; Mon, 09 Feb 2026 15:48:00 -0500
X-MC-Unique: zxNEysHuPaGoW_42PFE1nw-1
X-Mimecast-MFC-AGG-ID: zxNEysHuPaGoW_42PFE1nw_1770670080
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6a291e7faso1594874485a.3
        for <cgroups@vger.kernel.org>; Mon, 09 Feb 2026 12:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770670080; x=1771274880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BFz2HHJO0flQkCT+EP3v58+8Capft4jJvp38xn9xVew=;
        b=IPTip7RALhcWS1iOeWM31mDs2IqIGhbfZ1vGqU4dHCijywTpZCSa3jpGiW9cdAKTuv
         1tpIm+FrB5gcUls0SOX1YwtKvWcjTy59CVQVm0cYM1sq98iK9ipVKTrQMuvbMhySppsH
         esXfm4q20Lp9HXvO5QrI1NxZ858z3t+A/lRjEAuaLoxT2q1+Af/pXZ3BGuM73d5RhhZV
         fzZCg/7bCD9ED/YiXt4G2yXGe/jB5VJLyCvC2hVS+j0cTDVBwUAojERZM96nb9EtBiae
         Ui2/vnaHbZYlLBMHjNJrpIrEM57FuX3LDJCjSFr6yIXJnhMOEUbjPAiGleCAUPMZcENy
         1ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770670080; x=1771274880;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFz2HHJO0flQkCT+EP3v58+8Capft4jJvp38xn9xVew=;
        b=RpJZ8/P4qlum6bvPrkC8GE71U5yFbe1nX1XOoGk2w5yWF4klOsUem2zoVq+oOLH77g
         8nIj6oI15Lq/yGvsD/dpruDl9cynXhbJbf7aB70Eag59d/8Yn+f/OvZnk20OpFJB5HtF
         rtwemvcIjgwQHD/wWcjClbFIOwL003NlyO33TcoZU47NwkHbMZi5ezi/jc11gQCI26N+
         N6bSRhJEg8Mxr4LkQCOBDbhnoYZxfi6gAaw8zYnOBTNa89oIk/O/BHmiWtp3Idxhr+zI
         aZXOSzZt3JsXMdN+oSwWgYwo0xjGUuKF3mds2Qy842pdLndOBLvIpcJS0soKmoufURXN
         saOA==
X-Gm-Message-State: AOJu0YzlagbE+To1QcEdyuZRyC9/7h2D/z0XYfiNQfhjVUsfoWnJBKLz
	G89YvWnkj9o0rH/+VOBNpSOwpVZ/OigQS10jmfxl/rBUE/nwWxtP5Carfyv8t5UlhYwo3Pcbu9V
	t+wg6l1KpMks1+SODQICQRL+z70VyOBIRQH974kGOdNbZtMv6ma3MGsQxCsQ=
X-Gm-Gg: AZuq6aJaVYbEe90yGSO4DR7nreBe44divRTdlZ8/dCBU3wOEC4H1NJccRYnxAKpxOSM
	yRF7vKr5VVau4bCQZcFdW21qngy7pJUdARZXBNHi0Tx32gy7spfiz3vKSkHeJk5yz5rYYX6nFFC
	eJ1NnYmKCmscM7jq8fxReggebCQu25FPks4TSBg7nV9B4e5DuFMpYXU8W4shNAKHSeqm0r2rxXu
	YFFPtQ+JB/EDXfZLrKo00e2CVN1prwD6YeNv0Id0Y4+iF8Jc/6Nrs/TitzL4p9ZX9fo98k3UcoR
	4VLIokfr76h159DsCT7165Ev9kNtEenLvEVDPaA8hDROQb1z3I/eD4PXg4szzx44NitOHgo6fUd
	H7cQcwNLiyo5NQep0dudF9T3bWkxpTcGxKBPFNCDrIBQGkztXOXHgioJv
X-Received: by 2002:a05:620a:3723:b0:8c6:d309:8801 with SMTP id af79cd13be357-8caf1bc28e0mr1629153185a.86.1770670080223;
        Mon, 09 Feb 2026 12:48:00 -0800 (PST)
X-Received: by 2002:a05:620a:3723:b0:8c6:d309:8801 with SMTP id af79cd13be357-8caf1bc28e0mr1629150585a.86.1770670079848;
        Mon, 09 Feb 2026 12:47:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf982b811sm952627885a.29.2026.02.09.12.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 12:47:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8d140b06-4e90-4c58-90dd-61aa5d1cbd5c@redhat.com>
Date: Mon, 9 Feb 2026 15:47:58 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v4 4/4] cgroup/cpuset: Eliminate some duplicated
 rebuild_sched_domains() calls
To: Chen Ridong <chenridong@huaweicloud.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260206203712.1989610-1-longman@redhat.com>
 <20260206203712.1989610-5-longman@redhat.com>
 <da363ddb-c006-4ff8-a327-5ef75045d3fd@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <da363ddb-c006-4ff8-a327-5ef75045d3fd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13816-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 69399114894
X-Rspamd-Action: no action

On 2/9/26 2:53 AM, Chen Ridong wrote:
>
> On 2026/2/7 4:37, Waiman Long wrote:
>> Now that we are going to defer any changes to the HK_TYPE_DOMAIN
>> housekeeping cpumasks to either task_work or workqueue
>> where rebuild_sched_domains() call will be issued. The current
>> rebuild_sched_domains_locked() call near the end of the cpuset critical
>> section can be removed in such cases.
>>
>> Currently, a boolean force_sd_rebuild flag is used to decide if
>> rebuild_sched_domains_locked() call needs to be invoked. To allow
>> deferral that like, we change it to a tri-state sd_rebuild enumaration
>> type.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d26c77a726b2..e224df321e34 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -173,7 +173,11 @@ static bool		isolcpus_twork_queued;	/* T */
>>    * Note that update_relax_domain_level() in cpuset-v1.c can still call
>>    * rebuild_sched_domains_locked() directly without using this flag.
>>    */
>> -static bool force_sd_rebuild;			/* RWCS */
>> +static enum {
>> +	SD_NO_REBUILD = 0,
>> +	SD_REBUILD,
>> +	SD_DEFER_REBUILD,
>> +} sd_rebuild;					/* RWCS */
>>   
>>   /*
>>    * Partition root states:
>> @@ -990,7 +994,7 @@ void rebuild_sched_domains_locked(void)
>>   
>>   	lockdep_assert_cpus_held();
>>   	lockdep_assert_cpuset_lock_held();
>> -	force_sd_rebuild = false;
>> +	sd_rebuild = SD_NO_REBUILD;
>>   
>>   	/* Generate domain masks and attrs */
>>   	ndoms = generate_sched_domains(&doms, &attr);
>> @@ -1377,6 +1381,9 @@ static void update_isolation_cpumasks(void)
>>   	else
>>   		isolated_cpus_updating = false;
>>   
> If isolated_hk_cpus is defined, I believe isolated_cpus_updating becomes redundant.
Note that they have different exclusion rules. Other than that, you are 
right that "!cpumask_equal(isolated_hk_cpu, isolated_cpus)" should be 
equivalent to isolated_cpus_updating. But because of the different 
exclusion rules, there are restriction on where you can use one or the 
other.
>
>> +	/* Defer rebuild_sched_domains() to task_work or wq */
>> +	sd_rebuild = SD_DEFER_REBUILD;
>> +
> There is a potential issue: we defer all domain rebuilds here, including those
> triggered by hotplug events which may change the isolation state.
>
> The problem is that functions like cpuset_cpu_active, which rely on the
> scheduler domains being up-to-date—will, also be delayed. Is that okay?

No, we are not deferring all domain rebuilds. We are just deferring 
domain rebuilds that involves changes in the set of isolated CPUs. 
Domains rebuild will still happen if there is no changes in the set of 
isolated CPUs. I need to take a further to investigate if this is a 
problem or not. Anyway s suggested in my reply to Federic, I am 
considering to not changing isolated_cpus due to hotplug events. In that 
case, this problem should be gone.

Cheers,
Longman


