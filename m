Return-Path: <cgroups+bounces-12296-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FD7CAE0C4
	for <lists+cgroups@lfdr.de>; Mon, 08 Dec 2025 20:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 782EB3009B7C
	for <lists+cgroups@lfdr.de>; Mon,  8 Dec 2025 19:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985EA2E1EEE;
	Mon,  8 Dec 2025 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD1B6Fim"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B9F257827;
	Mon,  8 Dec 2025 19:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765220831; cv=none; b=kPjyAePxerJarlLmQaeBasTxPd2lENLKOFgXSygF9CWv58ucw1VFgBm/xpltOsWQp/K16lWEStH+wCW1NegXYyzKRlRz0woWtrSqjz729BQ1/I7eovNq8nLRckOMiv7ev+S0rMth4uQTbRnfLxEWJp2X8SR4qKxlYC9Mhyfwdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765220831; c=relaxed/simple;
	bh=XpRjNn1mmaqAw8tIi+jFZhf0YM5j0DVMLFx3PKlmFl8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SdOdJUjjzdVvlJvBEYVebfkJAhbPPkMnwZFPpOnCE7dV18AzzRsW8Kyzs1Qy5uDrX/fDyR06g2pFSzPFHIkGppQ3MTnoleGepRcrR9DYTonVZFDu6dd7O6e7KomWVr6GpaBC08nTt9yP08GBZUm9hfRV0y3q14TPEw/BpLI2BLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tD1B6Fim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1716C4CEF1;
	Mon,  8 Dec 2025 19:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765220830;
	bh=XpRjNn1mmaqAw8tIi+jFZhf0YM5j0DVMLFx3PKlmFl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tD1B6Fim1UsRZ/z87f37+l9B/PCXQRMS5rn4yj0gPAyCAdUNqWaboZOmZ5WOBSlme
	 6ZU94UOhXQIUIxp2Pyb50J0WZZ1UQnEDWZyLLj+XYtVqc0vYWrEvBqPR3pJQeUnCnq
	 nT3iJAhoce3N2/uDlJ0+vPw2ZyPRzXxeeOd0I2Aqcw0vfZF6CnxfjuvVGLM2MzsXwp
	 bh74uqABe9S9aKc+mHDXjSxk7Nh676C1V6x2uGxSYmqoQctMJmaRgR6pi5WkQw59Rw
	 YhlZE/ASHKoy9kL1r0s6s9dm2FGA78sd3wRY/qHiNVOxvJNzB8U0U+K4vIkG+HLg32
	 NO1HOIH6mQ0yw==
Date: Mon, 08 Dec 2025 09:07:09 -1000
Message-ID: <270598c71d716fd3a7569829bc3eb56f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
In-Reply-To: <20251126091158.1610673-1-chenridong@huaweicloud.com>
References: <20251126091158.1610673-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.20.

Thanks.
--
tejun

