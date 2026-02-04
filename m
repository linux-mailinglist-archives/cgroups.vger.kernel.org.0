Return-Path: <cgroups+bounces-13654-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAywMWHQgmk8cAMAu9opvQ
	(envelope-from <cgroups+bounces-13654-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:51:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C221E19E0
	for <lists+cgroups@lfdr.de>; Wed, 04 Feb 2026 05:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACB2F300B5BF
	for <lists+cgroups@lfdr.de>; Wed,  4 Feb 2026 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F87334EF1B;
	Wed,  4 Feb 2026 04:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epOOaSKl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmp2Obzf"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0346434DB78
	for <cgroups@vger.kernel.org>; Wed,  4 Feb 2026 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770180703; cv=none; b=nkls9zlcSBQLIm9FnLi2x6OSdZB0ClxeyIiDXXkzGc94IUMLRoU53vISfIJZR5yN0ZxrfSp7JkseTT+M/5/U2hLLXhycc8MJ8hotGHTrfUEVULhyfmgLKTyK77OVVBkhQsEpI5jaftU1RAnKYhTGX7x7MHxy4RrRrzU0H8NzChM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770180703; c=relaxed/simple;
	bh=D8rFsDusdghX9Cf6V/kCkMURMbR/46pNYwM4R/WsxV0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VN0zg1trEPPbuPKFWpN4a5Jh31s6UbgAjNgs9dKjJhRLz4bEO283R82AKo1zPkzo77UPhBnPsCnYKLVDhy3AclzXAQa5ONJMgx+J224D6Io656n1lwn4pfZy+XSKe+zCWktJYFS6lV6hbK0ZZ/gTtbJYAb0/qAdZKGHJcz+DAgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=epOOaSKl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmp2Obzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770180702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqp85rJLzs+OcPVvimtwEtdfYFvEbLOSgnCsPP9SUU0=;
	b=epOOaSKl1PIyWppDInQ99pYpXaqBFAyH+FCF/Q17WCblpLp+qWm6wymFSz1ny6lRm6SU6N
	s7zDj++vgt4Hu3ygY1n0AI0goKZQXJ8kvZvKa+fkq2QkW/Fq1pH4YA8migHI+EWnmRDoWZ
	ISyGv4kDjy0X0YjkcZ+TRGJYhAkp2ro=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-WOmYKNX5NUW_49DCyxyrxw-1; Tue, 03 Feb 2026 23:51:40 -0500
X-MC-Unique: WOmYKNX5NUW_49DCyxyrxw-1
X-Mimecast-MFC-AGG-ID: WOmYKNX5NUW_49DCyxyrxw_1770180700
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c6a87029b6so1925127085a.1
        for <cgroups@vger.kernel.org>; Tue, 03 Feb 2026 20:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770180700; x=1770785500; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pqp85rJLzs+OcPVvimtwEtdfYFvEbLOSgnCsPP9SUU0=;
        b=dmp2Obzfnm+vQfInWFPGTm/QAEgIGOKlzuh9JlpIl5M8cQRu/N8zrQKbxIU9/lG60X
         v9RHKN/kFlmP+ywGK1s2R3b7goQ4vZRqLpzP9WKpqXbBOMwQN8tkkFDFYhKSKSasrq/c
         HZ21/TUV8aqT+gFZtqXBMFeG5PVlMxuOKSDncKxaFWXVpzhOGztbBFEhBTViGxijunhn
         mR84djYu/RvrPoQBNyg3OIqu54uYvC/R9esUqdQMlTqRAkkYvDIfuuwbhIBCnAU5PsTl
         k3l3KQbXvGOh5KyMfnWy8GuXFOjYKN05GqaK8ldIEZQ/zrZ9dvV1fZsus2TUipbspUnE
         zWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770180700; x=1770785500;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pqp85rJLzs+OcPVvimtwEtdfYFvEbLOSgnCsPP9SUU0=;
        b=ercQECHTUBAWO1NEsj7uCTCyLKrvXN+0rkdsUeQMP2kTg/e2ElCNUSooasL3TY4sa+
         g+pr27SEUnXVM3TUzUCqvrfVh0UFU+fd7U1ONIJpDMimNs6NIlU3KVMqrzlwk6CIfrlU
         upAuXzg7lWJ5lret5h/SPifD3lt7jamDIUuxaJiUm8SmZc934DOmksNKoBuSS0PZcJ3U
         WAMoMwF8C0QpAxfQZiux5rC/OhkB+kgdbol36iQHShVSEockNLe62cp74WxdkUHydA8M
         NCUF3IJ/M6goQUOsQa6Xvdaz1UYMXA1YSQdBXZT9mjHpVSiWsfoiyBU34NRuFZBt+p2N
         uldQ==
X-Gm-Message-State: AOJu0Ywq0fgD5FcyXHzdVuM8wWzDQ4ReA/d4vekoVihgHpgo7oPz5UcB
	GXMkXzs5mpRSgFpoinD417znaf3ugpYU6iXjz9cub7pZ1l8moNACA4V+pobPmQfots9DpfUloKZ
	5AUOiQQSPSNBDoevhT5MMsl5ze1y7zOMiTeEHdTNA7deas1HAy7R44Bl5pAw=
X-Gm-Gg: AZuq6aIWG6g7xzDjoZeZCcUWa/ymF7k6zRJk1QKu8ueNalH2d3yNVnMblLXiGuYfxDt
	8uztut7eEX/JxrQgXEF9tzzmk8mREysuJU5AtaQCI8f3h0wRQ0sP/Ab7wp4zHgAH5eUsM0LcsAZ
	8MjzPBUU81VI8VDFwlo9B7iuBZjtizg9N6xZr1yGbcJpByEpoX5At8ylt7EYJFSRrnEi+vUhX5w
	znuLWT2nh05HhK2kkIeELy/OmCFNN+mgq0r+Q3CG7PqfcPEO6HIuOXelcAwrieckJlP9/jrTerg
	jo5dqHePWzGXdgFTZqogp19ioFrbYJOHHXAjHp3R+dSo3X3w5dFPREpAdlL/6s/+6gvP3ay7+ir
	2FMY9L9RrYy7BFy8vFLv4M0btIRV9F2NdUU6JdZVqtK11IzmhU+Jgb+yM
X-Received: by 2002:a05:620a:410e:b0:8c6:e0c5:7bbc with SMTP id af79cd13be357-8ca2f9fdd41mr205364385a.76.1770180700333;
        Tue, 03 Feb 2026 20:51:40 -0800 (PST)
X-Received: by 2002:a05:620a:410e:b0:8c6:e0c5:7bbc with SMTP id af79cd13be357-8ca2f9fdd41mr205362285a.76.1770180699876;
        Tue, 03 Feb 2026 20:51:39 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521bfeac0sm12038286d6.9.2026.02.03.20.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 20:51:39 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <617f19e4-cac0-4dab-801c-f1a31f0233a8@redhat.com>
Date: Tue, 3 Feb 2026 23:51:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/for-next v3 2/3] cgroup/cpuset: Defer
 housekeeping_update() calls from CPU hotplug to workqueue
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
References: <20260202201144.1669260-1-longman@redhat.com>
 <20260202201144.1669260-3-longman@redhat.com>
 <bddeef2f-1bde-480d-ba36-c0a59b6467b3@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <bddeef2f-1bde-480d-ba36-c0a59b6467b3@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-13654-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[llong@redhat.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,test_cpuset_prs.sh:url]
X-Rspamd-Queue-Id: 6C221E19E0
X-Rspamd-Action: no action

On 2/3/26 10:27 PM, Chen Ridong wrote:
>
> On 2026/2/3 4:11, Waiman Long wrote:
>> The update_isolation_cpumasks() function can be called either directly
>> from regular cpuset control file write with cpuset_full_lock() called
>> or via the CPU hotplug path with cpus_write_lock and cpuset_mutex held.
>>
>> As we are going to enable dynamic update to the nozh_full housekeeping
>> cpumask (HK_TYPE_KERNEL_NOISE) soon with the help of CPU hotplug,
>> allowing the CPU hotplug path to call into housekeeping_update() directly
>> from update_isolation_cpumasks() will likely cause deadlock. So we
>> have to defer any call to housekeeping_update() after the CPU hotplug
>> operation has finished. This is now done via the workqueue where
>> the actual housekeeping_update() call, if needed, will happen after
>> cpus_write_lock is released.
>>
>> We can't use the synchronous task_work API as call from CPU hotplug
>> path happen in the per-cpu kthread of the CPU that is being shut down
>> or brought up. Because of the asynchronous nature of workqueue, the
>> HK_TYPE_DOMAIN housekeeping cpumask will be updated a bit later than the
>> "cpuset.cpus.isolated" control file in this case.
>>
>> Also add a check in test_cpuset_prs.sh and modify some existing
>> test cases to confirm that "cpuset.cpus.isolated" and HK_TYPE_DOMAIN
>> housekeeping cpumask will both be updated.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   kernel/cgroup/cpuset.c                        | 37 +++++++++++++++++--
>>   .../selftests/cgroup/test_cpuset_prs.sh       | 13 +++++--
>>   2 files changed, 44 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index d705c5ba64a7..e98a2e953392 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1302,6 +1302,17 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>   	return false;
>>   }
>>   
>> +static void isolcpus_workfn(struct work_struct *work)
>> +{
>> +	cpuset_full_lock();
>> +	if (isolated_cpus_updating) {
>> +		isolated_cpus_updating = false;
>> +		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
>> +		rebuild_sched_domains_locked();
>> +	}
>> +	cpuset_full_unlock();
>> +}
>> +
>>   /*
>>    * update_isolation_cpumasks - Update external isolation related CPU masks
>>    *
>> @@ -1310,14 +1321,34 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
>>    */
>>   static void update_isolation_cpumasks(void)
>>   {
>> -	int ret;
>> +	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
>>   
>>   	if (!isolated_cpus_updating)
>>   		return;
>>   
>> -	ret = housekeeping_update(isolated_cpus);
>> -	WARN_ON_ONCE(ret < 0);
>> +	/*
>> +	 * This function can be reached either directly from regular cpuset
>> +	 * control file write or via CPU hotplug. In the latter case, it is
>> +	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
>> +	 * of the task that initiates CPU shutdown or bringup.
>> +	 *
>> +	 * To have better flexibility and prevent the possibility of deadlock
>> +	 * when calling from CPU hotplug, we defer the housekeeping_update()
>> +	 * call to after the current cpuset critical section has finished.
>> +	 * This is done via workqueue.
>> +	 */
>> +	if (current->flags & PF_KTHREAD) {
>> +		/*
>> +		 * We rely on WORK_STRUCT_PENDING_BIT to not requeue a work
>> +		 * item that is still pending.
>> +		 */
>> +		queue_work(system_unbound_wq, &isolcpus_work);
>> +		/* Also defer sched domains regeneration to the work function */
>> +		force_sd_rebuild = false;
> Eh, looking at the call path:
>
> cpuset_hotplug_update_tasks
> 	update_parent_effective_cpumask
> 		update_isolation_cpumasks
> 		force_sd_rebuild = false;
> 	cpuset_force_rebuild();
>
> Setting force_sd_rebuild to false here might be redundant, given that
> cpuset_force_rebuild() is called immediately afterward.

Thank for spotting that. I will try to address this.

Thanks,
Longman


