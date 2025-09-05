Return-Path: <cgroups+bounces-9745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2870B45E64
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 18:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6256587FC8
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBB2306B27;
	Fri,  5 Sep 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efkwbcX8"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9978D30216A;
	Fri,  5 Sep 2025 16:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757090462; cv=none; b=OJtnsyzKfK6X+RZJ3mBpvzshNzxsyur9FzlB83ebGRkN1t7mqV2A9TXpBenZE0AD7nS/29j+xu6m0GZkwh5a2C20AclS68Yh9lFTIoJahEWnX3xuepQzMECS2ngtJZRCO/Gz13GZzLqKsrBHBcHKCY8Dr0Sl/tHHGJ31WSebm6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757090462; c=relaxed/simple;
	bh=Qh44+KrMchxbyZzNEBpWM92pXYVg3F1xXhUYJE2PN/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qT6Svr14/hqc5eyEHEgAAyJt4EQuFiBI3pSNqd/EKA/2d9EiEcYN1g85FVnf5GiS39owRaHJ4Bl7kZAvnd3QcvyCo/3eFD1drBB4pmu7Kx0DhnuP0ovONCRAGEuLGM6F7pisdOizUG3Moi3mo+Mr3l/F+Jt72UPaDkMCziqwzYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efkwbcX8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3172C4CEF1;
	Fri,  5 Sep 2025 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757090462;
	bh=Qh44+KrMchxbyZzNEBpWM92pXYVg3F1xXhUYJE2PN/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=efkwbcX89plzfJzEg48sh8k7YYkmkxJSBYWhNyOeBe9Y0tY/BXHKee33RmUQqE68E
	 t09K7d7Vu6cYHQNVRQR0nEFOFgEKgv+WU4r7yzmtLeVXS6rZqNjTjYn22thVLZrqsS
	 WubgHnjKFQtwxkMo61pmXux28pf2im3VjfFawO74S55DouCewamdHuapuool25IMVO
	 xlaRNQGqkwVipd2QVFNKvrF9IAr+asFzsvthzQbyml6Qjx6hGxyEBmmeR2MBi06Dju
	 3a1IvSUX1LDCWAmIkFPKxntaoJudNpmO4G2fa4HVH4WmBszyDGz12XDCWd3Y2ZD0WB
	 nBeJ/VSnK1daw==
Date: Fri, 5 Sep 2025 06:41:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Subject: Re: [PATCH 0/2] cgroup: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
Message-ID: <aLsSnKz1WcYSwReG@slm.duckdns.org>
References: <20250905085436.95863-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905085436.95863-1-marco.crivellari@suse.com>

On Fri, Sep 05, 2025 at 10:54:34AM +0200, Marco Crivellari wrote:
...
> Marco Crivellari (2):
>   cgroup: replace use of system_wq with system_percpu_wq
>   cgroup: WQ_PERCPU added to alloc_workqueue users

Applied to cgroup/for-6.18 with dup para removed from the description of the
second patch.

Thanks.

-- 
tejun

