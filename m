Return-Path: <cgroups+bounces-8018-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C1AAA9DE5
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 23:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE87F1A80313
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 21:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC526FA50;
	Mon,  5 May 2025 21:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIp4Rua3"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071DA247DEA;
	Mon,  5 May 2025 21:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746479738; cv=none; b=Ff9oe8Z6czU7l7brXv5yyQCjJXWeqr9e7YmrDn7Sv3oy6oY9wu/AbBpKztBRw5ZoNv5CQczgwN0vrEyDLrSba3IKzSOHRiRJFan9AGzt1WvMy5ManGU/eJ1QdLUBbZ2gjmyufDaJHpl3xDfSUzB96uGs736Ep2ca0P0895Ox/oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746479738; c=relaxed/simple;
	bh=xdjmzuLq+SMnhJMs0RqB8PEpdL3mvHuKR3yY5bpucYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V7x7XRVZRVVAobGQbNrgjFL+bOpctF/hF65GOS8ipAxT5ksytsqqDOOfqusoqJ5VAKkIlyhjnXZQ+Y6UZMxcJyXQFqsmVfWWXPvVsJ4a494TsHphlKVS1FNdBfVvsmQY1oZfnuw6wSw1cikMSO7/U07DNEimTjVDTKPNkFdTDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIp4Rua3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D524C4CEE4;
	Mon,  5 May 2025 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746479737;
	bh=xdjmzuLq+SMnhJMs0RqB8PEpdL3mvHuKR3yY5bpucYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIp4Rua3OfqGZldIQ109NcemQu18wIdSy+ZQAFi3e/4zgqYiKglpXbxXe3S1vsZg8
	 U9vDTPrpfVLBoDD/QCNPh1sv1ZWM1zHmG03EJnz9kzF8Ksu4fbrdMHlKKFxAkEPq5m
	 IrXgFWEzWmMCY2AzKhzaovrh5CdgOg7k7aiXk228aTAdsjAW7Kv7MeDQlc/U/7fe6B
	 k7cCEamsp9TZANyWUCWPbjVZ+oF0zbeTA4CoTn1z+3bE+3vteTY7vjQ/UcpmMGuxwu
	 Kzb0zeFKwZRRtAfMh3zkk7XithPlnHT/yc1YW5F04vz/Q2TbEvKzgzUYXcCefMadk8
	 3pBBvBHTOrWbw==
Date: Mon, 5 May 2025 11:15:36 -1000
From: Tejun Heo <tj@kernel.org>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [PATCH] kernel/cgroup/pids: add "pids.forks" counter
Message-ID: <aBkqeM0DoXUHHdgq@slm.duckdns.org>
References: <20250502121930.4008251-1-max.kellermann@ionos.com>
 <bbublxzpnqrzjq5rmmbp772w2darjoahlewqky7caanaknglbx@6wuy5nidsnu3>
 <CAKPOu+_8cbUk=8d41GQGOvUrmG9OuaNVuSQrksDcUQMyFc4tiA@mail.gmail.com>
 <aBUQ7EzmeWYCyLwB@slm.duckdns.org>
 <CAKPOu+_Dk7rLgc+5YbMd4xpcjz74XKnR1jkgaTxu81EvE-q1-g@mail.gmail.com>
 <aBjn8epxUXDOomiu@slm.duckdns.org>
 <CAKPOu+-DoznsDeAn+AvyPkKyUW33ouLCv18QAO_0_42yXSk-3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-DoznsDeAn+AvyPkKyUW33ouLCv18QAO_0_42yXSk-3w@mail.gmail.com>

On Mon, May 05, 2025 at 09:52:59PM +0200, Max Kellermann wrote:
> On Mon, May 5, 2025 at 6:31 PM Tejun Heo <tj@kernel.org> wrote:
> > Oh, it's not specific to the cpu controller. The cpu part is just special.
> > Please see e.g. how blkcg or memcg uses rstat.
> 
> Ah right. I have started implementing it that way, but it turns my
> simple 20 line patch into a 300 line monster. I still doubt this is

Hmm... let's see what the patch is like but I don't see why it'd be
monstrously complicated.

> worth the complexity, but if that's what you'll merge, fine!

Your 20 lines don't implement hierarhical behavior and will likely show up
in profiles at least in benchmarks on large multi socket machines
(especially if you try to make it hierarchical in a "simple" way).

Thanks.

-- 
tejun

