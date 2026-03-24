Return-Path: <cgroups+bounces-15024-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLQ1OY+mwmkyggQAu9opvQ
	(envelope-from <cgroups+bounces-15024-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 15:58:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333B30A987
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A76430387E6
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2026 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2B63FFACD;
	Tue, 24 Mar 2026 14:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCmGxzMp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A46A3C279B
	for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364301; cv=none; b=PbgCKSFEVSqY1qkOTkizV1Wy5rF6we98K39Dh7Bx2b5x0PcSNR4lknmy61LitAQTGRB1FfhR+zAYRlOOmYvsAmFpa0VeiSJm0R7NdoovhZGC6KhCzJf5ZYuyjBNQ/PR/hSn/MUcVp7ugwlypS2YvFLBKSY29HgWcTg+sPBgVZvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364301; c=relaxed/simple;
	bh=UmL+1K91qgh5SgxUxjDJBvS9D7yGeWFwhKJrrOnDlSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khHD21x5vviudp1rWUXlwMp8PC5EL5fpgmmxXdqVJ4H3eO13+v3S25c6FZ3SY1aoNTjJuH2JSqHQs67YJyai9txW8Snw7PfvDYAlGDMCd13+f5Sqmbv8YfaYxRBbtovY8PyQscXK8+6mhebs4Pel7ZmC1QthRiO5kyDAdkclmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCmGxzMp; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-417c34b0509so3393755fac.1
        for <cgroups@vger.kernel.org>; Tue, 24 Mar 2026 07:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364299; x=1774969099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NiY1YRqWKN2c0v1X9CNmB9tc2X+pcdgcgZJabn7k3xw=;
        b=gCmGxzMpPKHYcr7Y24z9dK3Xor3T4cRN61VB2yLj3bbCnTuhSrzRHeHypnL3vIANoa
         IjdyLUczaaxocXJY1hV8qb2pZrN1YJEUeM0E+JhCIhbX6K/1R9pODF41iNFnOUIdFtdt
         /Eik9IqBJENG5/NciuwfEaNEBRtyiO4eQX+LjUnA3Rut5anN+GziW6tDne/SitRCnfyt
         yzcTjJ2jVmcy+PjyALrRT6gQxbPTiAxipYQDdNae+oZAIJRWkx5ObKDFH/2enW1Jm5m1
         tAdrIjjfuEdDQms4u91aIxhgemMzlSb7Q732UN5NKnuZDnwK2mtO4y4uywB4LtfKQt7x
         ZqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364299; x=1774969099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NiY1YRqWKN2c0v1X9CNmB9tc2X+pcdgcgZJabn7k3xw=;
        b=ZgsMy6ArZ/DtYsdBzM5PsG7JYbclpuO2WtT+1jhHT3Z+hCR03oSTm9oDYDxTjLp4BB
         t3hpN4CjTZDUtfUJxRqSWDPsBFn5THAKxzTHhVStmjnirCJXsX/ROJyIv+kuwLEdB3AD
         6/ribU8nvaFCv79SJnSR/c9p+bj8TJb/ovdwsMWF/9uafPlyG5v/JDgT0YWw7EwTAbaX
         oaHgHCWcJ+DXQyQ6Ng7tKlL/ueccKuxhwwiJUGD2xjG8jCIogA0hXAMjpmpzjVhK7OQM
         CfhpLqDNzguehuWeUaT/XSekbgd36VLw5ZBHXjB2dWoQIiRz99r6BDsmqpubo9Cz7xUu
         aNjg==
X-Forwarded-Encrypted: i=1; AJvYcCVpCGT3o64NHxc/D5wGrCij0pVNWnWjIE1kjKM7fF8pTMw7uJc2urcgLYP+b0h53HLjDs7/23GE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw238PBYkTl6fIl6TO+NQ8mXlQfSUy0hgzXc8+S8RJW1nlsKCLG
	ieL0O5nahwfugpaLcF9m6VIEQWJwQCCcjfWWLkvBgSaV5rndfOVT/3fR
X-Gm-Gg: ATEYQzxGY3fdHJ+f6wNPrdKPSN6Xiag5UN+eLfLzE9gDRczqYMxYk6WvUAugqa4jhid
	bI/jyNHaIJYh2YT//xJAtJ1mh0Mkqdn4CJAPiKItIdMw23Q73ScLyuCJ9mgcR5kQI5zlCsr1+JM
	IfVtG4HHxEEdh3DYUfxuXhrikCP58D+0tmRfyr2lZqoFFvDNEA/tGaSUDtW9UuGAuaPHGipSZdl
	VT7GHUDG6pP7eRAofV9GWIKCCdriu3Es3aA/kcmlnLlciSCcyDmT1JT5HWvOqsB422qpr6ikmFN
	o3hMr1OPySZcatCheQZkLBaFL0t9MnWgFKiBC/Ad8EvK+BIUsXqwI/rhtFfEZnVWqACsLJsH7vP
	8P8521x5rH8dTjknPO2tloqi6cNXlqnIF3kmwbeb4ni6XZ0xTXPWvsfYc52Eml4DZvSBzcAWiy4
	YIWOj0xC8wThAMSRk9KAHogw==
X-Received: by 2002:a05:6870:c248:b0:409:6862:aba5 with SMTP id 586e51a60fabf-41c11157d40mr10061336fac.25.1774364298770;
        Tue, 24 Mar 2026 07:58:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5e::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14ddbcb3sm13662511fac.14.2026.03.24.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 07:58:18 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: Gregory Price <gourry@gourry.net>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [RFC PATCH 0/6] mm/memcontrol: Make memcg limits tier-aware
Date: Tue, 24 Mar 2026 07:58:16 -0700
Message-ID: <20260324145816.3939303-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <13eb0f7a-95bc-4337-9d38-a06db0700777@linux.ibm.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15024-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[27];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 8333B30A987
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 24 Mar 2026 16:00:34 +0530 Donet Tom <donettom@linux.ibm.com> wrote:

> Hi Josua
> 
> On 2/24/26 4:08 AM, Joshua Hahn wrote:
> > Memory cgroups provide an interface that allow multiple workloads on a
> > host to co-exist, and establish both weak and strong memory isolation
> > guarantees. For large servers and small embedded systems alike, memcgs
> > provide an effective way to provide a baseline quality of service for
> > protected workloads.
> >
> > This works, because for the most part, all memory is equal (except for
> > zram / zswap). Restricting a cgroup's memory footprint restricts how
> > much it can hurt other workloads competing for memory. Likewise, setting
> > memory.low or memory.min limits can provide weak and strong guarantees
> > to the performance of a cgroup.
> >
> > However, on systems with tiered memory (e.g. CXL / compressed memory),
> > the quality of service guarantees that memcg limits enforced become less
> > effective, as memcg has no awareness of the physical location of its
> > charged memory. In other words, a workload that is well-behaved within
> > its memcg limits may still be hurting the performance of other
> > well-behaving workloads on the system by hogging more than its
> > "fair share" of toptier memory.
> >
> > Introduce tier-aware memcg limits, which scale memory.low/high to
> > reflect the ratio of toptier:total memory the cgroup has access.
> >
> > Take the following scenario as an example:
> > On a host with 3:1 toptier:lowtier, say 150G toptier, and 50Glowtier,
> > setting a cgroup's limits to:
> > 	memory.min:  15G
> > 	memory.low:  20G
> > 	memory.high: 40G
> > 	memory.max:  50G
> >
> > Will be enforced at the toptier as:
> > 	memory.min:          15G
> > 	memory.toptier_low:  15G (20 * 150/200)
> > 	memory.toptier_high: 30G (40 * 150/200)
> > 	memory.max:          50G
> 
> 

Hello Donet,

Thank you for reviewing the series! I hope you are doing well.

> Currently, the high and low thresholds are adjusted based on the ratio 
> of top-tier to total memory. One concern I see is that if the working 
> set size exceeds the top-tier high threshold, it could lead to frequent 
> demotions and promotions. Instead, would it make sense to introduce a 
> tunable knob to configure the top-tier high threshold?

Yes, this is true. It is also a concern that I have, and I think that
adding a tunable knob could be helpful. The other side of the question is
whether there are too many tunables for the users already, with min / 
low / high / max. I'm hoping to get a consensus for this at LSFMMBPF, 
I hope we can talk about it there!

The other way to approach this is to throttle promotions and demotions
when workloads are thrashing. Personally I prefer this decision, although
it isn't mutually exclusive to adding more knobs. 

> Another concern is that if the lower-tier memory size is very large, the 
> cgroup may end up getting only a small portion of higher-tier memory.

I think the issue you mentioned above is a bigger problem.

If the lower tier memory is large and the toptier memory is small, then it
makes toptier memory an even more constrained resource, so splitting it
fairly among the cgroups becomes an even bigger issue. Remember, we're
limiting workloads' toptier memory usage because other workloads have
to use it; if we let a cgroup use more toptier memory, it has to come
from another cgroup's share.

Thanks again. Please let me know if you have any other concerns, I'm
excited to talk about this more as well!

Joshua

