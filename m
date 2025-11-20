Return-Path: <cgroups+bounces-12130-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1B8C74640
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 14:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8DCD4FAC29
	for <lists+cgroups@lfdr.de>; Thu, 20 Nov 2025 13:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EFB341076;
	Thu, 20 Nov 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MRYO20LC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708A934107C
	for <cgroups@vger.kernel.org>; Thu, 20 Nov 2025 13:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763646101; cv=none; b=FUYJDGaj1DHORmNPO7ntOdnHVvaYh+Mycp9egv3Fecle5lGcW+oK7RbJCxfdMTDaPEUJ5jYLQ5pyHB5gqn9HcWyj/H+4mg4Ph0c5JilB1dNVPhAvfvyBut9QhE0z0/ktSR+xy+/uf5tzThWTyWEghgWaXkZc31Jo8wGBYCBXNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763646101; c=relaxed/simple;
	bh=rpGbnRiA/SFZ982PFn/ZGwKYtq6o194ofin/OxpEpY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjvxBAndBx6wQcgZbX3dO8+fMlqnH6IXZ5yKGq9DuGaf7vAm3SEedp4MvEosG/zyXrp5po4o9z6XQUxUoUBNzmrKpHD++YmGBPwX2adOaxik27ABjFigsW8cOhLkqADFjZtEfyATD1XMjFQ7J+5EZCHZXGt0JxG4pXQKEwQPx34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MRYO20LC; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fa71b2bf-e08e-4991-a821-51c6f40e9a90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763646086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiUwXuDwPsPo8P/JiH7Rc6iuaehlzYW3mvFReb61JcA=;
	b=MRYO20LC5Fn8ysYUK9k9irRH7GumJAbF7J9zObagPMYZVTcIKzaUpwAffATPRR0rSEby4B
	ohC0GJrFXrjXJIGTa6kWudW9h2GgghJHUJxrANhQg/E1dpccoCFh0uDl0mIVpojt7IGyP/
	6ZoSQQZNHbd7kPNULpfCrJ+wb9McQQk=
Date: Thu, 20 Nov 2025 21:41:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 19/26] mm: swap: prevent lruvec release in swap module
To: Harry Yoo <harry.yoo@oracle.com>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@redhat.com, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <c8b190b1b4f2690f12dee0e334e4c0b3f94ad260.1761658311.git.zhengqi.arch@bytedance.com>
 <aR7k8oFb_uZYj5bj@hyeyoo>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <aR7k8oFb_uZYj5bj@hyeyoo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/20/25 5:52 PM, Harry Yoo wrote:
> On Tue, Oct 28, 2025 at 09:58:32PM +0800, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> In the near future, a folio will no longer pin its corresponding
>> memory cgroup. So an lruvec returned by folio_lruvec() could be
>> released without the rcu read lock or a reference to its memory
>> cgroup.
>>
>> In the current patch, the rcu read lock is employed to safeguard
>> against the release of the lruvec in lru_note_cost_refault() and
>> lru_activate().
> 
> nit: the above paragraph looks incorrect.

Right, will fix it in the version.

> 
>> This serves as a preparatory measure for the reparenting of the
>> LRU pages.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Thanks!

> 


