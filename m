Return-Path: <cgroups+bounces-11402-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 650FBC1D310
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 21:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3376B4E03F8
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 20:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A335BDD4;
	Wed, 29 Oct 2025 20:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gbNivlUO"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F496358D3A
	for <cgroups@vger.kernel.org>; Wed, 29 Oct 2025 20:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761769577; cv=none; b=p3drar9sS+TNqOUjuWsglsIGsDnADP7NOkSxoBw5V5lWtfUjiiygeyGE08Y2H9ciIQmnt/qldorSwzqwR6hXuONV4TV37zD1L5m6LV4H9SrNGapX0pL19xfyRC4ufxwCMgNXw5D6zxW4jXM+jq0QhWMxp215VN7fQSOvFimFZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761769577; c=relaxed/simple;
	bh=g8udJnBf5qbbGeAHshH34t9fLGoHs/m2ZKo5Ipuc9QU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSBZc2czZmaNA8rfsNHY32m/Cs/IjKyh2ycOTsSC0nl/BRn+3qnrV+fngFtDrew9zREc3XA2XXQOBqeW1RBgfsp3QfuBz3bte7+83Ndsjlb4y5LgNOfnkCaKGiQ+EEv147tR4uzmHpBGuHlGMIXLBGeHGEI9HCLjY8NIqRnBKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gbNivlUO; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761769562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8LQMYVbeSSNK8HEpygcBXhLqfLwBAFQnmbjr1eMUwF0=;
	b=gbNivlUO+akpnki/DzJK4tKIph6Rnah2FtAYOZAFV/5Wv7eVnDwIZPm8p3A2ydfKREWBhG
	3FthTNlzbIfe+q5R50wA4HQ5Vk39t3AnmZyZ82mAHwVMj6FtGgEUrXCsjHi9Le98UFePqh
	M5/4hadwC/JHzm9H8+Xd3qivsGT3owI=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,
  Suren Baghdasaryan <surenb@google.com>,  Michal Hocko
 <mhocko@kernel.org>,  Shakeel Butt <shakeel.butt@linux.dev>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Andrii Nakryiko <andrii@kernel.org>,  JP
 Kobryn <inwardvessel@gmail.com>,  linux-mm@kvack.org,
  cgroups@vger.kernel.org,  bpf@vger.kernel.org,  Martin KaFai Lau
 <martin.lau@kernel.org>,  Song Liu <song@kernel.org>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH v2 02/23] bpf: initial support for attaching struct ops
 to cgroups
In-Reply-To: <aQJZgd8-xXpK-Af8@slm.duckdns.org> (Tejun Heo's message of "Wed,
	29 Oct 2025 08:14:25 -1000")
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
	<20251027231727.472628-3-roman.gushchin@linux.dev>
	<aQJZgd8-xXpK-Af8@slm.duckdns.org>
Date: Wed, 29 Oct 2025 13:25:52 -0700
Message-ID: <87ldkte9pr.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Tejun Heo <tj@kernel.org> writes:

> Hello,
>
> On Mon, Oct 27, 2025 at 04:17:05PM -0700, Roman Gushchin wrote:
>> @@ -1849,6 +1849,7 @@ struct bpf_struct_ops_link {
>>  	struct bpf_link link;
>>  	struct bpf_map __rcu *map;
>>  	wait_queue_head_t wait_hup;
>> +	u64 cgroup_id;
>>  };
>
> BTW, for sched_ext sub-sched support, I'm just adding cgroup_id to
> struct_ops, which seems to work fine. It'd be nice to align on the same
> approach. What are the benefits of doing this through fd?

Then you can attach a single struct ops to multiple cgroups (or Idk
sockets or processes or some other objects in the future).
And IMO it's just a more generic solution.

Thanks!

