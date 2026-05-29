Return-Path: <cgroups+bounces-16414-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JDdAstDGWqNuAgAu9opvQ
	(envelope-from <cgroups+bounces-16414-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:44:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2B75FEB69
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 09:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C7BE304259F
	for <lists+cgroups@lfdr.de>; Fri, 29 May 2026 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245DA3AD50B;
	Fri, 29 May 2026 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="njLFIoh5"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BB93AA1B6;
	Fri, 29 May 2026 07:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040414; cv=none; b=cB1VdVX2q0PXrJs82B5R2KWdSXMFR7hK3H/p5dHqDDGoHNWUyZBBu6areAo6s4BRFuk3Wf2m2J0qzMAMhpHLYcEzBPYrlHGacSXrOL0FGX7inxFZGYgIPEBtR8fNR/k/C6zOCg3MQLjYnS0XzALAFaWnophgLryjvBN6f+aR2gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040414; c=relaxed/simple;
	bh=jQMKoFxjhXOg58Gu2goSrIvcgitzJfXOyS065eiSQOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bLkBwjCtxqeECqXucnDM1xhvY3p3w12jiYEBrQhYEDUJsmuaniHq+0QDnqmaz2MoNy5tv8XCYK325HfbXUPugkfsHjtCxGUypxxatjGc4CcsVFwDN4/a4gXkki4sN4x+0BqG5K4FuHEiJB+vmfJgv3wm5qUg4QUt+kslpwxxsa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=njLFIoh5; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780040071;
	bh=jQMKoFxjhXOg58Gu2goSrIvcgitzJfXOyS065eiSQOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=njLFIoh5+QF8qO2yk3lhUuM/T3YGzqoJcLI545XszXAraCyn/vqzqXbQpztEhe2qp
	 TvvjZJh8sITmgxaNvTUvCrCWKTxfWZ5H1t6ucIVSwHpWHzYJrJ8zxulTWmtYdQuf1D
	 S1iDf5BZX/zV0p/epJhWh88rH8FjbA70aH6aSBWLtYah/vlXYhULlnKNsLubUkU37E
	 7eC5Et/rBQnmvo5b5xtczea6RnEY437dQfirB8BhtMrcEPhpaL015Dxlh69eFMoueV
	 Uz25Xm/jB+pKTjyCi8f7ocYa5b9mJEfuoTwizogiCCJAbev4ZmKHjn5+RxJNWFSD8p
	 6wFW6wpwDZIiQ==
Message-ID: <89901220-0a43-4668-9d20-aaecc72c58dd@lankhorst.se>
Date: Fri, 29 May 2026 09:34:28 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cgroup/dmem: introduce a peak file
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
References: <20260514-dmem_peak-v3-1-b64ce5d3ac38@igalia.com>
 <ahCISfTlN10gD8e6@localhost.localdomain>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <ahCISfTlN10gD8e6@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16414-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,linux.dev,linux-foundation.org,lwn.net,linuxfoundation.org,gmx.de,igalia.com,vger.kernel.org,kvack.org,lists.freedesktop.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,igalia.com:email]
X-Rspamd-Queue-Id: 0F2B75FEB69
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Den 2026-05-22 kl. 18:48, skrev Michal Koutný:
> On Thu, May 14, 2026 at 02:36:08PM -0300, Thadeu Lima de Souza Cascardo <cascardo@igalia.com> wrote:
>> Just like we have memory.peak, introduce a dmem.peak, which uses the
>> page_counter support for that.
>>
>> For now, make it read-only.
>>
>> This allows for memory usage monitoring without polling dmem.current when
>> the information needed is the maximum device memory used. That can be used
>> for capacity planning, such that dmem.max can be properly setup for a given
>> workload. It can also be used for debugging to determine whether a given
>> workload would have caused eviction or system memory use.
>>
>> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
>> ---
>> Changes in v3:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
>> - Link to v2: https://patch.msgid.link/20260513-dmem_peak-v2-1-dac06999db9e@igalia.com
>>
>> Changes in v2:
>> - Make it read-only for now and adjust documentation accordingly.
>> - Link to v1: https://patch.msgid.link/20260506-dmem_peak-v1-0-8d803eb3449c@igalia.com
>> ---
>>  Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
>>  kernel/cgroup/dmem.c                    | 15 +++++++++++++++
>>  2 files changed, 21 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>> index 6efd0095ed99..d103623b2be4 100644
>> --- a/Documentation/admin-guide/cgroup-v2.rst
>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>> @@ -2808,6 +2808,12 @@ DMEM Interface Files
>>  	The semantics are the same as for the memory cgroup controller, and are
>>  	calculated in the same way.
>>  
>> +  dmem.peak
>> +	A read-only nested-keyed file that exists on non-root cgroups.
> 
> s/nested-keyed/flat-keyed/
> 
> 
> With that
> 
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>

With your r-b it's ok to push it to the dmemcg tree?

Kind regards,
~Maarten Lankhorst

