Return-Path: <cgroups+bounces-11297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48891C167CB
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 19:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B2A21C2201B
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 18:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9D29BD9B;
	Tue, 28 Oct 2025 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qIZ8AJBK"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03A2E543B
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761676186; cv=none; b=gqRMdSlP2VQrqSfjbdaJ2cwpD4+5mCpoIC5bfdZjOUMGd5miOi3dsBISXr0VIiR1hN99k5MZTktd9A1Nt5RSfB7y6DzqIDcYawYRbnbEP4V3szfVWOZf0qbhkHFMbNWGS3l6AGxln3umu+l1SYHx68+St5G4457PGCRqJ2sgZZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761676186; c=relaxed/simple;
	bh=7P2dbbyEJjflzKNLdvD4ebWcrDwRFqvbuzX70x4OP+k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BfTlsX0ViEQdY7/8GfUTzmPXz90QzS9v79TopLpfmfpY7nZgydGPes5WxRcVs3rN8e+karZk8c/bBjmpcm/FsHdfVVktPnuuDi31g+iMkoh1qvr7mJl/kNCvERk/zt7dlpsM/QCYGNb+Gp9KXUYr0W/z1PUuly5Oqp8eKqLTLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qIZ8AJBK; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761676181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l3zBQtGS5UGvIEBLvL9hj21lqEc3c0qUJSEdistyCuk=;
	b=qIZ8AJBKRpTsZhTVBX8Edr2jXIPkePuHpcUP4LnnxeBhbhURlb4AkazZHMqQhbdA2iIIxP
	KRw0KGEq1ug/oVFhgFOLfS2wCTV82FJpYM1jDV8hQSXhoAPOr/oTSGvz9Dks/cFRIhcqcy
	9NxQ5iQmyVGPw2BuwK2GE9tZg3xm9LM=
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
Subject: Re: [PATCH v2 20/23] sched: psi: implement bpf_psi struct ops
In-Reply-To: <aQD_-a8oWHfRKcrX@slm.duckdns.org> (Tejun Heo's message of "Tue,
	28 Oct 2025 07:40:09 -1000")
References: <20251027232206.473085-1-roman.gushchin@linux.dev>
	<20251027232206.473085-10-roman.gushchin@linux.dev>
	<aQD_-a8oWHfRKcrX@slm.duckdns.org>
Date: Tue, 28 Oct 2025 11:29:31 -0700
Message-ID: <877bweswvo.fsf@linux.dev>
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
> On Mon, Oct 27, 2025 at 04:22:03PM -0700, Roman Gushchin wrote:
>> This patch implements a BPF struct ops-based mechanism to create
>> PSI triggers, attach them to cgroups or system wide and handle
>> PSI events in BPF.
>> 
>> The struct ops provides 3 callbacks:
>>   - init() called once at load, handy for creating PSI triggers
>>   - handle_psi_event() called every time a PSI trigger fires
>>   - handle_cgroup_online() called when a new cgroup is created
>>   - handle_cgroup_offline() called if a cgroup with an attached
>>     trigger is deleted
>> 
>> A single struct ops can create a number of PSI triggers, both
>> cgroup-scoped and system-wide.
>> 
>> All 4 struct ops callbacks can be sleepable. handle_psi_event()
>> handlers are executed using a separate workqueue, so it won't
>> affect the latency of other PSI triggers.
>
> Here, too, I wonder whether it's necessary to build a hard-coded
> infrastructure to hook into PSI's triggers. psi_avgs_work() is what triggers
> these events and it's not that hot. Wouldn't a fexit attachment to that
> function that reads the updated values be enough? We can also easily add a
> TP there if a more structured access is desirable.

Idk, it would require re-implementing parts of the kernel PSI trigger code
in BPF, without clear benefits.

Handling PSI in BPF might be quite useful outside of the OOM handling,
e.g. it can be used for scheduling decisions, networking throttling,
memory tiering, etc. So maybe I'm biased (and I'm obviously am here), but
I'm not too concerned about adding infrastructure which won't be used.

But I understand your point. I personally feel that the added complexity of
the infrastructure makes writing and maintaining BPF PSI programs
simpler, but I'm open to other opinions here.

Thanks

