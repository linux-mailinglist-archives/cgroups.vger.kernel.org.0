Return-Path: <cgroups+bounces-13066-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D648D12F42
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 14:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8B98330019D7
	for <lists+cgroups@lfdr.de>; Mon, 12 Jan 2026 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0D735B139;
	Mon, 12 Jan 2026 13:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cENMWRhK"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70235B144
	for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226251; cv=none; b=n+8iUgpjuhlcCWHxhMn97g5kCjqBfyvWk8G60ipJe+DvP9LBDA+KZt5BmoiZ9VkmrHTFIKuTwjj0Ao+GpKURNtX//ChxcF0mcsLwWFPAHgAOQcwv913Pf4xuU2eSGRQHyPR8zh9dqUIc5/+pfvekPTZatPytCwI/GBaOxWBr8wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226251; c=relaxed/simple;
	bh=gAMH2uvs/CgwkSg3WF3gErnuTMUlm803mdW74R4jxXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6EfNz5FaSRfDMq4poJNdOi7jz6MYXiBru6AKCplNmogaGjnzotkDN99XSR7d0fjeaYhu4FiHNVOWcQ1PQB5q2NI2pF1p1yRoW0riC7uJZ2lJqiwlHzdA8ER8h4HWGKphx8PJW4LuGH2XnGY+MCr52oOPeQveFnrdGJ36lKM0VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cENMWRhK; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47d1d8a49f5so41486995e9.3
        for <cgroups@vger.kernel.org>; Mon, 12 Jan 2026 05:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768226248; x=1768831048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ojfjuEZT6516dXGjj7cFzWBDB5vqwECXd9Bz2SUP+mg=;
        b=cENMWRhKoybH1EnF8zefbklP7+JoEXrKIKsYYyMuDN3od3HUng7xvPua2we/xwP3q5
         JSy65zS+Z4Q9gkka/GMuY6nt6rL3jx1g5VlRwQiR2ljLIJB2NWUrVjHvcC6jMcPk/ot4
         FP2ZQ497Kvcy3r9fR4bH0fRynENXwJsO3liJBPPKTJiWNAY1Q8+NVavuFCBqJNSBZxQq
         38BrzUvlaqRnXVJLal4WTH9GMxNeMkDqyaiN3lix0dWsg6eTFzZ+6jK3djl6v2fR4ue3
         zTAV8jlDusOEGr7KVYYltKE7WruMZiUjAiS+NtJDFcWdPYSApfH4gI2dWwgQaMQVaMtZ
         6rKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768226248; x=1768831048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojfjuEZT6516dXGjj7cFzWBDB5vqwECXd9Bz2SUP+mg=;
        b=oOoUXIVzFeH/XOTWsOpHNMdKxVm7po7byT3ykdJ60BZTiKPtpNKW8ooF0hrCGbVmOL
         v1zKV7mhWes0bNQlJjs+dgXSHsw3YtJEtEY4WGvAK9Yq46GA2vaEQjRiBQh69aIqDtKI
         2WgfeZEb/GJ5cRhuv9UgEMxOmrh5c6gCPTB1RACEhA9fu1HquoHzmpxZaWwt0vu5lpdo
         VYElS4dh/tTKWxUMfcF3bQCmegV67wP1dhGedn8x4OyMZRgd24dLo+HkQlwUoDLiwnZ8
         rAsfSRLhbIejJKZHxmsTZVkdVg1dfBrpGJPjVdx1RnlIREUtzHYx8V1XuKwg1JZy9cqU
         YtGA==
X-Forwarded-Encrypted: i=1; AJvYcCUhz6uh8BL9kLgrTlrpyjPugvyGbHf7TSbUoSwTAU3wedVk1TWUu0Wwehuv9G2j9zkUuc8IsgAf@vger.kernel.org
X-Gm-Message-State: AOJu0YwM2wEFAR5mxKIuVw1O+WBsERJ7D8KOwDVqG9XxnvSEUQDdOBNk
	q9Op8wVU4Zu5aYemIoiHS1fb7NWhC78w2mVnRpYSN6nGz3NpbhQUaZR8vioYqaqIipg=
X-Gm-Gg: AY/fxX6VhW3uzAFud5nIH8jwtu0l9Z7SYGxCnUdLFAmqiGnuly2bvN18Tks7wXVft9X
	fsWVW4q1iNF9a45+wRiUbDHGBqrXI+ppzwh1PznWCIFwL/m+lFtOaKTw8cwMtt+IawCfzRbeYCc
	B4amn5irAeyT32ufVAlBIJCvv7z1+1j6KW1vvanqaWzdFUunXVbMReUAxnUbyds1fOUoAa4uDxK
	pHmHYYT2qwXH92o/T3cSnMZkqQ54BKYk6b/es8zbRNeoFsE4MHuRwiMcpe65TC4nf2WUBPstTAQ
	jHO4mSFcCYo0QL5/RmQP3ZYeY6cipAhExr29XCr3N41+KzkK6uv5D9SEEv5Tv9CMveuvNnzSIgF
	SxuNm7tkpIfvSJSNF0K0OmJlROZUcSfLaDy+SPOraYz+MuNRFSREgoE8F7zrUsduAgcrMuauU2c
	OanYhVSNjzFNKoos4ki6EbnxwT
X-Google-Smtp-Source: AGHT+IH29GDIodJ0Iy57eZZOTR2mLdkX+1IGe3kPs2cJRyAcm1ljENQAhNQdsf2vi8k6BuFrEYkAGg==
X-Received: by 2002:a05:600c:1f8c:b0:477:7d94:5d0e with SMTP id 5b1f17b1804b1-47d84b40955mr197307005e9.27.1768226247504;
        Mon, 12 Jan 2026 05:57:27 -0800 (PST)
Received: from localhost (109-81-19-111.rct.o2.cz. [109.81.19.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm38478758f8f.16.2026.01.12.05.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:57:27 -0800 (PST)
Date: Mon, 12 Jan 2026 14:57:26 +0100
From: Michal Hocko <mhocko@suse.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>
Cc: hannes@cmpxchg.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/swap_cgroup: fix kernel BUG in swap_cgroup_record
Message-ID: <aWT9xnrRQsvMLVkL@tiehlicka>
References: <20260110064613.606532-1-kartikey406@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260110064613.606532-1-kartikey406@gmail.com>

On Sat 10-01-26 12:16:13, Deepanshu Kartikey wrote:
> When using MADV_PAGEOUT, pages can remain in swapcache with their swap
> entries assigned. If MADV_PAGEOUT is called again on these pages, they
> reuse the same swap entries, causing memcg1_swapout() to call
> swap_cgroup_record() with an already-recorded entry.
> 
> The existing code assumes swap entries are always being recorded for the
> first time (oldid == 0), triggering VM_BUG_ON when it encounters an
> already-recorded entry:
> 
>   ------------[ cut here ]------------
>   kernel BUG at mm/swap_cgroup.c:78!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
>   CPU: 0 UID: 0 PID: 6176 Comm: syz.0.30 Not tainted
>   RIP: 0010:swap_cgroup_record+0x19c/0x1c0 mm/swap_cgroup.c:78
>   Call Trace:
>    memcg1_swapout+0x2fa/0x830 mm/memcontrol-v1.c:623
>    __remove_mapping+0xac5/0xe30 mm/vmscan.c:773
>    shrink_folio_list+0x2786/0x4f40 mm/vmscan.c:1528
>    reclaim_folio_list+0xeb/0x4e0 mm/vmscan.c:2208
>    reclaim_pages+0x454/0x520 mm/vmscan.c:2245
>    madvise_cold_or_pageout_pte_range+0x19a0/0x1ce0 mm/madvise.c:563
>    ...
>    do_madvise+0x1bc/0x270 mm/madvise.c:2030
>    __do_sys_madvise mm/madvise.c:2039
> 
> This bug occurs because pages in swapcache can be targeted by
> MADV_PAGEOUT multiple times without being swapped in between. Each time,
> the same swap entry is reused, but swap_cgroup_record() expects to only
> record new, unused entries.

Shouldn't madvise path avoid paging out swap cache pages instead? IIRC
this is what the normal reclaim path does.

> Fix this by checking if the swap entry already has the correct cgroup ID
> recorded before attempting to record it. Use the existing
> lookup_swap_cgroup_id() to read the current cgroup ID, and return early
> from memcg1_swapout() if the entry is already correctly recorded. Only
> call swap_cgroup_record() when the entry needs to be set or updated.
> 
> This approach avoids unnecessary atomic operations, reference count
> manipulations, and statistics updates when the entry is already correct.
> 
> Link: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
> Reported-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d97580a8cceb9b03c13e
> Tested-by: syzbot+d97580a8cceb9b03c13e@syzkaller.appspotmail.com
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>

I would use
Fixes: 1a4e58cce84e ("mm: introduce MADV_PAGEOUT")
-- 
Michal Hocko
SUSE Labs

