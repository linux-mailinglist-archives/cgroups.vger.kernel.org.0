Return-Path: <cgroups+bounces-7758-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E78A997C7
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 20:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5186B3AD4E1
	for <lists+cgroups@lfdr.de>; Wed, 23 Apr 2025 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454028D82D;
	Wed, 23 Apr 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bacZrwAD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oj3JKxi5"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE492288C9A;
	Wed, 23 Apr 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432595; cv=fail; b=Zp8nga9SkJapOIUSflwla8xf4Z3+bcpgLA0v+LnS7yZZB4+xxI9mlW477cAYOMMQJXHNxRC+0NrtoXSq5iGI2wY2WKZFnYEbph7Xi2phclc2YvyN6yDVzFuBFgqCbCmtcETjseeM4hNkFVI1kldyUywUkfOYofRDBwhT4MMj7o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432595; c=relaxed/simple;
	bh=FkrRxRX5VudEdRag5iYlxk1Te2afIIkfwUjpXxA+jSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J4ktKgmJF98RPCFzo7GqIzodRGRvlfNk3gDZV1qKCU3yvR0Esp5XJFpLMGTVNZkwflwREyXCbAYFnRvMO3xruZ+I3kG+LUpjhWjwGjFMgJi3bX0flJ2RmopEM3WG6JfvhWr2pm8UzU1ON+B7Y6qa9vqA9lahSXAmP0YQO0hLVZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bacZrwAD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oj3JKxi5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGtn7H020011;
	Wed, 23 Apr 2025 18:22:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FkrRxRX5VudEdRag5iYlxk1Te2afIIkfwUjpXxA+jSo=; b=
	bacZrwAD1DXQ7xrBCaiDJCONiLE6jN2d1Pb7DYWf+5zWdvGqZt4ttWPVzVhajDab
	WWKyi3lCBLCt+kXEwyBmP4fgnJVtC7FkCxHxxQOkgrilUa4oBr3PhgOFNIxht1do
	mQhq5V7UyLlWQdTiXWnSuzW5aIXp7viHokoFoAvblYQEDL0XwAulevjQn7Luy40L
	PqHNjvFk4NVaS1qrBgboj5hEo8n/M/vOsi8obgwknKQGzjBSDi+jiXbyk59CcyoK
	hRB/aHffONIDQhAIU0o0r/dZDS6LIBDGjBs2etl+9nttCYZgvQUN2jj+UzJpW1GE
	wqiIS5N4UXL9IN7IHX2hrw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhdhwp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:22:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NHaQ5V025290;
	Wed, 23 Apr 2025 18:22:57 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbr14x0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:22:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjA6R/E1FbGzbWL6tndRUeSuZXsUPihaXyT2LPySpLDS4x22Fzce9nt6qJ8q7v8r6ksSdJmFT/w1l3xpkhrwrIf8mp+xuSuSEQs0WDPGp2RFW9R5/D6/ZInrXSd6/pDt517wbWcil8Ui+o4SRPbUrMXbbbeTgEihYrFh7UlK2xEGNs3nu/L3zh/pghnEhs+YQJ8EvSUnQhYkPyfgPRQc33IgE3jFbnsB8w4XEFK53ThNweUxBN55YerlCCqZ929SwlCrIQGp9zRmr8YGa0ZmHlpSoUrZhTuk1smV+slXLFSVzDfe0FxKSDsj5V0uxQK39M5plIMTAA/eY9DMJ+samA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkrRxRX5VudEdRag5iYlxk1Te2afIIkfwUjpXxA+jSo=;
 b=tEei41k70hUasW3JGUDVuNoIkFz/QYC57diceFKlQi7ShCnF2k6L+kYpIggiE0VGkowas17rESwdM8b9Tihy8uu7o5NwoeIatPlg7OEz6YTJEovk6uhSJUnxoyQ15HFdoTAaYZg52LlFfQ9Dvzn+uMEfFULgHQ6kQP9YDy1CrxOamg1aIwxQQOlI6DjfcW//PhFBwq0M8brh9MZeTCz5xf4ZNlrmOF2lLYqCMrChMjEZqudWf7kQrAGLXEVaZ7CqSlf5aKDdl1xleXfOoO6VWDheM7+NhGCwutw7J1txTJfFQcVpNGafdVVMb0DbejJE89fwAND+h5P/mgm5tx3RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkrRxRX5VudEdRag5iYlxk1Te2afIIkfwUjpXxA+jSo=;
 b=oj3JKxi5QD4K7bleQkKg61iOJyuYgxvxs+Ak6FKYCsUoq9oyU/fJy0x7Z9kMQN5sAbwiQef3JA9LA/3TMNQ271g+y1RRHSOMto+fp9Lg/a4zHF47M611pOw4P2QyvFcMHQi4snpG0YygtozQmNgu5KSFTD7RJ2Ft6UhS1sEC18Q=
Received: from MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12)
 by PH0PR10MB4616.namprd10.prod.outlook.com (2603:10b6:510:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Wed, 23 Apr
 2025 18:22:54 +0000
Received: from MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454]) by MW4PR10MB5749.namprd10.prod.outlook.com
 ([fe80::9a04:a919:657a:7454%3]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 18:22:54 +0000
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
Thread-Index:
 AQHbr80+uV+2NEya/km11I7Mcyg80bOxavCAgAAIi4CAAAHkgIAACoGAgAAB+YCAABfsAA==
Date: Wed, 23 Apr 2025 18:22:54 +0000
Message-ID: <8C830352-11B1-4D7C-84C4-F5D5F7008F63@oracle.com>
References: <20250417191543.1781862-1-libo.chen@oracle.com>
 <20250417191543.1781862-3-libo.chen@oracle.com>
 <20250423113459.0e53be50@gandalf.local.home>
 <104BC9F8-AECA-470D-9A9D-C4AFA3D4184C@oracle.com>
 <20250423121219.15d5c2ec@gandalf.local.home>
 <720D1AD7-112F-462F-9ECF-A060670D62D4@oracle.com>
 <20250423125659.3585b540@gandalf.local.home>
In-Reply-To: <20250423125659.3585b540@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR10MB5749:EE_|PH0PR10MB4616:EE_
x-ms-office365-filtering-correlation-id: a04b7cd5-993d-4931-c20a-08dd8293dd56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXArTmNXNUZpM2h2ZTZnOFYzaU1JeW1zUDJiY2xac2pDdWJCUVNvNk5FcFg2?=
 =?utf-8?B?UTdhWjdXWjJLRVZnOVdvbWlFVEh3TVo4UElZdFJLeWJSd3BLbTI4U2dESC9Y?=
 =?utf-8?B?K1NOM21EcjNYSXZPSFVwaVU1RWhYSWRRc0lHbWpSL3lrS2w1STlPT1FFK3U0?=
 =?utf-8?B?K2lHekJwQlM2NDNrSEtmcmhPMkI1a0NvZUtTSEdUZmorTWpUTTcwUUtWSWwx?=
 =?utf-8?B?bjhrYVArajNaNWpFM0x2Y1NNdDRlZVM3NjBsdjVOK1JyR2FBaDgwQUJmOTB5?=
 =?utf-8?B?UjgrMnZJazRFRUZXc29ZSWZoS0tUd3EvaVd1cEhyK3RPNzRIOVNWMTJzRG9U?=
 =?utf-8?B?c3I0MmtpTHk3ekNjUHp4TEM4bkIxNFpZZGJWV1pSVVY4cjFsYVljQ1JTdUwz?=
 =?utf-8?B?OHZyeEJkc2htQ3JWSE0xcG4xaFRPRzFVVlpSL2MxMkJ3SEc1ZGMrK0k1Wlg5?=
 =?utf-8?B?bndYRDlsMS9PMGtUcUcybW5kQWJMUnZ6QmppTlM3QzhWT1RDbE43dXdSM2g3?=
 =?utf-8?B?ZHJzVjVKT0dBUUo1eTBjZTlpRDYrUGhieEdoNXpERFlMaGIwV2Y3K1BBSTFw?=
 =?utf-8?B?R0I1N09wVE1Eanc4SGpUNmowR3V2cGUyVVVDR3Byekpkd0dFREhWTm45ajdL?=
 =?utf-8?B?M0x5NkpMTkFEM09RdFlrdG9NczBYZUFVV0VkMSsrb1Z2bVhkTWdTRXdMa05V?=
 =?utf-8?B?c21kZFJSS0NZNUhrb05EYWcwK3dpK2t6RWM5cjFOc1VPTklTU1dFU2trYmxt?=
 =?utf-8?B?RHczdkpSeTBLYUZmOHIyRklZZWpTejRjZWZ0d0tKZHY2NVJyejVoWnJzcVRC?=
 =?utf-8?B?NzFTanBYVkxUL0VsYS9Zby94OU1WYlhONkpDZmdtWjI5SGZ2VDVvTzl4enhu?=
 =?utf-8?B?ajNNVGQ3QmVzcUMvTDY4N2p2cWNIL1RuN1JGd3NmL2dheW5vYzB3ajJwc2NP?=
 =?utf-8?B?ekIxRVpFVGg0a3IxVGVyL253Q3YzcWE5UTliU3h1a0VSWnJ6dFNiRHQ3dVA4?=
 =?utf-8?B?VENLMUZKOEtEZTkwanNXRitvb3FnaTRyT3lFZ0cyTGlLZ2ZyOFQ4SStweEsw?=
 =?utf-8?B?bnBQM2Y1YWhQVXQvZWtxaUJLUk9ad2NneTRsUWpSRDhXc2REUGgwSHJNNU1z?=
 =?utf-8?B?SVNvNmRpb2ZrdnZPMTI1QnBRWDhZbVhBYXFOK2VFNDJXalZESXJxeWhmOHF4?=
 =?utf-8?B?OXBSRFluZWd4UmxDdTcySUZrV21sdCtNWDFobk5tbFYyRzUyVWRMTGJvbWdn?=
 =?utf-8?B?NVBzeHdpNHR5SWhOMkJ3Zjd4ZTlKTU9DZTk2YjVtU0NTdGtFVDROMkx6aXJv?=
 =?utf-8?B?M0dwdzVaSzFOcWpZRTlBU1VuVFp2aVEwK0tCSmJQWjVXZXNPZ1l1RkhxMWhK?=
 =?utf-8?B?bTBUanRUb0h4RTloYy9HeExSN0FMZ20xbVhxYURtTDNvU1hqRXpaT2lST05U?=
 =?utf-8?B?NE0yRWxUTXVYdjhqaWJSTDJPd1NQaHlSTzZ1WjlicFVwYnhqbGhHeGpWQXRR?=
 =?utf-8?B?TTh1cVE2ZnZ2dkd3RHF0MVI0WXNvV1djNCtoTVNnQ0FWbzJteEZYRjdmRy9P?=
 =?utf-8?B?eU5Lb2QyWFVpZUE3NkYrSDVpOHhJRHBmcEVoc0wxTCt0QVZPTkUrc3lvWEpM?=
 =?utf-8?B?TWlUcTUyemZkR0hjUEwxQ21oa21mY2x0dkh2eG1uT3R0OTFiVWgyRkQ1VUJH?=
 =?utf-8?B?TXBlajB3WEk1Si9xVXovWHVEVkpOTVpSMFFMS0dGRmZlV0FWVE5LY0lFL2Uw?=
 =?utf-8?B?OHE5SXkwMG1TNUlFS2hOUnNQM3VqQWU4a3g0V3FIS2VtUWNnR2srM0M1ZTVQ?=
 =?utf-8?B?ZmZWdHhSeDZlckw4WENjK0xsL2tXMTRpMytTUEo5L3hOeEVPUW9vZURWTElQ?=
 =?utf-8?B?WTk5bnZqK3h2ZFJsRGhLMmdNM2xJdzB4eG5yVllhaGpFMzAvbEdZZzVSTkdW?=
 =?utf-8?B?SVQra0tnNFZvWURlRm5KbHlnbWt1d080ckFwaWhNSEVET0l4MFhob1pFRDdk?=
 =?utf-8?B?RHUyV0VWdEFnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB5749.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aVdLdXZ1MTdxT2tTcWNYTU91Kzh4ZWlzL3dUWjRtMGwzSWliT1JNUlh3aVZm?=
 =?utf-8?B?N3Rva0J1WE0zN2c3b0xBNmtTTnAraDJwaTZWKy9FQkluODhNOGxZZy8vVGYy?=
 =?utf-8?B?clFQak9DVXZSMUgvN3A0ZjY1ZTBCY1BZci9acTRzam13SGovM1Z0OFN6YlNZ?=
 =?utf-8?B?a3FZK0t1SFI4Ujdsbnh1ZTNHOWkwYUdWenM1TUU0MXVPeHc1R2tnUnNZblgz?=
 =?utf-8?B?dDBNRWNFWjYvZ2pOcHFhZFhiaTVKcFI5UUIwcEJVLzBFaUlXdnd2eFhTSFY0?=
 =?utf-8?B?UWhJRVNsTEY0L3Bad0xUZkthU2dhZGtHNHZOMm5hRlI4bmtZVEhvZkxiQ25F?=
 =?utf-8?B?aDkvbWxkTDBRYjc1VzlIQnNHU0xJaEtpWUNGYTB5TTZIendkb2I3MVRWTWFa?=
 =?utf-8?B?bGwwVi9nVnhwSnE1N0t0WldNT3E5R2xyMVc5cDlBaTRvRGhudXl2V29qRmJR?=
 =?utf-8?B?MkMxVDZOeVdzQXc1dXM5MHhTNlY2eEJnSW5sK0xoZnJ2NlAxSGlKUzJGV25v?=
 =?utf-8?B?MVJWLzRib1VUWEpicE9CUDhnMi9lN01xcHVTMEdKRnJPWHNCdnNFWmp4Y25w?=
 =?utf-8?B?eHAwS2pWbVB3bDJSOWlFQm96V3FrZkpnbFd1NkVMSDhyM2daMXI2NkdBaDhI?=
 =?utf-8?B?ZStIWVQwbEZ6V0tqOHZ1YjlSblk0dEl2YnJJS3pWSkszaVlxVE8zSXp2UXNJ?=
 =?utf-8?B?UUNTV0xNMmRva1NhcVF0WGNPM09wQWI0UzBUMmE5Sm5MOGRYTm9EYXFQaFkw?=
 =?utf-8?B?TDVwaktmZDhTOENlNlRlaEx0NlI3c2dJdGEySTNXUUd1STdNeGVGdDF4bktu?=
 =?utf-8?B?bCtKTXBobUtTdGo5MTdOZjd2anlvL2gyWXFPaGo1TnRReXNzTVVmaEpzai9Q?=
 =?utf-8?B?L3huOHNyMkRtbWE4NFBpYVFXMmFFL2JCZXN1K0lGUkowNGFzZjVRUkUvZkR3?=
 =?utf-8?B?RVpab0JCd2hWUlpOSDFPVEpWZEE3N2duckZpYmVLQTdlUEtQN1ZSaWZUeHI1?=
 =?utf-8?B?b3lpWDFFYnJ0aEhxRFBoWTRWL3VjSUtZeksyZXU4SXlETURqdE5HTGFDU1p2?=
 =?utf-8?B?YmFKYTNBWUhsVW9iQTJMd3dLTXhaaTJITUd1WGZlVWhZblYwejAwVGVyQS9X?=
 =?utf-8?B?WStva3FBZkRGV1AycmpoSkltYW5JYWM2WndLYU1mTTU1aGxySlBBMzBYQkYy?=
 =?utf-8?B?WndvM1liQVFLQ3E3dHRDamxTQXFVUC9pSmo0K0prZnhLL2VhRG9UL1dhcTlx?=
 =?utf-8?B?a1ozODBtOTJuaEFZcEJuWVdBZGNkb2N4WTloMkxjZUlYMElrd3VWekxQN3pG?=
 =?utf-8?B?TldHcDRaVFdmQlRtWlhpY2NWam54M21HUlI5Rk1SVGpZN2ZWekxEOVF2M0R4?=
 =?utf-8?B?Q3JhdmtMbjlRc3ZtV1BsTjVkOEVZTXk2bm4wcitlbVRCaXlwalEzK2ZUYlZO?=
 =?utf-8?B?RElHSEVCL3F2Q2ZSZ1lxcHdvbTYzTklZRXV6ZXk4WVUzQVdhVktRWWJZbG8x?=
 =?utf-8?B?bDlQNWVWYnNXS1NkM2ZseE9ENVF0ai9JMS9XQk96OHllOXQ5N3lBUmJmLzE1?=
 =?utf-8?B?c09xM29SSXFWdFNlQU9wdXhwRW1ObVphYm1QL04zNWNITFowbWlVK1o0VGM2?=
 =?utf-8?B?MkFhT3FoREgxTU5peWVMVVpIcEJONnVBenJHWTQreEo4V0R4NmVMRURIaWRq?=
 =?utf-8?B?dXgrcldaZGxoR2xabVg3V0VUdTBheWhsVk9sMHlBWTVsYm0zOWh6NFhKNWlL?=
 =?utf-8?B?Q0ZwR0RWRVRlVW54cnNHR1g1MC9GcXYxTUI3R0ZPcEdCc0FmOWVvUHVLVkli?=
 =?utf-8?B?NTRLVlB4ZzBmb3ovVVlIWXVrS2sxdzM3Z3VabDJIbDlkUnVnbGU5VzdlOXBv?=
 =?utf-8?B?NFBtb1VnVFVKY09WTm8vVkpGeFBFK09UcldHSW9NTkhVNzdmZ3RRaVBIVVpD?=
 =?utf-8?B?OUZVZ1hicG9iU2o0QTVZZDZUeWtXMi9QcGFPMklETXMyU0ZMaGtnMHRGTG9G?=
 =?utf-8?B?NEVZQWJLQkFxSEZRNC9MMFFSdzhkTkFzZWh0L3cwTVFBYys2OTgzOGo2OWRi?=
 =?utf-8?B?cVBtdGsvQWpkYy9UNW5McmNHaHdqdTYwWGlJc3l1T3ljdklBL2ZpdmlIUURJ?=
 =?utf-8?Q?Nzqz3drzIJ+enmpLZDn/VjymV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F77A77914864841A5E75CCED32F9BE3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P5oaUaJQso+iiOkfp2fX08CK/u3oE0v1KVsC8r2IhM3CQsuHnPftGVAUttABCo/SX1bLPY9SXJjbUNA8pVeTytBGs3Nw+7gPCKKDq6QaIquekFScBeYyOhRos3+TBDcaeVmSLEogFVumj352BKZD6IyiVkreMOh/gCgvu4xHd3dpD67tWUlgr5DuR9YhHcKdiC/Web911keHRX0L28zgUMc8OT2jCccoY4tvxS7Vzm7oZ4Rs9l7FEsVuZlwPihPfhewaTCy3Cfg4GOpH/GXarMEDbDwRF09yw/JaYjmBPX6hdr1Z+uTfyB9ZcH3lN/kCOtJMhW2ZtBOhmlKE+0geydV4A3oFrtpkwZo0avIoYORjNwTaKrSKDDdgbJ9NJzXLEdaumb8FjfEnJY/vk2sxwdQLfgVUrTCxE1UUtc/040GWSPC9+CBgbcEyRjG4LM+NoRSbXigFp78ogoVLvsqErGrffLzMwH2hFGnA8Yy2yITY3hJRQCC7X5PsvPQCrqY5td2X9EHiBcrc3zvFrde3aJoucLAVsG6ssEBcIZE17BnVBkwpYEyCFAwmdNb9kz9adlCEvZ26RKpd1ak0wWQdUzjMD654EU3fI2vTe/8LB0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB5749.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04b7cd5-993d-4931-c20a-08dd8293dd56
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 18:22:54.1375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/Or/BhRwrwc9KBPfFxkeU8PEZ8AQ2etiX6jpv86j5h3HrpPEk57b9VQgVWm1vw+pIIVD9+xr0+KJee0fHu0Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4616
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEyOSBTYWx0ZWRfXxiUTwy6YClAP xOyi9zWtd+FHf/rbxb8eev5BI8FkwvOMsSlRSO4j+T/aQtM51HhOi6R6uWDqx5aHV2px5Awe0Wg hn+hR3oOVaPOleG4H7TbRx3HFlJvQD1QbJvnknevytykvxsM0ZzqqJ0JmpYFXBAvmZfcP/lS67X
 oIZy/SVEBoSELE9PAb8tUgAxksc1BiudXjfbBRps840KJ8YZn3LHEFxNmODTLxZ8Tcytu5XDcjF IZvTSX8jo+P3Hm2vGWWMjSDEZsUCdL+e1xWoj+IW4BOD7xK0dcqgu5s0Sabx/kx9/K5S9YluH3x YhhggtrUi3CLWD1EHNSMmjL7vIEc0golYKSs5yhqHVEYzPTgRAr4lBKh+P8H8DYXZWu5PwV9m0D 26o0he5X
X-Proofpoint-ORIG-GUID: zPA33bWonW4slhBDNYO4JpDB7lOpwsEY
X-Proofpoint-GUID: zPA33bWonW4slhBDNYO4JpDB7lOpwsEY

DQoNCj4gT24gQXByIDIzLCAyMDI1LCBhdCA5OjU24oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgMjMgQXByIDIwMjUgMTY6NTA6
MTUgKzAwMDANCj4gTGlibyBDaGVuIDxsaWJvLmNoZW5Ab3JhY2xlLmNvbT4gd3JvdGU6DQo+IA0K
Pj4gQ29ycmVjdCBtZSBpZiBJJ20gd3JvbmcgYnV0IGNhbiB5b3UgZGlzYWxsb3cgYW55IHBhc3Nl
ZC1pbiBwb2ludGVycyB0byBiZQ0KPj4gZGVyZWZlcmVuY2VkIHdoZW4gVFBfcHJpbnRrKCkgaXMg
ZXhlY3V0ZWQ/IFRoaXMgaXMgc29tZXRoaW5nIHlvdSBjYW4gY2hlY2sNCj4+IGF0IHRoZSBidWls
ZCB0aW1lLCByaWdodD8NCj4gDQo+IFlvdSBjYW4gZGVyZWZlcmVuY2UgaWYgdGhlIHBvaW50ZXIg
aXMgdG8gdGhlIGNvbnRlbnQgb24gdGhlIHJpbmcgYnVmZmVyLg0KPiBGb3IgaW5zdGFuY2UsIHlv
dSBjYW4gaGF2ZToNCj4gDQo+ICAiJXAqaCIsICZfX2VudHJ5LT52YWwNCj4gDQo+IEl0IGRlcmVm
ZXJlbmNlcyB0byB0aGUgY29udGVudCBzdG9yZWQgb24gdGhlIHJpbmcgYnVmZmVyLg0KPiANCj4g
V2hhdCB3ZSBjYW4ndCBoYXZlIGlzOg0KPiANCj4gICIlcCpoIiwgX19lbnRyeS0+dmFsDQoNClJp
Z2h0LCBJIHdhcyB0aGlua2luZyBzb21ldGhpbmcgc3RyaWN0ZXIgc3VjaCBhcyBkaXNhbGxvd2lu
ZyBwb2ludC10eXBlDQpmaWVsZCBpbiBUUF9TVFJVQ1RfX2VudHJ5IHt9IHRvIGF2b2lkIGRpcmVj
dCBhc3NpZ25tZW50IHRvIHBvaW50LXR5cGUNCmZpZWxkIHNvIHRoZXJlIHdpbGwgYmUgbm8gY2hh
bmNlIHRvIGhhdmUgdW5zYWZlIGRlcmVmZXJlbmNlIGJ1dCB0aGVuIEkNCnJlYWxpemUgQyBkb2Vz
buKAmXQgaGF2ZSBidWlsdC1pbiBtZWNoYW5pc20gdG8gZGV0ZWN0IHZhcmlvdXMgdHlwZXMgb2YN
CnBvaW50ZXJzIGF0IHRoZSBjb21waWxlIHRpbWUsIG1heWJlIHJ1c3QgY2FuIGRvIHRoYXQuIEFu
eXdheSBJIGdpdmUgdXAuDQoNClRoYW5rcywNCkxpYm8NCg0KPiANCj4gLS0gU3RldmUNCg0K

