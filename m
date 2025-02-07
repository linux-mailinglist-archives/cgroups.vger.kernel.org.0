Return-Path: <cgroups+bounces-6465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A421A2CEAF
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 22:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91171188DF94
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 21:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408BE1A3177;
	Fri,  7 Feb 2025 21:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPCrQowA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E86195FE5
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738962260; cv=none; b=p/etltughljLEMkt8KeeFsHAw6EYE5t+v6aztRv6J7kJGAUTBW9GIkEUaw65m38bdyw/Ji9u+Rh1CXNm6XqUKVQZoyJOO4CzASY9Mek0Ra6SkjcdZadr8D9BRo8GLDdbb6Gf1eeP/8w+fRn68/8S3skld9cL+OxFG56IPBzufx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738962260; c=relaxed/simple;
	bh=oW9W12QJrBA1J7WPVxfot36hUwJCncRxOoiwaWYoVkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8b6JK5vamdZE7jgEXkwK6Irn9I8B4E7qOwTAl9gsFKpaCeNlVSb0BLdnfGKnOEuXk6kcYnEk1dO+/Z0OKpbWaPdlM6VWdLuwfLrceMeFVcYI4xXwJbrtOTeVwgO1aFQoXHf31nUiUboGibEX0HSHeH86yAwmR20jzHMQB6zPqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPCrQowA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C5BC4CED1;
	Fri,  7 Feb 2025 21:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738962259;
	bh=oW9W12QJrBA1J7WPVxfot36hUwJCncRxOoiwaWYoVkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPCrQowAhlVTP4/+n8m6u4fPn68e/P6Pxb0wpuaIeziMIH7OeNMC8quGSJh+tboeY
	 gc0zEQDfnyZpvgnZUXua8vlO+A9JVCXdQ1+xnTGcEarr6IzFtoKHhF5lPbrOXIDcVV
	 u3+2miVOunR1SiAv/DnmPn394e5GFp5VtyrdlAFyOjuB/wJbaQyrUSE16XBJVm/YOJ
	 vDHYyRGKNbn/UvdIOblJT92D8tAC32uBXqaoMvHhblES0gcTspYbmdvyVVl4G6cLEy
	 eRmIyE4htfal2SAVbMoz671CDKgRMpWxaMsqQvApn/QfU43kXPV+Qljaq/pjAn0btn
	 mGIVn4RHoiLwA==
Date: Fri, 7 Feb 2025 11:04:18 -1000
From: "tj@kernel.org" <tj@kernel.org>
To: Muhammad Adeel <Muhammad.Adeel@ibm.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>,
	Axel Busch <Axel.Busch@ibm.com>, Boris Burkov <boris@bur.io>
Subject: Re: [PATCH v2] cgroups:  Remove steal time from usage_usec
Message-ID: <Z6Z1UjQ2OGRmFAUy@slm.duckdns.org>
References: <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
 <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
 <CH3PR15MB6047F418ABF4B97ABE64B9A080F12@CH3PR15MB6047.namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH3PR15MB6047F418ABF4B97ABE64B9A080F12@CH3PR15MB6047.namprd15.prod.outlook.com>

On Fri, Feb 07, 2025 at 02:24:32PM +0000, Muhammad Adeel wrote:
> The CPU usage time is the time when user, system or both are using the CPU. 
> Steal time is the time when CPU is waiting to be run by the Hypervisor. It should not be added to the CPU usage time, hence removing it from the usage_usec entry. 
> 
> Fixes: 936f2a70f2077 ("cgroup: add cpu.stat file to root cgroup")
> Acked-by: Axel Busch <axel.busch@ibm.com>
> Signed-off-by: Muhammad Adeel <muhammad.adeel@ibm.com>

Applied to cgroup/for-6.14-fixes manually (the patch body is CR-LF damaged,
maybe use git-send-email next time if setting up mail client right is too
cumbersome?)

Thanks.

-- 
tejun

