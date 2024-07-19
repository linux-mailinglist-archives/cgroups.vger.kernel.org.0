Return-Path: <cgroups+bounces-3788-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A3A9372B8
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 05:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFAFB28269C
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 03:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF63168D0;
	Fri, 19 Jul 2024 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWh3Tojt"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49F10A09
	for <cgroups@vger.kernel.org>; Fri, 19 Jul 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721359424; cv=none; b=adpkn35tyoaq74mk8JwPnh/pNCEK20TE1FwUMufxhM7z8/695zaK7nuJtRLzm3bVqyCuhWOrI6QVzcsnBOd5SljDX30ozJCkwUso5bo5JLdvZX/x3ZoQ0/dMtlkMdYSEVoudCQq8Hq7h+r28Oe6o81YQeKAaqyTfSOPmeodBru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721359424; c=relaxed/simple;
	bh=LzYtUaIzvRbkHQvbn06to4re3EBwEBR0G3sdQDN5Hq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RatAPuXXSWppoNjMr4E+kft1fYt6EWKAB4R6eJaSg9iyVN7HmzS1j9q0e60O67xw9UgYkN2pCodewiG3H3/7+7xAzXuMf7v0AzIWAfSoI+4Gsn4ZydRl+TLhUdifwii1EG2Utqvi94b3RiMc3gamP9wQhYGEzv+TjXQyAsiWyDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWh3Tojt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721359421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4g/2by4UFmJt1nLIIzaKlS2HPKjw7tCpSzx5XVWX0GE=;
	b=UWh3Tojtet9EbrziMb7JJdHUFv+p6SDLevcXUZUeAA/SZc8phEdHAWs5VxzcvVNNX99wHF
	Bb4PK1cxxMHnil9o/x0OmDm8KywpvLvA2XQ1hjd2+fcQVpDfb6phrEcbbLh1fJvcEE1Ke5
	25adrJoetq/O/bP0lZp0NhrfOe8y0Wk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-QO0slx50PEa2lPJEq-XW8w-1; Thu,
 18 Jul 2024 23:23:35 -0400
X-MC-Unique: QO0slx50PEa2lPJEq-XW8w-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9E6561955F43;
	Fri, 19 Jul 2024 03:23:32 +0000 (UTC)
Received: from [10.22.32.50] (unknown [10.22.32.50])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0C698195605A;
	Fri, 19 Jul 2024 03:23:28 +0000 (UTC)
Message-ID: <fcb8f0ec-59ff-4f79-82dd-7eaf2530aef3@redhat.com>
Date: Thu, 18 Jul 2024 23:23:28 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: David Finkel <davidf@vimeo.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com> <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org> <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OkHp3fYjByCnXJQ51rog93DsimSoc1qxcU7UyKw-nFrw@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAFUnj5OkHp3fYjByCnXJQ51rog93DsimSoc1qxcU7UyKw-nFrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40


On 7/18/24 17:49, David Finkel wrote:
> I spent some time today attempting to implement this.
> Here's a branch on github that compiles, and I think is close to what you
> described, but is definitely still a WIP:
>
> https://github.com/torvalds/linux/compare/master...dfinkel:linux:memcg2_memory_peak_fd_session
>
> Since there seems to be significant agreement that this approach is better
> long-term as a kernel interface, if that continues, I can factor out some of
> the changes so it supports both memory.peak and memory.swap.peak,
> fix the tests, and clean up any style issues tomorrow.
>
> Also, If there are opinions on whether the cgroup_lock is a reasonable way
> of handling this synchronization, or if I should add a more appropriate spinlock
> or mutex onto either the pagecounter or the memcg, I'm all ears.

cgroup_lock() should only be used by the cgroup core code, though there 
are exceptions.

You may or may not need lock protection depending on what data you want 
to protect and if there is any chance that concurrent race may screw 
thing up. If lock protection is really needed, add your own lock to 
protect the data. Since your critical sections seem to be pretty short, 
a regular spinlock will be enough.

Cheers,
Longman


