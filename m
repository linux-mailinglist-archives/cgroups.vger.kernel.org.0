Return-Path: <cgroups+bounces-11836-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A454C4FC00
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 21:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6304B18947FD
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54443A5E9B;
	Tue, 11 Nov 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1fZaOfF"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA2361DD6;
	Tue, 11 Nov 2025 20:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894654; cv=none; b=bDgDpFHfcYGXDlua19UVhEALqx7VRgAeUsHyT7TGO9iKArXha8DD+ZlVcPGtY82+HVTJFbVbuyrs/GCRXqlj/A4Fak+MrCfK4Y2fHPPW99NKXc3FDlGVX0Hr/YhwEgZC3qsE26I9Fs38uPnA2H4Kuvnbq8jvYEeX6C/1mxUnUbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894654; c=relaxed/simple;
	bh=eDxmszbWb19E1WNP67IbuAVTsXtliv6CkC4VxW7yHEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7SII994Zq2tChKhEBFt27fk21VwK1iZDLgf8QRpkUhtyZ6s8aia9UdDkr2YUC+lIynmjgLYuY18OXU726eEQey7faOUTDpU+c930gbjwMIiui8buslYs7NJqRvL0FgJxe/rulUzh+OfLewtAaI3HXJHu3mD//p9fOFZS5g9BeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1fZaOfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11949C4CEF5;
	Tue, 11 Nov 2025 20:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762894654;
	bh=eDxmszbWb19E1WNP67IbuAVTsXtliv6CkC4VxW7yHEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1fZaOfFNPdnVnnYgS934OSAZphKo12pEwMgeRtO1ntxcmJlBP0gt7Z72PQhaNTj/
	 zW0rQTyhEG4h2FIU+OwZeWZMfGpneRmoCZB1wzh0Mqu6Bn6k8kDTWrseM4rDpXk8dG
	 Qo6B2Z6aNVOYZ8LWs7cXT/y1xiL5J0LyZD4XO0WG71aOES+qCvDRim9RRsbacWEr8a
	 auPCCLTSFX8OrVGasLes7DWJuc/va+0QRf3i5x+sEJ1j6YC7qqMPvKV87To9bNxoFf
	 X1kZwaDlnN2tkT+cnmXWePeQCP3JvmKB9arYXB17FNltl43r25WhTAU2yadB7nRutL
	 lXmg8E/j68L9w==
Date: Tue, 11 Nov 2025 10:57:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH cgroup/for-6.18-fixes] cgroup: Skip showing PID 0 in
 cgroup.procs and cgroup.threads
Message-ID: <aROjPBLaJVSrNRvN@slm.duckdns.org>
References: <2016aece61b4da7ad86c6eca2dbcfd16@kernel.org>
 <5r6yyuleoru7h6wcbdw673nlfzzbsc24sltmfg5hk2mj6a34xa@2xo7a3jhhkef>
 <aQ31cwAFCS4Tvb7T@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ31cwAFCS4Tvb7T@slm.duckdns.org>

On Fri, Nov 07, 2025 at 03:34:43AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Nov 07, 2025 at 10:57:54AM +0100, Michal Koutný wrote:
> > On Thu, Nov 06, 2025 at 12:07:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > > css_task_iter_next() pins and returns a task, but the task can do whatever
> > > between that and cgroup_procs_show() being called, including dying and
> > > losing its PID. When that happens, task_pid_vnr() returns 0.
> > 
> > task_pid_vnr() would return 0 also when the process is not from reader's
> > pidns (IMO more common than the transitional effect).
> 
> Hmm... haven't thought about that.
> 
> > > Showing "0" in cgroup.procs or cgroup.threads is confusing and can lead to
> > > surprising outcomes. For example, if a user tries to kill PID 0, it kills
> > > all processes in the current process group.
> > 
> > It's still info about present processes.
> > 
> > > 
> > > Skip entries with PID 0 by returning SEQ_SKIP.
> > 
> > It's likely OK to skip for these exiting tasks but with the external pidns tasks
> > in mind, reading cgroup.procs now may give false impression of an empty
> > cgroup.
> > 
> > Where does the 0 from of the exiting come from? (Could it be
> > distinguished from foreign pidns?)
> 
> Yeah, I think it can be distinguished. We just need to check whether the
> task has pid attached at all after getting 0 return from task_pid_vnr().

Let me drop this patch for now.

Thanks.

-- 
tejun

