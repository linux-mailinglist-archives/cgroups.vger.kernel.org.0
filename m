Return-Path: <cgroups+bounces-15199-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EEPOKsg12naKwgAu9opvQ
	(envelope-from <cgroups+bounces-15199-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 05:44:43 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4423C6127
	for <lists+cgroups@lfdr.de>; Thu, 09 Apr 2026 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5062A301588A
	for <lists+cgroups@lfdr.de>; Thu,  9 Apr 2026 03:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D55374185;
	Thu,  9 Apr 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWiVZ2YU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KBntPLL+"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C1E258EE1;
	Thu,  9 Apr 2026 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775706281; cv=fail; b=GkJgidEnMKK3kJjd6I98S8ShzHacuRi/ZzryPuo3iJ0icWkU2NBv9Bn2HHe8oD8WFysMw2NNgI3HWofbn78vWcFbitAAq65MlQFH/GtL+0QGQik/LdU585+D4tzRMxAXDiCdJL8mNdVdo/mt5FHyaYSo/+AmRhjYNk+4PXjhIUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775706281; c=relaxed/simple;
	bh=VBrtbDAeYckTTm83qPEk3T4PHIMIbzDJsnoXC7dvua8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S/v9+364ziUrs4tAk6N2X1/D0Amp3ore5oNZR1E1DDNDLchL3gHUVJrkYzxmCa44xyLqugeqiqk/gtiqrhCdyyT4eQfaIsJOYpNLvQWF6KrMMIr5mJG/qN89f639xEPOvRP1vzc3Dak+DhcdAblufNsGq0e3W1GpKg2RwGWLKSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qWiVZ2YU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KBntPLL+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NtU9m794594;
	Thu, 9 Apr 2026 03:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VBrtbDAeYckTTm83qPEk3T4PHIMIbzDJsnoXC7dvua8=; b=
	qWiVZ2YUbqAVu386KafDUav7U1OIEyFkaFFYZ5zMF5bmPOz/Qvm7e1Qw/oLFAGNQ
	h2h5Tw4ETtum4+oToOZ9P7T3Gil6ki/RZk1J0gBibMy+8TcK+p9NdI/YKpACFQ3L
	zBNJHGaYMKRx3Q96l5cawwo95ZkYNfAFk4BaV2LBO6C2QABn16H22EAA2RlmjWKk
	/sZJW4wms+jAFfnFWvDZ7ERte6SdYKg6uaLaZHw3hum8pzcya5CCOIxFww5E/mYS
	PNXqyPDibo45eSV7BT+tP/GFHE7Z8C5t019xujZz+//lA7LmKMHLluQl/+81yG7e
	vtBrVqfv9X80E1N7XjhjNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dcmqavxw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 03:44:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6391H9CV035379;
	Thu, 9 Apr 2026 03:44:30 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ddgxra2a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Apr 2026 03:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDnEpcTqKL5/n6BOSPXXOkrdgkjWkIy4nhHnBmyU0W8FMT7r8jB+zsl3HJlzOtj4A9f5zOpE0uCv5mEDWdee1+7kwGFwEebI8lKBRlHqkTLPgd/m38pbnEz6ay1cGMLmHQlMmdEAl56lgnoK34X3IrRL7K3iPyW/b9lOtnLfRdnf3+FtNh0wkh8ofhBxlH0oiSza80zBZjUEuxYeRuvWZ4CJYuRC5gv1WlECdw6fSC+qOqFzUGDT6OZC/UlDvzBG6inAbo43Z90aneBVWaEbNiSqnNEkfBJ5QDrGp38nEuxsN0TcFW6qndFi5FqQz4YnDKg7yelnhpMP/YpViSeWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBrtbDAeYckTTm83qPEk3T4PHIMIbzDJsnoXC7dvua8=;
 b=ZV3GQ9p7a8cPeqOnVVCUejf/o99e+HSSFphWgx1zT1F6WyPecASrn8h6bMBUMWi72OyD5YYNCHhNoZlLAa4zD8kA33/0q++YdWyig9yKBSuzwkcwgtaGTYbdkhPS6jEE8tWd4E+5U00JxR0mwMLcVcWUggfUOO8/uTYfrx+DjDOM68JiHKGCtrpX85/Sg1t38i7QinV/f4b9+tkJ3oLOpde6rBusxxI27DNh1p0UWgsWH72PWgQ8Bgm1NCcFvuz93P0j2O5vW539r6iRs7yANRQgmA1v5hNufZP8CrM76CTHlZHnS/UiZbOIM2nyrNCR1fACzlJW9Idj/MVIqrMnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBrtbDAeYckTTm83qPEk3T4PHIMIbzDJsnoXC7dvua8=;
 b=KBntPLL+3W/Yqtenq32z48mG4ol1vOcn8wvqBfs2k15t4paaU7RaBc9Q+S86O164moyE7Mqm5kcIn9OMcI2GPYmW2ST5VDRBsWUY7+PmTwwUKdNpUyywRCD7WOFNAMivL8kV3cXT1Oi3akXvDLL5cToblIXqe1kzn78900/u6Mk=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 03:44:26 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::5f79:36e9:a632:d010%7]) with mapi id 15.20.9769.018; Thu, 9 Apr 2026
 03:44:26 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "hannes@cmpxchg.org"
	<hannes@cmpxchg.org>,
        Tom Hromatka <tom.hromatka@oracle.com>,
        Kamalesh
 Babulal <kamalesh.babulal@oracle.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] netlink: Netlink process event for cgroup
 migration
Thread-Topic: [RFC PATCH 0/1] netlink: Netlink process event for cgroup
 migration
Thread-Index: AQHcxrNUBK13yWAlsU2CSw3tJLam3rXVIDeAgAD4qQA=
Date: Thu, 9 Apr 2026 03:44:26 +0000
Message-ID: <F480D58D-B0B0-4AFD-891E-206D9B38466D@oracle.com>
References: <20260407172339.2017158-1-prakash.sangappa@oracle.com>
 <pd3vkzvgr233tkuocyvpgxc4kttsi5nlggcxuskvwi3mocoqkm@cfefi6hh74s6>
In-Reply-To: <pd3vkzvgr233tkuocyvpgxc4kttsi5nlggcxuskvwi3mocoqkm@cfefi6hh74s6>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.400.21)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|PH0PR10MB5731:EE_
x-ms-office365-filtering-correlation-id: 8be16824-7763-451b-aec0-08de95ea4c14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 az02TxJu39wCoFlwIbxYTMlmQZ9ozN8eL4XA8OlZwUu3bklKPjuEmf9hIXNVh+YaA6OMXfUP+JL5n0CoPVpmYgmh+2avTb8W0/zgEURd7dfpfS0kdsKSJwOx9c4Or310POO9v0pqyLJ/ePM/a+4I2Yn5i3JhlG4/BPSj3F7X5v8aufovuLud34VqIcXSvfX0QTYYovsR9u5qGKyGW6Y9PCmNyICn2fxmEFxp0f6y35hjAWNAofKodG8CGBd6o8ezYUZwP0IbgY6LiDxb88MQtnSRzMTYgnJMVlrLs0ctrTjfjSVO3ZZx8xeZzB9hu8iOpRZ2Xo11X75lP3Lw7TYA9dD5E/7W0mnzo5A9Syznq0jw1rNtAMAURXSXnoaAgZ8THNQnExrOsIzjTqpDdgtq823MREpdS9TluPZbWs9MmRxDqj6jbIIuxXnzdOZilDicr/VwMFJkoTUjp/ynyJKo5wAQzR1KYoa97+O5SVuAJ4V/hh50MdixMFK3jgpZaExh3M5crcs7nPaO1top9y9MYbbFo2qKl6NAwxy4YN1kwpAao/6MNU9eFmXzko7kucWjKhDV/Uo/qyQbtm0CcS8O1dYT/oTLk8nQI/SKBFlMpzfWPe1Ra+iEWmu1qrn3BC/xqZYhOscOYaKOZp02PuGdgaNRasjFjgdjGfvCmXTwaMsoHN0KKo+3/6SNN3vGjaNUJcR3IWOO86Wtz5fsmeoFsSUryNKeJ/9G72XteSAsO1vsADWLxRU7/hBkQ5mb2buo/9hxeo7q6LjwVYWyeepvoMgODq+AVelOhevhdtfXtgI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEZsQk5ORDBDeitPT2tDR2FnVFNoQ0xoNVZzWkhranpPRkxkZkRuaUhLUHdM?=
 =?utf-8?B?OTE5ZHNyK1hEcExicURMaWJtdWZnY0xTLytuVkg1K0pWTEpYUGJkaUZ6QTR0?=
 =?utf-8?B?bnRHM1dxd3d4Rk1iZ3R1UU5PbWJ4L3BvVUU4VmJqU1VPclRHVDNNQUJyazlv?=
 =?utf-8?B?UTZsUzVtNHo1dUNWVVY0VklENC84Z2JQanVVWTdSZ3ByWHFXZ2hwRi9UUVIz?=
 =?utf-8?B?dllIcGhYbzFkZGIremNiVDd2LzZ6dVdJZ1lwQmlOb2lBZnF3NWl2eW9MejY4?=
 =?utf-8?B?R25xckZVQWt5SmNMbkZuV3RKazhGQ1hycnBJSXFzTHlYbXg4eS9aUUdzUXJR?=
 =?utf-8?B?cGhlQ3hNMlVpWUlSenhDUFlSU3pFRjRkYUJ0OUM4NUVuTW5OVFpqdnIrQ01C?=
 =?utf-8?B?TDhNS05OQyt5TlphRTNENFVXeUczMEI5ZFhndVdFY2RrUis4TUF3TCtoNStI?=
 =?utf-8?B?RVRlVzBDdzNkT3plQ3NGNmdWQmdCY1BRZGwyVVQ3OGxzM1AxOVJWYnFaMmJh?=
 =?utf-8?B?VHBiQ3JmaFJwTVZ5OVFDc0F3MG1JNEM5NUJyYnVtOExrOGc3WVZ4eWFXQXEw?=
 =?utf-8?B?V0JFMnFWYmlvM1lQN09jMG1ma3dybTJMN090MGdJdzFRc3lnSGs2TkhGTWJG?=
 =?utf-8?B?aUwxbWZIdkF3K2t2cVU4bG0rbnRVc0lyZ2dTaTMvRWplemllejlkeURCMXZs?=
 =?utf-8?B?Zm9mRDR5aHdsZGdSaE1lRkQ0d3dDQS80a0NzemdvZDdMOVNVK2k5M0pzSUNH?=
 =?utf-8?B?LzRQQjk2YXlPbHJDQXpMWlpjRlRNZkJJbXVMaFplTTlPdWxHSXFKVGJVUTJt?=
 =?utf-8?B?MkFEbzVMUzNscEY4bTlUczBYR1hWZXlFaXR2Y1pEZFN6VEF3Q2svbC9rY0U5?=
 =?utf-8?B?YXdlSXhaUFpWUG56bTMyMTA4My9paWVUTE1RUDdPRytEZjRPZDFERVBZZncy?=
 =?utf-8?B?bEYrS042RFkrejM3WllmcTFPb05IdGQzVmdwYUtjc2QwVGtSaHkvME9FSTMv?=
 =?utf-8?B?YWs4SUxjMEgxNmF0WXhhbmtodTBUNExqTUU4YU5wNmt1SGQyVGxKcDNRcGlo?=
 =?utf-8?B?Zit5QS9MT2pDM2JGdFZRWjlCUVpGaWFxTTRGOTJRZWNwa1NlWDFlUHJCU24v?=
 =?utf-8?B?bGdEalMrRVUyeGtnNGhsL2ZHaUt1enJyR3hEaVF3Ukh2UnJvL2JUTjEvODds?=
 =?utf-8?B?Um40c1VwTnY5WENudXh6VGlVRW1DaVoyempwM0xrems1ZHVndi9OOXl0d1Vn?=
 =?utf-8?B?blY0emYzRWdnNC81YU94SjRqa1E0M0R4bHVUMDF4NzhmL3Z6QW5QZHU4K3NC?=
 =?utf-8?B?S0pHOG9TdTBpbG5tS3U2Z1ZrVzFTL3VBQ0h0dURZcXpnK3RwTmg5Nk50U0VJ?=
 =?utf-8?B?eWRDakI4WGF3eHdnYytqR3ZFVSs3aWNzL2FjS0tHZEdQZ0krT2ZtcGNlTVJP?=
 =?utf-8?B?RVpRUk9SNC93Nm9oNzlIVTFod3IvZUlRN01sWWVjZGxReVdHQk9xTHE5N1VN?=
 =?utf-8?B?UDNlNTB3dUg5VGZaNDY5T2lNTSt0bzAyVEZvOTkvbVhQMWdDcjBHcndrU2pW?=
 =?utf-8?B?Sy93REk4VjZCLzVwMStoL3pvVG5BM2RuVEgvOFJnZlpoaUprUXlqNi9aS1I3?=
 =?utf-8?B?Sk9qcStwNlI1Rkg3V3BUWlp5Z0d4TmhtdFlOT3NWMkJLbndtbTJ3YVA2SDc3?=
 =?utf-8?B?dlM5TlRybTIzdGZ4aG0za3ZlVk12Vk9tVjNmZFM0YTIrRGJEVnRENCtCbGpR?=
 =?utf-8?B?WVJMenYwSGpRK20zU2RBMWV0SnkvTlVpbzg0L2xoRzd0QXFTdHNQeDNZUUcy?=
 =?utf-8?B?OXh0am5BOUVpWVZLMHc5M1gxNWdjV2R0aDFzeGtGYXZFSVBCcWJ3bVdpNlZp?=
 =?utf-8?B?U3lxQUFmUmRhbVJqL2hBaHZyQWN6dmhveU1GZjl0YzNSM2lSbTVPNXBlTll1?=
 =?utf-8?B?clFLNEVJZUJQTE1sWWRTV1MzdTVWMHdGUGlLZk9iVTYwTGNtdE1wajhFUzZu?=
 =?utf-8?B?YmxXMVUvL1VzUjJQNWlqcG1FaUxCZmNxZXIzOWxzQkkrQUQ5TjNBRHJlbkk4?=
 =?utf-8?B?OVhHRjFDbTRqaHVPWEp5SEIxc1BwNS8vSmJhb3g4SjRDUlVtUloyMldqTGEz?=
 =?utf-8?B?VHMrazJERy9XSDluSWEvNCt5KzJoVjhoMi9KdnR6WVdMVEt0bFdPcGZMMXRV?=
 =?utf-8?B?UGkzY2xuM0tHYTc2OGJxNUhBUFZrcE5VYVZ2K2RIQXlHREg5aFNDNDdTbThi?=
 =?utf-8?B?U2RGVnNqbE9aQUYxRDA2ZklLODVPT1hMQ3ZCNmlIaTBIWjdxMFFvUVRQdXdZ?=
 =?utf-8?B?UTM5WWVxcHk4Mlk0ZmV2NEdweCt1UzdQSy83d1RPUVlyd3l2K2hmM09BTm4x?=
 =?utf-8?Q?ayJuto5CZTBWwN4M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02C2365AAA665547B7CBBBD436100D1E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	F5AT17SZs8t9TRKowQo7uUwG5j9N3/xgmFivLBlaG6E4h/g6UwSCnNOctbKj93yAEck2yFaF6LchkxD4WiTzXbfws0YtfEYN1ITOYESqTSIIKYr/HvzeNqeBf2n80ZHJCUvnz+ifV+fDbE7Pb9Dr1QFkuBuNY+a4F6h9tFjeiU27rbtN6uuP0P6k/eeXOMh3eeap7HwKrcHRimxhIpY9fpKKUD9cdD9s0NDNsBooqdqUNZn5vdOYLALcrrQSa9yI6zcF2346QM1e6zhnfsc+XbW6N0b1S/B6T4GNhPqPwGiFpcB7+5kTjgQ+/9/6h1tIXLYzJRmoUm/lPSE3otHjlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n5sllQAPPT5ZC1HtD9sWRj6+CzYWzrRkwVGOBxaNZ4rXlEMAd4FfhSNXM7yj5rs3VCWQwtavk3Us6xZYAhM45oojq9L2ZXHH/NsS7d3ysSlsrf+FWIaPhIdyvKQ2UqNY+xJVjvnvVNvbh49bQhD7PqUFOU+1F43GW7JNPSFpSffWE0FVcNc6lMtbPKsHcoqdQorTOs2wbW+06pdWCpRjjBz/Ik+agP4qqjqpM7GCG7D2F2Kwt9oCxIlu19PAPzW3bxqq473mEF/lOpNEPMeIVTriBoTEgDX3zFcRDQ0q88tNJ8UD/OFZ9thzTo+Z9+LXZp/TQbWFbcU1rafSzUJYiXuqFFgUqiIweCf66UX0TBJMNVRIw7U9eQ5v8Z3oe0sgTZX8x2axDGIU5kkr+WwJJOzexrQ5+hcgCAfSLdVAfaa5Vj2I0atpYMbKLlccN037t2XuEUSCZQOvPKiIwS/wzmnSqcfT0tj+y32JiAueJmdTAjBOQbbFwwvdwYoGLTwb+CDoL5obmnvHcylhMP8SLP30Hvi+o2dFAwrZAaOGHxgo6g/Di3kGATlXPEcQo+zLSbFKQcTqPYLbfZu7eTy57OXTZSOzx1AOkxDxW3oUgGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be16824-7763-451b-aec0-08de95ea4c14
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2026 03:44:26.4128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8k/zcE0Zh7L631ZgFOW+slKQ8O7jnyUepa62RP9CuqUk5SSDwnW498pUCacfSJGKyiN/NEhWp3c2aM3UJ36dEov/SV70IBk3oFS36SxcPTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2604010000 definitions=main-2604090030
X-Proofpoint-ORIG-GUID: Ehfsyqh-qPCMl3eqWRm2Jk2mGXHeILlF
X-Proofpoint-GUID: Ehfsyqh-qPCMl3eqWRm2Jk2mGXHeILlF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDAzMCBTYWx0ZWRfXyDYSxHFegLDd
 X/gtKUig1cSJqjSePqE2YWf7cIX3K1C4NQjAX5RFyWCIKuR3At+9rHJj+PV809QmVfMpNuYGgjF
 /GFtXYBaYcVoXjLBUnjtk8vptn4r47ZTezI3BeH2o0skXzx7MC7MR4C5meFxIHJqjVYusHQOoHq
 mtW6GC2V1rIrdFl85B8/RRNInvQwOnGyGLLqvmo0EmTHlBwG3yRLaj0fvlU+KFyXKzR+0SxDCDo
 zH48fFyFI+k0X5tIq0AN/0tXJF8EoDoXIrtHLhX5Us7lBYnWmiF36InJY76IipOzo4KOzBO0ZPS
 Myw6w1QXhAEnhjiP6piPNmZ6Vkg2OH+A6cYA/laukX0BQ2rTJi+PZUdI/seL64JgMqj9QBzn5wI
 wiqvyK3iNTn7+zxWAkss3kz5IJScVHiL0P5uEP6YrJFlWx0CHUXs/vQGxgzxMgHkG68hGcg+If3
 OfBQIkSqSU0SWYMcMzQ==
X-Authority-Analysis: v=2.4 cv=NZXWEWD4 c=1 sm=1 tr=0 ts=69d7209f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22
 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=frT6iVIPheJ-ltOiFt8A:9
 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15199-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prakash.sangappa@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	APPLE_MAILER(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5E4423C6127
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGkgTWljaGFsLA0KDQpUaGFua3MgZm9yIGxvb2sgaW50byB0aGlzIHBhdGNoIHByb3Bvc2FsLg0K
DQoNCj4gT24gQXByIDgsIDIwMjYsIGF0IDU6NTTigK9BTSwgTWljaGFsIEtvdXRuw70gPG1rb3V0
bnlAc3VzZS5jb20+IHdyb3RlOg0KPiANCj4gSGkgUHJha2FzaC4NCj4gDQo+IE9uIFR1ZSwgQXBy
IDA3LCAyMDI2IGF0IDA1OjIzOjM4UE0gKzAwMDAsIFByYWthc2ggU2FuZ2FwcGEgPHByYWthc2gu
c2FuZ2FwcGFAb3JhY2xlLmNvbT4gd3JvdGU6DQo+PiBXaXRoIGNncm91cCBiYXNlZCByZXNvdXJj
ZSBtYW5hZ2VtZW50LCBpdCBiZWNvbWVzIHVzZWZ1bCBmb3INCj4+IHVzZXJzcGFjZSB0byBiZSBu
b3RpZmllZCB3aGVuIGEgdGFzayBjaGFuZ2VzIGNncm91cCBtZW1iZXJzaGlwLg0KPj4gVW5leHBl
Y3RlZCBtaWdyYXRpb25zIGNhbiBsZWFkIHRvIGluY29ycmVjdCByZXNvdXJjZSBhY2NvdW50aW5n
DQo+PiBhbmQgZW5mb3JjZW1lbnQgcmVzdWx0aW5nIGluIHVuZGVzaXJhYmxlIGJlaGF2aW9yIG9y
IGZhaWx1cmVzLg0KPj4gQXBwbGljYXRpb25zL3VzZXJzcGFjZSBoYXZlIHRvIHBvbGwgL3Byb2Mg
dG8gZGV0ZWN0IGNoYW5nZXMgdG8gDQo+PiBjZ3JvdXAgbWVtYmVyc2hpcCwgd2hpY2ggaXMgaW5l
ZmZpY2llbnQgd2hlbiBkZWFsaW5nIHdpdGggYSBsYXJnZQ0KPj4gbnVtYmVyIG9mIHRhc2tzLg0K
PiANCj4gWW91IG1heSB3YW50IHRvIGNoZWNrIFsxXSAoYW5kIGZvbGxvd3VwIGRpc2N1c3Npb24p
Lg0KDQpXaWxsIHRha2UgYSBsb29rLg0KDQo+IA0KPj4gQWRkIGEgbmV3IG5ldGxpbmsgcHJvYyBj
b25uZWN0b3IgZXZlbnQgdGhhdCBnZXRzIGdlbmVyYXRlZCB3aGVuDQo+PiBhIHRhc2sgbWlncmF0
ZXMgYmV0d2VlbiBjZ3JvdXBzLiBUaGlzIGFsbG93cyBhcHBsaWNhdGlvbnMvdG9vbHMNCj4+IHRv
IG1vbml0b3IgY2dyb3VwIG1lbWJlcnNoaXAgY2hhbmdlcyB3aXRob3V0IHBlcmlvZGljIHBvbGxp
bmcuDQo+IA0KPiBUaGlzIENOX0lEWF9QUk9DIG5ldGxpbmsgQVBJIGhhdW50cyBtZSBhdCBuaWdo
dC4NCj4gVGhlIGhvb2socykgcHJvcG9zZWQgYWJvdmUgYXJlIElNTyBtb3JlIGZ1dHVyZSBwcm9v
ZiBhbmQgcm9idXN0IGFwcHJvYWNoDQo+IHRvIHRoZSBwcm9jZXNzIG1pZ3JhdGlvbiB0aGF0IGNv
bWVzIGFzIGEgc3VycHJpc2UgKGFuZCBwb3NzaWJseQ0KPiBpbnRlcmZlcmVzIHdpdGggaW50ZW5k
ZWQgcmVzb3VyY2UgbWFuYWdlbWVudCkuDQoNCk9rLCB3aXRoIFsxXSB3b3VsZCB0aGVyZSBiZSBi
cGYgaG9va3MgdGhhdCBjYW4gYmUgdXNlZCBmb3Igbm90aWZpY2F0aW9uDQpvZiBjZ3JvdXAgbWln
cmF0aW9uIGV2ZW50cz8gIFdpbGwgdGFrZSBhIGxvb2suDQoNClRoYW5rcywNCi1QcmFrYXNoDQoN
Cj4gDQo+IFRoYW5rcywNCj4gTWljaGFsDQo+IA0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvYWxsLzIwMjYwMjIwLXdvcmstYnBmLW5hbWVzcGFjZS12MS0yLTg2NjIwN2RiN2I4M0BrZXJu
ZWwub3JnLw0KDQo=

