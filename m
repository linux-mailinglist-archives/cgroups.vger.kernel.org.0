Return-Path: <cgroups+bounces-349-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A66347E9754
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 09:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1265FB209CC
	for <lists+cgroups@lfdr.de>; Mon, 13 Nov 2023 08:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D015ADC;
	Mon, 13 Nov 2023 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ENLLO7xc"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3404F15ACF;
	Mon, 13 Nov 2023 08:07:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E0110F4;
	Mon, 13 Nov 2023 00:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699862846; x=1731398846;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Gz1jc3j/vUIQC1LcsowIbxsUZ+JEI4/ZUHS7gaVZnYI=;
  b=ENLLO7xcDgesBWWZYQXsMwMJ1DDXtc9OsLFX+M4DCptab7zkPMW5xb3j
   iitHTeP8T4KTHU3xvdvx/A2V1N0NiiM6aIauuAUJe90zWq6BnRg43nPjz
   e0iaAOI+ZBvQFMbDBuxMSuvvXJuiZQ27V23WYCOs2MxfxkVn2a+wHrSa9
   yR9T+Ay5suFhKPsa1Y7le2PXdM7xhVdkzuRj8HfNNmZpQt3C4j4Tvxf9w
   Ik/D6Ii+Cm6CMfCKkn60btlzKTDVpRtnSy/5Ms5qTuhRBSwAmhXlOmwRp
   s0fPFYjh1YI544Vko++VSW1RibUUtOHHolXjRUQTlKeFFIrWU2p5D3eUt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9039191"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="9039191"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="740698058"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="740698058"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 00:07:09 -0800
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
In-Reply-To: <a09e21a6-6a1e-44ec-9187-600a0a969a45@vivo.com> (Huan Yang's
	message of "Mon, 13 Nov 2023 14:28:20 +0800")
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
Date: Mon, 13 Nov 2023 16:05:07 +0800
Message-ID: <87a5rif58s.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> =E5=9C=A8 2023/11/13 14:10, Huang, Ying =E5=86=99=E9=81=93:
>> Huan Yang <link@vivo.com> writes:
>>
>>> =E5=9C=A8 2023/11/10 20:24, Michal Hocko =E5=86=99=E9=81=93:
>>>> On Fri 10-11-23 11:48:49, Huan Yang wrote:
>>>> [...]
>>>>> Also, When the application enters the foreground, the startup speed
>>>>> may be slower. Also trace show that here are a lot of block I/O.
>>>>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>>>>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>>>>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>>>>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
>>>>> little to test UFS.
>>>>>
>>>>> Therefore, if the proactive reclamation encounters many file pages,
>>>>> the application may become slow when it is opened.
>>>> OK, this is an interesting information. From the above it seems that
>>>> storage based IO refaults are order of magnitude more expensive than
>>>> swap (zram in this case). That means that the memory reclaim should
>>>> _in general_ prefer anonymous memory reclaim over refaulted page cache,
>>>> right? Or is there any reason why "frozen" applications are any
>>>> different in this case?
>>> Frozen applications mean that the application process is no longer acti=
ve,
>>> so once its private anonymous page data is swapped out, the anonymous
>>> pages will not be refaulted until the application becomes active again.
>>>
>>> On the contrary, page caches are usually shared. Even if the
>>> application that
>>> first read the file is no longer active, other processes may still
>>> read the file.
>>> Therefore, it is not reasonable to use the proactive reclamation
>>> interface to
>>> reclaim=C2=A0page caches without considering memory pressure.
>> No.  Not all page caches are shared.  For example, the page caches used
>> for use-once streaming IO.  And, they should be reclaimed firstly.
> Yes, but this part is done very well in MGLRU and does not require our
> intervention.
> Moreover, the reclaim speed of clean files is very fast, but compared to =
it,
> the reclaim speed of anonymous pages is a bit slower.
>>
>> So, your solution may work good for your specific use cases, but it's
> Yes, this approach is not universal.
>> not a general solution.  Per my understanding, you want to reclaim only
>> private pages to avoid impact the performance of other applications.
>> Privately mapped anonymous pages is easy to be identified (And I suggest
>> that you can find a way to avoid reclaim shared mapped anonymous pages).
> Yes, it is not good to reclaim shared anonymous pages, and it needs to be
> identified. In the future, we will consider how to filter them.
> Thanks.
>> There's some heuristics to identify use-once page caches in reclaiming
>> code.  Why doesn't it work for your situation?
> As mentioned above, the default reclaim algorithm is suitable for recycli=
ng
> file pages, but we do not need to intervene in it.
> Direct reclaim or kswapd of these use-once file pages is very fast and wi=
ll
> not cause lag or other effects.
> Our overall goal is to actively and reasonably compress unused anonymous
> pages based on certain strategies, in order to increase available memory =
to
> a certain extent, avoid lag, and prevent applications from being killed.
> Therefore, using the proactive reclaim interface, combined with LRU
> algorithm
> and reclaim tendencies, is a good way to achieve our goal.

If so, why can't you just use the proactive reclaim with some large
enough swappiness?  That will reclaim use-once page caches and compress
anonymous pages.  So, more applications can be kept in memory before
passive reclaiming or killing background applications?

--
Best Regards,
Huang, Ying

