Return-Path: <cgroups+bounces-5938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC37B9F4D67
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 15:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D45188C5D0
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 14:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CA21F5423;
	Tue, 17 Dec 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="H/eEKRV3"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-ztdg06011201.me.com (mr85p00im-ztdg06011201.me.com [17.58.23.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDAB1F4E31
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444816; cv=none; b=DvW0mg/5D+IS/EJiKdLxP4hjY3w22WC54GIA5FYeNc9PIXRhWQqEUjXRxlOC9pBRuxzciaDl1391P5UGVP/vM8Gpw7yi7cen6l3WqnVXvbsMomOAcP7oKmQTN1bVt3iSo4zFesRKe39HzuGFgKYKD7qcLKps69cpM9VHRcoxH4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444816; c=relaxed/simple;
	bh=eFBjYsTE76euirqn3tovFPfiVwIu6gmxs7bFrEiCKeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H39EQD6NcBav9cGq6tKbZNd+NidbE3xuS+A5voE/v9yHSHlVUpAcBSoC1CnpMvqffcG96g9awRp3M2FrBIzr3UC+3LH5jdYxgHz3ayCMv0jigRS4AD8tGC5JVOSluUUTyxDV45BqpZfk1KbcMWxXQiVVSgVqq7UVLPdKYMc/GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=H/eEKRV3; arc=none smtp.client-ip=17.58.23.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734444814;
	bh=O1YX+oUbanCKI4PLZgWVURex1Gcui39acgWXzxMi1fY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=H/eEKRV3YDhoeq3i4YHtYRxLqEqPm1ZsRQqlzFPeldm/bJwH3RxJnDOEv7Akwly7u
	 cKaw0c1+AwhV/movKyRCNxa1dyktu7HZNUlii431G+OG2kggtDbfJnO7Bkgat0zgtQ
	 yQH5RKCFjUPwk+HiBY4ztjAuMP/moISpj27P+n6oX9FZHKaC0vBHNhJZkdSgf8yUBF
	 K3+oZkpJ7YyV4nIknzEKTsYvKRBiWNzL8Fv7KuDZkVb6SAGl9Rfc2kN2VyzhiTnBLB
	 Hgc0/wILo9aSlqmInEdXpEvqr96mEHjV3ZehY5VnWIqTYQrBWfAf+fAIWVGsndNXMm
	 q/MZTX8JwtPfA==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-ztdg06011201.me.com (Postfix) with ESMTPSA id 529F79602F1;
	Tue, 17 Dec 2024 14:13:26 +0000 (UTC)
Message-ID: <26ca6aa2-1641-4809-8b75-5579931874bf@icloud.com>
Date: Tue, 17 Dec 2024 22:13:22 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] driver core: Move true expression out of if
 condition in API driver_find_device()
To: Fan Ni <nifan.cxl@gmail.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-4-04e20c4f0971@quicinc.com> <Z2BrFjRedjEX4OU_@fan>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <Z2BrFjRedjEX4OU_@fan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: bKkMIOrZlJBb5V63CNtOUVPQqiSXbmOk
X-Proofpoint-GUID: bKkMIOrZlJBb5V63CNtOUVPQqiSXbmOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_08,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170113

On 2024/12/17 02:01, Fan Ni wrote:
> On Thu, Dec 12, 2024 at 09:38:40PM +0800, Zijun Hu wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> For driver_find_device(), get_device() in the if condition always returns
>> true, move it to if body to make the API's logic more clearer.
>>
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> ---
> 
> This patch and the next patch can be squished into one patch.
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 

thank you Fan and Jonathan for code review.

good suggestion.
will squish the three similar changes into one in v4. (^^)(^^)

>>  drivers/base/driver.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/driver.c b/drivers/base/driver.c
>> index b4eb5b89c4ee7bc35458fc75730b16a6d1e804d3..6f033a741aa7ce6138d1c61e49e72b2a3eb85e06 100644
>> --- a/drivers/base/driver.c
>> +++ b/drivers/base/driver.c
>> @@ -160,9 +160,12 @@ struct device *driver_find_device(const struct device_driver *drv,
>>  
>>  	klist_iter_init_node(&drv->p->klist_devices, &i,
>>  			     (start ? &start->p->knode_driver : NULL));
>> -	while ((dev = next_device(&i)))
>> -		if (match(dev, data) && get_device(dev))
>> +	while ((dev = next_device(&i))) {
>> +		if (match(dev, data)) {
>> +			get_device(dev);
>>  			break;
>> +		}
>> +	}
>>  	klist_iter_exit(&i);
>>  	return dev;
>>  }
>>
>> -- 
>> 2.34.1
>>
> 


