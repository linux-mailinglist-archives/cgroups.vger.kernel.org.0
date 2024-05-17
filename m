Return-Path: <cgroups+bounces-2945-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444628C7FAB
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 03:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66FC91C218A8
	for <lists+cgroups@lfdr.de>; Fri, 17 May 2024 01:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570DD1849;
	Fri, 17 May 2024 01:56:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2864A32;
	Fri, 17 May 2024 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715910972; cv=none; b=DkzVHfVzRL+5/ZTMmFRTeW5/wUqte9Dvi/HbwUKxxrztpI3x80d33XDG/E2hI0xHvuiVinn/lq3Z1t9qes2/8sJvZmxKmgF6vaHbbO5mQzmtFqiBalh/fCbR06eYZfFTUfa1Nlg9h4Qn/NQLE+KS4HLL0HqtvhpYpgdWunYxKww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715910972; c=relaxed/simple;
	bh=tZNGNne7HzMY2htCJ+GDUDa4aHZerBjW6Ld35cu2P3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nhAaTwgjxvJ61/NMmCJK8ZbMMSvRE28POKrBxmyglDPh+yaLDE+TBsw0LeA3+tuzwRhaUpdJgS47fOKB37aVOc/F0ZNWyIhtLQdck8644Eq9w6hBLpD8oEiC03Df5j4TlfrYXMwhmBDD7rDc54T2unQYBnxuj8TvJLU0GczSP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VgVNP4vB8zPlHx;
	Fri, 17 May 2024 09:53:09 +0800 (CST)
Received: from kwepemd500014.china.huawei.com (unknown [7.221.188.63])
	by mail.maildlp.com (Postfix) with ESMTPS id D4EBD18006E;
	Fri, 17 May 2024 09:56:05 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (7.221.188.163) by
 kwepemd500014.china.huawei.com (7.221.188.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 09:56:04 +0800
Received: from kwepemd100013.china.huawei.com ([7.221.188.163]) by
 kwepemd100013.china.huawei.com ([7.221.188.163]) with mapi id 15.02.1258.028;
 Fri, 17 May 2024 09:56:04 +0800
From: chenridong <chenridong@huawei.com>
To: Tejun Heo <tj@kernel.org>
CC: "lizefan.x@bytedance.com" <lizefan.x@bytedance.com>, "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIC1uZXh0XSBjZ3JvdXAvcGlkczogcmVtb3ZlIHBpZHNf?=
 =?gb2312?Q?cancel=5Fattach?=
Thread-Topic: [PATCH -next] cgroup/pids: remove pids_cancel_attach
Thread-Index: AQHap/qfLHXCp2VVSU6TM5y+7dYKErGaIfCAgACIp3A=
Date: Fri, 17 May 2024 01:56:03 +0000
Message-ID: <018226cf88194edc9cabdd947b40c9e7@huawei.com>
References: <20240517013001.215350-1-chenridong@huawei.com>
 <Zka2512X0A17eri9@slm.duckdns.org>
In-Reply-To: <Zka2512X0A17eri9@slm.duckdns.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
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

U2VlLCB0aGFuayB5b3UuDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBUZWp1biBIZW8g
PGh0ZWp1bkBnbWFpbC5jb20+ILT6se0gVGVqdW4gSGVvDQq3osvNyrG85DogMjAyNMTqNdTCMTfI
1SA5OjQ2DQrK1bz+yMs6IGNoZW5yaWRvbmcgPGNoZW5yaWRvbmdAaHVhd2VpLmNvbT4NCrOty806
IGxpemVmYW4ueEBieXRlZGFuY2UuY29tOyBoYW5uZXNAY21weGNoZy5vcmc7IGNncm91cHNAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBjeXBoYXJAY3lwaGFy
LmNvbQ0K1vfM4jogUmU6IFtQQVRDSCAtbmV4dF0gY2dyb3VwL3BpZHM6IHJlbW92ZSBwaWRzX2Nh
bmNlbF9hdHRhY2gNCg0KT24gRnJpLCBNYXkgMTcsIDIwMjQgYXQgMDE6MzA6MDFBTSArMDAwMCwg
Q2hlbiBSaWRvbmcgd3JvdGU6DQo+IEluIHBpZHMgc3Vic3lzdGVtLCBwaWRzX2Nhbl9hdHRhY2gg
bmV2ZXIgcmV0dXJucyBhbiBlcnJvci4NCj4gVGhlcmVmb3JlLCBwaWRzX2NhbmNlbF9hdHRhY2gg
aXMgdW5uZWNlc3NhcnkgYW5kIGlzIG5ldmVyIGNhbGxlZC4NCj4gQXMgYSByZXN1bHQsIGl0IHNo
b3VsZCBiZSByZW1vdmVkLg0KDQpUaGVyZSBhcmUgc3Vic3lzdGVtcyB3aGljaCBjYW4gdGhvIGFu
ZCBpZiBwaWRzIGlzIGJlaW5nIG1pZ3JhdGVkIHRvZ2V0aGVyLCBpdHMgY2FuY2VsIHdpbGwgYmUg
Y2FsbGVkLg0KDQpUaGFua3MuDQoNCi0tDQp0ZWp1bg0K

