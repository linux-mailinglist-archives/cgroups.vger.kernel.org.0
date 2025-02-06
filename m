Return-Path: <cgroups+bounces-6442-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32998A29F63
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 04:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE73A2523
	for <lists+cgroups@lfdr.de>; Thu,  6 Feb 2025 03:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C84A3B1A2;
	Thu,  6 Feb 2025 03:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WdPx9+yl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788D46BF
	for <cgroups@vger.kernel.org>; Thu,  6 Feb 2025 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738812664; cv=none; b=VrAsmNnGUfzpg56No/fj8e1x5toBq4x0yplGrhG0Wl6L8uYtL58kVGGUYoYHmJS/Bn4I3v9iTj/Gw/q/SgXg/+B+suk+CMbFeh9hCjsEcC38Fm8imowTjmj7ykRSwvMba6Tk0XxfqcOn63ikSrfLqkYIj24iJqOeMAalYu9QgJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738812664; c=relaxed/simple;
	bh=qse2BO6fn5JeMZ32HaFJkj6QdlsFwf7LW2TfUnJV/4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qA0jRl1ll82OgYzqCOAJ24cxUv3RrX7xPFxqo0F+O4dCZoXZvD+Yu5BLeWz4WSNdxYoh4Cyr0jZaStxBFQWXlEBXdXkQFEBUYe14uVbvN4DV41T56fR7Jbskmxawaf+CI1vdgnzR46UhR3HeTRnVdzFP5NZrVXlrD5L2MGa0LvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WdPx9+yl; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738812653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TbVCUPe1Kpjetdaa2IGozCJyxIGj2SBcKsrt9n290Rg=;
	b=WdPx9+yl2jzGCg+wEaOxo0PtLFTahg1WJYEyQ0kI/HcP6TaPzL5zdfVuGXiXAAVGpRXkta
	/bP/RlVgzKbfkN1aZZ3pHjXQD34vTO//vhwLbnCPZNqLh4MHtA1MwJV5kGtPsBCJ7NuuFQ
	Q0DIA07HMuhJeFwZ/XF5XGb1ki5jaQM=
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: A path forward to cleaning up dying cgroups?
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <7nqk5crpp7wi65745uiqgpvlomy3cyg3oaimaoz4fg2h4mf7jp@zclymjsovknp>
Date: Thu, 6 Feb 2025 11:30:10 +0800
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
 linux-mm@kvack.org,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Tejun Heo <tj@kernel.org>,
 =?utf-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Michal Hocko <mhocko@kernel.org>,
 Allen Pais <apais@linux.microsoft.com>,
 Yosry Ahmed <yosryahmed@google.com>
Content-Transfer-Encoding: 7bit
Message-Id: <91D2E468-B89A-4DD7-B1B0-B892FA4482E3@linux.dev>
References: <Z6OkXXYDorPrBvEQ@hm-sls2>
 <ccd67fd2-268a-4e83-9491-e401fa57229c@linux.microsoft.com>
 <20250205180842.GC1183495@cmpxchg.org>
 <7nqk5crpp7wi65745uiqgpvlomy3cyg3oaimaoz4fg2h4mf7jp@zclymjsovknp>
To: Shakeel Butt <shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Feb 6, 2025, at 02:46, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> On Wed, Feb 05, 2025 at 01:08:42PM -0500, Johannes Weiner wrote:
>> On Wed, Feb 05, 2025 at 12:50:19PM -0500, Hamza Mahfooz wrote:
>>> Cc: Shakeel Butt <shakeel.butt@linux.dev>
>>> 
>>> On 2/5/25 12:48, Hamza Mahfooz wrote:
>>>> I was just curious as to what the status of the issue described in [1]
>>>> is. It appears that the last time someone took a stab at it was in [2].
>> 
>> If memory serves, the sticking point was whether pages should indeed
>> be reparented on cgroup death, or whether they could be moved
>> arbitrarily to other cgroups that are still using them.
>> 
>> It's a bit unfortunate, because the reparenting patches were tested
>> and reviewed, and the arbitrary recharging was just an idea that
>> ttbomk nobody seriously followed up on afterwards.
>> 
>> We also recently removed the charge moving code from cgroup1, along
>> with the subtle page access/locking/accounting rules it imposed on the
>> rest of the MM. I'm doubtful there is much appetite in either camp for
>> bringing this back.
>> 
>> So I would still love to see Muchun's patches merged. They fix a
>> seemingly universally experienced operational issue in memcg, and we
>> shouldn't hold it up unless somebody actually posts alternative code.
>> 
>> Thoughts?
> 
> I think the recharging (or whatever the alternative) can be a followup
> to this. I agree this is a good change.

I agree with you. We've been encountering dying memory issues for years
on our servers. As Roman said, I need to refresh my patches. So I need
some time for refreshing.

Muchun,
Thanks.


