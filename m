Return-Path: <cgroups+bounces-9719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BEB44C78
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 05:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D817588255
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 03:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1602192F2;
	Fri,  5 Sep 2025 03:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp8KnX9I"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023A64C9D;
	Fri,  5 Sep 2025 03:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757044085; cv=none; b=YKQag7hnnOr2zwvQysmcBTXeKxkfg1AHeW0vXLC5qfcIzz+5qkDugRq8ShEMjxlBT4Xw1DFlkuSktss4sEsMzu21CaaL0my850hN2c2iAI6xNX8kxzzt8f2UcZ0inXm6pnu5bbaQ2GZEvaABYaym6hmhFiBAxY2cnNW+WIxmkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757044085; c=relaxed/simple;
	bh=OstQ+gHlYUNskQWvqAm5SYvrRSV9/LakS6DjfmTbYj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCseOgbLzAXTzWPneB0/gjiFR5hFr9IALAGwNDS/lyWpv+iIisn0bu+aZNK1yBKmJlpdGqplIoXS5QTrAJyM8G/kmHnGOVzmAgpk95G+tibb8IxWqtwpVW4Dy8c84CHCeeTHvdMf8WmcptZqn0Eh6M82UDet6/r5qqIfUpN6zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp8KnX9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E20C4CEED;
	Fri,  5 Sep 2025 03:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757044084;
	bh=OstQ+gHlYUNskQWvqAm5SYvrRSV9/LakS6DjfmTbYj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mp8KnX9I1XsiwMQ0EJxMeU2dZvdXujvJnkJ18/Dyk35QQpyoah3z/v9Tw6xuCkQc+
	 Tf1QUY19s/ozaWu6qbUG1Q7cZGCoO0ZSpTm6nQmg0rmJsVDYcuDTYqJQ7NcVAwC53J
	 Xeu4fTsTnnIgFsptOSODATTjuWYWtgFQlm60+KN/FUJ4N914I4ot8mPzI04Hc+7z/r
	 Fof9fDchnbDeRGagP9auCAyVrtvkYJXNxsy0p/FCLpH86L2fH7LJQ9lUMw+8nYIzxR
	 hGXKXze7fPygOm3+O8sSgMxHdnLVeMG+bqWL5ZXSKm9dfvj62oZM6qGJWiQZhadzM6
	 RUAc60hbnw+ZQ==
Date: Thu, 4 Sep 2025 17:48:03 -1000
From: Tejun Heo <tj@kernel.org>
To: escape <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with
 signal_struct->group_rwsem when writing cgroup.procs/threads
Message-ID: <aLpdc4oDdAxvtUQT@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1756985260.git.escape@linux.alibaba.com>
 <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
 <aLm-2Lcnu602AB85@slm.duckdns.org>
 <11edd1da-7162-4f5a-b909-72c2f65e9db7@linux.alibaba.com>
 <aLpKr6_r5exdc3EQ@slm.duckdns.org>
 <93b146e5-08e4-4c10-bb90-8149e82263f0@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b146e5-08e4-4c10-bb90-8149e82263f0@linux.alibaba.com>

Hello,

On Fri, Sep 05, 2025 at 11:44:53AM +0800, escape wrote:
...
> To avoid the complexity of runtime changes to favordynmods, perhaps a
> better approach would be to introduce a separate control variable,
> configured via a kernel command line parameter such as
> cgroup_migration_lock=[global|thread_group] to explicitly govern this
> behavior. What do you think about this approach?

Can't you just down_write threadgroup_rwsem when flipping the flag? Wouldn't
that provide sufficient synchronization?

Thanks.

-- 
tejun

