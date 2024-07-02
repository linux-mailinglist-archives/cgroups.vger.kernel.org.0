Return-Path: <cgroups+bounces-3477-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A192D91EBC5
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 02:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37C62284CFE
	for <lists+cgroups@lfdr.de>; Tue,  2 Jul 2024 00:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374833D66;
	Tue,  2 Jul 2024 00:20:09 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23E67462;
	Tue,  2 Jul 2024 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879609; cv=none; b=YiSFVSDy03Or32suuLNi26okr92lAxIkOQaQtpRvxKJMt7ro28KtyKyvSfihL/Jt9LmMkuGYxx8eHtnvQn221lxB8GNLD3FDPd0uraKRMSRnOQBgXYej1EZfjv1htbE6jwIiePJSJRlfM1Lw4g7NUk0ZyJZKtHdrJcxQG+lDR3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879609; c=relaxed/simple;
	bh=KfzK0u0XNP+Q2KDe3tM/QzyJ8mczJ9X8IXpdxz8URmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LhEZ0V5J8LfSELez2i2FDHTJTKV74zUoYs9Pdz/63sptw8mOxLD3V//XaB7FhbfU0a98MqV6pywPjgLJX8r39oE4wWhTJOpi4vA5wXo2TF88JBv3uydIpBlRMvLP84MrAauKIuAUc7gT2A28qypTmY6cYCS/XMxVzooEAL0nah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WCk3P1tGrzQjt2;
	Tue,  2 Jul 2024 08:16:17 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id CEEDD180AA6;
	Tue,  2 Jul 2024 08:20:03 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 08:20:02 +0800
Message-ID: <e5799cce-6038-c4bf-3414-4856d57f60a1@huawei.com>
Date: Tue, 2 Jul 2024 08:20:02 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next] cgroup/misc: Introduce misc.peak
Content-Language: en-US
To: Tejun Heo <tj@kernel.org>
CC: <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <corbet@lwn.net>,
	<kamalesh.babulal@oracle.com>, <haitao.huang@linux.intel.com>,
	<cgroups@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240701125259.2611466-1-xiujianfeng@huawei.com>
 <ZoLlCl1-PMr5DKIG@slm.duckdns.org>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <ZoLlCl1-PMr5DKIG@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)



On 2024/7/2 1:19, Tejun Heo wrote:
> On Mon, Jul 01, 2024 at 12:52:59PM +0000, Xiu Jianfeng wrote:
>> +		if (new_usage > READ_ONCE(res->watermark))
>> +			WRITE_ONCE(res->watermark, new_usage);
> 
> It'd be better to do cmpxchg loop on update. That doesn't make it noticeably
> more expensive and the peak tracking would actually be accurate.

Thanks for your review, will do in v2.

> 
> Thanks.
> 

