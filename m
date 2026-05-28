Return-Path: <cgroups+bounces-16394-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GeEKPlrGGrcjggAu9opvQ
	(envelope-from <cgroups+bounces-16394-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 18:23:21 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4495F4EC9
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 18:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B4B530A2518
	for <lists+cgroups@lfdr.de>; Thu, 28 May 2026 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822443FFAC9;
	Thu, 28 May 2026 15:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WiU94tYJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7788B3FF8AA;
	Thu, 28 May 2026 15:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779983707; cv=none; b=eJh3t/BLUgDkqqk+O024eN+udXxz7nNfoag1k7ytV1dd5OLHayhUZWwcxbeejzouiIs/oKP7LMRVVmd7hzMrN7oViw38MKp5nbq8zvprgaMVE0PVTB+TeoUiQ7wqkNGSkHCr6N7IZiJI0D8Dif7LfDvrGnsWNtiMOSg6ZgDy5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779983707; c=relaxed/simple;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=PUP8BuMTNqMSMkM3UitOp3TgKn1KOLia8+zdF7GF+xsfmFeibK3s+2CN3FBuSv0sA/5SfEXfyowFMGw/s8SZHCqp2W50hJf4qDCG7kCizxov5pZxhxdDlLJqVgMWrfG+7Nn1POymt5YHup8iCpYVq+ny3b6cLq245u30Bzb9Jss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WiU94tYJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2966F1F000E9;
	Thu, 28 May 2026 15:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779983706;
	bh=/EBK9Za3dzKeST6xzL+uhXsqga85E68iUDnkuLoGL9Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WiU94tYJr9FK+OilplGdffxFTtJ0XCiz9Jj7IV6RgxQ9Fz3GioEYe7zggcpIy4kNG
	 c0BgocTXj4VGLRgR0bFxFbl0ECF7OnToIcubSg9GP2Slgyh0Y6A3TmD7BBa9wXFHSS
	 4yxEP0vxbsF3Wm2eCi/0m7E8Uf/85tzuVFhDnsB47kLx0ZL/68mjQRkjTkyKDqzpcz
	 L4yBJhN8T0iLV+w+AtRjDOHF9zDfQ1H95CbQuOhpb/3HVEO3OyLU1KUu33DhXeGsll
	 tibKvOxt4yeY8er1ymdMz5A9icOaJQv8wwNQroZbf0NR/pPxibddQ3bifsMXLLT5Uj
	 n7bsFSK7kE5dw==
Date: Thu, 28 May 2026 05:55:05 -1000
Message-ID: <dd21517999367504dbc5aa9dbaf4946d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Ren Tamura <ren.tamura.oss@gmail.com>, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: pair max limit READ_ONCE() with WRITE_ONCE()
In-Reply-To: <20260528042839.28472-1-ren.tamura.oss@gmail.com>
References: <20260528042839.28472-1-ren.tamura.oss@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16394-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,cmpxchg.org,suse.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0A4495F4EC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Applied to cgroup/for-7.2.

Thanks.

--
tejun

