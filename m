Return-Path: <cgroups+bounces-5965-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5689F6B5D
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BB67A3CFE
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2024 16:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BBB1F6692;
	Wed, 18 Dec 2024 16:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mrG3DcsH"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3941B4230;
	Wed, 18 Dec 2024 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539976; cv=none; b=r8qNU4q+b0OF1+Mhf0Xj6KB12qHbgnuz+PiCgqnWiM/tekN48+TGK/yAVXdV8RrWjF9y1OLCwN/ss24XNTpMCW/wFXG/6Ok1A2WX+J3El87k+fHyB11Bk1/N0ombmm+CmCAkH46eyNLfaZyC8gxIPoz3B9/z9shXslCLPVXZFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539976; c=relaxed/simple;
	bh=djvgsoA7QACSsXqh8hpw0OxskfzL9M8iPIwpukN03HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqjrqxlE4uh9GSLOLXz+/acEoBhL76Z7z/8v3hk/Rfv2gDR1Y3Hm0XaAbmS8Oju507sexJRx2lfuJekr0iokwH2asfXCusk8qOc/s3Irix02aAKsN2XJVK61gSV0Wr0S5NmlvUR5c7GiYQVmYTEYpAvjV69XqNr/pm0I7/ozh0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mrG3DcsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E24C4CECD;
	Wed, 18 Dec 2024 16:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734539975;
	bh=djvgsoA7QACSsXqh8hpw0OxskfzL9M8iPIwpukN03HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mrG3DcsHuOtSCH+imXmmzdej2yI8D/y5jNassmJYRhGRH3Sq5ntG0JxfVL2SqEQZK
	 IojFpakXoiDdt5LF+YUJunkNesIBguX+WQExL804aNkwz+lOX7ox1vWkDDpaY883OY
	 Z2d9H0aK3WJNZlfkB7gmrJAXab9rpmU3DyfL2jW4UjrLgruL1biflwElZznpdwprOn
	 lvUSdrnbl1Co/Ya4TdgWWlad9e6ut6jjVT0f857cJZSwEP/be1n6PbQ1DP1+iLOTEf
	 MRt6mymppAcLmW4BH6wJxztgit38pNNvZxad0R9c+EOhFQV8rriEcZVSDV6W1TL5Ew
	 rDkwdMmXnyEcg==
Date: Wed, 18 Dec 2024 06:39:34 -1000
From: Tejun Heo <tj@kernel.org>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Boris Burkov <boris@bur.io>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/8] blk-cgroup: Fix class @block_class's subsystem
 refcount leakage
Message-ID: <Z2L6xk1qD-fqUz-J@slm.duckdns.org>
References: <20241218-class_fix-v4-0-3c40f098356b@quicinc.com>
 <20241218-class_fix-v4-2-3c40f098356b@quicinc.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241218-class_fix-v4-2-3c40f098356b@quicinc.com>

On Wed, Dec 18, 2024 at 08:01:32AM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> blkcg_fill_root_iostats() iterates over @block_class's devices by
> class_dev_iter_(init|next)(), but does not end iterating with
> class_dev_iter_exit(), so causes the class's subsystem refcount leakage.
> 
> Fix by ending the iterating with class_dev_iter_exit().
> 
> Fixes: ef45fe470e1e ("blk-cgroup: show global disk stats in root cgroup io.stat")
> Reviewed-by: Michal Koutný <mkoutny@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

