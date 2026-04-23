Return-Path: <cgroups+bounces-15471-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZlKGFx6mlBzQIAu9opvQ
	(envelope-from <cgroups+bounces-15471-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 21:22:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6C2456B14
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 21:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D29A83002B33
	for <lists+cgroups@lfdr.de>; Thu, 23 Apr 2026 19:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E17E310655;
	Thu, 23 Apr 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVGiY29P"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE52D8399
	for <cgroups@vger.kernel.org>; Thu, 23 Apr 2026 19:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972126; cv=none; b=qt14g1vtshoxrsHrBPhQEfkixQvaW6q2UPitLMmfO8NhvlN2c7sntM+Y76+6b73V37zrbtbKGITi4oeqOwl+XrSvz4r7MBwsTzrXNlvG7t0zx+y7oBtlh1bgU0oHb3QW0g0JriWbJXnPpxpRLkVDYf6erjQFCWbXw5azuRq8ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972126; c=relaxed/simple;
	bh=QtHjuTzc89JDqAcIY+ZA/UADrZI+EpqQxEi7XlkCt9I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ne6CUxvUPOJ1LP0Z1xyt6dbER13pllZNUoaX6TtkBKRkrBo6ATQ9DiZ2+CrqyE+UEOvFDxFFvr2b35jhFxjB4Y8luBT1MDbLBe6ogomyCO5/vydUKBVsuBUo7laojrbggA6d3zF8I37lmoRPsGIBN7RVPP/lZepUAcMa2emPWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVGiY29P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C8A7C2BCAF;
	Thu, 23 Apr 2026 19:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776972126;
	bh=QtHjuTzc89JDqAcIY+ZA/UADrZI+EpqQxEi7XlkCt9I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hVGiY29PbkUxLrJrEavCOJBSZQJKGAfoPa5MLrxIAX8kKUktyASspQSTtYFC2llkT
	 jwZJJ1peb96Mq6MNQNbZ2tQnNsyqVcV3RaT+h9TxlitMJnZEcFrWFheY9jMGxgXQ0D
	 1O2HnMog6l+KB3UpW91mrMLlrppv9a3f2b8PxkZUCUuwMcc+U7zIpvdyczxW7+8Ckv
	 xE7FRdWsYvlSSnrQbO863wmUkYxbVhsWeteq63Asyc4vzjJB7xHwkU3zA3RSkM0sZi
	 j48ZoPJxAA/bmDY0XmahSqPSZcz18uuWsfvhiFgufujS3q8tw+Qu/Q0f4Wd/aELtVv
	 J0mfG92M5SF3A==
Date: Thu, 23 Apr 2026 09:22:05 -1000
Message-ID: <e8c3b8d6dc941d3a74f2adf7464351fc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Petr Malat <oss@malat.biz>
Cc: cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] cgroup: Increment nr_dying_subsys_* from rmdir context
In-Reply-To: <CANMuvJmf7On+qRnkkBpqzDe2HqX0axWKKPdtfAdjSdN4i1f0qA@mail.gmail.com>
References: <CANMuvJmf7On+qRnkkBpqzDe2HqX0axWKKPdtfAdjSdN4i1f0qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15471-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F6C2456B14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to cgroup/for-7.1-fixes with the following Fixes: tag added.

  Fixes: ab0312526867 ("cgroup: Show # of subsystem CSSes in cgroup.stat")

Thanks.

--
tejun

