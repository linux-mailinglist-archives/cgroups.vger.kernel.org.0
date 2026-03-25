Return-Path: <cgroups+bounces-15055-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGvMHahtxGn3zAQAu9opvQ
	(envelope-from <cgroups+bounces-15055-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 00:20:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7AD32D562
	for <lists+cgroups@lfdr.de>; Thu, 26 Mar 2026 00:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AB93034E09
	for <lists+cgroups@lfdr.de>; Wed, 25 Mar 2026 23:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09C034B410;
	Wed, 25 Mar 2026 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UGPBngko"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836A530AAB8;
	Wed, 25 Mar 2026 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774480805; cv=none; b=fQ7ACLlz2pxEXpzu4YoCL8IZho7XuBM6hVss8HBMImZ4L1gcy3lmH0xl7ZWM2UeoKYLm1i6XjTmVw9aOb1lumUt6U4BH83tqPQy3P5I7udET2ZnnNDfQwqGeGa9iIot3NspkaoEIovIfKBSZvlezKBdtFnESV9NZsXrWPcSadys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774480805; c=relaxed/simple;
	bh=9s00olhICAUUbLnAIWavWFOvPO+7LJvV6aw+2t+Tz1M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gUTvDqHZX9d2dv5sfhaN73MELQFvHwyyLGsoMPtzlMj7/UX0irEreArzh1CqWbsfBQqIjx6k0UEF0KSRww+v65lveHgprBZCJp+zO4vm70KsRJqFbGK2L5/HpKhzO8KBktNjpFQd66imF9EZpFTOr+5CDeri59yif2S5SFf04Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UGPBngko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76A89C4CEF7;
	Wed, 25 Mar 2026 23:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774480805;
	bh=9s00olhICAUUbLnAIWavWFOvPO+7LJvV6aw+2t+Tz1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UGPBngkoEYosW/NnjPjNa5ydoYzla43Bwu9Hf7K8VvGyw1KnWKVVge2ZOw6+orvd8
	 nlg3rdGKT5SJCoMUYkBH+IDURtV47KARSb0umR3PAPvYwRxsDajCGQifkujroH3hvB
	 muTNsLeYiQlROjTXLUK0ODgZzNXdzIjZ+gchS9AM=
Date: Wed, 25 Mar 2026 16:20:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Youngjun Park <youngjun.park@lge.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, shikemeng@huaweicloud.com,
 nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org, gunho.lee@lge.com,
 taejoon.song@lge.com, hyungjun.cho@lge.com, mkoutny@suse.com
Subject: Re: [PATCH v5 0/4] mm/swap, memcg: Introduce swap tiers for cgroup
 based swap control
Message-Id: <20260325162003.136dc86796eb124d3c7210ac@linux-foundation.org>
In-Reply-To: <20260325175453.2523280-1-youngjun.park@lge.com>
References: <20260325175453.2523280-1-youngjun.park@lge.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15055-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,kvack.org,vger.kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,lge.com,suse.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim,linux-foundation.org:mid]
X-Rspamd-Queue-Id: BE7AD32D562
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 26 Mar 2026 02:54:49 +0900 Youngjun Park <youngjun.park@lge.com> wrote:

> This is v5 of the "Swap Tiers" series.

Thanks.  I'd prefer to hold off until the next cycle, please.  As I
mentioned in 

https://lkml.kernel.org/r/20260323202941.08ddf2b0411501cae801ab4c@linux-foundation.org

Also, AI review had a lot to say, Please take a look.  Should you do
so, I'm interested in learning how much of that material was useful. 
Thanks.

https://sashiko.dev/#/patchset/20260325175453.2523280-1-youngjun.park%40lge.com

