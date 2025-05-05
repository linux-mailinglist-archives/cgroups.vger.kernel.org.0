Return-Path: <cgroups+bounces-8009-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BAAAA990E
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 18:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C2B3A9B46
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 16:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F1199FAB;
	Mon,  5 May 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7kvudd0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80603189916;
	Mon,  5 May 2025 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746462707; cv=none; b=hcE0B4n0U+Lh4C5k1eDMpSlDIF02g9nPvoE8+n/xVz5H0/hDtTIcwLrW1EXSPXm9tMwQbfCiM0VNjitTIyJCHN/ACIWl9Loap5iy83jdzTXCCd0JZtJXZxwWdUU0or697pxV6Bbh4ud4gpsekROUxFx+BmU9w7x6bccUFtI6wOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746462707; c=relaxed/simple;
	bh=y1SP3R1X7Aw6BzogdM/E5QkLak2XRIYXi7HqJK2dPmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvOTKUYb3Hu814loaqcDvSSpDJcMZKw8qAXcZoMWIzgxkmr48z7e9QOp4IVUePgOKAoQ8hnEB1Tb+qT6Y6v56CqJnlbdjWl7jRtvb2DFsMXD1xgnjUg+OFsL5sFZXouUSeCEi028hoY9SSlGTlq1d02LyUG5sRPyjFYRj79jEow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7kvudd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED90C4CEE4;
	Mon,  5 May 2025 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746462707;
	bh=y1SP3R1X7Aw6BzogdM/E5QkLak2XRIYXi7HqJK2dPmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7kvudd0Ab1cGm3SdDLXmpjictZCSHAUfxyjUfEE82NWM0QrHATpJ5D3kG0HuAqvd
	 We0YDsouieVsRIfj59m0DcfhqwvW0uhuFWU368FbA0HWddcaVUxd6O8+oulQiJ17sq
	 fIJDOqQLykFtmA0D2k0Sb6mt1sNqExCHYlxZi1QXwykhy+11NaiwEqS+RuAN3JbXMh
	 /2c/rWFXLQp8TG8FzPWc0JwvNTPpiY207dHbBcEaKR+LQn+0E4zijuLz0WPgPdTUXC
	 rcoLvUzb5c7LM7Rv8dmmcD2ju+pLJclzYIcFTqx798+Ey+hwh6B5tTRBz6hDIL0Fnf
	 /5YVDzqP+Cwrg==
Date: Mon, 5 May 2025 06:31:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] kernel/cgroup/pids: add "pids.forks" counter
Message-ID: <aBjn8epxUXDOomiu@slm.duckdns.org>
References: <20250502121930.4008251-1-max.kellermann@ionos.com>
 <bbublxzpnqrzjq5rmmbp772w2darjoahlewqky7caanaknglbx@6wuy5nidsnu3>
 <CAKPOu+_8cbUk=8d41GQGOvUrmG9OuaNVuSQrksDcUQMyFc4tiA@mail.gmail.com>
 <aBUQ7EzmeWYCyLwB@slm.duckdns.org>
 <CAKPOu+_Dk7rLgc+5YbMd4xpcjz74XKnR1jkgaTxu81EvE-q1-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_Dk7rLgc+5YbMd4xpcjz74XKnR1jkgaTxu81EvE-q1-g@mail.gmail.com>

On Mon, May 05, 2025 at 02:49:09PM +0200, Max Kellermann wrote:
> On Fri, May 2, 2025 at 8:37 PM Tejun Heo <tj@kernel.org> wrote:
> > +1 on pids.stat, and use rstat and avoid the atomic ops?
> 
> rstat right now is specific to the "cpu" controller. There is "struct
> cgroup_rstat_cpu". And there is "struct cgroup_base_stat", but that is
> also specific to the "cpu" controller.

Oh, it's not specific to the cpu controller. The cpu part is just special.
Please see e.g. how blkcg or memcg uses rstat.

Thanks.

-- 
tejun

