Return-Path: <cgroups+bounces-8276-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97035ABE115
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C6781BA49B9
	for <lists+cgroups@lfdr.de>; Tue, 20 May 2025 16:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024FF27BF6F;
	Tue, 20 May 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MAL9HM2n"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB7A252297
	for <cgroups@vger.kernel.org>; Tue, 20 May 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759707; cv=none; b=ZZFlRvhfdC7IM6ajQUIfBNDQyM8nJIQOBT3L11/uCW0gVeh/3EepHHLp7V5rII9voTa7xT03b4z8/Y3x7rSdshQWYmqtjJYjEwenKNrYTmsilu4a2Q2So3f3t75SWn9eqoMKs0zBzxZdsYlnzqFhkR00WcQEg4L0e5+cukWA8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759707; c=relaxed/simple;
	bh=VKOLyd+fTgXxi0xSU7seE7QvEy9DHjhT9JyUqMZjDXk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CaE+bnsJSEqOTCPSf4qySIRFy8naI4uh+74zJR8iPjfBSSkKxs0i7qdTP2k9OmPV4OUEOWuXmvFmfEcUgylUCR0QiwKlovd3ciPBqVS/Y5fJAE1ruw6ADweL34b5ZbBPshMkjbxBvCHfRKFFXReAXGK7dg3InBk5dsxItPYSY84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MAL9HM2n; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30ed6bd1b4cso3881698a91.0
        for <cgroups@vger.kernel.org>; Tue, 20 May 2025 09:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747759704; x=1748364504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcl6TqUwD54tFkNVg+Ri/3Cun2a33c9FWRAhj6V56jQ=;
        b=MAL9HM2nG1K00TOdPGQrZMeQdy+sdujtHwdyk8bwp0aI9KalteiNX67XmAIs4Osnnv
         kGHhYbzi+jamSyQHP+eJ6Rzoc/RMGbmcSw3r2BoTrXHVRvI+IWi42BVnVTHEC1/OKRjK
         NW1XeGs2QNp73agFaMJtZ2Qru3L2QYP5n3pR70PevR+yW38HV682xxBaYg8q/dhaTj3L
         uEeFl/I4p7gq/FewAVotkSETtLS87Zho26NA5PfOd36hOuAr73jHQdyz4i6PQGvraYnF
         FzI/zlktwm8WGshF3G0q9ByYjQVvvNsixDomALSjMCxjtR7JdwbksLdrV4OsLid0RcEh
         pbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759704; x=1748364504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcl6TqUwD54tFkNVg+Ri/3Cun2a33c9FWRAhj6V56jQ=;
        b=YWJQHn/SClm157ZGhQF7WnGr4SOoOQbcebx3XsMvLKM4pMcLoviCwp7+D3rebDnuCH
         C7M5q3xLiBolpPCRAGEnqRXIJxZaiqh+vpe6GjBpB3IislfFbcjaRlWfcml3dkb1TOT2
         hm4lOhTywkn2Owe2fulU0f0GqvqoQHaO1jdfQijRZpz8ImXglhSP2BaS6zcGo/xKbpUj
         OcWlEpb0nro4VLlG1ngJAAMnwL2xCfiUmcbrVuaFnUhy/Pd64WVyPi5NMD+phWViRASB
         2Lsj3SDH2OxVlPT0S4lirfXe6L+rjQjgZQ1+DAr1E56AVBk9YSSQY32gXX5v094sWuZ3
         oTcw==
X-Forwarded-Encrypted: i=1; AJvYcCVSnykII2iJFRnSCQiBbJ9P2w4Bji6+hCmgUKSgGSa/DKSnGA8WPcHR+ZXgepQOvCQhcPwQ6Gh/@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnZnQvibYdB7PLSrNSh0KJWW4RK/wA+FUvbh0AICYKJChJpws
	qdKhu5oWwn3zqHSARMJdcfz5dp19v8ckNGoyPCy1Da/tGdx4+b2vFDylPx6KVof58O6/mVFZ5zb
	0/5n5dA==
X-Google-Smtp-Source: AGHT+IHWuapVqe0x+t6XHz6AnLhy46gF3CLB1xUoma8BHmFx0DTfNmTB/vRYZiHtoCJbxgU+GsCHbokk230=
X-Received: from pjbee16.prod.google.com ([2002:a17:90a:fc50:b0:2fa:15aa:4d1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:33c2:b0:2ff:58b8:5c46
 with SMTP id 98e67ed59e1d1-30e830f7b18mr26615931a91.8.1747759704142; Tue, 20
 May 2025 09:48:24 -0700 (PDT)
Date: Tue, 20 May 2025 09:48:06 -0700
In-Reply-To: <20250508184649.2576210-1-jthoughton@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250508184649.2576210-1-jthoughton@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <174767770635.2666521.3146495513676301743.b4-ty@google.com>
Subject: Re: [PATCH v4 0/7] KVM: selftests: access_tracking_perf_test fixes
 for NUMA balancing and MGLRU
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, mkoutny@suse.com, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Yu Zhao <yuzhao@google.com>, 
	David Matlack <dmatlack@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 08 May 2025 18:46:41 +0000, James Houghton wrote:
> This series fixes some issues with access_tracking_perf_test when MGLRU
> or NUMA balancing are in use.
> 
> With MGLRU, touching a page doesn't necessarily clear the Idle flag.
> This has come up in the past, and the recommendation was to use MGLRU
> generation numbers[1], which this series does.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/7] KVM: selftests: Extract guts of THP accessor to standalone sysfs helpers
      https://github.com/kvm-x86/linux/commit/d761c14d902e
[2/7] KVM: selftests: access_tracking_perf_test: Add option to skip the sanity check
      https://github.com/kvm-x86/linux/commit/26dcdfa01c33
[3/7] cgroup: selftests: Move memcontrol specific helpers out of common cgroup_util.c
      https://github.com/kvm-x86/linux/commit/3a7f9e518c6a
[4/7] cgroup: selftests: Move cgroup_util into its own library
      https://github.com/kvm-x86/linux/commit/2c754a84ff16
[5/7] cgroup: selftests: Add API to find root of specific controller
      https://github.com/kvm-x86/linux/commit/38e1dd578142
[6/7] KVM: selftests: Build and link selftests/cgroup/lib into KVM selftests
      https://github.com/kvm-x86/linux/commit/b11fcb51e2b2
[7/7] KVM: selftests: access_tracking_perf_test: Use MGLRU for access tracking
      https://github.com/kvm-x86/linux/commit/d166453ebd29

--
https://github.com/kvm-x86/linux/tree/next

