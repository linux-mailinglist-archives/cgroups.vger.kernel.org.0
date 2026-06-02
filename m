Return-Path: <cgroups+bounces-16555-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOFuGSyTHmqdlAkAu9opvQ
	(envelope-from <cgroups+bounces-16555-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:24:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D92BE62A796
	for <lists+cgroups@lfdr.de>; Tue, 02 Jun 2026 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9B443031CA3
	for <lists+cgroups@lfdr.de>; Tue,  2 Jun 2026 08:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC70A388879;
	Tue,  2 Jun 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hpz+v1DU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368FD38737A
	for <cgroups@vger.kernel.org>; Tue,  2 Jun 2026 08:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780388389; cv=none; b=dcFrHQ7smHdunxQ4fZ15z4ZrsrZIM/oQrwRDXv1V0Scnl4wYiOw/2V29OStB3P4YTUhKNy1vPSOKGraBgyVZ8/v1+WwKqkpWKneAUqFQcw9IHumBjUikNPwpGhOZayDtgTWG5r1zQBmIiohesyfQRrC0uC++KZJXnGTty0Nac2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780388389; c=relaxed/simple;
	bh=d4uyziz9BCE8n1/QwSyz4DMAfmTUBkyZhaAzDsbbxhg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rE8tM/4icWTKemx8mqprqn/Cudvyhd3M4LR5zIRNXq0c5PpVSDAo+WFriGecBV8lSCesKgG4um5lX1SFhCbs0muekhqt7lZxmfeHS1v1EIeSrUTewOa4I8PiPS+8Sg7HpegnkJLQ85+jTXYMVc+Secq7s+UPmFDkCXoFz8YYVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hpz+v1DU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4ce16a92-9b23-400d-bb32-b79a10807412@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780388376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NjDmMYOSfD3R0tgoLgQADu8SWNpyCv43yiDku36kijg=;
	b=hpz+v1DUS7cGfQV6UbWNPeAH/+RFW/D95prOy74xTkTHVNc1MPUEy0B2VbZ4JZ56Xq2/Md
	LjxthbGhs7myjVsXGU1F/hKA8kVhjaa7/7uP2Fm71J0plLL8cD282MxiaKHSPwBi9nMj3B
	Dnny0zBNQGx0hMpca+gtjvS1FHH5gfo=
Date: Tue, 2 Jun 2026 16:19:21 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Cc: cui.tao@linux.dev, longman@redhat.com, chenridong@huaweicloud.com,
 tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] cgroup/cpuset: Fix update_prstate() always returning 0
 on partition errors
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20260602045521.2381230-1-cui.tao@linux.dev>
 <ah6JpNvdO7vaBmjS@localhost.localdomain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <ah6JpNvdO7vaBmjS@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16555-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D92BE62A796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michal,

You are absolutely right. Looking at this again, this patch is total
suckage.

Returning 0 here is the correct declarative UAPI behavior. The invalid
state records intent and can recover later when resources become
available. Returning -EINVAL would only make things worse since the
state has already been mutated.

Sorry for the noise. I'll drop this patch.

--
Tao

在 2026/6/2 15:46, Michal Koutný 写道:
> Hi.
> 
> On Tue, Jun 02, 2026 at 12:55:21PM +0800, Tao Cui <cui.tao@linux.dev> wrote:
>> update_prstate() stores the error code in cs->prs_err and transitions
>> the partition to an invalid state, but always returns 0. The caller
>> cpuset_partition_write() uses "return retval ?: nbytes", so the write
>> syscall always appears to succeed from userspace even when the partition
>> became invalid.
>> Return -EINVAL when err is set so userspace can detect
>> the failure immediately.
> 
> This is quite a visible UAPI change (a write can succeed to invalidate a
> partition) and users are meant to watch for cpuset.cpus.partition state
> anyway for asynchronous changes.
> 
> I'd not change this gratuitously.
> 
> Michal
> 


