Return-Path: <cgroups+bounces-8761-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D5FB09494
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 21:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE71C45C87
	for <lists+cgroups@lfdr.de>; Thu, 17 Jul 2025 19:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF261298CA1;
	Thu, 17 Jul 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXtshgxk"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B8C2153FB;
	Thu, 17 Jul 2025 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779371; cv=none; b=AxYRfleMTamBe9aiLWG06zsJXaATnYwvjPnR3Y9ER3xbVdEREpjr+iwwcGx1U6wO6SD/OaFqlVrMk1HwzSA4INvLldqMQ1xfD8cZvOyCv2Hn0rjzij/sete45HM7kbLFaIAVgxnaq41FMjNm6k1Tr06jL/FKynMFr/bgVkFgRwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779371; c=relaxed/simple;
	bh=dqjOThknCuJUZYUJdNUbL5TNDM3zO8Z9XspebF7i5gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt9lYWkBKzXR2/ICyrzRVdz920nlK01SfOo/RgFr+6OENll4vddUxyiQWSf85c/P+3FqTzFmHyaxYyhycUfR2xwtAhY0Po+4VeYkGrA4EliSdKt4uFkhFHDJ+9VKaQnJ0B8LTQDmgsPbHSgQGQk3Jw43ZMsCN4dqsb0Cf+NCCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXtshgxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC38C4CEE3;
	Thu, 17 Jul 2025 19:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752779371;
	bh=dqjOThknCuJUZYUJdNUbL5TNDM3zO8Z9XspebF7i5gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bXtshgxkYSKpOkvY0x38knUKrKqkLB/LvLT65wVgm6RcY767jnupRllHvWFhoQxaC
	 nWQmE/L3acyRxzK1TSeOiIU3Z6RHnzqrLU1W+MU4+lH9wonwIyvWtZFDB/m/70NAMa
	 fz5tWV6LX3L+WHiv1fA9am/foqZdgzIK1KyRsO/koRTGPirqMNXJt5eP1YSx4CPnVd
	 AUAazmDH101ePdkgKZbUMUlkeSGEzR47SUQLlvdLoCbPgHFKeKQ4nCIJPs0qm+fc43
	 IGYSvnuK7l9Cn+3w3lmBU1kwDVctKmY38VQlnIkHw8XRkgPrJR+n9AMaLqsZf7kRyZ
	 grKEy+09aVczw==
Date: Thu, 17 Jul 2025 09:09:29 -1000
From: Tejun Heo <tj@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
	mkoutny@suse.com, pavel@kernel.org, timvp@google.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, lujialin4@huawei.com,
	chenridong@huawei.com
Subject: Re: [PATCH v2 -next 1/2] sched,freezer: Remove unnecessary warning
 in __thaw_task
Message-ID: <aHlKabRMHvnSmtwg@slm.duckdns.org>
References: <20250717085550.3828781-1-chenridong@huaweicloud.com>
 <20250717085550.3828781-2-chenridong@huaweicloud.com>
 <CAJZ5v0jnUQJSBbYWfmGb6wr_CY3j61TSq_cR9KBMqtvxWrmsaA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jnUQJSBbYWfmGb6wr_CY3j61TSq_cR9KBMqtvxWrmsaA@mail.gmail.com>

On Thu, Jul 17, 2025 at 08:26:26PM +0200, Rafael J. Wysocki wrote:
> I can apply this one, but I'll need an ACK for the [2/2].

Ooh, I just applied the two patches as the original patch referenced went
through the cgroup tree. If you'd like to route it, I'd be happy to revert
them.

Thanks.

-- 
tejun

