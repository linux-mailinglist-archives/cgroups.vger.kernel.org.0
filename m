Return-Path: <cgroups+bounces-303-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D0A7E7676
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 02:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3179BB20B89
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C9A7F1;
	Fri, 10 Nov 2023 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1SpVoq9"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096847E6;
	Fri, 10 Nov 2023 01:21:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2CA4228;
	Thu,  9 Nov 2023 17:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699579270; x=1731115270;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=oSLgzdqqUi7SDhMmhRVGvgJyNjx+NqyiNkbZfvYhL7w=;
  b=a1SpVoq9PGXDVS8WxW6cFdUwYTPuusuIEB4TkT1hFrakA+0Gb8H9KDWk
   Q8/qBYiHEVEoebYiP9QCuOSEkeUalXdyoleAJfI475EMzdc98HloQpKJz
   k6lTChnBFt91wJsD6iI+OKs2qnVMlfQcJdzcquI9bSqiOFtHyN69CrT7H
   28monfGGSj1yJUUYwqumJvgDXASHv7K5cO1W84kA9q+/mUUNxp9Dj3Nlg
   KvuNvRpbJMyeK7xeulJFpMFkwBIAD3r2nf3J8H0aC/seWnNrahra7vwvr
   Izj07sZj+phlVlsOftBthg9gQ/SvD20mYSQzRW29pB0arK4MBXd+S6sZz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="476339535"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="476339535"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:21:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="763611091"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="763611091"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 17:21:03 -0800
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
In-Reply-To: <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com> (Huan Yang's
	message of "Thu, 9 Nov 2023 18:50:36 +0800")
References: <20231108065818.19932-1-link@vivo.com>
	<ZUuV9xOZ5k7Ia_V2@tiehlicka>
	<ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
	<87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
	<ZUytB5lSwxeKkBW8@tiehlicka>
	<6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
	<ZUy2-vrqDq7URzb6@tiehlicka>
	<e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
Date: Fri, 10 Nov 2023 09:19:02 +0800
Message-ID: <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> =E5=9C=A8 2023/11/9 18:39, Michal Hocko =E5=86=99=E9=81=93:
>> [Some people who received this message don't often get email from mhocko=
@suse.com. Learn why this is important at https://aka.ms/LearnAboutSenderId=
entification ]
>>
>> On Thu 09-11-23 18:29:03, Huan Yang wrote:
>>> HI Michal Hocko,
>>>
>>> Thanks for your suggestion.
>>>
>>> =E5=9C=A8 2023/11/9 17:57, Michal Hocko =E5=86=99=E9=81=93:
>>>> [Some people who received this message don't often get email from mhoc=
ko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSender=
Identification ]
>>>>
>>>> On Thu 09-11-23 11:38:56, Huan Yang wrote:
>>>> [...]
>>>>>> If so, is it better only to reclaim private anonymous pages explicit=
ly?
>>>>> Yes, in practice, we only proactively compress anonymous pages and do=
 not
>>>>> want to touch file pages.
>>>> If that is the case and this is mostly application centric (which you
>>>> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
>>>> instead.
>>> Madvise  may not be applicable in this scenario.(IMO)
>>>
>>> This feature is aimed at a core goal, which is to compress the anonymous
>>> pages
>>> of frozen applications.
>>>
>>> How to detect that an application is frozen and determine which pages c=
an be
>>> safely reclaimed is the responsibility of the policy part.
>>>
>>> Setting madvise for an application is an active behavior, while the abo=
ve
>>> policy
>>> is a passive approach.(If I misunderstood, please let me know if there =
is a
>>> better
>>> way to set madvise.)
>> You are proposing an extension to the pro-active reclaim interface so
>> this is an active behavior pretty much by definition. So I am really not
>> following you here. Your agent can simply scan the address space of the
>> application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOUT)
>> on the private memory is that is really what you want/need.
> There is a key point here. We want to use the grouping policy of memcg
> to perform
> proactive reclamation with certain tendencies. Your suggestion is to
> reclaim memory
> by scanning the task process space. However, in the mobile field,
> memory is usually
> viewed at the granularity of an APP.
>
> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
> according
> to the pre-grouped APP processes.
>
> Of course, as you suggested, madvise can also achieve this, but
> implementing it in
> the agent may be more complex.(In terms of achieving the same goal,
> using memcg
> to group all the processes of an APP and perform proactive reclamation
> is simpler
> than using madvise and scanning multiple processes of an application
> using an agent?)

I still think that it's not too complex to use process_madvise() to do
this.  For each process of the application, the agent can read
/proc/PID/maps to get all anonymous address ranges, then call
process_madvise(MADV_PAGEOUT) to reclaim pages.  This can even filter
out shared anonymous pages.  Does this work for you?

--
Best Regards,
Huang, Ying

