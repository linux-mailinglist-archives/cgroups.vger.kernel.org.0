Return-Path: <cgroups+bounces-14378-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cO5cAzA0n2lXZQQAu9opvQ
	(envelope-from <cgroups+bounces-14378-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:41:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BAD19BAE0
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 534373030D2A
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4104C3ECBD4;
	Wed, 25 Feb 2026 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqQefBOg"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21353D3481;
	Wed, 25 Feb 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772041254; cv=none; b=iigIltzULw6Vgb0giPYaafKdLPIt0Y9elbVk1Cl6/2ElMH+UDQDRfzjDXrm9fOcc5GFqc04ZH4MwNszuH4jywgiq6fX7ZNc4DqxbuP0bco9wo8BGl2qafgDydRxypADIFW5XxmjQ3MnARRAPj5m32yyAGCAp7tD1vbS/0hL4kq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772041254; c=relaxed/simple;
	bh=BKB3rI1qnbcBlftiZQ/yeMMmOuQNLAFDO9LsBpm+w7A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=D2RLKooVEfnRemnf29Ke1a/lKhBDGMunIYk9Va8MXhRA7dCSG2UtQ8Uq7PLE1hVxmajM7/MynEak+xXFA4H/pP13Q8zaVWKL/8KRlCvGuR/4xvMFW3eCxAVd12oPrZJ51GFXeN8gUw2kG2YEDRWjllDBLfYDARGiqrP7gGTd6VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqQefBOg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7474DC116D0;
	Wed, 25 Feb 2026 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772041253;
	bh=BKB3rI1qnbcBlftiZQ/yeMMmOuQNLAFDO9LsBpm+w7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hqQefBOgZoR2pioEhBrW05GMfAM3KhK3Vj7URcpbC5YQd+hfnadJEL2bD2nQg2uvC
	 vP9ERt2sczc9LPK1mwDN3ccfwZDcxmt9UHj6FopGj6fIgLANoVfZ23O96AzRn4M8Tb
	 lfh7HkCzP4GR3ouez1R1R4/YO/qJ8ib6+FjM5pgte2N0NksoYYlC1E1ClPuQchpm3l
	 mmPmCpwn1bav2Qz/pm9x3JCSU+wDTeE5G0mfEjPTGjQjEOykPbM0tnvP/DsceDnT07
	 bryVtsftvAbk/akW+lMu/cOGbqoJNbJKBsVG7D92XguQKrOpdr6h8sAswiCV5V1yPU
	 imvnB5LItaZSg==
Date: Wed, 25 Feb 2026 07:40:52 -1000
Message-ID: <89dca74185416ed487717aa8ef82a222@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next] cgroup/cpuset: fix null-ptr-deref in
 rebuild_sched_domains_cpuslocked
In-Reply-To: <20260225011523.51365-1-chenridong@huaweicloud.com>
References: <20260225011523.51365-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-14378-lists,cgroups=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 92BAD19BAE0
X-Rspamd-Action: no action

Hello,

Applied to cgroup/for-7.0-fixes with the following modification:

- Moved the NULL check into the for-loop condition per Waiman's
  suggestion.

-	for (i = 0; i < ndoms; ++i) {
-		if (doms && WARN_ON_ONCE(!cpumask_subset(doms[i],
-					 cpu_active_mask)))
+	for (i = 0; doms && i < ndoms; i++) {
+		if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))

Thanks.

--
tejun

