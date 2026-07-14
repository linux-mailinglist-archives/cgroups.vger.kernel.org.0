Return-Path: <cgroups+bounces-17759-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ibg5JtjoVWohvgAAu9opvQ
	(envelope-from <cgroups+bounces-17759-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 09:44:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B9752078
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 09:44:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=resnulli-us.20251104.gappssmtp.com header.s=20251104 header.b=MXGbOTxb;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17759-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17759-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12D27305099A
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 07:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E433F0A87;
	Tue, 14 Jul 2026 07:40:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20433EEAD2
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 07:39:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014803; cv=none; b=I4551WxpPhkOvJA1K84fEcx5hCfH9NqCVdC4D6ipu7I733hnYY8zbzbgHoIUtn1gBY251dvf43FNdxan5FESvQl4bQhwq24BFFtx0MQI58Ya0GaxV1Hd6MWmAoKImmf59Pn6SwNiRJKBfgkYWTR8Ij//vLwU/o6443Z982XLFgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014803; c=relaxed/simple;
	bh=Ii4QglIlNfk2AF9Ta5Xci6IGgX7bNyNYfS9+14rJzNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzMRmTdAWT8eJaalzdkTwFAvSnDDLwtzByQmj9/Y+p9G4lMqvmBvU+/P5DSVqkjGvx2Q5QIZaRrH0iNtSkIHBdzIzrDeMltSpT/+ren8vnLKhyVSu15UaDyTEwULW4JL1/g4+F+qVH53+mpCGBf5Vh0lD319WGweAFRiQU1c9SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=MXGbOTxb; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493b77b150aso4641985e9.2
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 00:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1784014798; x=1784619598; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7C5iWjcphG9+X8eLvvIf+CpqUo2Z4rnWqlw/CwVzzuA=;
        b=MXGbOTxb/bWGnJSaW6/5X7OBDtdY5cRnC3WhClHMgp+BSOmlZyRVXImcF77gCuruCm
         JABkSDaLE4PVCwElIQtzeRBaqXfMR3PpBt6qPdPC5uBXSlyAuFjCMHaLLjfp0Mt7swqP
         as9OJpiGN+iybBbWENmIMOzoGxLznGHJzWF3KkEYSRddBIqZlhxs1IgNh5COjZRpafJa
         VsA3ozpE/9f7aJ7SPQkdjW7lQxqUD0sNDYZYhXNmaNxtXjaSjL+h8DSkLZ828gGWtcT0
         Rln1x8RKDBYr+cxoGWwi6+x6sb7xkooEkMGJHt+njcSi4vLJZlcWfPoK9ojLCvFIP0Zv
         lhSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014798; x=1784619598;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7C5iWjcphG9+X8eLvvIf+CpqUo2Z4rnWqlw/CwVzzuA=;
        b=EAgkz1zTOesTIo4zLWihmCvi34UmR8HQac1p494ccMzPn66EYYgPxK3E24f7oxxJNb
         tW6jCKurw1Om6Ichn6+VmaTaY2PbqZxmvC4zPKJYX7yTJGtzSZtPZSZZwerR7BhpZCl5
         uNBrtNefLF/C+M34OYoAkr84tpNDkXB9iS0gkUN/4Ng9Ojb7Ek67Hud1X5K68UV0XjuT
         qZEKEcufcIyw+mvkeOKwhcjrVqLHvKtiaO0JTsWFuEiGRb2yRrqKT9Ckd0ezyvSNM67z
         0Pk4MkvUKEAF5pD401Z98eCry3rG+egIEWWTa2gwTzDA84gwoTiW5vuF+pCTkCWc9byA
         +tOg==
X-Forwarded-Encrypted: i=1; AHgh+Rpg+CBj9lyvwGrLVu/cICUTAsTW+OiUPO3V1B8lWiHl8pSSQGHPGSK2rWjt3fnO8N7SgXbJUdpo@vger.kernel.org
X-Gm-Message-State: AOJu0YzRWL1l9Km+fPejaoIccgOwMUkQOkyxYyWvripQsRkCPlBgPnP5
	BjaTB33yQ1yeQUmHnP06rbxIEQKkyPZfidCH9jumY1RXXOGareoyuLKRKYRkHxdwj+Y=
X-Gm-Gg: AfdE7cmxc82LyCDK2dGNY86CJNWB6I9R1gVzVAAtiCiAw3ezS8P5XlaAoyMgOhd8gxf
	9t7aVLBqVuEv2lh7wdcUKlYl7LGiT+tcrhvULjl0fP4kRIX4RsWaJdUXDmzg32aoifPjb1bFADK
	oFzsCSo3FBIY/5+yNkSQijvhOEq1XgIEEPDn86M59ofsCG+LRJimgbXiHgdR+DZO20T8D042cWT
	AUkExOfiKnqDzC7Edn1nrM73HEu6PUWk3po0y/yC/O7TgAf2A5GJIn15CGUidFUd2pCVexUQtty
	wwcz7w2bLmYJz46MCflYZwoEGg4K7Gxh3xXPJ4lJZvjcF/+5hVLLBla2eAKL7oKcIM9O0qYXZeQ
	2ifAayD2aBf4zXxBruv4KmgbacDYF3GWoMFuXah3un01tl2JZ0eBYq2782NzBR9wk4XwKZ3l02B
	JfPsGZ982lhSqVAisMJamEvA==
X-Received: by 2002:a05:600c:1f87:b0:493:f870:fbf0 with SMTP id 5b1f17b1804b1-493f88b3693mr153093885e9.34.1784014797971;
        Tue, 14 Jul 2026 00:39:57 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a322bcbsm63449225e9.9.2026.07.14.00.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:39:57 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:39:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tao Cui <cui.tao@linux.dev>
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	linux-rdma@vger.kernel.org, cgroups@vger.kernel.org, netdev@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	parav@nvidia.com, mbloch@nvidia.com, cmeiohas@nvidia.com, roman.gushchin@linux.dev, 
	bvanassche@acm.org, zyjzyj2000@gmail.com, shuah@kernel.org, tj@kernel.org, 
	hannes@cmpxchg.org, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
Message-ID: <alXmwzDASDFaeVNZ@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
 <ak-Z071LrWhnI5lK@localhost.localdomain>
 <alSxB0wziQnNuyfn@FV6GYCPJ69>
 <2fc297ce-7259-4410-9d86-ccc32485622f@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fc297ce-7259-4410-9d86-ccc32485622f@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:mkoutny@suse.com,m:linux-rdma@vger.kernel.org,m:cgroups@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:parav@nvidia.com,m:mbloch@nvidia.com,m:cmeiohas@nvidia.com,m:roman.gushchin@linux.dev,m:bvanassche@acm.org,m:zyjzyj2000@gmail.com,m:shuah@kernel.org,m:tj@kernel.org,m:hannes@cmpxchg.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-17759-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,ziepe.ca,kernel.org,nvidia.com,linux.dev,acm.org,gmail.com,cmpxchg.org,linux.alibaba.com,linux.ibm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,resnulli.us:email,resnulli.us:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,FV6GYCPJ69:mid,suse.com:email,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 210B9752078

Tue, Jul 14, 2026 at 04:28:01AM +0200, cui.tao@linux.dev wrote:
>
>
>在 2026/7/13 17:34, Jiri Pirko 写道:
>> Thu, Jul 09, 2026 at 03:04:23PM +0200, mkoutny@suse.com wrote:
>>> Hi.
>>>
>>> On Thu, Jul 09, 2026 at 11:55:27AM +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>>>> index 993446ab66d0..4523c1884d67 100644
>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>> @@ -2752,6 +2752,13 @@ RDMA
>>>>  The "rdma" controller regulates the distribution and accounting of
>>>>  RDMA resources.
>>>>  
>>>> +When RDMA devices are isolated per network namespace (exclusive mode),
>>>> +device names are unique only within a network namespace. The device lines
>>>> +below are therefore scoped to the reading or writing process's network
>>>> +namespace: only devices accessible from that namespace are listed, and a
>>>> +limit is applied to the device of that name in that namespace. Configure
>>>> +limits from the same network namespace as the workloads.
>>>
>>> OK.
>>>
>>>> --- a/include/linux/cgroup_rdma.h
>>>> +++ b/include/linux/cgroup_rdma.h
>>>> @@ -7,6 +7,7 @@
>>>>  #define _CGROUP_RDMA_H
>>>>  
>>>>  #include <linux/cgroup.h>
>>>> +#include <net/net_namespace.h>
>>>>  
>>>>  enum rdmacg_resource_type {
>>>>  	RDMACG_RESOURCE_HCA_HANDLE,
>>>> @@ -34,6 +35,15 @@ struct rdmacg_device {
>>>>  	struct list_head	dev_node;
>>>>  	struct list_head	rpools;
>>>>  	char			*name;
>>>> +	/*
>>>> +	 * Net namespace the device belongs to. @netns_shared mirrors
>>>> +	 * ib_devices_shared_netns: when true the device is visible from every
>>>> +	 * net namespace (shared mode); otherwise @net is the only namespace
>>>> +	 * that may see and configure it. @netns_shared is updated when the
>>>> +	 * sharing mode changes, so use {READ,WRITE}_ONCE() to access it.
>>>> +	 */
>>>> +	possible_net_t		net;
>>>> +	bool			netns_shared;
>>>
>>> Any reason to store the netns_shared split per device? (IIUC, it's a
>>> global parameter.)
>> 
>> No reason, changed.
>> 
>Hi Jiri,
>
>A question on the v2 you mentioned to Michal.
>
>Once netns_shared stops being cached per rdmacg_device,
>rdmacg_device_visible() in kernel/cgroup/rdma.c still needs the current
>sharing mode, whose authoritative value lives in the IB core
>(ib_devices_shared_netns). How do you plan to expose it there without
>the generic cgroup controller reaching back into drivers/infiniband/?
>Exporting the global, or keeping an IB-side update hook, both feel a bit
>awkward; it would be good to see which direction you took.

Exposing this from ib side is not doable, as IB may be compiled as a
module. So what I do is I intrododuce "static bool rdmacg_netns_shared"
in cgroup/rdma.c and exported function rdmacg_set_netns_shared() to set
it from IB.


>
>On the mechanism itself: it's the right call that rdmacg_try_charge()
>stays out of the scoping. Charging takes the rdmacg_device pointer
>directly (no name lookup), and a task can only charge a device it
>already holds a handle to, so applying visibility there would be wrong.
>The scoping deliberately touches only the name-based lookup (the write
>path) and the enumeration (read/show) paths -- worth keeping that
>invariant in mind so a later patch doesn't grow the filter.
>
>Thanks,
>Tao> Thanks!
>> 
>>>
>>> Thanks,
>>> Michal
>> 
>> 
>> 
>

