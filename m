Return-Path: <cgroups+bounces-5483-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237269C254D
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 20:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD7A1F25914
	for <lists+cgroups@lfdr.de>; Fri,  8 Nov 2024 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63104233D86;
	Fri,  8 Nov 2024 19:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="TLUeNCbH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CE3233D80
	for <cgroups@vger.kernel.org>; Fri,  8 Nov 2024 19:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731092566; cv=none; b=UMjOjPjLxbtP6f+t1z1fgLwkoSzGpiNzV3M09fIXph8y+LOpM2GXeW7eUKqHHHWH7QJNLL7sGWIpoDASNJLcdSPfS+d2UfM1aZf2ArO1N5yzuC8H9G9FuCWdfhs3yoarbZ6S/26/04cVC02krpe70ymC4Ky4/pxb6I49b9hxgVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731092566; c=relaxed/simple;
	bh=J3Z26vWJ0Ua0F35/x/+Ws2PE3zLemr5ygJ/FVE2QBG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDZJ2KpDzKxNu8aWAJHpNXEYV6AqYFt75UnasyU+jymUlbbKsK796u1T0EkjjW03H1y5fwfpT87QB/vXUB7aXyHoHQkerygPHG3or0bb4WC9zp6cbUcyBuHzcOwE/hL3ncnVKaMSBqKv0e9vTasMpS55eydG0bUeQYdlckLFOY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=TLUeNCbH; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d18dff41cdso14539696d6.0
        for <cgroups@vger.kernel.org>; Fri, 08 Nov 2024 11:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1731092561; x=1731697361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81ZMx+RGiqmljfOo8CBnJJ2cfz2vJRL0QuZfzXnhKEw=;
        b=TLUeNCbHUdcjbKj2p5y+x08tADtkqIb5U1w99nbPbRQT1+mw+dwrwM00Eo3x+REYjl
         YXomRjRjTkaIglhNfAi1PpY4SrhPDSSCEYbppaVr12kHWLJiAMujduxGnLBnwPMi5Pag
         6s0KRU0BhKJdTI2u729X4NNf7as5a9BUY1F0Wcg4bOSKfB0DU+KxX1gqGC7nlurQxrY5
         w8Yf1MYWBvuAhXjvtQRm9rvP/ReyTLvrnCr3sqB51+bJaVbEXaVEUm+EgICo40T0ixZD
         W3Tw6YqUJELyEtlLk8dNjdkPZoDuCQcRiA/H8j7Q2eFLZ1pF4ZN8EZzoioXFtlxGWDsl
         DBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731092561; x=1731697361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=81ZMx+RGiqmljfOo8CBnJJ2cfz2vJRL0QuZfzXnhKEw=;
        b=PLnrwEjtwFCsILjxDYATvPXhCYSeWztcEZ/nTxEheHLMLk+0Du2M4EUoH4tHRwqe2e
         Yy5xm/itDwjsSt/LRBjadEq9uIqOoQHnmurfUnLcAKssfJxdA6aRjVxAn4igw7OIR85k
         ScyEPfoxaVsvsaMR9z32hLtzmmW+KpbliiMR5RF65koKZh84CeIZEnRRhAfVghngTpLw
         ahp/JGto/a7NwBY9E1a03Nc4YY4Y6poJFB1AAPDdmvwuh+UC9jmll7MbdkrbU4BeoDqB
         0CmaT3NDuOQM5bmiv5OEtHMJRLje4gOBA3nKqWgJj3jHOBFfj+/L6BvPm9cRw2RJ8lFo
         2/OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTSaETR6Ak8uNKin0MhOMovU9Szec1L5OYNCOLXBqhi26OE3wRCBIrT/T+yqvMj54khnyr2mwX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5eShgl9eTUkbVcGfGdg3DzqGHB/ZgRK5f3r8bLDbUOaJkXRR
	Tey6/KdoKcLVmCLx7XXqyTsiELEXUG9BsW5UTXXRsDBdNIzEoiAmbLt9ILeEQQ==
X-Google-Smtp-Source: AGHT+IFXvTD+JCQH3xCv42hH5FsEM2PDtDsiGfaxLcdpCYJgiL0EpAKzrCx6enhhTbUIpMOoZ64rbg==
X-Received: by 2002:a05:6214:5d8c:b0:6d1:8755:5cbe with SMTP id 6a1803df08f44-6d39e166ce0mr47184606d6.8.1731092561074;
        Fri, 08 Nov 2024 11:02:41 -0800 (PST)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6d3961df2desm22447296d6.21.2024.11.08.11.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 11:02:40 -0800 (PST)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	weixugc@google.com,
	rientjes@google.com,
	gourry@gourry.net,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: Re: [RFC PATCH 0/4] memory tiering fairness by per-cgroup control of promotion and demotion
Date: Fri,  8 Nov 2024 19:01:51 +0000
Message-ID: <20241108190152.3587484-1-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920221202.1734227-1-kaiyang2@cs.cmu.edu>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

Adding some performance results from testing on a *real* system with CXL memory
to demonstrate the values of the patches.

The system has 256GB local DRAM + 64GB CXL memory. We stack two workloads
together in two cgroups. One is a microbenchmark that allocates memory and
accesses it at tunable hotness levels. It allocates 256GB of memory and
accesses it in sequential passes with a very hot access pattern (~1 second per
pass). The other workload is 64 instances of 520.omnetpp_r from SPEC CPU 2017,
which uses about 14GB of memory in total. We apply memory bandwidth limits (1
Gbps memory bandwidth per logical core) and LLC contention mitigation by
setting cpuset for each cgroup.

Case 1: omnetpp running without the microbenchmark.
It is able to use all local memory and without resource contention. This is
the optimal case.
Avg rate reported by SPEC= 84.7

Case 2: Running two workloads stacked without the fairness patches and start
the microbenchmark first.
Avg= 62.7 (-25.9%)

Case 3: Set memory.low = 19GB for both workloads This is enough memory local
low protection for the entire memory usage of omnetpp.
Avg = 75.3 (-11.1%)
Analysis: omnetpp still uses significant CXL memory (up to 3GB) by the time it
finishes because the hint faults for it only triggers for a few seconds in the
~20 minute runtime. Due to the short runtime of the workload and how tiering
currently works, it finishes before the memory usage converges to the point
where all its memory use is local. However, this still represents a significant
improvement over case 2.

Case 4: Set memory.low = 19GB for both workloads. Set memory.high = 257GB for
the microbenchmark. 
Avg= 84.0 (<1% difference with case 1)
Analysis: by setting both memory.low and memory.high, the usage of local memory
is essentially provisioned for the microbenchmark. Therefore, even if the
microbenchmark starts first, when omnetpp starts it can get all local memory
from the very beginning and achieve near non-colocated performance.

We’re working on getting performance data from Meta’s production workloads.
Stay tuned for more results.
 

