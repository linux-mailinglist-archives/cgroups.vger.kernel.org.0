Return-Path: <cgroups+bounces-12788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A0CCE5E48
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 04:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5413007945
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 03:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08D26463A;
	Mon, 29 Dec 2025 03:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCtlTqKH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dzpich9C"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669D23717F
	for <cgroups@vger.kernel.org>; Mon, 29 Dec 2025 03:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980440; cv=none; b=An/MztiMeRBMPOhzm5rBEKF+MO+vpQhxY/14MK4LLKZravtJjIGI5EHb5XIJSmowR4WP1SzKnZX6Mnf0uGJn2ti2c4pxRF2ADj2bdMgRRSJ8DiY56jHJJ3SbiG6Gfpgn9J5UAtLi5/+MIqODx2SNMGTibl1/TbmbfSiCsN1UOxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980440; c=relaxed/simple;
	bh=i/2pV3I6wfGKU/F6zki7C+oop7j6XFoO7cS1k967DAI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tPh+B087wbQhHjcoYFc8PDv5x3qgIe/1btVBZ079svisy23aVXO56WSXx1RB29A7AiiMRFv51sH/fFCyiOfjtA/GvzYv0N/JvyZ20slKQWxnZ5psARnlF474zwusF7sIUbTqGP26gbHri23iDVQOH3/AbmJyNZKd2PyNBvFHL+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCtlTqKH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dzpich9C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766980438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
	b=HCtlTqKHCWpuLpTEmpjiR7Sq7HBpV063dko44Alv2Xt6LT9kOovD7L7yU1qGUbsHJNuXH4
	N5VhrXivjxS9mco4QetyNkvbrnRRFIU5UWxx7pgrBaDgURUBskMCjEnDMitTkipPe9snun
	Tq45oBVZ4j+0xFY3MA7mkGzHNYSQ/h0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-xrqRUQeIO_icQqPLO6S7vw-1; Sun, 28 Dec 2025 22:53:56 -0500
X-MC-Unique: xrqRUQeIO_icQqPLO6S7vw-1
X-Mimecast-MFC-AGG-ID: xrqRUQeIO_icQqPLO6S7vw_1766980436
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9d73d57328so9065388a12.1
        for <cgroups@vger.kernel.org>; Sun, 28 Dec 2025 19:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766980436; x=1767585236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=Dzpich9CW7mmDdLzp4v+RbuYrzNb9L/kJAoqrMIipAFj0bqK4f4EMQLGLpKwgybxl4
         +8CWXYsyw+LYdUsFVOJ7toXF4cY4rg+wtHCNwFpO5ZJ3yAuqxF/67uUy+L+SMIInpD0w
         fGT7Jo26uUohYMu4FcEs8hUqq/Yn7pyLXO1wnR3/Om/Wzu48G43+sd/+zUwy1/ML1Fh3
         11FU0zdHXpOA3aBDqanPnjidnaATwr//Oz4k2ar75SY4bObtl96qUeQ4MjMZdwf2Im2q
         PYnoRrL3golc9Otb6H4dT6oN2DMAOQwdfZfvTTdCeEi93i0ZZVW4LjPGcGXMKrAlDIkR
         VrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766980436; x=1767585236;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CS1U9kbXClTn3ClPyOJkBE6Q0JxlFOFOmyrM4XYp2Bs=;
        b=srBggNv/fAcEfmVDktTnO/56fvFxHJDeeBeMx309VJazq4yjM8Tqf0OwS7Plswxf+X
         +IRO8nxxUYZKvXGnFSp2e4WCYUOoCzodtfgoeysrehlylF2jwhdT9NWYp32fQ+V8bznV
         tuC8hCYxMfx4v8QSAIacF9A1zxIOkXj8wV4h3Fr+txpzY5URoAj4+vwlsY4rXgAaemmz
         GdO913goF+DMRzDBGrtcCqrdjg6LtQCM0yCSz5ZKD2okHErI35CADG9KPF7H1QA+NDOZ
         6SOwlOVkQ3HHL9fab+MOPYrbs1a72P67UQ7EeyNSzdPWEtgdNRZAeI+LML5QQevR37ce
         f3gg==
X-Forwarded-Encrypted: i=1; AJvYcCWQhvn7wXkCVfcu/1Q65M/z9/QXZLkmcbLBHUvdXawvuHOHeujSs1ERGrLMDIs7EnHi7Q0LAtBw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7+WZt/2wPy6p98ZXO+HhF+lrpvU9T0Cqz1SnuyxsLITrLa3Pa
	22xs1BsbTJ1AJU5CNu5bh51BW3vHbCvhpYHXpaipcWe6Rj0r4M0rJlFhemnjDmM8E7tJyR94Pin
	68QvHJB7hRvNiTLE8ht3lTTpk67jEC8nMnFb6cEDTw5kAZlfbaOD7OodIoxI=
X-Gm-Gg: AY/fxX7AvILs6EQ9iqgxNWNyThwt/Y4AZHgV2AtBVnLretD005wg8DvlM2tMDHh5X3b
	QLtmtGYO8Q2KlE0SaBYDHk5OIalP8faO3kvSIiCKOoH3t2FHQp0I69+rtsc2ityoUUr41Xb3OEZ
	AJWZg19/2ZfyCmw6BjxH12FAEjjP4Uw0QZ2UgX5komn8X7tGPeToJ9CyiWRidheg6hb+EAk0BT3
	6orFtcBje3078jvloFxMUtIob7WNVASmXBp7//LZhWHjkpB7O40+ycTgfNTV1z/PbAIclJYqW02
	9z4FfT1dADRnFGMYr5ktNpo83siYR6FU+6kE1TqFwKOXS80uZLgB1hVg+ZmDxXEYJFsxFC+twt5
	eUEE6IO31zsCy+TIv8VpJgaP8su43XqUwzqF/pVDEJuZbcKUeZrIbudl+
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193638eec.10.1766980435160;
        Sun, 28 Dec 2025 19:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwUgAvkgKwyfAg/XY7OmY8/35HtixZhtufU5RpA+DoSNpJWPgIxTe0gLEz02J7RhXsL5qbsA==
X-Received: by 2002:a05:7301:508a:b0:2af:7429:e53d with SMTP id 5a478bee46e88-2b05ebf88e5mr14193600eec.10.1766980434676;
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b05ff8634csm69342683eec.3.2025.12.28.19.53.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 19:53:54 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <81f201cc-395a-48d7-a1b0-db8c62b93c9e@redhat.com>
Date: Sun, 28 Dec 2025 22:53:41 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/33] PCI: Prepare to protect against concurrent isolated
 cpuset change
To: Zhang Qiao <zhangqiao22@huawei.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Chen Ridong <chenridong@huawei.com>, Danilo Krummrich <dakr@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251224134520.33231-1-frederic@kernel.org>
 <20251224134520.33231-2-frederic@kernel.org>
 <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Language: en-US
In-Reply-To: <e01189e1-d8ef-2791-632c-90d4d897859b@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/28/25 10:23 PM, Zhang Qiao wrote:
> Hi, Weisbecker，
>
> 在 2025/12/24 21:44, Frederic Weisbecker 写道:
>> HK_TYPE_DOMAIN will soon integrate cpuset isolated partitions and
>> therefore be made modifiable at runtime. Synchronize against the cpumask
>> update using RCU.
>>
>> The RCU locked section includes both the housekeeping CPU target
>> election for the PCI probe work and the work enqueue.
>>
>> This way the housekeeping update side will simply need to flush the
>> pending related works after updating the housekeeping mask in order to
>> make sure that no PCI work ever executes on an isolated CPU. This part
>> will be handled in a subsequent patch.
>>
>> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>> ---
>>   drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++++--------
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>> index 7c2d9d596258..786d6ce40999 100644
>> --- a/drivers/pci/pci-driver.c
>> +++ b/drivers/pci/pci-driver.c
>> @@ -302,9 +302,8 @@ struct drv_dev_and_id {
>>   	const struct pci_device_id *id;
>>   };
>>   
>> -static long local_pci_probe(void *_ddi)
>> +static int local_pci_probe(struct drv_dev_and_id *ddi)
>>   {
>> -	struct drv_dev_and_id *ddi = _ddi;
>>   	struct pci_dev *pci_dev = ddi->dev;
>>   	struct pci_driver *pci_drv = ddi->drv;
>>   	struct device *dev = &pci_dev->dev;
>> @@ -338,6 +337,19 @@ static long local_pci_probe(void *_ddi)
>>   	return 0;
>>   }
>>   
>> +struct pci_probe_arg {
>> +	struct drv_dev_and_id *ddi;
>> +	struct work_struct work;
>> +	int ret;
>> +};
>> +
>> +static void local_pci_probe_callback(struct work_struct *work)
>> +{
>> +	struct pci_probe_arg *arg = container_of(work, struct pci_probe_arg, work);
>> +
>> +	arg->ret = local_pci_probe(arg->ddi);
>> +}
>> +
>>   static bool pci_physfn_is_probed(struct pci_dev *dev)
>>   {
>>   #ifdef CONFIG_PCI_IOV
>> @@ -362,34 +374,51 @@ static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
>>   	dev->is_probed = 1;
>>   
>>   	cpu_hotplug_disable();
>> -
>>   	/*
>>   	 * Prevent nesting work_on_cpu() for the case where a Virtual Function
>>   	 * device is probed from work_on_cpu() of the Physical device.
>>   	 */
>>   	if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
>>   	    pci_physfn_is_probed(dev)) {
>> -		cpu = nr_cpu_ids;
>> +		error = local_pci_probe(&ddi);
>>   	} else {
>>   		cpumask_var_t wq_domain_mask;
>> +		struct pci_probe_arg arg = { .ddi = &ddi };
>> +
>> +		INIT_WORK_ONSTACK(&arg.work, local_pci_probe_callback);
>>   
>>   		if (!zalloc_cpumask_var(&wq_domain_mask, GFP_KERNEL)) {
>>   			error = -ENOMEM;
> If we return from here, arg.work will not be destroyed.
>
>
Right. INIT_WORK_ONSTACK() should be called after successful 
cpumask_var_t allocation.

Cheers,
Longman

>>   			goto out;
>>   		}
>> +
>> +		/*
>> +		 * The target election and the enqueue of the work must be within
>> +		 * the same RCU read side section so that when the workqueue pool
>> +		 * is flushed after a housekeeping cpumask update, further readers
>> +		 * are guaranteed to queue the probing work to the appropriate
>> +		 * targets.
>> +		 */
>> +		rcu_read_lock();
>>   		cpumask_and(wq_domain_mask,
>>   			    housekeeping_cpumask(HK_TYPE_WQ),
>>   			    housekeeping_cpumask(HK_TYPE_DOMAIN));
>>   
>>   		cpu = cpumask_any_and(cpumask_of_node(node),
>>   				      wq_domain_mask);
>> +		if (cpu < nr_cpu_ids) {
>> +			schedule_work_on(cpu, &arg.work);
>> +			rcu_read_unlock();
>> +			flush_work(&arg.work);
>> +			error = arg.ret;
>> +		} else {
>> +			rcu_read_unlock();
>> +			error = local_pci_probe(&ddi);
>> +		}
>> +
>>   		free_cpumask_var(wq_domain_mask);
>> +		destroy_work_on_stack(&arg.work);
>>   	}
>> -
>> -	if (cpu < nr_cpu_ids)
>> -		error = work_on_cpu(cpu, local_pci_probe, &ddi);
>> -	else
>> -		error = local_pci_probe(&ddi);
>>   out:
>>   	dev->is_probed = 0;
>>   	cpu_hotplug_enable();
>>


