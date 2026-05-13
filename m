Return-Path: <cgroups+bounces-15909-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BUENO3MBGrMPAIAu9opvQ
	(envelope-from <cgroups+bounces-15909-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:11:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 598F3539AB6
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 21:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B95C30A9F2C
	for <lists+cgroups@lfdr.de>; Wed, 13 May 2026 18:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF373AEB2D;
	Wed, 13 May 2026 18:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWlnmn1g"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26414352C2B;
	Wed, 13 May 2026 18:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698625; cv=none; b=OjxhtiTklqNRK3BF28KEgNupfPqoxMJmNrJrNp9nsWRQhHlBuHkPCnoczSdfikLQTq05kXtfLrGzBaHAmYAfZmwfuMFjcWinbnVqbOwDFOermdU0JBwwhVo7xW+67TpQjTV8Oit+9hMJGHAq114jJvxduuqpG2CdlSXxrTTS9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698625; c=relaxed/simple;
	bh=GCavLRXkGnKuJSZKfwoUCQysayADP/mxKntrbOU/Ob4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mmDPg94kdc7JK0HvHfO3aRGNDA6jg9czgEKL2qNKbLqyBIExKVMy4EYFVz0pLjPwEJg3MXhTs8XehnLfZKFUnhT/Vi+DR6+lBPkuu7zeE61ZrrtTP4/F61E0wMZ2dJZKwSWzd3vrM/WbKYGsTmS0paC251CGHK5wfQqnRLAugH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWlnmn1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F3FC2BCB7;
	Wed, 13 May 2026 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778698624;
	bh=GCavLRXkGnKuJSZKfwoUCQysayADP/mxKntrbOU/Ob4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cWlnmn1gEfp3SaseucxBnxk8jZTYzsiYcYcdVa0YU24ctbTo4nhZl3CPaI7b+zr9n
	 Ojj5ZTf52Kq76AJluW608hztswjQBmgePk+7RAm71ZKHSfsaIRSVmAIQmjwNdRK6vx
	 D3vrH3/gPzLkX08Emvhs/wA7j+vIjOk+P2Knz+FO8OVMd9gjB4YjDFhiIQmum+iko7
	 mspRsTr9psMy0pwpfPKkwyckwqxMMRqkrw3hhPfl7GNKeALfTgJISD82yNVgpY8zvi
	 qFU/X6mp9Bb2bETL8oYOxRtr0UXiWeczZD95TdwzKxJr3FyEgOsum9gNkWTBo6s93J
	 wwiczraNqSbhw==
Date: Wed, 13 May 2026 08:57:03 -1000
Message-ID: <0516560bff07454b1f877218c74dc2a7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutný <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cgroup/cpuset: Return only actually allocated CPUs during partition invalidation
In-Reply-To: <20260513103738.442779-1-sunshaojie@kylinos.cn>
References: <20260513103738.442779-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 598F3539AB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-15909-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello,

On Wed, May 13, 2026 at 06:37:38PM +0800, Sun Shaojie wrote:
> From: sunshaojie <sunshaojie@kylinos.cn>
>
> In update_parent_effective_cpumask() with partcmd_invalidate, the CPUs
> to return to the parent are computed as:
...

Applied to cgroup/for-7.1-fixes with the following changes:

- s/Test-by/Tested-by/ on Chen Ridong's tag.
- Added Reviewed-by: Waiman Long <longman@redhat.com>.
- Added Cc: stable@vger.kernel.org # v7.0+ since 2a3602030d80 shipped
  in v7.0.

Thanks.

--
tejun

