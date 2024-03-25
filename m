Return-Path: <cgroups+bounces-2149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DB488A5ED
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 16:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5981F6309D
	for <lists+cgroups@lfdr.de>; Mon, 25 Mar 2024 15:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1664717C9;
	Mon, 25 Mar 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aiA/xXVQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ild1+mnQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C217F0;
	Mon, 25 Mar 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369731; cv=fail; b=WYq8YwOa2YemnabOi+POfbUyXr8xSKsiNLkf+f/r9JYsc54WhY1hq2Nk3YBdsw/NAsCoA/FM5lEfLfibiqBl3Ing8RngzUBOPL7rRT4DXHwrkx01lEYg2WXmg32Psj49ZDH60kFNaQp7PXTQTEeP3zLE7UZRs1wd66TzHw6Ap+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369731; c=relaxed/simple;
	bh=diO9d0/jotb/mCbUYUdNdyG0TwfegpwU6zcxpAyeKQE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eB5oAJwYZnEtAHYKnH7WZHsdSfix9t5Ik6uhq5EkzvzS6ndkBfMHdyngQ10t2xgwCTAXsH3ZKECDawCiJM7jk9EnvL24mnQ52Srfso4DsWPZu3zoxFFxI/gcpsrwzrfm1HFRmnrKZyc/Xomq3fI1LiQdXh8D6UETsLaqBASG6+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aiA/xXVQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ild1+mnQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PC3sA5010980;
	Mon, 25 Mar 2024 12:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=+1FoTt0FQ0xK3x3BwZoGMa9eCTrQwqH+fNsiESSKR/I=;
 b=aiA/xXVQut37ZsIk1f6P6E/BmrzTgBt87BXv8yfNR56WNVcM/K8AdnOa/qKYwpIpA7wh
 w1uMe9/R6kxiDqopuOpCsf2E8m5raFybFv9m0EFfZc0aNx4poeMVAUAhZ7o0K+NIIERw
 QCrcCMnKm476fajdMr3qGAernKWLtIQeR0ReCgFuCm6VhSqzl6bI4Sb+ff8xTwA2BMSE
 w3zr6h8lR4hKMpUoWsO6UftBbWpOmxXwryAhi+v6Jx8qAqLEyAYgpxI9bQmir8bk6npa
 psGn4vytP0ny0Q0Vmcvo0hym+Ao4JsUnevD5B1c50GrPcmNDcp40gP/Ig/MoWrQ9Pe+U Hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1ppujjx5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 12:28:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PA41S7024433;
	Mon, 25 Mar 2024 12:19:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbnbn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 12:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSQ49WfopUobfiMij2FU4oiEq6c/7gS/AQJ0S8yORJ8M9TLPbTMgVubFMM5DCyOMQ1PA+uraCZm43mgSnZAo42qC0CPoxChMUUojAhauytHbsLuhEdgA/B2kC9t7/8BNDT8DZv0y4Vep/TUoXpNpEj7pnLb36OqDiyRUb5jmSL4ZkRd5Dpe8B3he4jNsB0UCHaatnciT6Qd4EfA5VPyZ8SE8lupa9XQMkZbAqwwfbIXcnfN/rjZx0VIyLasGzOQVLfYEOg8gP9SAHeQzVgKKonm3HybPJ1NVt8T4EttsrVXNytBP16MXxBppzoiVfoRcg0iaFbAZx5yRa2deekdeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1FoTt0FQ0xK3x3BwZoGMa9eCTrQwqH+fNsiESSKR/I=;
 b=DQzsxQAvr69iX+5ilqEXPemG40QQVlWY98ZvH+sMl7TqFhjCFgb7fBi61gVsGGw6QQXk29myArxQioFGv3gyV+ZP/6hVyvy/2mU32/B28rx3sBzdJBg4Tsd3UEDHS45n56jxCFPQNpEATxlF30uz53qD/eajXn3jbq+aPoB9jWcfieAvD9zqi/jlvr0PTf0BNMyNdU1O1XCDYohUVFwTj8WN8fhFMh6e+3JOcU2zniWnwNAiaENygHW9TPI1TOUpwWDAYl+Wnykj646M/SyOeOwxtp+dl18dS20WACySm08/y4ppRRBoIwWrtig+csilEUZgSZxUSJgVq2ey+pD0sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1FoTt0FQ0xK3x3BwZoGMa9eCTrQwqH+fNsiESSKR/I=;
 b=ild1+mnQcguSBih0wqLEcdGZ6UrI9F7R2NoJQ5Z3vCOmQDvbrfp/HD8I3i6weWvq5LT17HGQ8U5zhiHQwcsOctm+3xJOdDfdiQGkELhowIPZ1qa/L1Rhyl6ColhkSmOn2tKs1beI5lTZuWF2Ahm3cGCJpIPeTkdyNVKl+itbZq0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 12:19:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 12:19:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] blk-throttle: Fix W=1 build issue in tg_prfill_limit()
Date: Mon, 25 Mar 2024 12:19:05 +0000
Message-Id: <20240325121905.2869271-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1902d5c4-ade3-44f4-75d6-08dc4cc5caa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wvhZ++G7WB3Op+EF9+w05uS8kw/yj2gCwcFSX0XsLHa1v2/1sl0JdBv+KN+4Xk+sJhcDm3vrlkHMY4frWQc5bxKyrM7iMqdjeo4CpCfiEuRePq7A8sjuEwQ8bgQrFeP7CTmWZXUELycbCEr+Tg62GsgUeU/C38jM/Pyn8h/X00voHeRmiVDrJp9Ei/B5MZpkxn1fGcTNHMDNU95rIHU/z4F1cXbmBJXNqKodorLu2FnlFswuHlC0rZhhT8XJ4IRRa6ZZNLXFRn7xAfPVJi6qJlCyavvKjcj85pozypj1bmQsgCTuLLhwvD2dv07873d2tnzCwUxbxHs0Y9YWzYmraoiq04pezLhUORWyEuiGbslUs2hGfoJNY5nzbBxMPAnsi90CN9MQvuZ6VL3qoKxzKsaVsOJQhrEpnhSz62YdZyLno1rhQXHH7d+0D7d10EwDE6VGSsi1shQHfEE3Y5P30TXfa4BKVQYJlM4uyTqrqOx8zy5qmF+Njmvz+yJ3MLHuBB8CV7KpoQJs3yoyDlSJDyvdAWeLLqEVicBrC263f/p7NHn4fipWeII+e8KDQsSXSXS+YanbgP9CGd5vKWJxgXBZBkts/IIyc3cow5p1cbXM7Ve1RcB/AD/uhC98gMJTOY4f27+cmuUV1yFlzveAR6RSWy1YEKRcTiDOLa5YGjw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sk54SWNSZXZmUDhXREFXeVdDdGJXa3NoZHd2L1RZZndZY3M0SGhxcU1FZ2hM?=
 =?utf-8?B?VDlnb2IxRXZmM3pOLzhHUW5WM01HRG1mY3FhZDZ2ODM3bU9JNm1EbGdmVG9r?=
 =?utf-8?B?MFdSU1ZyWWd5UmRmY05EYkJKcWRwUGVGSjBhQUtSSXhOL1dRVEExM1pZM05R?=
 =?utf-8?B?QXczQkN0d1BnL3dLUTZxSDBwOEtGa2lpclRwVGo4cEd6dnQ3UE95cVhWRlcz?=
 =?utf-8?B?b25YdGNMWFFUSlQrNXVWcWhwRjVWblhEQ0g5SVQzWGZUYlBZb3A1YlFUK1BD?=
 =?utf-8?B?THo0Z3FFZWRWL3J5ajIvUUhBZm9ybHZaNktqQjFFUy9ieWp0Q1Y4a1ZpOEY5?=
 =?utf-8?B?bmVSY2RhSlgrZlMwMUlEV1FyRGVBYVpETzRzMi9WQk5qOXJyQlIydCs0L3hi?=
 =?utf-8?B?UzZVWForOGNLSHl4N3VmV3dmZkpUSTdPS1MxdlkvRUk4bGJLeldtMUx6K0Vl?=
 =?utf-8?B?ZlcwRlpDbVd5SDhPMkd5MHVGUWZNai9sM0g3L0ZyQWdmYlNjazZhaVh2WWRS?=
 =?utf-8?B?b25LaU9SZ0EyYURwWHhGV3NYdzg0cEtZVjdLYk1lTXVGR2xSRkVibDhQc1Rh?=
 =?utf-8?B?cXhTY3R0c0xBVjJob3UySVlKc3NvUklYdzhHRFMrS0xwWU9VWXdvY3REN1Ra?=
 =?utf-8?B?Y3NKQTZXVkMraGQya1BQRW1LVzM3STFjQWdNWElIM0dyb2tFS25WSUFNRDcr?=
 =?utf-8?B?S09HVzB1cGtHb3NqTXdmWW93TVhUSlFiR2lCaE9xTzZlbDhKbFA3V1ZJMUJw?=
 =?utf-8?B?ZGp6S3JuL3ZRTmV0WlpQbW5saVpuUzkxKzlGRzd5YUhCZWZ6aEltMnlCeFZx?=
 =?utf-8?B?T3BJWUt6ZEFIYURZejdBTEwwRmRZV2RPSUN0ZFJhcjFOUmEzNEpzMmJ2OTds?=
 =?utf-8?B?LzFIZVBIWExTU0RPL2JzV1NzREVOdzRDM1h2Wk8rY3BmdHFMSDFlQW5BQzYx?=
 =?utf-8?B?TmtxZ3lDb0dtZlNXUlhEeTY5c3hPQmFBdVVjaHRvZDFIbUk5cUtEZnZkemZp?=
 =?utf-8?B?Y1BsTzhsL21lTGdPSng4WDZPTncvQ29TdkY4eUtVcjdRSHQycHdiTG5SMzNn?=
 =?utf-8?B?dVdDNDdudUNsSHdHd05XbFFaVFpPbFVWb3V3SUJJVlc0WUN0aG40WkdldjBk?=
 =?utf-8?B?bm1jY2hhL2lRT0dyWWd0Z1BSMTdweE94YjlrdXgrVTlyZ2hDME9NaUkrRTRC?=
 =?utf-8?B?bWkxVlhkbE1RZjRsbExFZXBmWkh1YjV6NXJNT29iSHFjT0YzdHdSSFl4WGZa?=
 =?utf-8?B?VHREZm94b3ozQlNIQXo0MHZiUlJiQjFaTGlOYVpmU2R5RkYrelM3UG5UOGUw?=
 =?utf-8?B?MEJBMFFrSjFUTFZIcGRpKytQbzI1LzF1VXptTjcwbndnUldrRGFCb2FZaEVS?=
 =?utf-8?B?a2w0ZG1ka2hQZnU4K0pxZ2tZOGNXZ2xja0FNL0FhbUhCVTFGcVhHd01YbFA2?=
 =?utf-8?B?MTIxQ0lFaTVSNzJaYTRkb2JJOGhEeDdHaCtKRUplbnd4bVk1dnRVWGxLUzh0?=
 =?utf-8?B?emRVZU03VnRobXg5RXBMUWI4MEJXb0RkQXJqODNIRVlWYVppN1JJRXkrbnp3?=
 =?utf-8?B?N0kxNE9WNnpCL0RJYlZrTDllSkQ1dkl1OU9IR0tzcCtDUVhmKzc3VEdvcitQ?=
 =?utf-8?B?Vy8rbmhlYlF4NVFPb2toTVplWFg5ZUNQUzVhdlVNaFcwUloweGdLOEU3KzVt?=
 =?utf-8?B?dTdBOU9PUzc2OThmYll2ZHVWcUVPOWV0MFhCK2dnZXNwbGJLU0pIL0dNWE9Q?=
 =?utf-8?B?VXIrSUgyR0kyY3Rwb29XT3hpemxSRS80YUVhYTh0Q2JNLzhnbERJZTZ1VHY5?=
 =?utf-8?B?OG1kc3ltOHZ3YVBpSjZNdFRFTWlwSTJodG9QeVZNYUVteHZ2MjVxdWl1UG1R?=
 =?utf-8?B?SHovQmJzM0VIL0ExKzFTSVl1SEVkRGdVWkpCYlBIaExTZ2FwSlpYSE91Z0NP?=
 =?utf-8?B?YXNENnoraGNIaWZTYnhSd0RwYmhZSHh4c3VldUFhNGsrVU9tb3cyVjFWMDJp?=
 =?utf-8?B?N25xSGNLeUZ5SGliQUttbWxkd2N0UGx5dExsOTBacUZjSmJXSjZENHVqajRE?=
 =?utf-8?B?bTZGMnA5NnlSSFNJczM5b1RONS9HdStqa2U3a1UyOUZOZDU4U01vMjkydk1Q?=
 =?utf-8?B?Zjl2K0pTbldCYU9rVlhMVDA5cThUSzRxZ1hQbUwwTkxvRithakhCYTBkd0Zk?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	c+QjDmUjJWlglGbIsd1spJzsQb/12bvRyxOXriZ4nD7XoQo9eJ6XU0vr5YkkMHL2DsQG+GNA2iFFqlxbm2RvGdQIwulwAoyWGfpt75n8jrXSpengAXHXAyJ2geQQS15JPqmbvjyTK/uqQjb9iXNm4vuPTQLgpownlvPcIkrba3Pd8ZWSV8jlie3K3FIP8Do4+y72E8rpPIjU6Jcd4ceLg5qHGbDM1gS2uWyv05QtLufwScY1Vq6LT3uMsRSJY0rFTgFhTvhb4rXmFzePj3cb/d+EMH+SO/4Uo81ikU3uMoWK9onxkxQjVaFIKmlj6OKGfn7ayxDoIN7jsRMYCP4VYMwNYgBX7xghL9NcFYtr71v+LWm0B9OFNNmAjombsG+HFyju01RHKsRAFAAJoeSygJ63TU1hEDsNncG32byQei2KNLDWvqlO3sFW5mQ7hPuTFuFAph+bAeia+Dr/BtmOn8T5G5zR0FQZOHZeBgGvxMfXeKmpHCd9ekF2XuaBoIqL5FAjQNBb/EuiNXWAeUOPD74YOaCdEPNFxPkgFL+K3QQcNppJ+/Y/1PL82AkUVXFzhpwoHRkMN0LGGBkh6YWtobF37P3ekbz68eCwPzsAVR4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1902d5c4-ade3-44f4-75d6-08dc4cc5caa8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 12:19:17.3172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRiZRMYCFYLxMQHzdkfYb5WYf/otKh9GJzdSXM2sfgT8blTpcq93exRP+EQx9L8cKje9t8aO8RJc7iulNXNo/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2403210000
 definitions=main-2403250068
X-Proofpoint-ORIG-GUID: nxW327ws_9KmTUd6t1nJuDl98knfdqZB
X-Proofpoint-GUID: nxW327ws_9KmTUd6t1nJuDl98knfdqZB

For when using gcc 8 and above, the following warnings can be seen when
compiling blk-throttle.c with W=1:

block/blk-throttle.c: In function ‘tg_prfill_limit’:
block/blk-throttle.c:1539:53: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
    snprintf(idle_time, sizeof(idle_time), " idle=%lu",
                                                     ^
block/blk-throttle.c:1539:4: note: ‘snprintf’ output between 8 and 27 bytes into a destination of size 26
    snprintf(idle_time, sizeof(idle_time), " idle=%lu",
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     tg->idletime_threshold_conf);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
block/blk-throttle.c:1546:15: error: ‘%lu’ directive output may be truncated writing between 1 and 20 bytes into a region of size 17 [-Werror=format-truncation=]
     " latency=%lu", tg->latency_target_conf);
               ^~~
block/blk-throttle.c:1546:5: note: directive argument in the range [0, 18446744073709551614]
     " latency=%lu", tg->latency_target_conf);
     ^~~~~~~~~~~~~~
block/blk-throttle.c:1545:4: note: ‘snprintf’ output between 11 and 30 bytes into a destination of size 26
    snprintf(latency_time, sizeof(latency_time),
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     " latency=%lu", tg->latency_target_conf);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [scripts/Makefile.build:244: block/blk-throttle.o] Error 1

Increase idle_time[] and latency_time[] sizes to clear the warnings.

Fixes: ec80991d6fc2c ("blk-throttle: add interface for per-cgroup target latency")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index f4850a6f860b..ece272937792 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1497,8 +1497,8 @@ static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
 	char bufs[4][21] = { "max", "max", "max", "max" };
 	u64 bps_dft;
 	unsigned int iops_dft;
-	char idle_time[26] = "";
-	char latency_time[26] = "";
+	char idle_time[27] = "";
+	char latency_time[30] = "";
 
 	if (!dname)
 		return 0;
-- 
2.31.1


