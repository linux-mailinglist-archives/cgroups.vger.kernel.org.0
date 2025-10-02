Return-Path: <cgroups+bounces-10519-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A29BB494C
	for <lists+cgroups@lfdr.de>; Thu, 02 Oct 2025 18:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0CE1C3EEF
	for <lists+cgroups@lfdr.de>; Thu,  2 Oct 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B4D26B0AE;
	Thu,  2 Oct 2025 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eshjTMSZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3061A266584;
	Thu,  2 Oct 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423509; cv=none; b=CkTEvQyWnO16yL9Q4bpM39ukKCSp3etJ5HfXabadU+jQmAAWUnEAblAs4zaDntrdyZnmtxPcsc6qghXZqYb2WeIoppUXZAgOcRYxH97QlOIha+JqYY5T8BI5oAUxxLmeN2Z5NBTqfVTU6hOFcgxyvk5oJWggwFsYhsnPpzu9nCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423509; c=relaxed/simple;
	bh=A8BE/uZ4bRaKp1mPV9yFBcD9cYck3xUZ4rs0/g7nu58=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=JutvHfz+s8/UcfXjMnEvPQ757OcIByf4XQPBtfbGhB+NWeugoQEQMhyPttsTXZvkkh5pZ392AoyZaQrj/o422MQ53pDuVIc0loAH6Cgn9QYWvyLuUZl1u8yBJCZgSHHQHRIFT0WPOhpKlGesHOpx1KAo59OhqbKI8z/jWe93vTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eshjTMSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E597C4CEF4;
	Thu,  2 Oct 2025 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759423502;
	bh=A8BE/uZ4bRaKp1mPV9yFBcD9cYck3xUZ4rs0/g7nu58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eshjTMSZ9alS/XUJQfxwu1PfbQ2ytV+MNyfXNVV8GwjQ/NgB+T56MzIsEMBuWivDg
	 +7TmMbMCaidCt4irkwajqITe2IVfOfdP6wXUaqa69RVHZ3Ajijz8YC5p6c28flJw/e
	 kYqJKCAO29ssFd1lqRzWCUSLi4U3hsxP26Hzh3M+VHt4D6Ct1OtWsw2gPYGrIPaEvp
	 zluri2j+LmmVuVei1hv2n4uuyB7c2btotimrQxcLef9OxFUfm3Ys4kcouXij2a/Fbd
	 MeNpUYufGwkQAUJ/2CfKGiML1hPynQqZWUOcPVCA9Y1xVxC5LXtXL2Id3MNg5C4R/9
	 5Cc1828v7RLfw==
Date: Thu, 02 Oct 2025 06:45:01 -1000
Message-ID: <58de560994011557adefca6b24ebe4e8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Koutný <mkoutny@suse.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Tiffany Yang <tiange@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Disable preemption for cgrp->freezer.freeze_seq when CONFIG_PREEMPT_RT=y.
In-Reply-To: <20251002052215.1433055-1-kuniyu@google.com>
References: <20251002052215.1433055-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.18-fixes.

Thanks.

--
tejun

