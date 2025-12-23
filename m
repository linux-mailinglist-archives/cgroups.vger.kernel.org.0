Return-Path: <cgroups+bounces-12599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CAECD7FCE
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 04:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112603012DD0
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 03:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50727186E58;
	Tue, 23 Dec 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ8EvUk5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2CB665;
	Tue, 23 Dec 2025 03:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766461559; cv=none; b=HpljxYPponytT4PocnS90QbYVykyFqlStzW8AirxrL4m3M4K/NrGi8Ep/5BjmZX0d+p/QVRX++zCso4kgNn4HoQlCJSYhdhwtmf/pSclre+Z1SGsLTvLom85C79pf3Aa3lyXkAtmi4P27R2i6ompgycJtGhldCJmUAsS4lsADF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766461559; c=relaxed/simple;
	bh=vsTABa2PEcZmQ4f+9wswUpQ7SiDvERegtlBHuJE21hk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VPEKJerbBLu9fK0xZkPuHB3M4ji0N9SEmJ0Vhtq2WKw2ccrkJrUcNGjOq4voyrFzHQQtxaXj66f0hLQZlQBad9bwh9xTcMr2k5194FMc9QbCblLlCEOyKdXnv3dIwTpJUcAMFGou1M18zYomim0ipwQgl/VYL5FWf74U4mRrkPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ8EvUk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F24AC116B1;
	Tue, 23 Dec 2025 03:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766461558;
	bh=vsTABa2PEcZmQ4f+9wswUpQ7SiDvERegtlBHuJE21hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JJ8EvUk5BAfKZkAIZR68RI55ZRPnb8v3KUYXCM44HnAj6u74vlxd6TunRGIpBnpBa
	 BPvjSOo/3zalo+qJonHTLjfKkOb4+N7hBEBlRTZpCEY4NP5tZQyMZXDCe9anAHcb5B
	 ARDxkPE1bGky6UsITf7HGPU9o01Lzbf1vy9o7LE93Q+mgnsvv89hHksaURxOcPorSP
	 gwxE3SjciESe1V6qWg/bP+QpvuGdVb3SQNnCCJAtuTNz5Qdf6FPnqF3QcUQJe9W2gG
	 FehQ7ubt+e2c2Sg7W2Ii0ZX5GysaIRrk0M7dKhUwTSeFhud7Fi3M+C26G3qpEbJbYB
	 3RiJTeRI+uU5g==
Date: Mon, 22 Dec 2025 17:45:57 -1000
Message-ID: <9b9c055c55e27a243d14b1a5199ade44@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 chenridong@huawei.com, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, dan.carpenter@linaro.org
Subject: Re: [patch -next] cpuset: remove dead code in cpuset-v1.c
In-Reply-To: <20251220101557.2719064-1-chenridong@huaweicloud.com>
References: <20251220101557.2719064-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.20.

Thanks.

--
tejun

