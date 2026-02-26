Return-Path: <cgroups+bounces-14444-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJhfJc+ooGnilQQAu9opvQ
	(envelope-from <cgroups+bounces-14444-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 21:10:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4B91AEE71
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 21:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47ADD30C6C58
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 20:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BDA392C2B;
	Thu, 26 Feb 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="orHl8mid"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDC44CAC0
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 20:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772136380; cv=none; b=QC+IUDsDnSVcw5U8CmDThRvMn6FuX7snAocgzi2G+GO1D0pk88GAjsi447qKN/JYpbqlTDR3vM8THRK1H0EdPlcZ6Cj4CTVrycDdD+vNOV7/cYBlDr82hG5c+iyIRSMYAmJpGOmc6MxKipZr8895OnStlbLul8SgwACMAgz5hes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772136380; c=relaxed/simple;
	bh=3yf0LP7DbELypCjehNozND7Z6JekSj04QPOTP61YTlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtFmXZwZ9wBEHPWwG5tcAnoi+ls6NZ3px4jmXJnkfnECLLlrbQmAkL5/cv2zfOnEtFZETj7G9tjjOR6zxcIpNZIZKHoywrjjEvkrhX0SeLUvQDRsjZ66fnISdQYQ6VwBfy94L2aayklpOGTw3FHJFSC/7a8rBEWolsJVpZidqVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=orHl8mid; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Feb 2026 12:05:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772136375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rs9phl7CZvkpvyuP0IIhlSI4jujqBSi/WWAKbzIQYsk=;
	b=orHl8midT2uBXGfRsOr2njRHvvNwaJQOJxd6xzi+HlP7ns9d24jSabNuhSMVsgF/5A8eAD
	edn6NcjIBNt+DuaQK91WZ1tfqHMII5n1FfROxXnXhPSsmmZx9Ixfi1DVOI2d9mtCPRreRy
	G6h/hIlv0jKp6ctwaa3sZXskEjI+8zI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, yosry.ahmed@linux.dev, 
	imran.f.khan@oracle.com, kamalesh.babulal@oracle.com, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com, 
	akpm@linux-foundation.org, hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, 
	lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 update 30/32] mm: memcontrol: convert objcg to be
 per-memcg per-node type
Message-ID: <aaCmpSNRZU1wIYxq@linux.dev>
References: <0f915487ffc653cf6ea19335c21c01aa06004641.1772005110.git.zhengqi.arch@bytedance.com>
 <20260225094456.74145-1-qi.zheng@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225094456.74145-1-qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14444-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: EB4B91AEE71
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 05:44:56PM +0800, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Convert objcg to be per-memcg per-node type, so that when reparent LRU
> folios later, we can hold the lru lock at the node level, thus avoiding
> holding too many lru locks at once.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> changlog:
>  - fix a missing root_obj_cgroup conversion and completely delete
>    root_obj_cgroup.
> 

After this patch, do we care that page/folio/slab points to the objcg of the
same node as them for a given memcg?


