Return-Path: <cgroups+bounces-6006-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7EC9FBD5D
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 13:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8418854BC
	for <lists+cgroups@lfdr.de>; Tue, 24 Dec 2024 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D591B87DA;
	Tue, 24 Dec 2024 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="bYZwLVxp"
X-Original-To: cgroups@vger.kernel.org
Received: from pv50p00im-ztdg10021201.me.com (pv50p00im-ztdg10021201.me.com [17.58.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593721B3954
	for <cgroups@vger.kernel.org>; Tue, 24 Dec 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735043637; cv=none; b=V8xiUV1M++B/u1+uTEVaFge1dl/qSxRxb3A90srjyjxTqQm6h5jPQmS3+Dr6El3TGBEugt8lc5judCdB8vvjLcKgJRhcBmr5FmzQWKullTk3ey0RuZ1mOP5ZoVIcmRNe8DDJVW32BQ4hAcm2n7kRf6U0WlXwCQRoX+1ePr9zeo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735043637; c=relaxed/simple;
	bh=1EQ0yurKM95jBWQ00/8VBZ5AGN/p7LjsJnJEMi4OJfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQZztDum1ciS46k46iV60/yqREzsufYiPbiNYhycWaYFhlnhf+tljpETiueoqMr6rihUC4q7zxOySJ96mz83Q1A4JYI7LtRn0XbkLtnXV4jx1w8CabWJYmc5oVPEvHFmXvJ+ce5sqFUwWJmBH6lsafjHn72S1fChQGl+vd8VhTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=bYZwLVxp; arc=none smtp.client-ip=17.58.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735043635;
	bh=VkUkiz3yqLlBsjFYgea5cThovJocXi+1zjk/aOOMWXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:
	 x-icloud-hme;
	b=bYZwLVxpIKtIB73umt9vs3izWRVLzBuxUKHfhtuVtFqN/JVq1c8cb3B0sTa/xSH3h
	 Ge+zVp3j9JCc5DEJsidvyOajnBzM1DukkGqILtXYHAuLZKN56ZLJg/8H/Yw5oOdvmX
	 5/YdEbftIkjMAH8swSJcrv30ht+WBnhCA9lzmMrawWxWtwOrROI8a7TwdTBYw0n4fK
	 k6oTWjS/wyBlLg7/lQLNUkOqLx2nBaGB7ID6cDMaLwXzaiPxMXo5ZRHqWb+6PwP61o
	 Rd1545PmmNV9FF3oZVFVh7fNueMLIhUAXnT3lJxyaljynAFRAx+v8zYMM6H1WwI3gt
	 0KUChOymqniQw==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021201.me.com (Postfix) with ESMTPSA id D05C23118A91;
	Tue, 24 Dec 2024 12:33:48 +0000 (UTC)
Message-ID: <39bb2acb-b003-43b1-af6d-81c99f6b47eb@icloud.com>
Date: Tue, 24 Dec 2024 20:33:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] driver core: Move 2 one line device finding APIs
 to header
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
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
 <20241218-class_fix-v4-8-3c40f098356b@quicinc.com>
 <20241223201152.000012d1@huawei.com>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <20241223201152.000012d1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8CGMWjQZE3d2DTieq3tSpsGjx9dZnMRJ
X-Proofpoint-GUID: 8CGMWjQZE3d2DTieq3tSpsGjx9dZnMRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_04,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=993 bulkscore=0 spamscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240108

On 2024/12/24 04:11, Jonathan Cameron wrote:
>> From: Zijun Hu <quic_zijuhu@quicinc.com>
>>
>> The following device finding APIs only have one line code in function body
>> device_find_child_by_name()
>> device_find_any_child()
>>
>> Move them to header as static inline function.
> Why drop the docs?
> 
thank you Jonathan for code review.

will add these comments back in next revision.

i do not notice the comments include important info, and think the API
name prompts what the API does, so remove the comments. my mistake.

>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>


