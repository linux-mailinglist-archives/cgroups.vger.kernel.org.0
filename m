Return-Path: <cgroups+bounces-8903-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 932A8B1158D
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 03:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA891CE46A6
	for <lists+cgroups@lfdr.de>; Fri, 25 Jul 2025 01:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07178194124;
	Fri, 25 Jul 2025 01:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AH7sQmUG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E0E43ABC;
	Fri, 25 Jul 2025 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753405713; cv=none; b=hBz9IK7Bsg7xpb2qfyishrUet3a6aRP/45K9NTjp75n2B53pf19cjJabXoKZftG/8DoDxKujdvcWrFdqbkVmcmguEM+3sCpe9n1S6gBmL+xqqZhZdDoaFIcanUMXFvUnuEF05j95s+dk4ZAXLAuI2M2zJdEm9igoDHjkAJFVaLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753405713; c=relaxed/simple;
	bh=H/BgPUQANvlTWqgIAXAGOhv0SbRMbQQECIU5nmflkSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rn3jVJBHIDLtAhEATOsCT3/Nn6ivceV0HLxXEZHytIazU16ny+YIyXWsd9JPIgTOk74bNnv1zNQ21vkZmx3zailNoGWc5oiFwakF4gmDj9wkuHDFWHkotCiznbhwQOFT81uIp9rdFVsD0a354ty0UM7qZzcHHphEmpaCkpDReCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AH7sQmUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1781DC4CEED;
	Fri, 25 Jul 2025 01:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753405713;
	bh=H/BgPUQANvlTWqgIAXAGOhv0SbRMbQQECIU5nmflkSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AH7sQmUG2sSuxb1SOBDDq2VjnWKmpmZCRlQaE1DVpLIGOA5VLkq9OCOR/9B5UnNij
	 ox2+1eAwnsh4dloVlpDJqgcwh95zX/N7R4hWQQR3YZ6KI8G+h+Q9INm7+hlOFdRMLs
	 E8sHys+2KyGPznmixAhtyWLHh3o/45sxZndm1SGZqmaTqOg4lior8XKHmzO6KV2Gwk
	 8zoepBvNaiKt3QNQLiWMP8scg1Jz0LtqTWliz213wIIKhft4954CSlcZ5UsOD74REf
	 0367UyVK/CCxvDtez1pE+Edp45xgNnfWh9OUtTyMMKKi7Jv31zDq7mYDdm76V6U4RV
	 AANi/ENVe+uPA==
Date: Thu, 24 Jul 2025 15:08:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Tiffany Yang <ynaffit@google.com>, linux-kernel@vger.kernel.org,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
	Jonathan Corbet <corbet@lwn.net>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: cpu.stat in core or cpu controller (was Re: [RFC PATCH v2]
 cgroup: Track time in cgroup v2 freezer)
Message-ID: <aILZDyD4mPkiMrfd@slm.duckdns.org>
References: <5rm53pnhpdeqljxqywh26gffh6vlyb5j5s6pzxhv52odhkl4fm@o6p7daoponsn>
 <aHktSgmh-9dyB7bz@slm.duckdns.org>
 <mknvbcalyaheobnfeeyyldytcoyturmeuq3twcrri5gaxtjojs@bbyqhshtjfab>
 <180b4c3f-9ea2-4124-b014-226ff8a97877@huaweicloud.com>
 <jyvlpm6whamo5ge533xdsvqnsjsxdonpvdjbtt5gqvcw5fjp56@q4ej7gy5frj7>
 <e065b8da-9e7c-4214-9122-83d83700a729@huaweicloud.com>
 <aHvHb0i6c8A_aCIo@slm.duckdns.org>
 <2c723007-710f-4592-9fe2-7534eb47e74f@huaweicloud.com>
 <adrjkqsqqwxcsdr5z4wmxcrvgvutkulzgka6pjjv23v6242txr@vv2ysb46nhpk>
 <0064b782-2bed-4375-aba8-3745aa306a6d@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0064b782-2bed-4375-aba8-3745aa306a6d@huaweicloud.com>

On Wed, Jul 23, 2025 at 09:28:02AM +0800, Chen Ridong wrote:
> > But beware that the possibility of having cpu.stat without enabling the
> > cpu controller on v2 is a user visible behavior and I'm quite sure some
> > userspace relies on it, so you'd need to preserve that.
> 
> This is what I worry about. Thank you for your confirmation.

Yeah, this was an intentional decision - sacrificing a bit of code org
cleanliness for everyday usefulness. Enabling CPU controller can have
substantial overhead and having cpu stats available by default doesn't cost
much while improving usefulness.

Thanks.

-- 
tejun

