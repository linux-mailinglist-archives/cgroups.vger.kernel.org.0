Return-Path: <cgroups+bounces-15349-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOwDEo9x4mnR5wAAu9opvQ
	(envelope-from <cgroups+bounces-15349-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 19:44:47 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB6041DA88
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 19:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46DE43029241
	for <lists+cgroups@lfdr.de>; Fri, 17 Apr 2026 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D0C3D2FEC;
	Fri, 17 Apr 2026 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRq9iMaE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BA3C1980;
	Fri, 17 Apr 2026 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776447457; cv=none; b=R6lJvqaIoZTiYPjS5jhIR+DksPeOW9lzQc0GqZaEqv6x93fqO5+p8DdoOTIRN1yF3qWN0igQ6DjaHKGkYAua+PgnfC/mKIR0iJDpLrdtgkys85O5L8XYTZmVJke1Yxrr5Katc2fWtJx0Wc2ApsW42IO4R8Wk+Xlq16vIJBHDcSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776447457; c=relaxed/simple;
	bh=a1XmirleA2qxX+RFvGsgY45vrooNVUER/oKFPxr/pbs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=W9HfwBGUMUtifDT0uQz2hF8EexCZYSIZQBlLaKqO7Eoqb09ZLpne2+x2NTfLO8equ4hl+SGzRoETQq6RFjBwc8Ox9eSVja0Vwh8cOtQkPXaDBy3n+oQA+4gAo9DqdDRCo76IEn464D1m61E+RMDFbhRWWJjQlmao/LP9lFbyDnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRq9iMaE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4536CC19425;
	Fri, 17 Apr 2026 17:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776447455;
	bh=a1XmirleA2qxX+RFvGsgY45vrooNVUER/oKFPxr/pbs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nRq9iMaEoISue65kZhjKXorfyNzrx0T0oiQTnC3jBYd8h+7PZJ8Ji9WV0gQGjQTwn
	 pVdchLyZrbcevgnI54FVPbXyVJ0KIDUWrc3wWbJ/K1cSB6NHlnqgCBRT3ZevavdvEH
	 n0la513llJrjEy7Qrt9P76ziSDXnACCBLSgglBv6utHdLDg9DFFnEfQJi0InLkZsKw
	 rab3IXlQOTWdAX/QGNFQZa6kudQc80Vle7hXqx/t2i5Nv3jW4plXn3qIw+pDik8ivM
	 j4G9I349NrIoDAMtaLP2ygInXDND84bYjwJjjjdkJANC1XVtKFBaS6SBErTuo12dFs
	 Xp0oLAKRd/Pxg==
Date: Fri, 17 Apr 2026 07:37:34 -1000
Message-ID: <8867ffc00281b5cb2eef239326a8eb19@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: cgroups@vger.kernel.org, chenridong@huaweicloud.com,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org, mkoutny@suse.com,
 syzbot+33e571025d88efd1312c@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v5] sched/psi: fix race between file release and pressure
 write
In-Reply-To: <tencent_FBCECE887BCA6C3C2CE96E5896C8E9AEEE0A@qq.com>
References: <tencent_FBCECE887BCA6C3C2CE96E5896C8E9AEEE0A@qq.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_TO(0.00)[qq.com];
	TAGGED_FROM(0.00)[bounces-15349-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups,33e571025d88efd1312c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CBB6041DA88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

> Edward Adam Davis (1):
>   sched/psi: fix race between file release and pressure write

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

