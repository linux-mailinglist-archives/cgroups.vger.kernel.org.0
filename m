Return-Path: <cgroups+bounces-10457-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905ABA0C1F
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 19:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F3F7B9C1F
	for <lists+cgroups@lfdr.de>; Thu, 25 Sep 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231730AAC6;
	Thu, 25 Sep 2025 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="l5sRIKuV"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F6B3081BB;
	Thu, 25 Sep 2025 17:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820108; cv=pass; b=V/ESndzAN4L9GaENXa918s5GWbUT2pLXzEwhhpHRpbpXYdg+sKKUN71OVaFGbja+juS4CE4xVNJr7QCITnDiDtyAjK7+kZtpj/56rUG//yBkUJiZNFFJ5MCEHXpCzUgCl44s0YdNEUdPeimKPWg+D7y3u+HVxW3zD9fe0GRwvns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820108; c=relaxed/simple;
	bh=xh7K/XJFQ6KkEtm/OLCF3JPZG7ct8pPnp/RtlikI1UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l84ZpN8TnsnMUb/VGUkJaVSoqOX//UAM4g/op/s3gp70reg8PugakgaAlz2vzLTDLY6tvhwMNY2AKYxnNMJgInNO3JuF2vgFANIRiD2DbjiCOsIa2Gz2kIuzX7Upv136Sq/VEEVsjx4a8ZcSZ7u+Sw0m9qDfA7F7wrfamCVXn0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=l5sRIKuV; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1758820071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PE5glDIsYYr7d4pKIscD4HkL/+QqyqDxWnAkaQe/NBQ5PEk0Djp/pd3gdknSw5LJ7o2I1kp+xCG4qBtGlCPxIMdBMI0PK4TBNhiG1pcgKOgwku9ffJcNb2KvWK6Aa2X6twhan+OCCTljOGpq389Al6Ckk5OkKHCmGPIMG4zskFs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758820071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xh7K/XJFQ6KkEtm/OLCF3JPZG7ct8pPnp/RtlikI1UA=; 
	b=FySJUk52uxt/fWGi5Ma/0yIkUjR5kRBlSaenMNSNfu/UTj+/vcfS+ZVU70Su6VMHRFs8nikDn/hOBEPF8Ut6vfz0M4AK7mLb/Tp7LUYA5sTfNcASQoT3qg/ySZWL8fAmWxZ+ZpvPj1Ay9IusATNIk6LjIxvl9umRhTTWQjGHask=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758820071;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=xh7K/XJFQ6KkEtm/OLCF3JPZG7ct8pPnp/RtlikI1UA=;
	b=l5sRIKuV6EnO3zuk5usTtk3gAlssOPDKZAWjYt6QRJ7KxG0XlH5PAxSXZ9LV4L8P
	K27KcsZ9I7CceXQPnIzcnspF6yfPE9rxBz/9as7VzwC+v/3j1BIDUEvB85CJyBaY2y6
	Bslw0a+cYcqbdLEgq9iiIBPlUFpxQLnO7XTs2tbo=
Received: by mx.zohomail.com with SMTPS id 1758820067677192.5730499183651;
	Thu, 25 Sep 2025 10:07:47 -0700 (PDT)
Message-ID: <01e7eccd-3529-4d12-8ad2-fd9e034a026d@yukuai.org.cn>
Date: Fri, 26 Sep 2025 01:07:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] blk-cgroup: use cgroup lock and rcu to protect
 iterating blkcg blkgs
To: Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai1@huaweicloud.com>,
 tj@kernel.org, ming.lei@redhat.com, nilay@linux.ibm.com, hch@lst.de,
 josef@toxicpanda.com, axboe@kernel.dk, akpm@linux-foundation.org,
 vgoyal@redhat.com
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, yukuai3@huawei.com,
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250925081525.700639-1-yukuai1@huaweicloud.com>
 <20250925081525.700639-2-yukuai1@huaweicloud.com>
 <bc6fe04d-3245-40dd-aa30-c3a3acb670c2@acm.org>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <bc6fe04d-3245-40dd-aa30-c3a3acb670c2@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/25 23:57, Bart Van Assche 写道:
> On 9/25/25 1:15 AM, Yu Kuai wrote:
>> It's safe to iterate blkgs with cgroup lock or rcu lock held, prevent
>> nested queue_lock under rcu lock, and prepare to convert protecting
>> blkcg with blkcg_mutex instead of queuelock.
>
> Iterating blkgs without holding q->queue_lock is safe but accessing the
> blkg members without holding that lock is not safe since q->queue_lock
> is acquired by all code that modifies blkg members. Should perhaps a new
> spinlock be introduced to serialize blkg modifications?
>
No need for a new lock, I think blkcg->lock can do that.

Thanks,
Kuai

> Thanks,
>
> Bart.
>

