Return-Path: <cgroups+bounces-3596-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5993992D776
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 19:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAEF1C209CE
	for <lists+cgroups@lfdr.de>; Wed, 10 Jul 2024 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A75195383;
	Wed, 10 Jul 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bj2G0UK9"
X-Original-To: cgroups@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F53194C73;
	Wed, 10 Jul 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720632590; cv=none; b=E64zoolgtpITwvATSXCeQDOMbNFiUMR1zvf/D8T/xz+fA5va4yMvRyA7gYpGwVVcmPE1yk8KBP27TPkhXySy2ssiSjrI9sYyFUtcuxcNF/L3EccTWS6mZPLbJwjcXcGqS8JD7YKBdfQA/hTvrE/Tpj1GdIoAE5GgkblBC/dtoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720632590; c=relaxed/simple;
	bh=DyGRGlgOLGpoVuyLhfvxdym1NoUTGtpMoLs9b6MzGtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y5TyEvtPV6L8e5VofRahxMRIJ/vNodEwnus3HmVY9koCJQXgRboYva0hV1DpGsBoKDr7C2SLA7jOsxOdnjtbH9BmJ640AXj/nT1bt2gq9EUBMpk+Df1xiZougtj96XEudqThhe1iTM9VX55T2wVIms9xabhrNrbGZOdL9gO2YhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bj2G0UK9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AD5ZT2022205;
	Wed, 10 Jul 2024 17:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Mw/t8xLpptDWSgL1nDLhnAFYxFHqHSyHbIPdNWVA84=; b=Bj2G0UK9pgTKCDAQ
	BNaJ4RXTG2/0ISwzrTg3RJp1bNutxQAoUhQxCUOOMOXAMGDqZQq3qwWAFU9amZp7
	HjGCuJxJV4mkvWl8VYXtjw/owyMsb6g5qVnSKsRTbMmXdmlVwTE2idg2L9b8ApZ9
	NiILelIm1mkbITxskIeiLQNBxAp8/7lJrVnlR/nKy4CwKrpCduobZlmRqyIsmFJz
	/uV+sCot9P0B5nymFxvPt5HEByCUE7iNnWFhXf1dH3C3DQKYgU/WyDm3E3i8yGJ8
	M02tjulIaDuL0JWqJBuLoFcIrtb9f0uMd83BpxYykWTUAYSTPinuvwkPMEHRzfsg
	r/eN1g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hhn5e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 17:29:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AHTafI006932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 17:29:36 GMT
Received: from [10.48.245.228] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 10:29:36 -0700
Message-ID: <2594acbf-f2d5-43fc-9967-f3660a9c2c54@quicinc.com>
Date: Wed, 10 Jul 2024 10:29:35 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_counter: Move calculating protection values to
 page_counter
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        <linux-mm@kvack.org>, <cgroups@vger.kernel.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal
 Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel
 Butt <shakeel.butt@linux.dev>,
        Muchun Song <muchun.song@linux.dev>
CC: <linux-kernel@vger.kernel.org>
References: <20240703112510.36424-1-maarten.lankhorst@linux.intel.com>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240703112510.36424-1-maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: huDRjL5LilBcFuYCdTi9px4eNmYgRlZv
X-Proofpoint-GUID: huDRjL5LilBcFuYCdTi9px4eNmYgRlZv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_12,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100122

On 7/3/2024 4:25 AM, Maarten Lankhorst wrote:
> It's a lot of math, and there is nothing memcontrol specific about it.
> This makes it easier to use inside of the drm cgroup controller.
> 
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> ---
...
> +/**
> + * page_counter_calculate_protection - check if memory consumption is in the normal range
> + * @root: the top ancestor of the sub-tree being checked
> + * @memcg: the memory cgroup to check

need to document @counter instead

mm/page_counter.c:400: warning: Function parameter or struct member 'counter' not described in 'page_counter_calculate_protection'
mm/page_counter.c:400: warning: Excess function parameter 'memcg' description in 'page_counter_calculate_protection'

> + * @recursive_protection: Whether to use memory_recursiveprot behavior.
> + *
> + * Calculates elow/emin thresholds for given page_counter.
> + *
> + * WARNING: This function is not stateless! It can only be used as part
> + *          of a top-down tree iteration, not for isolated queries.
> + */
> +void page_counter_calculate_protection(struct page_counter *root,
> +				       struct page_counter *counter,
> +				       bool recursive_protection)
> +{


