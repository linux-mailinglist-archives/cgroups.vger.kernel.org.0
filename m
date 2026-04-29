Return-Path: <cgroups+bounces-15549-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mG4sE51x8WmggwEAu9opvQ
	(envelope-from <cgroups+bounces-15549-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 04:49:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D3E48E6E9
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 04:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5AD83010485
	for <lists+cgroups@lfdr.de>; Wed, 29 Apr 2026 02:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D6E332EC1;
	Wed, 29 Apr 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aoBRpeHb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E5732B989
	for <cgroups@vger.kernel.org>; Wed, 29 Apr 2026 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430934; cv=none; b=P5dx3NS5aAx7i13lGGrp/vpg7nPeNRSP/vk2kJKtZUBq6hbZCoSVu1GBOsASIv+X1oqmOFhAHzY/NZu181GMdTGHsmILV5avgrXKDvjO/mkXE+4SG/K0fbVLLcisXq0/8wD5FYS+N9iH/5hht5enHTWS2S7PKY+X/bljEGi9I1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430934; c=relaxed/simple;
	bh=FbA0m6+tniHcNnQeNB4xVc6aZ5BIEKYuLrm2k0G1SCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KFln2gOTEOuS/biSajuxQhFNPOD/FWq9Y0PfJhwdZ3+/OO29sxjwnG/7+gAyBheQ7ojvyqIOQWkIftUN117iOmbkNCjb1bq5URK8gjpakUNA5tzT3RWEhXCGPPlmEG4fc+0Uw9MSJEXhNhUgRQdrdwdpLp71RlmJ30jcgzxRFqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aoBRpeHb; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea4b2fcc-25e4-42ae-9d3e-5fe7d86ed7fa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777430921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiMWZCTeAOPUrZJ5+1IQsZdUyxFEVinUAq4pUHwGoUs=;
	b=aoBRpeHboqK1C9r6RmublLyhyIrTONH3Jiry0/y/FTwvTxj5hf7xvfUTNAlqHqnsU2+cKh
	oEF5/o4rq6PRlBk42L0TBnNpeYXqcHBHAmYC/beOU1JzMYX297j77/H7GdIjSK07FuXu77
	BU1LR6tTSDRk5Np61JNZ5LTYN77/Ryw=
Date: Wed, 29 Apr 2026 10:48:34 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: memcontrol: fix rcu unbalance in
 get_non_dying_memcg_end()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, yosry@kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20260428103108.45719-1-qi.zheng@linux.dev>
 <20260428151253.bdfb08401ebb74c438df0e52@linux-foundation.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260428151253.bdfb08401ebb74c438df0e52@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E0D3E48E6E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15549-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]



On 4/29/26 6:12 AM, Andrew Morton wrote:
> On Tue, 28 Apr 2026 18:31:08 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:
> 
>> Currently, get_non_dying_memcg_start() and get_non_dying_memcg_end() both
>> evaluate cgroup_subsys_on_dfl(memory_cgrp_subsys) independently to
>> determine whether to acquire or release the RCU read lock.
> 
> Sashiko review
> (https://sashiko.dev/#/patchset/20260428103108.45719-1-qi.zheng@linux.dev)
> is correct.
> 
> mm/memcontrol.c: In function 'mod_memcg_state':
> mm/memcontrol.c:881:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
>    881 |         get_non_dying_memcg_end(rcu_locked);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/memcontrol.c:874:14: note: 'rcu_locked' was declared here
>    874 |         bool rcu_locked;
>        |              ^~~~~~~~~~
> In function 'mod_memcg_lruvec_state',
>      inlined from 'mod_lruvec_state' at mm/memcontrol.c:973:3:
> mm/memcontrol.c:952:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
>    952 |         get_non_dying_memcg_end(rcu_locked);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/memcontrol.c:944:14: note: 'rcu_locked' was declared here
>    944 |         bool rcu_locked;
>        |              ^~~~~~~~~~
> In function 'mod_memcg_state',
>      inlined from 'mem_cgroup_sk_uncharge' at mm/memcontrol.c:5392:2:
> mm/memcontrol.c:881:9: error: 'rcu_locked' is used uninitialized [-Werror=uninitialized]
>    881 |         get_non_dying_memcg_end(rcu_locked);
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/memcontrol.c:874:14: note: 'rcu_locked' was declared here
>    874 |         bool rcu_locked;
>        |              ^~~~~~~~~~

In v1, I explicitly set rcu_locked in get_non_dying_memcg_start() to
avoid the uninitialized warning. However, I noticed that even if I drop
it, the warning doesn't actually trigger -- probably due to some GCC
optimiztions.

Anyway, let's explicitly initialize rcu_locked in both
mod_memcg_state() and mod_memcg_lruvec_state(). Will do it in v3.

Thanks!



