Return-Path: <cgroups+bounces-3629-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35792EDEB
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 19:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD3E1C21516
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2024 17:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24016D9BE;
	Thu, 11 Jul 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOJbyg6e"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1EB42AB5;
	Thu, 11 Jul 2024 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720719389; cv=none; b=jb2d1z2IksQgRntAbx7wQx9rA+gblEPiRCBl9tUO5/m/gjQIA9/ytU8pu2IKPcn4F8Qadn8KtVHUctgJYbeO0ExENDsM3dO/hmdAQRQwwK8CsU4Lvj0YfkxFQCRFa15hP+BdMwwKrA2EghgAGPBqAFvJ9WxQBrM3XP+Z0RoQWLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720719389; c=relaxed/simple;
	bh=C5suPf+gv5somtxGk1++GqfXOaMwIqZhNI7zUWJb8kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jst3k7dF8m8WGh3kGWeCvlL8aqhlSZjC1QAp2FLxkY4igOzqcpFwz4HLC0amoTcrq6m35BEUhUQYW1+7GmEYwSVdAUE4rXjh1qSx0vc/2iIlz8NY1bp9lYD3Cifj7qiSW+i9jRJYFcPCgkw6apQdwE+HltbiLtHSHuiu5HrVjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOJbyg6e; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-24c9f630e51so609952fac.1;
        Thu, 11 Jul 2024 10:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720719387; x=1721324187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cmz5UsWDT60En/miMTtYfPr7c0NXygGxzB3yUKFH96Y=;
        b=fOJbyg6eZrSLXaN8DWa+KA9Y1MtJ/2mb/veVbYN+3ZA7A8OidvU7x/+nytiy+c/cdK
         CMTrmeQ3iDCWWuO0S0e0xP3mSuTziWhvEhYOaOryhE7UXhCVxaA4uvAa7sC7bXanwCib
         Yf4ydbHdEYHBED2mBNxH3J/DcueZLVqGtqXhNGh0JVwd0Ltuj7R0zKbw73szLHc2Bkv8
         L3HqCFvW5S48CMOlQSkQ71ZHfTt86VvIF5Cc/ypN/EGqxOtWZpG5ilWobadEokHe/jD1
         dZEEdxWPG5MSpNhLGabBuePTUXkTmsTQYIesiCehB0iwBhecm/nOiNYCsWmv1VRpMKqT
         P3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720719387; x=1721324187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cmz5UsWDT60En/miMTtYfPr7c0NXygGxzB3yUKFH96Y=;
        b=lssh2tvjRnqkmgScjaZe9WHWKuHdK2K8Sgn/OPmKQ5MzUhDFXVlhtJjYBVX1XDtWRS
         R3yCULL2bMchu4NsEOhmC0KEwgzko4P/Xg2uMB05ErJWGhvvuLUSZ6UHeyQbTafxNdMQ
         lkp8s76blzxIpks/KDlC+OfmswDAD4HrnPiLhBh3KaswEy6jSuwIPYpHeHgLn/2OflTk
         8nBD914Eeazt9+RY+ujsAeSFHJMQZ+nRVRiw1r3lVVzaB11zaI7I8ql8BA6AMFwRLcMd
         dQ0XzhIkfi1P/7+QdToEckQb1yUFEgfRKn6iYNRx31FKtrEoRWcxoo90sj5ylLWm0fm/
         Otng==
X-Forwarded-Encrypted: i=1; AJvYcCVn48/bucxZIU5EoeV8MAlIx2H0bSv5Mv792U/fTq8+ULd7njgsQ35O4dPhNvhkkonY/eO8OpJJHBGfRkutH4nXCd51qu9EdETSMaPZ6p+9bVIVoW0LmPGkQvSZiuIcnWkh2b15/BDc6bIGQSJLbcaAb8CbRgMeQvd+1Q==
X-Gm-Message-State: AOJu0YwMbfqERJQUufjluWbLTK7i547GOzup68jFaJJJY+wbZvvMO0l8
	zRCqzHs1DK7Q1V7acyppBx9YwQmzAJLJ12PiQA2eBRMVe+Fr+iCE
X-Google-Smtp-Source: AGHT+IHpp1+rc7dbw7jGnBpOxoWfUxuThE+dAFg9Vl4NzTdbW5fU7EB1LPuDAypcWnaXlPrpGe9hZw==
X-Received: by 2002:a05:6870:41cf:b0:25d:f285:d013 with SMTP id 586e51a60fabf-25eae7b64c7mr7280110fac.15.1720719387209;
        Thu, 11 Jul 2024 10:36:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b9a83sm5954762b3a.197.2024.07.11.10.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 10:36:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 11 Jul 2024 07:36:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: chenridong <chenridong@huawei.com>, martin.lau@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com,
	hannes@cmpxchg.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
Message-ID: <ZpAYGU7x6ioqBir5@slm.duckdns.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
 <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
 <a1b23274-4a35-4cbf-8c4c-5f770fbcc187@huawei.com>
 <Zo9XAmjpP6y0ZDGH@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo9XAmjpP6y0ZDGH@google.com>

Hello,

On Thu, Jul 11, 2024 at 03:52:34AM +0000, Roman Gushchin wrote:
> > The max_active of system_wq is WQ_DFL_ACTIVE(256). If all active works are
> > cgroup bpf release works, it will block smp_call_on_cpu work which enque
> > after cgroup bpf releases. So smp_call_on_cpu holding cpu_hotplug_lock will
> > wait for completion, but it can never get a completion because cgroup bpf
> > release works can not get cgroup_mutex and will never finish.
> > However, Placing the cgroup bpf release works on cgroup destroy will never
> > block smp_call_on_cpu work, which means loop is broken. Thus, it can solve
> > the problem.
> 
> Tejun,
> 
> do you have an opinion on this?
> 
> If there are certain limitations from the cgroup side on what can be done
> in a generic work context, it would be nice to document (e.g. don't grab
> cgroup mutex), but I still struggle to understand what exactly is wrong
> with the blamed commit.

I think the general rule here is more "don't saturate system wqs" rather
than "don't grab cgroup_mutex from system_wq". system wqs are for misc
things which shouldn't create a large number of concurrent work items. If
something is going to generate 256+ concurrent work items, it should use its
own workqueue. We don't know what's in system wqs and can't expect its users
to police specific lock usages.

Another aspect is that the current WQ_DFL_ACTIVE is an arbitrary number I
came up with close to 15 years ago. Machine size has increased by multiple
times, if not an order of magnitude since then. So, "there can't be a
reasonable situation where 256 concurrency limit isn't enough" is most
likely not true anymore and the limits need to be pushed upward.

Thanks.

-- 
tejun

