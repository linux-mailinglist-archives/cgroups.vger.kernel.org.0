Return-Path: <cgroups+bounces-12143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3FBC77006
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 03:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86181349648
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 02:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E12241103;
	Fri, 21 Nov 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkkPE8dB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5B157A5A;
	Fri, 21 Nov 2025 02:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692049; cv=none; b=hcZZSp1NWbf8gELgKwa4rNOcAXaGsCbbkLLK6FPca4e81sn6t/ceI8vszna7Gpaj0DlnNPS7NsCldurNBdVyuWNNdP6CvMYjU5Sbe4rYE0M+z2rHIwE2RJMFirIgrW6LRQ0xOkfLTQukd9qZKNPC8zJ5kHP/RDI3wLfMwzxZyjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692049; c=relaxed/simple;
	bh=QZa8ayUfWJJS+Lqb+yeeTgCdpc71cKgH26tuKpF5vVA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=WSFhzrA1Rcg6RCvBtQsmYPOjsp4cRQ+vSyAK3YzNhgEsYXmpdZuV7RsC6V2PiS6GyfbZsoOoU4Aosm+FYo/GOQGWaWRVShJ1yBCvQKXMoOeMZZaZvgvI+Jp1JUnFH60z9+SftWsum51jns+9HwZ7U1Qlh43bJJSF8lBAazEpACA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkkPE8dB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC05C4CEF1;
	Fri, 21 Nov 2025 02:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692049;
	bh=QZa8ayUfWJJS+Lqb+yeeTgCdpc71cKgH26tuKpF5vVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nkkPE8dBpOxuIitnotH2A5YABYKGbAauIl2CiJ9Vy5LbdaQ8xX6SvIPrKxPWLbIdO
	 P+1pwgHSDwmjHCMA7eynNGw5odSOkkganMr/bQXXx186O8/o0V/2vkLEy2eL10QF6U
	 5Nd0Fm3dSSYcvomStLHbn29nH2+LZeYe8I6N3F7iLlwJXNl8QkTtifIc2VBaLYs7UU
	 fl+E7SfCBuOmcUF8yrFNUpR+5KJ6f8e4qlrj65RhDCXOONOC26Y1zw1V9l54GBHrX2
	 LbqlGnR1QzMb2Fpwtv12BcJtv5oInL1lKLMj4W7o0DfJlLNTnN8e8yvxQtog0S2ZT9
	 ZVzNII2m6DcJg==
Date: Thu, 20 Nov 2025 16:27:28 -1000
Message-ID: <58a4e80c42cd0c1c6f19ac0890ba383c@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next v3] cpuset: Treat cpusets in attaching as
 populated
In-Reply-To: <20251114020847.1040546-1-chenridong@huaweicloud.com>
References: <20251114020847.1040546-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>

Applied to cgroup/for-6.19.

Thanks.
--
tejun

