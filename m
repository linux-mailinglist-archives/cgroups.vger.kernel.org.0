Return-Path: <cgroups+bounces-5702-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A09DAEBE
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 22:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C00EBB215E0
	for <lists+cgroups@lfdr.de>; Wed, 27 Nov 2024 21:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF44E202F6E;
	Wed, 27 Nov 2024 21:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POdWqnXe"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB73114AD29
	for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741506; cv=none; b=PcWETU4y37ykrz3l9vfpdtMT+Oo2pP/kk5vicMkMVjGgTqXvsfUj1wp6gFJ4AywzfCj5vJ5tVNqy+sDjjfnk+bjxZTAGowO1Dh0M1Us4pVWhocCJUAZGvG/LWt64Dwbv5Tiy++Dc8ot1o3O0uvXHJA7BbO79tof/dmkQ7WCvvyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741506; c=relaxed/simple;
	bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I2z6nFwHdaKa18WstyBdnwCK2lQK7DVZRN7oPcX5LmJK+1SP7FdkTkBAE1k+KkUn6ozqAC0cmU984i6T2U0ItHGTTsliIleGo3mhpoBg1UY8E1eTgc9KnKgNH2BgZodzCr3HypO/i9uL8i0s56ssye7aBh7nEjUZt6EEocNqplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POdWqnXe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382378f359dso125076f8f.1
        for <cgroups@vger.kernel.org>; Wed, 27 Nov 2024 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732741503; x=1733346303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
        b=POdWqnXeKGMNU4VUevAKmKUJEXYyfv7sqNVyGKgLJw7TPjfcTZSULBQ7zI5cxjslbK
         +ogbHh69w09Yc0tKzCw4hhg6KCPLVmokbVvVKFfQTy9LKSU8XBSHbZIFB/i9DkvLvYh6
         XyM6QbusuSVUrzRjlxRjJm4AyGQogjLqGIDqPlh4bPi+QDn3neGzV4de9suFr/SL3t1r
         gPX8ADI3VznXsg+IXdSZ1PDEQFjNZMZLOE3LskM+Lu2YehD8YcnQ5r1laVXlwPtne3pG
         JujDq/iie3FLtUxuLSyEY8LOWxDNyeIXyvJf3La+WvukyjXS+sD2NT6IfZwAEVwD0gao
         Xahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741503; x=1733346303;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
        b=jxA1ccTKLnXsmQmUqa29OUBq03Nk2007O5QtVsscQ7RBKMcp2+YKSSllJmgF8+ziFB
         9SP6ZsKdwobXSZmYqzBjk43VMm3Uggcna8w3MjWXc7rHFWX9X0n6WeM/FtjDr3WPSUrm
         rJ2sLH1whSbz6ikWkzqJvoO2yJx4agNn1k/28lkLDrEyjQ24TffbfAuzQ3pPOTELIht1
         4YFVtd5tv0V27tygFYYwqsq7BuvjAuiID5L1chdz+Q3n5L5whYgnHnmNxpqAWwUNgRky
         GUjIES7m9OdRf0MBSpZIbcXI18PvJntEAr5Tv3D0vOTSSguTDF6OOqldc3pIWB0tgrkg
         ZFLA==
X-Forwarded-Encrypted: i=1; AJvYcCWyghLMrFMh1dnGDPtrIGBo84njXoCO+eb1DSEIC8FM1AIPAVEKXpdejoeGeCiwHcn3FRkESmZE@vger.kernel.org
X-Gm-Message-State: AOJu0YyElpfQNIBe+ca59h/WcA4xODIMwN0jHMh+0idfFwYneUYo7zYO
	dQfvjTKl07zh5WAijO1stVPX9IAovBuBxmhnokKRgbdudxBc+CBcra88Pps6Wr4tV+3y7avlwq3
	G4Cc+LbpT4Tw+yICYmSck6pjGYYaV8+K/zEfH
X-Gm-Gg: ASbGncsV621cE0FJHyQBsi0vLV7YhDuQWqXxEuhbP2o3N9WFUaWdY3yTwPvUjQU61CY
	pqDV3BdYaNS+1SS4yhHFrjcG2+e0kFY+G
X-Google-Smtp-Source: AGHT+IGdFse4RAD6QkqDKI9fg4urdam3vMe+wtZk8AzXAJMsg+euTEP9GHYvdmww+9BiM+6zarTRyeFOqpLdC56Zyyk=
X-Received: by 2002:a5d:6481:0:b0:382:415e:a139 with SMTP id
 ffacd0b85a97d-385c6cca2a1mr2970566f8f.7.1732741503292; Wed, 27 Nov 2024
 13:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 22:04:51 +0100
Message-ID: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
Subject: [QUESTION] What memcg lifetime is required by list_lru_add?
To: Dave Chinner <david@fromorbit.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Linux Memory Management List <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear SHRINKER and MEMCG experts,

When using list_lru_add() and list_lru_del(), it seems to be required
that you pass the same value of nid and memcg to both calls, since
list_lru_del() might otherwise try to delete it from the wrong list /
delete it while holding the wrong spinlock. I'm trying to understand
the implications of this requirement on the lifetime of the memcg.

Now, looking at list_lru_add_obj() I noticed that it uses rcu locking
to keep the memcg object alive for the duration of list_lru_add().
That rcu locking is used here seems to imply that without it, the
memcg could be deallocated during the list_lru_add() call, which is of
course bad. But rcu is not enough on its own to keep the memcg alive
all the way until the list_lru_del_obj() call, so how does it ensure
that the memcg stays valid for that long? And if there is a mechanism
to keep the memcg alive for the entire duration between add and del,
why is rcu locking needed? I don't see any refcounts being taken on
the memcg.

Is it because the memcg could be replaced by another memcg that has
the same value of memcg_kmem_id(memcg)?

tl;dr: what does list_lru_add actually require from the memcg
pointer's lifetime?

Alice

