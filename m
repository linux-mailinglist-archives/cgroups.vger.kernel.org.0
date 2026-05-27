Return-Path: <cgroups+bounces-16363-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KQIHnhAF2qg9wcAu9opvQ
	(envelope-from <cgroups+bounces-16363-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 21:05:28 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4FF5E9592
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 21:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 205D13026C28
	for <lists+cgroups@lfdr.de>; Wed, 27 May 2026 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AFD36214C;
	Wed, 27 May 2026 19:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+e26+PO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3F348866;
	Wed, 27 May 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779908723; cv=none; b=EHejIdamN+KzKVpr6EaGRKhmKlSWgDBlpxDycFB6GDu+gUGI45VLA//bxOnHpW2GQwax0inoEaLKgU84wynChTFWABLyPUud2udMe0pFJ83L0+z9XTwVBvCzeZQ/YcgsWUa5uMjU8jaMQYGLxu0QWEJoaotuLVJr382IWo77zlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779908723; c=relaxed/simple;
	bh=KsCrf+cekczKlqipyoAzcKdIM9b65wCVmMlqlPxUShE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dsKXtxCA6AeYmk+xuXR4ne0IsRnHNjzrtwcXHR2GV+UeuE+kvKFduIq+EIHeu4i0DXJ/MhLsdO8NEJZnTXfq1A/e+A/hjUpcMGmRC4+gPtyXgsSe/dChmsJZQfJDp4vxkUnOn7IeQjkrIDtBC78/hOl7z0uuwJz6qYKF5jSmmew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+e26+PO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ADB1F000E9;
	Wed, 27 May 2026 19:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779908722;
	bh=qtazIC5aRMFDl6IRdGD6bgmOhThRh2qqZDO3vHYKi0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R+e26+POr7lnytdgUMFHO7NWux97kcyXviSlViUn4GRuf7NBddYN/weUUjkBy/Cem
	 VtU3ubfdJnhrepMGVLEpNKjBdaxE9v7GkJZoJz7YBq+rlT9Ox1VOTCzwdrJLtFW6TV
	 BCnxO/49AxorDygSMAAoGTlrobuW86mipFwKz18wfl+p+0xpLoiHpwBs/SFhdYurxJ
	 KRFbV4QcI6fxDO/gPqL+kzZCKoexVFVtMxNx9XBfnoHvmnE6oVgTKyT1TlXcMg63bC
	 qttfJfX6D0J7zkhPE0AkmCHUxC5RJmg39moS3zaJsB2YlL9erOb0EsW0xu4KTlN0F0
	 O6apLWDjJA7fQ==
Date: Wed, 27 May 2026 09:05:21 -1000
Message-ID: <d609e4c1a3b3b652a9326a88157b73c1@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangguopeng@kylinos.cn
Subject: Re: [PATCH v2 0/2] cgroup/cpuset: Fix sibling CPU exclusion in partcmd_update
In-Reply-To: <20260527064329.640060-1-sunshaojie@kylinos.cn>
References: <20260527064329.640060-1-sunshaojie@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-16363-lists,cgroups=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 0C4FF5E9592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

On Wed, May 27, 2026 at 02:43:27PM +0800, Sun Shaojie wrote:
> Sun Shaojie (2):
>   cgroup/cpuset: Use effective_xcpus in partcmd_update add/del mask
>     calculation
>   cgroup/cpuset: Add test cases for sibling CPU exclusion on partition
>     update

Applied to cgroup/for-7.1-fixes with the following changes:

- Added Cc: stable@vger.kernel.org # v7.0+ to the fix since 2a3602030d80
  shipped in v7.0.
- Added Reviewed-by: Waiman Long <longman@redhat.com> to both patches.

Thanks.

--
tejun

