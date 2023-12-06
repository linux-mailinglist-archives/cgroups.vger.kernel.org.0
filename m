Return-Path: <cgroups+bounces-834-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6658063AC
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 01:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418561C210F3
	for <lists+cgroups@lfdr.de>; Wed,  6 Dec 2023 00:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B7C655;
	Wed,  6 Dec 2023 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nEP39hyH"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44887C6;
	Tue,  5 Dec 2023 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701823948; x=1733359948;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=80ctbQu0ehO8Eb46q4E7qyIosvMkmzHirGugGzD0fGM=;
  b=nEP39hyHfvzoRlsdcZVVjm+sRym3O/E5kVOwZZsoCdSZxLB8WvBkrY+9
   0PJKnxrAVlR/IQ7iwyqbm8vY6A6F5e5/VZ60CR3LOyLcMtqNvXMhn3wwR
   r4N42KS3X6gqWNGM5czJi4f5jzu0x5x0bFONLzgan+zzAwSb3rt7VKagm
   D0diNi3uUpKO0fX+vMxnGjpGlgvooll2cNTC+q5b9hZ3HPyPEZR2N2DrL
   AkEoKI1k1ziPAS8Vd0t5V1sojcHeT8B0bHIM2IvPDehLHt8LaHgYDhj5U
   hXX2wQILePSXlkhco5RQ/nM781In2Vlo7eJb+lpELSON2ZLlcVv1c/Fqi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="821338"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="821338"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:52:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="861937995"
X-IronPort-AV: E=Sophos;i="6.04,253,1695711600"; 
   d="scan'208";a="861937995"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 16:52:23 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Michal Hocko <mhocko@suse.com>,  "tj@kernel.org" <tj@kernel.org>,  "John
 Groves" <john@jagalactic.com>,  Gregory Price <gourry.memverge@gmail.com>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "cgroups@vger.kernel.org"
 <cgroups@vger.kernel.org>,  "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  "lizefan.x@bytedance.com"
 <lizefan.x@bytedance.com>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "corbet@lwn.net" <corbet@lwn.net>,  "roman.gushchin@linux.dev"
 <roman.gushchin@linux.dev>,  "shakeelb@google.com" <shakeelb@google.com>,
  "muchun.song@linux.dev" <muchun.song@linux.dev>,  "jgroves@micron.com"
 <jgroves@micron.com>
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
In-Reply-To: <ZW84F5PUB/0yPW9d@memverge.com> (Gregory Price's message of "Tue,
	5 Dec 2023 09:47:51 -0500")
References: <ZU74L9oxWOoTTfpM@memverge.com> <ZVNBMW8iJIGDyp0y@tiehlicka>
	<ZVOXWx8XNJJNC23A@memverge.com> <ZVOn2T_Qg_NTKlB2@tiehlicka>
	<ZVOzMEtDYB4l8qFy@memverge.com>
	<87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZW1IdPI11nhKcdZl@memverge.com>
	<87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZW3ZFDeTs7xotImL@memverge.com>
	<87fs0h2fb4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZW84F5PUB/0yPW9d@memverge.com>
Date: Wed, 06 Dec 2023 08:50:23 +0800
Message-ID: <875y1c2lyo.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Tue, Dec 05, 2023 at 05:01:51PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > On Mon, Dec 04, 2023 at 04:19:02PM +0800, Huang, Ying wrote:
>> >> Gregory Price <gregory.price@memverge.com> writes:
>> >> 
>> >> > If the structure is built as a matrix of (cpu_node,mem_nodes),
>> >> > the you can also optimize based on the node the task is running on.
>> >> 
>> >> The matrix stuff makes the situation complex.  If people do need
>> >> something like that, they can just use set_memorypolicy2() with user
>> >> specified weights.  I still believe that "make simple stuff simple, and
>> >> complex stuff possible".
>> >> 
>> >
>> > I don't think it's particularly complex, since we already have a
>> > distance matrix for numa nodes:
>> >
>> > available: 2 nodes (0-1)
>> > ... snip ...
>> > node distances:
>> > node   0   1
>> >   0:  10  21
>> >   1:  21  10
>> >
>> > This would follow the same thing, just adjustable for bandwidth.
>> 
>> We add complexity for requirement. Not there's something similar
>> already.
>> 
>> > I personally find the (src,dst) matrix very important for flexibility.
>> 
>> With set_memorypolicy2(), I think we have the needed flexibility for
>> users needs the complexity.
>> 
>> > But if there is particular pushback against it, having a one dimensional
>> > array is better than not having it, so I will take what I can get.
>> 
>> TBH, I don't think that we really need that.  Especially given we will
>> have set_memorypolicy2().
>>
>
> From a complexity standpoint, it is exactly as complex as the hardware
> configuration itself:  each socket has a different view of the memory
> topology. If you have a non-homogeneous memory configuration (e.g. a 
> different number of CXL expanders on one socket thant he other), a flat
> array of weights has no way of capturing this hardware configuration.

One important task of the software is to hide the complexity of hardware
from the users.  At least it should provide the option.  It only add
complexity based on real requirements.

> That makes the feature significantly less useful. In fact, it makes the
> feature equivalent to set_mempolicy2 - except that weights could be
> changed at runtime from outside a process.
>
>
> A matrix resolves one very specific use case: task migration
>
>
> set_mempolicy2 is not sufficient to solve this.  There is presently no
> way for an external task to change the mempolicy of an existing task.
> That means a task must become "migration aware" to use weighting in the
> context of containers where migrations are likely.
>
> Two things to consider: A task...
>    a) has no way of knowing a migration occured
>    b) may not have visibility of numa nodes outside its cpusets prior to
>       a migration - making it unlikely/not possible for them to set
>       weights correctly in the event a migration occurs.
>
> If a server with 2 sockets is set up non-homogeneously (different amount
> of CXL memory expanders on each socket), then the effective bandwidth
> distribution between sockets will be different.
>
> If a container is migrated between sockets in this situation, then tasks
> with manually set weights, or if global weights are a single array, will
> have poor memory distributions in relation to the new view of the system.
>
> Requiring the global settings to be an array basically requires global
> weights to be sub-optimal for any use cases that is not explicitly a
> single workload that consumes all the cores on the system.
>
> If the system provides a matrix, then the global settings can be optimal
> and re-weighting in response to migration happens cleanly and transparently.

For these complex requirements, we will have process_set_mempolicy2().
I think that it's even more flexible than the global matrix.

--
Best Regards,
Huang, Ying

