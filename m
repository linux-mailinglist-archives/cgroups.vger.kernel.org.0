Return-Path: <cgroups+bounces-9389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD56B34A41
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 293AD3B58C5
	for <lists+cgroups@lfdr.de>; Mon, 25 Aug 2025 18:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9674C30E85F;
	Mon, 25 Aug 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d36sH2kj"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6D30E83B;
	Mon, 25 Aug 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756146050; cv=none; b=lx2kKlAtAsZKnSMH7k0WSd9nCv8NV24kQC7BlRXFkGQ9O26LFr/dDdwF8asz+fkcJ+5P2kDPQVjnzTIRJ8oshSLILnJ8K6WgBrfjzLsMGUnnTHvGu4RXwj7V8lw+P255Q+It+rREuMC6yGEetDEDrcg4Jls5SI/Hm0jOswblRYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756146050; c=relaxed/simple;
	bh=sH5Vbg6kAzfq+SO3i7zbp2fLhoWlh6akYnjv6DHaJ6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKe5ifymHfyAfygJehoItFiyObkJlK2NW1aGx7+k1mfoI+CRG6g2A/B8Jb1GDAIlCHwJfSOgJrhtKJdxurCUjd/gWc/j14LNRIqGjc/pPaNN4W3sIilwe7M+pRj2KFzwrixLuP0FPRy+ETz3Pav1pxnppXsjS2rxz7P4VJt6/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d36sH2kj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD133C4CEED;
	Mon, 25 Aug 2025 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756146049;
	bh=sH5Vbg6kAzfq+SO3i7zbp2fLhoWlh6akYnjv6DHaJ6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d36sH2kj/I+V2RsxhnE82hYZqSWTTEnj2Hs/QUNadECZrljcXWMGF5Edywm86DQ8q
	 OmCifprpyMdAWU+SsptYEClH4J443X4wtfC2LgJ3tPEjYhg50xqhmv4wS0sbQPsHA3
	 mPQOYpUqb44YzWgzhrlDMz1vV6Bkx2+c2RGVQAfC5LBkW/mTSvrq3w3oa+e3Ubdyi1
	 fozU39/05j5m/qovYer7Kkknb6OdCXDYwct+gBQ/I3HsTcebbXZE+PZGv2Gi2aRBfn
	 8Ik1delSdopJEQuYRDzOixkvusssCQnVnWoOSwXFtEzkarUHHxOpxexKoAmk6rYlUV
	 9+FkQb0Yvn0wQ==
Date: Mon, 25 Aug 2025 08:20:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next v5 0/3] some optimization for cpuset
Message-ID: <aKypgAoAT1ip6hyR@slm.duckdns.org>
References: <20250825032352.1703602-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825032352.1703602-1-chenridong@huaweicloud.com>

On Mon, Aug 25, 2025 at 03:23:49AM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> This patch series contains several cpuset improvements:
> 
> 1. Decouple cpuset and tmpmasks allocation/freeing.
> 2. Add cpuset_full_[un]lock helpers.

Applied 1-3 to cgroup/for-6.18.

Thanks.

-- 
tejun

