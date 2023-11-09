Return-Path: <cgroups+bounces-264-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B37E628A
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 04:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37121281286
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 03:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E35257;
	Thu,  9 Nov 2023 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G8CV9cbD"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7DB53A5;
	Thu,  9 Nov 2023 03:18:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F01BE6;
	Wed,  8 Nov 2023 19:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699499879; x=1731035879;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ynC47GQwYlSIUpMUpstR+O3T0lqTMuFurlbi3ahjlAw=;
  b=G8CV9cbDessHvGfJqmxoTmzdGMkGSUitbV7A7XMUGupc9VWYZtoL3Avc
   KCgIkzFpgnzMmOq6TtZeWRue4tTWBpdzYoAxhzVmjkA8GP3xInh3Eh7iq
   nFD8JzWxJDb7up8N4NbpOUOgaiTbQKdn7/zljOSZH/C9/SKiQOAwzTtfA
   uwlpDHiHrMMuCcx5kwdaM5DQLTEwKucHhMVSw5PBFbvh/lsoyC/KYk6bz
   Z8n7tkYjGAf3NTBB6sbZww5/6qbCreViYYoqy0787Uq4VWr9oHIGWh5fJ
   BNAkd9OjxfoEZu60PTKQNnIJMzqz29BjB8nSIipl1w2B0+WGcL9ag6hfo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="421007291"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="421007291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 19:17:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="936715642"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="936715642"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 19:17:53 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Huan Yang <link@vivo.com>
Cc: Michal Hocko <mhocko@suse.com>,  Tejun Heo <tj@kernel.org>,  Zefan Li
 <lizefan.x@bytedance.com>,  "Johannes Weiner" <hannes@cmpxchg.org>,
  Jonathan Corbet <corbet@lwn.net>,  "Roman Gushchin"
 <roman.gushchin@linux.dev>,  Shakeel Butt <shakeelb@google.com>,  Muchun
 Song <muchun.song@linux.dev>,  Andrew Morton <akpm@linux-foundation.org>,
  David Hildenbrand <david@redhat.com>,  "Matthew Wilcox"
 <willy@infradead.org>,  "Kefeng Wang" <wangkefeng.wang@huawei.com>,  Peter
 Xu <peterx@redhat.com>,  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
  Yosry Ahmed <yosryahmed@google.com>,  Liu Shixin <liushixin2@huawei.com>,
  Hugh Dickins <hughd@google.com>,  <cgroups@vger.kernel.org>,
  <linux-doc@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
In-Reply-To: <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com> (Huan Yang's
	message of "Thu, 9 Nov 2023 09:56:46 +0800")
References: <20231108065818.19932-1-link@vivo.com>
	<ZUuV9xOZ5k7Ia_V2@tiehlicka>
	<ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
Date: Thu, 09 Nov 2023 11:15:52 +0800
Message-ID: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> =E5=9C=A8 2023/11/8 22:06, Michal Hocko =E5=86=99=E9=81=93:
>> [Some people who received this message don't often get email from mhocko=
@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification ]
>>
>> On Wed 08-11-23 14:58:11, Huan Yang wrote:
>>> In some cases, we need to selectively reclaim file pages or anonymous
>>> pages in an unbalanced manner.
>>>
>>> For example, when an application is pushed to the background and frozen,
>>> it may not be opened for a long time, and we can safely reclaim the
>>> application's anonymous pages, but we do not want to touch the file pag=
es.
>> Could you explain why? And also why do you need to swap out in that
>> case?
> When an application is frozen, it usually means that we predict that
> it will not be
> used for a long time. In order to proactively save some memory, our
> strategy will
> choose to compress the application's private data into zram. And we
> will also
> select some of the cold application data that we think is in zram and
> swap it out.
>
> The above operations assume that anonymous pages are private to the
> application.

If so, is it better only to reclaim private anonymous pages explicitly?
Add another option for that?

> After the application is frozen, compressing these pages into zram can
> save memory
> to some extent without worrying about frequent refaults.
>
> And the cost of refaults on zram is lower than that of IO.

If so, swappiness should be high system-wise?

--
Best Regards,
Huang, Ying

>
>>
>>> This patchset extends the proactive reclaim interface to achieve
>>> unbalanced reclamation. Users can control the reclamation tendency by
>>> inputting swappiness under the original interface. Specifically, users
>>> can input special values to extremely reclaim specific pages.
>> Other have already touched on this in other replies but v2 doesn't have
>> a per-memcg swappiness
>>
>>> Example:
>>>        echo "1G" 200 > memory.reclaim (only reclaim anon)
>>>          echo "1G" 0  > memory.reclaim (only reclaim file)
>>>          echo "1G" 1  > memory.reclaim (only reclaim file)
>>>
>>> Note that when performing unbalanced reclamation, the cgroup swappiness
>>> will be temporarily adjusted dynamically to the input value. Therefore,
>>> if the cgroup swappiness is further modified during runtime, there may
>>> be some errors.
>> In general this is a bad semantic. The operation shouldn't have side
>> effect that are potentially visible for another operation.
> So, maybe pass swappiness into sc and keep a single reclamation ensure th=
at
> swappiness is not changed?
> Or, it's a bad idea that use swappiness to control unbalance reclaim.
>> --
>> Michal Hocko
>> SUSE Labs

