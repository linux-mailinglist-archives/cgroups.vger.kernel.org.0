Return-Path: <cgroups+bounces-9838-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D72BB5045B
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 19:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94E71889C03
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 17:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B319E308F0C;
	Tue,  9 Sep 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b="ZUv0t9YL"
X-Original-To: cgroups@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8E31D384;
	Tue,  9 Sep 2025 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438385; cv=pass; b=ruMjWc7InXnJJnI0/Ukvlw+UmCrmN2JPNtbLr6zJeEMXuhiD68YS6KQkw9UpPELXgiyMp3dKXDjhmMbo3xKwzJsa0bK6lnwaK6mjKYmB8EsR0U9EibHwVtl1w0d5N5B+DT9bVzhneG0F8dB3sgHgrekxFLhTYvGztHshUlM/cQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438385; c=relaxed/simple;
	bh=6s7rAoDzB1ZmdBThLTPc5cIsdvIyxx4bJvCbPL+uRQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abwk7eWbzTquYdzKZDWVXU6q9zK8v/omN/ZWgSZGmcLacAqtYXAqxmpjkiXHbFtRze7I0a4ZcH5eZeXOd3+7NnRDaYftgo9H5F00yGXYsbHlTInRgRK/EacvvWElGqpRH4wmo6WozJmqdJ0lTOw/mmWVKidvtZq7r9Xu+Z5XUA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn; spf=pass smtp.mailfrom=yukuai.org.cn; dkim=pass (1024-bit key) header.d=yukuai.org.cn header.i=hailan@yukuai.org.cn header.b=ZUv0t9YL; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yukuai.org.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yukuai.org.cn
ARC-Seal: i=1; a=rsa-sha256; t=1757438217; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=chM6LFDKVM3oGT0Rxz/4CoW9UyDdeCRynMGcfGp8LhBDsz1Vs8AvtodB9ZfoEeCUgXF/Lwa2SCfzz4kdDnSL16O+5sPf2GtobGGpENIlJkV2g7fMUc/hrUaxZGPGDz+Pz6hg/Q6Ucu3nzk1LypUraSTD50kAd8mGMJqwNc6+x48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757438217; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6s7rAoDzB1ZmdBThLTPc5cIsdvIyxx4bJvCbPL+uRQk=; 
	b=J2L4m86XC3ks+5u9xpGvaDxi2jGRRR3JqpezhnAdThPbRBvs6QstOcr+edB8RbFGvzu7UvVa4o01a2hODY+kYNAEUo4/5lNd6Ln6YJj30tfy5U2Ftl6viJ5FIU95bj6ZAabUHdkcouWpmzfdL/kSvQWlUMUH1Ab0TQuuzhWHcjI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=yukuai.org.cn;
	spf=pass  smtp.mailfrom=hailan@yukuai.org.cn;
	dmarc=pass header.from=<hailan@yukuai.org.cn>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757438217;
	s=zmail; d=yukuai.org.cn; i=hailan@yukuai.org.cn;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6s7rAoDzB1ZmdBThLTPc5cIsdvIyxx4bJvCbPL+uRQk=;
	b=ZUv0t9YLcXJmna3pE+KQjxKvJuQNh1Yu3pNbbnJg+aO34xRGJ4tsLLQUKMuQZ4MW
	kjCppifTa6KlUG0DfjvMCg+Kh+oe2qzf2gtWoIT1UYWZsKHPtPMXVV3hzRpOeNMX3wx
	6zmYHoq4rGVXAlUyRLry1DmPknto6e4DAuBoQez0=
Received: by mx.zohomail.com with SMTPS id 1757438214195641.9733379534401;
	Tue, 9 Sep 2025 10:16:54 -0700 (PDT)
Message-ID: <5c37dd28-3719-4b4b-b91c-37fab8ce65bd@yukuai.org.cn>
Date: Wed, 10 Sep 2025 01:16:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.18/block 00/16] block: fix reordered IO in the case
 recursive split
To: Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai1@huaweicloud.com>,
 hch@infradead.org, colyli@kernel.org, hare@suse.de, dlemoal@kernel.org,
 tieren@fnnas.com, bvanassche@acm.org, tj@kernel.org, josef@toxicpanda.com,
 song@kernel.org, yukuai3@huawei.com, satyat@google.com, ebiggers@google.com,
 kmo@daterainc.com, akpm@linux-foundation.org, neil@brown.name
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250905070643.2533483-1-yukuai1@huaweicloud.com>
 <165f4091-c6c9-40f7-9b41-e89bfdd948cf@kernel.dk>
From: Yu Kuai <hailan@yukuai.org.cn>
In-Reply-To: <165f4091-c6c9-40f7-9b41-e89bfdd948cf@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi,

在 2025/9/9 23:28, Jens Axboe 写道:
> Can you spin a new version with the commit messages sorted out and with
> the missing "if defined" for BLK_CGROUP fixed up too? Looks like this is
> good to go.

That's great! I'll do this first thing in the morning.

Thanks,
Kuai


