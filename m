Return-Path: <cgroups+bounces-16291-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MqsBHs9FWqgTwcAu9opvQ
	(envelope-from <cgroups+bounces-16291-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 08:28:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F95D129C
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 08:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23CF03024A21
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6F13BD24A;
	Tue, 26 May 2026 06:27:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF823AC0D7
	for <cgroups@vger.kernel.org>; Tue, 26 May 2026 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779776872; cv=none; b=nmrol5cumG9hZIEQLh+05lNJ5P2Q09UnehtlKoteXCWYiw2ztdhlL9Aqv56pi+ajo9V3FelfGCAuszCfrDR/falJpIANDyB9SximzBtq6DpoPoXUTKc8tpcHeP9GoWb5GyyweLwuNrBM7Epi60teX3jZCIzcdK7ns3yfzYPpxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779776872; c=relaxed/simple;
	bh=VL+hy+2ujYAVLuWc6kxX56wVYatnle/V7AJ55xzlyuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vsna5l5olpyFiTCU+6Jot5AxM/0T+UwXszrDMfhskZoTGDKmmuNiCBpluXVBcu0PNpi2V9KoZ52mIzgetAMqDGE949VX0V0k6JrsTUK6oOlcihdmZGl3QOeR5EDqjhSRHucb3HjiROP7Q0+QcV/xS+HQsFCtX2YandJHvHX2kw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 26 May 2026 15:12:48 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 26 May 2026 15:12:48 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Baoquan He <baoquan.he@linux.dev>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	kasong@tencent.com, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
	taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com,
	baver.bae@lge.com, matia.kim@lge.com
Subject: Re: [PATCH v6 1/4] mm: swap: introduce swap tier infrastructure
Message-ID: <ahU54MtOVajvVYjT@yjaykim-PowerEdge-T330>
References: <20260421055323.940344-1-youngjun.park@lge.com>
 <20260421055323.940344-2-youngjun.park@lge.com>
 <ahTD24kOr9WoluRT@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahTD24kOr9WoluRT@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [-0.86 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16291-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lge.com:email]
X-Rspamd-Queue-Id: 0D6F95D129C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 05:49:15AM +0800, Baoquan He wrote:
> On 04/21/26 at 02:53pm, Youngjun Park wrote:
> > This patch introduces the "Swap tier" concept, which serves as an
> > abstraction layer for managing swap devices based on their performance
> > characteristics (e.g., NVMe, HDD, Network swap).
> > 
> > Swap tiers are user-named groups representing priority ranges.
> > Tier names must consist of alphanumeric characters and underscores.
> > These tiers collectively cover the entire priority space from -1
> > (`DEF_SWAP_PRIO`) to `SHRT_MAX`.
> > 
> > To configure tiers, a new sysfs interface is exposed at
> > /sys/kernel/mm/swap/tiers. The input parser evaluates commands from
> > left to right and supports batch input, allowing users to add or remove
> > multiple tiers in a single write operation.
> > 
> > Tier management enforces continuous priority ranges anchored by start
> > priorities. Operations trigger range splitting or merging, but overwriting
> > start priorities is forbidden. Merging expands lower tiers upwards to
> > preserve configured start priorities, except when removing `DEF_SWAP_PRIO`,
> > which merges downwards.
> > 
> > Suggested-by: Chris Li <chrisl@kernel.org>
> > Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> 
> This looks good to me.
> 
> Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> 
> While there's only one tiny concern, please see the inline comment.
> 
> > diff --git a/mm/swap_tier.c b/mm/swap_tier.c
> > new file mode 100644
> > index 000000000000..9490e891c5fe
> > --- /dev/null
> > +++ b/mm/swap_tier.c
> > @@ -0,0 +1,302 @@
> ......
> > +/*
> > + * Naming Convention:
> > + *   swap_tiers_*() - Public/exported functions
> > + *   swap_tier_*()  - Private/internal functions
> > + */
> > +
> > +static bool swap_tier_is_active(void)
> > +{
> > +	return !list_empty(&swap_tier_active_list) ? true : false;
> 
> The above line seems like generated by AI. Whatever else I have seen is
> "return !list_empty(&swap_tier_active_list);" which is enough.

Oops, it is generated by me. My coding style.

You are right. I will remove the ternary operator.

Best regards,
Youngjun Park

