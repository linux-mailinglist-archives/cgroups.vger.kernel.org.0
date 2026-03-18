Return-Path: <cgroups+bounces-14877-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WNoXJFgSu2nGegIAu9opvQ
	(envelope-from <cgroups+bounces-14877-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:00:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2F02C2C80
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 22:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5005318A0CA
	for <lists+cgroups@lfdr.de>; Wed, 18 Mar 2026 20:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D27371870;
	Wed, 18 Mar 2026 20:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+E57JVT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3D636F41F
	for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 20:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773867480; cv=none; b=gUZy3aDSt9/8QTYK/J83hJOjp1ANBDlFx/MHfEfH5H2aMEQ8HTZ7+KM7m9+curHyZx1bhTcCXLUGVJ95fQrQdTX5Let60yaa0A/HFhnpBpVTiT0YfnsL5SLA5GTL+lpicuOq+ZQYBAaXnUR5NvXJcNZg9/qn9VNaYvWrb1R5AmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773867480; c=relaxed/simple;
	bh=Oy0njUjW6R5iexNMz3wzKCSxfU2YGWhYv9JL6HRw5xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7b16w/W2tdDKWREWneop6cSkK3X5Lat4vgt5VG2HkqaXndpt9+yDmbF7m0OKf0hwcyxvsGinwGnM7ZhfrKtaZcTBSI2sjVH3WudmOd8VxAweBif+X8ABMrhQ4oMgvHzmmBksWUbqvRAYBDWSVizPEJOHKoltU0jRv3cr5R/PW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R+E57JVT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aeab6ff148so8405ad.1
        for <cgroups@vger.kernel.org>; Wed, 18 Mar 2026 13:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773867479; x=1774472279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oy0njUjW6R5iexNMz3wzKCSxfU2YGWhYv9JL6HRw5xo=;
        b=R+E57JVTj11xcfxsQdrauM6zpW8njxl0/iWi6D4LQEOAU2x11nmZq+4ncgRIUF6A2o
         CxHUYJalJUGS0pXYkREW2wfv4lk9KLfL1er7CCXjLF8iAKLbAsL41dVMY46s5DdRK/+y
         CqVhgoCl87vvdmxFYWEEdveDU2WHkCv3Ka3lHA6BRkg+twKeulSc1puzECqLsko7bcp+
         oPHsndPjIArPwbuHVH7ruYs+MUaquQgy7nRJDy7FiTwwNJFyEYJyYCF8J9/UsXwUc4Qe
         ski8P9LLcLRNzB2lVw69aTk5A9dVvv+r3VwSD/RWLvy7CwGWaXA4ytR6hidQoyT2WA5k
         muXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773867479; x=1774472279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oy0njUjW6R5iexNMz3wzKCSxfU2YGWhYv9JL6HRw5xo=;
        b=aWslfFRSZJfyxacSWKPxNWNncExacteJS2jK/m8Nhe8b6+mSwe2kCL0yqmTgLW41ji
         H2Azh/WUIFkW2aJ3lzJl57XV50Pp9o5ZdWIIgABehWCovDNUm3EFNYtEHdaTVNQEZhOi
         v8A1xqu2MqoeLP6CqYFNoHmf5YFGfk5cILV0k4ILKZUWuITnU7sbx+v4m71/xciwTff+
         7QBn09O3E1iesq3yMuDa//yqEQNJtnPoMmNhsG8olU5DP2NU1b18aATFnaOPPXISCGDy
         nNtY4SvmWufnMs+Ngil5eC7c8UH//Nk4QpO4AJ6bmKHd85h2EpjVPXaascA7t3uvYmgc
         pHFg==
X-Forwarded-Encrypted: i=1; AJvYcCX0nXbwFnYjRqBTqng95oVglkoB/asiqC12yEJ8DNTaJ4IpDXocprK1H36d6eaiHDKjJ0CSt9hl@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNe+nLUEH6T7uoY5iPQchwviYew7fmn7HR57XVgPnRPq0vJFI
	SSP5QcmwHBCIqLVIk5fLgBm1VacBUO7xbR7LMNdfSGhFzUixTup3ZJik/qQhxfVC89vOrDN9a0x
	Ed1KSLWUE
X-Gm-Gg: ATEYQzy8kmnHYqb2vR8ezFCaSoIUTATSVsjISY7OyBA0BgN6yCtSznPXaVJkdHGyyZY
	uSc+t8jEGp9mAvpVFZB3VFkHcdsrzh39LhwK8EPD+votYvHIeUn1tjsIca7iXT8hB5UNXpBvpqi
	ZWNiVItNvK+jGBSH+279lQrFgEofMW5q85+SXbi4FfQwwl5zbjx6tW1BQj6+KvvzjZv1QB2Unuy
	Tl8rTfxRINBMPd90PGNko04DhoZ04x4l9MClxqvrEwC9L0u/g6zJprI7kYGBKi+SwGoze+LhdQs
	Oe4PPYcsUwUyMokMJaqabiHhlS05Kb+oGjR/6uw6P4/1TMh+li5IFZgoMEAsMDpsLPdrmTdo8ej
	W16x8mbj2hwzxaD6B+X0pP+qbfLCipIaKASAGnr3fgKESZg+731wh+WqchfPWCv1e5DnkolUoMl
	RpMiXYtDT4pkqxukv4T1rZiqskHBBwdAhZja1pbBqWKNsKmzrInWb5u/leJ5zujMacDysveYCqk
	fc=
X-Received: by 2002:a17:902:d549:b0:2b0:5ba3:2416 with SMTP id d9443c01a7336-2b079f9f6d5mr203135ad.7.1773867478553;
        Wed, 18 Mar 2026 13:57:58 -0700 (PDT)
Received: from google.com (206.238.125.34.bc.googleusercontent.com. [34.125.238.206])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bbad77e50sm1525460a91.6.2026.03.18.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:57:57 -0700 (PDT)
Date: Wed, 18 Mar 2026 20:57:51 +0000
From: Bing Jiao <bingjiao@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>, cgroups@vger.kernel.org,
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
Message-ID: <absRz4U_IMk0ofxl@google.com>
References: <20260317230720.990329-1-bingjiao@google.com>
 <20260317230720.990329-3-bingjiao@google.com>
 <CAO9r8zP5HmeE1uOZE9WxN1GyC59mM_F2JGaKLEkxzzCvnxpW2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9r8zP5HmeE1uOZE9WxN1GyC59mM_F2JGaKLEkxzzCvnxpW2g@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,google.com,vger.kernel.org,tencent.com,huaweicloud.com,gmail.com,redhat.com,lge.com,bytedance.com];
	TAGGED_FROM(0.00)[bounces-14877-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bingjiao@google.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.905];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE2F02C2C80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:44:34PM -0700, Yosry Ahmed wrote:
> On Tue, Mar 17, 2026 at 4:07 PM Bing Jiao <bingjiao@google.com> wrote:
> >
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
>
> See the discussion @
> https://lore.kernel.org/linux-mm/20250909012141.1467-1-cuishw@inspur.com/
> and the commits/threads it is referring to.

Hi Yosry,

Thanks for pointing it out! I was unaware of the previous discussion
regarding demotion as aging progress.

I will drop patches 2 and 3 from this series and resubmit patch 1 as
a standalone fix by replying to this thread.

Thanks,
Bing

