Return-Path: <cgroups+bounces-11667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C43F1C4022C
	for <lists+cgroups@lfdr.de>; Fri, 07 Nov 2025 14:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8223ACBE1
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 13:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA1E2E6CD5;
	Fri,  7 Nov 2025 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csAjAb7m"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7264284889;
	Fri,  7 Nov 2025 13:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762522489; cv=none; b=il3Io0WhC8bYNAm8hXTPrVISgdAmXWPu8qRfzF0T95TGy/GkqaSjhxPlv7LlvSD5Hfp3vyo20BOObSsZMlgokQKidh6QkypKEj1FzGlicseojUhxC0m2NutHp41BGBvOg0Nf6tNT2Kj3K0Gs42AXVkmyEGrIybGfLrd8b1l/HmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762522489; c=relaxed/simple;
	bh=GZ1aR9vyKGpOf7GGJN4F566g8/j1fnBtFxg9TQ8LTV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUKHZlqO4Wkii9uGCaqHDSDaEJhR0NrDXN6DvwqFwpQ8Dwer0XgjMYq2ZQUez8tBpLqmFD2xZ738u8EM2s7HuZng+0Y/zmsdHn2nhZTK8YKp4VoxXrayUy3/RM4qdKeRHLBDaROJuUpdi07pY1WDsvFhxexnCuYFihjaVECBbBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csAjAb7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C94C19421;
	Fri,  7 Nov 2025 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762522485;
	bh=GZ1aR9vyKGpOf7GGJN4F566g8/j1fnBtFxg9TQ8LTV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csAjAb7mGFsqx+jfwzUVkcCZbX87Qv5IOMRvCXEF9CB+kgSMXusMQRfkWRBzmUX9f
	 hbMA7FSl2VHpww5ujPh0o1Sl8uSpHbQyDj3QyriTWqBLq5NBbrYKkw45orJAAa/tsc
	 X1CiWgQzFTwixR/ZIjdZJiRj+L9CXOX59g5vULlBUZ1mAqH1MfyEofeiSjz4jNSjdT
	 mWMu5UKmjJym4wNFYvtovGe9NJB5gtsXXPIpwA4mHq/YoHsElg/ZzZ3vY1+ROnyH7R
	 IvihDf2vhihy0H/lL2evyqs4eb2rQP94wsJRRlObud+hFnceAyxAQyBDCn+chkkDXH
	 /LKH38exKdo7Q==
Date: Fri, 7 Nov 2025 03:34:43 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
Message-ID: <aQ31cwAFCS4Tvb7T@slm.duckdns.org>
References: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>
 <5r6yyuleoru7h6wcbdw673nlfzzbsc24sltmfg5hk2mj6a34xa@2xo7a3jhhkef>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5r6yyuleoru7h6wcbdw673nlfzzbsc24sltmfg5hk2mj6a34xa@2xo7a3jhhkef>

Hello,

On Fri, Nov 07, 2025 at 10:57:54AM +0100, Michal Koutný wrote:
> On Thu, Nov 06, 2025 at 12:07:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > css_task_iter_next() pins and returns a task, but the task can do whatever
> > between that and cgroup_procs_show() being called, including dying and
> > losing its PID. When that happens, task_pid_vnr() returns 0.
> 
> task_pid_vnr() would return 0 also when the process is not from reader's
> pidns (IMO more common than the transitional effect).

Hmm... haven't thought about that.

> > Showing "0" in cgroup.procs or cgroup.threads is confusing and can lead to
> > surprising outcomes. For example, if a user tries to kill PID 0, it kills
> > all processes in the current process group.
> 
> It's still info about present processes.
> 
> > 
> > Skip entries with PID 0 by returning SEQ_SKIP.
> 
> It's likely OK to skip for these exiting tasks but with the external pidns tasks
> in mind, reading cgroup.procs now may give false impression of an empty
> cgroup.
> 
> Where does the 0 from of the exiting come from? (Could it be
> distinguished from foreign pidns?)

Yeah, I think it can be distinguished. We just need to check whether the
task has pid attached at all after getting 0 return from task_pid_vnr().

Thanks.

-- 
tejun

