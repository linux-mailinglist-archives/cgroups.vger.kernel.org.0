Return-Path: <cgroups+bounces-3818-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BDB937B87
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 19:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 570911C21C72
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032341465B7;
	Fri, 19 Jul 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5kAhRao"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5792783A19;
	Fri, 19 Jul 2024 17:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409798; cv=none; b=CMyKIuYKTNfqF6KToASvuQ+lMkZzshfWRlhnxOxpy5KLgyqY1tFn7E4ENHN/f+/sbpHECpVloUiqdfDFLV2H3BGkpm4crpl6xTbNz4HWUt/hyDo4n5QAUuvhbCAI2TY4TRCP1a3/JHaXy+O4AavhZBPhPT1ZwMp3HjPjvizLZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409798; c=relaxed/simple;
	bh=CDXueEtpbKlPwbZHAQNZH8jv0yOjc62LghiUy9u7rSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozn80ijhK6kdMno6xo1Sw1ZZ98mKOvy8e3NyR1fd4YkURq+s1mmZw9D2GGDMTQSSth/Dps/84vHLDFXJCt2zRjwu4hR14qQQqTdqKx3NmvVZqIFKiCiiW5yUVvR79lJ+MW+k0NssieVykPDgLMUksz0KOtXURxAginy1jDrd4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5kAhRao; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d01e4f7fcso495052b3a.1;
        Fri, 19 Jul 2024 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409796; x=1722014596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C/v/AOLKlEzLuRjurmQiPQIdJ8PHb8AXqqPGCQCihM=;
        b=g5kAhRaoZTD1VMvODgrQTV7K4jN8B/sulMzqFsEuc06cpDUeX1epQmokavOseWGZqn
         U350HuyjecmoKjQFjD5q7dmM3OtIKuxt7VygFPZJ10a2an1wJKBTXy3DdmKOyg8S9wX9
         gJkt1GyzHP1oIA9Y/NS1YuEC7SKt1KP2bEfIkMpPcNfwLGQjknaF2NbUgyzsZeK+yT71
         Sq8wdX75vefZ0efRxmUKc0E1cN7JviPmDP3pqaGMtzHCmpUsrvwrw7An38kPQChrMZrk
         AcoONTK66no1ukzf/maXZcacWL+c1/a8Tl14///F3cfM79VJeXdoix4AJo/sEe6IFEzz
         KMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409796; x=1722014596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C/v/AOLKlEzLuRjurmQiPQIdJ8PHb8AXqqPGCQCihM=;
        b=jMJUtDbQiyraxJsRD/e+XEj98SQ1fubDIKwwL2wOG09ehbnHKJ7aHHhUHLveuthkkN
         VwURmKSePsgpI81UU0mcY/CVF+rTlzrABl5gbldf6qSSAosoQs8rwIA5tdrl3WQ4Xg1P
         oOzsYCwuPRl7rSQ8ybq6MZZ/OuiS7B5Ob04CEAHDp111Wlt1XKpqosk0EPk7s3lPpweK
         jcXjGHntcLd6MNONmJPdno07cddg0Okl6PgzlBhOZMA9tY7ThtXb9gGZuxKw9SEeTjPs
         cC8F2SePu7dmDmsVEXWat+fcgLIsy4qmOO5z8q6dgawfgqxk8tiTOt+bJ36/nEa7Ux3E
         5i9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXNjpR0i5r9c++3Ho6n6b4U1dJVWvwvAqyuFR1gSvAk7vbvRr73oo1RJR+FX+rUu6tSt/nbH+LJmtxRVdsjhlu4/F+Sz0QddioSsQVGTuUQxQrBbmqZnahngKYXLUUsF/07bCsCFfswBRSLRJDUAydclOCm6jYEZ6p7SHcB6hPhsNCG
X-Gm-Message-State: AOJu0YyxT20KZAUdgzKE4KCyZYC+XSDQJPzmEf7s1Y4iVpPBH17fUw7w
	pL+m4UZVq3nr/V4PNcOtfZeWLh/MSXS4tYvr34nMeKtqbGb9+sMpCtICNg==
X-Google-Smtp-Source: AGHT+IHeKLFoUCmdaLRSaS3gNSPYsk1SeETdn/0bXJCLse68Z8DPAdRc2Yb4mJ2tJUMYrmkUbn001Q==
X-Received: by 2002:a05:6a00:acb:b0:706:6408:7917 with SMTP id d2e1a72fcca58-70ce4f1cd21mr10828379b3a.26.1721409796494;
        Fri, 19 Jul 2024 10:23:16 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff5fcdd5sm1430781b3a.194.2024.07.19.10.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:23:16 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jul 2024 07:23:15 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, bvanassche@acm.org, jack@suse.cz,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 2/3] blk-ioprio: remove ioprio_blkcg_from_bio()
Message-ID: <ZpqhAxZzujCd7AV4@slm.duckdns.org>
References: <20240719071506.158075-1-yukuai1@huaweicloud.com>
 <20240719071506.158075-3-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719071506.158075-3-yukuai1@huaweicloud.com>

On Fri, Jul 19, 2024 at 03:15:05PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently, if config is enabled, then ioprio is always enabled by
> default from blkcg_init_disk(), hence there is no point to check if
> the policy is enabled from blkg in ioprio_blkcg_from_bio(). Hence remove
> it and get blkcg directly from bio.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

