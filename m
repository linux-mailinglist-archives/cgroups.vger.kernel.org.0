Return-Path: <cgroups+bounces-14014-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KXCI3PQlmkZoQIAu9opvQ
	(envelope-from <cgroups+bounces-14014-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 09:57:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E057A15D25D
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A86BA3022F45
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE013382E2;
	Thu, 19 Feb 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoGU5tz3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5083346AD;
	Thu, 19 Feb 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491436; cv=none; b=FIFuBcQSN5DxOYhLLtLZFIZK5/Q2zZQtFNnEE66iGz8bAzaJNe7FC1U2PGRnFm/OTEvQMshUtjOGiTs1tdDhP0zsd/4lkKKQ49eKJUhSodDgTNlhdy58zlTsmBPvQfVd0M/uyi7Qr4j+f4m/61c8Q48tV7rugLeuyf/Jn96jHH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491436; c=relaxed/simple;
	bh=JnTVAYhQ/P4N0pSZd4qr1+jbOHBcQ58Dr2VlbwxwgQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cc3j8kjuB8V5gemnOoSU0xmjy/ODXzn6puXbMuvNQWtYABQHdPvX0SI/SZoTKZBS8wKzLJbcIx7Oplv7VhwHmSIuGPHV6iX5y+gC2IL/k0OXlCgnQ/qfT88+M9C41OFG6fa6lRjFU6u0tj5ZC52mYaM5bV6q/YgmN5bLwWaaTyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoGU5tz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA993C4CEF7;
	Thu, 19 Feb 2026 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771491436;
	bh=JnTVAYhQ/P4N0pSZd4qr1+jbOHBcQ58Dr2VlbwxwgQU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uoGU5tz3M9il+NVBLUl1f8VpETmSHceacznaIvb6Co35cHpP+qVovru3BS4N4tt4Z
	 60Eik2Tsmm1P1zsWHUuNeObk6FPcN/SLdbc3MHNF02e028MNZV2hZE1UnPjUVkW6Fy
	 vlyHmi3UD3ViLam90YEjAeI03XMR7T9YK60zMYVCBmQfbyBGGeEkF5WhdO6rdqnAyc
	 O5a1lHVYRj8HcTu193k6TIOfRrifReZPXtaEI/WZUtPBdn/V17e4z0uFzyvRwhD/B2
	 UjlsfydHdoC/g5cnDlwBHVQ0ITUF2u/irftL369I7mvmxjFmFFizHYeHA4PnotRRiz
	 sAEK5Dx+XY7Dw==
Message-ID: <c038af7f-bea1-4270-b423-41fa5939246a@kernel.org>
Date: Thu, 19 Feb 2026 09:57:07 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: move pgscan, pgsteal, pgrefill to node stats
To: "JP Kobryn (Meta)" <jp.kobryn@linux.dev>, linux-mm@kvack.org,
 mst@redhat.com, mhocko@suse.com, vbabka@suse.cz
Cc: apopple@nvidia.com, akpm@linux-foundation.org, axelrasmussen@google.com,
 byungchul@sk.com, cgroups@vger.kernel.org, david@kernel.org,
 eperezma@redhat.com, gourry@gourry.net, jasowang@redhat.com,
 hannes@cmpxchg.org, joshua.hahnjy@gmail.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com,
 matthew.brost@intel.com, rppt@kernel.org, muchun.song@linux.dev,
 zhengqi.arch@bytedance.com, rakie.kim@sk.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, surenb@google.com, virtualization@lists.linux.dev,
 weixugc@google.com, xuanzhuo@linux.alibaba.com,
 ying.huang@linux.alibaba.com, yuanchu@google.com, ziy@nvidia.com,
 kernel-team@meta.com
References: <20260218222652.108411-1-jp.kobryn@linux.dev>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <20260218222652.108411-1-jp.kobryn@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14014-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,google.com,sk.com,vger.kernel.org,kernel.org,redhat.com,gourry.net,cmpxchg.org,gmail.com,oracle.com,intel.com,linux.dev,bytedance.com,lists.linux.dev,linux.alibaba.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email,linux.dev:email]
X-Rspamd-Queue-Id: E057A15D25D
X-Rspamd-Action: no action

On 2/18/26 23:26, JP Kobryn (Meta) wrote:
> From: JP Kobryn <jp.kobryn@linux.dev>
> 
> There are situations where reclaim kicks in on a system with free memory.
> One possible cause is a NUMA imbalance scenario where one or more nodes are
> under pressure. It would help if we could easily identify such nodes.
> 
> Move the pgscan, pgsteal, and pgrefill counters from vm_event_item to
> node_stat_item to provide per-node reclaim visibility. With these counters
> as node stats, the values are now displayed in the per-node section of
> /proc/zoneinfo, which allows for quick identification of the affected
> nodes.
> 
> /proc/vmstat continues to report the same counters, aggregated across all
> nodes. But the ordering of these items within the readout changes as they
> move from the vm events section to the node stats section.
> 
> Memcg accounting of these counters is preserved. The relocated counters
> remain visible in memory.stat alongside the existing aggregate pgscan and
> pgsteal counters.
> 
> However, this change affects how the global counters are accumulated.
> Previously, the global event count update was gated on !cgroup_reclaim(),
> excluding memcg-based reclaim from /proc/vmstat. Now that
> mod_lruvec_state() is being used to update the counters, the global
> counters will include all reclaim. This is consistent with how pgdemote
> counters are already tracked.
> 
> Finally, the virtio_balloon driver is updated to use
> global_node_page_state() to fetch the counters, as they are no longer
> accessible through the vm_events array.
> 
> Signed-off-by: JP Kobryn <jp.kobryn@linux.dev>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



