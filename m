Return-Path: <cgroups+bounces-15350-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICTWHFBx4mlP6AAAu9opvQ
	(envelope-from <cgroups+bounces-15350-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 19:43:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4223141DA6B
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 19:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC44A31A121E
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 17:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74AC3D301D;
	Fri, 17 Apr 2026 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVMCN3B5"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44EC3D3008
	for <cgroups@vger.kernel.org>; Fri, 17 Apr 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447459; cv=none; b=QmFLDMTV0WxgDDiUTnGCRfl8palmX9U4PTxS8fL5U+0FdN1trj6oBxedXKHy+X8NbRWMrlHpzC3WFi/OXud/kDZSuUqqrQw+LHaeXPJalF6MmWbkrpyR9nNHyCB/oEyOVwVBj7eVed0GsjOMUa25gs8lKZx1NL0T98j0FD1EP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447459; c=relaxed/simple;
	bh=UScojqXTSjWLmywHUY7uE9UBQNVESgyJRXxoaWRNSBE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uq/kiGfcHc/6JSn1tg4PUQj28OvvWDbzSR21QRdATnj7jkYV2HUfTEkXowzVK873JCCW04ghdwKc01YVaelwh4SE7EFUEzzZGLef5U70cJ6uSX9gh2K4rDO2bcynbswTSzRGGFv+9JoecThpVL+CoaGi1ldMPXw2VrercmFHqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVMCN3B5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6887C19425;
	Fri, 17 Apr 2026 17:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776447458;
	bh=UScojqXTSjWLmywHUY7uE9UBQNVESgyJRXxoaWRNSBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YVMCN3B5G2Nr07gsU7eEq/d1TNRYkL9DxvjSl+BzXOvboz1HuR7n31WpNrITk3xpZ
	 xYW/bpnsgYcsBPrOvfSqFxMX1nCQ1Qw3+gZrqHx1f6ox3+4I3Mk1aQfWeYvUZqZua/
	 jScJHaoFHuexXjhtgf8mGb6sge5MEe7AVmIKc4OmvKg/xo4ZdAZn1khAQBhyClSHZL
	 pbQY2cWMAfZ1TgBn6dKIzjk41XAP6lzJYSQ04fVRmVy9Z+OlWpNLqC5xp+uLo5Uma6
	 ejt2UwecYhpoKI4JSeP0zyHCpKumzpzcb7LTGRBVlzlYvRvsfrBxSuTBlda0RNxO1J
	 XDF0G7dZGNADg==
Date: Fri, 17 Apr 2026 07:37:38 -1000
Message-ID: <b739e918a3d0c0f0c4b129078f9196e2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: cuitao <cuitao@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [PATCH] cgroup/rdma: fix integer overflow in rdmacg_try_charge()
In-Reply-To: <20260414015327.306721-1-cuitao@kylinos.cn>
References: <20260414015327.306721-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15350-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4223141DA6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> cuitao (1):
>   cgroup/rdma: fix integer overflow in rdmacg_try_charge()

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

