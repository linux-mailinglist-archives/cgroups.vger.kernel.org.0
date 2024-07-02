Return-Path: <cgroups+bounces-3485-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA1F9237BE
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 10:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4DE9B20FE3
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 08:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74314F10E;
	Tue,  2 Jul 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdRDML7s";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h/+6FjXk"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7F614E2E6;
	Tue,  2 Jul 2024 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909749; cv=fail; b=QMl4Isp4/WTuiwIptWZUf9v0m5z4BTad2T6sgFEFgYrEMesyOtx7E0LLxlzHKptYp8UGtmOVEaiqS1F2oKPnHuJSG54XX1oGNemh9Zym1JlWwnG2jzHkOFF5lqg9fG2h7sNpWCORUTeFlqC7HSlKSEiqt9fbDcGpW4jSmyp5xtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909749; c=relaxed/simple;
	bh=eJHrKAv50R4sUaItx2JWuuzorH2hr74diOEugHaOVFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BWPZJH4XA8gtSHOMV3QqPFQi4l6KZgUEWdtqTeOorU/SAOsTwswmUt80DEgbXt6GOzuRISnPfieKuuLJsBVNSpnq4dx1IJMlT/4fubG0mTcpv42ygwkf+JmBlJFqdhr2s1vUC2jORcL0OuCgqubUTGYlOhO2ZWdvKHxU60vNMW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdRDML7s; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h/+6FjXk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4625MVqL015531;
	Tue, 2 Jul 2024 08:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=k3SNrEehJfqGJIWji/LXGyVCPyKdQ8ZoSZ2Zl6QEwPc=; b=
	JdRDML7s6ACaBLQ4ghruuyym+qbX1fBqLeZVS3uwVdg/07V7qLsOD4PYmobuInNz
	kN0vg52rp/8avqEMFuT+DRY6qmN5dnjaRLEY2+JNlGWF5D/blq3/iUh7Gf28tKt8
	yw0uTZLY4OAxZrze0/7l8B913qs4kvN02I87yaRXcCudQmGRdgNQie+w+JAjO4Kn
	z+UBgD7655V14cKmaP8BNe9wp6rOJtZXW3Tv0ZulE52ib9qxgQ42dvgN1UqXLKxW
	viL+cvtA0x6NdBfvg2uYs1Ozbd41OmiriEAq4YvX4FnklvTdJRDE7ZegJsNZrjdi
	4DzaQBqzoogpUw341DBcBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028pcn8bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 08:42:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46280K0b010548;
	Tue, 2 Jul 2024 08:42:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q7jy3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 08:42:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daWi5AEcTMcwUdriMhQluu8otuaabWbquWVqvUXV5IuIQDV/HWk7no4kqSuorpTM6AouJJqew4FPiOq2mfkDDWHxhabnf2pCzvGdwljopDrGYukdzsQBFz1v5D/fPHPoGz0vyl3U/c+1a4S4G/4wOr4gYJ4yWpqlaDxZc3hXt9QkcO4CCC0ddYdCZ+po9YDqJ4nhrX3c6OUYpQ6FekVemNPh/KYipGUNCuDyZ/lTdIm/DdoSmV7eztBltLOh2neXcaRSfjovl7rwmG0ZUkrl+p3GwNVM1L90Tc4YmqBOa4Kc87W+qB+TnNvw88RSTMMISgeg6QSET05YZxK4p3aBqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3SNrEehJfqGJIWji/LXGyVCPyKdQ8ZoSZ2Zl6QEwPc=;
 b=SC5Cw53+JdpZhC4zhmujDPXnlUhTGXxCYFyl/nMwNBifRcnLwbrWJ8i5dr7xRvbL6G3Rmdx41fzojJubpJQCb+ve2geh3dtZys1A/KM9tXc9++Aytvimy/0zgor2vMx60Xq58GNpJIpqPxaQ+ogPMC3mv1zT6t867rtGXRrbv7ViDCI9aOIPVe/Ix/dtn65IT2ZV2dF561FmuAXwSEipA4rCTr1GwiQppgz+qiGLnVngtKML2CEsp6lUbliHugndxuvWxvCTf1pGsmQCxS/WEGZpjW/QDLryiHK/gql47NHGOHnCTsSgXw+Nu8uXO6r0e2EYpsuwPhNA9inHU5atUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3SNrEehJfqGJIWji/LXGyVCPyKdQ8ZoSZ2Zl6QEwPc=;
 b=h/+6FjXkKP1kNmnh09qGuIED55uQUdNwLdbCTjwWowRqnp44KwVjLJPzwdlVxmlEWSGNtAqoQ0RDqW+OGyNo57lPjAxVAfnbAup77tTkELbTih1g2yM09vp8UypthqmEt/sHw47olb6rcOndFeGaIwB2LlV6iQoTvoKr1bEGRTw=
Received: from PH0PR10MB7080.namprd10.prod.outlook.com (2603:10b6:510:28c::6)
 by LV3PR10MB8084.namprd10.prod.outlook.com (2603:10b6:408:282::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 08:42:06 +0000
Received: from PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936]) by PH0PR10MB7080.namprd10.prod.outlook.com
 ([fe80::3d6b:7c00:50d4:9936%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 08:42:06 +0000
Message-ID: <8cced4cf-979b-444c-aff8-057b2a09efdd@oracle.com>
Date: Tue, 2 Jul 2024 14:11:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 -next] cgroup/misc: Introduce misc.peak
To: Xiu Jianfeng <xiujianfeng@huawei.com>, tj@kernel.org,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
        haitao.huang@linux.intel.com
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240702075718.2657635-1-xiujianfeng@huawei.com>
Content-Language: en-US
From: Kamalesh Babulal <kamalesh.babulal@oracle.com>
In-Reply-To: <20240702075718.2657635-1-xiujianfeng@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0205.apcprd04.prod.outlook.com
 (2603:1096:4:187::6) To PH0PR10MB7080.namprd10.prod.outlook.com
 (2603:10b6:510:28c::6)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB7080:EE_|LV3PR10MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4b63ac-80c3-41ba-0ab3-08dc9a72da7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RjNZSks4bVk4OGZ5VHZjbzVUZVh5M0JnZDVyVURONCtrdStsNzVIMjRXeHpk?=
 =?utf-8?B?aU93R25VUklqQ2s3aDJHNVhUQ1p3SnZRVTZQMm1UQXJkRktKVzFaSjFIdGYv?=
 =?utf-8?B?QzVkVk1xOCsraUhnWkRqcTkrZkUwVGVZckV0UDFoSGhhSGFGRmZWd08xZVJC?=
 =?utf-8?B?dlJPa1hUUUdhWUxVZUdzWHFweG16SytzRzhDN2MvU1NTTGNvci9kd1BLalM2?=
 =?utf-8?B?eCs5WElSS292dmEzTTJKL0lpU05MdVQ1MmU0NnB0ZDJDT2kxSW1kZXFCOGR2?=
 =?utf-8?B?MG5leWgyZU4ya1NKci9NeCsvTC9iL2ltbHRFaU5xM2NCc21QNEdTYmg1b01k?=
 =?utf-8?B?MmlEdGUzczQ0ZmtWL2c3TzVOVGhqem9ta0haTlljbGVHOGpSc2ZSbUNYUktO?=
 =?utf-8?B?UkFrNTZyUFNDenJTN0dUbjFmSmlkTlVKK0w0SERDb2VrS1BHalhOTkUxYktE?=
 =?utf-8?B?SHRoYWNaZzVLbnV0QTd2aG5CM1l1MUFjVEtOS2lhNjdFYW1KbEpXQTRuZWMr?=
 =?utf-8?B?K3dlaW15dUdRY0cyTUFndnZqWEVyUTFnWGVYTVZPYTBJN0VPdzl6dUZuZlh0?=
 =?utf-8?B?alNZTlk4dVZKSjMrckxJSUJHRlhSa2RVbE9MWUM1MTlUMTdXQUk3TXdsWXNR?=
 =?utf-8?B?VFpnQVhIMXllRkhnTXhzV016MkpDejBSWDZCendqRCtBL1gvRVVSK0RSYkwv?=
 =?utf-8?B?cTg4OUhUamVFdElSVGtEYmdpVWhjTitKNkY1dmhTZ2tRTGM0REIrbm5qQkhn?=
 =?utf-8?B?aTJhL3lHTDVRSVAzbjNmLzZDdmhRaHBsZnZmaFFnR21ZS0Q4WEJZb0FucW9t?=
 =?utf-8?B?d1NGdzdLVVhvbDNPbnk4eS9VUHdGWmwwVDU5SGZxcHlYSEdMY1FvdWdHN3dQ?=
 =?utf-8?B?M21CODdWUkpXVm95YzhUVnlOM2UxWVdoRnlHSzRJbnptU1Uyd21NV0VWdGNO?=
 =?utf-8?B?TGlidzBpbGNxYWVMS3lJV2xXRHBDZWwyZTBIWXFyUmpla1MvbTlieGV5T0Zs?=
 =?utf-8?B?MGYyN1gxbXV4V0cxNVpGcllCUGcyd1o2UFQ1aFlUT2w5QVU4MTgrU2VvVmdU?=
 =?utf-8?B?K1VTcHhRN2M1WDFFajNiZjRacFFYclpiVHQ3dEkrZXN1NE9vVUlnK2tqUnVL?=
 =?utf-8?B?R090aWFaTHNleGFDNEcvbCtRK0NteTMrUUxVcG92S3U4eGo0bHI2aFRCYk9O?=
 =?utf-8?B?YlNud1dtdnVoZ0JxWTlzZS9SLzd2RTl5NzRUMFlqbFJQN252REh2eU4zV1Rl?=
 =?utf-8?B?N1JMbnZrdEQzVUYwWVJFeFpDVnByamdBWmJPY09IZUpMdW9CSHFydjkwUzdL?=
 =?utf-8?B?Y2dVSUU5U2JhQWhOblRXbUMvellVWUE3VEw2Y2FLRCtCT3NMU2dZaVc3eW1v?=
 =?utf-8?B?c25XekRnaGtJZ0dTRytVRFFoaUliSWNJbGlabjJkVEwybjI4bm5mQ0dBSVlF?=
 =?utf-8?B?UHdCMFFHZU9XQ2t3ZU9DUSt6ZTVjQUg0STZtYXAvcStkdjRNWm0rQTJCVXdz?=
 =?utf-8?B?WnRsNXRTVmt6akVybk1vMk5qWE5KWHBLRG04SWtYcW85RVEwa1YvUnB3cVJ4?=
 =?utf-8?B?ejM4RGZKS2dvNnNZTXREZ0ZlTHc1T1cyWjNEVFBrYjhDZ1pmVEozMkZ2bXFF?=
 =?utf-8?B?NkxXNE1LbTJYRmlSQno2R09RWEpHRXd5Ny9VbHovVlNXeExFeE9rTHNGTnh6?=
 =?utf-8?B?cmkxekdjU3pCNnp4MGRwUzB6dFJkdnc5OWVGa1JMSzRYa1dVZFpuaE12RjI2?=
 =?utf-8?B?b0oxcEhlN2NZdGthSnB5RXBZWVYyeTBTdXdzRHpBM04ycjNPeFlOeGlhSzJr?=
 =?utf-8?B?STAwYnRHdWxGVHZyYmFldz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB7080.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXlZOGZoTlFONlNnUnlTemtVUWZBNENjZkYrQTNQM2xoajR6RFYrTUNBNTJG?=
 =?utf-8?B?T2d3MzZTQXFyd2pVZHBIZWlBdmpIRjExT3VQVXRYQ3l3SEIyR1dyZXNMdnRW?=
 =?utf-8?B?cWVvbXk1cG1HN3ZaR0ZPRU8xYlVUQXlMakpPY3d3NWovV0V3OFhtNXdidWpF?=
 =?utf-8?B?bjJaKzVRbkQyUzhIbjVxSzc2aG8zNWs3Z0htSnNTVVRncENiZUlTaWZMT1Rr?=
 =?utf-8?B?Ym15QkZFa0VRU3hXTnlJODRlTXVOejhjUktOT3hTbXk1VEJYaW5jTS8zVnNN?=
 =?utf-8?B?dVQ4Vk1kRk5YcEJIblFPWm5ublZ1RGdQUE95TlhaaFoyYTlvNkRBYXQwUEZJ?=
 =?utf-8?B?YWhKQzFEVkhzMngxQUZQeWptSUVVRXVHYUxLL1JRTFJvMTNvUGIwTEFsdWR5?=
 =?utf-8?B?ZkVjbHZaamg2QmFudGxDOU1iYlVJSXQwK0k5cGlHTGdxelRlMW1ucDJnelZD?=
 =?utf-8?B?LzJSS25ZenVYd1hkNXF3a3Mvei9yVFVhZC93UW9jZ3ZoSGJmZUdBQkxUYVRz?=
 =?utf-8?B?MHBIb1hMR2VSbDBxR3BrdVhUQ1ZPNGxYSFdMcnJIb2hRMXF6ekZBSmlWb2Fm?=
 =?utf-8?B?Y0ZVL2srU1dtMUhmK1MyMnNTSm0wRnIzNlhiMG1DQ3RXSnJNRXpwSUtkQWpD?=
 =?utf-8?B?Nll3a0R5RDB3YkpzNGFLK0RMZXJYK0RBVzQzQllYejZLVGFCREM0aUtPWk1q?=
 =?utf-8?B?cW9Rdkk1RGpOSzJQUUswMGFBemZacWZkUUxBZ3ZrNkFUejEwTnNZblJ5S1NS?=
 =?utf-8?B?YnhoTUwwdElJRjZhOXBjQkhaZEZEQlI0Y2F6blE4NHZxOWo0V0Yra1lpYjJX?=
 =?utf-8?B?SkZKVTU2U0lwMy9iVGZpZjBOWXhGSkg4OCtnc1REb0srdlM1eGQzSFczaGd0?=
 =?utf-8?B?eGF4THdybEZPb25mNDdnWjBCL3g1aUFPb0lTZHp1Q3dtcnhpZzNnbFpja3do?=
 =?utf-8?B?Ukc4U0FSaXc4bGdyelZmUzJYbDBBc2FkUytscUo3dzZ4UjlWRDE0bm96QURX?=
 =?utf-8?B?YVQ0dGpXZ1RtTDNrT250VEV2cXZaNXNpZ0VOQW9SRW1xd2I4Z251QlFVZmQ0?=
 =?utf-8?B?aVVYNllPSXMyd2NhYmZqYTBMckxGQWVvNHFPb2xHaUxjRzE5NTFHVVpZVVZn?=
 =?utf-8?B?MGdUWnZsS005Q1NRdE9BWlJFQTJPNWJnMjJkSUpSLzhYMGY3cFlSZllibDl2?=
 =?utf-8?B?NGNIWndRQXdrUUlSbXdPNUlvdHkwNHNKTEFTcmozSENYOXFIdHNNd05RQnZ3?=
 =?utf-8?B?bkE0dGtFbm9jSXAyc0xGTGlNMVEwcHAzVXcvYnhwK2pkbW5vcFo1V2c0cGRv?=
 =?utf-8?B?NEpBTys2NFd6RHJ1MmhhMmZ1RWdHN2YxQnFab1o2T1FPWkIwODVsM3FMUFpi?=
 =?utf-8?B?eGFONjgycHZReHd1OThhazdpcjdJTHkzMEQxZmZscDUvcjlWYm94K1pEM0ha?=
 =?utf-8?B?eGF0bzdYN0dnMVUrMXQyVG5uUEcvVDhESTdUejNLVmprZGtQVDlFakdWRmFs?=
 =?utf-8?B?Y1pXMWF0eXpKZUJ2UXBhUTNqejc5SXd2SzVwTFJadDRGdStPQW44T21ocjdM?=
 =?utf-8?B?U1dqNFgxVmlGOTJEQi9lL3EyTXJJdDY1cXJKajZpSkR4b1RiREt4enEwc01i?=
 =?utf-8?B?MllUMGJ3aUgvQzVwOUVpWHc1QS9VYTJtL2dnalhySVlhMnpIcDVma3R2VVJN?=
 =?utf-8?B?dGtRZVdaenYwRHRneU1MU1J2ME1oMSs0WmFJdVFMbXFCV2hycDBIcDMzYlh6?=
 =?utf-8?B?NzBHVzFtMmZDemYzSVhHZGIyODRJRXJzSXhUZTQ2aXA4N21NaEZsZStLZUZC?=
 =?utf-8?B?WXpibHpjTDdzNnpyM1FjU2x5Wm5wYTFrNGRYTFZtWTlOMUdkdWpvb3ZoS1pD?=
 =?utf-8?B?VWtZZkQzRktDd3FWaVFqVnVGcUgxbVQrc2d3TWx2Yy9sWEIyeTlPd0JyZk91?=
 =?utf-8?B?VG9RTVp2cW1RRGlrRVRpQ3QxcGx1NjZyekd2VFRBR2JOUkdpaVVrSFNuL2lX?=
 =?utf-8?B?aFNzUnlxLzNvMnhTeWJ0cFBtSFJWaFlpMTRXOERaTGk0QmVkdUVQTWpVbjdL?=
 =?utf-8?B?V3d5b05YeEVEakM3TjQxODJyYUdySktMS3pjWkpkdlRNYVR6QnUweVc4aER0?=
 =?utf-8?B?UTltYlZRNHVUTmEvVnY2U0FFZjg2RjhLK1RkVE5WbDdGeGdXbnlyei9NOUZN?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	aTFHtj6GdXSeU5dl6yswcCHwhzjKIWvcdN1BZtOziH8jaQqJatOYNBWaO/idlXlxW4iHaJVqqlnYykccJP0FOLVt1a2iglTJYwZNpBRSDIbnc8v6A1IEA/CXaydJ6B0AUtjWC6z8eC2O1rkR4293wcpgiOQ1xCfRwuy58s627Sz0WhRZ4wq0cfBOP8kUPcDG5YpoTRc3QgVXnCsdzNP1we41EdEMpN2LM2Ye/YA2wrenFbWJIjIu6T4ZnaMQ8EsFUBFXFgK4IX+Iu30shF2Agyp0ElXXGkqzMPvOqqbJfk3tQlnAwaI+Fx3GhAjPJ4ipiWfx6L5pdKUlNhDAK9xFWWoURK5uT0Hzi6dF1lbxc/DWkxV+mjraLjQb+F7yBpI8lENdx57ynQOqxWlLZD+qeBMygcRLk/508A2bL7AAY28+xxafIO/LPmkT5YY5Ycp/ZgC92HrqeewKf85Kfibv4zjWjq/ZhND4m+xRhEJuREb1WmlucU2Z57ORaWWrH1qAMaCyUngKoZTPvQfg9pZkin2cL8xsQJM7osnkh/qtOJaoNWnMnSByZbvgSvMpWSGW1xbFv0ZhIafl3u5TGp4FU4sK+9S8DNDW8wZ/DyT7Lvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4b63ac-80c3-41ba-0ab3-08dc9a72da7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB7080.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 08:42:06.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /noVDRZcHVadtI1MsUIdnYVEcwp1sXOsMwCFRAPt7Us0dFiF7HneSIW3LlQYMFK0+wl3TWilyo9l9uWlUp6fvOJIPyfNK+mDMRey50T3MNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8084
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_05,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407020065
X-Proofpoint-GUID: UGKLLrv7gN2YZ2G9iui-LmU0-PEYO1BQ
X-Proofpoint-ORIG-GUID: UGKLLrv7gN2YZ2G9iui-LmU0-PEYO1BQ



On 7/2/24 1:27 PM, Xiu Jianfeng wrote:
> Introduce misc.peak to record the historical maximum usage of the
> resource, as in some scenarios the value of misc.max could be
> adjusted based on the peak usage of the resource.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kamalesh Babulal <kamalesh.babulal@oracle.com>

