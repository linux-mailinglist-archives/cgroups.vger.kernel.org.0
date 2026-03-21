Return-Path: <cgroups+bounces-14977-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEYGEewYvmkxGQMAu9opvQ
	(envelope-from <cgroups+bounces-14977-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 05:05:00 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5D2E32E8
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 05:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 69B8C30333B2
	for <lists+cgroups@lfdr.de>; Sat, 21 Mar 2026 04:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA0F27FB0E;
	Sat, 21 Mar 2026 04:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eMWwq7tA"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED08230BE9
	for <cgroups@vger.kernel.org>; Sat, 21 Mar 2026 04:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774065895; cv=none; b=NALnC12RHSJAv4GOFr8QFDfw2QBk02Yf0eSPK2lAi0JapFyo3hfB5lyaCYBWnoToG0cVjYfUR3ms+ltRtA8MWUclTlxYXorxZd2jnnY5Gwh7xRjfYiW1M/Hr4a4KXgHqfNJ08/TQzptmcwxypqaOQE/W4+mv/0seQd7oLvfBbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774065895; c=relaxed/simple;
	bh=Vb0hgyyRQxiEoRD57QPoNnifO28j8YAw05wFPmEsgvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAF1RusqtCpOUvUtZUN5d/HhXESDxMNMAKnUIrhPklfiXy4q5k8w3sKIe7H/J9Gc2eCQYH/Do7E1UgSJstJd/h0rI8di18zHk/t2qESam847h4KPEI/+PXvDys38jh4mVkt0BguVUipsyCfuDnqKZcgvozdj2DKzIzw28ZVEv/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eMWwq7tA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b052ec7176so36145ad.1
        for <cgroups@vger.kernel.org>; Fri, 20 Mar 2026 21:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774065893; x=1774670693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vb0hgyyRQxiEoRD57QPoNnifO28j8YAw05wFPmEsgvQ=;
        b=eMWwq7tATjetERtfSIF+fUO4VC9GJYpUP8A9Z5JeO4t2OFY5u91IL8YCR44iXM9wo5
         Me2n56vNuYSI0al58qlNXVwkeoSxermFyv1ibcNqnIldErprGg2kzVseq332FJLq2TgR
         HA8klWkQn6+pouGR4pVly9mMe/jAgCj8Zrr+LFOjfy7SW1RceV2vh+8neuVMBEERMzim
         6aZB2XjHyYuTfN0Nwq/8D7SqBoAzbl2mQqpVIqPAeVPRQUeUA2bQ8HzO1kScTEW7bs16
         jEviwJpAtKyIVLNKG83G9io8OPhZydrJlAx0osBkSCzLEJ8ogBiy2MmbBuK0PbdbrNRt
         R67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774065893; x=1774670693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vb0hgyyRQxiEoRD57QPoNnifO28j8YAw05wFPmEsgvQ=;
        b=qu0YBSS2kSegr8OgG7F77fx7E3kLyLT5hgDcZ1ox/7cM50nLlqvxBiBvz3NRUr6gf7
         7Gzd7H0uZKEzrQnBSO3/GTCf6WecyccDBUQVc0i447Y7Ax6uPliTpMFL1QmBbhUC7FdM
         HTTlrlni8oqbjTjk3qFYupW9ApBZWEqii9iKxlZY56FY+XCjIGATK1jpdp0U5ZlXaISD
         bVD9Nn6bhWBX2ZUcNhxXLDL/53bSYc/8uDsSzh0y8/2Q0x0UVe8MJrgAXOq2k7dRg+1t
         aWjQIygN8jOY00/2JCnU93OYJJbRgnRtZ/wsBt0EfYwwaucQZVScARHpBrZsFYclKdcp
         IC6g==
X-Forwarded-Encrypted: i=1; AJvYcCUZPmO0Cqz9qf1dxh9AHTjFrVV6cBRF3GSnfCGlaufLk2khZnxWcRQSaKd3NAo7cZRmJLuMZO0R@vger.kernel.org
X-Gm-Message-State: AOJu0YwGG50l/NKYZl7VqyPCsA3zcwyXR+JinyfR2Pp3RklitCJb8inJ
	iysHmZAmO0XaHEE5RDyr7O1wfanJO79u3qncf/YttbzT/lqK6MwGF/XYCHGXc313Cw==
X-Gm-Gg: ATEYQzwtLbeCLkATnVmE9vZNJZlKlmXOiVdcfbmqautNRH0xsiiFt6sq0EOgjHXdqlm
	0PELaVhcwKimUNULP7Z9xp0Wo5/VoEqiOlxjLn63GPVSevvrIGE4Sc2TFojwuRHLbrJwMONHRDH
	jP3duAwGZbx3PkyVQ0Nfks2wYuiE0uL7Mkm36hU+r6qRBN0Cp1EYreyAceqwYbRpsrYkE4DkWQ7
	L0HUj/922sfyzHWD7/aWTdwK+F1AaWvKH2sbmd7CQyfjb+iMzMORVqY98rGt8F4Ume0FxMPzVvM
	+tsgbodpsTLnBE7ZUeatZXeHmyFpod5FwL7knSckwEjlxgqYq+RgtN6cFeisAbNFp/XJaQDyCRV
	s6tBoe675XH+vI0KLw97fS55lPa03I92cGzPTTWd+dbZvDLEhI4QLjoU28EakRv8iMhILbPjKsB
	Z2w8NObRJxQclppRbZNO1So1sxL3/1KugjrGrkngkFpEtyklzNapDw8z22D2lwEJyM
X-Received: by 2002:a17:902:ebc5:b0:2ae:7fa2:6bda with SMTP id d9443c01a7336-2b08c38a9b3mr1002905ad.1.1774065892911;
        Fri, 20 Mar 2026 21:04:52 -0700 (PDT)
Received: from google.com (206.238.125.34.bc.googleusercontent.com. [34.125.238.206])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b0409f582sm3411460b3a.33.2026.03.20.21.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 21:04:52 -0700 (PDT)
Date: Sat, 21 Mar 2026 04:04:47 +0000
From: Bing Jiao <bingjiao@google.com>
To: Donet Tom <donettom@linux.ibm.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Yosry Ahmed <yosry@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 2/3] mm/memcontrol: disable demotion in memcg direct
 reclaim
Message-ID: <ab4Y33lBuYiOTGx7@google.com>
References: <20260317230720.990329-1-bingjiao@google.com>
 <20260317230720.990329-3-bingjiao@google.com>
 <380c52cb-fc8d-4fbe-8d2a-f153bd179816@linux.ibm.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <380c52cb-fc8d-4fbe-8d2a-f153bd179816@linux.ibm.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,google.com,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14977-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 96A5D2E32E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:47:14PM +0530, Donet Tom wrote:
> Hi Bing
>
> On 3/18/26 4:37 AM, Bing Jiao wrote:
> > NUMA demotion counts towards reclaim targets in shrink_folio_list(), but
> > it does not reduce the total memory usage of a memcg. In memcg direct
> > reclaim paths (e.g., charge-triggered or manual limit writes), where
> > demotion is allowed, this leads to "fake progress" where the reclaim
> > loop concludes it has satisfied the memory request without actually
> > reducing the cgroup's charge.
> >
> > This could result in inefficient reclaim loops, CPU waste, moving all
> > pages to far-tier nodes, and potentially premature OOM kills when the
> > cgroup is under memory pressure but demotion is still possible.
> >
> > Introduce the MEMCG_RECLAIM_NO_DEMOTION flag to disable demotion in
> > these memcg-specific reclaim paths. This ensures that reclaim
> > progress is only counted when memory is actually freed or swapped out.

Hi, Donet,

Thank you for the feedback and reviewing the patch.

> Thanks for the patch. With this change, are we completely disabling memory
> tiering in memcg?

Yes, this change will completely disable demotion from memcg
directly reclaim, as demotion does not help to reduce memory usage.

>
> Did you run any performance benchmarks with this patch?
>
>
> This patch looks good to me. Feel free to add
>
> Reviewed by: Donet Tom <donettom@linux.ibm.com>

Thanks again for the review!

Following a discussion with Yosry regarding demotion as an aging process,
I have decided to drop patches 2 and 3 from this series for now.

Additionally, Joshua Hahn's RFC ('Make memcg limits tier-aware') [1]
introduces a mechanism to scale memcg limits based on the ratio of
top-tier to total memory. This approach or similar approaches might
provide a more comprehensive way to resolve 'fake progress' in memcg
direct reclaim or establish a better framework for addressing such
issues in the future.

Hope you have great weekend!

Best regards,
Bing

[1] https://lore.kernel.org/linux-mm/20260223223830.586018-1-joshua.hahnjy@gmail.com/

