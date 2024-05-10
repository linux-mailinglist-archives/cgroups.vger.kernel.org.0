Return-Path: <cgroups+bounces-2859-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0F18C218A
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 12:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E161F21D52
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2024 10:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70569165FA3;
	Fri, 10 May 2024 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jmGLk4aT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XutS4Lgq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jmGLk4aT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XutS4Lgq"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830301635CA;
	Fri, 10 May 2024 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715335433; cv=none; b=gRqgS4Tzjkg6OyeE5/sFawKi3CE8alHWNa+PNbZ4f+zrteBMC1wE23LnWZ1aOuNRDcATkhmpbrY1xvpKu/OV0Y8QETvhDYWun60GegWUyVbJDxvxYFKuDgPk5Zz9/p2kFamkW4abLRi+TQLCO7NK1vWBQYrytDtqfbChn99Cw1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715335433; c=relaxed/simple;
	bh=fgdtPgMJvngaGk9B43OLHUDTq5XQ2ILmViQl2hnJmxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpYN8r2ivkjeW5vDZRvAFOZzIGVKUC+vZE79tHaZ6PoqTE3v4xwFx6iuQ+mp3Qu0pKPLNl40bH2EHHXPNljhixcTQyC1yG8B53HVjuYxIZSVyF3Umz1DhbP0MI5zJ4uols+HvMvZ6iLIavw8c4CmPsGsZzTz/RhSerqxRreS8wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jmGLk4aT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XutS4Lgq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jmGLk4aT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XutS4Lgq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 986EA612FA;
	Fri, 10 May 2024 10:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715335429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMpepoHPQGFvD0N3kbkFGaQjjEC2A4z9p2yUgksG/QY=;
	b=jmGLk4aTsvKTn2DTOvJl46nbSrVv5jVpUAAj5t8+j+9733x3rV7l87j8+UPCAE2wgmUqTK
	wNpKJLsGnrIt1V4FlzUKlaIA4unjZHi+4zj7sy9VkKX5DqHG0CwtcRYjmojmcwFqYWlsuH
	AGb6zwJ9b9mZevi3ZrXS9IdH0Pb4nDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715335429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMpepoHPQGFvD0N3kbkFGaQjjEC2A4z9p2yUgksG/QY=;
	b=XutS4Lgq0Rb2gINEoE/Q6JPJJjiR1KrvuhLGDQ+twpcXDPsyJ0okEK/EwOEJhG0y8bWeOw
	/ZOEYbglpWa1shCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715335429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMpepoHPQGFvD0N3kbkFGaQjjEC2A4z9p2yUgksG/QY=;
	b=jmGLk4aTsvKTn2DTOvJl46nbSrVv5jVpUAAj5t8+j+9733x3rV7l87j8+UPCAE2wgmUqTK
	wNpKJLsGnrIt1V4FlzUKlaIA4unjZHi+4zj7sy9VkKX5DqHG0CwtcRYjmojmcwFqYWlsuH
	AGb6zwJ9b9mZevi3ZrXS9IdH0Pb4nDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715335429;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zMpepoHPQGFvD0N3kbkFGaQjjEC2A4z9p2yUgksG/QY=;
	b=XutS4Lgq0Rb2gINEoE/Q6JPJJjiR1KrvuhLGDQ+twpcXDPsyJ0okEK/EwOEJhG0y8bWeOw
	/ZOEYbglpWa1shCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF3371386E;
	Fri, 10 May 2024 10:03:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fNN0OATxPWZyQQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 10 May 2024 10:03:48 +0000
Message-ID: <1d338bad-39ad-4669-bb87-35c5a242e130@suse.de>
Date: Fri, 10 May 2024 12:03:48 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme: add 'latency' iopolicy
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, John Meneghini
 <jmeneghi@redhat.com>, tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
 kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com,
 hare@kernel.org
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, aviv.coro@ibm.com
References: <20240403141756.88233-1-hare@kernel.org>
 <20240509204324.832846-3-jmeneghi@redhat.com>
 <2ac54036-6245-466f-b8fa-aaf56db72d1e@kernel.org>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <2ac54036-6245-466f-b8fa-aaf56db72d1e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.29
X-Spam-Level: 
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On 5/10/24 09:17, Damien Le Moal wrote:
> On 5/10/24 05:43, John Meneghini wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
>> latency tracker to provide latencies for each node, and schedules
>> I/O on the path with the least latency for the submitting node.
>>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>>
>> Make this compile when CONFIG_BLK_NODE_LATENCY is not set.
>> Advertise the 'latency' iopolicy in modinfo.
>>
>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>> ---
>>   drivers/nvme/host/multipath.c | 63 ++++++++++++++++++++++++++++++-----
>>   drivers/nvme/host/nvme.h      |  1 +
>>   2 files changed, 55 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>> index d916a5ddf5d4..e9330bb1990b 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
>>   	[NVME_IOPOLICY_NUMA]	= "numa",
>>   	[NVME_IOPOLICY_RR]	= "round-robin",
>>   	[NVME_IOPOLICY_QD]      = "queue-depth",
>> +	[NVME_IOPOLICY_LAT]	= "latency",
>>   };
>>   
>>   static int iopolicy = NVME_IOPOLICY_NUMA;
>> @@ -32,6 +33,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>>   		iopolicy = NVME_IOPOLICY_RR;
>>   	else if (!strncmp(val, "queue-depth", 11))
>>   		iopolicy = NVME_IOPOLICY_QD;
>> +#ifdef CONFIG_BLK_NODE_LATENCY
>> +	else if (!strncmp(val, "latency", 7))
>> +		iopolicy = NVME_IOPOLICY_LAT;
>> +#endif
>>   	else
>>   		return -EINVAL;
>>   
>> @@ -43,10 +48,36 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>>   	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
>>   }
>>   
>> +static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
>> +{
>> +	struct nvme_ns_head *h;
>> +	struct nvme_ns *ns;
>> +	bool enable = iopolicy == NVME_IOPOLICY_LAT;
>> +	int ret = 0;
>> +
>> +	mutex_lock(&subsys->lock);
>> +	list_for_each_entry(h, &subsys->nsheads, entry) {
>> +		list_for_each_entry_rcu(ns, &h->list, siblings) {
>> +			if (enable) {
>> +				ret = blk_nlat_enable(ns->disk);
>> +				if (ret)
>> +					break;
>> +			} else
>> +				blk_nlat_disable(ns->disk);
> 
> Missing curly brackets for the else.
> 
Ok.

>> +		}
>> +	}
>> +	mutex_unlock(&subsys->lock);
>> +	return ret;
>> +}
>> +
>>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>>   	&iopolicy, 0644);
>>   MODULE_PARM_DESC(iopolicy,
>> +#if defined(CONFIG_BLK_NODE_LATENCY)
> 
> What is so special about the latency policy that it needs to be conditionally
> defined ? I missed that point. Why not drop CONFIG_BLK_NODE_LATENCY ?
> 
The 'latency' policy is using the blk-rqos infrastructure, which in 
itself might not be compiled in.
So we don't want the user to give a false impression here.

>> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin', 'queue-depth' or 'latency'");
>> +#else
>>   	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>> +#endif
>>   
>>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>>   {
>> @@ -250,14 +281,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>>   {
>>   	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
>>   	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>> +	int iopolicy = READ_ONCE(head->subsys->iopolicy);
>>   
>>   	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (nvme_path_is_disabled(ns))
>>   			continue;
>>   
>> -		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
>> -		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>> +		if (iopolicy == NVME_IOPOLICY_NUMA)
>>   			distance = node_distance(node, ns->ctrl->numa_node);
>> +		else if (iopolicy == NVME_IOPOLICY_LAT)
>> +			distance = blk_nlat_latency(ns->disk, node);
>>   		else
>>   			distance = LOCAL_DISTANCE;
>>   
>> @@ -381,8 +414,8 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>>   
>>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>   {
>> -	int iopolicy = READ_ONCE(head->subsys->iopolicy);
>>   	int node;
>> +	int iopolicy = READ_ONCE(head->subsys->iopolicy);
> 
> No need to move this line.
> 
Sure.

>>   	struct nvme_ns *ns;
>>   
>>   	/*
>> @@ -401,8 +434,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>>   
>>   	if (iopolicy == NVME_IOPOLICY_RR)
>>   		return nvme_round_robin_path(head, node, ns);
>> -
>> -	if (unlikely(!nvme_path_is_optimized(ns)))
>> +	if (iopolicy == NVME_IOPOLICY_LAT ||
>> +	    unlikely(!nvme_path_is_optimized(ns)))
>>   		return __nvme_find_path(head, node);
>>   	return ns;
>>   }
>> @@ -872,15 +905,18 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>>   {
>>   	struct nvme_subsystem *subsys =
>>   		container_of(dev, struct nvme_subsystem, dev);
>> -	int i;
>> +	int i, ret;
>>   
>>   	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>>   		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
>> -			nvme_subsys_iopolicy_update(subsys, i);
>> -			return count;
>> +			ret = nvme_activate_iopolicy(subsys, i);
>> +			if (!ret) {
>> +				nvme_subsys_iopolicy_update(subsys, i);
>> +				return count;
>> +			}
>> +			return ret;
> 
> It would be nicer to have this as:
> 
> 			if (ret)
> 				break
> 			nvme_subsys_iopolicy_update(subsys, i);
> 			return count;
> 

Ok.

>>   		}
>>   	}
>> -
> 
> whiteline change.
> 
>>   	return -EINVAL;
> 
> And "return ret;" here with ret initialized to -EINVAL when declared.
> 
Ok.

>>   }
>>   SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
>> @@ -916,6 +952,15 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>>   
>>   void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>>   {
>> +	if (!blk_nlat_init(ns->disk) &&
>> +	    READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_LAT) {
>> +		int ret = blk_nlat_enable(ns->disk);
>> +
>> +		if (unlikely(ret))
>> +			pr_warn("%s: Failed to enable latency tracking, error %d\n",
>> +				ns->disk->disk_name, ret);
>> +	}
>> +
>>   	if (nvme_ctrl_use_ana(ns->ctrl)) {
>>   		struct nvme_ana_group_desc desc = {
>>   			.grpid = anagrpid,
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index a557b4577c01..66bf003a6c48 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -411,6 +411,7 @@ enum nvme_iopolicy {
>>   	NVME_IOPOLICY_NUMA,
>>   	NVME_IOPOLICY_RR,
>>   	NVME_IOPOLICY_QD,
>> +	NVME_IOPOLICY_LAT,
>>   };
>>   
>>   struct nvme_subsystem {
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


