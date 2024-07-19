Return-Path: <cgroups+bounces-3817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94E2937B84
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 19:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646E928110B
	for <lists+cgroups@lfdr.de>; Fri, 19 Jul 2024 17:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5994F1465B7;
	Fri, 19 Jul 2024 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LqT3KPww"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB58413A276;
	Fri, 19 Jul 2024 17:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409741; cv=none; b=c8hPV0gUXtxnaQAx9VY+gtKfj942D03Ai1XuNf2eCfSbsn883xDQW5DrL6qkfA03ep1TMLitKdoZKe/fdcQkFqpGxlb6a6IYEBBi53rPL3CocZbiN/UvIYj26w1utjKs316PnUfh71QFh2ordEWLnTGDO1aEGgl7ECWsI/xY6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409741; c=relaxed/simple;
	bh=75TilRr4eqURd4BYhRdC+4i5DBcTEC8oQUDTsnw8sMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpQBxBC1clNu8UHoaXBcdkHcRPaIbRCaR25FJWjYQObHR0j9VPRrpUCUFMikg6H3t/ZKEGXnjghGKpR9spgyjdhnMp/LyHbB6hTaYixr+T9t0byE2B6uTA59fh5z9aosJDzVn2q65repY9Kwoh5jx5I7nnAo2hzQoVXmRaWkVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LqT3KPww; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70af5fbf0d5so814548b3a.1;
        Fri, 19 Jul 2024 10:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409739; x=1722014539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egpF0SEnIXYb7MnIEEOBfEQ/CaSDz8TBIJfjNcsV5l0=;
        b=LqT3KPwwUgiWMDW3ynrPPsYhkwTMYPiF6QoLKZHYB/PnCBleI0AA16BR1c9QphdQ8U
         DfFIC0oeNjAMQrucr92tFA4mSxCZCZHZxoM7/Wz945k9K2Ot3yhePUHbQEapRlADtw2z
         O5e75ue29vuDejNMEjX8BzSVNWSRBIN2pYlgTwwr4GH/HUO7/ZdEOmGMwQ0QvyF2UdSt
         UrNmRg2iq3A0TTufOtM3S3ku7W6HhEsNpNyrjad2mBdnGdbzJAzBiKTEfIfvtx9LFqc3
         NvtKo6I7vt4PfDDo/8g4WoAjhel5vQGy2YJ3M11TgEaDMeq7JBplX5To+xVsWmqZZfKN
         crVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409739; x=1722014539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egpF0SEnIXYb7MnIEEOBfEQ/CaSDz8TBIJfjNcsV5l0=;
        b=sxWSzF5wR2iLtLKQy0V4kmu/suGqUaQzl77DMtpQBDXdSOOMML6ntWJt9mrjSk0sfy
         EQf1eZSzD3QtAoTDYwclD8B30xlDDj3Or8oW/Bpy7bubUp4r2sXTZglcELrjI+r7q3i7
         AQCibL0CdJK6fLh63NriFHtUeMn0V+4IZSmyYzqiG7pkmLU8T2OCzP2MKJ2x+6h9s94j
         2GzF5YcBOFTCBCY8VbF9uqxTu8GLE+YQPseA8Wa/FA5jp0S0N4lJCfFLs6FgdZNFOqIg
         gv5VLjCAxvkw7YoQZhIbzGp9pbpRb6XsszY2ZSzO5cxRaFRmdV89lTKJQX5q0g6UwT02
         k8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVXaQqYfTv+FQSxLXggCHs6LIaA7NkQb1qpmoOaP86Gl1dqWMUUA8gnq/5ASI4sXxRbTemqPsQjMWbrVu8nsd4GF1DGrcVDqPpzSKcqIEszO9m2EvAnD51tm8+5Aw1Ah5N1s2l2JzWvR1SGtrBh6VqnqR44bcqzX0hK9PStF50h3t6r
X-Gm-Message-State: AOJu0YxR1/vXUwFuxtWjmOOKOjzKFNAdn948U+kLh24Ab/vMECT7mrug
	GMTs5x8zGU0Ali+YmUmUdpd/A5kSBuOksNuu6s4InOFqrySMl3Lu
X-Google-Smtp-Source: AGHT+IEeNgTrAkzxHGoPidL1EgMwE+24N/lIEMV3sziwJeEce9gTRudT1TJSTYzrYKkBc2+BS6ympQ==
X-Received: by 2002:aa7:88c2:0:b0:706:5daf:efa5 with SMTP id d2e1a72fcca58-70cfd51f315mr5762976b3a.9.1721409738838;
        Fri, 19 Jul 2024 10:22:18 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff491217sm1429064b3a.30.2024.07.19.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:22:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 Jul 2024 07:22:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: hch@infradead.org, bvanassche@acm.org, jack@suse.cz,
	josef@toxicpanda.com, axboe@kernel.dk, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 1/3] blk-cgroup: check for pd_(alloc|free)_fn in
 blkcg_activate_policy()
Message-ID: <ZpqgyCEhr6s4pXDc@slm.duckdns.org>
References: <20240719071506.158075-1-yukuai1@huaweicloud.com>
 <20240719071506.158075-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719071506.158075-2-yukuai1@huaweicloud.com>

On Fri, Jul 19, 2024 at 03:15:04PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently all policies implement pd_(alloc|free)_fn, however, this is
> not necessary for ioprio that only works for blkcg, not blkg.
> 
> There are no functional changes, prepare to cleanup activating ioprio
> policy.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

