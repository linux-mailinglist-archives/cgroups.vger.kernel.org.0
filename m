Return-Path: <cgroups+bounces-16288-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOQKLw0dFWoVSwcAu9opvQ
	(envelope-from <cgroups+bounces-16288-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 06:09:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B675D093E
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 06:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31172300B549
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 04:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDEF3BE17E;
	Tue, 26 May 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDItGFol"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A467346791;
	Tue, 26 May 2026 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779768577; cv=none; b=j31u+50NgRibhNJekAKYbMs7rAOg19XtodHE7azuYVjzlibOM0KmoIqYXtcVN4YDWGpbEx5EpXWaSanGRZCfgQAMAn8qUjlwyOfUjK1HgEFsrncjVLIE0U7jM0c3ZKvRwuc6oQzlBUOkLwO9ZIm5IKDIEAwTjDAYBIZlRprsm4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779768577; c=relaxed/simple;
	bh=NvZVqZuQ7y2IwzLbMgpaOQ7CYW4He6M5aDwstA1GzFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+cH/o8/jAGUq+lFvO+nH5ty8YGwYmnVT3STbMjyUaca45iUd2OxGM4vn9GG4OGkGbc7B9DUXmfJbH6ZH+iL0B5gsu6K5CTALpg6oG7BXD+lOfCmgPdziT+BSZCqTLP+h1sGRt22RxAlPcl0wCGWUZbfd9p/mjTjJg6f0Y7dksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDItGFol; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7891F000E9;
	Tue, 26 May 2026 04:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779768570;
	bh=CQd79S3jmwh5Od5pm5jxNxTwgJT8xPboifU1ZFa5Ro8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZDItGFol54Vyau00nEwrGiLqSd89co+5KygIfEcE5Yr9VyW3cUR4nJWWme0xPopxf
	 taMzNt2gz2DLL+gNKrkkZFSSOJ3NRNjd3xNYd5JlyE/NQiMf+s1ijUNsWwhZXPyUe/
	 v14XqSFIG8rjcaV8gI7SXwL4XlEJvmbpP/YP636LSFKbCiO8y6Cvc44SYbLXde+SNE
	 z9TscFICTMfvkGQgGB3jyhh227m6Ji9ic0Q+OFIgYi2dQpkCvSc6gH7JPfXTIoODNi
	 0rT5IJ4En/qwmqN2yW2gHJCWpxAm1i3UsTPwTazILJKAeS77pIWzU6hLUsYRvKVoAr
	 sTx9ONa6Ijn2g==
Message-ID: <c129633e-c411-4070-a836-78024b4f6acb@kernel.org>
Date: Tue, 26 May 2026 13:09:26 +0900
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] memcg: cache obj_stock by memcg, not by objcg pointer
To: Shakeel Butt <shakeel.butt@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>,
 Alexandre Ghiti <alex@ghiti.fr>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>
References: <20260518222827.110696-1-shakeel.butt@linux.dev>
 <aguiSnY3ie1y4nEl@linux.dev>
 <4e296262-fbbf-4ac7-aecc-3ef831583704@kernel.org>
 <agxszIIN6FtK0fEb@linux.dev>
 <ca8e655d-5fe7-4957-8a36-6667616be8b6@kernel.org>
 <agynzVVBb4CYJTYG@linux.dev>
 <20260519134927.ee04379d07b0674872422c06@linux-foundation.org>
 <ahB_kaWXowIIQ6dQ@linux.dev>
Content-Language: en-US
From: Harry Yoo <harry@kernel.org>
In-Reply-To: <ahB_kaWXowIIQ6dQ@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16288-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 36B675D093E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/23/26 1:16 AM, Shakeel Butt wrote:
> On Tue, May 19, 2026 at 01:49:27PM -0700, Andrew Morton wrote:
>> On Tue, 19 May 2026 13:11:13 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:
>>
>>> Andrew, please don't send this patch to Linus until we decide on the option.
>>
>> No probs, I added a note-to-self.
> 
> Here is my suggestion on how to proceed.
> 
> 1. Let's drop this patch (memcg: cache obj_stock by memcg, not by objcg pointer)
>     from mm-tree.
> 
> 2. Let's not add anything to 7.1.
> 
> 3. 7.2+ will have the multi-objcg series [1] and the patches will have fixes
>     tag. If someone uses non-LTS 7.1, they can easily find those patches and can
>     backport them.
> 
> Please let me know if there are any concerns.

Sounds fair to me.
> [1] https://lore.kernel.org/20260522011908.1669332-1-shakeel.butt@linux.dev/

Thanks!

-- 
Cheers,
Harry / Hyeonggon


