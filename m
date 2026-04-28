Return-Path: <cgroups+bounces-15533-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIPpGdeG8GnuUQEAu9opvQ
	(envelope-from <cgroups+bounces-15533-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:07:19 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B1E482399
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 12:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C03D2307119C
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9713E4C99;
	Tue, 28 Apr 2026 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/Sy5Wnu"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C063DE45D;
	Tue, 28 Apr 2026 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777370610; cv=none; b=K0rjJk7fDNYRibyNkiBKPNdfA16WFktYUXcEfgDaHd3CHmMiRD3mZwy4RA+pmGaDDWEaxVsz6mXyL9lcAKqEvtVe1itp1o1y5hHgqDYtB5YBRe14sCPuu0Gxp1S9gUrIrTxHHjAC9HddLYbtSPErBv8Mpm9tlZRIJUr3BpkKOLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777370610; c=relaxed/simple;
	bh=+ECWrTj6T9nXyizFcGHRHwRi9kfPiNkkeLvnXcmcBbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F5p1U+FGEuG3bsobpFsjy2R4wLmpQJ1FikQTCTjwSQ0AsVL0ss4akcFhbeEeUeZewriIDw8RoJ9nXaLejiPJAz+nP/YIfBrgVZfNcFtrQg5nqtIJ6YlZzEuQTZWag6nXbs83IRGipYaLi8Mb2voUSoSD+OqgCvaaMjSoVlX9mCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/Sy5Wnu; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777370610; x=1808906610;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+ECWrTj6T9nXyizFcGHRHwRi9kfPiNkkeLvnXcmcBbs=;
  b=W/Sy5Wnu6tOgFKWuRYklDqVYUpQVsAsm7WdX6BzVg5a32d+W1RaKWJv+
   kkoOjz7UTjTd6vaQIXmzCVwNHJNko++Oxv8kztHkc5KnMFrB2r/zoG0mN
   BNuxaOnBnvoazPIHLuyhC3yzwRznEUjeG3dXSuC8Ucukt5pMHQJXq9nvv
   qBYOrj7MEYttWAFFt+XhjiD7HKDmvqF6tgTLP2oHTcfie09bdhaUs81Gf
   oAPUPM1PaJL/vgg5YiJqMZ5nUwn3pkB5SgxcfK/X+Usb5037EJ1t5FUS2
   4sx6+MnWiYAV4BnQAuEFWx9INnOb3ar2XXELq58TudXpdYlEhUfaeYAkG
   g==;
X-CSE-ConnectionGUID: eyDJ48qxRgy4shCg9uI/DQ==
X-CSE-MsgGUID: mTUT2rZMSZSGhsZajPqr9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="89364208"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="89364208"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:03:29 -0700
X-CSE-ConnectionGUID: RbzKJ2OCQxukaTrtiIiKNg==
X-CSE-MsgGUID: yJKBYizaSuqthFAadQ2HUg==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO [10.245.244.230]) ([10.245.244.230])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 03:03:24 -0700
Message-ID: <be6168a0-38b2-41ac-94d8-cfc2b19dec2e@linux.intel.com>
Date: Tue, 28 Apr 2026 12:03:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drm/xe: Wire up dmem cgroup reclaim for VRAM
 manager
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260428073116.15687-1-thomas.hellstrom@linux.intel.com>
 <20260428073116.15687-4-thomas.hellstrom@linux.intel.com>
 <84473cbe-79ad-421e-8c8a-171e5784105f@linux.intel.com>
 <5d36326b1b9c009cd544fe5ca195ae484dbbc915.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <5d36326b1b9c009cd544fe5ca195ae484dbbc915.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E5B1E482399
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-15533-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,linux.intel.com:mid,patchwork.freedesktop.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hey,

Den 2026-04-28 kl. 12:02, skrev Thomas Hellström:
> On Tue, 2026-04-28 at 11:50 +0200, Maarten Lankhorst wrote:
>>
>>
>> Den 2026-04-28 kl. 09:31, skrev Thomas Hellström:
>>> Register the VRAM manager with the dmem cgroup reclaim
>>> infrastructure
>>> so that lowering dmem.max below current VRAM usage triggers TTM
>>> eviction rather than failing with -EBUSY.
>>>
>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> ---
>>>  drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 19 ++++++++++++-------
>>>  1 file changed, 12 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>>> b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>>> index 5fd0d5506a7e..1bdcb3fee901 100644
>>> --- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>>> +++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
>>> @@ -303,13 +303,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device
>>> *xe, struct xe_ttm_vram_mgr *mgr,
>>>  	struct ttm_resource_manager *man = &mgr->manager;
>>>  	int err;
>>>  
>>> -	if (mem_type != XE_PL_STOLEN) {
>>> -		const char *name = mem_type == XE_PL_VRAM0 ?
>>> "vram0" : "vram1";
>>> -		man->cg = drmm_cgroup_register_region(&xe->drm,
>>> name, size);
>>> -		if (IS_ERR(man->cg))
>>> -			return PTR_ERR(man->cg);
>>> -	}
>>> -
>>>  	man->func = &xe_ttm_vram_mgr_func;
>>>  	mgr->mem_type = mem_type;
>>>  	mutex_init(&mgr->lock);
>>> @@ -318,6 +311,18 @@ int __xe_ttm_vram_mgr_init(struct xe_device
>>> *xe, struct xe_ttm_vram_mgr *mgr,
>>>  	mgr->visible_avail = io_size;
>>>  
>>>  	ttm_resource_manager_init(man, &xe->ttm, size);
>>> +
>>> +	if (mem_type != XE_PL_STOLEN) {
>>> +		const char *name = mem_type == XE_PL_VRAM0 ?
>>> "vram0" : "vram1";
>>> +		struct dmem_cgroup_region *cg =
>>> +			drmm_cgroup_register_region(&xe->drm,
>>> name, size);
>>> +
>>> +		if (IS_ERR(cg))
>>> +			return PTR_ERR(cg);
>>> +
>>> +		ttm_resource_manager_set_dmem_region(man, cg);
>>> +	}
>>> +
>>>  	err = gpu_buddy_init(&mgr->mm, man->size,
>>> default_page_size);
>>>  	if (err)
>>>  		return err;
>>
>> This patch will conflict with 
>> https://patchwork.freedesktop.org/series/164694/ which removes
>> stolen support, can we merge that patch first while we wait for AMD
>> acks?
> 
> Sure, np.
> 
>>
>> Do I need an ack to get the series through drm-misc?
> 
> Which series? The stolen support or this cgroup series?
This one, I think it might be easiest to just merge stolen through xe,
and then backmerge into drm-misc.

