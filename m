Return-Path: <cgroups+bounces-8109-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06BAB1BA3
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 19:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DB02170DCA
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 17:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B002356B2;
	Fri,  9 May 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaCEFTrp"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F8945038;
	Fri,  9 May 2025 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746812049; cv=none; b=pmA47gSnxNTTuA+3CGzGQkDtPJh5z+r2h7/rxma1HYBLV2oUBDOC7+dPQpz0dmf0eV3thEAO6sqYthqifYJGOmxLG6EQr/1mXGKi4XKJ1mYb+dA0/K+MzsAQhOkPeN25sgj4Fgv2EZkRjXlYcGnWkdXgHZr4xn/UoUyjQbMiCRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746812049; c=relaxed/simple;
	bh=e53trJLIiasM3/I8mjGMp8lx597jgk1Qk4o/EcA/Voo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJBtCBbgXkVkcoO8cI0EpX25fMchOgyPR22eD/OaMHW2s3uPXOaM1B2FKFuaRO5ms080YFfPQYyWBPwRMkVo4klA4CUeZed2TdCPv40sZDjt2LzioH8/w7oIOcPM/hH5Jh8WiY8FkBwExPqM2+bOO1Ei14q/NQAokpbbtTAH8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaCEFTrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 939BCC4CEE4;
	Fri,  9 May 2025 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746812048;
	bh=e53trJLIiasM3/I8mjGMp8lx597jgk1Qk4o/EcA/Voo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NaCEFTrptqHHXDfAacN5iwpTLA0+hc+GSvv5yWTVIwEqaomXuDbXrVAAXQjsPL6GT
	 flaK+1Bg/olmlLF5LgCFXx1KMrMeOXdXpIfd+JgPCLGOPFkkshy5wbMaZcSWGrTcXf
	 SUizZI1RV6lQyyVVsZzYzbD4XONPllxTIigeJ7SDlu8EYsjwG/vEWS69K5+VKrRmfX
	 oSMBmYV61jRI3WHTf/QxSlaK7OIUyKqt66tJJGQJgN8MQN+BWjaCcWCQFMzrIdaPLy
	 eONL6JHcb3FGp5EHZVgiuZEaL87QyLulF3FPbMKt4IBj3dM05Z5dYVbwzXSfkLFoas
	 b39EXkPdIp3VQ==
Date: Fri, 9 May 2025 07:34:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Joel Savitz <jsavitz@redhat.com>
Cc: linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/2] include/cgroup: separate {get,put}_cgroup_ns
 no-op case
Message-ID: <aB48j10nArAWAVH2@slm.duckdns.org>
References: <20250508184930.183040-1-jsavitz@redhat.com>
 <20250508184930.183040-3-jsavitz@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508184930.183040-3-jsavitz@redhat.com>

On Thu, May 08, 2025 at 02:49:30PM -0400, Joel Savitz wrote:
> When CONFIG_CGROUPS is not selected, {get,put}_cgroup_ns become no-ops
> and therefore it is not necessary to compile in the code for changing
> the reference count.
> 
> When CONFIG_CGROUP is selected, there is no valid case where
> either of {get,put}_cgroup_ns() will be called with a NULL argument.
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Applied to cgroup/for-6.16.

Thanks.

-- 
tejun

