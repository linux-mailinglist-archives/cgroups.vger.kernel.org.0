Return-Path: <cgroups+bounces-17754-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OZ/GNMGeVWo2rAAAu9opvQ
	(envelope-from <cgroups+bounces-17754-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 04:28:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E087505CC
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 04:28:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=UAvlqFgG;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17754-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17754-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9E533009992
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3CE3803CF;
	Tue, 14 Jul 2026 02:28:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773737F73A
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 02:28:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783996095; cv=none; b=OgxmrGLZqFsaC7BOkuH1zJ298FVjYZaan4EOdWZRL08qCjRYkXgtWVAD3q8ADMMFdtuQCNpt2xuz49927KqatunVpjjlVWeriSF2R0TagklgvDTTbo40Gmr5Vyu3uxC4t/ewC6sleieIyUxuJ7U+9QWXMqHsUbyzTMEnFUEWq+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783996095; c=relaxed/simple;
	bh=DPob54I1nbTw2wNBi+c15m+C3BjzsQ+0vrOEP0bfYTU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=btKrW83wFPij/JBi2o+H8IvLa7+UfveFOQVAXYCMoQfdgdTEK4m5T6ymTjFfAEWT0nUsxVueNMOJHwkLI6Sj/lCn0eiCfEYmaCJd1wtEiTR8asotLlYZ2jPXk4BMCJ2ehbkFCKYi1/Po9eeidAYE5iswuc1fBXHVktf6ZgOeHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UAvlqFgG; arc=none smtp.client-ip=91.218.175.188
Message-ID: <2fc297ce-7259-4410-9d86-ccc32485622f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783996091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pV3N8ci8r9hi8imLNZSBGOdl04OdEpOXZ6SSHiqXk5A=;
	b=UAvlqFgG5sK6uHIpqOjMOSfEyjTOZBOfU4QTZytAffqSoboIdx5RvOIGplJnE+wfOm95+7
	BbWTnmRJq1+JHKmZBx3JMX4XMx/BVPmeuKg0+fWOSFBZDn4i5t6CUYSli0i2kgBw+968JY
	UaHvObFa/8QryPmpRJsqX2chq35H+eE=
Date: Tue, 14 Jul 2026 10:28:01 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, linux-rdma@vger.kernel.org, cgroups@vger.kernel.org,
 netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-kselftest@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org,
 parav@nvidia.com, mbloch@nvidia.com, cmeiohas@nvidia.com,
 roman.gushchin@linux.dev, bvanassche@acm.org, zyjzyj2000@gmail.com,
 shuah@kernel.org, tj@kernel.org, hannes@cmpxchg.org,
 alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
 wenjia@linux.ibm.com
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
To: Jiri Pirko <jiri@resnulli.us>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
 <ak-Z071LrWhnI5lK@localhost.localdomain> <alSxB0wziQnNuyfn@FV6GYCPJ69>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <alSxB0wziQnNuyfn@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17754-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,acm.org,gmail.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:jiri@resnulli.us,m:mkoutny@suse.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,resnulli.us:email,suse.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60E087505CC



在 2026/7/13 17:34, Jiri Pirko 写道:
> Thu, Jul 09, 2026 at 03:04:23PM +0200, mkoutny@suse.com wrote:
>> Hi.
>>
>> On Thu, Jul 09, 2026 at 11:55:27AM +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>>> index 993446ab66d0..4523c1884d67 100644
>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>> @@ -2752,6 +2752,13 @@ RDMA
>>>  The "rdma" controller regulates the distribution and accounting of
>>>  RDMA resources.
>>>  
>>> +When RDMA devices are isolated per network namespace (exclusive mode),
>>> +device names are unique only within a network namespace. The device lines
>>> +below are therefore scoped to the reading or writing process's network
>>> +namespace: only devices accessible from that namespace are listed, and a
>>> +limit is applied to the device of that name in that namespace. Configure
>>> +limits from the same network namespace as the workloads.
>>
>> OK.
>>
>>> --- a/include/linux/cgroup_rdma.h
>>> +++ b/include/linux/cgroup_rdma.h
>>> @@ -7,6 +7,7 @@
>>>  #define _CGROUP_RDMA_H
>>>  
>>>  #include <linux/cgroup.h>
>>> +#include <net/net_namespace.h>
>>>  
>>>  enum rdmacg_resource_type {
>>>  	RDMACG_RESOURCE_HCA_HANDLE,
>>> @@ -34,6 +35,15 @@ struct rdmacg_device {
>>>  	struct list_head	dev_node;
>>>  	struct list_head	rpools;
>>>  	char			*name;
>>> +	/*
>>> +	 * Net namespace the device belongs to. @netns_shared mirrors
>>> +	 * ib_devices_shared_netns: when true the device is visible from every
>>> +	 * net namespace (shared mode); otherwise @net is the only namespace
>>> +	 * that may see and configure it. @netns_shared is updated when the
>>> +	 * sharing mode changes, so use {READ,WRITE}_ONCE() to access it.
>>> +	 */
>>> +	possible_net_t		net;
>>> +	bool			netns_shared;
>>
>> Any reason to store the netns_shared split per device? (IIUC, it's a
>> global parameter.)
> 
> No reason, changed.
> 
Hi Jiri,

A question on the v2 you mentioned to Michal.

Once netns_shared stops being cached per rdmacg_device,
rdmacg_device_visible() in kernel/cgroup/rdma.c still needs the current
sharing mode, whose authoritative value lives in the IB core
(ib_devices_shared_netns). How do you plan to expose it there without
the generic cgroup controller reaching back into drivers/infiniband/?
Exporting the global, or keeping an IB-side update hook, both feel a bit
awkward; it would be good to see which direction you took.

On the mechanism itself: it's the right call that rdmacg_try_charge()
stays out of the scoping. Charging takes the rdmacg_device pointer
directly (no name lookup), and a task can only charge a device it
already holds a handle to, so applying visibility there would be wrong.
The scoping deliberately touches only the name-based lookup (the write
path) and the enumeration (read/show) paths -- worth keeping that
invariant in mind so a later patch doesn't grow the filter.

Thanks,
Tao> Thanks!
> 
>>
>> Thanks,
>> Michal
> 
> 
> 


