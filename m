Return-Path: <cgroups+bounces-2663-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DA48ADBF3
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 04:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4341C21290
	for <lists+cgroups@lfdr.de>; Tue, 23 Apr 2024 02:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9360018032;
	Tue, 23 Apr 2024 02:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b="DPjV+b2W"
X-Original-To: cgroups@vger.kernel.org
Received: from bjm7-spam02.kuaishou.com (smtpcn03.kuaishou.com [103.107.217.217])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9B51799D;
	Tue, 23 Apr 2024 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.107.217.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839385; cv=none; b=GfokSmdJb5LveLTlRaA3sY+si+SiVk4hXFbb3LhRBmfrbFtkUwBQAET7Zn0T/TBQtZT86LvQFiey41XtXN9EXy2WvMKyfKBzEdiWymz4joncxhQ/bn//dkLk2aHqMYebaC6kg9vtwFslNx2IDcK0xnuAbDe8CbLN/zj4EoM6XBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839385; c=relaxed/simple;
	bh=X5rhTkAkWfAzGkOiZliZ12NR9HEWcVW6a6gLioYjsZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UyhYymuzVJIZ01Ri3SKN2LjhlEG9ENx7yGpMY/aEF077JzTLXC/wrhoVfyTqZlMSZxe58YuaFBNqJVvLyR1Sh/ibQsrgDqXfl5NJV/FgwqbiZqzqHnoKKdt2u92x1VAyBZiBcl5RZUE9SWsjQdVHtBjPLElhVChxiE/S2vEV3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com; spf=pass smtp.mailfrom=kuaishou.com; dkim=pass (1024-bit key) header.d=kuaishou.com header.i=@kuaishou.com header.b=DPjV+b2W; arc=none smtp.client-ip=103.107.217.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuaishou.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuaishou.com
Received: from bjxm-pm-mail03.kuaishou.com (unknown [172.28.128.3])
	by bjm7-spam02.kuaishou.com (Postfix) with ESMTPS id C6D771800155C;
	Tue, 23 Apr 2024 10:29:41 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; d=kuaishou.com; s=dkim; c=relaxed/relaxed;
	t=1713839381; h=from:subject:to:date:message-id;
	bh=X5rhTkAkWfAzGkOiZliZ12NR9HEWcVW6a6gLioYjsZk=;
	b=DPjV+b2W5qO9OFIj5etQbYxANwDJb3DuIpVmnpd85fi7g5irXDRNLwqIvFhYPXLqX6QZiWoBNVr
	DbVYbkKniOFsxpQqdbNE8Sqv7UgOzAGhboK3ZEnZUKTh5q3ni2ztJsOWkFKM6WA/5qPc7RSJEHkLP
	wTIHFeA1ANxzIoUDpZY=
Received: from bjm7-pm-mail01.kuaishou.com (172.28.1.1) by
 bjxm-pm-mail03.kuaishou.com (172.28.128.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.20; Tue, 23 Apr 2024 10:29:41 +0800
Received: from bjm7-pm-mail01.kuaishou.com ([fe80::90df:c4ca:7789:1e31]) by
 bjm7-pm-mail01.kuaishou.com ([fe80::90df:c4ca:7789:1e31%16]) with mapi id
 15.02.1118.020; Tue, 23 Apr 2024 10:29:41 +0800
From: =?gb2312?B?1tzMqdPu?= <zhoutaiyu@kuaishou.com>
To: Yu Kuai <yukuai1@huaweicloud.com>, "tj@kernel.org" <tj@kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "yukuai (C)"
	<yukuai3@huawei.com>
Subject: Re: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
Thread-Topic: [PATCH] blk-throttle: fix repeat limit on bio with
 BIO_BPS_THROTTLED
Thread-Index: AQHalSYYgvn316ZF/0ORm0fZgl7H2Q==
Date: Tue, 23 Apr 2024 02:29:41 +0000
Message-ID: <6ed23c45113b4ba48477030402295d07@kuaishou.com>
References: <20240419120747.38031-1-zhoutaiyu@kuaishou.com>
 <ea781ccc-c29e-894e-c54a-f44ea349edca@huaweicloud.com>
 <e2d291e6b6ed43d89930eb2a7d459ff8@kuaishou.com>
 <fbf135e8-de16-8eb4-9ade-1b979a335e33@huaweicloud.com>
 <Ziag2TL_BqmTRK5D@slm.duckdns.org>,<283462e4-c2d7-8d70-bb0f-61db62a86e02@huaweicloud.com>
In-Reply-To: <283462e4-c2d7-8d70-bb0f-61db62a86e02@huaweicloud.com>
Accept-Language: en-AS, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGksDQoNCj4gSWYgeW91IHJlYWxseSB3YW50IHRvIGZpeCB0aGlzLCB5b3UgbXVzdCBjb21lIHVw
IHdpdGggYSBzb2x1dGlvbiB3aXRoDQo+IHRoZSByZXNwZWN0IG9mIEZJRk8gcnVsZXMsIGJyZWFr
aW5nIGl0IGxpa2UgdGhpcyBwYXRjaCBpcyBub3Qgc29tZXRoaW5nDQo+IHdlJ2xsIGFjY2VwdCwg
YnJlYWtpbmcgZmFpcm5lc3MgYW5kIHNvbWUgb3RoZXIgZmxhd3MuDQoNCk9rLCBJIHNlZS4gVGhh
bmsgeW91IHNvIG11Y2ggZm9yIHRoZSBmZWVkYmFjay4=

