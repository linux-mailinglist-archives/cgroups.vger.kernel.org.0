Return-Path: <cgroups+bounces-16730-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zlTjDr7CJmqWkAIAu9opvQ
	(envelope-from <cgroups+bounces-16730-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:25:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E2F6569C0
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 15:25:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lankhorst.se header.s=default header.b=a1FrAp1s;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16730-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16730-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lankhorst.se;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0276A30A2027
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7B370AC8;
	Mon,  8 Jun 2026 13:14:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3936C0D6;
	Mon,  8 Jun 2026 13:13:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924440; cv=none; b=g7fjVwc7DZezBtrfjbZVJeWRIwqAAVsj6hccdcXljA8FMAVapxx/wtBVHrJyFkZqY1rP2im+hxav/Xrp5zAtbxxebVLEQAqHTG6ghhPhtEXYn7f75XM39IWztYOUKS12kQ+Xm9izlvRrhBsm6AnhKda44ZxtbX5K69aMLK3RyOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924440; c=relaxed/simple;
	bh=kWmrbBrFJNXrHqm+QvN7OAx/N9PT+K0Bb7hyg+swA4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=My9W8GHtsZKEhNRp1vCBARXNlxFmVxAI1whGzkw/NSI4hXp4lzErd4wCEQxv4U0aJgpRKAWUEZB/QAsrBh4RCivFh95960S9pPOd7XNOIPNy96Oy7JeYYWfZw6j15DN/XsyNLepPyD7RrNMaUcJcMEeLiKW3i6NQytFA57lT+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=a1FrAp1s; arc=none smtp.client-ip=141.105.120.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780924430;
	bh=kWmrbBrFJNXrHqm+QvN7OAx/N9PT+K0Bb7hyg+swA4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a1FrAp1syfh2rgAO+9Yiz1xXIY6uV4rBr1yfUGDMjFPyuoxHfrkokiW5TkYwXsV6i
	 oaugY3XQUmkuWAJ79T4R4qBA6HKv0RgjxwMe0SdhuKVtRmf+AGQBfpTlohcdBgwKpM
	 mJdOKbve0PbxWt+qy7GEFaHtc+A6dl90yKX6/ih6GfLrHU7BG8lk+5UyaG5nWuwr+B
	 VVTEDUIWtUr3yX2EmqdbB59iMH5f8lnBymuQP7BXZ3DLSoYpL1viqhvOEriG25Pt7m
	 rzKYAw0YDCn6BWyWBIki2SVjRuEaeSZxCmmg+OjmqWVkc4ghzak19/wYpmXjoDU78X
	 DBddYLvj+ytXA==
Message-ID: <15bab7c9-0857-40b9-963b-9923c0e7392c@lankhorst.se>
Date: Mon, 8 Jun 2026 15:13:56 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cgroup/dmem: accept only one region per limit write
To: Maxime Ripard <mripard@kernel.org>
Cc: Natalie Vock <natalie.vock@gmx.de>, Eric Chanudet <echanude@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Albert Esteve <aesteve@redhat.com>
References: <20260605-cgroup-dmem-write-single-region-v1-1-9137f296579c@redhat.com>
 <271b1c16-3c3c-4a1e-b09e-c4361c63814c@gmx.de>
 <f00e7771-cd70-4c86-9fac-149897e02b12@lankhorst.se>
 <20260608-glorious-fluorescent-salamander-93daec@houat>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260608-glorious-fluorescent-salamander-93daec@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16730-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mripard@kernel.org,m:natalie.vock@gmx.de,m:echanude@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-kernel@vger.kernel.org,m:aesteve@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,redhat.com,kernel.org,cmpxchg.org,suse.com,vger.kernel.org,lists.freedesktop.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchwork.freedesktop.org:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lankhorst.se:dkim,lankhorst.se:mid,lankhorst.se:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83E2F6569C0

Hey,

On 6/8/26 14:42, Maxime Ripard wrote:
> On Sat, Jun 06, 2026 at 11:44:10PM +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 6/6/26 18:31, Natalie Vock wrote:
>>> On 6/6/26 00:44, Eric Chanudet wrote:
>>>> Accept only one "region value" pair entry for the dmem.max, dmem.min,
>>>> dmem.low files.>
>>>> This changes the UAPI that otherwise accepted multiple lines for setting
>>>> multiple entries in one write. No existing user is known to rely on
>>>> writing multiple regions in a single write.
>>>
>>> Ugh, shoot.
>>>
>>> For dmem.low specifically, there already are some userspace thingies floating around that may write more than one region/value pairs.
>>>
>>> These thingies all depend on that one patchset for dmemcg protection that I should really get around to merging[1]. Since the userspace utilities depend on not-yet-merged patches, they sort of have to expect stuff changing under their belts, so I wouldn't really consider those users a blocker by necessity.
>>>
>>> As I see it, we could go down one of two paths:
>>> 1. We go ahead with the patch as proposed, and I make sure that the users I know of adapt. Could be a bit icky wrt. "do not break userspace" rules, but since the already use non-merged UAPIs in one place, you can argue that these users kind of have to expect breakage.
>>> 2. We use the old handling allowing multiple lines for dmem.min and dmem.low only. This preserves compatibility but uglifies the code by quite a bit.
>>>
>>> All things considered, I think I personally would prefer going with 1. and taking the patch as proposed and just having one codepath handling every limit file. Just highlighting this so we don't do it on accident.
>>>
>>> [1] https://patchwork.freedesktop.org/series/163183/
>>>
>>
>> I prefer option 1 as well, but would like an ack from one of the core cgroup maintainers too,
>> and what Maxime's opinion on this as well.
> 
> Option 1 works for me too if doable
> 
> Maxime


I see this as an acked-by?

I'll commit this patch to drm-misc-next if so.

Fortunately it may not even break those scripts in the typical case where only 1 region is registered, eg the most common laptop/desktop case.

Kind regards,
~Maarten Lankhorst

