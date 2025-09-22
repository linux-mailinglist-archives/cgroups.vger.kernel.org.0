Return-Path: <cgroups+bounces-10368-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B5B93881
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 01:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB0444235F
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 23:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9429A287519;
	Mon, 22 Sep 2025 23:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="1dm75PcT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496853AC39;
	Mon, 22 Sep 2025 23:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758582285; cv=none; b=YKOOgQBwcka38GAX7AuoJRblytKxtnK7nmAJcZ4YQQgHBpqd0FRn6p61NnAlNyJh8V3cmNoRF/glTtnFswIgNIv2qNs6Ll2CPO4kh//x/hLtwI/1JRvN+8SG9MY+uuQ+GXhrPMUx699EMPLYqrhZJq03g+3rCFgemS1UPxhC498=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758582285; c=relaxed/simple;
	bh=uV1BEGwMril5Mf0IeyAdOLV9h4kg1knR4wxauKL6cjg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CK/SNVWLoVDCG16PoNAFES0YNipQvZpMX4cot7EfADc+omIiGgNk0RRpT14U30H7Y/VGQrzkFbEdFKJ1ths6fIFHc41NWMmWftw8RxNw9OsPowgEvKJdg5bPl/ROhX8A4L2fOI21+kNxpWFxRih48LaLkjL15xlPmaAByED+t5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=1dm75PcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2202AC4CEF0;
	Mon, 22 Sep 2025 23:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758582284;
	bh=uV1BEGwMril5Mf0IeyAdOLV9h4kg1knR4wxauKL6cjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=1dm75PcTM0GNvvo8wLFKhZIacGv6nXR3yYxOxMiiOtNAj5M0ApnHtCXet/LFONcXF
	 ji2nZFqa7tlksRBYoJEHrP3xc4LSjX0yanqNESbjXkKP4HpEu76FhVnCIIDFprM4da
	 j7TY40fj8aHE552hd8tU1Zc6xpSMg3h/OtfFCRVw=
Date: Mon, 22 Sep 2025 16:04:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal
 Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, bpf@vger.kernel.org, linux-mm@kvack.org,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not
 allowed
Message-Id: <20250922160443.f48bb14e2d055e6e954cd874@linux-foundation.org>
In-Reply-To: <20250922220203.261714-1-shakeel.butt@linux.dev>
References: <20250922220203.261714-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Sep 2025 15:02:03 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Alternative approach was also explored where instead of skipping
> cgroup_file_notify(), we defer the memcg event processing to irq_work
> [1]. However it adds complexity and it was decided to keep things simple
> until we need more memcg events with !allow_spinning requirement.
> 
> Link: https://lore.kernel.org/all/5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd/ [1]
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Michal Hocko <mhocko@suse.com>

Fixes a possible kernel deadlock, yes?

Is a cc:stable appropriate and can we identify a Fixes: target?

Thanks.

(Did it ever generate lockdep warnings?)

