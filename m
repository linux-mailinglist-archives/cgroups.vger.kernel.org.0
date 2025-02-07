Return-Path: <cgroups+bounces-6457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53619A2C343
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 14:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E993A90A4
	for <lists+cgroups@lfdr.de>; Fri,  7 Feb 2025 13:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C711E1023;
	Fri,  7 Feb 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ABV4aC9P"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2381E1A23
	for <cgroups@vger.kernel.org>; Fri,  7 Feb 2025 13:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738933623; cv=fail; b=YMM6Bhr2/QPG0wNqc9tBqvJYxiU6IslSRspHs9JKgMhXlvV1yHlbrav+HPTsNu3NY3f0vY6P1eWhl6YrdR/eRGeAw8EIiMlY1JLBo/GgPjtch4yQzO3sJiUVlKskhnT89SampUWE7O1RVciyJUPgxLrr7jEVseMf9rcl4zz3LII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738933623; c=relaxed/simple;
	bh=tp0NUXB2OQb/+FlC7+T5RlxK6LsuCtFggIHMM7dI70Q=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=c1z+hqrdx0AheBb6VPlFh8QsElqQY1lR6GUXP+OBsZo41Y5zwqiK5MfDVym/Fx5nIiynxiFe6OXWf2gN/+Jf72ixe2WaTSkkj4bTX5P+kTBzGBQ8U9HhKPpvQmvfCD2hns947NXzMctW1+M9iUK5WrfkViQeTK9hzlW0gWGyOaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ABV4aC9P; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517187vB021979;
	Fri, 7 Feb 2025 13:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tp0NUX
	B2OQb/+FlC7+T5RlxK6LsuCtFggIHMM7dI70Q=; b=ABV4aC9Pke5/0v8eS/FHTq
	6xQqXzyZOvgaRdUsCRcyf9NSKgk7j/NV3GTOFFI6S5bCjkMIs5AXY4aPqvROoFWJ
	Yg2AwAgGi32sL4xVpkWK7yek8ZY7p8rMCU1XFvSJvapVvQhChBybVORrGfdPJucy
	r4YPO7JwI7jpXL1Ur1IVAVDOYI3Jnys/j+E9f/lv6RB3CLjNvi/+hvXZEN0NAOAC
	877xLJpFJhqEOSUnd21MuMgzQRMhC90+GS+VnGoGr1+hJcVfBbMuGYVBS/wHcbpl
	lLDMJkxq1llcERCh32SXE2vF+N5nUYtf54BJ+TUmxf28yloKs7OwDDG2VuvrWbdw
	==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n889b0tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 13:06:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UFbSvv9SxHYHfiH8yIh8A6mwWk4cCFjrgycsVi30H4W/d6XJVpXjSAeSoGkdqROeD/8n7GKgCCmGGXrM8JQjsygVw3bUquVevqKk6XikNeprtJf2pxAIEsov4wU6xXf/39QGrNIIYYrONbX8t+veLx/x6mSvgo2biGv3/JHmHmYuWUAW1m6UxaPxfu84y+ZYu/Jq80UnxWuUBXFowdEfkrdHLBBxq3I5rDwY6EP2UspQdC1UAbWvmNG6S2Xt/Xs0B1uvw2CPTHLydUe40h6VJi5v4DE5VbQ2+epvvKB99XSG3OqeZM7TxH1LuIoaPaowqHKJoik/D00mRroLo+Z/Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp0NUXB2OQb/+FlC7+T5RlxK6LsuCtFggIHMM7dI70Q=;
 b=F03AcRC0aVtoKbiwRdgnl/NKVoJwFkMeSzjkejuTRCtQcrqPmYo2vm7NHhxdAkgXtY4QAJuPvVgs87J3VMJQ6nFSSIjiLfSDYrMSuW5HEETRJN1JwZ5FvhAWETuIJDRMILoZJiD09RMlbOcYQbarY5zd382lWV9A7CxTbyXm/x63mBV/r4RZFiPvlCLri6dOBac3eV6FqApxbJnXdXbRZurGgWXvBYFoNFwIyg0XrWPRlE4m5goeB0uBxOIB1dzadSkqMJFEP86zaoy2KDIscOv111rBBFLh2B0sE+Eh7wvQJb1JwUW7sGTIZo4Am8Q5ZdChVyLZmyu+bgQIhFkVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from CH3PR15MB6047.namprd15.prod.outlook.com (2603:10b6:610:162::5)
 by SA0PR15MB3790.namprd15.prod.outlook.com (2603:10b6:806:86::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Fri, 7 Feb
 2025 13:06:51 +0000
Received: from CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06]) by CH3PR15MB6047.namprd15.prod.outlook.com
 ([fe80::5f69:515f:3a6:4f06%6]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:06:51 +0000
From: Muhammad Adeel <Muhammad.Adeel@ibm.com>
To: =?utf-8?B?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>
CC: "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "tj@kernel.org"
	<tj@kernel.org>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        Axel Busch
	<Axel.Busch@ibm.com>, Boris Burkov <boris@bur.io>
Thread-Topic: [EXTERNAL] Re: Remove steal time from usage_usec
Thread-Index: Adt5SlqCaMaEauuyQhSxLrDnYXxdgQADqxCAAAG2TmA=
Date: Fri, 7 Feb 2025 13:06:51 +0000
Message-ID:
 <CH3PR15MB604772B824C2236FAEB35AA980F12@CH3PR15MB6047.namprd15.prod.outlook.com>
References:
 <CH3PR15MB6047C372317D5EC6D898D7AE80F12@CH3PR15MB6047.namprd15.prod.outlook.com>
 <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
In-Reply-To: <al3vrgjeb6uct3oaao5gwzy6aksjvqszirafg2sjyi2c53luyj@pijf4ctzyrft>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR15MB6047:EE_|SA0PR15MB3790:EE_
x-ms-office365-filtering-correlation-id: 9e653ac3-7e2f-447f-f27d-08dd477849cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eHR3dGVmZ01YVkVKc2Q0cnhtOTh4M1Z2aGNEUHZWYWg5VWh6SGFtQWMrN3d3?=
 =?utf-8?B?UkY3a3J3ZVZ0YzdEOVB0UmtSc2pHb2RobmVJTG5kUXNrM1VaencrcytNUzZW?=
 =?utf-8?B?Vzl4clREenBoTFJ5M0xQdXowZEphWWp3c3hYYzEzZmxkS0loQU1xMnpqSmwr?=
 =?utf-8?B?NEc4Q2p3dGZIR0hNajRnYjUySDZoa09ielBTU2RrL0hDRFZjc1MwS2NOa0dB?=
 =?utf-8?B?NTl4OVYydU9QZTFqZDBJTkZ0NXRLekRnVVVkSHFoVUxpb0ZzcE4rRVBuM3JN?=
 =?utf-8?B?cXlGOUc0UEgxU29odjQ2STN5a0ZSdkx0S29DRjRBdWRJdmJJS3VFT2MzN254?=
 =?utf-8?B?S2JhQnVUaDJ2QUppSk05UzNxbXlLUFNwYU50aFdsdHRkbm1ScnRKcnBHRnlj?=
 =?utf-8?B?QUhqNzU5VGQzZkxvODJCZ2ZYR2JCRzBXM2xvYUw3d3Q1OHZ2U1lROEF4akQ3?=
 =?utf-8?B?SXZmdXJ0YlhLei9uUkYyUXZjNGpTM0ZnUFRRTlBGSGM3SXZOdG50VGlRcGJr?=
 =?utf-8?B?TXRLUzREZHp1dVltOXZ5dWFHeU0vWWNWYmw1bkdhdGFFL05iRzJBUUZsNUN3?=
 =?utf-8?B?R0lodmVtZUJ1bDFPMXJ3Tnp4dUIvZWc3SXZ4ZldWR0VpRFFIVXo5WVJ4emgz?=
 =?utf-8?B?cU1HMmZMZnFaRFpDMHVKUC9NTkV4SXZnbUd4REhIUDMveHZPMk9pRzBvSjM2?=
 =?utf-8?B?YmtJckZaeHN5WWMvL2NoSGNyVmoyR21yc3Rwd3BjdDVlYVlMa0gzN2RTS0pr?=
 =?utf-8?B?aU16L1dGeDh6VDhpWVhjWSt0Rjc3Q0RvU1B6QUlwMXFyc1JQMHEreGxEOGJC?=
 =?utf-8?B?MkVLaEdPb1RIeDE3dWhHNWZFbW53ZzM5QUtRTldaK1VNTGFqajkwQnRJdmp3?=
 =?utf-8?B?SU5Ja0cxaTY3R3NpdzNURHRHWCtTWVBMNzh5eTc5SGpPbDIxY08rOWhyMTNE?=
 =?utf-8?B?M1drbnR3Q21aWTNSWnZnV3hzbUtwVEdiV0daUDVXMjRScG9VeDRCOUE3dmls?=
 =?utf-8?B?bi9GWGxNNEhOU280V1A2Rjg1a0N5dnNydTQ3Y2lWNFdKblhkb0NrSVhxR3Y3?=
 =?utf-8?B?VVVRQ3M0VzBjaDRHNlBYcEdGZXdrTm1GenhFZmlKQ2ZzUWFtcE1LSHF2SkFE?=
 =?utf-8?B?dzFrUDMxYUYxUGVLNDJ4cmdIWUloM1NiUkNYTk1vbTJ5a0dhemNoZjN2S1Zo?=
 =?utf-8?B?ZStON2xxUDQrQzZrbVV6OEJxc0dwN2tCcjdaOS9lMmNUZWVRSVJSNnAwb2R4?=
 =?utf-8?B?OVRKWS9hVlAxRUhjN1ZLOENuUGhWNzJSSlhmK0hvaEZwOUNIdmxBOW5YRS9D?=
 =?utf-8?B?b25HRHpseFBQUmRuUW16RDRGVE1zWndDQS9LSDlrWDlENjcxallOYVJFM0FM?=
 =?utf-8?B?VlN3VEMwNDdGeW5zNHc5WWttaHZjWTNVR2l1NjRpVTZtSmh2c2VZcmdtMVh1?=
 =?utf-8?B?aG5LdUFMZ3F1eUJ0cUJrTmgzcUF3dGtIcFkxTVdqUFF2dWpNT0Y3eXlIRmNM?=
 =?utf-8?B?V0Q5RnU0YnlsQVBsUEI2ZkR0a2R0am9NYlFqOVQ0Wm5QOWJpbjAxV2REUk9H?=
 =?utf-8?B?VVdveTZDMVd6ZExCbXRWaGhyN1lydGtiaXJ4MWtkYXFVZndsU3NibWdQZUk4?=
 =?utf-8?B?M1poMHp4WE9Oaks5QUExM0RIaXo4Q3JVMzB6a1VBNnl2U3ZKMWJtdTB5eEVi?=
 =?utf-8?B?cmtkaTBsQ0kwb3gyVlNxdlFDOVZDNFhMa3M3di9OL1B4YWtXTlV0bDZscCt5?=
 =?utf-8?B?b2I3a1RYeTRJUW55T3R5aVhTQjBzdlRTZUVIMGFOV24yV29OREgxamIvZ3lz?=
 =?utf-8?B?WFBiaXpWbk9SM3pJcGlUZkNQWDNBRFNFVW5Wc1NlZHJ3UFRlcmdBL0dlK3VP?=
 =?utf-8?B?ZjU2Q3dhb2xlZ2dMRmNNSVZnVmx6dExMTWw4d1dkRGZWTjRBcHRhRmV6RXI2?=
 =?utf-8?Q?0FZnrUsUSslexJksmSdUiVEIWTFpKV6B?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR15MB6047.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0RSUzBhVndCcmVXaVpzeG5GM0crZjA2TEdXL1F5bDRRS3pnQ252ZFhEMlRT?=
 =?utf-8?B?MXZEcGIwN3lQK3NkQ3ZkNytuMi96ZW45L1ZsaUtlMklvODBYL3B0WWhWRExO?=
 =?utf-8?B?TnlFRHQxSEhkVEI0bkxGRG9LcllHdjV2Y2xGTjhLOXZXeWlwYzJyYWFycTAz?=
 =?utf-8?B?WDM3MTIySUtoZkFrUCt4QkpCMlRGaWZRZVpFekJXaUloUzBwUitRTmIvSjMr?=
 =?utf-8?B?dnhlYjFYa2V4NjhlazVYZmp3Q1FCQ2hvbEpmU3NXR29YY3daWWc0N29Ra09q?=
 =?utf-8?B?Y1ovaWl6VGJTQjhZcStYWmU2bnB4VVpyMzdYME1ucStIRlZRR2NEYTNqbTVz?=
 =?utf-8?B?MSs5UlRnUUNqT3dUSElUcWZGZSsyQmZPOTA1N2thV2E3VjlYTSswY1JKUTVs?=
 =?utf-8?B?ekVPQStNSDY4UlMzQloxUmpRZjJCbFBXMGs3UjliUWFaVUVzYVgycXNGK2k1?=
 =?utf-8?B?U1Y1bU1nUXdkRjhJMHpkMk9EMG9JTG56TlIvanVFZ2lqS1BNc0hhckVWazRj?=
 =?utf-8?B?bEkrdDJJWGhHOTRZSmNTQ1R6OXhqc0N6c05RRUZUV3kwT3lJaXRzUmU2aERr?=
 =?utf-8?B?UytuU1VDbkMzdG1RT2tkVFcrUXdyeGQvMHhsQzREWHErWWd4SFY3eXhuejRr?=
 =?utf-8?B?WGo5eHhRTXdBSTVZVHdTVmZ5NmQvdEdwRjQwdWF1YkN1S3hyMlRKNDQ2NWcx?=
 =?utf-8?B?NnljenBTR0dYenYyRVdrckkzTzFEdGxoNmVtVDRBWkxNOWI4ckw3bi9YT2pG?=
 =?utf-8?B?T0Vxc1o3SldhWTdreGV4dWF5dFUzTFVHQldVdDcxM1VUTE5uK3RESDFkVi9w?=
 =?utf-8?B?VkR6aG1yUHpTK25zMmo1L3BMVm1sNHh4OW5LeTFPSWVaT29qdWljZ0RTUzVT?=
 =?utf-8?B?L0ZLZXdsR0VJTzAzUmdzZlF4RnFwRzZSaXhPZXpOTkdTZnhlL0JONHFBT214?=
 =?utf-8?B?Rms3R2xTQ0Rib05UTGkwQ0tET2dnd2hjTGhLWktJcE93ZXJrM1cvQm42MXNY?=
 =?utf-8?B?UFR5aHFSSUpyaWxGS3RVY1loUDhqMzNGM3EvcHl5UHAxUXk0cFM2ZndlQnYz?=
 =?utf-8?B?MXlCVG10ZUR6c2FWMUgxME9mUnorSitvNjAxN2tiOHI3VGVmN3B6bmF6bzJy?=
 =?utf-8?B?K0VTR1hlK2p0U09DbWV1MnJLTjIzZFJpdStnUFJNbFRoc3RGK1NmSGMrUWdR?=
 =?utf-8?B?bUU0RE43STdYVDBQdHlMY1BlclJ6OXRIK2h2Ty84N3ZMU3BCenNjWWEzMTR2?=
 =?utf-8?B?ZHo0SGxwMmF4ZHhhMmYzNFY2WU9DWmNBaSs4Y21kTlQ4SXhJQjZjUS85RVo0?=
 =?utf-8?B?djBKMStKTVp6NGdIZ2xhcmN4ZDlvYURGZklzYmlqeGMySEMxcDNLUnduSUND?=
 =?utf-8?B?NXhpc1FNVzdaQ3NNRlpOVVlzSXNocGZpa2hlS1NSU3JJZXo4MUdKNFFiYVN6?=
 =?utf-8?B?ZnVaRVNVTTM3bHVvSm9sVXZlcTFpbnhyblRZd2xYVzQ3dUI5VExHWU9oNjUz?=
 =?utf-8?B?WFZFM1BKRUJnUmpWMjk3cVZ0Q0t6b2pqWVZFVzY1N2lFcXFwSnk2T2JXQmpn?=
 =?utf-8?B?WnY4SzN0K09uMFZqQWhVd3g2RDVEZzFNMnlCMmVCVVVGRUVnZVdjY01WS0NM?=
 =?utf-8?B?eXhTSHlsYXhkcTZtWUpWMUtxRjNta21CRWg2TzVPQStwc09ienZUdzZjbTZO?=
 =?utf-8?B?Y3RjOXhWbXRsWjdaVDJNZ1hLdzU4blBwNitJNjVaUWhPNDI1Q3dKZDVVU1M1?=
 =?utf-8?B?a0V4Q1VHbGpPRWxQc1I5bmdzQkpWa1hqWHVFaXJDT0pXWjB5NEU4R25LZ25Y?=
 =?utf-8?B?cnppbjNwYzZIeHJUbDVBUExyZGNDWnZud0txRlRqTmRPTW1FcHp5NlVubHRa?=
 =?utf-8?B?MisyaGh1UTNhS3hGKzhyUi84bjVEM01jZWRLbVR6aW5zQyt3aUtYY2NyZW5I?=
 =?utf-8?B?VGg5R0thZXhxZzdzUUZGZ05weW1vUmcvaytjb0txbWJUeU0yM0UvRXZWYk5l?=
 =?utf-8?B?U0RiWnZJT3ZVSGtRS280enUrcUhVR2M4YjIvby91MG1GVU5ocnpHYnl5S2dS?=
 =?utf-8?B?SWR5ZTFMS1d6RThwVjd0Z1J5ZmZhNStlZmorVDZmUklETmNlVzZvbjF4NXI0?=
 =?utf-8?B?MitQQkZwaE4xMHViUFNmTXczTGoyTmxBdnJuUkNOSW1BaEdBcUpEUXNzeTlJ?=
 =?utf-8?Q?hXmyQ8ejBdGjbXHraggon69WBeKICN+9EQuEWH8FLqyA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR15MB6047.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e653ac3-7e2f-447f-f27d-08dd477849cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 13:06:51.6188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jAD014rr5YFUL6yORdB1JIwJARYJEhmUD69X5ORK9ZgdEIpKyFZuE2sNwC9ZA7aN/cNKymCwm1kg4jmI5LSdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3790
X-Proofpoint-GUID: KUtkbpn3MK-9hJ8nGAx_fmK438J_0NuD
X-Proofpoint-ORIG-GUID: KUtkbpn3MK-9hJ8nGAx_fmK438J_0NuD
Subject: RE: Remove steal time from usage_usec
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1011 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070101

SGkgTWljaGFsLA0KDQpUaGFua3MuIFBsZWFzZSBmaW5kIGJlbG93IHRoZSByZXZpc2VkIHZlcnNp
b24gb2YgdGhlIHBhdGNoLiBJZiB0aGVyZSBhcmUgc3RpbGwgcHJvYmxlbXMgd2l0aCBmb3JtYXR0
aW5nLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoNClRoZSBDUFUgdXNhZ2UgdGltZSBpcyB0aGUgdGlt
ZSB3aGVuIHVzZXIsIHN5c3RlbSBvciBib3RoIGFyZSB1c2luZyB0aGUgQ1BVLiANClN0ZWFsIHRp
bWUgaXMgdGhlIHRpbWUgd2hlbiBDUFUgaXMgd2FpdGluZyB0byBiZSBydW4gYnkgdGhlIEh5cGVy
dmlzb3IuIEl0IHNob3VsZCBub3QgYmUNCmFkZGVkIHRvIHRoZSBDUFUgdXNhZ2UgdGltZSwgaGVu
Y2UgcmVtb3ZpbmcgaXQgZnJvbSB0aGUgdXNhZ2VfdXNlYyBlbnRyeS4gDQoNCkZpeGVzOiA5MzZm
MmE3MGYyMDc3ICgiY2dyb3VwOiBhZGQgY3B1LnN0YXQgZmlsZSB0byByb290IGNncm91cCIpDQpB
Y2tlZC1ieTogQXhlbCBCdXNjaCA8YXhlbC5idXNjaEBpYm0uY29tPg0KU2lnbmVkLW9mZi1ieTog
TXVoYW1tYWQgQWRlZWwgPG11aGFtbWFkLmFkZWVsQGlibS5jb20+DQotLS0NCiBrZXJuZWwvY2dy
b3VwL3JzdGF0LmMgfCAxIC0NCiAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KDQpkaWZm
IC0tZ2l0IGEva2VybmVsL2Nncm91cC9yc3RhdC5jIGIva2VybmVsL2Nncm91cC9yc3RhdC5jDQpp
bmRleCA1ODc3OTc0ZWNlOTIuLmFhYzkxNDY2Mjc5ZiAxMDA2NDQNCi0tLSBhL2tlcm5lbC9jZ3Jv
dXAvcnN0YXQuYw0KKysrIGIva2VybmVsL2Nncm91cC9yc3RhdC5jDQpAQCAtNTkwLDcgKzU5MCw2
IEBAIHN0YXRpYyB2b2lkIHJvb3RfY2dyb3VwX2NwdXRpbWUoc3RydWN0IGNncm91cF9iYXNlX3N0
YXQgKmJzdGF0KQ0KDQogICAgICAgICAgICAgICAgY3B1dGltZS0+c3VtX2V4ZWNfcnVudGltZSAr
PSB1c2VyOw0KICAgICAgICAgICAgICAgIGNwdXRpbWUtPnN1bV9leGVjX3J1bnRpbWUgKz0gc3lz
Ow0KLSAgICAgICAgICAgICAgIGNwdXRpbWUtPnN1bV9leGVjX3J1bnRpbWUgKz0gY3B1c3RhdFtD
UFVUSU1FX1NURUFMXTsNCg0KICNpZmRlZiBDT05GSUdfU0NIRURfQ09SRQ0KICAgICAgICAgICAg
ICAgIGJzdGF0LT5mb3JjZWlkbGVfc3VtICs9IGNwdXN0YXRbQ1BVVElNRV9GT1JDRUlETEVdOw0K
LS0NCg0KUmVnYXJkcywNCk11aGFtbWFkDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogTWljaGFsIEtvdXRuw70gPG1rb3V0bnlAc3VzZS5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgNyBGZWJydWFyeSAyMDI1IDEzOjA5DQo+IFRvOiBNdWhhbW1hZCBBZGVlbCA8TXVoYW1tYWQu
QWRlZWxAaWJtLmNvbT4NCj4gQ2M6IGNncm91cHNAdmdlci5rZXJuZWwub3JnOyB0akBrZXJuZWwu
b3JnOyBoYW5uZXNAY21weGNoZy5vcmc7IEF4ZWwgQnVzY2gNCj4gPEF4ZWwuQnVzY2hAaWJtLmNv
bT47IEJvcmlzIEJ1cmtvdiA8Ym9yaXNAYnVyLmlvPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJl
OiBSZW1vdmUgc3RlYWwgdGltZSBmcm9tIHVzYWdlX3VzZWMNCj4gDQo+IEhpIE11aGFtbWFkLg0K
PiANCj4gT24gRnJpLCBGZWIgMDcsIDIwMjUgYXQgMTA6MjM6NDFBTSArMDAwMCwgTXVoYW1tYWQg
QWRlZWwNCj4gPE11aGFtbWFkLkFkZWVsQGlibS5jb20+IHdyb3RlOg0KPiA+IFRoZSBDUFUgdXNh
Z2UgdGltZSBpcyB0aGUgdGltZSB3aGVuIHVzZXIsIHN5c3RlbSBvciBib3RoIGFyZSB1c2luZyB0
aGUgQ1BVLg0KPiA+IFN0ZWFsIHRpbWUgaXMgdGhlIHRpbWUgd2hlbiBDUFUgaXMgd2FpdGluZyB0
byBiZSBydW4gYnkgdGhlDQo+ID4gSHlwZXJ2aXNvci4gSXQgc2hvdWxkIG5vdCBiZSBhZGRlZCB0
byB0aGUgQ1BVIHVzYWdlIHRpbWUsIGhlbmNlIHJlbW92aW5nIGl0DQo+IGZyb20gdGhlIHVzYWdl
X3VzZWMgZW50cnkuDQo+IA0KPiBJdCBzb3VuZHMgbGlrZSBpbmNsdXNpb24gb2YgdGhlIHN0ZWFs
IHRpbWUgaW4gdGhlIG9yaWdpbmFsIGNvbW1pdCB3YXMgcmF0aGVyDQo+IGFjY2lkZW50YWwgKCtD
YzogQm9yaXMpLCBzbyB0aGlzIHNvdW5kcyBhIHJlYXNvbmFibGUgY2hhbmdlLg0KPiBDb3VsZCB5
b3UgYWxzbyBwbGVhc2UgYWRkDQo+IEZpeGVzOiA5MzZmMmE3MGYyMDc3ICgiY2dyb3VwOiBhZGQg
Y3B1LnN0YXQgZmlsZSB0byByb290IGNncm91cCIpDQo+IA0KPiANCj4gPiBBY2tlZC1ieTogQXhl
bCBCdXNjaCA8YXhlbC5idXNjaEAuaWJtLmNvbT4NCj4gKHRoaXMgZG9lc24ndCBsb29rIHZhbGlk
IGRvbWFpbikNCj4gDQo+IFRoZSBtYWlsIGRvZXNuJ3QgaGF2ZSBwcm9wZXIgcGF0Y2ggc3ViamVj
dCBsaW5lLCBJJ2Qgc3VnZ2VzdCB0aGUgdGlwcyBmcm9tDQo+IERvY3VtZW50YXRpb24vcHJvY2Vz
cy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0IGFib3V0IHBhdGNoIGZvcm1hdHRpbmcuDQo+IA0KPiBU
aGFua3MsDQo+IE1pY2hhbA0K

