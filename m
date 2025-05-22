Return-Path: <cgroups+bounces-8317-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0BAC14A0
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 21:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784323B75BD
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 19:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86DA628C5C6;
	Thu, 22 May 2025 19:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6yVGDdB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F95A283695;
	Thu, 22 May 2025 19:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941084; cv=none; b=G1lYHD1IagpjoctgH4gIsVLqSME0naCRBrgapABoDBFkKd5rXU+UGH5S9pQlBkZ907NM9QBNzbpj+LOYdfRKRXH9/Y6k7mRrKdUMfnoI3x33vmbPW8rXyI/HRwYmHcSlvQ6xu8GGYcLi0d0/61hVFBBH7cLLqJDU5ihKG7tOgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941084; c=relaxed/simple;
	bh=d1GJR2yf3eXDuTrxjW9QBdEVd+3EjCiKg9xwQQxttOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlyBmPtx3kMkr7H9zKLLxhx4zSjgEa4JalY4cU0qxDoKEVA2d+D7SzYlP0aq9aghPz6E8QaALZ7J4Mj4sdYHqalhE+BTZNb4rW1ZTNTK4j0qQBjlW2J9ODNh597eQyh0CoahTonlxytGHo4RWLNllckoqme7Ram0NpiyVaFNH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6yVGDdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953C6C4CEE4;
	Thu, 22 May 2025 19:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747941083;
	bh=d1GJR2yf3eXDuTrxjW9QBdEVd+3EjCiKg9xwQQxttOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u6yVGDdBCzXLf2x8Ri7watNeTgW/rcP8rfsKl1ku2L1p4dUNyWsu75/DQxwrfIEP9
	 kmLs/sHBCIYtlBFS37Z03UAUddMJjdKG92PGcSkJnvZmZDKjLGZjdRv8swXYgGwt4C
	 K793tvJKoKJ8NkYeuRiLB4JGVc9iOoq35ipDTGwHFKamdCKxbog9gTpuw5pRFbz7eD
	 +kmzW7V9SVPrtFdxmz6VZiT6tYioko/FCkX1sJlZHKk8aRIAg8vhurQZCIMcychs9i
	 QcO3LvLFWcxfyJnhk1q9ytr8GuKhevoq/mztEFrLJ4Jb1A2XZ7vvZor3+w3dlin/8v
	 63nfkzQIXE+lw==
Date: Thu, 22 May 2025 09:11:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shinya Takumi <shinya.takumi@sony.com>
Subject: Re: [PATCH v3 3/3] cgroup, docs: cpu controller's interaction with
 various scheduling policies
Message-ID: <aC922rl2-mALroIt@slm.duckdns.org>
References: <20250522-rt-and-cpu-controller-doc-v3-0-483fc9cca591@sony.com>
 <20250522-rt-and-cpu-controller-doc-v3-3-483fc9cca591@sony.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-rt-and-cpu-controller-doc-v3-3-483fc9cca591@sony.com>

On Thu, May 22, 2025 at 11:08:14AM +0900, Shashank Balaji wrote:
> The cpu controller interface files account for or affect processes
> differently based on their scheduling policy, and the underlying
> scheduler used (fair-class vs. BPF scheduler). Document these
> differences
> 
> Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

