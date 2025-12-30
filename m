Return-Path: <cgroups+bounces-12811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C32ACE8A96
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 05:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1411A3010749
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 04:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735D923D291;
	Tue, 30 Dec 2025 04:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HMtpIgPT"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91580224D6
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767067312; cv=none; b=t5t8AvfRJ1VmmAVpzPiVj/PHT25AepymRtqffXbpeXP65SE3LCduOcgGY2XiZ2lnbbIfUHvaLnn9uURNvt/MnEaIqTFf6nSixbRWoSiLu2HpMaSIv75EgHzyXf4HDZwiyXr1RgXMESHPVnVDPNrlVopllZm63W7g5DF7VwCW6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767067312; c=relaxed/simple;
	bh=vNU8wMgFhiTh8aOkqcgwp571KVH2uZ9Hx4EMB0kgvV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCjk4q5klvJ+XtLzpITqbPyKcBrAn2KjxbyK0CjXQkjKc8GbfQVzaTICQk3IW1A8DH7MpNEqzuwlescHtBMz5o5RuXg4qS7LsrLdL85TzN+29A3rfM0Q7iyjfgV1aiNmmugr4aPb9c+h+iKvWr8sHPK2AsTrLN4bIt+SRplF9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HMtpIgPT; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 29 Dec 2025 20:01:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767067308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wh1jdyymTeALV9AMOvPpN1wNV02zTapRbpXJU8VX2gM=;
	b=HMtpIgPTp6+vmVC3Zw63bq/TJXIqO0pBSV/nDK5lfkbZSxCDWmJKOiXzFU/KuQGc43LtOI
	qmo9bthNashfG8yBi0zVQGQ8pOgP4VdG5ejT+MTgGLw8ANxikcTqCgcnUOYBcXKosMEPrn
	RBYjYfspdvI9HQ2hT0vvIMkCOqzfPmw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com, 
	mhocko@suse.com, muchun.song@linux.dev, david@kernel.org, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	chenridong@huaweicloud.com, mkoutny@suse.com, akpm@linux-foundation.org, 
	hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com, lance.yang@linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v2 00/28] Eliminate Dying Memory Cgroup
Message-ID: <423puqc6tesx7y6l4oqmslbby2rfjenfnw5pn5mgi63aq74jwj@jwgorel2uj3m>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <7ia4ldikrbsj.fsf@castle.c.googlers.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ia4ldikrbsj.fsf@castle.c.googlers.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Dec 30, 2025 at 01:36:12AM +0000, Roman Gushchin wrote:
> Qi Zheng <qi.zheng@linux.dev> writes:
> 
> Hey!
> 
> I ran this patchset through AI review and it found few regression (which
> can of course be false positives). When you'll have time, can you,
> please, take a look and comment on which are real and which are not?
> 
> Thank you!

Hi Roman, this is really good. I assume this is Gemini model. I see BPF
and networking folks have automated the AI review process which is
really good. I think MM should also adopt that model. Are you looking
into automating MM review bot?

thanks,
Shakeel

