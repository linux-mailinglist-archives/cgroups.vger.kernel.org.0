Return-Path: <cgroups+bounces-14408-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGbIKGuzn2kpdQQAu9opvQ
	(envelope-from <cgroups+bounces-14408-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:43:55 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 073161A02FD
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38A06307F221
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 02:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94560378D68;
	Thu, 26 Feb 2026 02:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QI0TE1dJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D217A2EA
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073620; cv=none; b=TIo3rYjzXg0UJMxYE8d4HNvywxJK4QbTOZ22SmJwhFhOCQE+D3g8JjCYQmbk0RzHIHB7NerjLkfLHY3HEl0Ecd4IWl/c+0ZDPZt6OVXtUBf6edtE5So+Tx1uSgWh5VtTQA9wU8Yy0xojG/i98JbRr1usen4PEFsb0xNacFKRbCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073620; c=relaxed/simple;
	bh=kRpE73dKflKGmiEgIaorNWmUEBz/yJiW+66DsA9Pbag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbqCnbeBnolI5ZXP5AmfW3+la21eHQPUvzUkbGK6A6tW25NITZhdSiuF7k5watKV6kiqE31nk1QFOwNSNSiVcmBmF4XvdJrZBlRCN5Siu1RtGm5xh8S4kO2UW/Dm8d5zGaPBlk+59ItitB04J+J35PI6Lf+aUzPACAa26G183k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QI0TE1dJ; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 25 Feb 2026 18:40:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772073616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rB/Yufk4Q59hquQidpF2pzxYz6y4Be21NRg66TSUZCc=;
	b=QI0TE1dJoXpxiwq1XSFant4T8pZYqEYop53rdpYR8nNzwyzDrCPmtUcpYN78Syex43PlXA
	+2oebGbF8N3FxEHRRGG66B7Gfjdp3Rt3J0XJQD3A8JflGla3e6J1r2geNn0XvO43ZIDCat
	0AvxBYHL/+m65guD0Aa572jFfDjO4Eg=
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
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v5 31/32] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <aZ-yctMtmVYVawK-@linux.dev>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
 <ff5a945386f168faa877901d569296592cdaadc3.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5a945386f168faa877901d569296592cdaadc3.1772005110.git.zhengqi.arch@bytedance.com>
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
	TAGGED_FROM(0.00)[bounces-14408-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[29];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email,bytedance.com:email]
X-Rspamd-Queue-Id: 073161A02FD
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:53:14PM +0800, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Now that everything is set up, switch folio->memcg_data pointers to
> objcgs, update the accessors, and execute reparenting on cgroup death.
> 
> Finally, folio->memcg_data of LRU folios and kmem folios will always
> point to an object cgroup pointer. The folio->memcg_data of slab
> folios will point to an vector of object cgroups.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

