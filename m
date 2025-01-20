Return-Path: <cgroups+bounces-6239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E41CA169BB
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 10:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55407A12B0
	for <lists+cgroups@lfdr.de>; Mon, 20 Jan 2025 09:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C61AF0A6;
	Mon, 20 Jan 2025 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L3l9f683"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F1A1A8F63
	for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737366056; cv=none; b=JByCfY8k8g1AuB9imznrnbqI/iRksiij49Fteitx/FGwS8JgOms09zvwFESiJOPGpeFpveBGkt+Fc5mT7KBPgZXoMi3pX/KvA5RiwJhntdGLKDToSjTiBKuYTeTZGMsw39f9YAc7V2TMy9qbtEpHmGg1xArhidSDFNmeCC7IKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737366056; c=relaxed/simple;
	bh=jGAuDk4ODppPL0yi45/0osBz7E1mny8BsvEuH80d6ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z78/OmsxsXXnWeabCNnqI/r58aCw+F0ltwIDav+3WuvPtQAwtSRhLaDkv/xaNEQaW4v8htAhgEaspycfIF52SJNHCY3BbvnCo8yRAQlp75nDoztZCh9zlvYQ0nRtCV6rG+gCetXX7Bq7pRQMqV+JkEexE4cgZJtTYhPYGSZGi34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L3l9f683; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaeef97ff02so691634666b.1
        for <cgroups@vger.kernel.org>; Mon, 20 Jan 2025 01:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1737366053; x=1737970853; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yPKYIW+/1BswY6JPHJ5KhjmDv3E4BoFMuuugSXDPRmg=;
        b=L3l9f6839oeESHI7wG6LOqUYdeAi2BAbbZ2AeLF3VZqNGpKNZNBgUkU21WKHt3DM04
         aCMMiT71S/FvQb4P4Txp8hxQ8aX8wz+HhmP6bbwDxh6Pf3gP8tDhf5EokZzkBODdtLK1
         +n2Zqcb23P9Xe8/baBFQh+AxUbfQa2zXWSL3PCuMjLOCZyXpRI2hBOYQwC758a68WGxc
         pFgltv9s74uUZv5Gek10QaMNfw7asRTyKP/qsA2cijFu4TUKShXTXI6cfjHAhrg0sy7d
         h3WTQ5Mk8da9zTQ267bI0XWWZIEMJ9/j2o/68B2rCAJ49WETB+ud9VqBz2FxKK2PiuPO
         2k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737366053; x=1737970853;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yPKYIW+/1BswY6JPHJ5KhjmDv3E4BoFMuuugSXDPRmg=;
        b=jg849QE2hv24xaXGl9B6jDPbobdA/zXujUXQj2g4vtkt4bTZWfu4kAq1p9GpGA9E/8
         bDZmeBBXa7z7YfMxK+pWHlqmiQ/EEWll7RrpBEXtoJjvgXeP6tr1wxOtZgih/WQP67tA
         UhLRUP0R0EX0hbgtpE9QFUsJxMRqcuWeJG2t6JTj83EmSXhv3BauOKy1xVdrtTvMMq3T
         f6BRGRiqsPrBebAO2BsDHJBrK0hDdlw2PEPJp5XCyCRAOeWOeoYKUILBnOqYUQjcEMnH
         XdV/EeOMim7nNzmEDKs5tkPaToSJxOYIw8vGi6wCizYEIVA2XJxEgNtuQKx59OLzRIa2
         t5gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpFb8k+/ymggURkxOR59A2aBGNbXy4Dc7EUL+Cui2JezRktTK/NHlCDnkaSBNLc3DSQG5RFVoK@vger.kernel.org
X-Gm-Message-State: AOJu0YxaT6mwSzbxpKsejiWBULZh6NMdJVDQKcDXsrD1RvYB9Bj3/ayY
	hnE37ThA+OiCQfeycb9MOSOrWovuWxcp9H3KRj/11rTTM+a9i1SKnYo6jnkEsL4=
X-Gm-Gg: ASbGncv7Rfnrbw1sPkHlg+kdan8pFZWIAW5goDegmL8Td5FN8D25lk1u+Cx5BZYkHw1
	B1sy+FJT1cW5bZMEKN5jkmpmtAy0d/dcLnRl6stAS4c0eBD3P2PdGCXmo9jsl7En0oPe365d7VK
	92qV/3pqs8DVkWzjiCkMqqsLGow3vxqQ6IHIYGo94HHUm2MP661FNfgd3i7kNTE0bPOFAkNngIR
	WBkqcV8HCkK5NF9D27ArRjdb1g/tXLNYTUQ7061RV2l9qbwlxf3RxJgIUmbmZ/Z2tmU+fkkPQNw
	hxg2Uoc=
X-Google-Smtp-Source: AGHT+IFA2mrrQCmqsHXHh3qM1OB0JGHDkTSHTxhU+WYqBMFAdjqFLOjNjtr6V6ka7y9doZtbRAOrKg==
X-Received: by 2002:a17:907:7da2:b0:ab3:84b5:19b7 with SMTP id a640c23a62f3a-ab38b52ed37mr1243807866b.56.1737366052904;
        Mon, 20 Jan 2025 01:40:52 -0800 (PST)
Received: from localhost (109-81-84-225.rct.o2.cz. [109.81.84.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f86244sm592211066b.152.2025.01.20.01.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:40:52 -0800 (PST)
Date: Mon, 20 Jan 2025 10:40:51 +0100
From: Michal Hocko <mhocko@suse.com>
To: zhiguojiang <justinjiang@vivo.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH] mm: memcg supports freeing the specified zone's memory
Message-ID: <Z44aI3c5M6Y9utuM@tiehlicka>
References: <20250116142242.615-1-justinjiang@vivo.com>
 <Z4kZa0BLH6jexJf1@tiehlicka>
 <a0c310ba-8a43-4f61-ba01-f0d385f1253e@vivo.com>
 <Z4okBYrYD8G1WdKx@tiehlicka>
 <3156c69f-b52d-4777-ba38-4c32ebc16b24@vivo.com>
 <Z4pCe_B9cwilD7zh@tiehlicka>
 <b2d25ba9-8773-4e17-b5d9-2dbc90382eb5@vivo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2d25ba9-8773-4e17-b5d9-2dbc90382eb5@vivo.com>

On Mon 20-01-25 09:22:47, zhiguojiang wrote:
> 
> 
> 在 2025/1/17 19:43, Michal Hocko 写道:
> > On Fri 17-01-25 18:25:13, zhiguojiang wrote:
> > [...]
> > > > Could you describe problem that you are trying to solve?
> > > In a dual zone system with both movable and normal zones, we encountered
> > > the problem where the GFP_KERNEL flag failed to allocate memory from the
> > > normal zone and crashed. Analyzing the logs, we found that there was
> > > very little free memory in the normal zone, but more free memory in the
> > > movable zone at this time. Therefore, we want to reclaim accurately
> > > the normal zone's memory occupied by memcg through
> > > try_to_free_mem_cgroup_pages().
> > Could you be more specific please? What was the allocation request. Has
> > the allocation or charge failed? Do you have allocation failure memory
> > info or oom killer report?
> Hi Michal Hocko,
> 
> RAM12GB, Normal zone 7GB, Movable zone 5GB.
> Issue: kmalloc-order3 fails from Normal zone and triggers oom-killer. At
> this time,
> there is no order3 memory in Normal zone, but there is still a lot in
> Movable zone.

Thank you, I believe this makes the situation much more clear. It seems
that the Zone normal is too fragmented to satisfy order-3 allocation
request (the amount of free memory is above high watermark). That means
that the focus should be more on memory compaction rather than reclaim.
And more importantly at the global level rather than memcg.

Also you are running quite an old kernel which might be missing many
compaction related improvements. I would recommend re-running your
workload with the current Linus tree to see whether your problem is
still reproducible. If yes, please report along with compaction counters
(reported viac /proc/vmstat).

Good luck!
-- 
Michal Hocko
SUSE Labs

