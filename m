Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677C4B1698
	for <lists+cgroups@lfdr.de>; Thu, 10 Feb 2022 20:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbiBJTxP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Feb 2022 14:53:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238964AbiBJTxO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Feb 2022 14:53:14 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58DDFE4;
        Thu, 10 Feb 2022 11:53:13 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AJACmS005968;
        Thu, 10 Feb 2022 11:53:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EiS5pojQWsnyBrJtk6e1Ld+7DUgrdd5uQOAlFUpJZI8=;
 b=ieN1noDLOmu7ZKNV12k86e6WnHbQ6O5ZHkcGKDqKmNN/obCieZjYD99Cnbgx5LN6lINm
 DfeofwBI1oQZrzHg6rb3hA9Qjf4p9MTd3Q8KyrxT9d4dH3s6wMN2ZIMPAyGKiKFtRXUI
 ZAZqSL7JXMciXWMJpuxhOwm//AjOVQR6m9o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58mhrbg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 11:53:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 11:53:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgnnOFi3QW2dqLYiZM9WrfSe93z4BH9b32XfaK4AJJ7U9CZtpDeh4VsqPAs/30g3cVUpCscquJmtUogBrsZq81PFyz/1z06++y+huwUfic9Y4Nt+jW4zLYjOsJWXY6w13gGu4tQUdwpRnOKI+NXwvdh8S1QVvjc+xKqoJl5/883PKNzwLPhLmLDnsRTDpt0GngUJ8QCCIH9NvnhfjX+eccwIkjxImmx4qv2uU/sajzxGXxEBcLhvXsZWrUk+K+QzVfc3DXXIQ72Uj32/H2XV+8x6gCUBuGR6KSAJX5Db6GDI+ZWMfV4Uu+5KhFC/9642vbaxB4JpKhaRsCFuW39ffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiS5pojQWsnyBrJtk6e1Ld+7DUgrdd5uQOAlFUpJZI8=;
 b=Z2y6EU5x1utKes3mNLoa324pvud00FDr/eyPwjUkjNeE3Bgge18M0qx1D3L+KLlyLCzFaFWF0GUBR4CXRRhPYCzt8ca+peLzzF3oHALy/vTxv4WlRUh3WrMcn0zRERKGOG0+SIcFBSgtiMS9kOQDZ9Hkhc3CscLAP1CNmsEQGWy7PhxN8n7j0wXwfIOrnW1MSSYo49IzUY/eLdl7mh2WsL0emD+1+hUwwbDZpXULB7fqRrSCl4frN55UPYDzhBJcM7uzwvwtbWX5bwrVXesxVemMJGzrbv2rFWgkjZtgiUMtJ+JvM8F6/nNlx8Z0/ehlIj3n2PfPqm0ohpgNQgEfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by MW4PR15MB5157.namprd15.prod.outlook.com (2603:10b6:303:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19; Thu, 10 Feb
 2022 19:53:01 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::8038:a2f9:13d7:704c%5]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 19:53:01 +0000
Date:   Thu, 10 Feb 2022 11:52:58 -0800
From:   Roman Gushchin <guro@fb.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        <cgroups@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] memcg: refactor mem_cgroup_oom
Message-ID: <YgVtGhvXqqVzTy7M@carbon.dhcp.thefacebook.com>
References: <20220210081437.1884008-1-shakeelb@google.com>
 <20220210081437.1884008-2-shakeelb@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220210081437.1884008-2-shakeelb@google.com>
X-ClientProxiedBy: MWHPR18CA0041.namprd18.prod.outlook.com
 (2603:10b6:320:31::27) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 880ceb42-27be-4f3a-b38a-08d9eccef1eb
X-MS-TrafficTypeDiagnostic: MW4PR15MB5157:EE_
X-Microsoft-Antispam-PRVS: <MW4PR15MB515744A5F9C1C801C181A355BE2F9@MW4PR15MB5157.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +EfBE2F1+g0LUkCXjkJScSxbkyQldHLs1C4OSUkuspo1ZzOu3UC8PI60GSXY4g6yUf7tOgb/932tZJo7B4PaL4+ouSWIwN6On3Hjmc1ErUEvOXm6gSsCM0tvyUOVuf1ppuUhWsumS56mWxx4QI3yCYsA3TCtb4VE36jEjW7DcQqztktlDH17Ff4Y0LQWn/Hacve/Tw361q16870yfWemZdul7DScTd2yrm3Oa3kyHchflbJcgNEqolWDruuQJI8rU+MuhhvLgzRfiBHT9DK/51jmuO966vEiXHhep8fugWi3j8vmKA0E3VAz0R3bweoK36YnE8tULP/4hryJdh+zK/yIJ1OqjICJraPJyRflD9DcgNO4EfJwGvz9dN5HV8oNRV/fF/YBtU77q/wfhRes+Oe1I77yaMeH7lDSKbpwoOzwyZvHHxzqrWszup0Z9QF+sQ1bqZxmbIDwpVHIX4d3iZOxlfqZbjgbpP2VgLCaxXfHyrUT2iftjvtcFnLlKrC+prYSvhErEeacQxM+lChM6fX9TGyGV3MBqDDNd7cDabehm4tT5wHbigFGg4iUSLdoiRZDb47qzykNgvslQLd0FU3zfuBLp/MZgbwKWDbecP+a3OTnXNr3kJrmPEKA1CPXj0IT7JuDmKi/hdEUvFrAfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66556008)(86362001)(83380400001)(66476007)(6916009)(316002)(66946007)(54906003)(5660300002)(2906002)(8936002)(186003)(6486002)(6666004)(9686003)(38100700002)(6512007)(52116002)(6506007)(8676002)(508600001)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uAZCUbJzfUsmV7AE7dxJ0/nVDSfzBZr4mmyU2u4KjHI/mEyFq0Ywbg4XUGx?=
 =?us-ascii?Q?6PfKw+qsFSks3h7gNPmqtAvBFft+t0ft28089OFn7Shuc5mvz1q8Z155i+0+?=
 =?us-ascii?Q?5TMvYXdCPTN4M9t2BmQfxTOCd8/kxqykJhV0kRgqKam0ZMTdBdlqa0+l5PQP?=
 =?us-ascii?Q?AS7FGLixY6qJIm1TWemwqHPrqavdblNhQuZGXmPwq6LkkvjfmvtlXqPB6bNp?=
 =?us-ascii?Q?bnr/DmneXnKOlUceljXIHJQKB6d+RSXsVKVaTQuonUt0SDnSR2LH9JrlLrR3?=
 =?us-ascii?Q?Rgn5MouQLu5EmaiiZoo1sIoCBxUaXIz/rXfh5jaqg08kw/wWwzsHO1CyDJxd?=
 =?us-ascii?Q?yJciky6iyRBq6oL9qhMfRnR9qxPpeEaMqwz7UJDS8+KofRQ3HVpuKvolSstZ?=
 =?us-ascii?Q?6bEIO66ojfdzudcMUPaLWJuPKm0xROe5IwlFYfgHK3Nc6dhTb5DzxOEGi0xk?=
 =?us-ascii?Q?d5h4YhH4Sb20HBZG0a/2nk6yG0RqijmzUqmnsiLWj+Crys9/eMkRonueKp9c?=
 =?us-ascii?Q?NqcEpxNNFONbmeJ8k2JkZwsSF7TJTT+xbIpR1xu90dlAQ5zScrsebwESHUaA?=
 =?us-ascii?Q?VFzNz1jtmhOZS/e2rYNGV/0ERG2BI5atRiYN1mLRXILfRBB09s6N5T+LZkVW?=
 =?us-ascii?Q?Gm+oLmPx54Wv9ETYTDy64pxf/vvwa7YacWixKMZIMR2XMCC6t0HTeWc//q0b?=
 =?us-ascii?Q?IJfRApfyr25hxIyYEs0wdgBNDOdo53/33OLaGZJwzbEr+0QoLZSPE21csNFV?=
 =?us-ascii?Q?RKImJptZl4hpeiWzKd/3+r8Xx6te7vy7dUTZXIUUFqiezjf3EYw4eImX7uo5?=
 =?us-ascii?Q?I24kZBBYW7BOF/v96WCWsgvLf9E+5en3gbKfIQ2xG/Esq8sCwxPvidg8mVR6?=
 =?us-ascii?Q?JN9jBtJqA1VHFWXiZCNn/h7wmX0u5e5QWT8EvzyuC9qitFxk4sGhr7acGeKE?=
 =?us-ascii?Q?x1vYOT3khtttXNjK6T8ho/Cl/i9VKUO0mwAqmoADBtOO9EgMdUs0UZtrv1oT?=
 =?us-ascii?Q?smzo7UDdOqpjn+0pnu2pb2S3UknXM+V4G+ZvdZrFMMDqp4UefjgwFZgAXaiT?=
 =?us-ascii?Q?nzToKiXn0CweToDSOvyH46mWv2m5RT/4dAILj7++rEpIJEWGeXmL9QYwthXR?=
 =?us-ascii?Q?lGLmr8oT2HkWNCtQDRLKYNRF8/rv6CBJq0Rr+cLldVPDf56UBldTkViUcUb3?=
 =?us-ascii?Q?t4tfqHDexdRVIBVs6WlhiD/nEIL94WYbBAmqtpqgND0UbbpvFnfTtpFNnua8?=
 =?us-ascii?Q?erAGXAlSVddLzSaL0Wv2qHByaIaaob8m/K5GxwBySzK2cRlmfpgFsCdhCfej?=
 =?us-ascii?Q?VjTp5wm+zFGcvVd8ag6eqAOd5n1VtpL6+Ks1eYCfTstDoarINCGvGWvAk/Hp?=
 =?us-ascii?Q?5+ridPU05jPSyi06j47C+00aYJKy6g0ChAhKrE1w7lm+j8CIwvn7b6STFnR+?=
 =?us-ascii?Q?0LcC4LE+Tf4VqCIBAnES1g0SRbWmNDzWcgSn8B+FPWd0jnECz4sPz4uccrfi?=
 =?us-ascii?Q?e5JiqKoMnIoMTlmDGVk15/vNbv6l+wqAk3ucdoRG5mP/2EH1JzvR9vFRSQ5u?=
 =?us-ascii?Q?deFD5GekX3kzf4L3tmom1OxAVQIw+prNdq8/P2NR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 880ceb42-27be-4f3a-b38a-08d9eccef1eb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 19:53:01.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGz8qu+FMVKSblwkRRMjQBQwoh1T2hjnsYH8CziQlrlsX09yDmhuaSL0j8IWoS4v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5157
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: HMncNfyNnBAwxMOrYLIIIIRT1u1nhP0R
X-Proofpoint-ORIG-GUID: HMncNfyNnBAwxMOrYLIIIIRT1u1nhP0R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_09,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100104
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 10, 2022 at 12:14:34AM -0800, Shakeel Butt wrote:
> The function mem_cgroup_oom returns enum which has four possible values
> but the caller does not care about such values and only care if the
> return value is OOM_SUCCESS or not. So, remove the enum altogether and
> make mem_cgroup_oom returns a simple bool.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Nice!

Reviewed-by: Roman Gushchin <guro@fb.com>

> ---
>  mm/memcontrol.c | 40 +++++++++++++---------------------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a0e9d9f12cf5..c40c27822802 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1795,20 +1795,12 @@ static void memcg_oom_recover(struct mem_cgroup *memcg)
>  		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
>  }
>  
> -enum oom_status {
> -	OOM_SUCCESS,
> -	OOM_FAILED,
> -	OOM_ASYNC,
> -	OOM_SKIPPED
> -};
> -

The only thing, I'd add a small comment on the return value here. E.g.
"returns true if one or more tasks have been successfully killed" or something
like this.

Thanks!

> -static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
> +static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  {
> -	enum oom_status ret;
> -	bool locked;
> +	bool locked, ret = false;
>  
>  	if (order > PAGE_ALLOC_COSTLY_ORDER)
> -		return OOM_SKIPPED;
> +		return ret;
>  
>  	memcg_memory_event(memcg, MEMCG_OOM);
>  
> @@ -1831,14 +1823,13 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  	 * victim and then we have to bail out from the charge path.
>  	 */
>  	if (memcg->oom_kill_disable) {
> -		if (!current->in_user_fault)
> -			return OOM_SKIPPED;
> -		css_get(&memcg->css);
> -		current->memcg_in_oom = memcg;
> -		current->memcg_oom_gfp_mask = mask;
> -		current->memcg_oom_order = order;
> -
> -		return OOM_ASYNC;
> +		if (current->in_user_fault) {
> +			css_get(&memcg->css);
> +			current->memcg_in_oom = memcg;
> +			current->memcg_oom_gfp_mask = mask;
> +			current->memcg_oom_order = order;
> +		}
> +		return ret;
>  	}
>  
>  	mem_cgroup_mark_under_oom(memcg);
> @@ -1849,10 +1840,7 @@ static enum oom_status mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int
>  		mem_cgroup_oom_notify(memcg);
>  
>  	mem_cgroup_unmark_under_oom(memcg);
> -	if (mem_cgroup_out_of_memory(memcg, mask, order))
> -		ret = OOM_SUCCESS;
> -	else
> -		ret = OOM_FAILED;
> +	ret = mem_cgroup_out_of_memory(memcg, mask, order);
>  
>  	if (locked)
>  		mem_cgroup_oom_unlock(memcg);
> @@ -2545,7 +2533,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	int nr_retries = MAX_RECLAIM_RETRIES;
>  	struct mem_cgroup *mem_over_limit;
>  	struct page_counter *counter;
> -	enum oom_status oom_status;
>  	unsigned long nr_reclaimed;
>  	bool passed_oom = false;
>  	bool may_swap = true;
> @@ -2648,9 +2635,8 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 * a forward progress or bypass the charge if the oom killer
>  	 * couldn't make any progress.
>  	 */
> -	oom_status = mem_cgroup_oom(mem_over_limit, gfp_mask,
> -		       get_order(nr_pages * PAGE_SIZE));
> -	if (oom_status == OOM_SUCCESS) {
> +	if (mem_cgroup_oom(mem_over_limit, gfp_mask,
> +			   get_order(nr_pages * PAGE_SIZE))) {
>  		passed_oom = true;
>  		nr_retries = MAX_RECLAIM_RETRIES;
>  		goto retry;
> -- 
> 2.35.1.265.g69c8d7142f-goog
> 
