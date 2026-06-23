Return-Path: <cgroups+bounces-17203-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L6trL8vwOmpfMQgAu9opvQ
	(envelope-from <cgroups+bounces-17203-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 22:47:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 272606BA1BE
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 22:47:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C6vpCIpH;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17203-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17203-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3FBA30B17D6
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EB3ACA5E;
	Tue, 23 Jun 2026 20:45:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795CD3ACA41;
	Tue, 23 Jun 2026 20:45:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247521; cv=none; b=cbanH0DdqHBDMJT4f/KgvFrP1JMzDI7iJiy2CJ7QxQb2BrVssMZeqR9MCkfOVEuF6+XCVZqGhl6sDmfU3Y5GHhPf1MGX935yVkj9V7O1yHxWPiLlC6YbXufWM3UBMJgN7F7fARpMa6jPMADXB8GVampqEhOxtQiYnA4dggqYoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247521; c=relaxed/simple;
	bh=TgQ193mZwAfjhmDQmgpjU7n1cGp4ogtA85u6FxjWLRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KNOmSwb0+G1DWbJkvOu0xyqbt+ELi5mjV6GBGaSuAseJ3ZtW0jPl3o00SuNxurCF+dg8H+ZVkQJkNAIFEbSnVzQ6J0cCIOwlP1CxWxzjFwWc3ChP7+086TAI17CvOM/hcEw0vKmlbZ3l3l+NHE9QgdNeIEcN9+SMpcv6qI/wFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6vpCIpH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00501F000E9;
	Tue, 23 Jun 2026 20:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782247520;
	bh=HeB7xZnuDs/TEcIKXn5nTk2Jy0itlcqx7vzVd0ZePtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=C6vpCIpHcDCGe6ZMcJJEP0+Nz3+p6knyFyKDQZGz+NjKRDoZ9qk1Ti0o8I+agBJkZ
	 UFoH6JHRau1Hr1o4NWUKNtke+olSavbfY/S21PiOWPcJIoBa4zL1vrFFLaQMr1EAZE
	 /+8GyCioZL7Sjrmp1y3pVJCPxUp4fdhS7fh5uHeV8XOG9HFjdMohaLr4VnYS6oM4eh
	 Lh5+jZ+43F6Oa2JJ2lUEyP0QOl+AniJnA0YsCw27hlgWR24Fn3Nm84An4Xdg1mgJl8
	 GqTHcX4qpjrYhhkvY1ECCBJgWdcD9dXTVyr3FCr+bWMrIEWOJtcrmV1bRwQclDesIg
	 IAVXt+CPJuY3w==
From: Thomas Gleixner <tglx@kernel.org>
To: Jing Wu <realwujing@gmail.com>
Cc: Jing Wu <realwujing@gmail.com>, Waiman Long <longman@redhat.com>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 cgroups@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH v3 08/13] genirq: Add explicit housekeeping callback for
 managed IRQ migration
In-Reply-To: <20260623043641.2391662-1-realwujing@gmail.com>
References: <87cxxnegqa.ffs@fw13>
 <20260623043641.2391662-1-realwujing@gmail.com>
Date: Tue, 23 Jun 2026 22:45:17 +0200
Message-ID: <87fr2dkmua.ffs@fw13>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:realwujing@gmail.com,m:longman@redhat.com,m:linux-kernel@vger.kernel.org,m:rcu@vger.kernel.org,m:cgroups@vger.kernel.org,m:yuanql9@chinatelecom.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17203-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,chinatelecom.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 272606BA1BE

On Tue, Jun 23 2026 at 12:36, Jing Wu wrote:
> On Thu, Jun 18 2026 at 22:27, Thomas Gleixner wrote:
> That said, I fully accept the architectural feedback: the on-the-fly
> subsystem modification approach in v3 is wrong, and v4 should use the
> CPU hotplug machinery.
>
> We are open to coordinating with Waiman on a unified approach that
> covers both use cases. Before starting v4, two questions:
>
>   1. Is the "no boot parameter required" use case worth pursuing
>      independently, or should it be folded into Waiman's series?

Sort it out with him.

>   2. For the hotplug path: is CPU-by-CPU offline/online the expected
>      mechanism, given that you rejected the cpuhp_offline_cb() bulk
>      approach in Waiman's v1?

I think so. It makes the most sense.

