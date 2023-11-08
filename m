Return-Path: <cgroups+bounces-237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E488B7E51B5
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 09:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B687281416
	for <lists+cgroups@lfdr.de>; Wed,  8 Nov 2023 08:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68674D52F;
	Wed,  8 Nov 2023 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKYQz0Mc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F77D520;
	Wed,  8 Nov 2023 08:11:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB03C1A6;
	Wed,  8 Nov 2023 00:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699431096; x=1730967096;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=t39GUkIid9dZJeh3529U2jVJKYEbEiVsy5OvbtMLGXA=;
  b=iKYQz0McCqcMyj9r2TGFj4YhqdAN/WadSy4tURLq4yuODWJwOeoSDXn5
   RmzXNcsmWu78TdFe/uXBkVukrnUDoHVDusT/SBv4O8q6rsejXTX8XcfzF
   DiG5kHdiSYp9u/8eG3K7xEGPH70FKdN376gX/qqqO+UC7aOMSf7YnELm7
   3p/O/yzfyAiqv3ghpFj+neGe4SVq+znd9K0WMuifiorkEqWnirI/o4hHV
   WqXNPbkIC280rVYDwmYOxA2OP4OoQgovSUaqMf6Wo1ICBkUY3ObCN3F5i
   SCeP7Xj8cnnaXdCLrEglZb7ibYFd2qeFZWbCQfW98re9fPB8e5RyaGQ4F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="389523284"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="389523284"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="936438382"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="936438382"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 00:11:31 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Huan Yang <link@vivo.com>
Cc: Tejun Heo <tj@kernel.org>,  Zefan Li <lizefan.x@bytedance.com>,
  "Johannes Weiner" <hannes@cmpxchg.org>,  Jonathan Corbet
 <corbet@lwn.net>,  Michal Hocko <mhocko@kernel.org>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeelb@google.com>,  Muchun
 Song <muchun.song@linux.dev>,  Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand <david@redhat.com>,  "Matthew Wilcox"
 <willy@infradead.org>,  Kefeng Wang <wangkefeng.wang@huawei.com>,  Peter
 Xu <peterx@redhat.com>,  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
  Yosry Ahmed <yosryahmed@google.com>,  Liu Shixin <liushixin2@huawei.com>,
  Hugh Dickins <hughd@google.com>,  <cgroups@vger.kernel.org>,
  <linux-doc@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
In-Reply-To: <d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com> (Huan Yang's
	message of "Wed, 8 Nov 2023 15:53:16 +0800")
References: <20231108065818.19932-1-link@vivo.com>
	<87v8ack889.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d3d2f43f-0733-4205-a649-0a42ea88f377@vivo.com>
Date: Wed, 08 Nov 2023 16:09:29 +0800
Message-ID: <87r0l0k6o6.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Huan Yang <link@vivo.com> writes:

> HI Huang, Ying
>
> Thanks for reply.
>
> =E5=9C=A8 2023/11/8 15:35, Huang, Ying =E5=86=99=E9=81=93:
>> Huan Yang <link@vivo.com> writes:
>>
>>> In some cases, we need to selectively reclaim file pages or anonymous
>>> pages in an unbalanced manner.
>>>
>>> For example, when an application is pushed to the background and frozen,
>>> it may not be opened for a long time, and we can safely reclaim the
>>> application's anonymous pages, but we do not want to touch the file pag=
es.
>>>
>>> This patchset extends the proactive reclaim interface to achieve
>>> unbalanced reclamation. Users can control the reclamation tendency by
>>> inputting swappiness under the original interface. Specifically, users
>>> can input special values to extremely reclaim specific pages.
>>  From mem_cgroup_swappiness(), cgroupv2 doesn't have per-cgroup
>> swappiness.  So you need to add that firstly?
> Sorry for this mistake, we always work on cgroupv1, so, not notice
> this commit 4550c4e, thank your for point that.
>
> I see this commit comment that `that's a different discussion`, but,
> to implements this, I will try add.
>
>>
>>> Example:
>>>    	echo "1G" 200 > memory.reclaim (only reclaim anon)
>>> 	  echo "1G" 0  > memory.reclaim (only reclaim file)
>>> 	  echo "1G" 1  > memory.reclaim (only reclaim file)
>>>
>>> Note that when performing unbalanced reclamation, the cgroup swappiness
>>> will be temporarily adjusted dynamically to the input value. Therefore,
>>> if the cgroup swappiness is further modified during runtime, there may
>>> be some errors.
>> If cgroup swappiness will be adjusted temporarily, why not just change
>> it via a script before/after proactive reclaiming?
> IMO, this unbalance reclaim only takes effect for a single command,
> so if it is pre-set using a script, the judgment of the reclamation tende=
ncy
> may become complicated.

If swappiness =3D=3D 0, then we will only reclaim file pages.  If swappiness
=3D=3D 200, then we may still reclaim file pages.  So you need a way to
reclaim only anon pages?

If so, can we use some special swappiness value to specify that?  I
don't know whether use 200 will cause regression.  If so, we may need
some other value, e.g. >=3D 65536.

> So, do you mean avoid use cgroup swappiness, just type anon or file to
> control
> this extreme unbalanced reclamation?
>
>>
>>> However, this is acceptable because the interface is dynamically called
>>> by the user and the timing should be controlled by the user.
>>>
>>> This patchset did not implement the type-based reclamation as expected
>>> in the documentation.(anon or file) Because in addition to extreme unba=
lanced
>>> reclamation, this patchset can also adapt to the reclamation tendency
>>> allocated according to swappiness, which is more flexible.
>>>

--
Best Regards,
Huang, Ying

