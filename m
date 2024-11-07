Return-Path: <cgroups+bounces-5464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AC89BFAA0
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 01:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2FAF1F223EB
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 00:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EA11372;
	Thu,  7 Nov 2024 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGhbfO9z"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28604A06;
	Thu,  7 Nov 2024 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730938879; cv=none; b=r0SLMbYhSo3E1suOZqsypnUUn852GFgYU2hTRKG+wdwCBHJhGtEDo7k181/mUJSTQGK7MdebpAdccXbDII35mgVK3bCZ6W3MxcQ0ZKnlgqEkbNUn1HWPqOOv1b+s92kcpguayoMOQKgvw4C1tthOyVckJt4PU1/A0eMx9WRnXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730938879; c=relaxed/simple;
	bh=psQixYFDJlslInBMg5OWxzp6Dooki/nhJXKMLVZag20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jrsTC3kBhV0peXazUQ02JBl/wlG4nsNEEU2nUSX3z1W8a5DvSkoF0bk+JbpOD/zVIxbuRuQD6WEhH9tBRkagdeiEgcS40DeBIN5fVU31KqxrNe1gxWnLK8ytL+NJ1odyjcUPLYc0F8BHz4hbJ6fEfHecDAPw0y6G2RNHHW6wjl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGhbfO9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D4DC4CEC6;
	Thu,  7 Nov 2024 00:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730938879;
	bh=psQixYFDJlslInBMg5OWxzp6Dooki/nhJXKMLVZag20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGhbfO9z/u8YWwDARFmjp/GW8EdnwxG2DiPRgeChafJfRbG1Jy3DwaBobEpjFIk8P
	 6gU6PzaxB+Cv66s68jAaRDpcc339rzyBHT0NZg3rYr7/uSw8a/cV06wrSJOTrEdAor
	 fKogoY5K5GwvHWfntQNN9rY8D3NsTbFSMZhqtoZAaex989Mn0zUKRqRpieG5Q/smA/
	 iyCo7MZCPKFMP4/NBfz1FLAopqyCtGTFfkOYHa7V/reqjqbitlUVVl+a2pXDTC8zx9
	 a91/EA/3Qhbn3VuhYiNlNo6HzersFJAmAx+gGaRIZ1oTHF6tnaY0ZO0jKkQGIpDoJp
	 2Igq0t/MyPlQQ==
From: SeongJae Park <sj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/2] memcg/hugetlb: Introduce memcg_accounts_hugetlb
Date: Wed,  6 Nov 2024 16:21:16 -0800
Message-Id: <20241107002116.55528-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106221434.2029328-2-joshua.hahnjy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 6 Nov 2024 14:14:33 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:

> This patch isolates the check for whether memcg accounts hugetlb.
> This condition can only be true if the memcg mount option
> memory_hugetlb_accounting is on, which includes hugetlb usage
> in memory.current.
> 
> Signed-of-by: Joshua Hahn <joshua.hahnjy@gmail.com>

Nit.  s/of/off/


Thanks,
SJ

[...]

