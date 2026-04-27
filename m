Return-Path: <cgroups+bounces-15514-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NJTFV6l72mvDgEAu9opvQ
	(envelope-from <cgroups+bounces-15514-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:05:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196AF478217
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEC2130A009D
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2026 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AB03E7151;
	Mon, 27 Apr 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZVhVgkU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752963E92B1;
	Mon, 27 Apr 2026 17:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777312744; cv=none; b=CGNRfWRGeITyU9E7XTQACV7LUzIjDWVSDm8QopCgJWc5Fr7iH0neFQVPdFkeR4DVCJkGBwtmwD/tSsKbekZmch6PxN196P3x2qexJgpR2yKVN0Y1T/QV7TwYe99hUsLDZAfXbqUW7KPynR3kvdgyTJ8UeqUnwZB5in9vk7DH4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777312744; c=relaxed/simple;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbqGzO4hkyWRr7n9F0W7CeVqcMvgEuNbyU18Yca+zxanZhAHIqETb0K4Y7WC8H5HVLH9KE7IFe91YuvX/wARCMTcfjY1goJyolpkifRZRsU7CKlrniD88RWtQ8/ZZw32RAdMXQcfSLn+VMc5oKklF6qBFAboop5LbmSjiPoIIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZVhVgkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A4BC2BCB5;
	Mon, 27 Apr 2026 17:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777312744;
	bh=h+uhi/NqA0FdGMn82gWEgw/8zcywPLWzEWQvhat6/88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tZVhVgkUqq/NRdHmv65W5/hJvEmrTG9cIHYAWPeJUFoEQK6MKcHiBRMLbQk4ck97J
	 3NuDOvN0K91eYpeXjPHgHqEwAOJEUQGOk6XWurlXQJMT01q+CU4Ke1HJNKdsOHUrWt
	 PLvCc5VkRonjoOD85RqS4o+0nGLLu+eMDxDgJeyeFB0gMgEldl7xIoRgfILDTO9jxw
	 G6QfXA47YR3PpdTnkG0XfV5Tu5PZtCGTYHEr/mqTPX4RdfVRxOoXmO1tLE2bR7CPaE
	 EHGVBdeC6P5mLKlMhT6S6oKN/jjSYYY+CPD9YUST9jvJ0tJexNwxAfwdbZtAeKhHFw
	 3St6YmDU4QY1w==
Date: Mon, 27 Apr 2026 07:59:03 -1000
Message-ID: <872ba166f5c481bfb53627d5aa62a9c8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: =?UTF-8?Q?Petr_Van=C4=9Bk?= <arkamar@atlas.cz>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 cgroups@vger.kernel.org,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: cgroup: fix typo 'protetion' -> 'protection'
In-Reply-To: <20260425080356.14731-1-arkamar@atlas.cz>
References: <20260425080356.14731-1-arkamar@atlas.cz>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 196AF478217
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-15514-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello,

Applied to cgroup/for-7.1-fixes.

Thanks.

--
tejun

