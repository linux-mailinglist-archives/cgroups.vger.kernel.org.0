Return-Path: <cgroups+bounces-12487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EF9CCB152
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50FF2301512C
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6C2FB632;
	Thu, 18 Dec 2025 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmNczh+k"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F192EB84E;
	Thu, 18 Dec 2025 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049068; cv=none; b=GKd7QlC1BZxxWsuY1jyMxmXBzZuWNbAeMYarPH7dbSqeMqycgC5vzmcXN/+DxhlPiBZd2MI9Qwcw9cPQaI2ktyy6+2dqb7Im2Hh/hypfI94MJq394rKQfMhOBlPYEOW9wr2coHiVobGvC5Xc2bUoGVLUSJkhsM6HPLyCVFIxpxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049068; c=relaxed/simple;
	bh=m6maDrxugfkeNLKycZHBYmyqUqhUOYOT2Iqymt3Cj9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ixcpOVk47XUhaswrQ7jPjlI0mzudHYMAcbX3/FcHOEUzltsvfG3T8vaMZLmPafxFGSQtsCwghqz+/zfk2Sejym9J24OV4fz6y7UnYzERkUxlWLm7q6JYi/H67eFO4vw/1e+O0Ls+63mVtKN18lsPr5MUn3xb2JK5vPfAMQFkQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmNczh+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB33CC4CEFB;
	Thu, 18 Dec 2025 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766049066;
	bh=m6maDrxugfkeNLKycZHBYmyqUqhUOYOT2Iqymt3Cj9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OmNczh+k7Da92qoJ93NeWV1genL1oEJUEO12ITMlEoc1P+3ATqHCpBDJh2vKz4MYz
	 JcrDdPzFzXoY5Hz3kj7oWEHWUO7d0VeOP8e/QcS58ouVcLE+0Xi1e2hK1ZqZMnsplR
	 GwY0F/lrXnCBOuc5KdGOwPHXT+Yn8AAmbBWiZUd0OA7Y46stI+X4ZBaNKNTi31AFbB
	 CtUc0ae39TdcjcQVz9aZnRy1nl/fOFnPOvfI0RFfaah2LgxnK5rR4zMDTa9tHhFAek
	 IrxkC33jw4gIJnQ2uLNOSgrc3PUEjl+ut8o2x3KqAla6AlXhT6xVacsxzWj73LYMMf
	 nzyJEqvkh6BYg==
Message-ID: <2e153b06-e541-41de-9b5d-7869dc2aba72@kernel.org>
Date: Thu, 18 Dec 2025 10:10:58 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/28] mm: thp: prevent memory cgroup release in
 folio_split_queue_lock{_irqsave}()
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <4cb81ea06298a3b41873b7086bfc68f64b2ba8be.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 08:27, Qi Zheng wrote:
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> In the near future, a folio will no longer pin its corresponding memory
> cgroup. To ensure safety, it will only be appropriate to hold the rcu read
> lock or acquire a reference to the memory cgroup returned by
> folio_memcg(), thereby preventing it from being released.
> 
> In the current patch, the rcu read lock is employed to safeguard against
> the release of the memory cgroup in folio_split_queue_lock{_irqsave}().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---

Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>

-- 
Cheers

David

