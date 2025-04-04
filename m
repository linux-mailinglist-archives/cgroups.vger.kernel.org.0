Return-Path: <cgroups+bounces-7367-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 392FAA7C4AD
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 22:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47AC1B6215E
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 20:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A38221D9F;
	Fri,  4 Apr 2025 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwNoKRvX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464E22157A
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743796828; cv=none; b=YilsS7TCER2vyUQdWnRwtoCPazO6Gz4HltKNo4LlY3KvJ22TSkhEJgC8pDTH+cruvIjKFtI6+eIw/CwAlT5ppsR+J55GKKsiecqKLjpHXBVoXqWtEmc0Q8UqKAUixCqeZISzLMKbr2kvYajFsjcTE7PFtnLAkazOIyM4anVSduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743796828; c=relaxed/simple;
	bh=youZVDSXWxqPeudTSAYG+CS7IXwWVZhbzznDqGM8d8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfyzkWUD07skWvfVkeJsRvNq5GUe3+M8EWiXSg344yqJtNUBPkzvPJeRmDWeXlFWRYKnLKKgZM7P4h4TKPZJvgd7posrs3sWVQUIejZw5oU4jUgW2qO+k/zWCE1+2nkr9Uoi5jHc2LS15JJIxPcZMU/GZme9QkN8/VRPUQXnx6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwNoKRvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE497C4CEDD;
	Fri,  4 Apr 2025 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743796826;
	bh=youZVDSXWxqPeudTSAYG+CS7IXwWVZhbzznDqGM8d8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lwNoKRvXMYm3seTbKqwJUlf/HLvj3LAOf8r1PrexfOqgjwSF1bqMAiuzlOVcFK52X
	 2Q/FbmtqS1hYzQnDgnDg8BvWDDF4DlpyYAGmCRSBz0UxOZhxigYgC1l7YrPywHmDTW
	 5nYJ+XOdD/YPmeRGXWhaWjYZz4ZKan19DPI/yF8NhMICYnjk0gedw/Ol/qdJle7saK
	 N2krKhEtIG95PLKHF0o+31PEW3PAGmNGaQGYsdTyHZQjlfRcR3JJ3EgFaLDaPpGZvg
	 b3KZO6sEc1F4mNV5h6taDCiaGX7BW0Q9irZ8/DI10hazvfbwPpxqSQ5comajD3CREH
	 5ODDvGhlUqhPg==
Date: Fri, 4 Apr 2025 10:00:25 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 3/5] cgroup: change rstat function signatures from
 cgroup-based to css-based
Message-ID: <Z_A6WXpNcybYssn6@slm.duckdns.org>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-4-inwardvessel@gmail.com>

On Thu, Apr 03, 2025 at 06:10:48PM -0700, JP Kobryn wrote:
> This non-functional change serves as preparation for moving to
> subsystem-based rstat trees. To simplify future commits, change the
> signatures of existing cgroup-based rstat functions to become css-based and
> rename them to reflect that.
> 
> Though the signatures have changed, the implementations have not. Within
> these functions use the css->cgroup pointer to obtain the associated cgroup
> and allow code to function the same just as it did before this patch. At
> applicable call sites, pass the subsystem-specific css pointer as an
> argument or pass a pointer to cgroup::self if not in subsystem context.
> 
> Note that cgroup_rstat_updated_list() and cgroup_rstat_push_children()
> are not altered yet since there would be a larger amount of css to
> cgroup conversions which may overcomplicate the code at this
> intermediate phase.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Applied 1-3 to cgroup/for-5.16.

Thanks.

-- 
tejun

