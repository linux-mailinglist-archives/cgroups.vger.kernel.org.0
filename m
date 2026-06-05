Return-Path: <cgroups+bounces-16677-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qs/EMPryImp8fgEAu9opvQ
	(envelope-from <cgroups+bounces-16677-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 18:02:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 030A16498CB
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 18:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lankhorst.se header.s=default header.b=HKtT4aia;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16677-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16677-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lankhorst.se;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59E303002F82
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615413B71A5;
	Fri,  5 Jun 2026 15:53:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934D37B023;
	Fri,  5 Jun 2026 15:53:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674801; cv=none; b=R/avN2O/ydxlbG62mVA90EjBYzJyObeeIiM/vxPwf6dnAaQ6tIW9CYDhFcF+qdJhpjvpVBvC6nNZnERBL5Fcdp9MZty+OZjEf/YuLWPskX1MU6m8sLZVu6Tka3OdKwZLTIkG6lnWQKDlrMgetY2+rRs252RG27vH5/ijtq7QYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674801; c=relaxed/simple;
	bh=KHV7Fhy3ZcWBoItd6My6nFLOPmYf7jB0k6jodzEWg7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSrXcs1NmKE3tz9QvFT0feBf039SDIQjmBTnlhbQUnIK/gRHGAPfos2GGsDG4gvDzV/9ToKo1tiNs6ERZVBCA0iAsZKbF00Euyh+709bvtilFp2dioeut2foYqo4uywIkkp5kJs+s9cOCMKcGS3D4yU3qi+FFWB0luUGqBC7L4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=HKtT4aia; arc=none smtp.client-ip=141.105.120.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1780674796;
	bh=KHV7Fhy3ZcWBoItd6My6nFLOPmYf7jB0k6jodzEWg7o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HKtT4aia3WWT2tzcVXI+3VWpQ23gDCQYrXrrNZBhkl6DzG+UDBwgl/CCMoXyPVsOc
	 hB8jBZvWwgIg7zVTRHwtYVYMbLfzuVVJIQlOipw0ztzvLaBOag/+Pd1ydQSQglviUM
	 LOjTWStzoANoaNrme8SUVMbfol4zc+gR9LGIfqCS6qACDLRkJIEG0hxooyNHBDJ2xE
	 bQIoXuqoLzdGfJrs18kvYf9Gly5Zk1AwbytFbmPVuAZASDjSGS28j95+ATMW9AwW06
	 I/2gELsdMnVao7bV2lOmZYjYguEv4V1OL+E+CNQMWP0XI32nrAm687iJWUBlUM0Cyv
	 A+5mxS7AWf8MA==
Message-ID: <9c59cddf-0a1b-4110-886d-477d7f334f08@lankhorst.se>
Date: Fri, 5 Jun 2026 17:53:17 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
To: Eric Chanudet <echanude@redhat.com>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Maxime Ripard
 <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "T.J. Mercier" <tjmercier@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>,
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
 <ahBxB5a9sX9DEWvl@localhost.localdomain> <ahXKFYBdCMDBvc_N@x1nano>
 <158bc103-7f99-4df4-8d3b-2da9b04ac0ed@lankhorst.se> <aiLVbQPxK1qI1h4p@x1nano>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <aiLVbQPxK1qI1h4p@x1nano>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16677-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:echanude@redhat.com,m:mkoutny@suse.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:mripard@kernel.org,m:natalie.vock@gmx.de,m:tj@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:tjmercier@google.com,m:christian.koenig@amd.com,m:mripard@redhat.com,m:aesteve@redhat.com,m:airlied@gmail.com,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 030A16498CB

Hey,

On 6/5/26 17:42, Eric Chanudet wrote:
> On Fri, Jun 05, 2026 at 01:27:09PM +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 5/26/26 18:59, Eric Chanudet wrote:
>>> On Fri, May 22, 2026 at 05:26:16PM +0200, Michal Koutný wrote:
>>>> Hello Eric.
>>>>
>>>> On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.com> wrote:
>>>>> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
>>>>> configure whether allocations in a dmem region should also be charged to
>>>>> the memory controller.
>>>>
>>>> This kinda makes sense as it is not unlike io.cost.* device
>>>> configurators.
>>>>
>>>> Just for my better understanding -- will there be a space for userspace
>>>> to switch this? (No charged dmem allocations happen before responsible
>>>> userspace runs, so that the attribute remains unlocked.)
>>>>
>>>> (I'm rather indifferent about the actual double charging/non-charging
>>>> matter.)
>>>
>>> Yes, this is intended to be configured before the user space stack that
>>> would start allocating things is started. Once it has started (and tried
>>> to charge something), the configuration is locked
>>>
>>>>
>>>>>
>>>>> To handle inheritance, dmem adds a depends_on the memory controller,
>>>>> unless MEMCG isn't configured in.
>>>>>
>>>>> Double-charging is disabled by default. Once a charge is attempted, the
>>>>> setting is locked to prevent inconsistent accounting by a small 4-state
>>>>> machine (off, on, locked off, locked on).
>>>>>
>>>>> The memcg to charge is derived from the pool's cgroup, since the pool
>>>>> holds a reference to the dmem cgroup state that keeps the cgroup alive
>>>>> until it gets uncharged.
>>>>>
>>>>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>>>>> ---
>>>>>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
>>>>>  kernel/cgroup/dmem.c                    | 158 +++++++++++++++++++++++++++++++-
>>>>>  2 files changed, 178 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
>>>>> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a8914d3033e8e42359 100644
>>>>> --- a/Documentation/admin-guide/cgroup-v2.rst
>>>>> +++ b/Documentation/admin-guide/cgroup-v2.rst
>>>>> @@ -2828,6 +2828,29 @@ DMEM Interface Files
>>>>>  	  drm/0000:03:00.0/vram0 12550144
>>>>>  	  drm/0000:03:00.0/stolen 8650752
>>>>>  
>>>>> +  dmem.memcg
>>>>> +	A readwrite nested-keyed file that exists only on the root
>>>>> +	cgroup.
>>>>
>>>> Strictly speaking this is not nested-keyed but flat keyed [1],
>>>
>>> Indeed,
>>>
>>>> which leads me to realization that this is the first instance of a boolean.
>>>> All in call, such a composition comes to my mind (latter is RO):
>>>>
>>>> 	drm/0000:03:00.0/vram0 enable=0|1 locked=0|1
>>>>
>>>
>>> So per[1] 1 key, 2 sub-keys (enable RW, locked RO), that looks better
>>> and match the documentation, thanks!
>>>
>>>>
>>>>
>>>>> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char *buf,
>>>>> +				       size_t nbytes, loff_t off)
>>>>> +{
>>>>> +	while (buf) {
>>>>> +		struct dmem_cgroup_region *region;
>>>>> +		char *options, *name;
>>>>> +		bool flag;
>>>>> +
>>>>> +		options = buf;
>>>>> +		buf = strchr(buf, '\n');
>>>>> +		if (buf)
>>>>> +			*buf++ = '\0';
>>>>
>>>> I recall there was a discussion about accepting only a single device per
>>>> write(2) (at the same time I see this idiom is still present in other
>>>> dmem.* files, so this is nothing to change in _this_ patch).
>>>
>>> I would second that. When setting say dmem.max for 2 regions, with a
>>> typo on the second, the first one is set, but write still get EINVAL.
>>>
>>> Also, I just notice dmemcg_limit_write() returns EINVAL if the region is
>>> not found (this patch returns ENODEV).
>>>
>>>>
>>>> Thanks,
>>>> Michal
>>>>
>>>> [1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format
>>>
>>>
>>>
>>
>> Perhaps a bit late, but before we start adding this UAPI we should enforce a
>> single region per write?
> 
> I can send that separately, although that is a UAPI change. Is there any
> user that would be affected?
> 
> This series is hung on charging memcg using memory objects from the
> context of dmem, when at that level of abstraction it doesn't have
> access to the underlying pieces that were allocated.

It's a uapi change, but I see more and more interest in the development and usage of dmemcg.
I believe it's better to fix this before users (perhaps accidentally) start to rely on this behavior.

Kind regards,
~Maarten Lankhorst

