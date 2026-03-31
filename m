Return-Path: <cgroups+bounces-15138-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGNqCNYczGnHPgYAu9opvQ
	(envelope-from <cgroups+bounces-15138-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:13:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312C3706B6
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 21:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43DF0302F0CB
	for <lists+cgroups@lfdr.de>; Tue, 31 Mar 2026 19:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419F23A3E9A;
	Tue, 31 Mar 2026 19:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlSSTaB/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405938F63E;
	Tue, 31 Mar 2026 19:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984103; cv=none; b=G17dCdlvcaK6ycyP5cMIZ2Eaa5e7Cd87peMz/hXqyWnpp5ONp0JB8l10+zE1ZDjp7JBM/mmyv/k27Syd2PAZVXcplMQCM10Qylln0LfawHxUtQodpLzX4pcpPL00ixj33VFj56h0LSo+ETylo0KZ1YrDqfIGBzqTPtadP29Vz70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984103; c=relaxed/simple;
	bh=Mf/0pumfUhA9ECgsANbCF1epWD/hK819mgDmwzKUF6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txZFeZ+MHw19xnmazPqtgvFj+oj43NCZFMnWmnsUUPuxI84anlODjJFKIpPaBOa5nbjRmElmP/agUc/GLxeyqQiT60NG2c7+r5BqsLZ/BHg5vHSIDnnH6XJZMfvK7rFpPgROT0Q9k/RahrizM0mfWmeRXurX9/KNZNz/VEh5fYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlSSTaB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CB4C19423;
	Tue, 31 Mar 2026 19:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984102;
	bh=Mf/0pumfUhA9ECgsANbCF1epWD/hK819mgDmwzKUF6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlSSTaB/n26RaUyt9zjwfEHYx8fJ+FHwwzK05E+RQkOnvlNPI7MPIrAH2fk0GlLRi
	 mFLDNr3HoDi8q1bGYlCmzc9IQLrbQw5lx+HypRjOVi3iKDYEqJ5e7OoRgk+ol3dUSR
	 28dxC4QAsnTF1SKqMsqQ9EJhrvlmt1/S6y/CnzJ7uPzL0RR3IJ090PcpozcL54+vRx
	 lcDc7jWSWaVmH10Qx6NneZe1RQlfpXSsCFQj1B0W2YiHWn/S+uXgjmbu8Ncv+WZ/D/
	 aCwKHKur5pYsJU0B1CbnfA7COPoFNvT8/7js0slbbBQFHuCPTWfWRTsSRHwgULqGsS
	 4+1xQd63Iykkw==
Date: Tue, 31 Mar 2026 09:08:21 -1000
From: Tejun Heo <tj@kernel.org>
To: Jialin Wang <wjl.linux@gmail.com>
Cc: axboe@kernel.dk, cgroups@vger.kernel.org, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] blk-iocost: fix busy_level reset when no IOs complete
Message-ID: <acwbpW7DUre11Jo7@slm.duckdns.org>
References: <20260329154112.526679-1-wjl.linux@gmail.com>
 <20260331100509.182882-1-wjl.linux@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331100509.182882-1-wjl.linux@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15138-lists,cgroups=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[slm.duckdns.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7312C3706B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 10:05:09AM +0000, Jialin Wang wrote:
> When a disk is saturated, it is common for no IOs to complete within a
> timer period. Currently, in this case, rq_wait_pct and missed_ppm are
> calculated as 0, the iocost incorrectly interprets this as meeting QoS
> targets and resets busy_level to 0.
> 
> This reset prevents busy_level from reaching the threshold (4) needed
> to reduce vrate. On certain cloud storage, such as Azure Premium SSD,
> we observed that iocost may fail to reduce vrate for tens of seconds
> during saturation, failing to mitigate noisy neighbor issues.
> 
> Fix this by tracking the number of IO completions (nr_done) in a period.
> If nr_done is 0 and there are lagging IOs, the saturation status is
> unknown, so we keep busy_level unchanged.
> 
> The issue is consistently reproducible on Azure Standard_D8as_v5 (Dasv5)
> VMs with 512GB Premium SSD (P20) using the script below. It was not
> observed on GCP n2d VMs (with 100G pd-ssd and 1.5T local-ssd), and no
> regressions were found with this patch. In this script, cgA performs
> large IOs with iodepth=128, while cgB performs small IOs with iodepth=1
> rate_iops=100 rw=randrw. With iocost enabled, we expect it to throttle
> cgA, the submission latency (slat) of cgA should be significantly higher,
> cgB can reach 200 IOPS and the completion latency (clat) should below.
...
> Signed-off-by: Jialin Wang <wjl.linux@gmail.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

