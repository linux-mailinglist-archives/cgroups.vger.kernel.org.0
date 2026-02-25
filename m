Return-Path: <cgroups+bounces-14238-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCQwIPpdnmmIUwQAu9opvQ
	(envelope-from <cgroups+bounces-14238-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 03:27:06 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA7190E1D
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 03:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D61A30432F7
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 02:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2775280CE5;
	Wed, 25 Feb 2026 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b="BKQWGCAJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mta22.hihonor.com (mta22.hihonor.com [81.70.192.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC5283CB5;
	Wed, 25 Feb 2026 02:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.192.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986258; cv=none; b=ZJSyZF5/jCEfVRmG2YpkMNJfjbPCGUHQj8DrRuuehzcn38c9SiYV84kwPYJfGV92q71wlZvFfjBsaRF5FWuKysvZN+byDi2hecTeLBI7ieqSupwLKsOqH+WMOGVfc8KbTJN6K6RpP1wxx1LBd+CUAdQyhyOiNBGj7N3DMlg4TrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986258; c=relaxed/simple;
	bh=WlyNojbPTko68Qj0ULwLL+kCfgbog0aOcgtY6cCgulM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m53OJ15uTC/TRzNTbUpzT3oeVyeNAZvQ8s1UGuQVGxaaHQI9HlCGtw9hEYr4qUdPoLhxutXG91Jqwmke5r1W3GNNFMO/OHjMWQ9++dn6vmfMKV/Le/h5uBC0BBkTsz0db9JzZketSgv4Y3/uxRTL+DimTcJ37tYvWCKYfYxYz9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; dkim=pass (1024-bit key) header.d=honor.com header.i=@honor.com header.b=BKQWGCAJ; arc=none smtp.client-ip=81.70.192.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=To:From;
	bh=WlyNojbPTko68Qj0ULwLL+kCfgbog0aOcgtY6cCgulM=;
	b=BKQWGCAJFkd0mDR16wY/ICCIPaLH+2zJ0sNPSPo3atPAsHilAqUrTkTQ4cjw9VAhkSIrULHUq
	3g0yRutVg98PAuKyaD+ZOZFtxb4qZeqQBRCLQR+dm2ul/Ulpb/EIFrvAb6qeD/XH4z3Va0Ag9Ay
	LVvJrV+VQ+Ws44jxkBs3EhE=
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta22.hihonor.com (SkyGuard) with ESMTPS id 4fLHvF4PVLzYl246;
	Wed, 25 Feb 2026 10:03:53 +0800 (CST)
Received: from a008.hihonor.com (10.68.30.56) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 25 Feb
 2026 10:07:18 +0800
Received: from a008.hihonor.com (10.68.30.56) by a008.hihonor.com
 (10.68.30.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.27; Wed, 25 Feb
 2026 10:07:18 +0800
Received: from a008.hihonor.com ([fe80::b6bf:fc6a:207:6851]) by
 a008.hihonor.com ([fe80::b6bf:fc6a:207:6851%6]) with mapi id 15.02.2562.027;
 Wed, 25 Feb 2026 10:07:18 +0800
From: zhaoqingye <zhaoqingye@honor.com>
To: =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cgroup: remove redundant NULL assignments in migration
 finish
Thread-Topic: [PATCH] cgroup: remove redundant NULL assignments in migration
 finish
Thread-Index: AdyleOaWxVLArOnARO2GXXWcyNkQHf//pBWA//6gsuA=
Date: Wed, 25 Feb 2026 02:07:18 +0000
Message-ID: <3408af45fe6d48569caf1e769f19d2d4@honor.com>
References: <994c084e31414d4188c8e2973d9f6e6b@honor.com>
 <qdws4gdrziqtygwwjaw5eujnvd5edz7mklasea64vueijfbbv4@2qq5isumvkyl>
In-Reply-To: <qdws4gdrziqtygwwjaw5eujnvd5edz7mklasea64vueijfbbv4@2qq5isumvkyl>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[honor.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[honor.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14238-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[honor.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoqingye@honor.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5EA7190E1D
X-Rspamd-Action: no action

Hi Michal,

Thanks for the explanation. That makes sense, so let's keep
cgroup_migrate_finish() as it is and I'll drop this patch.

Qingye

