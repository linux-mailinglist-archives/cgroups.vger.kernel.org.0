Return-Path: <cgroups+bounces-284-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDBD27E6CEB
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 16:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C5C228108A
	for <lists+cgroups@lfdr.de>; Thu,  9 Nov 2023 15:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E5E200C8;
	Thu,  9 Nov 2023 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="gydpRhEG"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914B13AEA;
	Thu,  9 Nov 2023 15:10:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA2135AF;
	Thu,  9 Nov 2023 07:10:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXLFCTEu5Mobuy3H5boj2F35+YH75Az2yVOSbw8eb/nzaN8q9JJ/VWBfYr1bneX4NrIOYYU9qPBeNU+lV/UEpOtTMztPcZT/ethNgeS2ev+SKibJgxfhVKc0mpJmLq6KSY1f+EkQQTUHHrhc8GXXMOrsCDG+ubQSeA3y4wdEdDUiuO56d7LJVXBGDxFQAPEB9zZIyKIf4o3LvfhhapNbsgw763rk+6sAOjVouDWs2r/Qm8FPN1fPo6R7N60XRJ42HcoAXeJKWF14sbrsK9O8ImKMfhW9DHDg/RfsRgd6pKePt4vwpeqjx2o/MI7Q0/tVNO3m7vVWxIYsAkdcMbOQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E+aqYadBVCGqMHlvIWB6fReAMbXW+JQCV43AX0WkPQ=;
 b=gJ1wMDtIox7qBjnHBl42n3rrWUfv/WxlyNLYaCUDaIHOadRxY+OFctEwok6GkGS8lOSITPj8hAn3AcdUDvoY2BgFgMBXbSGi6NUdz0+6A6+n2OAEoZnqmulNwKbVStdyak3m/vqD87Z+rjPAKK/eIeTe4WJ6OJv9SQakmr+ooXVUdPoDjMZDgpD20wqaaRL/787z9mcHkry3udVzkyebyN/TX3U1eof+TObHRIPRBbpbp7lGZv06Zrg/D8v0WWbhQrmEwNgOQi1h+TiIATNgxnExH97wYBRA4TZAgLbTvTLO1icBJsxpmWdzbC9k06Xb8RbBQs91ySYBFgGHNuBYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E+aqYadBVCGqMHlvIWB6fReAMbXW+JQCV43AX0WkPQ=;
 b=gydpRhEGDMy4J3DQWKIX4gOBw8p9AadYCFxDcK2ENfs3qz2MluzQWAguqrLu0N4YEUhzWVg8vErmy5XB+eLBZo81Orq6gIHCeSF0zF61zGKGTqdzuQvPb/XphAm3c663k0s6aNs/KuW0+Sa/lBC+q6mxEBVquNg4UoHNFpH8DBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DS0PR17MB6127.namprd17.prod.outlook.com (2603:10b6:8:c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Thu, 9 Nov
 2023 15:10:22 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6954.019; Thu, 9 Nov 2023
 15:10:22 +0000
Date: Thu, 9 Nov 2023 10:10:18 -0500
From: Gregory Price <gregory.price@memverge.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	ying.huang@intel.com, akpm@linux-foundation.org, tj@kernel.org,
	lizefan.x@bytedance.com, hannes@cmpxchg.org, corbet@lwn.net,
	roman.gushchin@linux.dev, shakeelb@google.com,
	muchun.song@linux.dev
Subject: Re: [RFC PATCH v4 0/3] memcg weighted interleave mempolicy control
Message-ID: <ZUz2WiF+LkEtiy2C@memverge.com>
References: <20231109002517.106829-1-gregory.price@memverge.com>
 <ZUyuL9_8PPiEflnS@tiehlicka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUyuL9_8PPiEflnS@tiehlicka>
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DS0PR17MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b466f1d-0b29-41b6-ce96-08dbe135fe7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iefFrKtyBai0oQUMd7aSMY2EdAFiWiXjT4x65bBexsjbwqjUOsv5Sf5GVLAjlHYe4sWFb9gDJrcHNGL3rpKz1CG4zGuHC/e9TnK1tcL3287kcjKFjFRPY9teUqLKSd96L2mn8nqEHE6ug8T623BAOOtj9P4cfaiYv42SPkpi2fJqi0hAV9c7ECYlG5Xg+1jvRx+lrVQR+/gn9J8E7Ufs8Y2ztP3IU2skNME12yrM8nN0QhEY1pxFCmgWuqnRsrGmXT999ZdBYVtSWVB9DerZOIRs0sYYnBxXAQFJrBXZBepQGjYw6XKtleKvEtfekXh7aYmoabRYEh1S57xnTtQ531pxLve8EsAXoGbpv46TipF4x6g8CGP2DUgmLQ+3onN/wwr9Oxm5O34xFZz6hPktXop/ompIV+X9GtmatlMbeMAoafPRUYXd+0k9fWzM/OtMkCyUU8RsuHIZ8UWNOK5202MKpHxf9L9u7TarSBTo4zmxE9SDT8g+rSCTd/lsB8HhVsfut2jeEflL65R1fmhRtRpxlT5DzVA2+y6/JBnIl5MyIPW5lHMo3nfeO5UXYonGDU0l9P8xq4kwaCL+2rr/A8FKpwkc895p0idZv5WvLxE6iemxSGxxjAUAovoy20bQdGZp6QsoKRP3F72ErYFo0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39840400004)(136003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6512007)(6666004)(6506007)(6486002)(316002)(8676002)(8936002)(4326008)(41300700001)(44832011)(7416002)(2616005)(4744005)(26005)(2906002)(86362001)(5660300002)(6916009)(83380400001)(478600001)(66946007)(38100700002)(66476007)(36756003)(66556008)(16393002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WbtCIADX9Q2r1MSy+Dzg35sa7qSeKRGhJ4CZlPrxNdWdq4oXOPVCyF3zv4P?=
 =?us-ascii?Q?rRRHMTqmH02MF0B3xuEi+Y7J+8Mg+J/wi/Yo6ChPBx06BaGMdYOuSeYp1CHV?=
 =?us-ascii?Q?OFOc7XYycei8HZTBucsZQ19lYnTg9ZKz76GM/L+fISHufdJJASJlsOPPDoPt?=
 =?us-ascii?Q?WNzcFm47Kzxb5maY1UMGaUGI3SkQN0ICKoSwv4onaTByK5b1BV+SrI35H/fK?=
 =?us-ascii?Q?1Ph8xA+w2HHvb5E5CPv+bsNcYnmpaxL8n/Wnt58bLVAo9nZmDk9m8DC63xZW?=
 =?us-ascii?Q?bpUnKxdJTtgc905KVYJQew2lmfcDU7UTXb0ytSEUgkbmxGi7xrj1ry+Av1jH?=
 =?us-ascii?Q?e9EeR9qvQd17TkFLDwPv35Gk9maTISPMg/AVzjoTVbVo2KWhZteFCUfF3MtT?=
 =?us-ascii?Q?yvlAn8fFwzBLtAFBC8XfXji2002US1YzmsJVhN/MgsH+NKL8JQdJZoNgJIql?=
 =?us-ascii?Q?N4YVUJKYunufJRyll1OCNUx7qQ8GS93weEgn7ZZFxmYwlKZ8Z58Ae3FvtR8H?=
 =?us-ascii?Q?ecLYieVMcT2Hlzzir1UT4GdqWXRmn8ZiT3VShJpznXY8IpmEixiO7xd2xABF?=
 =?us-ascii?Q?c7PjjEIzji1Y3z4ZX3aAYvwt/f+WOXD78LEhOius1Y0cg5X265jXhwsS0nqy?=
 =?us-ascii?Q?CzWdNkGCIfM4us6jXEB6SvoEiMt5gn7xpoLSGSenTkQHqGk+YBicvU8+vFcl?=
 =?us-ascii?Q?V3l33NLo8zPeNvbKzryuDLF8CHwhSVbSgu5wgngxWjmdXDPSp6kuK+P/zQmW?=
 =?us-ascii?Q?yanK7hReuJmfD8zD7JFZw4+WroUEZDi7gpjtzoU362grPLoQYveRq0rWyGFX?=
 =?us-ascii?Q?VJ128MBkQ8HijFV+PJlte/GT/OKC0ejaSrgllo+MXtz+Ztda4zNKKvDdio0U?=
 =?us-ascii?Q?4WOzNp8HhMcktE6hcUd2FkAvJZfbZLbh3WLrNBEq87RAusdN28Zzxoc8cuKs?=
 =?us-ascii?Q?ZjSChKwmMA96VU/pt6fwOmhQm2F3hBIRoANWkY81bKO4Bg5Qu6rU8iNoiTL8?=
 =?us-ascii?Q?RWxvEBTtwgA3E1eOLFmdluZRgGhB8D4btbfpQYBPcwxRnQ0lTJN45vMbTNLa?=
 =?us-ascii?Q?lLdpe+ZGwmfxwy44g6Zj8Ky+lWMmvR+3NtODdiiHmonggSjJNs0XIMmDOiVs?=
 =?us-ascii?Q?3y4TaSKoge+0AmNDIF4CX/Gc5XzeHNmU83TlekZjDRFOgNJtC2yCnWexiisM?=
 =?us-ascii?Q?E+E2GLXWu/AI7piwH0Bj55HJxyNtZGeOvQuHBNATCQGcJSqYNdwr6umLIFNp?=
 =?us-ascii?Q?t4oMqAH77kd9lYaiQt9aNGOBHN7wqYFTNEDWTBVd3nbyfPi8o73isAuv68Yq?=
 =?us-ascii?Q?VEIhC3y05g03CdBMWy/4fddw6CD2NouYkVPneMZYNRPqo/89ahRA5q3/bHEq?=
 =?us-ascii?Q?Fscv80lAIQdzuWWISJnXgm/HlVaveoIW7iegWwCy1Qc2nab6fk6cPsgZl9Ue?=
 =?us-ascii?Q?vEc+RtU4qnwtJ77WjHgsi7SuKkpIRmQV84kh+MAaDB8+nn8qGBIGBYBn8QcZ?=
 =?us-ascii?Q?da9qiIzkel7F/IHzR/wEsnKVly1JTHPJU6tiF7+37qc7s0L59NZJAHmftJnI?=
 =?us-ascii?Q?4oYOhqtcpPw3bUMkRgJrgcUVpkKqeY7EAAFhizhQHDhqAq/2Y2cOfqsNvkuS?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b466f1d-0b29-41b6-ce96-08dbe135fe7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 15:10:22.5980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buwcWhbmL422/55EXzRyOqqWNx3E/c0nI/XCeyXEu/o7Q7uC24NYyDXt5ak4LUOGvubyl4cUN670sTyc2nEcdY59Q1fVbZ8SNjf9nHIywyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR17MB6127

On Thu, Nov 09, 2023 at 11:02:23AM +0100, Michal Hocko wrote:
> On Wed 08-11-23 19:25:14, Gregory Price wrote:
> > This patchset implements weighted interleave and adds a new cgroup
> > sysfs entry: cgroup/memory.interleave_weights (excluded from root).
> 
> Why have you chosen memory controler rather than cpuset controller?
> TBH I do not think memcg is the best fit because traditionally memcg
> accounts consumption rather than memory placement. This means that the
> memory is already allocated when it is charged for a memcg. On the other
> hand cpuset controller is the one to control the allocation placement so
> it would seem a better fit.
> -- 
> Michal Hocko
> SUSE Labs

Wasn't sure between the two, so i tossed it in memcg. Easy relocation,
and the ode should remain basically the same, so I will wait a bit
before throwing out an update.  Assuming we've found the right place
for it, i'll probably drop RFC at that point.

~Gregory

