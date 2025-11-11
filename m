Return-Path: <cgroups+bounces-11829-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D5C4F8FE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7B574FAFAE
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 19:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958AD2E6CB8;
	Tue, 11 Nov 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BK+z0/Gw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9668E2E7641
	for <cgroups@vger.kernel.org>; Tue, 11 Nov 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888406; cv=none; b=tY9uUBeoeUYf1t91PO8mqyHnVNMVGsUCzqTLZyEkiR0BU0YNvgLEaTqYxeVUOQmGDIzifW6lHS3xrHfyZHUOYwPjn6HtPZ9ODV8yCZzs8CnUUSAkQVVwh9bBYITidlY4a6wG1e9be/VvmV7nAWqvJ7XzB/UCJL4KE9HkAvTQL6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888406; c=relaxed/simple;
	bh=2GOc/f+MZYJh7MJNPngu+YOeG3qkWI4rcxeCs4gXmtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NBr7jf+Ct5dmwTEf0/dp1lR7I5e59Ii11iAkOrCn7pczrS/3seLaGqrHqNyAbTLT50YrfUOmFPhZ7lfPfD2WxJlbO/pd1RUzhwhWVKFvktDhug4Q+ZXPLT8srGlTDx4S/8HRVp4yOVgz1wMpJUskGSeUHP2KIwLLcjeWXwOu1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BK+z0/Gw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762888391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WAMF5Kieve7eLi0CA1Q7SiwB8XtOEdddDh5a5e2G5pM=;
	b=BK+z0/GwfZFWc92LGrJKHMQiWjt8FetZh6gz9F7Q3nigg37iUGQkMuedZ0rPT2Gs1ppbzb
	W95ukc8Q++q9Y/TmKv2Gbi490gsoalmrdY0sSLJhEoUJRa777q+YEA8iwwAVuqcwuBu3b/
	81SxkJdLw2+ynMuB7sJquE7X9LFbQzs=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,  bpf@vger.kernel.org,
  Martin KaFai Lau <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,
  Kumar Kartikeya Dwivedi <memxor@gmail.com>,  Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 13/23] mm: introduce bpf_out_of_memory() BPF kfunc
In-Reply-To: <aRG0ZyL93jWm4TAa@tiehlicka> (Michal Hocko's message of "Mon, 10
	Nov 2025 10:46:15 +0100")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-3-roman.gushchin@linux.dev>
	<aRG0ZyL93jWm4TAa@tiehlicka>
Date: Tue, 11 Nov 2025 11:13:04 -0800
Message-ID: <87qzu4pem7.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Mon 27-10-25 16:21:56, Roman Gushchin wrote:
>> Introduce bpf_out_of_memory() bpf kfunc, which allows to declare
>> an out of memory events and trigger the corresponding kernel OOM
>> handling mechanism.
>> 
>> It takes a trusted memcg pointer (or NULL for system-wide OOMs)
>> as an argument, as well as the page order.
>> 
>> If the BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK flag is not set, only one OOM
>> can be declared and handled in the system at once, so if the function
>> is called in parallel to another OOM handling, it bails out with -EBUSY.
>> This mode is suited for global OOM's: any concurrent OOMs will likely
>> do the job and release some memory. In a blocking mode (which is
>> suited for memcg OOMs) the execution will wait on the oom_lock mutex.
>
> Rather than relying on BPF_OOM_FLAGS_WAIT_ON_OOM_LOCK would it make
> sense to take the oom_lock based on the oc->memcg so that this is
> completely transparent to specific oom bpf handlers?

Idk, I don't have a super-strong opinion here, but giving the user the
flexibility seems to be more future-proof. E.g. if we split oom lock
so that we can have competing OOMs in different parts of the memcg tree,
will we change the behavior?

