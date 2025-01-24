Return-Path: <cgroups+bounces-6283-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6E0A1BE39
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 23:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F391A16CCA7
	for <lists+cgroups@lfdr.de>; Fri, 24 Jan 2025 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E51DD872;
	Fri, 24 Jan 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMs00Mvn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A71DB128;
	Fri, 24 Jan 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737756134; cv=none; b=OUQOC9E1LFRUxrKh6bXuIhuGJqjG0pEkJTLLDWyONHCoeTfdUUU9q6iaCgMYZXh0ywr5brClazy87IIrV4OJzndINaWrDqvPkBsnW0Pu72ot5UgONayF5L2NHuRDPH+xFnc+Inp8m/OwPCmT0tjp60gd+H91DgGPXgt7ZcFz15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737756134; c=relaxed/simple;
	bh=lLihE6XZZtN9yVgumbdWxb4A42CSEAsS/LOxYGjvpqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx0hlUJ6LMAFEbRryBIkHjLIzcCQvQKhXtSLkZ9yofiBztkULyL2GY3eENmu2F65adMpQsmGpvTlwHv/jhT0J7Z1CHZnT0I5RMCY/p6SPh1eUrKKEU5WJ3qq/o/XVQSuIrNuUZhAELtvmp7LaD2hr1sb6U3T7x4FyN50645KKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMs00Mvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47351C4CED2;
	Fri, 24 Jan 2025 22:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737756134;
	bh=lLihE6XZZtN9yVgumbdWxb4A42CSEAsS/LOxYGjvpqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMs00Mvn0wF26a5URlz5Gqrxny50Jn21G4gh65kTGOuOTiWHiM8qWnhYz3WLrbqse
	 NVDN1TiScwYv8x6SQ2HgHV8T+K8/8MjALkB/FdtFylGWQ1FvIxjNMewbms/9OplGyd
	 bLbEE3wzMlBxD4G+j9F09RzSW42tFscaziv9UxASLaWMhvI+wfYrXW/BNQ+z0AUhWi
	 LtcPyE078FfRDh8Pr9jRWF87d4HpNMDfmLcotVpzbVTQYzlP3ArBrG5h2zJtVVsY+K
	 jKPG2LfUezYTn4VwIOTGABUxONkcGQUiVycr0m7ORp9ClXQ7xO8WB6Z4NVhlg+v98X
	 D5Er7zWzozYhQ==
Date: Fri, 24 Jan 2025 12:02:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Waiman Long <longman@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Chen Ridong <chenridong@huawei.com>
Subject: Re: [PATCH v3] cgroup/cpuset: Move procfs cpuset attribute under
 cgroup-v1.c
Message-ID: <Z5QN5V0BOCqQzb5I@slm.duckdns.org>
References: <20250120145749.925170-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120145749.925170-1-mkoutny@suse.com>

On Mon, Jan 20, 2025 at 03:57:49PM +0100, Michal Koutný wrote:
> The cpuset file is a legacy attribute that is bound primarily to cpuset
> v1 hierarchy (equivalent information is available in /proc/$pid/cgroup path
> on the unified hierarchy in conjunction with respective
> cgroup.controllers showing where cpuset controller is enabled).
> 
> Followup to commit b0ced9d378d49 ("cgroup/cpuset: move v1 interfaces to
> cpuset-v1.c") and hide CONFIG_PROC_PID_CPUSET under CONFIG_CPUSETS_V1.
> Drop an obsolete comment too.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-6.15.

Thanks.

-- 
tejun

