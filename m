Return-Path: <cgroups+bounces-805-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27540804D24
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 10:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6DF1F214E4
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 09:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEF43D977;
	Tue,  5 Dec 2023 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VrH0qrnA"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2482120;
	Tue,  5 Dec 2023 01:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701767052; x=1733303052;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=0Xoq+rJyY1UIp1LJiIIxaTDxo/bpE9rs+1q3pFVff/c=;
  b=VrH0qrnAymaYUoJak9mBiYADAvf3zZhqm4NDohcUL0hcofCeVkqfm4QA
   ghEgkru2MInK75g/01a423bam7zLDP50mQ3ZO1tofgusBkDR5pEs1/6Fg
   6Ih5FUTDB09Vh49Oz0v23MrIZDxMl3SKShXVn9X86xP5rPf+mTez6hzhx
   1S/s7Z7YRqS3hbupzfRO1nuktwYafuzvCViZ2CblUmSQvHmJURG+v+KIf
   AEKifhR+OILzzLRczX0H9hepheF2iqC4jagvUVpzAq92BCYJ8WpkN4Hnq
   RxYvC40jsbEpkFrYELs5BkHiSMEliB6AYWSeKz3YzeKk9HaaU+EYo806W
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="708162"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="708162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914730523"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="914730523"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:03:51 -0800
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
In-Reply-To: <ZW3ZFDeTs7xotImL@memverge.com> (Gregory Price's message of "Mon,
	4 Dec 2023 08:50:12 -0500")
References: <ZU6uxSrj75EiXise@memverge.com> <ZU7vjsSkGbRLza-K@slm.duckdns.org>
	<ZU74L9oxWOoTTfpM@memverge.com> <ZVNBMW8iJIGDyp0y@tiehlicka>
	<ZVOXWx8XNJJNC23A@memverge.com> <ZVOn2T_Qg_NTKlB2@tiehlicka>
	<ZVOzMEtDYB4l8qFy@memverge.com>
	<87o7fveeze.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZW1IdPI11nhKcdZl@memverge.com>
	<87sf4i2xe1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZW3ZFDeTs7xotImL@memverge.com>
Date: Tue, 05 Dec 2023 17:01:51 +0800
Message-ID: <87fs0h2fb4.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gregory.price@memverge.com> writes:

> On Mon, Dec 04, 2023 at 04:19:02PM +0800, Huang, Ying wrote:
>> Gregory Price <gregory.price@memverge.com> writes:
>> 
>> > If the structure is built as a matrix of (cpu_node,mem_nodes),
>> > the you can also optimize based on the node the task is running on.
>> 
>> The matrix stuff makes the situation complex.  If people do need
>> something like that, they can just use set_memorypolicy2() with user
>> specified weights.  I still believe that "make simple stuff simple, and
>> complex stuff possible".
>> 
>
> I don't think it's particularly complex, since we already have a
> distance matrix for numa nodes:
>
> available: 2 nodes (0-1)
> ... snip ...
> node distances:
> node   0   1
>   0:  10  21
>   1:  21  10
>
> This would follow the same thing, just adjustable for bandwidth.

We add complexity for requirement. Not there's something similar
already.

> I personally find the (src,dst) matrix very important for flexibility.

With set_memorypolicy2(), I think we have the needed flexibility for
users needs the complexity.

> But if there is particular pushback against it, having a one dimensional
> array is better than not having it, so I will take what I can get.

TBH, I don't think that we really need that.  Especially given we will
have set_memorypolicy2().

>> > That feels very intuitive, deals with many race condition issues, and
>> > the global setting can actually be implemented without the need for
>> > set_mempolicy2 at all - which is certainly a bonus.
>> >
>> > Would love more thoughts here.  Will have a new RFC with set_mempolicy2,
>> > mbind2, and MPOL_WEIGHTED_INTERLEAVE soon that demonstrate the above.
>> 
>> Thanks for doing all these!
>> 
>
> Someone's got to :]
>

--
Best Regards,
Huang, Ying

