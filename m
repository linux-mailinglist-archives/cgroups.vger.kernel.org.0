Return-Path: <cgroups+bounces-5731-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCED9DFE77
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 11:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1D02813A5
	for <lists+cgroups@lfdr.de>; Mon,  2 Dec 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0B1FE472;
	Mon,  2 Dec 2024 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NkaMZmBh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WRjQoUzq"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A31FC11A;
	Mon,  2 Dec 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733134311; cv=fail; b=F0OhwBtwoGnlPAXz2RsiD/ZQJ0hxXtXu98p0qJ+T2MP8IwtjIMgrwdROhhJ1CahfKuo0/MOjimJ9VsfiS+pty6hJYzkbx3tqfIbxDJlU+0b5G78zGmTKyANoVxZOxlgwh5inUbOPg73SUc4gM3aYJVAXcPt9Cmz9DYxhWQVTc2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733134311; c=relaxed/simple;
	bh=pWst/jLMtyhw9CdmPy3wj54LbzJk6km7V4YscnRTJP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Arls8YjpOCjPNR66QBDK6WvPo6Y3tDILxJFFjIEH7IFVaxJj2Fr/ChW2R4ZiYQFVOsCYs9aYc7FqiBErfE5zDaJfWLwthxQtU/QH+V2hm9PbzKdam4A1h+BJr4PE7Tj5eLDYCPt+0hqPA/IiJ200NFmKn7CBbsqkgu/8kgxDLY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NkaMZmBh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WRjQoUzq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26Wxvr008605;
	Mon, 2 Dec 2024 10:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yXuVMfHi41Y1jRfz2LyGiYKxl/pGfVN9pcpVpZk7JNk=; b=
	NkaMZmBhnLQCVMEv8Jf94z0bdTgXANmwO37kZQb2xmNiNIqoqqQcUSCWKZg07979
	TD9TrfzM4c8VCkWZn5wrDlUSDa0rtT0MupJh5k5926BfM9auPaDZ+7L9TRdR85UG
	dt85dLAw8E1FplWtaMqLCeCnMo60JwSzUApkQUxJlQSAN4tPZ+m8x37DuMl7AupA
	jplGAbEJGmHb9lJacQFFAwdGt5q6LnKbCjFiHPORUuo+xhIhET5V0z1yIbbH5ML1
	652X++yY9hhiBBxNjxlT7GOYBODQeQv377uRdpKFD1Zfb5AH/HDI2GI4KE4jXefC
	opd13+oHtoRb7kyRWjbmsg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s9ytgcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:11:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B28kpa1032206;
	Mon, 2 Dec 2024 10:11:44 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836sabw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Dec 2024 10:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmtOfaSmUL6E/jkQl6P/5lyegdXJUcTD460nkpakNuh66YuLsen/CJj2fl5cXBh3ZQlEz2PW53lrUlUofkU+U0AfuWvI5LgxqiqkNg53hIp+8MKfEwaA2ZQYpBI7+48J3t8zwfeJF17C61KPAVAkj09rVFjzjzFQRILlgp/qBFvQ4wMYhrjfTp/94YQ/cuLaR17j/BOuDkPQEf9EuPMayHXj/pgMr332hQ5HvML6UjhuTuA2vZpwXjlLNWwKoS7nXCRGqPhjcfyL3ETBqVDBmOOExvH7GT8Fc4Gju+7FXtNJqmqSNXGOxikFl4Nazkx8v7bY78lTvLpZ6rrsLN/T1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXuVMfHi41Y1jRfz2LyGiYKxl/pGfVN9pcpVpZk7JNk=;
 b=ci9XQ8auQYgucPGBETjZlidlvK7qJzX8H17eKxq2xsFnsCqA+BDY2ZIsDU040RcMsNUlvmNNh2K5kayJQuhB7t+qSTFaa0oT4rMQrBSneA6ltVgMF2lhfpcQJ/NVE+MTx50edqzHFIk5UkbBLj2pCdxDuJ01SwEZxgWGuHl4kSB04xQKz2gArw1v68dBqvTFTgs721asI3tMrtHvLETfDR8Ta1OWExC2842A/uOe4B4ZLthQ9jk+oKl1yy9Tn72W54p5Fimvqnp0N7QGhxFl5jS8bI/EbbAb4u0U6lU/1QJpg01aSmnrjWwlpWQFsjsRjIQ1fVwiHOEy9IsnFqovpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXuVMfHi41Y1jRfz2LyGiYKxl/pGfVN9pcpVpZk7JNk=;
 b=WRjQoUzqTlNZuWrh7TmPdq2VP0okwPTdHviqGGsfuiDtstcMvTXwVvcI73VGnye76VVMaI+RuAx5lZJv3faGuDy4dCL8mwV4MVI7tFFnUQCBjJiPWChdzx8dNxg2eSjQhcxVUySfhWKo8qqo4L6soy2oIDdTuMBbAOERb3h6Ad4=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 10:11:41 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 10:11:41 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH 2/2] cgroup: Move rcu_head up near the top of cgroup_root
Date: Mon,  2 Dec 2024 15:41:02 +0530
Message-ID: <20241202101102.91106-2-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241202101102.91106-1-siddh.raman.pant@oracle.com>
References: <2024120235-path-hangover-4717@gregkh>
 <20241202101102.91106-1-siddh.raman.pant@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0254.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::20) To PH0PR10MB5563.namprd10.prod.outlook.com
 (2603:10b6:510:f2::13)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5563:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 08377f49-9c9d-4909-c9fd-08dd12b9b7c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajRKT0JYNVlFekxHeVZCK0VFYlJBUHFUWDlrNVNsYkJsRnhEcFNWR2d3czdQ?=
 =?utf-8?B?dXUxcGVpTW1kL1hvZ0Rya2VBU1hzZGhickZVQW9SRnR2SWQ2Z3lhZFRYcU9I?=
 =?utf-8?B?V25IOVFNYis1RVUyQlhVcXBvS21CSWVWRzNmNmpCZXg1OWhTMnoxeHBodnBZ?=
 =?utf-8?B?elF4VEVIOThZZ3hUZFRRQ3JEakkvUHBXRm5zdCtzcDNoMVd6NHhWN3pqaUly?=
 =?utf-8?B?OVpRaU5JL2hhTEZOOXZjQXZvNnVxWHYvUmVZYkVHQXJ5c29zZHdOY1crTm8w?=
 =?utf-8?B?czJIMmdETXFmL05YRVVnWkx1UlBvRmpZdmJnalE3QXBvQy9YTGp1d0JIbUJE?=
 =?utf-8?B?enpzK0QvVWFLQVk4bjFpK254YXBlSUtBeVZJVE83ZDErakhIZlI0OWZ1ZXhM?=
 =?utf-8?B?V2dhVGhqSmN1MlJmUkxwUGUrVWFNQlRoK0J4Zk1Fdnk2azE0YkgwM2tVN2FP?=
 =?utf-8?B?SGNSOUszb2JoeThhMDNrNXlleHpBN244MmJoL0NlNk9RVEx1ZDRkV0I3WWxh?=
 =?utf-8?B?NE0yWkRscVJsS056QWNPMU1DSUU3YUM4Z1JYRHlnTE8xQU5TeW9UNmpsOXNU?=
 =?utf-8?B?RWZGZDh6U1R0akJzZVZCVjJaTHN0aEpaODVhbERycHk3QkRYUTlUWmxTMmc0?=
 =?utf-8?B?ZEtTTkFqTEE4Qy9WZnh5UDQzTEVObGRDRzJUVTJpY2RvOVE5N01zb0tXZExP?=
 =?utf-8?B?blRtK3JaZUViSGVWRmIrQU9YN1BaVkEyVnhmTmNYUy9GVVdIYkZUTzc2dDRn?=
 =?utf-8?B?RUtPUlNYWHZlUm9NblJEMjdYL0ZMK3lwa244TEloK01MWS9GRDZGdWw2NE1h?=
 =?utf-8?B?Y1FraEhtQW4xc1dRazNEVUcrRmh3S0RWYXpqVUE3aHpsUFNRRmZRT3pZU053?=
 =?utf-8?B?VWtJN0lLSzV0OWVHSjE0L3ZXZGZxaGRrWVBYR1J5RndVYm1mZjQvdG9kSC9Z?=
 =?utf-8?B?OElTVksyOVB1NXFvVDFtUzkycnZBY01xdDVHU2c3MVNhc1pWNGZ5b3h3a3No?=
 =?utf-8?B?OUZiQ0tCd21xR1I4UzlyT0QzYmFhdkJZV2FqTWRhZW4yeExBd3NuNzdXVlAr?=
 =?utf-8?B?M2lpZDJ5ZWdOTDhzRjlIT09HNmxMQmdjRlloQWErWW9FT21FSi93YVFFeFQv?=
 =?utf-8?B?dzlkNmJJYUh0cVZiYU5PaWwwOWdsTjdqZmh1Vk9TMDBid2xqbDdHM0VOT0tE?=
 =?utf-8?B?V1MvaC9IcnB6ZXRObjFMZGNPWUtQMVo4a1ZRRHJyOUlGcm1aMjVxQk5MT1hU?=
 =?utf-8?B?VHkySDBFWGExdDdQMy8vam15NEovb041bUtZMnNvaTJmbGxRRnlaL1NSK29W?=
 =?utf-8?B?enhOQStMcjA4TVZkVVlDRC9jUC82TUlHN245aFQ1TjBDbDJTa1l0RmovVWJN?=
 =?utf-8?B?NGNJM0Z5TkFteEZTSmptM3Vibitra3J3YlZuMDBJZitibUg0YmxOU2w3MFYz?=
 =?utf-8?B?WnBDSHVzVzMwUFVxMGJVcGlzNmt0VXhJY2tDc2dwVTNjcGhMenNQWDJzK3Rr?=
 =?utf-8?B?eGl3YVg0bkJZSnRTMnNpYmJaaGJ6bkplN2ZvTC9icG8zYW4wNTJ6TklpL1d6?=
 =?utf-8?B?dkV5OWRFRjFJRDVyaU1DRGxNQ3NFUTJBRkNybDM1VG9NaEt4MFd3blVCV1d2?=
 =?utf-8?B?dk1hYitBS2dUVCtueVV3cWMwQ0lUckFUOUwzcVN3c1lZRFpudTVkcVNaeWlh?=
 =?utf-8?B?eW9laXl3QkNHZzlPeUVvSFJ0UlpXR25IaFlxZm11eWVFZjAyTTNjbXJoQzhN?=
 =?utf-8?B?cWpsdy8xekFoZytCMHIrVTNLNlo2ZWMzZmlDZW9lYzd3akdZaEVyMHdyZWtx?=
 =?utf-8?Q?3qeeLMOUVVczC7z3dInYpFWuud5YH9KLzPlU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alJrbFJKNk9lZGZ2UGdVellqZkVZM3hld3ZJZHhPeE9qWEw1QWJycDY2ZWM3?=
 =?utf-8?B?Y0NjekZJWFk4Zi9tbEdBeXdHbXZ4YS9YWmxXeXBoem1ENEQvWkNSS01oL0Rv?=
 =?utf-8?B?dVBWang1c285YU4vWDhLajRWcGhpczdKSzI2UStiUjNMeVk4SzZyaU5seVFD?=
 =?utf-8?B?WTRVdUpVZXJFMlh4V3VUVWtJeU03RkJEWGk3Z1A0L1MvMDNxTy82bEhuMHRQ?=
 =?utf-8?B?TDdKZjNoVVBCSXQwWUlZdEVhamxzRkVIa0xxamJEL3FsYVJxc1RrdmhJRmhu?=
 =?utf-8?B?UkJ4eVZ1UnpBOHFxdyt0V0RxallGNzJ6cFQycXdDTXJIMmQzTForMjhPVEtl?=
 =?utf-8?B?azA4KzlxVTIzMW1DNnNDTkh5R3hBWFRTMzlJU3JKbVlCRnVoZDF2a3lkK0Zh?=
 =?utf-8?B?SVVQZlFVdEh1VTl2UThNZVVUbkNJYW1nUWhnRWNScUk3SmltL041WkdPSVRY?=
 =?utf-8?B?Y3g3SWsyM0Q2bHBnUExHbW1zQ0x1ZU5rREQ3QytoYThubURpQUxqNy8zTHRz?=
 =?utf-8?B?Wm1LRXpqcGo4cVFhZ2M0WVUyMVhNL1d6UFR6anVKVld1L1RaOHJoa2VjSk8x?=
 =?utf-8?B?V2FTcUZDOUc0ZkpWaGE3NWg5NjZLYy9jTUk1T29HR0pyQ1BJU2hpZkJWRjBx?=
 =?utf-8?B?czlYWjBrMHp2MjJjaWdqL3Vac2NiUkZoWDJEY2JrbWdMQ25SZ1NEZWFValEx?=
 =?utf-8?B?emhaNGtJdVVKaGNidzFCV0lxeE02ZytzT09kb2dIQUpPUFBpZFU4SXloRTU4?=
 =?utf-8?B?Q2tYZllaMmhBK3kzejFhNXh1REVET1krVHhIR0ZQeXl0RXRPL1ZxQXpEbnR1?=
 =?utf-8?B?UlJvNngzQWxpQXVDbGlRSk05dzRtenNmNVZNQVEvNUprdlh2bHF6YXNSeTla?=
 =?utf-8?B?UUNQbUVIOHlnV2FObjRKczc0eVZZeWFNVmNROFRsK0UwY1dhNEgxZG8zTmx3?=
 =?utf-8?B?RG9Oem9XeXNRM1dRV2xGM3h2WVVuWTltNDcrWE5LSS9CeWlTSk1TckdhWHJQ?=
 =?utf-8?B?VWJLbWd0Nnh6VnJrbGtqaGdrV2tRcGwyclZoOWxjQVJvZUZ5ZzFTWmxmRkpN?=
 =?utf-8?B?dnJZYzNSczNWR3FFZVllWU0zNGNjNVFrWTJzcURvRW5nZG9UQkZrRzFRT3ZE?=
 =?utf-8?B?bUFqTDl1UTIzTTZmZ1RCa1BLMFcvMWVBWmdqQWdTb29Kdko5c2NxcTBnaXpO?=
 =?utf-8?B?Tjc1YWdoTzlqRWl1R0haL01KaVNld1ZJUnVYSjdKcmlQajI5K0JKSVBpZUQv?=
 =?utf-8?B?a0NUTzBLRWJBRFdoQkhkaks3a3BveXpTMDB6cTJOTEhDR2hhUlp2bnRjUU9m?=
 =?utf-8?B?cnI5THMyUzllZzBIUCszcFBCa2lSb2EwWkZyTVN2aHNqaTFSM0pwaGIxZjM2?=
 =?utf-8?B?UFhOY2U5d0E2T01hL1llNWtzSkltMzVZRlk4R2FQUGduYjA1cEd3TlkzaUZn?=
 =?utf-8?B?MHNhSHlJSnByMjJhY1FjYnowbWtGY0MvRE1LMnY4VEJUT0wxdnU2ajB5dXVz?=
 =?utf-8?B?K2Y3RmdPOThuWTMzNWNFcWltTk9GaFR0Zi9TWVFLVDlyRXpSSEJyUk9FQVZm?=
 =?utf-8?B?cisyNlA4Z2w3b3dnaHp2K0QzRkdaTVBWc0dVUm5WWU5hUSs2N2NqczFvblRx?=
 =?utf-8?B?cUtyRFpMbkxQdTZSWDJJQUNiU0Zva09zVFlJbzdVdHhRQkxlNXZuYTBHekN1?=
 =?utf-8?B?clhCRUgxRjgxZnZNTDdQR1JGc05zNlRLUitmRWpxL1dtWjM5UU1nanBISXp1?=
 =?utf-8?B?WCtOVWlIRlc3cENoSHNsMFVySTlNNFJ0OVM2MjlVYmxmenhrVUgrQXh3Nzdj?=
 =?utf-8?B?a2NJR21TcTRJY1p0MzRFcVNtMmdualJ4UnYzcG5mN3ptNU1GMnBWaUlGd0Zp?=
 =?utf-8?B?Q1NHT2dtT2JIYkkrUmJ5TlE0U0pqeW5XenlLcGlMbnBleXpyM29zZXhBZjhN?=
 =?utf-8?B?M1hCVHhiSGZLaWgvSEdsR1A5allnNERjZUtoMHgzMjhWUVlmZzJRNm8weDlU?=
 =?utf-8?B?cnNBZDhmQ0ppWWZVb2IvaTRLOFQrdjk3YUdGTGJ2NHBrS3ZrQUlhbWFaeXBP?=
 =?utf-8?B?N1NXU21FcWRjRElIQ01TeVE0ZUQ0S0lvMG1sVmMrbTF6MzA5U0VrM0xBVU13?=
 =?utf-8?B?aDJPZHgrUTVPYUtiSGNsQUgwOTJsVVNrdXVvdVlMbHd4UXl3Z21NdW9GQ3lx?=
 =?utf-8?B?c3IyV01lbktFMm9jMXdaaXZpOWdFZnd1MnJjU3I5ekNCbXBybmQxT3hVcno5?=
 =?utf-8?B?bnVCYm9nTnh3UTZLSHJEUktFMW1nPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T5dSbOwBh8ZUrSUoUjiGEo1NbSMxr6NNNyPDOWt8RBnzBrYTkLL+HdyZv7otj/yUhJigXvF7CL+MXIVX9WKjQHqFCzSthl2xQxzaBeKkEx1iFkLTdmTfE0knCmdCJpXqf+cPz9F0SjttmS+3Jjx0GecDu1QC6ehtj2At5ngLlAe7Kjz0MF5DgY4avPwqBHROWQY8k/jNnN8/je2yWuB1Pu5KC9J0IYJYluvGp8DIy3doSfI0lQrR3aPWHaWJZTiDSmb7QJTsuPBuhFfDWuHrece4UB7BiheCEkdEBPfy3JROd89AzgrL+baILst5RmHt0ZqeTfdc464x4Ac10jcF3MHY6oyUQDGZxqE3aFqXgCBZMdlkEhpenM/2DTar+LmQgI1Tk2QJiXOommMYBNDpDx2nK3OVei4NOZR5iRhg8OFkJBLhW3RPhOteksL0WbzlmSasUpgijs3wddkYkUgbFt1yiRUL0kyljwRqoNNapZyxjpnaEwHLMnV9AZitVi1+zpHP8aPCIMdP+6EZju7mmGlyxuyDuZlDo8i3fTpOhrCWy9sJwM6ReCcJg2zWUE7k+Pd1rtmQBF1TbY2HFaLbFaa7eb/UGWjM914YOckNx+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08377f49-9c9d-4909-c9fd-08dd12b9b7c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 10:11:41.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: APoNSpml/ZJsxOdJEb7ZcEHcj3vOIsybPHuTIm0E2TioKdFKO4vk6dBiP1b7YNAqwPreAjxerYnU//VrrujJvqbu5DPBxo75BrqfQoU9rAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_06,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412020090
X-Proofpoint-GUID: B9vU1FfTSc1owvzUI4iFfFOJXpYlrQQN
X-Proofpoint-ORIG-GUID: B9vU1FfTSc1owvzUI4iFfFOJXpYlrQQN

From: Waiman Long <longman@redhat.com>

commit a7fb0423c201ba12815877a0b5a68a6a1710b23a upstream.

Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
for freeing the cgroup_root.

The current implementation of kvfree_rcu(), however, has the limitation
that the offset of the rcu_head structure within the larger data
structure must be less than 4096 or the compilation will fail. See the
macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
for more information.

By putting rcu_head below the large cgroup structure, any change to the
cgroup structure that makes it larger run the risk of causing build
failure under certain configurations. Commit 77070eeb8821 ("cgroup:
Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
the last straw that breaks it. Fix this problem by moving the rcu_head
structure up before the cgroup structure.

Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
[Shivani: Modified to apply on v5.4.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
Reviewed-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 include/linux/cgroup-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index c64f11674850..f0798d98be8e 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -506,6 +506,10 @@ struct cgroup_root {
 	/* Unique id for this hierarchy. */
 	int hierarchy_id;
 
+	/* A list running through the active hierarchies */
+	struct list_head root_list;
+	struct rcu_head rcu;
+
 	/* The root cgroup.  Root is destroyed on its release. */
 	struct cgroup cgrp;
 
@@ -515,10 +519,6 @@ struct cgroup_root {
 	/* Number of cgroups in the hierarchy, used only for /proc/cgroups */
 	atomic_t nr_cgrps;
 
-	/* A list running through the active hierarchies */
-	struct list_head root_list;
-	struct rcu_head rcu;
-
 	/* Hierarchy-specific flags */
 	unsigned int flags;
 
-- 
2.45.2


