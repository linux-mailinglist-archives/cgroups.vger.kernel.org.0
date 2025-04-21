Return-Path: <cgroups+bounces-7682-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B17A95605
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 20:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD5DF1895519
	for <lists+cgroups@lfdr.de>; Mon, 21 Apr 2025 18:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3418DF86;
	Mon, 21 Apr 2025 18:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTW+Ual7"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24B34C92
	for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745260579; cv=none; b=t7+GeeR7yanG4knO7sFOW6qLgH/San+Gu6GkdqDJQTiK4iBetODSwUSjKV+nIeOqDao0AlfkIz78C+gQQJYCJyorw/7WZbjq2qmVf0Q5uj9M9bzw6uY46eXGupNwYpmZzfwC5YtGzrikVnqCQNyVhNfNSxeRHeGcrtu/RTCDEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745260579; c=relaxed/simple;
	bh=rxwpNYvlEactlJK8Se5s8RnQZj0ks1CLfULxvjosi0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKJCfiewJBldfapsjfASAjWMgQ76uznX23Q4KJ+jgf2DCfBXkBpEZzQdluGFcV0e3yhVQZrgIBiUpuTvTDFf5P/nUp5qcToucTwURbbFpCBhtGR199B0kTbx3txMhodC6aB93frCBA7nx17sCLhA5SB4zaG4lPkl11TGAZ+i2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTW+Ual7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29619C4CEE4;
	Mon, 21 Apr 2025 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745260576;
	bh=rxwpNYvlEactlJK8Se5s8RnQZj0ks1CLfULxvjosi0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTW+Ual7x15mtqsUSF1x6LGjzfhQxWWj5oDAVkA89SrlBIJzMxHILEBBzPruZMVCt
	 KK1zH2IFKuagK/5NsT6yCluyp4513X+DeIENp9A6C1vUaZXi0bg2wEZUmqjchc3fnA
	 QFnY929tsHJpNCLBxv4mGg1Ezx8qpzitLgssGkF7FgWkWhZ6hDXicr8pFNc4K/Xfau
	 23ZYYloBTZDIyjnxfwsFVO0026Bbk1cdMHMYvBTVXa6ELG1K2bq8Fn8kHQQKz8R5CV
	 5/4n2oO87QPtNaUWKDwCOnQgNlgyhS1sJ6QeBlCO9ree3wfDaK70ZpZSlSdMaBrKNl
	 R9TKsvOTld4mQ==
Date: Mon, 21 Apr 2025 08:36:15 -1000
From: Tejun Heo <tj@kernel.org>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: shakeel.butt@linux.dev, yosryahmed@google.com, mkoutny@suse.com,
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup: fix pointer check in css_rstat_init()
Message-ID: <aAaQH0ELDM4x9uA3@slm.duckdns.org>
References: <20250421165117.30975-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421165117.30975-1-inwardvessel@gmail.com>

On Mon, Apr 21, 2025 at 09:51:17AM -0700, JP Kobryn wrote:
> In css_rstat_init() allocations are done for the cgroup's pointers
> rstat_cpu and rstat_base_cpu. Make sure the allocation checks are
> consistent with what they are allocating.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Applied to cgroup/for-6.16. BTW, it could be nicer if you note the commit
that's being fixed or at least the target branch (here, cgroup/for-6.16).

Thanks.

-- 
tejun

