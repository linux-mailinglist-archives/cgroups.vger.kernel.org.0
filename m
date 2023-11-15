Return-Path: <cgroups+bounces-423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD367EBD42
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 07:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B4B20B36
	for <lists+cgroups@lfdr.de>; Wed, 15 Nov 2023 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51693D6C;
	Wed, 15 Nov 2023 06:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LDXbTERB"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131B43D6E;
	Wed, 15 Nov 2023 06:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76724C3;
	Tue, 14 Nov 2023 22:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700031274; x=1731567274;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=KQs4vJm/jx2KWNtm77V1LxYhHIJm4bwsu8GghKrRV7U=;
  b=LDXbTERBhNd6gGCSXh8Td0IWAYYwfaYaabwC3dhgoz/UKJkD7RddGWk2
   Xa/tcJYLhUHHlnub+BRDO0614CBoVTXHtzwB4FNw9AcPeg6g0xqODodM9
   jjvTnUfmrI3TKWwrsPEawPXoSFicPjqN0j6pS4TzfokjWixZp2ngRn74s
   Yob6uU/vHGqGlHDtJI9VKpfJGm3Imcuw3+qkRvE2InmN2JZJUMge9SCoX
   p3OulI+HWFL/WPJJiKMOdUhJz+3DP9WcU5jDkCES1AWih3SV1rYOxf3xQ
   29fdvgSogEw3sHQg5VwhHiWwtzNAMq8eoUmUuWxSbQXJa5N8RGuZL3Uzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="3937280"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="3937280"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 22:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="6048782"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 22:54:26 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Huan Yang <link@vivo.com>
Cc: Michal Hocko <mhocko@suse.com>,  Tejun Heo <tj@kernel.org>,  Zefan Li
 <lizefan.x@bytedance.com>,  Johannes Weiner <hannes@cmpxchg.org>,
  "Jonathan Corbet" <corbet@lwn.net>,  Roman Gushchin
 <roman.gushchin@linux.dev>,  "Shakeel Butt" <shakeelb@google.com>,  Muchun
 Song <muchun.song@linux.dev>,  "Andrew Morton"
 <akpm@linux-foundation.org>,  David Hildenbrand <david@redhat.com>,
  Matthew Wilcox <willy@infradead.org>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Peter Xu <peterx@redhat.com>,  "Vishal
 Moola (Oracle)" <vishal.moola@gmail.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  "Liu Shixin" <liushixin2@huawei.com>,  Hugh
 Dickins <hughd@google.com>,  <cgroups@vger.kernel.org>,
  <linux-doc@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
In-Reply-To: <97a3dbb3-9e73-4dcc-877d-f491ff47363b@vivo.com> (Huan Yang's
	message of "Mon, 13 Nov 2023 16:26:00 +0800")
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
	<ZUytB5lSwxeKkBW8@tiehlicka>
	<6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
	<ZUy2-vrqDq7URzb6@tiehlicka>
	<e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
	<ZUzTVgK_i05uiHiB@tiehlicka>
	<e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
	<ZUziy-6QPdTIDJlm@tiehlicka>
	<f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
	<ZU4g9XZvi9mRQD27@tiehlicka>
	<b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
	<87edgufakm.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<a09e21a6-6a1e-44ec-9187-600a0a969a45@vivo.com>
	<87a5rif58s.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<97a3dbb3-9e73-4dcc-877d-f491ff47363b@vivo.com>
Date: Wed, 15 Nov 2023 14:52:24 +0800
Message-ID: <87jzqjecev.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> =E5=9C=A8 2023/11/13 16:05, Huang, Ying =E5=86=99=E9=81=93:
>> Huan Yang <link@vivo.com> writes:
>>
>>> =E5=9C=A8 2023/11/13 14:10, Huang, Ying =E5=86=99=E9=81=93:
>>>> Huan Yang <link@vivo.com> writes:
>>>>
>>>>> =E5=9C=A8 2023/11/10 20:24, Michal Hocko =E5=86=99=E9=81=93:
>>>>>> On Fri 10-11-23 11:48:49, Huan Yang wrote:
>>>>>> [...]
>>>>>>> Also, When the application enters the foreground, the startup speed
>>>>>>> may be slower. Also trace show that here are a lot of block I/O.
>>>>>>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>>>>>>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>>>>>>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>>>>>>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I chang=
e a
>>>>>>> little to test UFS.
>>>>>>>
>>>>>>> Therefore, if the proactive reclamation encounters many file pages,
>>>>>>> the application may become slow when it is opened.
>>>>>> OK, this is an interesting information. From the above it seems that
>>>>>> storage based IO refaults are order of magnitude more expensive than
>>>>>> swap (zram in this case). That means that the memory reclaim should
>>>>>> _in general_ prefer anonymous memory reclaim over refaulted page cac=
he,
>>>>>> right? Or is there any reason why "frozen" applications are any
>>>>>> different in this case?
>>>>> Frozen applications mean that the application process is no longer ac=
tive,
>>>>> so once its private anonymous page data is swapped out, the anonymous
>>>>> pages will not be refaulted until the application becomes active agai=
n.
>>>>>
>>>>> On the contrary, page caches are usually shared. Even if the
>>>>> application that
>>>>> first read the file is no longer active, other processes may still
>>>>> read the file.
>>>>> Therefore, it is not reasonable to use the proactive reclamation
>>>>> interface to
>>>>> reclaim=C2=A0page caches without considering memory pressure.
>>>> No.  Not all page caches are shared.  For example, the page caches used
>>>> for use-once streaming IO.  And, they should be reclaimed firstly.
>>> Yes, but this part is done very well in MGLRU and does not require our
>>> intervention.
>>> Moreover, the reclaim speed of clean files is very fast, but compared t=
o it,
>>> the reclaim speed of anonymous pages is a bit slower.
>>>> So, your solution may work good for your specific use cases, but it's
>>> Yes, this approach is not universal.
>>>> not a general solution.  Per my understanding, you want to reclaim only
>>>> private pages to avoid impact the performance of other applications.
>>>> Privately mapped anonymous pages is easy to be identified (And I sugge=
st
>>>> that you can find a way to avoid reclaim shared mapped anonymous pages=
).
>>> Yes, it is not good to reclaim shared anonymous pages, and it needs to =
be
>>> identified. In the future, we will consider how to filter them.
>>> Thanks.
>>>> There's some heuristics to identify use-once page caches in reclaiming
>>>> code.  Why doesn't it work for your situation?
>>> As mentioned above, the default reclaim algorithm is suitable for recyc=
ling
>>> file pages, but we do not need to intervene in it.
>>> Direct reclaim or kswapd of these use-once file pages is very fast and =
will
>>> not cause lag or other effects.
>>> Our overall goal is to actively and reasonably compress unused anonymous
>>> pages based on certain strategies, in order to increase available memor=
y to
>>> a certain extent, avoid lag, and prevent applications from being killed.
>>> Therefore, using the proactive reclaim interface, combined with LRU
>>> algorithm
>>> and reclaim tendencies, is a good way to achieve our goal.
>> If so, why can't you just use the proactive reclaim with some large
>> enough swappiness?  That will reclaim use-once page caches and compress
> This works very well for proactive memory reclaim that is only
> executed once.
> However, considering that we need to perform proactive reclaim in batches,
> suppose that only 5% of the use-once page cache in this memcg can be
> reclaimed,
> but we need to call proactive memory reclaim step by step, such as 5%,
> 10%, 15% ... 100%.
> Then, the page cache may be reclaimed due to the balancing adjustment
> of reclamation,
> even if the 5% of use-once pages are reclaimed. We may still touch on
> shared file pages.
> (If I misunderstood anything, please correct me.)

If the proactive reclaim amount is less than the size of anonymous
pages, I think that you are safe.  For example, if the size of anonymous
pages is 100MB, the size of use-once file pages is 10MB, the size of
shared file pages is 20MB.  Then if you reclaim 100MB proactively with
swappiness=3D200, you will reclaim 10MB use-once file pages and 90MB
anonymous pages.  In the next time, if you reclaim 10MB proactively, you
will still not reclaim shared file pages.

> We previously used the two values of modifying swappiness to 200 and 0
> to adjust reclaim
> tendencies. However, the debug interface showed that some file pages
> were reclaimed,
> and after being actively reclaimed, some applications and the reopened
> applications that were
> reclaimed had some block IO and startup lag.

If so, please research why use-once file page heuristics not work and
try to fix it or raise the issue.

> This way of having incomplete control over the process maybe is not
> suitable for proactive memory
> reclaim. Instead, with an proactive reclaim interface with tendencies,
> we can issue a
> 5% page cache trim once and then gradually reclaim anonymous pages.
>> anonymous pages.  So, more applications can be kept in memory before
>> passive reclaiming or killing background applications?

--
Best Regards,
Huang, Ying

