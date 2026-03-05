Return-Path: <cgroups+bounces-14622-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJgSK+HvqGkwzAAAu9opvQ
	(envelope-from <cgroups+bounces-14622-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 03:52:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6020A55A
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 03:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08CA83049948
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 02:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B75826A1AF;
	Thu,  5 Mar 2026 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBCRf6Ry"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036342AD03;
	Thu,  5 Mar 2026 02:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772679089; cv=none; b=s9B7wggsoiNNxutKDD/B2vfWy+oxAsFHcUWi2Gr5DXhWh1p+ZkyX6YN7L54dqzPhHtw+l07tXPpagrzwQUDaS35ONAtj/K2KJC9UTgbDfkCEIUbOxqVxyegm/1l/pNVvLCF1QurLdp4kql6QT+w740cN2TscI+pBUh+cefCgVNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772679089; c=relaxed/simple;
	bh=1SKb4ML0Kq4w3JWpdhfAOI7xmSOWVka7/Q3K6nP0k7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwOMGARBaYsyNJfUfc39efXLIIC9R7jpdEdgsVHRz/9dcv9dYJMaG2rZISLypnmUg3fecGbxC6j+9FvIfSO3XqYD82Iw7CsXzb4bayEnjsGI00Vqy1Q7Nvnur09no269IrMKsvakMEP5eToRUquQMRTnKZ9ToUwcD/HjonxBDaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBCRf6Ry; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e44845ad-47c1-4b9b-a553-2c3054bf05e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772679085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ce9EqtabjAdAeKefFLUq0trgFug3kHXTicrfkTTmTdo=;
	b=LBCRf6RyiS8eBOAANfyDQJkIyNmgHJRCV5zdDo2BMV2WQs2MdxHm9tbG3KWUom8e2GEct/
	zCqAXSVJhZ1fKkCDrlsPfUQNnPzy0W0kJ0yRPtPF4Yfcwge4RlkOhCb1aXHFE7bBsgkKOC
	agVRYflly/5+l2og3VSmMtmlKDYl1w4=
Date: Thu, 5 Mar 2026 10:51:00 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry@kernel.org>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
 <20260228072556.31793-1-qi.zheng@linux.dev>
 <CAO9r8zNYFvNnz_oTu10kPBYL6=1ZewKUMRYcMmcMdSqbro_miA@mail.gmail.com>
 <de1476aa-20a3-420e-9cd7-9238efd3c85f@linux.dev>
 <46bgg2vwqvmex7wtk2fkvf454tqgaychb7l4odnnrx7svci5ha@vy4b4ophm763>
 <22cca07c-49e0-42e8-b937-7b1c7c51e78d@linux.dev>
 <20260304140656.10c524970519de373accca0b@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260304140656.10c524970519de373accca0b@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 35A6020A55A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14622-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,google.com,suse.com,linux.dev,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Action: no action



On 3/5/26 6:06 AM, Andrew Morton wrote:
> On Wed, 4 Mar 2026 15:56:42 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -6044,8 +6044,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn,
>> const char *name, umode_t mode)
>>     */
>>    static void css_killed_work_fn(struct work_struct *work)
>>    {
>> -       struct cgroup_subsys_state *css =
>> -               container_of(work, struct cgroup_subsys_state,
>> destroy_work);
> 
> Lots of wordwrapping in this patch.

Oh, I will check this more carefully in v6.

Thanks,
Qi



