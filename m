Return-Path: <cgroups+bounces-7753-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F68A995C3
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 18:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02091188CD22
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D0F285401;
	Wed, 23 Apr 2025 16:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A8G3L1Pr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="abQMOd9f"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75F726A081;
	Wed, 23 Apr 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427081; cv=fail; b=q3eczUvbSWGx2jtSMpo4XhaOnUe3SiVIpwtEjKNpoSQMB7KuaOW3jVuS7JTjagV3pCJXhvS8He1vQBdXgboiXARoEhdlBPiyNPdy5HmRH7V62+tM5x+cUQrzzZz/VhnRDboT6mUUCZkevXA4n5y6ZBqO/mdgrinmBYO4RN/dr/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427081; c=relaxed/simple;
	bh=/SPnf4ZpIChjvjaenWAgFGut1KIdeXJrcBRs+/rV484=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MrLk+HuFt3Dgo1Hr+WYZaN3JqN3Dj3/L1vAwkkXiaInfThjayPRT1ymH/rAi05r9p2RUfga25Z8Uqp4vAawiEH2+1+UrONA3zIX4O0US+PcBvZmX24yEjZOX7UK9UKFqSae5OeQhjNcCqMzalt1TxRTFoCTd2P99nyCTpsq36KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A8G3L1Pr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=abQMOd9f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGo5a7014992;
	Wed, 23 Apr 2025 16:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/SPnf4ZpIChjvjaenWAgFGut1KIdeXJrcBRs+/rV484=; b=
	A8G3L1PrUQPvHyDHeP3McFXhcyKkY1Y/rU+GJB5IN/95+ynaNfWZiz7GEzbp0a/N
	qocBNAirdFOv8rraFV2tW6/aG3rWUOUjKBavO9p2EZlXlx5GnSYtHvikMoxnp0h3
	/ToVPTkeNjSGRVrAXQ9zNWp1nsRAG0j3OhNgjc/k/jRYi5jEHFJYCVLbqYVpRbF2
	IpSw/CpQRClo97v5Mg0ZJd58zcWCbcAUX5J1mjOiPmJVFa2cEw6jP6Eqqh/0vLTZ
	osX+d+wvzLGQYw/c12MwXWLsOI9ktiUvlF4+NWMXyAhMHUreDG5BjgTk1j4aujyN
	f8w5rZgKDefAb/8A1VE9Ug==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha1q2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:50:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NFpjWw028470;
	Wed, 23 Apr 2025 16:50:19 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013076.outbound.protection.outlook.com [40.93.1.76])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx6cctc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 16:50:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp2bqipNy1rf5lCqp3On14k0ZfXV0Vr9NwCn/HSzpdiy2AAgj3W7Ki1cjqrIUXRS8lgPZ++piISbOpjewYp4qz1fMD4tjGuTzlnXvmzZGkRvr2CqHamK7G/jfgBx7N2R07QmXuNB2KfNgcS+VHc7X7dEeFi9Kg3aId2H0TSH0P8TgsWsVRrM22zmsSc68QHdzTonvK2x7QfIqmzzmNZ95//+3eWbs2UeOZrIZxG7XLHwR8YW8auF0Dwie1x2E+2BQDP1voHUdb8HNOpMEOuuem6QCa4lqxFw3RLtY4HWkuCfx3klTDPreI8UxeixGuUazWBB+LtegPuP60zDduHcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SPnf4ZpIChjvjaenWAgFGut1KIdeXJrcBRs+/rV484=;
 b=fdqLA76EPw6EHeO3GLcdWj4/z1LBz8NRVSZudzDLt5GfY1jpSTeFU3uJi/wkKqu+8dRoGYiKrheNzFmqg+250KIqQqEnBhBxxWdm39YF4bjZjoJZi6Vesbb+2fnchzSyEbRYqztw7i3BR5cMOCRqc2CNjNkN1w4XdhcY8nTmZCfqoehMoxFAPp2ka9AYj8zgLZxa73TmbBSRMA77VVUGk0JMXSGJ7nhOIR9oF5NkZfEmNYmj6yTX99QDLkFp7JANm16y6lNYx9kfr0SXpJnDdRF4Fe8LXxvuzl9vQofqdvBHFGCSn39nEUbsacpY9c69f+QNdS/EtyWnbEKi5zJv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SPnf4ZpIChjvjaenWAgFGut1KIdeXJrcBRs+/rV484=;
 b=abQMOd9fDxl2F/NwW0IZ0wrqaCB4N7RcYi89kRxIFp3vLxVnflnIs1+yXlo0AjpB/DhfQk/+ab+EnrD01scpFRw/gfmtjOzni+H0hW8VLk4SdzH6wbGS+KM1zouujd6r4RVEzZ1ic0MFtc0tifWS7GjLAiFSbLEw7yzQrm1LEw4=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by BLAPR10MB5188.namprd10.prod.outlook.com (2603:10b6:208:30d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 16:50:15 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 16:50:15 +0000
From: Libo Chen <libo.chen@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "peterz@infradead.org" <peterz@infradead.org>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "llong@redhat.com"
	<llong@redhat.com>,
        "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>,
        "raghavendra.kt@amd.com" <raghavendra.kt@amd.com>,
        "yu.c.chen@intel.com"
	<yu.c.chen@intel.com>,
        "tim.c.chen@intel.com" <tim.c.chen@intel.com>,
        "vineethr@linux.ibm.com" <vineethr@linux.ibm.com>,
        Chris Hyser
	<chris.hyser@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>,
        "mkoutny@suse.com" <mkoutny@suse.com>,
        Dhaval Giani <Dhaval.Giani@amd.com>,
        "cgroups@vger.kernel.org"
	<cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Thread-Topic: [PATCH v3 2/2] sched/numa: Add tracepoint that tracks the
 skipping of numa balancing due to cpuset memory pinning
Thread-Index: AQHbr80+uV+2NEya/km11I7Mcyg80bOxavCAgAAIi4CAAAHkgIAACoGA
Date: Wed, 23 Apr 2025 16:50:15 +0000
Message-ID: <720D1AD7-112F-462F-9ECF-A060670D62D4@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-3-libo.chen@oracle.com>
 <20250423113459.0e53be50@gandalf.local.home>
 <104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
 <20250423121219.15d5c2ec@gandalf.local.home>
In-Reply-To: <20250423121219.15d5c2ec@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR10MB5749:EE_|BLAPR10MB5188:EE_
x-ms-office365-filtering-correlation-id: d8c1030e-5c34-4081-0107-08dd8286ec1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmRwZmFiYUptWGhaVUNCWDdYNEtUQ1MvaGVReUtkQ3FYQjgwQmlySjEyUWMx?=
 =?utf-8?B?d2Z6Uy95ZEdGOVJwNTBNTjBhY3gxTnhkbjFWSC81OWROV29TRUM1ZGpKdTZo?=
 =?utf-8?B?RWtzbmN1VDlucmdIZ0hPby9BRVloQWFDK0pER2ZOdkE5T25GeTVaVzB1cjR3?=
 =?utf-8?B?R0ljT0FQWDhLZjY3ZElJUFZOR1FkejlKbmVvdDZjZlowbUpGVmdXazRNM05X?=
 =?utf-8?B?enRBVzNFdytTYldVUnJOVGU4NXRmRUxCMmVOOGFZc3pGMFhXOGF2bXNXM2ZX?=
 =?utf-8?B?OGlSRThXcUpENjhnNy80NlFmS1A2ZiszZEhKQlhBSTRQbEpaOVJ0SnpiOWdn?=
 =?utf-8?B?V1ltRTdzOVYxU0M5TnliVnhNOEs1RnFJakJ3VEtoZnIrZk93TE53eHo1eElS?=
 =?utf-8?B?RnNHeGhuTlU3UVFpRUYvSVFGWStuMEdhRHBzMGp5NmhtMDdkaHUrbmVXTmx4?=
 =?utf-8?B?SmZidmxKcEpPa2NFc1U0T2x2TTZIVzgzSFNSd1BnUGViTlc3VXVlV2poeGdm?=
 =?utf-8?B?aFY0eWVpWEk1enVnd2pMM2NEVGdPamJZa096U1RvUTJtS3A3MU9sd1ZXeUJ3?=
 =?utf-8?B?MzlIcUsycTF2NlhwUHdZY3RVK21YOXhiVU1PTk5GR3lJaWNIM3gyTlE4Zmgx?=
 =?utf-8?B?cnp3cEJVcnRBQW1IenYydFowc1hPQlEydG9naTg5R3k4cndZZ3JYODk3ZW5a?=
 =?utf-8?B?bUVRL1l1OE5YUThxejNZT0pzUHBtelVmcHFjWG5NRlc0ZWl3ZHN5MW1Gdyt1?=
 =?utf-8?B?Qnc1MHpCVlVYamNlL00xOE1lOThBb0tmSDM4QVdML0lVOEdsMkRZd1pIRGlq?=
 =?utf-8?B?dUpNbFB5Qm1Ja1pKRVdOckEvRWoxenREcm5tRGZHK2FySU9hK2o3MTFvUVQ4?=
 =?utf-8?B?eDJacTdIMnlOVUlRbGxBZE5GZXoyWjMxak41emRseGNXTFlmQW5yOHBhWDh6?=
 =?utf-8?B?eHNETDFWN0Z5Q0hPcUI2NXk2WkdHb01kejFySU4vWWVZMkkwTlFFNDVocHNR?=
 =?utf-8?B?NlF5cGpjcnlRQTRTQUtIRytoUUMwYjdtUGgxdFp1ZlZSODNwUHZjYnpGcGJj?=
 =?utf-8?B?aUFpVkpqTzgra016bGVuOFZ4WnZIYnlBSUdmaWJpZ2RVdVR6VWNXMlF0WHZK?=
 =?utf-8?B?bTFNeXUxNHM5QmZ2alRtMnhjVjhJQ2dsYnh2ckxaSWl4SmVoZ3QrdVdIRlRZ?=
 =?utf-8?B?eGM0UkxRdEJSOGdBZWRGWks2T2cxNENXYkNqWFg2alpKT3o4Wit0OXNGQ1lw?=
 =?utf-8?B?VjllV29CZlNOTDVSdHpucTZ4MWI0M1VGNG5vQ2xhQlpQcU5ZNHhqUy9FSGpD?=
 =?utf-8?B?U2Z3aXIrSlc1enUxbjlJQnFuVHdpeVVtQ2UyTTI0a1JxeHBlVE9LV1NaSEtt?=
 =?utf-8?B?MkxoR2hDcFdpTktGSlJmZzlubHRLb2VzYlFTOUZpcmRXSUNEMjlRMkgvNHdR?=
 =?utf-8?B?Nm5NNC9wN1NFZnBaU3Y5UUVZMnVMWFdDZjYybngvRnR5dFE4QVBNUVU0YjRt?=
 =?utf-8?B?S2toeldNMlZkK1ppMWxjKy9VenZtNjBzQzk1ak1Wb0Q0UCtveEZuVW9kMU5T?=
 =?utf-8?B?WXM1aGV0d0ZFWWhRdzJqL1JnU1d5dXVMMmdwU0FuckNwTDlXQmptTFZDOVNS?=
 =?utf-8?B?NGw1SjhqaFI3bHNCSDhrQ0NaM2xvZVVpa1NNQ29EMEpEY3NIa2Y1L3NmT0pj?=
 =?utf-8?B?Rkkyb0hYWHVOK1ZtNHV5bk90TnFmdHpXaDVMb0lYRFRIWWJYMUZYcWJ5RWtO?=
 =?utf-8?B?bldUb2FqV3cyR0c0MmpaVUhORlJKQVc3aEhJTFMzNGtZVDU3d2VuN1ViL0ZW?=
 =?utf-8?B?MjU5L2NRbGtURENUV0p4RVdYYTFhSCtjNWF4Wm5MV2YyS25PRG8rTjFkbFpi?=
 =?utf-8?B?MEcrZk5XR0VOUnRNQ3ZjM2JpYXA3M2FYcDd3Y1Joc2VTTzA3aTYrbXQ3R2xI?=
 =?utf-8?B?L1oxdHp1Q2MxWCtIZ1dwT0lkU2Mvd3Z2Qm9tQXc2YVNHOXJ5VTFsNHhwdjUw?=
 =?utf-8?B?a3djSWloNThRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TG84OU0rRkNKbnp1NTJjOURiTEh1VjVFQjgyUmwvY1UzdEdoKzBzVFlneHZD?=
 =?utf-8?B?NFZWMlJ4UndJZzlvT0x0RHc4d3NVOWZRY05udE02RXAyVlpReWlEdGxPYjNo?=
 =?utf-8?B?bXNFdXlodjR0UTQ1Tkc1b0JqRzNBTGFZMXJJcTZ5ZEx6eUk4TVdEMDl4b3Jz?=
 =?utf-8?B?WkZTMXdlUlMrNnZXVHNDTzhIMEphMFgxdTZEWHgyd1VOa2NoRDFkRm16UzU1?=
 =?utf-8?B?dWM0T3VMQXZKeUpKTEwrRXJtRmRPK2pHdFNVY0MxYVphOWJ0SGtmc002Smp3?=
 =?utf-8?B?VDQrMTZSRXRJL1AvUDZIdzAyeTU4a1M0YVBPd21DNTd1Y3o1MmNIUnVqRUk3?=
 =?utf-8?B?dFgySEhKaWY0YnJvWmNJVGh5Z2x3Uk40aFZRZm9nTThhb2xqQ3lzR21Sc0M4?=
 =?utf-8?B?L1FxeXdsN0JHOFJKUy9hVjlUalJLekQ1V3pnZit6S1FUYy9xVTZVOW1pOVZG?=
 =?utf-8?B?WnNvR3h5SnJia3BhN2hWTjhEOElqaU9zeHZoOU9abFNuOFJzOUZqNGl0cjlT?=
 =?utf-8?B?THhRV05TTEszZlBnTXprM3RQbEJlKzd0VWxWYWtVQndiOWR2bUFqZzFTc3hJ?=
 =?utf-8?B?VXVTa0Ntam1hT1hQSDVqRkNqRFB1ZXhlTzY4Vzc4RDVOSW9ZUWRxM2piM1ZF?=
 =?utf-8?B?ZmxWMDdRRDRmY0lxcVZkK3BEbHRNL01LWG9IcXdocjJOQXdwUDhpWkhIcHBm?=
 =?utf-8?B?K3lGYVBzaVhJMVFXd2dKYkZiUmFGRlYvbGE2M0lYU1lXWFlZRVQ5UzZScC8v?=
 =?utf-8?B?WFoxdExZSmlURzB2T1hOZTRtYXZ2c0NUMjloZ2FKMzNXSHlYUk1uQWZTVTRs?=
 =?utf-8?B?MTk2M0wvMXpCaTlpVGM4VXE1cmRmM3FGdEVaVllGdEZUS1Jlc1JFcC9UZkYy?=
 =?utf-8?B?WjlhTGFPbnVadGEzNzM5MWhUdklzRVluQlVKZ3JxT1JsMncxUHhSNTNndFZn?=
 =?utf-8?B?cUl6L3BHZVJoWURKeTdSN1lRUWhZWTc3eFpOSUtmb1EyZmw1QWl6a0U0ZFQ2?=
 =?utf-8?B?SmFlL2I5VUM5cTFId05qcDBkOHZMWmRDNVl3OGJnTTBDK2RXc0U5NFJaM3U3?=
 =?utf-8?B?UkIyd2NpNFo2WUlUZXBpNUN1cTUwREhGRUJzS29wU2VycDc0TDl2NjhzOWZQ?=
 =?utf-8?B?SUZvWnhLQW52OVR6Q3ozOG01NjFnRHFDOWtCTHZ6NGwrOU4xRzJjM1hJN3JJ?=
 =?utf-8?B?eEduRUVFaVdjc2REMERSOU1BNFd5NjVNRExPeGJiQjlVclMwOGVLd2EvWmNI?=
 =?utf-8?B?N1hGdFZLU2NocUhGbkxVWVBOdVc4elhWVXJBWE1wbENoQW83enRnOWZmRE9P?=
 =?utf-8?B?Z0tWVTVPOXI2aGh1Z2xrNTc4Lzg5L250NFY1T0xUUlVRb25FTktQSnIyMG5V?=
 =?utf-8?B?cE5DL3VWUXQzcmRIa3YyMFdGaG1Db2pPS0xya1k0M3o4eXVKb3haMDY2UXpm?=
 =?utf-8?B?dkJyNzU1d05CWkcrZ1d3OElJamUvN0R5c09tZlhsS1JZUHAwQzI0L3kzUGFm?=
 =?utf-8?B?Sm5halFyTFB5M25hV1VMRmRXNWlid0lqTzk2VHVJZHlRWjBMU1kzR3VkSTQ4?=
 =?utf-8?B?enBIR2crYkdVTk42eUQ0bTRyZjhPbmhMWC9Ld2xuNlNPdXNyM25tTy80NHNT?=
 =?utf-8?B?alYyMkk3MWhUOG9LRlFaTlJTYW9TMGN0VEErbkhIaDh6dkdNM09sZDM3bTN1?=
 =?utf-8?B?SGV3dUFMSmFFY1lzelVnOEhVZVlMVlA3VFlEMjRoUHNBK3c0bUJXcW1aZ2Vo?=
 =?utf-8?B?aXB1c3prQ0llS0ZMa005ZmkwaGxtQkIzYzZUd2tsM1l1WExUMWJQTnB4dy9y?=
 =?utf-8?B?Y1hzK3Uxb3NhSzZBcG54cFppMEhMcDlwbmxoSmJVQkdwZEhxeWJUSUdhQTV2?=
 =?utf-8?B?WkdJTHFZb0VZUUViL1pLTnlmQ2JzdDRHLzBpWW1maHgwZWxlTGhOeHBXZHJh?=
 =?utf-8?B?UkpvQW1FZVM1bTUvbnNKTzFoUC9FbkJSb1pOUis3RWwzS2dMMVBQOGhCcGdU?=
 =?utf-8?B?SVlOVDcwa2JtVVdNNzIrcGpSZWJlcndpWXh6clREMkRHb3FGWEFCVnFIejBI?=
 =?utf-8?B?MEYrUnFLOVR1OUNLSUZYbXFac1pmZlZlZGlrWmlZT1BML2hLVVV3eHNnUnlv?=
 =?utf-8?Q?w8Q0oZDRTBbBOIvMNu5W/XsGr?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EACEA285CD9D464988832B4C230A9894@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hT1QLwJzGa+Ui+7OkxPgmXjnkyJjYcFmuD31A02QIkAQsxNhbx63A5RrQgeHqRYA0BqOX5nb5LSAhRAd3Zvkuc42WJySLHbsWzUIxtEDQSCKyCsBWdChKcrKIb192MoE1UOQqw05Kb5d7boVaCzw44ADNGOB4amKxH0GZzOdayrSTy1ljUb5hNxeRj3phL9rPe4evhAZzpxTRUXiEMD/0Mu+4nQDblwXyBPvLxXzF+Qjqsvu4Pu1ioPtNpV+mEdViwvTFz5oYpNywRhV9AbpTttc5LWK2w5wzEuW2ttF/8xhBNHtavc7gkSR3wvRM6Z19PIg3tMrveKeop5cLu+t7QXusqOs18fjtg3Jt5d29u67J5mFi9OLRmj8pnI+LP9ymtEoF7qrUBz8VXui3SZL4B9uc7BvrGWDO5a9161Bi6844QRioTBq44OVLKd976tiIRmZDrUrBAqA2Z6ohvNH9nqfEfGyiPDRagO1VmXYflL+zIu7QKTU+CYYMcNILRHJyu5jQVJHQDNBSK98gbsC/Og3kCm+fzu0oN7nKPGNJnaCXQtMd8W8UwwS2xkVrHba4wr57vfRK89s7qxrtdJyNn0rliH/zIxAdm81JZVZOUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8c1030e-5c34-4081-0107-08dd8286ec1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 16:50:15.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aG0W7i8QMWa67/iIuynvVm6hsprvhxuFGT1n7FDqd2OjJXm3p8OmKjqBWCg+RwyD6X3FicDWvP+NxBc9ZXCxDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_09,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDExOCBTYWx0ZWRfX7XrBpRUDKrAZ LB4Am2jkp5wv26gS7Dbzj6VHjVsr0m9A39sJNakryeymVr1o6xSqPPqXbKlMxeW3tUmFYi1H4Qb ayINvBmYPxu+UnLBaYBsFfxKeSZykYDCMRf24TtTXwAPviJzce4gmO/2B+Y7t1ASvZEsOkWq8tZ
 Vifq55hIX4nvfT768f0kpjkJlXIrOye9V5UKjLJ3MMqxs5C2S/6GuGwgDRJ5dW430Q7bBX6Oub4 MmifV0DEaKIUkvSuzVK2f7hOrQe0b7sY3ytyc9Y3oC/V+NzOFgO1GA1fyqFf+qoD+SggrQEmPnX GjJHNJ9x2VwJVw8Afq7QQMocHC3ng62RvbKar+ORnA5nmc+X7p039BE5lRCxlgfEHMh9sel3r6Z muur/pUc
X-Proofpoint-GUID: ISyBr7tR48bNkzRwxtTrB9ax8LjeQu0m
X-Proofpoint-ORIG-GUID: ISyBr7tR48bNkzRwxtTrB9ax8LjeQu0m

DQoNCj4gT24gQXByIDIzLCAyMDI1LCBhdCA5OjEy4oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMjMgQXByIDIwMjUgMTY6MDU6
NDQgKzAwMDANCj4gTGlibyBDaGVuIDxsaWJvLmNoZW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0K
Pj4gQWxzbyB3b25kZXJpbmcgaWYgd2UgY2FuIGZhaWwgdGhlIGJ1aWxkIGluIHRoaXMgc2NlbmFy
aW8gc28gaXQgd2lsbCBiZSBlYXNpZXIgdG8NCj4+IGNhdGNoIHRoaXMgYnVnIGF0IHRoZSBidWls
ZCB0aW1lLg0KPiANCj4gcmV0dXJuIC1FUE9OWVMgOy0pDQo+IA0KPiBJIHdpc2guIEl0J3MgaGFy
ZCBlbm91Z2ggdG8gY2F0Y2ggdGhpcyBhdCBydW50aW1lLg0KPiANCg0KQ29ycmVjdCBtZSBpZiBJ
J20gd3JvbmcgYnV0IGNhbiB5b3UgZGlzYWxsb3cgYW55IHBhc3NlZC1pbiBwb2ludGVycyB0byBi
ZQ0KZGVyZWZlcmVuY2VkIHdoZW4gVFBfcHJpbnRrKCkgaXMgZXhlY3V0ZWQ/IFRoaXMgaXMgc29t
ZXRoaW5nIHlvdSBjYW4gY2hlY2sNCmF0IHRoZSBidWlsZCB0aW1lLCByaWdodD8NCg0KTGlibw0K
DQo+IC0tIFN0ZXZlDQoNCg==

