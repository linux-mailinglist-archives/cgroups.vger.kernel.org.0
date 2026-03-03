Return-Path: <cgroups+bounces-14560-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMKjMk3qpmnjZgAAu9opvQ
	(envelope-from <cgroups+bounces-14560-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:03:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D47C91F0FE7
	for <lists+cgroups@lfdr.de>; Tue, 03 Mar 2026 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 294913001FA7
	for <lists+cgroups@lfdr.de>; Tue,  3 Mar 2026 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9035F5F4;
	Tue,  3 Mar 2026 13:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J7ot4P4j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MVht0fih"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0183F31E833
	for <cgroups@vger.kernel.org>; Tue,  3 Mar 2026 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772546284; cv=fail; b=N/uJtaG/lZjQn0HWop+mcJdSMCXl94hvuQtJbAnsWOHzSmI4hkCPSNfoJLpEAV7rR2OVEqQAWc75xL4+P1YHLfjhNmXdA+Fve15Tc44MKfiU8gjejx9vsF2TpWN3nHdhaWO+DatrsMjh6OTSbqtLkWOh9G65J+0FyZUvAw064XM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772546284; c=relaxed/simple;
	bh=QiHPfXX8+h98Gy7+buxDk35BHeHvZtAIQmIhWU9Il3g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f1YRj5QU5rhI91Cm4vNnj9IL3Ize+eKbYd8Rode2lz7v5Quhm79qcxiRM8MyeDnFR3GQpE4Fm7AWnQ/wz2GsmJbJL9hYh/aCMnYAZ4yUMvGe8P2WnpgYjS1lpSWHcSx75osIMroQuhTQHstDrkdi9WBdzfc/mj0JvhQ0Abjwy90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J7ot4P4j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MVht0fih; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623DquM61765592;
	Tue, 3 Mar 2026 13:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=9XijlStc+p75aS+E
	AovrKNV5fiumnDPeKarvjzJPY8E=; b=J7ot4P4jd1rp77LOiCalKuESSnVw+oLB
	2Yy8iWjJzZx70E5GI3Spm/j7YWH+BDviyLWtERUKhNmwqqphMNFjNcbpiZ5L53To
	4MqHNcS5EAqUBDm8eJCLVRPOiq+F9TEs/DDETEPgfNQcvfAANSnUCKJOKGLdouYR
	pWQAtLC4e8ODmy/628NVLqXWa2pJs10EOg6qbqlOmmw7wJtzOXqofdQ2xZbonrch
	505BBDBNwznq8h6TqLSW8bH68hF5W7qon6UYx8iFLa/Mm2pD3Oj+pP0PjCA+Vr1X
	yNlD5QWNu9lMwvIDeBbF2tFimSu3cGzb/0xr3YDNTWNe4RMahsLObg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cp0wvg0aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 13:57:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 623Bs4Bn026747;
	Tue, 3 Mar 2026 13:57:39 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpta3j8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 13:57:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJYjNOX78ipN/zjrvpWVQ1OOBswU8e3Y6JIbVslZCQ5SCMPsPMlKXVxxkHjk+6pb8EYtrgxxnhjEQf5Ko7800gV2E+hP4HNPZzZ25N6N1/P9qUg6IqI+d5byQXP6yM4UmW26uc6z2LJLRxHSJGc9qHL/hA235+phqLcm+5JqNt+DK4qclCpVpkGKVTRQE7KjwyaIz48ihjU3AiDwgTlqepq1/i7cVhqpMyOrOCgHxLPd2a9QJpwBQ+rZPs6gEX7WYChL/fGO3dKSRruayIim0bQ3thbvQ0LLW0kl8uYOf5AzHfJ/QfKP1acoHBgYZ7020A6Ve0A2cuf4AS3Rzcjfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XijlStc+p75aS+EAovrKNV5fiumnDPeKarvjzJPY8E=;
 b=Un2BptboJ5slJ41/VjZL/EhfWVbJAmdTK1IuVkDnQ/VnO2Pf5MCimteK0lFvlT91X8NAb4Z0aWQ08wol/v4sGnUxeDSr94Hps5dRy7/U6k2Da5MnnDUFhs+JeVKRs+UzNtZ/NYETZ3mqGAtBEfpuu47sx9sYDX7jBs3bd87uYqZ3vch+ZP9lPEswyYTgDCuCXt656bdvt8NOSn831BpXpK0+ZKjadZEBas+YFVp2VpXajOQmyqTrHbwLEiiDWm0VTqnVZUzeePH0/7qNwmqEk7pcMRNuuCjwlNu+Mnuvr+GA4MODUE9FWqMOp0NFdKN915Ws7EtjUkY0sutlY8+M3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XijlStc+p75aS+EAovrKNV5fiumnDPeKarvjzJPY8E=;
 b=MVht0fih7SmgfGRpw7sxkhpP0f06qW2P3a6QWzXk7ysndRKCmUs1fbjvExgwNEdkmixI1pxmkfWphgwBiVorXWAE6ZZKJruJNhsCN1LK/lpgD9kkruQThqbszAUYRkfyILOpBF4mh8DtdijqG8GH3q3gi0Ht7hVmpvdKrRFunCc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6172.namprd10.prod.outlook.com (2603:10b6:208:3a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 13:57:34 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 13:57:34 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: vbabka@suse.cz, harry.yoo@oracle.com, akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org, cl@gentwo.org, hannes@cmpxchg.org,
        hao.li@linux.dev, linux-mm@kvack.org, mhocko@kernel.org,
        muchun.song@linux.dev, rientjes@google.com, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, surenb@google.com, venkat88@linux.ibm.com,
        pfalcato@suse.de
Subject: [PATCH] mm/slab: change stride type from unsigned short to unsigned int
Date: Tue,  3 Mar 2026 22:57:22 +0900
Message-ID: <20260303135722.2680521-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 76860c6a-b536-4b5c-74a4-08de792cd1da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	VVFZWhcpXmgBZXWeKy0rxDt7BV3j2qug7hYCMydjiTFRj5lsjnCyBZ+iRhExggCFOJyGX84QqQl4JCjm7+22f6qQ8hIa1atry5BlLr92TE5PfYpWH82WzAPc2FJ3YCRj2b/4tHcm4cnRMqsDJE3gJ8bRS1sYGsW07fzfvcSouOb2Lt+uVuQv7BsI2dAVSunuuTRqhgBolWhJrwTMBKnPDxe2RK3e6IVFNCZXAMYODvk3IxrD+vhdLqHEYqg2OXS9TZmpeLF6CJPo9gDZ5cfxVofEYxDxoTub/SpEgellsofYbdkNkEf/NeOwgPWT3iAXDp8myzFPzUVj2vbMWA6pkS9sArGIcGldDsg3XUFoRIz9Tjv+zOVm92PQ2oHLuXDd1AmeeukZEUWf15svdMD3Uwh1XHpyOkPagmDE+VDS2aQ+cmDG6uRmvAQZbweTXlBpxvITGJArTpskgrDdKqAuWx2HtSy/tRiS2MJVlmoUGzcSqdmi4OhX8O54fZPpr3bxabf8LEAMhGTNc5JmBgIDt9cwMTS73LnDE3Kge+xHQP3W2bYYIR0oozJ3LabuUXjud/iy1kuae4h/jMFjqDc+MUJTeNdycCDLH3dlPx8wlWt+U5Cjp7/TEfGj7uDWudMO00e+NMnlkU9UjiYnzPgvdSnUyobyAhgmMfTvRc/+h9hkc1b0pVnzuMBqkF/KQdEe2Ku6qXIFSivVQfQd7dFPkvRfp1wTtU1rlaleqVNbEcf+uowJQCPiOtBkZ7+mnfDl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtjfR5EcycX9y8tFbHuPstv3u5trO0a1EqGWN/4ebCj+QfTT5ZX8BlaU6iq8?=
 =?us-ascii?Q?xAuc1gXSla72g7AkqNZ3Zfh4ibx/JnVz6qWqDqTR2PWWtwIuyew3Xq11XRYI?=
 =?us-ascii?Q?cxFk3yeUmlNkocH29oY2jkStLkjAOjFMEbrJKFZDqqalGslAc36KcDGd1mmA?=
 =?us-ascii?Q?TI2fVEDCjpiyvYNj78R78uaI/rcMVEHNxlRiRIc9Ae/19kQW1ERaMHMDzVZa?=
 =?us-ascii?Q?6DqkElqOBVWpv7p8prlIZn744OGloJGezYvQhfE1x0ZObRJWhfohAYMkFpAI?=
 =?us-ascii?Q?X9+TCokY63XJ0cOvgccRmlLlxJbZYYqeNlB1qUNNDxqfnVchTB7nQmDDaj5T?=
 =?us-ascii?Q?0kw61L0Ur53jS6S037RweF9huiLRQRQUxrVnYu1wTIdt4EIanJXIQyhhlFQv?=
 =?us-ascii?Q?vFrJKQKxkT2W0eoAp52IDV8BlxurkS3+wcKkSXq856/GKz4IxgXs981VPGE0?=
 =?us-ascii?Q?y63DHH60yGXTjqpoT7dKewaSXrZWcGEhSqDsL5kryDg6AZunwo3z71Vujbdf?=
 =?us-ascii?Q?hVv+DUApsJmfVN9syQ9sR70Zb+OKGgP55pSX72muaO7U/+QEJ+zo0r7yMOVS?=
 =?us-ascii?Q?VDeV73v64n7G5D7RHhRnSfltCv9cPkn6SgCwmGT0rV23neG/lhccPnBEsCCK?=
 =?us-ascii?Q?CYkLZW7+3GbDVvXjhhrV2NB9o1bZPac9GOJNwQubzn7RCd3EIN9uWOYUpqiB?=
 =?us-ascii?Q?CyBKQVpMHm/w8rpjYGZuZKLyBEtqdlxPI6ehQsdaXw3+fBw/IxqoJP9KVy9k?=
 =?us-ascii?Q?Do0oF0PJTgV8ElCWO8ryhZEIrn3nT4/uzrbW3YOxARP2zSgONr+MaCeyDMAM?=
 =?us-ascii?Q?pL5HFI3VIyMrnOoashBHZbMFTjtOQvHKwCQtymDLBKlRIeMLKe2r8ezTJhQy?=
 =?us-ascii?Q?P3mPTm0YzuAv/OJRl/oNYxGF41gEJ0GNh6+AWAe7ZM8gdWJqZEBScP1mZI3H?=
 =?us-ascii?Q?EXiC8uNjJyFtBljJv6DS8P1ydhaLTmhXKw8GWMV8XVMSNSV/FLsxOsmszA0G?=
 =?us-ascii?Q?t/zQCPI93fB5pHeSsm4NIpk6gv1FT10RSiQgb53uACD+q+AeGxBTi5KvYBsA?=
 =?us-ascii?Q?te0ZuGQZfGOyAs8N0G1rbsQjdxTUvRTEDJNi5MRIY9uXnPTUaQmz4qi7vEcs?=
 =?us-ascii?Q?CqgGmdMU1y3Y1oQnq4peH4jC3TFv0RWUMVs/JBQSCmd5k57LJqgTGEoqoJdG?=
 =?us-ascii?Q?6G0tOzOouV3RpD9rbK0+CSwzGCa5NgzA7/Y+/mnvYCaTjuS2LzNtrmNkKHai?=
 =?us-ascii?Q?jJHaKxK5byzpn3yyE2cEz7gV7YFyeuk5lQxp/+RW6fFCRLbPAgnYpxSPIXSB?=
 =?us-ascii?Q?zjnp9saFgO+AL16e2MmGiylpBtWEH5W7SYbyk+VvAyZLfBFeUTxlpd8IcxHS?=
 =?us-ascii?Q?Z6ZfkxjNKLTk/2fnGK8uaRVckoZ/WkzQfXnRIUtGXCGwwGorQQv0W4riDk5J?=
 =?us-ascii?Q?zsvVXk0kONmDDc3FAbcTEnvvUrvJlFP6ZWVq+ogwvDRTNz6dwttbQw7erqs/?=
 =?us-ascii?Q?G9zsGi45hjNU+uESV7v0lsE2kvcNs8zIYh7OHKRCWiEqoJWYjnO1b7OqPbmZ?=
 =?us-ascii?Q?+Z0C9BodRV4iqsUr1boMqLv8QS7ilf9QCHelatn1COjcWJTVzE4dR7KW13Nw?=
 =?us-ascii?Q?P3jN+EXWWjGtB9oo9wNSBP6jTQYnBfDYVFpGCP0w8jLIqq+HsGSndFx5/XeV?=
 =?us-ascii?Q?uU2pJK6wglOk8VUBMqFOYB51BLexpj3zx4hzgLGw2X9l0wmBR07KXXG0NetP?=
 =?us-ascii?Q?suE7voOYnQ=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	iKphfTNX27Z+NPTb/EBZP3Htdj74iPwfMlVPeYkSASyCpjNsfCU+zuDdNc7nwReY0k1VbijPxrRsNMdylTDWzbdqyXqytwJ3Qxt5B0s5vlPcHi8314suNTb24xewGLkXliF8YTqYw/e6clX1XLi9o/+T8tQZP+vtJCFw3QYaq7n1b5CPXn8VepvSAa6ee2nhbFU1vVJlJcPkJCmpsmiKm9pNv2C88J8eO5ghxDQGMuyPcVDflGTO95Bea51QySS2tqVNUt1dlop6YugL21uwALEBRiurNRXFIfKIS+y5YqN5DpgXlO84JskYO2hm5em39UHH+frnn1tQHgf63DVgBA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PK79KRrfcdEVZ92XyplnsGcIlpdmUb3UsKdlO/qdNvCmH1mZytE1645OmmL/3wy7AXShBcPT1wnHg6I02+ZpgQf6KG9xOv63OwVa0i0/EZc+7Ex8BEBypH18IxdJEHG8f2Ox6/yAJc/sgse2Tef000zdz0zIoFFWSY1E5XMphRVkfJQwA3oK6QuCuBC4ANZBeHNdJCyVMKUQWi7tsUJm3U31/Z6DHlLjR+71P8ZT3Ho4CRFa6YbAQjB0fIvHHiZ4kYJ+T4KbQzmmjHN88spJvnqW6nVlKAV1oh8cYEd9B0tduZ7sXg8RjV8QIzHoVnZEc7y4pbjc3lPAe7gSPtJvEAgTuq5AsGBunHVn1WRL0xMeIewc48UTL1ttcMXrapIn9nmDwgw3TkIrq9VRyrjXcYKIbTF8lX9tpHM88y3JKia4GOhh7sAFN2It/nepwIh6s0fBQ6+ZEL0awdQADAYkcoVhWbfWUdWmtNEHRBSd1pClubeVfHArgTn001YdLUfd0oQukyt2OJWbtPS4c1SpVK0Y/FSXZBgMcZb44rlW5teBdw9o/LL2Tnae7sbLW9MkbN2KsoVBbb2Ca+WPnjPgMnzY05C/3jnzI0hVCkYJCGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76860c6a-b536-4b5c-74a4-08de792cd1da
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 13:57:34.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fc1+U1wcMWmIDK8OcQbY33DhbLjX2d4b6um/OdDvkEdy2ZsXMJdXcimdb5gT1LdYXeswvhug9EONGBOugQZlIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6172
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603030110
X-Authority-Analysis: v=2.4 cv=WIdyn3sR c=1 sm=1 tr=0 ts=69a6e8d4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
 a=zwTiArdrw5g1_wk7WeAA:9
X-Proofpoint-ORIG-GUID: Q2WWPEaAe04fcccFe_Cn_UAqy2k6yBWT
X-Proofpoint-GUID: Q2WWPEaAe04fcccFe_Cn_UAqy2k6yBWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDExMCBTYWx0ZWRfX553SpbCszWvr
 30Ud/P6AdbFlUM5WVcQX/GXXElEB1lLuvRrIL+3URlD2YlxSt/mDkG0UkN/g5abT7bLNLhF34zu
 6Dr9JqqpjgFqRvdwXsoJjfPA3T11KJBmYTAZgJMQU61MEanQq8eJVV/f6ZX++EplmoP42kC6oqo
 bR+L3EGZWPDl/01byaSq9ZyPmsT87SQPla/PkQAOtgbkTlzF3EGICIWtfhG7DTAzKHNmnF1Yjv+
 osQkH2x8m3DNWn8z4nvfFqkEG3mtGT5fb/m2QyROim5kefIri8NDl31tMH/CxXacGw5bK+BSZvP
 hJOsFwmlghcILZ7Mh750/1lHbZL0p6cNFoj/AuM/RkfT2t796EkClQ81lIoNNHkAHvI+twPaKMO
 BcsiLCejnBqrG7hg+qdef2HRLAW4RGHIYkZkvCv6zujtSw8hd5i2MssQm1j3FQ+fXwhotdwBHx5
 2VlIFqp/fpfo9+WEmGg==
X-Rspamd-Queue-Id: D47C91F0FE7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14560-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:dkim,oracle.com:email,oracle.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Commit 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
defined the type of slab->stride as unsigned short, because the author
initially planned to store stride within the lower 16 bits of the
page_type field, but later stored it in unused bits in the counters
field instead.

However, the idea of having only 2-byte stride turned out to be a
serious mistake. On systems with 64k pages, order-1 pages are 128k,
which is larger than USHRT_MAX. It triggers a debug warning because
s->size is 128k while stride, truncated to 2 bytes, becomes zero:

  ------------[ cut here ]------------
  Warning! stride (0) != s->size (131072)
  WARNING: mm/slub.c:2231 at alloc_slab_obj_exts_early.constprop.0+0x524/0x534, CPU#6: systemd-sysctl/307
  Modules linked in:
  CPU: 6 UID: 0 PID: 307 Comm: systemd-sysctl Not tainted 7.0.0-rc1+ #6 PREEMPTLAZY
  Hardware name: IBM,9009-22A POWER9 (architected) 0x4e0202 0xf000005 of:IBM,FW950.E0 (VL950_179) hv:phyp pSeries
  NIP:  c0000000008a9ac0 LR: c0000000008a9abc CTR: 0000000000000000
  REGS: c0000000141f7390 TRAP: 0700   Not tainted  (7.0.0-rc1+)
  MSR:  8000000000029033 <SF,EE,ME,IR,DR,RI,LE>  CR: 28004400  XER: 00000005
  CFAR: c000000000279318 IRQMASK: 0
  GPR00: c0000000008a9abc c0000000141f7630 c00000000252a300 c00000001427b200
  GPR04: 0000000000000004 0000000000000000 c000000000278fd0 0000000000000000
  GPR08: fffffffffffe0000 0000000000000000 0000000000000000 0000000022004400
  GPR12: c000000000f644b0 c000000017ff8f00 0000000000000000 0000000000000000
  GPR16: 0000000000000000 c0000000141f7aa0 0000000000000000 c0000000141f7a88
  GPR20: 0000000000000000 0000000000400cc0 ffffffffffffffff c00000001427b180
  GPR24: 0000000000000004 00000000000c0cc0 c000000004e89a20 c00000005de90011
  GPR28: 0000000000010010 c00000005df00000 c000000006017f80 c00c000000177a00
  NIP [c0000000008a9ac0] alloc_slab_obj_exts_early.constprop.0+0x524/0x534
  LR [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534
  Call Trace:
  [c0000000141f7630] [c0000000008a9abc] alloc_slab_obj_exts_early.constprop.0+0x520/0x534 (unreliable)
  [c0000000141f76c0] [c0000000008aafbc] allocate_slab+0x154/0x94c
  [c0000000141f7760] [c0000000008b41c0] refill_objects+0x124/0x16c
  [c0000000141f77c0] [c0000000008b4be0] __pcs_replace_empty_main+0x2b0/0x444
  [c0000000141f7810] [c0000000008b9600] __kvmalloc_node_noprof+0x840/0x914
  [c0000000141f7900] [c000000000a3dd40] seq_read_iter+0x60c/0xb00
  [c0000000141f7a10] [c000000000b36b24] proc_reg_read_iter+0x154/0x1fc
  [c0000000141f7a50] [c0000000009cee7c] vfs_read+0x39c/0x4e4
  [c0000000141f7b30] [c0000000009d0214] ksys_read+0x9c/0x180
  [c0000000141f7b90] [c00000000003a8d0] system_call_exception+0x1e0/0x4b0
  [c0000000141f7e50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

This leads to slab_obj_ext() returning the first slabobj_ext or all
objects and confuses the reference counting of object cgroups [1] and
memory (un)charging for memory cgroups [2].

Fortunately, the counters field has 32 unused bits instead of 16
on 64-bit CPUs, which is wide enough to hold any value of s->size.
Change the type to unsigned int.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: https://lore.kernel.org/lkml/ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com [1]
Closes: https://lore.kernel.org/all/ddff7c7d-c0c3-4780-808f-9a83268bbf0c@linux.ibm.com [2]
Fixes: 7a8e71bc619d ("mm/slab: use stride to access slabobj_ext")
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

Hi Venkat, could you please test this on top of 7.0-rc2 (instead of
7.0-rc1) and see if the bugs [1] [2] are reproduced on your machine?

I reproduced a debug warning on a ppc machine and fixed it.
The bugs are expected to be resolved by this fix.

p.s. After more debugging, I saw stride appeared as 0 even on the CPU
that wrote it, which likely rules out a memory ordering issue...
and I discovered this while decoding ppc assembly suspecting memory
corruption or a compiler bug, which came down to:
  
    "Hmm... why is the size truncated to 2 bytes?... OH WAIT!"

 mm/slab.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index f6ef862b60ef..e9ab292acd22 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -59,7 +59,7 @@ struct freelist_counters {
 					 * to save memory. In case ->stride field is not available,
 					 * such optimizations are disabled.
 					 */
-					unsigned short stride;
+					unsigned int stride;
 #endif
 				};
 			};
@@ -559,20 +559,20 @@ static inline void put_slab_obj_exts(unsigned long obj_exts)
 }
 
 #ifdef CONFIG_64BIT
-static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+static inline void slab_set_stride(struct slab *slab, unsigned int stride)
 {
 	slab->stride = stride;
 }
-static inline unsigned short slab_get_stride(struct slab *slab)
+static inline unsigned int slab_get_stride(struct slab *slab)
 {
 	return slab->stride;
 }
 #else
-static inline void slab_set_stride(struct slab *slab, unsigned short stride)
+static inline void slab_set_stride(struct slab *slab, unsigned int stride)
 {
 	VM_WARN_ON_ONCE(stride != sizeof(struct slabobj_ext));
 }
-static inline unsigned short slab_get_stride(struct slab *slab)
+static inline unsigned int slab_get_stride(struct slab *slab)
 {
 	return sizeof(struct slabobj_ext);
 }
-- 
2.43.0


