Return-Path: <cgroups+bounces-15537-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAogOAm88Gn+XwEAu9opvQ
	(envelope-from <cgroups+bounces-15537-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 15:54:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C62486554
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 15:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C9C430406AA
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A40A4534AD;
	Tue, 28 Apr 2026 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="dNuxLkdu"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87C450910
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382069; cv=none; b=JSLmmHbC+5qbN/GJlChrZEii3llkijaI10HZyuHEbNf1l/KS8XvGYVbmP5TCC/8mEZknhK6LWmSc4xE0AvDeW5adxu/JLAihlV3mWzKTg5qMnGhzjjqyFUoyz1oJTxVg49EKS4Yb0MbDfiMb6SOfLRWrY2cvAfOJ7OVErMjfoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382069; c=relaxed/simple;
	bh=nTVAk8FVU9/9Iqogqi1Nlg2TfMCF2sxeKJyQ/8j1X+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OB0EY90txqNa15X3mVkAfkr6KwDbv1GbduhM+DMR321SStsBsU1cjjQegPdQkYnnILQi/tzeBCdrpyLXHAESusTW43AwXFbVuqCWS32bdYtntBVgVfkhH1KSFsF2ZTDQByxF5x4YKl5HLUvqvTqK8u421QrV99528XE621XKp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=dNuxLkdu; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1777382059;
	bh=nTVAk8FVU9/9Iqogqi1Nlg2TfMCF2sxeKJyQ/8j1X+A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dNuxLkduwB6bE+D5PePF93PM94aLLhS1Ywf7tnyWekON9xD2WQub3FOhLzs5iPwWo
	 FSBWG0HYkaaK7+AiRd7RTCuQUgf4nQy7+GxTrsJXc/shlL4RcABxhbnBBLM3uyT/SE
	 5Jifqsk6NODk5CJt6usjVA8KyL6w9t6MWF80wIMKTZWOqbQYwGZEkjYyJHSht1SE88
	 M4ICL940urGpJ4dIpVE4N9/c0lIDuSu7SXLOSMlytVGLM0OZ8yXQsTCDFMAGdWKTgc
	 M4l4Iy3TpDEsuY2XJ4O1VTGdyhgKbgswuscHCJ+XWKej5+2so1BfNNlmUP4VUoX1DT
	 iGBJCKWphFCJg==
Message-ID: <e1b698c8-5b9f-4726-9f83-06ed62822bdf@lankhorst.se>
Date: Tue, 28 Apr 2026 15:14:20 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
To: Natalie Vock <natalie.vock@gmx.de>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>,
 cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-2-7c71cc1492db@gmx.de>
 <cykgy6mf4nu5kkwl3uc6modkj3ppela2xgjy2ijidpyzdsnyn4@cbwivcrqa5kh>
 <911b9bfb-c352-4f6d-93a1-540246ccd5b2@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <911b9bfb-c352-4f6d-93a1-540246ccd5b2@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 63C62486554
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15537-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net,vger.kernel.org,lists.freedesktop.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]

Hey,

Den 2026-03-16 kl. 09:46, skrev Natalie Vock:
> On 3/13/26 15:16, Michal Koutný wrote:
>> On Fri, Mar 13, 2026 at 12:40:01PM +0100, Natalie Vock <natalie.vock@gmx.de> wrote:
>>> This helps to find a common subtree of two resources, which is important
>>> when determining whether it's helpful to evict one resource in favor of
>>> another.
>>>
>>> To facilitate this, add a common helper to find the ancestor of two
>>> cgroups using each cgroup's ancestor array.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   include/linux/cgroup.h      | 21 +++++++++++++++++++++
>>>   include/linux/cgroup_dmem.h |  9 +++++++++
>>>   kernel/cgroup/dmem.c        | 28 ++++++++++++++++++++++++++++
>>>   3 files changed, 58 insertions(+)
>>
>> When the helper is added, the idiom in
>> kernel/cgroup/cgroup.c:cgroup_procs_write_permission() could perhaps be
>> switched to it too (structured in commits) to "optimize" migrations from
>> large depths.
> 
> Right. Perhaps better suited as follow-up work though, isn't it?
> 
> Thanks,
> Natalie

Does this patch need an ack to merge through the drm-misc tree?

Kind regards,
~Maarten Lankhorst

