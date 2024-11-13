Return-Path: <cgroups+bounces-5534-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F176B9C74EC
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 15:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A681F2344A
	for <lists+cgroups@lfdr.de>; Wed, 13 Nov 2024 14:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1620015444E;
	Wed, 13 Nov 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wf32Kn6j"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD3A1CAAC;
	Wed, 13 Nov 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509912; cv=none; b=Q6yIaDB+PyT9s22Q5RN/kftFl6bxMlxGG8DDmX1sVsE6jPXw2bZFUnWUZunq2RbpkuvsjD5V7r5v1hmUdtzkFEolJ5dDO5tGX90PWsl4Jr6xBD0Hk8njvbOvw9o0L+6o0t7cS93L9jYIICNcVYoj2Bsbg6ppqWaPnertYkfqMZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509912; c=relaxed/simple;
	bh=X24yyBmMKWlCDsByrpVknt1MPni2cbO2tE1LVAy+jxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ih5G1unmF/5nvOnXT1j0nySvpv2kiC+VicZvZiD4t6mASnMqGiqB4z9J6z8QU1rOnkhGmcIpJNhUsmy508Xv3zm1g43K1n8Kx/3ehHgMXbIxfBQZV9C1sn5fycWR1FrrdfJE6SIHbgr2212u0jkpKaeJn6PscWThPq03MLnHC00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wf32Kn6j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731509911; x=1763045911;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X24yyBmMKWlCDsByrpVknt1MPni2cbO2tE1LVAy+jxw=;
  b=Wf32Kn6jKQliYNAoBOHEjVqrGM+rktkqGxgvye2pEmEU23cxI3SaFyWL
   YMyJ0bmTnVOxr/uzYNRxMaV1tHZjkSnHXfeC1MyKoa4GtndBxYhG6O06X
   OE7VIRpdUnKN8TVZ1DEyjeYLK99ttZ2CbOe7RsX44G1L21FxUgwYQhxve
   d9gUsCulownlxwKFpvM7QIGGprwxpsNCiv7HdTy5Oz+IOPed9zDEZ+ZLK
   A6SoqBl9jBlxzPxtfQNIJN+p0vhjurMYMPWO/lI82NKNcnkKqi4MRQie+
   rwb5opRtLPJzbl4+35Tr6cd7OCgIXSGtw49jjsnJLtCqWrhgScsXfGjjf
   Q==;
X-CSE-ConnectionGUID: J4Vxpio9R4K+XwGnutKWeA==
X-CSE-MsgGUID: bfC8bGbvSz6OWlWIu+09Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48856350"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48856350"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:58:31 -0800
X-CSE-ConnectionGUID: Bc6jQQN4S02Ll+J+ofCI0w==
X-CSE-MsgGUID: Kyb9bbZNSx+iy0bO1f/hmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118833767"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO [10.245.245.192]) ([10.245.245.192])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:58:27 -0800
Message-ID: <d6c57862-1593-44ff-a192-7af308cac94b@linux.intel.com>
Date: Wed, 13 Nov 2024 15:58:25 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] kernel/cgroups: Add "dev" memory accounting cgroup.
To: Tejun Heo <tj@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Zefan Li <lizefan.x@bytedance.com>, Andrew Morton
 <akpm@linux-foundation.org>, Friedrich Vock <friedrich.vock@gmx.de>,
 cgroups@vger.kernel.org, linux-mm@kvack.org
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <ZxlRLMwkabTaOrjc@slm.duckdns.org>
 <20241024-beautiful-spaniel-of-youth-f75b61@houat>
 <Zxp-nLXOJXoSy8BN@slm.duckdns.org>
 <20241028-meaty-mega-nuthatch-3d74b1@houat>
 <20241029203834.GA636494@cmpxchg.org>
 <20241106-vivacious-eagle-of-gaiety-44a419@houat>
 <ZyuzeIhTgXU5CCk0@slm.duckdns.org>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <ZyuzeIhTgXU5CCk0@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

Den 2024-11-06 kl. 19:20, skrev Tejun Heo:
> On Wed, Nov 06, 2024 at 11:31:49AM +0100, Maxime Ripard wrote:
> ...
>>> How about dmem for this one, and dpu for the other one. For device
>>> memory and device processing unit, respectively.
>>
>> dmem sounds great to me, does everyone agree?
> 
> Sounds good to me.
> 
> Thanks.
> 
Thanks for all feedback and discussion. I checked mostly on patchwork so 
I missed the discussion here. Fortunately it's only been about naming. :)

I'm thinking of adding a 'high' knob as well, that will work similarly 
to high in normal mem controller. (so not proportionally calculated like 
'max', but (usage + allocated) < max = ok.

Recursively of course.

Cheers,
~Maarten

