Return-Path: <cgroups+bounces-14553-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBhOIOyrpmn9SgAAu9opvQ
	(envelope-from <cgroups+bounces-14553-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:37:48 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178DB1EBFAE
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 10:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68349305465F
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8758A38C2DE;
	Tue,  3 Mar 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfwWX0/a"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49436DA1D;
	Tue,  3 Mar 2026 09:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530656; cv=none; b=JX+rTzv0DRPg0q7iYL3pYB/73US2UJ2cBIdc6HO62d87AvvdnkLN7tOxm1oq28cvU7i7v+/LxZdMo2OLfMSTuQo74jFLEAKYauJg2UNhIM3L78M0GaxCO/f0V+XRe3RT4r/aJF4vTF1Ls4/NPALCKcSzKRyHJDmRGOdXsY2KGqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530656; c=relaxed/simple;
	bh=HWIX1VXWGP5HassDQ1MCakNYhPt303yxu0dwTHvL5BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HusUtcP2svnAmC9S1NWVGH9TcfLXd1eAQoGOqMiWwJ49czVmSP7jqckVXr0R8x3PR6uievE0K0xv7OFEWUczpklwSjHqSe+cTTTr91ZWA8Ta3fCiJXe13ioh59zsiHiAW6h4iXCwiVGQs6w+LJ5mF10ma+4qZrkCuxqS7z9Tk1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfwWX0/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDDFC19425;
	Tue,  3 Mar 2026 09:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772530656;
	bh=HWIX1VXWGP5HassDQ1MCakNYhPt303yxu0dwTHvL5BI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QfwWX0/abWuzpZ4Aya1NffXUEnkK9KWGoLslHJu+eBpOgpTbau/lAw3+VKWop/2UA
	 iZTS34s56/mZqD1RrvBlfhj6ZWejOKi5TNXlIsulfiiESX3mLZ45oaC3MipTgyOhDQ
	 3OsDZI/KJmGEY2iNi1GSksPHUHwUXdVMeQbTuxerajttSvcgOVu6WyM5qbg2KqbTnM
	 eOhxzTAIZG/ieJiGyqKtut308v5thEBAbWZJXY6YhN2j8VKsgFZWfniXlBbO1+q5wY
	 lUUobbSZvR6IFZbWHROwfvATggC2tL3mqV7R5rAhQMfwNXtGB3UrpTzufIqpAQWNe+
	 cYtKKePQu4XSQ==
Message-ID: <8d78db89-2f84-48c5-870a-6bb1fc1ddc88@kernel.org>
Date: Tue, 3 Mar 2026 10:37:32 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] mm: memcontrol: split out __obj_cgroup_charge()
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Vlastimil Babka <vbabka@suse.cz>,
 Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260302195305.620713-1-hannes@cmpxchg.org>
 <20260302195305.620713-4-hannes@cmpxchg.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260302195305.620713-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 178DB1EBFAE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14553-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cmpxchg.org:email]
X-Rspamd-Action: no action

On 3/2/26 20:50, Johannes Weiner wrote:
> Move the page charge and remainder calculation into its own
> function. It will make the slab stat refactor easier to follow.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


