Return-Path: <cgroups+bounces-2167-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA888C612
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 15:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E741F6258C
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 14:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5926213C69D;
	Tue, 26 Mar 2024 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fziBlWhQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RKnjArUe"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584913C695;
	Tue, 26 Mar 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465080; cv=fail; b=C0aSSDCYl3L0UwJH5qr5uG2ctfvQ+M3TtaOtTljHe+RIo3vfw9NqkznhTh4AmFklRDJKkewkMf7NVt8AkJyr6C6JlMy0/yIYaNcFFr3g+kQ0S9t55D7WOXgrGl/wfLoZbA9b217e9kZc1/heZ3Mx6Rjm2MnO1dNESa+USV3JBI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465080; c=relaxed/simple;
	bh=hwXJ7zqydBqLOSH5Eb4Xz7n/BY+97MuxJO5B6sA9Ehc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Tx7SaWQwbfZg7oKq1moTuIpG0q5pF7rQ2xGtjvEgsnN6MWQ/zbFJTBtAtisRNwKi1mMjKQSupbA9BEpfNfPgGAcByBGz5inIgEEkSTEtdmd3Ec7ALe9lCSl7lND8rOxW2qEFbJ8vr1YwMoGC1SLwJp/TKgD+zbL5IopW0S0kSjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fziBlWhQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RKnjArUe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42QBnXaA027564;
	Tue, 26 Mar 2024 14:57:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=CvD2wKOpDwAJwG7dAQ2Rg5LY4EbgqLlM0dax59VZIsU=;
 b=fziBlWhQDim8/8Ujy0RTS914hv1hOakI/CMT5shB3N3TaOdzIvZOdujPIJQ+PeCBsJQc
 nVNHqDjCRfULKkE/Hd+gczBRR92n0ut1Ca8tr3UXdSBR7VBLeVHwnRqsVgZ7DB19HvZK
 fHwwa7h38fWeqCvUJMXY0P07Np7wXGnIeYfy834q0nB9gJ/X3kmIa6DMij3NNJf5aQM1
 oWchNZdyTg+yaZmB4TRRzzqfSsK/uKPsDRPZsPeY9aTA1l33P9AY8BFpkengIsIqVhFT
 dvbcKKF4c2nIlwKNl3pgCJsOyUr7y6zHSs8DTAY2y7/0RYEeaIjqQ9B2nUbz54DfXq5A zA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1nv456xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 14:57:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42QDmXlb013826;
	Tue, 26 Mar 2024 14:57:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh7b0jf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 14:57:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeXtpcSCN1wgFALWg3W3qwtRAly4lFiudcONkf50seFKgOI5BfRdaMZBSuoVRlK4RcT9/z6T+HqNayrE6SH3L69YVCGgzQJaF95DGYCjfNoXcgNHVAf+Vz+tHGuxcwiN94t7WLlbGA5KM1eQbrGnOrOr6JZyomMcHwsmpNhwMku+YG1IJid5VyZrVlCRwNz4j9Wbhjnx4NxdOU5GUJ5ciEQC1VQXmhV5egkCSnqijVkUdr32M35Y77ieQsP7CibeGwYvhmkdWinvcmcnGrrUtNIUEdLDylw1XGD+WZPljw4CSG1DJwpr5C0RbXb4osv/gF0kC2fTG7AzWDIgHSRtqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CvD2wKOpDwAJwG7dAQ2Rg5LY4EbgqLlM0dax59VZIsU=;
 b=epMzIuyp1v6TDoGxIIB1Zry4L5kqWKvUATNYBfACB16Voaneg9l2XXvZOfJLZf7XBrKJFxSCaKMU+Pc3j28AXdtTCPgzfw+ZcvdYz/qhyJMKLzbmsGZi6QosNToR+mEIYx86sdA4QzELCvrJ9k0r2WfPdUwWz+Y/L3tgjRv0KaJow+gfCSyVXNCZ0NbVqrS9rCbQVdIpWR6N/167JSDP58kI+MW+tIFvhD55D8ZKOUgZdYhA4PeLEwr/EizkCEw1204gRoI01CT/tdpCC1p+GivAxDqhuVhOV9TxDfUJ0WaAkBWRq9Ot36g8b24T1czkRqJSmeJNadWDCoBjjTbgBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CvD2wKOpDwAJwG7dAQ2Rg5LY4EbgqLlM0dax59VZIsU=;
 b=RKnjArUe6GoZ2LlxmjUNDF03m/IkGDpsCvBBIauMXj9KYXmQ7RXz+XGN42SIt6F1CTLtbwrohFuqh0wWz7hNHi/RrLgRNQ+gpWZT1/Ngr14z7LZSjVInV05n+Dl4PwLJ/TA7bP6h3AO+8iG/gVWOx5zMcd/FoYLtlmu0BSmyLhY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4800.namprd10.prod.outlook.com (2603:10b6:a03:2da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 14:57:23 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 14:57:23 +0000
Message-ID: <98859b45-e86a-40d4-8cfd-8cf63db3cb14@oracle.com>
Date: Tue, 26 Mar 2024 14:57:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: Fix W=1 build issue in tg_prfill_limit()
To: Christoph Hellwig <hch@infradead.org>
Cc: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20240325121905.2869271-1-john.g.garry@oracle.com>
 <ZgJzNvN4nQqKnhk5@infradead.org>
 <a4d8b56e-1814-4834-9d25-ef61ff6f1248@oracle.com>
 <ZgLgedPipnZuyHCA@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZgLgedPipnZuyHCA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0134.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4800:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	krCKCZbI6r2jDHP9J0/gVmuXLrqoItg40pHv+qdGbfGgeM4p+jqNXBk4KBnjJkMZ1WW+sqoUP4DfbBIS3qY3j8NrRTO5HZH4iks64uCwKz0eLyXSkXRkT2WduQLdIFof/8+UaTAhgaX/NrouGjNkx00PKB07ob6mJXaQtadfJuFMyaJ2nwua2/RdK73bJQJJiIG7vRNyQc9h67dlLmsHCveZxwQZul4UhhQaiEMBdUiNdHCQy233SOv3cio3Bl7p/zMEO6aWDZg6r+He03LHJgFNFK4mwalMApcFKZVOUXR+LyzqEZUmbwfvOuZQuvjFo0xd1BY24CcApFnmLEPlUoafF6T7UaLzD2STxLeLlGfetoRpex1YifwqjipQC1pKXN55Y+V5SwGIsbF/Ome37rd/7Jbm2L7efiTZtwSEf1F3dKjnE/952UKlbvKFSBZ5/Wc6gtkb24pR8pgmjM6khRBDGjPgb0bkWNLe3Bx8yRDvldLuTerQ99rX68k6BV+9jjUSIXYW24lSOWefrgfm2Bbmc3b9bLBA4dRcfzZlCuzZUFdCDe8ewyjfiQU/hhB7qkGAhwGZWf9MxA6DXTYh7WzrB0c65AEHaXKvm5BtpHip3Es9RPyLpfuqeGHWcKSTdcEF+8yTsrjKL4qiwrfzSuBpP7BsAXSsfxwOwTnE+K0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dys0N3Z2ejR3clk0bGdLdG9BT3BxQnlwcUFkMXlCblRYcHBHTlNGWjF4MTlF?=
 =?utf-8?B?eGlXZGt2Qi9GQUljcEIrRU1RV0c5TGdHWHRaMDl0cW9XTThoT0NIUGNRTFBs?=
 =?utf-8?B?Z1RBUzhDZm51akVxUXpYM0VFcitybE9HR3BwMm01RC9ELzZ2SjExcWljYi9H?=
 =?utf-8?B?dytBVy82VERRNzMxNkJrTVBvMzg2a1ZKYXZmekJkT0ROQ2VKaXVmUDZrS29J?=
 =?utf-8?B?UnljYU1GOU5jL2R6OXdmbVphM1dZbUMwTmdEbEUrWTJRTFQyaFN4QjFJNHV3?=
 =?utf-8?B?MHBlMFZwWkZiRGZQYm9VY3lSVTdNemlUbFZScHN4YWdmMlJwWGxQdkUxTXVa?=
 =?utf-8?B?ZkIyVGdEblc3VytkUmw2UjFUMGxHeGlaemFtczlDakUxK2lqbjI2VkkxQmlZ?=
 =?utf-8?B?aC9PeTgvYndVZ0VwNFJOK3JXdC9NOWNydEFSMmFkeXNjR054cXJyOVF4VzVK?=
 =?utf-8?B?a04vUFkyeXludkhLeDYrckVBNC9iemU3ZGljUE9SQm1pVGVYbktlRHFuUzd6?=
 =?utf-8?B?QXBMWnJTT0NaSHZWeUxpNElvM2w1SDNNVVd2a09BSlg2MGMrZUQ5dmVMbVdB?=
 =?utf-8?B?V1A0N21iRjZ4ZFZTNGNnMEF1aURnMjJxTm1BZnl0NWc1NDBPQXA3T0I3SW93?=
 =?utf-8?B?S2ROQWpyaGFTT0t0dnVDYjljSys0djk1RzVGSnpqeE1kWEk5bDRXUCtIbjd6?=
 =?utf-8?B?QWNiL2tOcG1LSHZSYXJHYWpISncvRkhnaUFwcXp0T09Ja1B0d0RUeGdHZy92?=
 =?utf-8?B?MkJZc084SE80WFlDYkFzUkducndvQXNWNlBCaGpYZ2lsb2R0UVp4ajREMXdQ?=
 =?utf-8?B?Q3MvbjdQOHZWZytBeCtSN2lzL1U3Y1VqaG42ZFVrOUR2a2cyeVVidUc2REda?=
 =?utf-8?B?V0ZiOVdSaFkxSnpsQXV2ZFNEMlBNeUtnd2UySjc3U3BPbUkvQVQ1WFFRQi9u?=
 =?utf-8?B?S05VOEZuT3dKM0ZMbVdaZUhIelQyTVdzdVloSHJkeHNNUjliMEZ1R0RzM3NN?=
 =?utf-8?B?cU1WSy8wbnE4K0dJVTdOMzFsNmtseStuck5xa01OalJoeUo3QkRwQjBhQVVE?=
 =?utf-8?B?Nm5xVS95NFJzQ3JKZ1Rnd3h2UTVLWkwzQWlVcm5HajFITWdWalNMSzgvdkVD?=
 =?utf-8?B?aEJ5RFh1M0ttTkhrM0J5bXhGV1ZVUTBEVm85WlE3ZW96elIyWkpZQ2xteWxD?=
 =?utf-8?B?c2g2V3JoV2hCTndVanRHWEkxVDI1eDhNTWRsa09aMzJCSEtwMTVsNFhBN1Bp?=
 =?utf-8?B?TGlqY09mY1luSlp4blJwaUFFajdsT1ErYjBCR0h4UHJHT2RrNjhQeGdHU1Az?=
 =?utf-8?B?VXIyTE9QRkRoK1lvNjVhbGlSdWdkenp1Nm5PWTExQnhqUm9qMmdKUW0zbllz?=
 =?utf-8?B?UnZYblBVWFdrTnZDUVFXcG9vSVNIRG9CaEpjNDBEd1FrZ0Z1emQxejJwVStE?=
 =?utf-8?B?emNtZFpRb2hPY25QUUl3RllDcGlvV0FFdXp4cXhrVk5kRTlGci9ycUZvRjRS?=
 =?utf-8?B?TDQ4WE9Rck80eXBBU0RwL0lCNG1uZ2RyNThjckRjQ0hubjRzWHVNNXZWWUgz?=
 =?utf-8?B?Tmd6cG9sd1ZDbEQ3TlNmSUxQQkd6NmFkMTRDVURsenlpWlM2NTZNNEtrTjVE?=
 =?utf-8?B?ditRWEF5VzRsK3RXZDB1eXlLL3VsQzdXd3B2MjNRUFRhSGNlbys3S0xEWlJn?=
 =?utf-8?B?RFE1VnRXMHFxSERWVFkyNWJSVVh6eVRpS2owcHM3c2draHF5UE45N3NVWHdO?=
 =?utf-8?B?TE0xQUFNc011Rkp3b21CWStTOWxCbE5rck4rQW9QaHBNbXJsWUxYRUJkaHZo?=
 =?utf-8?B?Ni9uUlJHcXdyWU9WT1c0c1B2c3ZvVnpmSWx0VUtPdU1oWDR5bDBNMld0WERh?=
 =?utf-8?B?UnpzUjdPTTI2MVlpWUhDVjdoZ2lqeG5WUkc4OXM1ME1CVXhqazZ0N1BFenc1?=
 =?utf-8?B?d3NwQnl6T216TXBHeUozTG9SakllUmxyK0NpT3J5NWtpWU5hNW5mSnU3R1ZP?=
 =?utf-8?B?UDhzYUkwcnlOcGQ5dFFvRzY4N25Wa0FyNGpqdkNHRzFaSFphejZEQnh5NGc4?=
 =?utf-8?B?THdqcnJLa3hhVnV5bVZqa2ZobjNVZGE5NGN4UGtDTTkwSXMvQWE5bkViWnVM?=
 =?utf-8?B?QzdtQkZHVlVHZmJ2bVZqU2oxNG5Pd0ZHVUo1MzRieC9MNzVWYklYZHh5dllt?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SlXF4NR7sr2iogrP6iShNZvmPoEvERZlI+6q0jS3ydqDGtP1sfDTFltkcoqrvOpWokhJNzjRPkJip0iRh5d+eY59IdJ9RTb8nv3H5fuxvzQ9MjzcWUE+pa8f/lNHloWlq0JYD6xEYbEXq8OqBBWoIvXRzrcI0WaLpAVNWCZlqCXFFahe6ciLf3gmxARiXrfXy/aUqEYtalFB8lhMgnE8+42VUPoGBt0/yv6sv0oKnIukXlt4P56iB2lvNDw3t2bjLTxYmNemyZzH7lPfAwLXbGEtS85KxpLHZPl2D20uL0HFFRh4BjVzdfnle70G/945WHnXFh1ulyqrCnirk99qze2IvT+ZjNTGdwto1+xBtYZ8N2iuFJn+/ZMRqD4Yh23BjO/cZCKZ29oekgOCbOO3R/g+QSJ6whYEn+Hapq2NT+6dnpFtBVuRalCxy6JB19qRwxi8pqE8q7pseAtA2pr0h03GhxY2+hoXqZQQ72GEZSNn3npaqR/ehWnAz3f3XjBObryCLF9W033h/K8R79KRvPG0EfgtxUHcwRoLVRt0Z7sGx+t8ZsE6LLMp6Gg/YA23wBEoqIucgiOa3GacGYZrq8oFGSgsAweTDWbJWTT+vbI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9acde0f-0507-4805-1244-08dc4da50b1c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:57:23.3414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHnFd4615HhLhkpxGhMSnleonuQaDmPZK8p+wULZ4M4iXxoGbZn8s4EPbj7pW3UtLzpko4yNdkaK5ogfFOce5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_06,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260105
X-Proofpoint-ORIG-GUID: atwYUn5KHmIjfMC_gE5jW6Dh_Xlsw7Xb
X-Proofpoint-GUID: atwYUn5KHmIjfMC_gE5jW6Dh_Xlsw7Xb

On 26/03/2024 14:49, Christoph Hellwig wrote:
>> Here's how the current code could look (using only seq_printf):
> That looks much better, thanks.

ok, I'll put it in a formal patch. It would be nice to put purely a 
"fix" for stable, but no one else has complained about this old warning 
AFAIK.

Thanks,
John


