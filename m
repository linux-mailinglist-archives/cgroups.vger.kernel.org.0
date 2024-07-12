Return-Path: <cgroups+bounces-3656-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0E592FFA3
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB32B1F24537
	for <lists+cgroups@lfdr.de>; Fri, 12 Jul 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65298176AA1;
	Fri, 12 Jul 2024 17:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF2Hy2Ow"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F9B174EF8;
	Fri, 12 Jul 2024 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720804790; cv=none; b=AaVJ2PCGGwpcHqcZ+VOk7aCpGwliC1yS28MXbLsdyTVKYy+WoEHf86rhuD1zu3/pR3Z+rxq7NuU4lUBC6fJSr9Bto7HvA1mN/b5aFWNTKWCTZ3X4HNKTcP6JETV2RCdV4mjNXq95SvFC89Q1gUDNECWUGDwIWyjHfzLc62sQmRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720804790; c=relaxed/simple;
	bh=ttLF7O7mJmLLIvwZHUjJVnPnrdw+2UYWswNcOiIGEyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrZqwPV0TnrwNzHi+E/c72OeHAUSj0MLolwDIDm3w0c+t23YQ2e6H6RzvnNwSiVRypfuwUMnLQ7vX0X7P9GPFpxY79glzNL+484cK3Q1xeyNVmJBkeUGE5zQVHbWETbvylm9vZ3fQdsaGY9lZBg+GO635Ad8Z9keay2ihQ4mQlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kF2Hy2Ow; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5c47c41eb84so1235971eaf.0;
        Fri, 12 Jul 2024 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720804788; x=1721409588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/Gn627AZPe/QQaHzaSIrwpojyhT7Q6TwyJkki/9ctw=;
        b=kF2Hy2OwnMiBvaCa5G1U/zm+/6GrHYz81abQaMER3kPTgnW+Qws/Mb2WTkGmx7rnUH
         lLtcjQfijvDowbihjIzWbKWAuWo8XirWOmOFrmmgxnfcmBHe3DwMP0NQ3AwU+0/Vhlbu
         PKEV1gsmDflVN8vtD+VsAqC6YPfqbr/UcxdUv5rl+RGUur6tG1awbcQYRRAcsnMtqEO+
         6VgC8QTDhe8n7DQ1PbY9Yy4X2RPXoPcQG7yeXQBDhs2dju/Da0EykHPo6B5cnaGFyPlO
         dMcpomK92O0jCbwDo/lEy014uilTKazPNNGSxvKn8NXaNw75CCnoPqlTxkCmSt+GRqzU
         iwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720804788; x=1721409588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/Gn627AZPe/QQaHzaSIrwpojyhT7Q6TwyJkki/9ctw=;
        b=LELSW6Gon0FopOSBR8DqcemLQIpoQR38QSnstnVM0SQCCXOZAYoHuETzt5FaosGNYU
         Fko7uzJiW2b0+/6K/c0o1IZwBvGs4dob95qOAt+czI/IjHuW3Wkxtk7aUPJlhYA7C2eb
         9Ce9VDi9rvDla/C5/Bt8n1sFJXD2sGbI3zNOVhboIICS4IMZsbs1yKehYDTy1nxxrZMv
         2hEpyAdpbjhc5V30oW9qZ4isyXHg5RdchMqmrR2SCIyBHfjNA3Da6TH5QeZEyb5YBz2A
         iKhCeP0a3JDTER3ULv3dUJl1lY0rvqHDwaiYiXFKTqU3+8iUQ4CiQYxlFE59MnsI9iBw
         nlhg==
X-Forwarded-Encrypted: i=1; AJvYcCXQyAS+oZvnA3W5Ck2yJOCs40QPbQTutdEhCIddezfmhqVFSw1nuf+VkFE9IzPuo8Lms6vExLDeQoyvuAqM0GZBKQfWlowBgf/en7QU8xTUsc9594KrQH3iXuQKlCRrOvdwis8OT1czyeLVSw1DBkD8fwzvkwe8ZTjeC5kOUTm/cJAf
X-Gm-Message-State: AOJu0YygCXd+p2/qADqhg5FzGRvpFVy7LhGCZQOdqbslve9lM7T9GBg+
	39LiCba1ZIFmp8fIvTFHmbdv6U8SrN5AZAl4RbnG/Bt/nEkDsC+N
X-Google-Smtp-Source: AGHT+IFFT3R/DrZI1RkYPgoNrfL7xkIuMXcw08FwJ9gDOppfwcBuOZw9mcLBD9zJAd4yMgZcdTp7Iw==
X-Received: by 2002:a05:6358:c3a8:b0:1a5:575d:def with SMTP id e5c5f4694b2df-1aade041a1emr949599055d.2.1720804787707;
        Fri, 12 Jul 2024 10:19:47 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d60da9d16sm6121583a12.38.2024.07.12.10.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 10:19:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 12 Jul 2024 07:19:46 -1000
From: Tejun Heo <tj@kernel.org>
To: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: josef@toxicpanda.com, axboe@kernel.dk, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] blk-cgroup: move congestion_count to struct blkcg
Message-ID: <ZpFlsrNMMUMnT_Lq@slm.duckdns.org>
References: <20240712085141.3288708-1-xiujianfeng@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712085141.3288708-1-xiujianfeng@huawei.com>

Hello,

On Fri, Jul 12, 2024 at 08:51:41AM +0000, Xiu Jianfeng wrote:
> The congestion_count was introduced by commit d09d8df3a294 ("blkcg:
> add generic throttling mechanism"), but since it is closely related
> to the blkio subsys, it is not appropriate to put it in the struct
> cgroup, so move it to struct blkcg.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
> only compiling tested

blkcg is per cgroup and blkg is per cgroup-device pair, so the change isn't
just moving the field but updating what it means and how it works. The
change needs a lot more thinking, justification and testing.

Thanks.

-- 
tejun

