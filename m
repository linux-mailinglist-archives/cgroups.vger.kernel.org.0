Return-Path: <cgroups+bounces-2885-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D138C59E2
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 18:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06993B21553
	for <lists+cgroups@lfdr.de>; Tue, 14 May 2024 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED92B17F389;
	Tue, 14 May 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE9YQJq5"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494F158213
	for <cgroups@vger.kernel.org>; Tue, 14 May 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705301; cv=none; b=Gi1tMB/YwDa7CXk3RuLoIiQlNS3aZYtvOQUZNFXFLjsgOcr+8zvQbPWvDmBj/AwaZemVBjkVeG+0DwYEbkX/c1wlGIdzWV2or+OcpIy387hbyPzMZIlBdgZRNFJ8v3+wM4hTvrfZ2H6dvri/u8+DT97A5rSp1ORONpD7iYukGLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705301; c=relaxed/simple;
	bh=ordsi/vf7xq5Mpx0wPQqakHQgTmZ+T7L0Wq0WkySFGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nYYbMFrStVusx1ZGGmJCC5YrqJgiMCsSfi/aH9RKUCc0eHG3SYBWFZW0dEKzYCpG7CFm5k5ASo0kVcVY/ADGMUyo2Q6dV6pw+k+7L4xfUjhQp2IWk6BtwkQr8BkeQmGSK41+kmIM9bpPiYkbNzzE+t0jnnJNZyowQhC3IQCZx0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE9YQJq5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715705299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3yPKE/w5eUj9cE5mu0i5vJKgEGLHkvzbGLmCvqOXubs=;
	b=JE9YQJq5jKHsiMO2p2++/6izpeYZHEn4Of6gC2y3v7WedjLyAZuot/eU2k53v78rp6g99C
	F86gQfzFUDru3U9o3vLfQgN4fSXd34/OBJe8MoYtuHM8dXLKywxlev5llmd44/AsN8MhyW
	Q4LUc2gaUKfcH53wo4wJSCHtosXgWK8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-zuLSYt1OPHG168KNbQHKJg-1; Tue,
 14 May 2024 12:48:03 -0400
X-MC-Unique: zuLSYt1OPHG168KNbQHKJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8D7338000A0;
	Tue, 14 May 2024 16:48:02 +0000 (UTC)
Received: from [10.22.34.104] (unknown [10.22.34.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0F6E040228A0;
	Tue, 14 May 2024 16:48:00 +0000 (UTC)
Message-ID: <911ca229-4849-4fd2-8ae8-5ca653d8a5e3@redhat.com>
Date: Tue, 14 May 2024 12:47:59 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] cgroup/cpuset: optimize
 cpuset_mems_allowed_intersects()
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Imran Khan <imran.f.khan@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Peter Zijlstra <peterz@infradead.org>, Rik van Riel <riel@surriel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20240513220146.1461457-1-yury.norov@gmail.com>
 <20240513220146.1461457-6-yury.norov@gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240513220146.1461457-6-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2


On 5/13/24 18:01, Yury Norov wrote:
> If the function is called with tsk1 == tsk2, we know for sure that their
> mems_allowed nodes do intersect, and so we can return immediately instead
> of checking the nodes content.
>
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>   kernel/cgroup/cpuset.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 4237c8748715..47ed206d4890 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -5010,6 +5010,9 @@ EXPORT_SYMBOL_GPL(cpuset_mem_spread_node);
>   int cpuset_mems_allowed_intersects(const struct task_struct *tsk1,
>   				   const struct task_struct *tsk2)
>   {
> +	if (tsk1 == tsk2)
> +		return 1;
> +
>   	return nodes_intersects(tsk1->mems_allowed, tsk2->mems_allowed);
>   }
>   
Reviewed-by: Waiman Long <longman@redhat.com>


