Return-Path: <cgroups+bounces-5937-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C09F4D45
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 15:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952571651B2
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2024 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DFB1F7559;
	Tue, 17 Dec 2024 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="PeD/ivdh"
X-Original-To: cgroups@vger.kernel.org
Received: from mr85p00im-hyfv06021401.me.com (mr85p00im-hyfv06021401.me.com [17.58.23.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8E1F7540
	for <cgroups@vger.kernel.org>; Tue, 17 Dec 2024 14:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734444620; cv=none; b=iQLAwzKyZ2dykirX8Q9nwGDrMbSzMU5eZmmbl/1QlMZWauR5k7G5jM1jbrX3k7MJGKkhxH7lsi8S5a1bvyJ01nfwHRCg2V9IgHkMaJJtO8b8twaDT+AevnWmgpBogl7/+H/xA1CKbAa+fc8jsEitEteW05gip6j4gcMT9sa+3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734444620; c=relaxed/simple;
	bh=VLsnCtafXhDS7hweNxcgJtp3sZLnCmqILMkQI7ZbwxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egFh9rKl0nr0U1ggZdn0hUaHFsMKkyUc++9EYLD9mAWKAbjT0knUPpzbnMvgTaU9ZGjwsmRLO8EZ7ZJ3Tf9gdoWRVNbbYL/IiIyJeKgrIoMBPMaJTcIgobVZibP/UlUsYt22TcJX42OJP///GFDnO90ZxRNfTS1DemfLo280Ya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=PeD/ivdh; arc=none smtp.client-ip=17.58.23.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1734444617;
	bh=Z37RZ5z2SjLpNzhBno1LkTxWUoMuUAtliAQC+gyH/dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=PeD/ivdh2nr/rPjRF/bS/0P1DswFY+MV9l3xiHsxFEWPcA1gNjEJG2m2neuQEpc0P
	 x67HAvvd8HOPUqWxxBZW54iWxuGqrX6aA5atN5ACIyB5ciquSEbyKJnmfszrY53dcv
	 esAlsAHeP/vLNYjxAKfI0VpCrcd2psksBiQHpwGXrd7LzW0TE/QyOYApsF9FwZAMEH
	 t4OnVFimMLmJ++l56kIi6amuiQuP2vC6ZaPUtmISBgHxpkfi4DrGry2OONddIk5Xgs
	 x+fMBPMcJMf+R9y3IVq0gFLH4ennoTcQJqSSytTyXy3i4RqFb/sTblDbEIqLGmA3QY
	 HslSA/MyTygtQ==
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06021401.me.com (Postfix) with ESMTPSA id 2BA4330382B0;
	Tue, 17 Dec 2024 14:10:11 +0000 (UTC)
Message-ID: <bffb665a-f747-421a-833a-a4820927e86c@icloud.com>
Date: Tue, 17 Dec 2024 22:09:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] driver core: class: Fix wild pointer dereferences
 in API class_dev_iter_next()
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tejun Heo <tj@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
 Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-cxl@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241212-class_fix-v3-0-04e20c4f0971@quicinc.com>
 <20241212-class_fix-v3-1-04e20c4f0971@quicinc.com>
 <20241216153611.00007f26@huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241216153611.00007f26@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 30aZxNNOonJSucW78TiIS4UeSm7wEU_U
X-Proofpoint-ORIG-GUID: 30aZxNNOonJSucW78TiIS4UeSm7wEU_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-17_08,2024-12-17_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412170113

On 2024/12/16 23:36, Jonathan Cameron wrote:
>> Actually, all callers of these APIs have such usage pattern in kernel tree.
>> Fix by:
>> - Initialize output parameter @iter by memset() in class_dev_iter_init()
>>   and give callers prompt by pr_crit() for the error.
>> - Check if @iter is valid in class_dev_iter_next().
>>
>> Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> This looks fine in general, but over to the core device model folk for which
> element they think should be used as the sentinel and whether zeroing the
> whole thing makes sense or just the one being used as a flag, or even setting
> it to an error pointer.

thank you Jonathan for code review.

i actually ever thought about below change and finally dropped it.

-       if (!sp)
+       if (!sp) {
+               iter->sp = NULL;
                return;
+       }


For such APIs, they return void, and does not any output parameter to
feedback operation results.
it may be good practice to always reset its output parameters firstly.

