Return-Path: <cgroups+bounces-13582-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHTlEMOEf2mxsgIAu9opvQ
	(envelope-from <cgroups+bounces-13582-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:52:19 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DCC690A
	for <lists+cgroups@lfdr.de>; Sun, 01 Feb 2026 17:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F179A300F9EA
	for <lists+cgroups@lfdr.de>; Sun,  1 Feb 2026 16:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925731B532F;
	Sun,  1 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5TTiNl/"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA726E71E;
	Sun,  1 Feb 2026 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964708; cv=none; b=VG0pcsikOUE8toq470uXgdZNKjsMzwC5AF4X0HrMc4917Wq3Bv5SgjG4ZzFkopxjTIjRQbc7Ai77giEDW3ZxZ3/vhThivRNvcEziDzVjCsDCoOvFmrVXprfU3P6O+xvIaiV1dFZWuw5wqO/CVYlzAXAkqpJdzX7pDJxey0rplw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964708; c=relaxed/simple;
	bh=AvgjU4pq3tQBOXYv2Cm4Oz/DnPNOIpwzLhpGB43kziI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=BvQBJhBUiKCn9Yuh1Zy9l4AhaQrz/2r53zgJAkEqaaLRLy0w4LKuyK0Kvr+jvpzlOLi7CxjVkYSOCBPCq/JtV4sb5gHBTSnx/wP5CE5U+Y6EHGaAgrDYuupGZP4TiA6G/YPeOfUh4OFkCz45/82VpVJSgkOunZwgemAKh+5h7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5TTiNl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10910C19425;
	Sun,  1 Feb 2026 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769964708;
	bh=AvgjU4pq3tQBOXYv2Cm4Oz/DnPNOIpwzLhpGB43kziI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z5TTiNl/bNLMA7Ahq6drqGMN4cL2C8C50es4Iz+HqHuJCmQjo5OX9dMcrT3D5vJYv
	 f5LIDiUZlKpzzs52LgyAnpzwB8GiHSwTfSi39OVPklzulB6WuP3yxT6x0jtMp4C7d7
	 CXsk0of9nJ6v5uNrHDPgcaFrzpEZ6hxvGL2xMPimHB9wnci9CeuoFiUPCDlMRNRUR+
	 b27Dv+sBQYsiavj23wtql20vazo9nwdU6v5dgte+kYVrCpE7j/HBbwf0qZaBh0WXsq
	 xB4gvc0AAR6sC16XrPYlTlVeY4yKLwXzKaRqG5bLcsw1+l+sbON/SG8fOYjqiKyCNp
	 ypqrl85xsf/vQ==
Date: Sun, 01 Feb 2026 06:51:47 -1000
Message-ID: <3a1538ab6d0d1063dc49855cc5b303a8@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
Subject: Re: [PATCH -next] cpuset: fix overlap of partition effective CPUs
In-Reply-To: <20260129064516.210203-1-chenridong@huaweicloud.com>
References: <20260129064516.210203-1-chenridong@huaweicloud.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13582-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC0DCC690A
X-Rspamd-Action: no action

Applied to cgroup/for-6.20.

Thanks.

-- 
tejun

