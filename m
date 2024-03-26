Return-Path: <cgroups+bounces-2162-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8066788BCBA
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 09:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED22F1F35549
	for <lists+cgroups@lfdr.de>; Tue, 26 Mar 2024 08:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8D14F90;
	Tue, 26 Mar 2024 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gsWNX0B6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ERuuaT1I"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48414A81;
	Tue, 26 Mar 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442813; cv=fail; b=rFIlFwcbj37KrJ+Oecxqhsky/tl+evv86MzdlrK28FZNtAAJ4oxp1UbDM9J+3EdwTUZHwQCd3+TxFyecNyGz7xAz+1djwVW86iXsUNOQP5SXF/kx/+w1tQBDHneswNHGzvyWZyxiqT6SKxybomnRCBZNjqStt4tU6QYUctmG0s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442813; c=relaxed/simple;
	bh=esFNkXNaE368Smh8keb6amQYl9c6ZgelnforKcQxAiE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ad52TaGSo4lFBSWaTMX34oqpLihF9fJ3XWnu4DCZj5M4RsDX22lM8mUR9kVjDfY3XVuGvmqrzLfNskqxZTJOKgSi/RXlep8mVVYMnpGqEJS2gGdq72fUm5gBpms4BFAWkzG/iDmGAHUjgewjC+zLUylPgJ+42CDmJ34QOCDkT1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gsWNX0B6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ERuuaT1I; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q5OwpE001798;
	Tue, 26 Mar 2024 08:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uHw4MBUWb2+AmFfvnVRA/jUgt6J+fFDucZu5Io/50sA=;
 b=gsWNX0B6lK0/MinH6j3Ws2UjCNMor+dFD//tA4n5nREXi4n6g9ehQmhtzogl4XTgstkb
 cp9SVF66FNHj6Easi9g3T0ltB5ZJtOF49Rkau981cz4VjlGRBG0n2aIYIcawqcHMt431
 RomJ09uW5H2+03MVZJ5RLy4BcZ6zW2LmXIcbdGIKk2jqpFOTuPFC1hEUI1UF+bVTPTtk
 HibYuWqzZ+Wrpn76Pg/1IVqd/fFe7FE6MjyMPw4HB8u46t1EaFUSwZyBCH0LkuWGnTBx
 BvBuY71MrHs5/1q3Ho+R+yz0A8wvh/61v4Lg50rQlthVzNG3gjWtTqsUxILPz6aXhlM8 bA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x2s9gty17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 08:46:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42Q8LmTZ020216;
	Tue, 26 Mar 2024 08:46:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh6n86c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Mar 2024 08:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAXhas+/ocMGKUIZd0F2ZX9A4XdDYf3sXjHzT8kOwLDIPrHm3owgDdmwEkl65uteSEKuXK04a74fPJJSlG4ofBC+cDKLPsnzudfa0JZ1Mon9xakl7bc8fRxPRSxQICjOPyQ7gj33Ya01+E1jyMTlYzxrcf1t+2DsS31qmAkveJO39O791TUGvA1r7o/nICmT+ehUPTP6tWUdkBH5bEg18amDwI7gmQtIwDoAvDzOg4bvoNsJIASLmKomS7JY5KmVkMH9kUNqRAEpuKgUiy2XXehNaKkFnsulz0PJQAQmppBH1/jBqvHjFebW+cXFkXjUL3dS3hVgh14IQe+fiSrU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHw4MBUWb2+AmFfvnVRA/jUgt6J+fFDucZu5Io/50sA=;
 b=CkOijIOYbqXkd1hqpPQE5m1NtfseM84PSQJzH9/DjTNQ0QMuJMyL8t8NxiWujZy2P6ORLKg3XekB0GwgTiZyA5r4qYWyQO7JW3Z8p3PZGLoNSmJ89+8dp4vt7EPPNbyeG1p7wC7JeX66nl0M6NNJfe2BX1s5ZxPNlgbzNA132WT0KXFXOiG5mczYsGZMlaK+V1EIFdanRk+QnOxpvAoO/Pckx3izra2y6dokac7ISzCh6dde8DD+5/BHCFoU1ulF9lKkZLa6SLK77W3Ob5I//NyI0fXzJ21pPBSfdxI/67MBQp6p8vMDjVKCwLGSyI5F0FHfcnrdBqI+HkLfQY2YXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHw4MBUWb2+AmFfvnVRA/jUgt6J+fFDucZu5Io/50sA=;
 b=ERuuaT1IqOvGNO+ItEaoEVlbXTmwv9HQy0I908eRli9Hrt2SHFXSSUBhCkAqYuI0am9dqsk31T9qeCLL8K6eH7QoDCWRE/L1Ok4Nm2hqK0pWFw6dudesAcGk+RA3Qjm8WU5ry2ykG5ifYw1jF53hAxjjrz8jVUOB6U1g1Ac3GHw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5775.namprd10.prod.outlook.com (2603:10b6:303:18f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 08:46:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:46:33 +0000
Message-ID: <a4d8b56e-1814-4834-9d25-ef61ff6f1248@oracle.com>
Date: Tue, 26 Mar 2024 08:46:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-throttle: Fix W=1 build issue in tg_prfill_limit()
To: Christoph Hellwig <hch@infradead.org>
Cc: tj@kernel.org, axboe@kernel.dk, josef@toxicpanda.com, shli@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org
References: <20240325121905.2869271-1-john.g.garry@oracle.com>
 <ZgJzNvN4nQqKnhk5@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZgJzNvN4nQqKnhk5@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0181.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5775:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eQbqDnYkC72BEdWWD1FbGfcVlsuiJbjWB7jGR35M6OED0eNorakNGVej/Dn6kHZVvjsQmsqDwJLWn5w1wrFqnBwVbTtQEfc6uDHIVHtVezY/F6ilKhY5C7TgZKB+tLgZ8vVd0iRnpIb2QuIXgmHVHgdD0zWZ3BiM6J9TDNwzJT0WWfnZO71T5/wP/VO+h5qlITRJKbUAKphWwcUOKcrKOvTV5TzxsF0o3TFLfFa0t6m0jTb1S6bQZ7KnYwuntbLW7csjxXnIU3869rNjNEUp7xAKAzd12ndknY/W/pPL4weAhC8YLneERLlbyZeYFG2LE6GWsYZiYzl50sFhQwMBRuX27JpfW+3gCtjdiB9bc2l2AHn+uqyvLglFPa9FuPAq/tG9dbHig0O6MIWD1f7tj4ypPCDtkK91hFricbGrwgHWb7/RuJSc9teisXbCnzDvMG276zujRyOTRpuvP5HQPFZl8CppKhxqxJGhJuDBgXQl+XjYJ3y7i59w3W5QMuDc7KanVzJw294fWa8QsTbyPBWIxA5+OgGBCkwXvUgiZmu6pX8W+QfENi8r+l06VEp7R+Rz08VvJfXJT5tyol9rR64WuUdvHJcGhdk7gJjVQdPzahdJN2btV97Jy0+9N4AzRCblsbtjceeZDK4blJtraWn6GrcVgeH1ko/cBfb0MBs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NE9BZXloQldHY1dXeG9OTkxQMFFnMXc3SzBBb1Y4UlVZbW5STTN2MUxkS2VR?=
 =?utf-8?B?QWxva3orMytYWEhXMUd4dHZ1TW03VkpVcHdQMzVLeHN0akZwL2N6SGZiMmwy?=
 =?utf-8?B?eGlpdlJvKzY5bjlKeFFTMXI5cEZkaEFzS1RRWldrbk9CcDhUREFnam9uV043?=
 =?utf-8?B?R0xJcWx2OUlpYkZZSjVJVFhqVnd4bFpsY3FwVTdSWm01QXk3TGdNYXFhQlVQ?=
 =?utf-8?B?dTdPdzN6bGtjSHllTUJ4QlFWbFJ2REJMWHdlWFRnajVyY204Nll3UzFSQUh6?=
 =?utf-8?B?bEovcTRnK2FtY0piRnF2MDZ2a2h0OWxaWXBxa1IyLzBnT29CTG5YWGhrQ2lk?=
 =?utf-8?B?ZndRei9GSmdYU2UwUEprbCs4Wkt5OVI3ZmJ4NzNIdlVEUzFheTdRaUpGSzdX?=
 =?utf-8?B?dnUybTZrV3pLbjczeHFpVXlRSkZ6RWx3VW9pKzNXTy9RV1ZMT3JrTjcrRTVr?=
 =?utf-8?B?U3d4MDJSWEg5Q0NoaVpaSXU2L0RVK0Fmd1FMNjRuSFVpcDg1OHBCL2o1eUJU?=
 =?utf-8?B?MVIyQ2N0aHVqSzJaUS9aYUZBNTJJaHZJZ2twSUE3MDQ0TU5KK0JXV3FKZCt1?=
 =?utf-8?B?aDBNN25IVWtLdVQzT2tWNitxV0Yvb1M4RzFNa0l0b2FFUnlRTlZlWkREYlpo?=
 =?utf-8?B?MlpaNlNScmVwdXhHU1Q5SlppaC8rajBtdXhtQ2VCQkx6QnNDaGpXYmRCaVBE?=
 =?utf-8?B?enU3WjkrRFppcEhoaW5nNktCNUk2Rm40V0c5WGw1bzNlVkhUVXlMYnppSm52?=
 =?utf-8?B?NHc3N3llejdPRFROeG03VXhKTG5neEV0Qk82aEdXcXpXM0RjM2NxRlBiS1FZ?=
 =?utf-8?B?NlVSQzhyUWs0ZE5UMzdHRllSdmdTcktINGtnSTVpOVdHOGZXd1F5Um8zTm1Y?=
 =?utf-8?B?K1NQRGVMMFFQdEJ1SFdXaHQyajJZTmMvMUp5Tm45bzlkTld1aS9qQWVSNkx5?=
 =?utf-8?B?aURVSGJET3pJT0N2U1djVTNUSzdtWUJaNG5ZTjZoeS9jYWlaaE1Edk5DMjls?=
 =?utf-8?B?ckRnMy9DVkFWZHQwOGVrLzlSRGh5ZHg5dXllaGdMM0xabTZGaFBPcndIRUp4?=
 =?utf-8?B?UlRMY01YVGMvWS8xM1lRNlEzM1JscVdrR0YwTEp3N2Rka0s0L0hSeG52UFBi?=
 =?utf-8?B?cndIOTV4cjVLQkR1Tm5nWHlZVjZWVm9pUnE1cytxdHRTeGhkZEJpS2Z6VllF?=
 =?utf-8?B?Z1N3N0ZRUGk5c3ducDd4VEh1a1RHL1Z0RldUN0lxcnVOZ2tNTDJyTmNIQ1Ey?=
 =?utf-8?B?dC80aFVXaDF2VWxOTjBDeGFzeHlYYXZuYUhRdkR1bmt1bUxiSUVQS1QyK3Fi?=
 =?utf-8?B?dVpjZnBxbVBROElkSFdLTlpJbHJEcHRKdDdtdlZrN0tGT0p0akFYcjQyVmwv?=
 =?utf-8?B?ckhFNGc0eU1KZVMyclVkUmduOW9QdnU5dk96eE1YUDVFVVpRL3JodmMrZnBa?=
 =?utf-8?B?OVVLcEZGcEl1Tkc4NkorYnJhdU1XNTZUVG9rRGVicGxPVERFS3B1ZEZCK09J?=
 =?utf-8?B?dnc5bmhleFZUcWFXaVliN2pIZURSeFpyUnl1L0JXUzJ3RVFSbVV2b2lqNHMr?=
 =?utf-8?B?RnhCRlJFOHNjbU1wV09HejFjb2QwZ3MxYmRSOVR0UnJGazJENVRpVVJ3SDE3?=
 =?utf-8?B?blNnam1vOW1GUjM1THZUTm5zdGR6Vit6Qm8yU0xEZ1dUVGU3azdUYlgzYzB3?=
 =?utf-8?B?M1ZjdTJDR1NHejFuQm94NzlJWFhXYnQ5SWpIbFNDRlBkRzhOdEJEdkNxaHBF?=
 =?utf-8?B?M2lvRlRsS2U5dGgwTEpreWc5TjYxTFA2ZDJ4Y0w2TW8zeTFac3ZkUEVtaTli?=
 =?utf-8?B?cGUrS29OL0FEZ1Z0K1g4L0owZW80MlJYdm9NbGxiNXRsc29oYm1aLy9pU1BC?=
 =?utf-8?B?d3c4TEFkem53WDMrbDIvQ2wwRFhGdmxtSlhRazMrUlBJUkFMUGUxSUgvMTdO?=
 =?utf-8?B?SDVaLzUyTEtPNFdKcmE4QlR0bmNxWVRsWG9QS3ZQZW9yOTBqbStMMU9Hd2FJ?=
 =?utf-8?B?c2ovVW1rc2s4NHk5UzhFR0E4N0lWbkcra2Q1UXFMLzIxRGVIYmpRVFNQZjBx?=
 =?utf-8?B?Y0M1dk16aVdKZE5vTmJkaEVFTDA4SlhkQWpldGJUc0psN0dCRFl2ODFoaFow?=
 =?utf-8?Q?pwsAlJNyj8CkuxwuKX+hokAL0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7hgHIn4dWmIz35+sW13bM1dlOT2DolinequKmhHxpNYUkHxe7uwYJdaz51+P0fn62j4jpSxijcG8qyNW89SwJwYjcw915O3PsNNypPRLNzxlDJksilFvVouhr1+3geDtDkaYxBX66hkM3kr0PzXvZHv5f+6s2w/LpZIBOmjesHiLbXRqHALp3i8b+sAiC+VZ7RahtZX0RnlDQ3sozZYBWPE8YmQncusZSP9QH8NFWWErg/SrjMYkeMLJzI21z45mFRNtQG06/EizfrsUbxu0xASm+XjkjJqYHGoNEUtvihN9PSlQqW4C2Y3dw9t4DbTiixyPSTUcbav+vCz7Cyz9cuUmnEvLzKBZzyo8xGcl6E8zwQao9MqEPTs6In+wxApR5VFr/S5t5WjaEsF3YZCBqXFgI+XQeQTCpADvQn33uvphSmTo34SQ83eCMQ9x4ah8yS6jc/TxDHlKx+pbC4JZOn53+70iUMsBE7hWHoLEij/g59zOpVueOQbnqxgfe7EPd4WHX5nnG8uDZ6bzOQPaRRExgi0Q6yIIy+k5VQ1E1yUPOwJw1LcsJWA0lQchB3TZIV75PBpqSxU3EjsVfPkFFlmfqZn/f/Wgm1JudrYL1jc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da0d7c03-36a0-49fa-ff63-08dc4d713d3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 08:46:33.6752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNR86Zbfp9HnRhDSfVAVF/NOcz88oBs9ewxTsSa6nr9rsunBgXJZ8ps1Y1WDwWJz6hVv3gU430VyAIGVFt2Q2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_04,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403260059
X-Proofpoint-GUID: 4wK3o3Tlnxy0tGjB9ReI4PYwAH22gxnY
X-Proofpoint-ORIG-GUID: 4wK3o3Tlnxy0tGjB9ReI4PYwAH22gxnY

On 26/03/2024 07:03, Christoph Hellwig wrote:
> On Mon, Mar 25, 2024 at 12:19:05PM +0000, John Garry wrote:
>> For when using gcc 8 and above, the following warnings can be seen when
>> compiling blk-throttle.c with W=1:
> 
> Why is this function even using these local buffers vs a sequence
> of separate seq_printf calls that would get rid of these pointless
> on-stack buffers?

Currently a combo of snprintf and seq_printf is used, a strategy which 
seems to go as far back as 2ee867dcfa2ea (2015), when it was a much 
simpler print. All the other code in this area only uses seq_printf, so 
it seems that the author(s) prefer this way here.

Here's how the current code could look (using only seq_printf):

static u64 tg_prfill_limit(struct seq_file *sf, struct blkg_policy_data *pd,
			 int off)
{
	struct throtl_grp *tg = pd_to_tg(pd);
	const char *dname = blkg_dev_name(pd->blkg);
	u64 bps_dft;
	unsigned int iops_dft;

	if (!dname)
		return 0;

	if (off == LIMIT_LOW) {
		bps_dft = 0;
		iops_dft = 0;
	} else {
		bps_dft = U64_MAX;
		iops_dft = UINT_MAX;
	}

	if (tg->bps_conf[READ][off] == bps_dft &&
	    tg->bps_conf[WRITE][off] == bps_dft &&
	    tg->iops_conf[READ][off] == iops_dft &&
	    tg->iops_conf[WRITE][off] == iops_dft &&
	    (off != LIMIT_LOW ||
	     (tg->idletime_threshold_conf == DFL_IDLE_THRESHOLD &&
	      tg->latency_target_conf == DFL_LATENCY_TARGET)))
		return 0;

	seq_printf(sf, "%s rbps=", dname);
	if (tg->bps_conf[READ][off] == U64_MAX)
		seq_printf(sf, "max");
	else
		seq_printf(sf, "%llu", tg->bps_conf[READ][off]);

	if (tg->bps_conf[WRITE][off] == U64_MAX)
		seq_printf(sf, " wbps=max ");
	else
		seq_printf(sf, " wbps=%llu ", tg->bps_conf[WRITE][off]);

	if (tg->iops_conf[READ][off] == UINT_MAX)
		seq_printf(sf, " riops=max");
	else
		seq_printf(sf, " riops=%u", tg->iops_conf[READ][off]);

	if (tg->iops_conf[WRITE][off] == UINT_MAX)
		seq_printf(sf, " wiops=max");
	else
		seq_printf(sf, " wiops=%u", tg->iops_conf[WRITE][off]);

	if (off == LIMIT_LOW) {
		if (tg->idletime_threshold_conf == ULONG_MAX)
			seq_printf(sf, " idle=max");
		else
			seq_printf(sf, " idle=%lu", tg->idletime_threshold_conf);

		if (tg->latency_target_conf == ULONG_MAX)
			seq_printf(sf, " latency=max");
		else
			seq_printf(sf, " latency=%lu", tg->latency_target_conf);
	}

	return 0;
}

better?

Thanks,
John

