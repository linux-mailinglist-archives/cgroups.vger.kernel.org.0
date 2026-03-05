Return-Path: <cgroups+bounces-14674-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJ5XMiTCqWnNDQEAu9opvQ
	(envelope-from <cgroups+bounces-14674-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 18:49:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C48D72167D0
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 18:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6ADC63019FE3
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 17:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01FE3ED5C9;
	Thu,  5 Mar 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cjUutFyT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oZTLsQD0"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C873E5ECB;
	Thu,  5 Mar 2026 17:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732680; cv=fail; b=SwmnUCVFRVYIyy3KAaS+2B+foRnILf1NmYNhebrM/PhTIEJ4yBzm/QEbnObR5qNph9S6QA39ie0wDoI3UPy31/gxGlRLXdgejka2mINu9+MKK/jQ+A4HTUsb0oIZvqzorG9BkhmHD7hopuTiQ4teSJM3RyhhmKH+YOMvA0Wsnqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732680; c=relaxed/simple;
	bh=BpuGo6G0ljlDAg3yECRfD2B7Gb9xW/NZVhM6fJxqktg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JxycuUF+OzYNoYJErVexFXSqn/HxJE41e31ioYkmEMtUXsFqsluWusMbN8rzGYp1+zSjFkMSfvWtbCYstN9KLhkbAurTmozhMpxTu0KtYIu4t1DUdkyggFLkZ4+pr2kH/Ml+e16g2/yuh7CHPr8nBG2AvenT+1IXFVMYHEvlg+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cjUutFyT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oZTLsQD0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625HRQDR677308;
	Thu, 5 Mar 2026 17:44:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oWKmT6ROL1R0tdvNHiTVmWixp/OIIV+2PhNsA6h6fX0=; b=
	cjUutFyTwcZfzTpGp8XxqSP6TlR0MDm4Vc/9VSDPoX/Ls6LWe3s8+dvyNSwsbaDS
	Bv1tmxWbD0828ECmmYnive0CUwEnJs0QZsUt8tfrXaFsUlxoJgFldI6MTQkhbKVC
	Rrn2rrBvK8JhfgG1QGmxf56k6FlwPCUOyK1sSIKggd7nmpMITLZU68apFdLm2ZUe
	fRgfWsYNwuYg9i5MYqH245ElbEDUnBlQmg5YpfPWs/ZN5D/BGWFXQBlyVFb5GyFf
	nPrtpc6/TDAQi+8IzQ7es59zMRWWenbB3GSkcqWZYWSiaCEdQDxaF3e41C+s9+0L
	AsNa70hC6S2fRH0veUioFQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cqe88r1j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 17:44:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 625HQGfN029777;
	Thu, 5 Mar 2026 17:44:11 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012023.outbound.protection.outlook.com [52.101.53.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckptdhf41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Mar 2026 17:44:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIKW9LFfOPlVPRhiLkUsIDvMmZbqFM9H+1zUzhVIPL1lxiXU8DHTmmV9OTRrg5GDW3/5aRp6Uf00H6JlCF01+jJPOhWhEbuVz8n13EB5JAqTw7lxNEAzrMQys+z/zCcIF9DYodbDjloE6sS+GSiGfjNf8pETSpzzGrHR+fBbsCKUtvedGeay3T3SHJCE42YRM6hHHUiMUHBQGq1eGzu6+qz8NRDMyhTPsJxpKjhdgghSgeiQvf4+bDz66KJAiDRWAVNBFLxr1RHUs8u2H7s4LM7Q+NLo2Cl1zO9zAv3mI9Ddjr6zKQhOY3FK05BG76EpiGgb6vnFSnZ4G1hT7SLe/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWKmT6ROL1R0tdvNHiTVmWixp/OIIV+2PhNsA6h6fX0=;
 b=wSFO7yLHKMyQSZCIkh3SxoqfcpjHfp5xo8kAve5NjGTLCJgRP7x9KZ9uNPUATBN6ndJiux14wCj5L2qXeJT5aIOKBVYSj2eGbcqhmcRfJpdw8ehUkSsNM935luz9boHNIfb/E6Je8BML7qtr1SW7+pAjV9oB8s2VOdB+kvEy2+r+zP8sAuQ0Ss1P9IysOBKpbGh4pjSqTyDaZLSUUnJ98PEMT5h/QaEUmDz7S0gvTRJO8cumv+NjdLlkCf/xqYcc3Q2wLrYRbSvAnWis29FIcfWykU7NU2VfBfTVTQ6gDuooev44N6FXEkYy6EkUpV1q1p2iNG8F7xIMrWLf8hcONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWKmT6ROL1R0tdvNHiTVmWixp/OIIV+2PhNsA6h6fX0=;
 b=oZTLsQD0I5Vf857NG7gbJIVSlUgstrUJxVM+VRfm1VDbLW6O2pe/L5Di3izqOzfdNCrj+KS1vtHxBabaYpd5c/20dhZybGh3x8yr6TdZLe30wl3cTjHxxzjjw3M7fZbH3F4P/BQj/ioiMxJgAqDaM8F3zj+dtZ+pXpBuL313tWA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CYYPR10MB7626.namprd10.prod.outlook.com (2603:10b6:930:bb::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18; Thu, 5 Mar 2026 17:44:07 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 17:44:07 +0000
Message-ID: <ef48bf24-1fb0-40bb-9d78-322b9a27d1a1@oracle.com>
Date: Thu, 5 Mar 2026 17:43:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/bpf: add cgroup attach selftests
To: Christian Brauner <brauner@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Tejun Heo <tj@kernel.org>
Cc: KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>
References: <20260220-work-bpf-namespace-v1-0-866207db7b83@kernel.org>
 <20260220-work-bpf-namespace-v1-4-866207db7b83@kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260220-work-bpf-namespace-v1-4-866207db7b83@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DX0P273CA0024.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5b::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CYYPR10MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 962f54d8-4e23-42ee-da5b-08de7adeccf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	7lYy6sFs//Zij+KyLY2wTEXRojNjGWj17yqr5F0OkgvN7tnF53tewfyVWbDpl23jATJX+6iF1fx38oRex/LNffcmmpxIuaVYlhq4rAN5y0S4mxMAfSPdPc6tLYiuW4joFXBC7Kzl93tlWuBInzH5mV4YD6NLCARsW6RRXDUmBG370nYWV02sfWdAyv3ohyZEQBxHs+AC4i9HMb3PaZs52O7Q0ImQ6TcEWKjcmgSaZ8BZtczPl/I2BX6psg0s/NjoVy2YwHcI8GnteKIACC+M4drJxDxbHnAWMEO8QKvHXklK25/bAL0BtHpAHKs+ky47wUqnVUzxPN2rR7VGO4B+w2RNra3xi2nPNSAhCKAoYPksShSky4V1SQDB6cI2mDG1XtLQtrzQRP5UPvFgpCLSwImkPdcilKvNNktHodws9tJ5RPAMOzjSpNeLGcb3vdGUKNNUyuQUeE0K5FMidQNNIl8CoEk3K7HRV7MxC//ONqj1mdL3ZHStJkuXvyKoXok27OI7ioLZZHso1eNVR5PCJlHGdSJ+WAI+3VzCmfIaT5e94zVlQacXiF6hJexL64ADveebwudTxKKrElcBmhr71mMby80nn7U1Cw4fpcuJjaxFuZaMrAbC9Qk3RSdM9vyVscnHVB/vneQF8EEoKl3XOjjhBX9B0G/jbHehlV6q507EmWWGUHMbHT2ldBvALPbuZtfOrgCToN6LxYHJZMkQnGREN7LjiGyf+D1DtN2z6bU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEE0RGgyQmlqdGhEUXoxT2gwb0NEV2JqUVRtWGJISUlVYitlcW5MQ0haNjdL?=
 =?utf-8?B?a3V0NE0vWVFXRE5vOUwrMWVHMkphSzhMWmM2STBKTHhkZFc4N1VZdC9lWG91?=
 =?utf-8?B?Y0J1dVovOXdWQ2p2VTZjTHBlN3o3VU03Si95ZVJrNEwya21aTnpjc3R0cmJs?=
 =?utf-8?B?MzRYYlVtQ3dHdGFPcFZwOGUyOElFeHZYK09SQ0FMaElLUlFOSjdKaFRYYzQv?=
 =?utf-8?B?QVdIajBHWXRBYnNhT3lCS1ZSNVpqMGR3UXhXMzVUc2VLdmR5L0lKSG05UFJS?=
 =?utf-8?B?d2xWMjJ1Q3BMUUNKSGV4VGJsbVAzWmovNnZtbFNYQjNjVmk2MVJxdXZlMnQw?=
 =?utf-8?B?K0JIUVozQTdXby9YNVRuUU4xWEpLQ1czM2twWWVlMm5sQzdZdzRlbW4wMElo?=
 =?utf-8?B?MTQ1SmFMOFR0aXFLZXJEZENJZjBGWlo5NU1hTUE5aVZsMHlvU3gybXRHelVu?=
 =?utf-8?B?WnkxdnY0bkZXWUxuOXArQUtzNmVFdDRmVmpORWJyZWJLalExYjJ0amlmNGNS?=
 =?utf-8?B?bVdYNUZaU3IvZGdkWEJyb0xSazlOdnRYTmZqRjdPeWpzczNKMXNlOVg3ZWFO?=
 =?utf-8?B?b3p6TE5RblU1ZzhMeWlwK3pyckhQOENqVXNLUWQ1bmZnbHVGbkFTU2R1WmNv?=
 =?utf-8?B?UllHd2dYOVA2MWhrVU5MWndTc1B0clJuaGFTNkxRWEUvekd1V01UdmxGRjlS?=
 =?utf-8?B?WUdPUk10c0tNV245bHdhSVVzV3UyTUxMUHFoeEdMcXRSOWtkbU5ieGlRSTJJ?=
 =?utf-8?B?VHJseW1ESExFeGpNSnVlc2NtcjFGYk1zWE52WnhZN0tOdE9rZVlWTTNXUXZa?=
 =?utf-8?B?VWpabXRqOTg5L3FyNFI5aUhpNmZjZUVBcWpSM1RUSml2SmJjMDVZYlE4RS9P?=
 =?utf-8?B?QkQyTmZTQVRwQ2dMZUVpdDRibG1aaWUraXNUOWluejhlZCt5d3JFYnNWdXFx?=
 =?utf-8?B?Ymg4YkR1c2pZYWlPNHZkVGswalg5T2p6S1R5cTFCTTM0TkpEdzF2ZWVlR1JS?=
 =?utf-8?B?MC9WTkluYUdvTXpyMDFMRzViR1FqRkpuWmQxdjRnU2FENzZoRkVCWTJtZnov?=
 =?utf-8?B?Wm9UWWpFUitMaVZGN3hMK01LaDRzemxXN2hkbjVCUGJVK3EyeUJQVlBrK2NE?=
 =?utf-8?B?dlZ4c0hDUnBnZTZvZ1JaQ2JZSUFLWVBUZVV5NmlLRkEvdS92bnFyeUF6Mi9P?=
 =?utf-8?B?TmpGTlg3M1Z2Yy9Ob1cvRzVjUVNuZmdlYkNGS21HMkJCK1oyL2RZV2NJeHFt?=
 =?utf-8?B?N1lXVXpoKzk3RVZmU1RuRUR2d1JIMkRPak0zRVUzcHNpZVhWdzZ2YjVuR2RO?=
 =?utf-8?B?QzQ1OUl5dFJiOG5oQW1xT3pzdm9rKzB0UDEvZStNSHF4QUxNcEIxSDl6UkRJ?=
 =?utf-8?B?MjBZd29ZdURYOGFHNmFWMUtEVUpEWUh6U0EwbXdkMm54RlVVNkczU1Z4SHJm?=
 =?utf-8?B?V2xsbXY4Q1d0ejJvSXhicHp3ZzhuejJDRW5hRkQ4OTQ0alV6a3BKcjNUYjJH?=
 =?utf-8?B?SEZkbUpKUnVWd29pL2Vva0VNVmxpOWNxWUM5TVVQWmk2dU1qQTEzb1Bwem9C?=
 =?utf-8?B?djdBSGcySmJvWVpRc2g4ZG1sTlpNbVJwczhDckF4YTdocDBVUFlrc2dJMDdT?=
 =?utf-8?B?cmhCS0VsclpJUGl0QzRsbU4ybHpnZ3JLMkJSWS9sa3NCR2pvL2QvUlRjMWpi?=
 =?utf-8?B?ZktBTHpWb1U0d2RvMGlEczBqSTMySmNBSHlXTW1HRmtEQ2Z4VGp5NldaUjZp?=
 =?utf-8?B?VFNBMXcxZHZyVGl1WWorc3NsS2twVy9MNlNaWlZXSUk5UGlLZWdmTWRad2Jl?=
 =?utf-8?B?eTdVUTJlTmZPM01CQU93bzZXd1JXNzlIS3djWWw3Q2tNRndiNFhsYjAvc2Yw?=
 =?utf-8?B?NFYrSENmU1N0aVRJNENnRTM3WlhmbHVac2hHeUdzQ2JFckppOGFwaUZwYkFZ?=
 =?utf-8?B?eTc2bUY3TkxrTnprKy90Yjd3Wm5ZTm1IYk50NUlzVW5pNWF1Nk5lcmpncVVX?=
 =?utf-8?B?eTlSZ3VZYXVMcjgzYS81MGdDdWQrQjB3emdzSDl6THlib2ZJV0hNcTRzS2c0?=
 =?utf-8?B?RXhrRmpFbVA1V3VDcENrNmc1d0lFYzV0VkxJQXRDaW9oN1NEU2srMTRscXF4?=
 =?utf-8?B?U01Mclh2S1NqN3V4RVplNHJIc3htVXFJK3dFTDVxUlJrcFpOU3JxOHZ3OTg0?=
 =?utf-8?B?a1FIb3dnUFp3aUVwMVliWmJyTXVjVzEyZFNDNjJOOCtvRXdqb2pKeElqWndj?=
 =?utf-8?B?ZGkyU2liQ2g1aTJkOTlHYmJxcDkwaDFxUUQyMEJYSjY2WVhTZ0ZyL2NhcFdC?=
 =?utf-8?B?R0IvWFc3R1lkd0IvMGtEb0taY2xVaUhWa1c3L2o0S2lmTG5pSFlsUT09?=
X-Exchange-RoutingPolicyChecked:
	ps1cKKko8UuIpAfNYM+Avfbf9fF04kU4gfwuIB/a71KFIss2xei+3DEt22SunmSq7IGKRMGij5+prENRBTcVxrGn1Dc6FuhjRKuimf7uY0AEfCa6wlja6U6Sm056yNj4IxThQfY9gXod4etmhgwfy9akjenePurvSdtqtm0Xs1hTRQlg5DywSaBmqadoQPg7boRvMdGAOpvnuOCvkkYRPAhIkO/vBc1OPkeeWoNO2aCBOSZnLZ/C0FoWl1abJoKDIfm0NmIUFC7jscmY1CM91cBnyT2SS/3IlG7H8SgRGdxGlOMt8G7nmlgNsAthkWFAzS+TtutekQyhwXzQEvUYFg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PV0FdVHFI1vM/CNyIII3f06R6K2YAl3PJNV1sfbtLakg+cUlN5la0sQgw/nFbM0LktlXrdrQqcKR1WEku/UpvTqrgTP+Qpq27Bd2hAyjMQrIayD3lKrVDD7FN+6f4pM9jf48V40mQI9Bep8ZUXOHvFpjZ4CKt3rvKUcBJfMqHTNIWGaON+cTSYl2S1vRI8tOLomeDGlpd4VaIKbPLFj7ZeV9o2wwq8f19vwYlVEP9Wg52wcaYYNdUM7PkECyoOYrwwzPiE0cIwjY/QgOkj6gg5Xuzo+nP0lLpgyBvRZzlOt7wnIxGqx4KPqXwGMGOJx5W43zC47fdFWFymYH99TMFhdKYoBVCaKBQVQQsqK+czjmKskp2D/IUNd7cnL3YNE4FY4t28RXbAYrieqF57KIs+jNyYIDi/p3ETf+HUM1e/dcrVhPl5FLiirx+apoUI2QoV9VJiuUXDjAVE1NmN3O0iVcS7xi1M4rl4IOjl+N+4hd0jDGwMRMj1xqYKEZCdn+uP5H9V9JmWMbf0Fou3umzO5V/kXhFb3ZnfOXO0RjiXW7NKH6N+4SqFTOCwWMGKxyYcZ1sdcbJ7oBKmSYzDEsV9wQafP2PuPP/E7Aw8sw/SQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962f54d8-4e23-42ee-da5b-08de7adeccf2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 17:44:07.4337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RTtGUnRJVJDymueyjQERd8bCbU1dEmyrcRSEmkeMyE5JkgbuRwSnyCEEQ1K0JR1JrpSHaKGtjXS7bPTxlRFEwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7626
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603050145
X-Proofpoint-ORIG-GUID: xDiiT5JLtXmwGUA5gPsoi_AfIZhowOCA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0NSBTYWx0ZWRfXwt0uPjveE7SB
 aBn+O/ahcZl7wxRqwEa2PC/qoqmtmqnPo9/2KgOjQ/zrGYy7cT30Kirm80Qlf9YuMPAOWwfy8fI
 d0IipNNS4Afcw2EMxy4hDxHnv9PVe4M0uGAGqsfWsLS7r/Fa0sYde6XZBzMtzyAxLiOe2gMA9RX
 BPvjLH7jGpuZE5THMFiqsP78w1HBSWrtpJ9IPOD+OdiaKViWRlqK3QzF+ttgsA+4P3Oq4hBNcAC
 YOIZf7ibyiwHJ5mDE+KCJvLNtssoHMiZFvm3mmFJPsWmfr/odga8D60JYyRGOJMVOrYf7os9rXb
 pSkIQVuLHelQ00ngmMjzbZouesZ8ODz+jCIuolUz2FipzItNnUXlnkxqeKNLLcVzLRDbbCFcorP
 Vi7XHZtY+IvPAwrqaiBPLv1ZN0TJ0hiMg0hOmNm11A5hOQsd6uYcKPz+vtSH4I3j4T1InxfFytP
 B2oErtfOOqslG5aSWdA==
X-Proofpoint-GUID: xDiiT5JLtXmwGUA5gPsoi_AfIZhowOCA
X-Authority-Analysis: v=2.4 cv=fsnRpV4f c=1 sm=1 tr=0 ts=69a9c0ec b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=eEIn5IY0qqQ7KplES98A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: C48D72167D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-14674-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oracle.com:dkim,oracle.com:email,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alan.maguire@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On 20/02/2026 00:38, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>

one optional suggestion below, but

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  .../selftests/bpf/prog_tests/cgroup_attach.c       | 362 +++++++++++++++++++++
>  .../selftests/bpf/progs/test_cgroup_attach.c       |  85 +++++
>  2 files changed, 447 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c b/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c
> new file mode 100644
> index 000000000000..05addf93af46
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/cgroup_attach.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +
> +/*
> + * Test the bpf_lsm_cgroup_attach hook.
> + *
> + * Verifies that a BPF LSM program can supervise cgroup migration
> + * through both the cgroup.procs write path and the clone3 +
> + * CLONE_INTO_CGROUP path.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <linux/sched.h>
> +#include <linux/types.h>
> +#include <sched.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include <test_progs.h>
> +#include "cgroup_helpers.h"
> +#include "test_cgroup_attach.skel.h"
> +
> +/* Must match the definition in progs/test_cgroup_attach.c */
> +struct attach_event {
> +	__u32 task_pid;
> +	__u64 src_cgrp_id;
> +	__u64 dst_cgrp_id;
> +	__u8  threadgroup;
> +	__u32 hook_count;
> +};
> +
> +#ifndef CLONE_INTO_CGROUP
> +#define CLONE_INTO_CGROUP 0x200000000ULL
> +#endif
> +
> +#ifndef __NR_clone3
> +#define __NR_clone3 435
> +#endif
> +
> +struct __clone_args {
> +	__aligned_u64 flags;
> +	__aligned_u64 pidfd;
> +	__aligned_u64 child_tid;
> +	__aligned_u64 parent_tid;
> +	__aligned_u64 exit_signal;
> +	__aligned_u64 stack;
> +	__aligned_u64 stack_size;
> +	__aligned_u64 tls;
> +	__aligned_u64 set_tid;
> +	__aligned_u64 set_tid_size;
> +	__aligned_u64 cgroup;
> +};
> +
> +static pid_t do_clone3(int cgroup_fd)
> +{
> +	struct __clone_args args = {
> +		.flags = CLONE_INTO_CGROUP,
> +		.exit_signal = SIGCHLD,
> +		.cgroup = cgroup_fd,
> +	};
> +
> +	return syscall(__NR_clone3, &args, sizeof(args));
> +}
> +
> +/*
> + * Subtest: deny_migration
> + *
> + * Verify that the BPF hook can deny cgroup migration through cgroup.procs
> + * and that detaching the BPF program removes enforcement.
> + */
> +static void test_deny_migration(void)
> +{
> +	struct test_cgroup_attach *skel = NULL;
> +	int allowed_fd = -1, denied_fd = -1;
> +	unsigned long long denied_cgid;
> +	int err, status;
> +	__u64 key;
> +	__u8 val = 1;
> +	pid_t child;
> +
> +	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
> +		return;
> +
> +	allowed_fd = create_and_get_cgroup("/allowed");
> +	if (!ASSERT_GE(allowed_fd, 0, "create /allowed"))
> +		goto cleanup;
> +
> +	denied_fd = create_and_get_cgroup("/denied");
> +	if (!ASSERT_GE(denied_fd, 0, "create /denied"))
> +		goto cleanup;
> +
> +	skel = test_cgroup_attach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		goto cleanup;
> +
> +	err = test_cgroup_attach__attach(skel);
> +	if (!ASSERT_OK(err, "skel attach"))
> +		goto cleanup;
> +
> +	skel->bss->monitored_pid = getpid();
> +
> +	denied_cgid = get_cgroup_id("/denied");
> +	if (!ASSERT_NEQ(denied_cgid, 0ULL, "get denied cgroup id"))
> +		goto cleanup;
> +
> +	key = denied_cgid;
> +	err = bpf_map__update_elem(skel->maps.denied_cgroups,
> +				   &key, sizeof(key), &val, sizeof(val), 0);
> +	if (!ASSERT_OK(err, "add denied cgroup"))
> +		goto cleanup;
> +
> +	/*
> +	 * Forked children must use join_parent_cgroup() because the
> +	 * cgroup workdir was created under the parent's PID and
> +	 * join_cgroup() constructs paths using getpid().
> +	 */
> +
> +	/* Child migrating to /allowed should succeed */
> +	child = fork();
> +	if (!ASSERT_GE(child, 0, "fork child allowed"))
> +		goto cleanup;
> +	if (child == 0) {
> +		if (join_parent_cgroup("/allowed"))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	err = waitpid(child, &status, 0);
> +	ASSERT_GT(err, 0, "waitpid allowed");
> +	ASSERT_TRUE(WIFEXITED(status), "allowed child exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "allowed migration succeeds");
> +
> +	/* Child migrating to /denied should fail */
> +	child = fork();
> +	if (!ASSERT_GE(child, 0, "fork child denied"))
> +		goto cleanup;
> +	if (child == 0) {
> +		if (join_parent_cgroup("/denied") == 0)
> +			_exit(1); /* Should have failed */
> +		if (errno != EPERM)
> +			_exit(2); /* Wrong errno */
> +		_exit(0);
> +	}
> +	err = waitpid(child, &status, 0);
> +	ASSERT_GT(err, 0, "waitpid denied");
> +	ASSERT_TRUE(WIFEXITED(status), "denied child exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "denied migration blocked");
> +
> +	/* Detach BPF — /denied should now be accessible */
> +	test_cgroup_attach__detach(skel);
> +
> +	child = fork();
> +	if (!ASSERT_GE(child, 0, "fork child post-detach"))
> +		goto cleanup;
> +	if (child == 0) {
> +		if (join_parent_cgroup("/denied"))
> +			_exit(1);
> +		_exit(0);
> +	}
> +	err = waitpid(child, &status, 0);
> +	ASSERT_GT(err, 0, "waitpid post-detach");
> +	ASSERT_TRUE(WIFEXITED(status), "post-detach child exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "post-detach migration free");
> +
> +cleanup:
> +	if (skel)
> +		test_cgroup_attach__destroy(skel);
> +	if (allowed_fd >= 0)
> +		close(allowed_fd);
> +	if (denied_fd >= 0)
> +		close(denied_fd);
> +	cleanup_cgroup_environment();
> +}
> +
> +/*
> + * Subtest: verify_hook_args
> + *
> + * Verify that the hook receives correct src_cgrp, dst_cgrp, task pid,
> + * and threadgroup values.
> + */
> +static void test_verify_hook_args(void)
> +{
> +	struct test_cgroup_attach *skel = NULL;
> +	struct attach_event evt = {};
> +	unsigned long long src_cgid, dst_cgid;
> +	int src_fd = -1, dst_fd = -1;
> +	__u32 map_key = 0;
> +	char pid_str[32];
> +	int err;
> +
> +	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
> +		return;
> +
> +	src_fd = create_and_get_cgroup("/src");
> +	if (!ASSERT_GE(src_fd, 0, "create /src"))
> +		goto cleanup;
> +
> +	dst_fd = create_and_get_cgroup("/dst");
> +	if (!ASSERT_GE(dst_fd, 0, "create /dst"))
> +		goto cleanup;
> +
> +	/* Move ourselves to /src first */
> +	if (!ASSERT_OK(join_cgroup("/src"), "join /src"))
> +		goto cleanup;
> +
> +	skel = test_cgroup_attach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		goto cleanup;
> +
> +	err = test_cgroup_attach__attach(skel);
> +	if (!ASSERT_OK(err, "skel attach"))
> +		goto cleanup;
> +
> +	skel->bss->monitored_pid = getpid();
> +
> +	src_cgid = get_cgroup_id("/src");
> +	dst_cgid = get_cgroup_id("/dst");
> +	if (!ASSERT_NEQ(src_cgid, 0ULL, "get src cgroup id"))
> +		goto cleanup;
> +	if (!ASSERT_NEQ(dst_cgid, 0ULL, "get dst cgroup id"))
> +		goto cleanup;
> +
> +	/* Migrate self to /dst via cgroup.procs (threadgroup=true) */
> +	snprintf(pid_str, sizeof(pid_str), "%d", getpid());
> +	if (!ASSERT_OK(write_cgroup_file("/dst", "cgroup.procs", pid_str),
> +		       "migrate to /dst"))
> +		goto cleanup;
> +
> +	/* Read the recorded event */
> +	err = bpf_map__lookup_elem(skel->maps.last_event,
> +				   &map_key, sizeof(map_key),
> +				   &evt, sizeof(evt), 0);

could just add a last_event struct to skel->bss and save the map
storage/lookup, but not a big deal.
 
> +	if (!ASSERT_OK(err, "read last_event"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(evt.src_cgrp_id, src_cgid, "src_cgrp_id matches");
> +	ASSERT_EQ(evt.dst_cgrp_id, dst_cgid, "dst_cgrp_id matches");
> +	ASSERT_EQ(evt.task_pid, (__u32)getpid(), "task_pid matches");
> +	ASSERT_EQ(evt.threadgroup, 1, "threadgroup is true for cgroup.procs");
> +	ASSERT_GE(evt.hook_count, (__u32)1, "hook fired at least once");
> +
> +cleanup:
> +	if (skel)
> +		test_cgroup_attach__destroy(skel);
> +	if (src_fd >= 0)
> +		close(src_fd);
> +	if (dst_fd >= 0)
> +		close(dst_fd);
> +	cleanup_cgroup_environment();
> +}
> +
> +/*
> + * Subtest: clone_into_cgroup
> + *
> + * Verify the hook fires on the clone3(CLONE_INTO_CGROUP) path and can
> + * deny spawning a child directly into a cgroup.
> + */
> +static void test_clone_into_cgroup(void)
> +{
> +	struct test_cgroup_attach *skel = NULL;
> +	int allowed_fd = -1, denied_fd = -1;
> +	unsigned long long denied_cgid, allowed_cgid;
> +	struct attach_event evt = {};
> +	__u32 map_key = 0;
> +	__u64 key;
> +	__u8 val = 1;
> +	int err, status;
> +	pid_t child;
> +
> +	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_env"))
> +		return;
> +
> +	allowed_fd = create_and_get_cgroup("/clone_allowed");
> +	if (!ASSERT_GE(allowed_fd, 0, "create /clone_allowed"))
> +		goto cleanup;
> +
> +	denied_fd = create_and_get_cgroup("/clone_denied");
> +	if (!ASSERT_GE(denied_fd, 0, "create /clone_denied"))
> +		goto cleanup;
> +
> +	skel = test_cgroup_attach__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel open_and_load"))
> +		goto cleanup;
> +
> +	err = test_cgroup_attach__attach(skel);
> +	if (!ASSERT_OK(err, "skel attach"))
> +		goto cleanup;
> +
> +	skel->bss->monitored_pid = getpid();
> +
> +	denied_cgid = get_cgroup_id("/clone_denied");
> +	allowed_cgid = get_cgroup_id("/clone_allowed");
> +	if (!ASSERT_NEQ(denied_cgid, 0ULL, "get denied cgroup id"))
> +		goto cleanup;
> +	if (!ASSERT_NEQ(allowed_cgid, 0ULL, "get allowed cgroup id"))
> +		goto cleanup;
> +
> +	key = denied_cgid;
> +	err = bpf_map__update_elem(skel->maps.denied_cgroups,
> +				   &key, sizeof(key), &val, sizeof(val), 0);
> +	if (!ASSERT_OK(err, "add denied cgroup"))
> +		goto cleanup;
> +
> +	/* clone3 into denied cgroup should fail */
> +	child = do_clone3(denied_fd);
> +	if (child >= 0) {
> +		waitpid(child, NULL, 0);
> +		ASSERT_LT(child, 0, "clone3 into denied should fail");
> +		goto cleanup;
> +	}
> +	if (errno == ENOSYS || errno == E2BIG) {
> +		test__skip();
> +		goto cleanup;
> +	}
> +	ASSERT_EQ(errno, EPERM, "clone3 denied errno");
> +
> +	/* clone3 into allowed cgroup should succeed */
> +	child = do_clone3(allowed_fd);
> +	if (!ASSERT_GE(child, 0, "clone3 into allowed"))
> +		goto cleanup;
> +	if (child == 0)
> +		_exit(0);
> +
> +	err = waitpid(child, &status, 0);
> +	ASSERT_GT(err, 0, "waitpid clone3 allowed");
> +	ASSERT_TRUE(WIFEXITED(status), "clone3 child exited");
> +	ASSERT_EQ(WEXITSTATUS(status), 0, "clone3 child ok");
> +
> +	/* Verify the hook recorded the allowed clone */
> +	err = bpf_map__lookup_elem(skel->maps.last_event,
> +				   &map_key, sizeof(map_key),
> +				   &evt, sizeof(evt), 0);
> +	if (!ASSERT_OK(err, "read last_event"))
> +		goto cleanup;
> +
> +	ASSERT_EQ(evt.dst_cgrp_id, allowed_cgid, "clone3 dst_cgrp_id");
> +
> +cleanup:
> +	if (skel)
> +		test_cgroup_attach__destroy(skel);
> +	if (allowed_fd >= 0)
> +		close(allowed_fd);
> +	if (denied_fd >= 0)
> +		close(denied_fd);
> +	cleanup_cgroup_environment();
> +}
> +
> +void test_cgroup_attach(void)
> +{
> +	if (test__start_subtest("deny_migration"))
> +		test_deny_migration();
> +	if (test__start_subtest("verify_hook_args"))
> +		test_verify_hook_args();
> +	if (test__start_subtest("clone_into_cgroup"))
> +		test_clone_into_cgroup();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_cgroup_attach.c b/tools/testing/selftests/bpf/progs/test_cgroup_attach.c
> new file mode 100644
> index 000000000000..90915d1d7d64
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_cgroup_attach.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026 Christian Brauner <brauner@kernel.org> */
> +
> +/*
> + * BPF LSM cgroup attach policy: supervise cgroup migration.
> + *
> + * A designated process populates a denied_cgroups map with cgroup IDs
> + * that should reject migration.  The cgroup_attach hook checks every
> + * migration and returns -EPERM when the destination cgroup is denied.
> + * It also records the last hook invocation into last_event for the
> + * userspace test to verify arguments.
> + */
> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +struct attach_event {
> +	__u32 task_pid;
> +	__u64 src_cgrp_id;
> +	__u64 dst_cgrp_id;
> +	__u8  threadgroup;
> +	__u32 hook_count;
> +};
> +
> +/*
> + * Cgroups that should reject migration.
> + * Key:   cgroup kn->id (u64).
> + * Value: unused marker.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_HASH);
> +	__uint(max_entries, 16);
> +	__type(key, __u64);
> +	__type(value, __u8);
> +} denied_cgroups SEC(".maps");
> +
> +/*
> + * Record the last hook invocation for argument verification.
> + * Key:   0.
> + * Value: struct attach_event.
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, 1);
> +	__type(key, __u32);
> +	__type(value, struct attach_event);
> +} last_event SEC(".maps");
> +
> +__u32 monitored_pid;
> +
> +char _license[] SEC("license") = "GPL";
> +
> +SEC("lsm.s/cgroup_attach")
> +int BPF_PROG(cgroup_attach, struct task_struct *task,
> +	     struct cgroup *src_cgrp, struct cgroup *dst_cgrp,
> +	     struct super_block *sb, bool threadgroup,
> +	     struct cgroup_namespace *ns)
> +{
> +	struct task_struct *current = bpf_get_current_task_btf();
> +	struct attach_event *evt;
> +	__u64 dst_id;
> +	__u32 key = 0;
> +
> +	dst_id = BPF_CORE_READ(dst_cgrp, kn, id);
> +
> +	if (bpf_map_lookup_elem(&denied_cgroups, &dst_id))
> +		return -EPERM;
> +
> +	if (!monitored_pid || current->tgid != monitored_pid)
> +		return 0;
> +
> +	evt = bpf_map_lookup_elem(&last_event, &key);
> +	if (evt) {
> +		evt->task_pid = task->pid;
> +		evt->src_cgrp_id = BPF_CORE_READ(src_cgrp, kn, id);
> +		evt->dst_cgrp_id = dst_id;
> +		evt->threadgroup = threadgroup ? 1 : 0;
> +		evt->hook_count++;
> +	}
> +
> +	return 0;
> +}
> 


